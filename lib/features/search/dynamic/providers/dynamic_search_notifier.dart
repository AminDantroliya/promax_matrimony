import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/core/network/dio_provider.dart';
import 'package:pro_matrimony/features/auth/screens/register2/models/dynamic_form_models.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/features/matches/providers/ai_match_notifier.dart';
import 'package:pro_matrimony/features/matches/screens/ai_match_result_screen.dart';
import 'package:pro_matrimony/features/search/providers/search_notifier.dart';
import 'package:pro_matrimony/features/search/screens/search_result_screen.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';

class DynamicSearchState {
  final bool isLoadingSchema;
  final DynamicFormSchema schema;
  final Map<String, dynamic> formValues;
  final Map<String, List<DropdownOptionModel>> dependentOptions;
  final String? error;

  const DynamicSearchState({
    this.isLoadingSchema = false,
    this.schema = const DynamicFormSchema(totalSteps: 1, sections: []),
    this.formValues = const {},
    this.dependentOptions = const {},
    this.error,
  });

  DynamicSearchState copyWith({
    bool? isLoadingSchema,
    DynamicFormSchema? schema,
    Map<String, dynamic>? formValues,
    Map<String, List<DropdownOptionModel>>? dependentOptions,
    String? error,
  }) {
    return DynamicSearchState(
      isLoadingSchema: isLoadingSchema ?? this.isLoadingSchema,
      schema: schema ?? this.schema,
      formValues: formValues ?? this.formValues,
      dependentOptions: dependentOptions ?? this.dependentOptions,
      error: error,
    );
  }
}

abstract class DynamicSearchBaseNotifier extends Notifier<DynamicSearchState> {
  String get searchType;

  @override
  DynamicSearchState build() {
    Future.microtask(() => fetchSchema());
    return const DynamicSearchState(isLoadingSchema: true);
  }

  Dio get dio => ref.read(dioProvider);

