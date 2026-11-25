import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/core/network/dio_provider.dart';
import 'package:pro_matrimony/features/auth/screens/register2/models/dynamic_form_models.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/sibling_dropdown_helper.dart';
import 'package:pro_matrimony/utils/utils.dart';
import '../models/dynamic_edit_section_config.dart';

class DynamicEditProfileState {
  final bool isLoadingSchema;
  final bool isSubmitting;
  final FormSection? currentSection;
  final List<FormFieldModel> fields;
  final Map<String, dynamic> formValues;
  final Map<String, List<DropdownOptionModel>> dependentOptions;
  final String? errorMessage;
  final String? successMessage;
  final bool autoValidate;

  const DynamicEditProfileState({
    this.isLoadingSchema = false,
    this.isSubmitting = false,
    this.currentSection,
    this.fields = const [],
    this.formValues = const {},
    this.dependentOptions = const {},
    this.errorMessage,
    this.successMessage,
    this.autoValidate = false,
  });

  DynamicEditProfileState copyWith({
    bool? isLoadingSchema,
    bool? isSubmitting,
    FormSection? currentSection,
    List<FormFieldModel>? fields,
    Map<String, dynamic>? formValues,
    Map<String, List<DropdownOptionModel>>? dependentOptions,
    String? errorMessage,
    String? successMessage,
    bool? autoValidate,
  }) {
    return DynamicEditProfileState(
      isLoadingSchema: isLoadingSchema ?? this.isLoadingSchema,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      currentSection: currentSection ?? this.currentSection,
      fields: fields ?? this.fields,
      formValues: formValues ?? this.formValues,
      dependentOptions: dependentOptions ?? this.dependentOptions,
      errorMessage: errorMessage,
      successMessage: successMessage,
      autoValidate: autoValidate ?? this.autoValidate,
    );
  }
}

