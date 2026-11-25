import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/common/data/repositories/dropdown_repository.dart';
import '../../../features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/preference/session_keys.dart';

part 'dropdown_notifier.g.dart';

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

/// Helper method to verify if dropdown data exists and is proper (non-empty essential fields)
bool isDropdownDataProper(DropdownData? data) {
  if (data == null) return false;
  return (data.maritalStatus != null && data.maritalStatus!.isNotEmpty) ||
      (data.religionList != null && data.religionList!.isNotEmpty) ||
      (data.mothertongueList != null && data.mothertongueList!.isNotEmpty) ||
      (data.profileby != null && data.profileby!.isNotEmpty) ||
      (data.countryList != null && data.countryList!.isNotEmpty) ||
      (data.educationMasterList != null && data.educationMasterList!.isNotEmpty);
}

@Riverpod(keepAlive: true)
Future<DropdownData?> allDropdowns(Ref ref) async {
  // 1. Check in-memory runtime cache first (only if data is valid and proper)
  final memoryModel = ApplicationData().getDropdownResponseModel;
  if (memoryModel?.data != null && isDropdownDataProper(memoryModel!.data)) {
    return memoryModel.data;
  }

  final langCode = AppSessionService.getValue(SessionDetail.kLanguageCode) ?? "en";
  final jsonKey = 'cached_dropdown_json_$langCode';
  final timestampKey = 'cached_dropdown_timestamp_$langCode';

  final lastFetchMillis = AppSessionService.getValue(timestampKey);
  final cachedJsonStr = AppSessionService.getValue(jsonKey);

  // 2. Check if persistent cache exists, was fetched today, and is proper
  if (cachedJsonStr != null && lastFetchMillis != null) {
    try {
      final lastFetchDate = DateTime.fromMillisecondsSinceEpoch(lastFetchMillis as int);
      if (_isSameDay(lastFetchDate, DateTime.now())) {
        final Map<String, dynamic> decodedMap = json.decode(cachedJsonStr as String);
        final model = DropdownResponseModel.fromJson(decodedMap);
        if (isDropdownDataProper(model.data)) {
          ApplicationData().setDropdownResponseModel = model;
          return model.data;
        }
      }
    } catch (_) {}
  }

  String? apiErrorMessage;
  // 3. Otherwise, fetch from API
  try {
    final repository = ref.read(dropdownRepositoryProvider);
    final response = await repository.getAllDropdowns();
    if (response['status'] == 'error') {
      apiErrorMessage = response['message']?.toString() ?? 'Failed to load options';
    } else if (response.isNotEmpty && response['data'] is Map<String, dynamic>) {
      final model = DropdownResponseModel.fromJson(response);
      if (isDropdownDataProper(model.data)) {
        ApplicationData().setDropdownResponseModel = model;

        // Save to SharedPreferences for daily persistent caching
        await AppSessionService.setValue(jsonKey, json.encode(response));
        await AppSessionService.setValue(timestampKey, DateTime.now().millisecondsSinceEpoch);

        return model.data;
      }
    }
  } catch (e) {
    apiErrorMessage = e.toString();
  }

  // 4. Fallback: If network/API call fails (e.g. 500 error or offline), use any existing cached JSON if proper
  if (cachedJsonStr != null) {
    try {
      final Map<String, dynamic> decodedMap = json.decode(cachedJsonStr as String);
      final model = DropdownResponseModel.fromJson(decodedMap);
      if (isDropdownDataProper(model.data)) {
        ApplicationData().setDropdownResponseModel = model;
        return model.data;
      }
    } catch (_) {}
  }

  final fallbackData = ApplicationData().getDropdownResponseModel?.data;
  if (isDropdownDataProper(fallbackData)) {
    return fallbackData;
  }

  // Throw so Riverpod enters AsyncError, stopping any automated re-fetch cycles
  throw Exception(apiErrorMessage ?? 'Failed to load options');
}

@riverpod
class DependentDropdownNotifier extends _$DependentDropdownNotifier {
  @override
  Map<String, List<DropdownOptionModel>> build() {
    return {
      'caste': [],
      'state': [],
      'city': [],
      'income': [],
    };
  }

  Future<void> fetchDependentData({
    required String listFrom,
    required String listTo,
    required String value,
  }) async {
    final repository = ref.read(dropdownRepositoryProvider);
    
    // Map listTo to the expected type parameter for the backend
    String apiType = listTo;
    if (listTo == "state_id") {
      apiType = "state";
    }

    final params = {
      "type": apiType,
      "parent_id": value,
    };
    final response = await repository.getDependentDropdowns(params);
    final rawData = response['data'];
    final List<DropdownOptionModel> data = (rawData is List)
        ? rawData.map((e) => DropdownOptionModel.fromJson(e)).toList()
        : [];

    var newState = Map<String, List<DropdownOptionModel>>.from(state);
    if (listTo == "caste") {
      newState['caste'] = data;
    } else if (listTo == "state_id") {
      newState['state'] = data;
    } else if (listTo == "city") {
      newState['city'] = data;
    } else if (listTo == "income") {
      newState['income'] = data;
    }
    state = newState;
  }
}
