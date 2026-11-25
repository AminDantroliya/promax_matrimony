import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/core/network/dio_provider.dart';
import 'package:pro_matrimony/features/auth/data/repositories/auth_repository.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/services/registration_token_holder.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/sibling_dropdown_helper.dart';
import 'package:pro_matrimony/utils/utils.dart';
import '../models/dynamic_form_models.dart';

class DynamicRegisterState {
  final DynamicFormSchema schema;
  final int currentStepIndex;
  final Map<String, dynamic> formValues;
  final Map<String, List<DropdownOptionModel>> dependentOptions;
  final bool isLoadingSchema;
  final bool isSubmitting;
  final String? error;
  final String registeredUserId;
  final String countryCode;

  const DynamicRegisterState({
    required this.schema,
    this.currentStepIndex = 0,
    this.formValues = const {},
    this.dependentOptions = const {},
    this.isLoadingSchema = false,
    this.isSubmitting = false,
    this.error,
    this.registeredUserId = '',
    this.countryCode = '+91',
  });

  DynamicRegisterState copyWith({
    DynamicFormSchema? schema,
    int? currentStepIndex,
    Map<String, dynamic>? formValues,
    Map<String, List<DropdownOptionModel>>? dependentOptions,
    bool? isLoadingSchema,
    bool? isSubmitting,
    String? error,
    String? registeredUserId,
    String? countryCode,
  }) {
    return DynamicRegisterState(
      schema: schema ?? this.schema,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      formValues: formValues ?? this.formValues,
      dependentOptions: dependentOptions ?? this.dependentOptions,
      isLoadingSchema: isLoadingSchema ?? this.isLoadingSchema,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      registeredUserId: registeredUserId ?? this.registeredUserId,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

class DynamicRegisterNotifier extends Notifier<DynamicRegisterState> {
  @override
  DynamicRegisterState build() {
    // If user closed/restarted app or has no active registration token, reset to step 0
    final hasActiveToken = RegistrationTokenHolder.hasToken;
    int savedStep = 0;
    if (hasActiveToken) {
      final savedStepStr = AppSessionService.getValue('registerStep')?.toString();
      savedStep = int.tryParse(savedStepStr ?? '0') ?? 0;
    } else {
      AppSessionService.setValue('registerStep', '0');
    }

    final initialState = DynamicRegisterState(
      schema: DynamicFormSchema.defaultSchema(),
      registeredUserId: '',
      currentStepIndex: savedStep,
    );
    Future.microtask(() => fetchSchema());
    return initialState;
  }

  Dio get dio => ref.read(dioProvider);

  Future<void> fetchSchema() async {
    state = state.copyWith(isLoadingSchema: true);
    try {
      final response = await dio.post(
        getDynamicFormFieldsApi,
        data: {'type': 'register'},
      );
      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> raw;
        if (response.data is Map<String, dynamic>) {
          final resMap = response.data as Map<String, dynamic>;
          raw = resMap['data'] is Map<String, dynamic>
              ? resMap['data'] as Map<String, dynamic>
              : resMap;
        } else {
          raw = {};
        }

        if (raw.isNotEmpty && raw['sections'] != null) {
          final schema = DynamicFormSchema.fromJson(raw);
          final clamped = state.currentStepIndex.clamp(
            0,
            schema.sections.length - 1,
          );
          state = state.copyWith(
            schema: schema,
            currentStepIndex: clamped,
            isLoadingSchema: false,
          );
          return;
        }
      }
    } catch (_) {
      // Graceful fallback to bundled default schema
    }
    final defaultSchema = DynamicFormSchema.defaultSchema();
    final clamped = state.currentStepIndex.clamp(
      0,
      defaultSchema.sections.length - 1,
    );
    state = state.copyWith(
      schema: defaultSchema,
      currentStepIndex: clamped,
      isLoadingSchema: false,
    );
  }

  void updateFieldValue(String fieldName, dynamic value) {
    final newValues = Map<String, dynamic>.from(state.formValues);
    newValues[fieldName] = value;

    // Reset married sibling if total sibling changed to a lower count
    if (fieldName == 'no_of_brother' || fieldName == 'no_of_brothers') {
      final currentMarried =
          newValues['no_of_married_brother'] ??
          newValues['no_of_married_brothers'];
      if (SiblingDropdownHelper.shouldResetMarriedSibling(
        currentMarriedValue: currentMarried,
        newTotalSiblingValue: value,
      )) {
        newValues.remove('no_of_married_brother');
        newValues.remove('no_of_married_brothers');
      }
    } else if (fieldName == 'no_of_sister' || fieldName == 'no_of_sisters') {
      final currentMarried =
          newValues['no_of_married_sister'] ??
          newValues['no_of_married_sisters'];
      if (SiblingDropdownHelper.shouldResetMarriedSibling(
        currentMarriedValue: currentMarried,
        newTotalSiblingValue: value,
      )) {
        newValues.remove('no_of_married_sister');
        newValues.remove('no_of_married_sisters');
      }
    }

    // Automatically remove values for fields that become hidden
    for (final section in state.schema.sections) {
      for (final field in section.fields) {
        if (field.showIf != null && !field.showIf!.isVisible(newValues)) {
          newValues.remove(field.name);
        }
      }
    }

    state = state.copyWith(formValues: newValues, error: null);
  }

  void setCountryCode(String code) {
    state = state.copyWith(countryCode: code);
  }

  Future<void> fetchDependentDropdown({
    required String fieldName,
    required String parentId,
    String? apiEndpoint,
    String? paramKey,
  }) async {
    if (parentId.isEmpty) return;

    try {
      final endpoint = apiEndpoint ?? getDependentDropdownDataApi;

      // Determine dependency type: e.g. caste, subcaste, state, city, income
      String type = fieldName
          .replaceAll('part_', '')
          .replaceAll('_id', '')
          .replaceAll('List', '')
          .trim();

      if (fieldName.contains('caste')) {
        type = 'caste';
      } else if (fieldName.contains('subcaste')) {
        type = 'subcaste';
      } else if (fieldName.contains('state')) {
        type = 'state';
      } else if (fieldName.contains('city')) {
        type = 'city';
      } else if (fieldName.contains('income')) {
        type = 'income';
      }

      final Map<String, dynamic> requestData = {
        'type': type,
        'parent_id': parentId,
      };

      if (paramKey != null &&
          paramKey.isNotEmpty &&
          paramKey != 'parent_id' &&
          paramKey != 'type') {
        requestData[paramKey] = parentId;
      }

      final response = await dio.post(endpoint, data: requestData);
      if (response.statusCode == 200 && response.data != null) {
        final List<DropdownOptionModel> options = [];
        dynamic rawList = response.data;
        if (rawList is Map && rawList['data'] != null) {
          rawList = rawList['data'];
        }

        if (rawList is List) {
          for (var item in rawList) {
            if (item is Map) {
              options.add(
                DropdownOptionModel.fromJson(Map<String, dynamic>.from(item)),
              );
            }
          }
        }

        final updatedOptions = Map<String, List<DropdownOptionModel>>.from(
          state.dependentOptions,
        );
        updatedOptions[fieldName] = options;
        state = state.copyWith(dependentOptions: updatedOptions);
      }
    } catch (_) {}
  }

  Future<String?> generateAboutMeWithAI(BuildContext context) async {
    if (!RegistrationTokenHolder.hasToken) {
      showToast('Please complete step 1 first');
      return null;
    }

    try {
      final result = await ref.read(authRepositoryProvider).generateAboutMe({});
      if (result['status'] == 'success' && result['data'] != null) {
        final bio = result['data']['about_me']?.toString() ?? '';
        if (bio.isNotEmpty) {
          updateFieldValue('about_me_description', bio);
          showToast('AI Bio generated successfully! ✨');
          return bio;
        }
      }
    } catch (e) {
      showToast('Error generating AI bio: $e');
    }
    return null;
  }

  void previousStep() {
    if (state.currentStepIndex >= 2) {
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex - 1,
        error: null,
      );
    }
  }

  void jumpToStep(int stepIndex) {
    if (stepIndex >= 0) {
      final target = state.schema.sections.isNotEmpty
          ? stepIndex.clamp(0, state.schema.sections.length - 1)
          : stepIndex;
      state = state.copyWith(currentStepIndex: target, error: null);
    }
  }

  void resetRegistration() {
    RegistrationTokenHolder.clear();
    AppSessionService.setValue('registerStep', '0');
    AppSessionService.removeValue(SessionDetail.kUserId);
    state = DynamicRegisterState(
      schema: state.schema,
      registeredUserId: '',
      currentStepIndex: 0,
      formValues: const {},
      dependentOptions: const {},
      isLoadingSchema: false,
      isSubmitting: false,
      error: null,
      countryCode: state.countryCode,
    );
  }

  Future<bool> submitCurrentStep(BuildContext context) async {
    if (state.schema.sections.isEmpty) return false;

    final currentSection = state.schema.sections[state.currentStepIndex];
    state = state.copyWith(isSubmitting: true, error: null);

    try {
      final payload = Map<String, dynamic>.from(currentSection.extraParams);
      // Removed member_id parameter: stepper APIs are authenticated via Authorization Bearer token header

      // Collect field values for this section
      for (final field in currentSection.fields) {
        // Skip hidden fields (failed show_if)
        if (field.showIf != null &&
            !field.showIf!.isVisible(state.formValues)) {
          continue;
        }

        dynamic val = state.formValues[field.name] ?? field.defaultValue;

        // Auto-resolve default RangeValues for range_slider fields if not yet touched
        if (val == null && field.type == 'range_slider') {
          final min =
              field.minVal ?? (field.name.contains('height') ? 48.0 : 18.0);
          final max =
              field.maxVal ?? (field.name.contains('height') ? 84.0 : 60.0);
          if (field.defaultRange != null && field.defaultRange!.length >= 2) {
            val = RangeValues(
              field.defaultRange![0].clamp(min, max),
              field.defaultRange![1].clamp(min, max),
            );
          } else {
            val = RangeValues(min, max);
          }
        }

        if (val != null) {
          if (val is File) {
            final fileName = val.path.split(RegExp(r'[/\\]')).last;
            final mFile = await MultipartFile.fromFile(
              val.path,
              filename: fileName,
            );
            payload[field.name] = mFile;
            if (field.name == 'selfie_image') {
              payload['selfie_photo'] = await MultipartFile.fromFile(
                val.path,
                filename: fileName,
              );
            }
          } else if (val is List<DropdownOptionModel>) {
            final ids = val
                .map((e) => e.id.toString())
                .where((id) => id.isNotEmpty && id != 'DOES_NOT_MATTER')
                .join(',');
            payload[field.name] = ids;
          } else if (val is DropdownOptionModel) {
            payload[field.name] = val.id == 'DOES_NOT_MATTER'
                ? ''
                : (val.id?.toString() ?? '');
          } else if (val is RangeValues) {
            if (field.name.contains('age') || field.name == 'part_age_range') {
              payload['part_frm_age'] = val.start.round().toString();
              payload['part_to_age'] = val.end.round().toString();
            } else if (field.name.contains('height') ||
                field.name == 'part_height_range') {
              payload['part_height'] = val.start.round().toString();
              payload['part_height_to'] = val.end.round().toString();
            } else {
              payload['${field.name}_from'] = val.start.round().toString();
              payload['${field.name}_to'] = val.end.round().toString();
            }
          } else {
            var strVal = val.toString().trim();
            if (strVal == 'DOES_NOT_MATTER') {
              strVal = '';
            }
            if (field.type == 'phone_number' &&
                field.name != 'mobile' &&
                strVal.isNotEmpty &&
                !strVal.startsWith('+')) {
              strVal = '${state.countryCode}-$strVal';
            }
            payload[field.name] = strVal;
          }
        }
      }

      // Ensure photo_visibility is always present on photo steps (default: '2')
      if (currentSection.stepKey == 'photos' ||
          currentSection.endpoint.contains('photo')) {
        payload['photo_visibility'] ??=
            (state.formValues['photo_visibility'] ?? '2').toString();
      }

      // Ensure Partner Preferences range fields are always present
      if (currentSection.stepKey == 'partner_preferences' ||
          currentSection.title.toLowerCase().contains('partner')) {
        payload['part_frm_age'] ??= '18';
        payload['part_to_age'] ??= '60';
        payload['part_height'] ??= '48';
        payload['part_height_to'] ??= '84';
      }

      // Step 1: Initial Account Registration
      if (currentSection.stepNumber == 1 ||
          currentSection.stepKey == 'basic_credentials') {
        payload['country_code'] = state.countryCode;
        final otpMethod =
            AppSessionService.getValue('otp_login_method') ?? 'firebase';
        payload['otp_login_method'] = otpMethod;

        final result = await ref.read(authRepositoryProvider).register(payload);
        state = state.copyWith(isSubmitting: false);

        if (result['status'] == 'success') {
          // Store token in temporary in-memory holder (RAM only, NOT in session)
          if (result['data'] != null && result['data']['token'] != null) {
            final regToken = result['data']['token'].toString();
            RegistrationTokenHolder.setToken(regToken);
          }

          if (context.mounted) {
            _advanceStep(context);
          }
          return true;
        } else {
          final err = result['message']?.toString() ?? 'Registration failed';
          state = state.copyWith(error: err);
          showToast(err);
          return false;
        }
      }

      // Multipart Upload Steps (Photos, ID Proof)
      if (currentSection.isMultipart) {
        final formData = FormData.fromMap(payload);
        final response = await dio.post(
          currentSection.endpoint,
          data: formData,
        );
        state = state.copyWith(isSubmitting: false);

        final status = response.data?['status']?.toString().toLowerCase();
        final isSuccess =
            (status == 'success' || status == '1' || status == 'true') &&
            response.statusCode == 200;

        if (isSuccess) {
          if (context.mounted) {
            _advanceStep(context);
          }
          return true;
        } else {
          final err = response.data?['message']?.toString() ?? 'Upload failed';
          state = state.copyWith(error: err);
          showToast(err);
          return false;
        }
      }

      // Standard Registration Steps
      final result = await ref
          .read(authRepositoryProvider)
          .registerNextStep(payload);
      state = state.copyWith(isSubmitting: false);

      final status = result['status']?.toString();
      if (status == 'success' || status == '1') {
        if (context.mounted) {
          _advanceStep(context);
        }
        return true;
      } else {
        final err = result['message']?.toString() ?? 'Step failed to save';
        state = state.copyWith(error: err);
        showToast(err);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      showToast('Error: $e');
      return false;
    }
  }

  void _advanceStep(BuildContext context) {
    final nextStep = state.currentStepIndex + 1;
    AppSessionService.setValue('registerStep', nextStep.toString());
    if (nextStep < state.schema.sections.length) {
      state = state.copyWith(currentStepIndex: nextStep, error: null);
    } else {
      // Completed all steps! Clear temporary registration token
      RegistrationTokenHolder.clear();
      AppSessionService.setValue('registerStep', '9');
      AppSessionService.setValue('registerStepStatus', 'Disable');
      context.go('/registration-success');
    }
  }
}

final dynamicRegisterProvider =
    NotifierProvider<DynamicRegisterNotifier, DynamicRegisterState>(
      DynamicRegisterNotifier.new,
    );