class DynamicEditProfileNotifier
    extends Notifier<DynamicEditProfileState> {
  @override
  DynamicEditProfileState build() {
    return const DynamicEditProfileState(isLoadingSchema: true);
  }

  Dio get _dio => ref.read(dioProvider);

  Future<void> initialize({
    required DynamicEditSectionType sectionType,
    ProfileData? profileData,
  }) async {
    state = const DynamicEditProfileState(isLoadingSchema: true);

    await _fetchRemoteSchema(sectionType: sectionType, profileData: profileData);
  }

  Future<void> _fetchRemoteSchema({
    required DynamicEditSectionType sectionType,
    ProfileData? profileData,
  }) async {
    try {
      final response = await _dio.post(
        getDynamicFormFieldsApi,
        data: {'type': 'edit_profile'},
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

          // Find the matching section directly from the backend API response
          FormSection? matchedSection;
          for (final sec in schema.sections) {
            final key = sec.stepKey.toLowerCase();
            final formType =
                (sec.extraParams['form_type'] ?? '').toString().toLowerCase();
            final title = sec.title.toLowerCase();

            if (key == sectionType.formType ||
                formType == sectionType.formType ||
                key == sectionType.stepKey ||
                key.contains(sectionType.searchToken) ||
                title.contains(sectionType.searchToken)) {
              matchedSection = sec;
              break;
            }
          }

          if (matchedSection != null && matchedSection.fields.isNotEmpty) {
            final formValues = <String, dynamic>{};

            // Use the fields and pre-filled default_values directly from backend API
            for (final field in matchedSection.fields) {
              final initial = sectionType.parseInitialValue(field, profileData);
              if (initial != null && initial.toString().isNotEmpty) {
                formValues[field.name] = initial;
              }
            }

            // Validate initial married sibling values against total siblings
            final broTotal = formValues['no_of_brother'] ?? formValues['no_of_brothers'];
            final broMarried = formValues['no_of_married_brother'] ?? formValues['no_of_married_brothers'];
            if (SiblingDropdownHelper.shouldResetMarriedSibling(
              currentMarriedValue: broMarried,
              newTotalSiblingValue: broTotal,
            )) {
              formValues.remove('no_of_married_brother');
              formValues.remove('no_of_married_brothers');
            }

            final sisTotal = formValues['no_of_sister'] ?? formValues['no_of_sisters'];
            final sisMarried = formValues['no_of_married_sister'] ?? formValues['no_of_married_sisters'];
            if (SiblingDropdownHelper.shouldResetMarriedSibling(
              currentMarriedValue: sisMarried,
              newTotalSiblingValue: sisTotal,
            )) {
              formValues.remove('no_of_married_sister');
              formValues.remove('no_of_married_sisters');
            }

            state = state.copyWith(
              isLoadingSchema: false,
              currentSection: matchedSection,
              fields: matchedSection.fields,
              formValues: formValues,
            );

            _triggerInitialDependentFetches(formValues);
            return;
          }
        }
      }

      state = state.copyWith(
        isLoadingSchema: false,
        errorMessage: 'failed_to_load_form'.tr,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingSchema: false,
        errorMessage: e.toString(),
      );
    }
  }

  void _triggerInitialDependentFetches(Map<String, dynamic> values) {
    // Religion -> Caste
    final relVal = values['religion']?.toString() ?? '';
    if (relVal.isNotEmpty) {
      fetchDependentDropdown(fieldName: 'caste', parentId: relVal);
    }

    // Country -> State -> City
    final countryVal = values['country_id']?.toString() ?? '';
    if (countryVal.isNotEmpty) {
      fetchDependentDropdown(fieldName: 'state_id', parentId: countryVal);
    }
    final stateVal = values['state_id']?.toString() ?? '';
    if (stateVal.isNotEmpty) {
      fetchDependentDropdown(fieldName: 'city', parentId: stateVal);
    }

    // Partner Religion -> Caste
    final partRelVal = values['part_religion']?.toString() ?? '';
    if (partRelVal.isNotEmpty && partRelVal != 'DOES_NOT_MATTER') {
      final firstId = partRelVal.split(',').first.trim();
      if (firstId.isNotEmpty && firstId != 'DOES_NOT_MATTER') {
        fetchDependentDropdown(fieldName: 'part_caste', parentId: firstId);
      }
    }

    // Partner Country -> State
    final partCountryVal = values['part_country']?.toString() ?? '';
    if (partCountryVal.isNotEmpty && partCountryVal != 'DOES_NOT_MATTER') {
      final firstId = partCountryVal.split(',').first.trim();
      if (firstId.isNotEmpty && firstId != 'DOES_NOT_MATTER') {
        fetchDependentDropdown(fieldName: 'part_state', parentId: firstId);
      }
    }
  }

  void updateFieldValue(String fieldName, dynamic value) {
    final newValues = Map<String, dynamic>.from(state.formValues);
    newValues[fieldName] = value;

    // Handle cascading clears and fetches for dependent dropdowns
    if (fieldName == 'religion') {
      newValues.remove('caste');
      final valStr = _extractIdString(value);
      if (valStr.isNotEmpty) {
        fetchDependentDropdown(fieldName: 'caste', parentId: valStr);
      }
    } else if (fieldName == 'country_id') {
      newValues.remove('state_id');
      newValues.remove('city');
      final valStr = _extractIdString(value);
      if (valStr.isNotEmpty) {
        fetchDependentDropdown(fieldName: 'state_id', parentId: valStr);
      }
    } else if (fieldName == 'state_id') {
      newValues.remove('city');
      final valStr = _extractIdString(value);
      if (valStr.isNotEmpty) {
        fetchDependentDropdown(fieldName: 'city', parentId: valStr);
      }
    } else if (fieldName == 'part_religion') {
      newValues.remove('part_caste');
      final valStr = _extractIdString(value);
      if (valStr.isNotEmpty && valStr != 'DOES_NOT_MATTER') {
        final firstId = valStr.split(',').first.trim();
        fetchDependentDropdown(fieldName: 'part_caste', parentId: firstId);
      }
    } else if (fieldName == 'part_country') {
      newValues.remove('part_state');
      final valStr = _extractIdString(value);
      if (valStr.isNotEmpty && valStr != 'DOES_NOT_MATTER') {
        final firstId = valStr.split(',').first.trim();
        fetchDependentDropdown(fieldName: 'part_state', parentId: firstId);
      }
    }

    // Reset married sibling if total sibling changed to a lower count
    if (fieldName == 'no_of_brother' || fieldName == 'no_of_brothers') {
      final currentMarried =
          newValues['no_of_married_brother'] ?? newValues['no_of_married_brothers'];
      if (SiblingDropdownHelper.shouldResetMarriedSibling(
        currentMarriedValue: currentMarried,
        newTotalSiblingValue: value,
      )) {
        newValues.remove('no_of_married_brother');
        newValues.remove('no_of_married_brothers');
      }
    } else if (fieldName == 'no_of_sister' || fieldName == 'no_of_sisters') {
      final currentMarried =
          newValues['no_of_married_sister'] ?? newValues['no_of_married_sisters'];
      if (SiblingDropdownHelper.shouldResetMarriedSibling(
        currentMarriedValue: currentMarried,
        newTotalSiblingValue: value,
      )) {
        newValues.remove('no_of_married_sister');
        newValues.remove('no_of_married_sisters');
      }
    }

    // Automatically remove values for fields hidden by show_if
    for (final field in state.fields) {
      if (field.showIf != null && !field.showIf!.isVisible(newValues)) {
        newValues.remove(field.name);
      }
    }

    state = state.copyWith(formValues: newValues, errorMessage: null);
  }

  Future<void> fetchDependentDropdown({
    required String fieldName,
    required String parentId,
  }) async {
    if (parentId.isEmpty) return;

    try {
      String type = fieldName
          .replaceAll('part_', '')
          .replaceAll('_id', '')
          .replaceAll('List', '')
          .trim();

      if (fieldName.contains('caste')) {
        type = 'caste';
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

      final response = await _dio.post(getDependentDropdownDataApi, data: requestData);
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> rawList;
        if (response.data is Map<String, dynamic>) {
          final resMap = response.data as Map<String, dynamic>;
          rawList = resMap['data'] is List ? resMap['data'] as List : [];
        } else if (response.data is List) {
          rawList = response.data as List;
        } else {
          rawList = [];
        }

        final options = rawList
            .map((item) => DropdownOptionModel.fromJson(item as Map<String, dynamic>))
            .toList();

        final newDependent = Map<String, List<DropdownOptionModel>>.from(state.dependentOptions);
        newDependent[fieldName] = options;
        state = state.copyWith(dependentOptions: newDependent);
      }
    } catch (_) {}
  }

  String _extractIdString(dynamic val) {
    if (val == null) return '';
    if (val is List<DropdownOptionModel>) {
      return val
          .map((e) => e.id ?? e.val ?? '')
          .where((id) => id.toString().isNotEmpty && id != 'DOES_NOT_MATTER')
          .join(',');
    }
    if (val is DropdownOptionModel) {
      if (val.id == 'DOES_NOT_MATTER' || val.val == 'Does Not Matter') return '';
      return (val.id ?? val.val ?? '').toString();
    }
    if (val is List) {
      return val
          .map((e) {
            if (e is DropdownOptionModel) return e.id ?? e.val ?? '';
            return e.toString();
          })
          .where((s) => s.toString().isNotEmpty && s != 'DOES_NOT_MATTER')
          .join(',');
    }
    final str = val.toString().trim();
    if (str == 'DOES_NOT_MATTER') return '';
    return str;
  }

  Future<void> submit({
    required BuildContext context,
    required DynamicEditSectionType sectionType,
    required GlobalKey<FormState> formKey,
  }) async {
    state = state.copyWith(autoValidate: true);

    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      return;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final endpoint = state.currentSection?.endpoint.isNotEmpty == true
          ? state.currentSection!.endpoint
          : editMyProfileApi;

      final params = <String, dynamic>{
        'form_type': sectionType.formType,
      };

      if (state.currentSection != null &&
          state.currentSection!.extraParams.isNotEmpty) {
        params.addAll(state.currentSection!.extraParams);
      }

      final values = state.formValues;

      // Add all dynamic field values from the form
      for (final field in state.fields) {
        if (field.showIf != null && !field.showIf!.isVisible(values)) {
          continue;
        }

        final val = values[field.name];

        if (field.type == 'range_slider') {
          if (val is RangeValues) {
            if (field.name.contains('age')) {
              params['part_frm_age'] = val.start.round().toString();
              params['part_to_age'] = val.end.round().toString();
            } else if (field.name.contains('height')) {
              params['part_height'] = val.start.round().toString();
              params['part_height_to'] = val.end.round().toString();
            } else {
              params['${field.name}_from'] = val.start.round().toString();
              params['${field.name}_to'] = val.end.round().toString();
            }
          }
        } else if (field.type == 'time_picker') {
          final rawTime = val?.toString() ?? '';
          if (rawTime.isNotEmpty &&
              !rawTime.contains(':00') &&
              rawTime.split(':').length == 2) {
            params[field.name] = '$rawTime:00';
          } else {
            params[field.name] = rawTime;
          }
        } else if (field.name == 'total_children') {
          final maritalStatus = _extractIdString(values['marital_status']);
          final isUnmarried =
              maritalStatus == '1' || maritalStatus.toLowerCase() == 'unmarried';
          params['total_children'] =
              isUnmarried ? '1' : _extractIdString(val);
        } else if (field.name == 'status_children') {
          final maritalStatus = _extractIdString(values['marital_status']);
          final isUnmarried =
              maritalStatus == '1' || maritalStatus.toLowerCase() == 'unmarried';
          params['status_children'] =
              isUnmarried ? '' : _extractIdString(val);
        } else {
          params[field.name] = _extractIdString(val);
        }
      }

      await _dio.post(endpoint, data: params);
      await ref.read(myProfileProvider.notifier).refresh();

      state = state.copyWith(isSubmitting: false);

      if (context.mounted) {
        showToast(sectionType.successKey.tr);
        Navigator.pop(context);
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
      if (context.mounted) {
        showToast(e.toString());
      }
    }
  }
}

final dynamicEditProfileProvider = NotifierProvider<
    DynamicEditProfileNotifier, DynamicEditProfileState>(
  DynamicEditProfileNotifier.new,
);
