import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';

import '../../../../utils/api_urls.dart';
import '../models/ai_interest_models.dart';

part 'settings_repository.g.dart';

class SettingsRepository extends BaseRepository {
  SettingsRepository(super.dio);

  Future<Map<String, dynamic>> performAction(String url, Map<String, dynamic> params) async {
    final response = await postRequest(url, params);
    if (response.object is Map<String, dynamic>) {
      final map = Map<String, dynamic>.from(response.object as Map);
      map['status'] ??= response.status;
      map['message'] ??= response.message;
      return map;
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getPrivacySettings() async {
    final response = await getRequest(getPrivacySettingsApi);
    if (response.object is Map<String, dynamic>) {
      return response.object;
    }
    return response.data;
  }

  Future<Map<String, dynamic>> updatePrivacySetting(Map<String, dynamic> params) async {
    final formData = FormData.fromMap(params);
    final response = await postMultipartRequest(updatePrivacySettingsApi, formData);
    if (response.object is Map<String, dynamic>) {
      return response.object;
    }
    return response.data;
  }

  /// PUT/POST ai-interest/update-settings
  Future<Map<String, dynamic>> updateAiSettings(Map<String, dynamic> params) async {
    final response = await postRequest(aiInterestUpdateSettingsApi, params);
    if (response.object is Map<String, dynamic>) {
      return response.object;
    }
    return response.data;
  }

  /// GET ai-interest/list
  Future<AiInterestListResponse> getAiInterestList() async {
    final response = await getRequest(aiInterestListApi);
    return AiInterestListResponse.fromJson(response.data);
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository(ref.watch(dioProvider));
}