  Future<void> fetchSchema() async {
    state = state.copyWith(isLoadingSchema: true, error: null);
    try {
      final response = await dio.post(
        getDynamicFormFieldsApi,
        data: {'type': searchType},
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
          final initialValues = <String, dynamic>{};

          for (final section in schema.sections) {
            for (final field in section.fields) {
              if (field.type == 'range_slider') {
                final min = field.minVal ?? (field.name.contains('height') ? 48.0 : 18.0);
                final max = (field.maxVal != null && field.maxVal! > min)
                    ? field.maxVal!
                    : (field.name.contains('height') ? 84.0 : 60.0);

                if (field.defaultRange != null && field.defaultRange!.length >= 2) {
                  final s = field.defaultRange![0].clamp(min, max);
                  final e = field.defaultRange![1].clamp(min, max);
                  initialValues[field.name] = RangeValues(s <= e ? s : min, s <= e ? e : max);
                } else {
                  initialValues[field.name] = RangeValues(min, max);
                }
              } else if (field.name.contains('compatibility') ||
                  field.name.contains('match_percentage') ||
                  field.type == 'single_slider') {
                initialValues[field.name] =
                    int.tryParse(field.defaultValue?.toString() ?? '') ?? 60;
              } else if (field.defaultValue != null) {
                initialValues[field.name] = field.defaultValue;
              }
            }
          }

          if (searchType == 'ai_match_search') {
            initialValues['min_match_percentage'] ??= 60;
          }

          state = state.copyWith(
            schema: schema,
            formValues: initialValues,
            isLoadingSchema: false,
          );
          return;
        }
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingSchema: false);
    }
  }

  void updateFieldValue(String fieldName, dynamic value) {
    final newValues = Map<String, dynamic>.from(state.formValues);
    newValues[fieldName] = value;

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

  void resetFilters() {
    final initialValues = <String, dynamic>{};
    for (final section in state.schema.sections) {
      for (final field in section.fields) {
        if (field.type == 'range_slider') {
          final min = field.minVal ?? (field.name.contains('height') ? 48.0 : 18.0);
          final max = field.maxVal ?? (field.name.contains('height') ? 84.0 : 60.0);
          if (field.defaultRange != null && field.defaultRange!.length >= 2) {
            initialValues[field.name] = RangeValues(
              field.defaultRange![0].clamp(min, max),
              field.defaultRange![1].clamp(min, max),
            );
          } else {
            initialValues[field.name] = RangeValues(min, max);
          }
        } else if (field.name.contains('compatibility') ||
            field.name.contains('match_percentage')) {
          initialValues[field.name] = int.tryParse(field.defaultValue?.toString() ?? '') ?? 60;
        }
      }
    }
    if (searchType == 'ai_match_search') {
      initialValues['min_match_percentage'] = 60;
    }
    state = state.copyWith(formValues: initialValues, error: null);
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

      if (paramKey != null && paramKey.isNotEmpty) {
        requestData[paramKey] = parentId;
      }

      final response = await dio.post(endpoint, data: requestData);
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

  String _extractValueString(dynamic val) {
    if (val == null) return '';
    if (val is List<DropdownOptionModel>) {
      return val.map((e) => e.id ?? e.val ?? '').where((id) => id.toString().isNotEmpty).join(',');
    }
    if (val is DropdownOptionModel) {
      return (val.id ?? val.val ?? '').toString();
    }
    if (val is List) {
      return val.map((e) {
        if (e is DropdownOptionModel) return e.id ?? e.val ?? '';
        return e.toString();
      }).where((s) => s.toString().isNotEmpty).join(',');
    }
    return val.toString();
  }

  Map<String, String> compileSearchParameters() {
    final params = <String, String>{};

    for (final section in state.schema.sections) {
      for (final field in section.fields) {
        if (field.showIf != null && !field.showIf!.isVisible(state.formValues)) {
          continue;
        }

        dynamic val = state.formValues[field.name] ?? field.defaultValue;

        if (val == null && field.type == 'range_slider') {
          final min = field.minVal ?? (field.name.contains('height') ? 48.0 : 18.0);
          final max = field.maxVal ?? (field.name.contains('height') ? 84.0 : 60.0);
          if (field.defaultRange != null && field.defaultRange!.length >= 2) {
            val = RangeValues(
              field.defaultRange![0].clamp(min, max),
              field.defaultRange![1].clamp(min, max),
            );
          } else {
            val = RangeValues(min, max);
          }
        }

        if (val is RangeValues) {
          if (field.name.contains('age')) {
            params['from_age'] = val.start.round().toString();
            params['to_age'] = val.end.round().toString();
            params['part_frm_age'] = val.start.round().toString();
            params['part_to_age'] = val.end.round().toString();
          } else if (field.name.contains('height')) {
            params['from_height'] = val.start.round().toString();
            params['to_height'] = val.end.round().toString();
            params['part_height'] = val.start.round().toString();
            params['part_height_to'] = val.end.round().toString();
          } else {
            params['${field.name}_from'] = val.start.round().toString();
            params['${field.name}_to'] = val.end.round().toString();
          }
        } else if (val is bool) {
          if (val) {
            params[field.name] = 'Yes';
            if (field.name == 'photo_search' || field.name == 'is_with_photo' || field.name == 'with_photo') {
              params['photo_search'] = 'Yes';
              params['with_photo'] = 'Yes';
            }
          }
        } else if (val != null) {
          final str = _extractValueString(val);
          if (str.isNotEmpty) {
            params[field.name] = str;
          }
        }
      }
    }

    return params;
  }

  void performSearch(BuildContext context) {
    final params = compileSearchParameters();

    final criteria = SearchCriteria(
      fromAge: params['part_frm_age'] ?? params['from_age'],
      toAge: params['part_to_age'] ?? params['to_age'],
      fromHeight: params['part_height'] ?? params['from_height'],
      toHeight: params['part_height_to'] ?? params['to_height'],
      maritalStatus: params['marital_status'],
      motherTongue: params['mother_tongue'],
      religion: params['religion'],
      caste: params['caste'],
      country: params['country_id'] ?? params['country'],
      state: params['state_id'] ?? params['state'],
      city: params['city'],
      education: params['education_level'] ?? params['education'],
      occupation: params['occupation'],
      income: params['income'],
      manglik: params['manglik'],
      employeeIn: params['employee_in'],
      designation: params['designation_level'] ?? params['designation'],
      eatingHabits: params['diet'] ?? params['eating_habits'],
      smoking: params['smoke'] ?? params['smoking'],
      drinking: params['drink'] ?? params['drinking'],
      star: params['star'],
      photoSearch: params['photo_search'] == 'Yes' ? 'Yes' : null,
    );

    ref.read(searchCriteriaProvider.notifier).updateCriteria(criteria);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchResultScreen()),
    );
  }

  void executeAiMatchSearch(BuildContext context, {bool isTodayBestMatches = false}) {
    final params = compileSearchParameters();

    final minPercent = int.tryParse(params['min_match_percentage'] ?? '') ??
        (state.formValues['min_match_percentage'] is num
            ? (state.formValues['min_match_percentage'] as num).round()
            : 60);

    final isWithPhoto = params['with_photo'] == 'Yes' ||
        params['photo_search'] == 'Yes' ||
        state.formValues['with_photo'] == true ||
        state.formValues['photo_search'] == true;

    final criteria = AiMatchCriteria(
      fromAge: params['part_frm_age'] ?? params['from_age'],
      toAge: params['part_to_age'] ?? params['to_age'],
      fromHeight: params['part_height'] ?? params['from_height'],
      toHeight: params['part_height_to'] ?? params['to_height'],
      maritalStatus: params['marital_status'],
      motherTongue: params['mother_tongue'],
      religion: params['religion'],
      caste: params['caste'],
      countryId: params['country_id'] ?? params['country'],
      educationLevel: params['education_level'] ?? params['education'],
      minMatchPercentage: minPercent,
      withPhoto: isWithPhoto,
      isTodayBestMatches: isTodayBestMatches,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiMatchResultScreen(criteria: criteria),
      ),
    );
  }

  Future<void> saveSearch(BuildContext context, String searchPageName) async {
    final name = await AppDialogs.showSaveSearch(context, pageName: searchPageName);
    if (name != null && name.trim().isNotEmpty) {
      final params = compileSearchParameters();
      params['search_page_name'] = searchPageName;
      params['search_name'] = name.trim();

      final success = await ref.read(savedSearchProvider.notifier).saveSearch(params);
      if (success && context.mounted) {
        performSearch(context);
      }
    }
  }
}

class DynamicQuickSearchNotifier extends DynamicSearchBaseNotifier {
  @override
  String get searchType => 'quick_search';
}

class DynamicAdvancedSearchNotifier extends DynamicSearchBaseNotifier {
  @override
  String get searchType => 'advance_search';
}

class DynamicAiMatchNotifier extends DynamicSearchBaseNotifier {
  @override
  String get searchType => 'ai_match_search';
}

final dynamicQuickSearchProvider =
    NotifierProvider<DynamicQuickSearchNotifier, DynamicSearchState>(
  DynamicQuickSearchNotifier.new,
);

final dynamicAdvancedSearchProvider =
    NotifierProvider<DynamicAdvancedSearchNotifier, DynamicSearchState>(
  DynamicAdvancedSearchNotifier.new,
);

final dynamicAiMatchProvider =
    NotifierProvider<DynamicAiMatchNotifier, DynamicSearchState>(
  DynamicAiMatchNotifier.new,
);
