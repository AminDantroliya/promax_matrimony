import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/common_models.dart';
import '../../../../utils/api_urls.dart';

part 'config_repository.g.dart';

abstract class ConfigRepository {
  Future<TokenResponseModel> getToken(Map<String, dynamic> params);
  Future<Map<String, dynamic>> getDropdownData();
}

class ConfigRepositoryImpl implements ConfigRepository {
  final Dio _dio;

  ConfigRepositoryImpl(this._dio);

  @override
  Future<TokenResponseModel> getToken(Map<String, dynamic> params) async {
    final response = await _dio.post(getTokenApi, data: params);
    return TokenResponseModel.fromJson(response.data);
  }

  @override
  Future<Map<String, dynamic>> getDropdownData() async {
    try {
      final response = await _dio.get(getDropdownDataApi);
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return {};
    } catch (_) {
      return {};
    }
  }
}

@riverpod
ConfigRepository configRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ConfigRepositoryImpl(dio);
}
