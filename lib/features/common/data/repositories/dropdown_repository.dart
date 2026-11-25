import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../utils/api_urls.dart';

part 'dropdown_repository.g.dart';

abstract class DropdownRepository {
  Future<Map<String, dynamic>> getAllDropdowns();
  Future<Map<String, dynamic>> getDependentDropdowns(Map<String, dynamic> params);
}

class DropdownRepositoryImpl implements DropdownRepository {
  final Dio _dio;

  DropdownRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getAllDropdowns() async {
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

  @override
  Future<Map<String, dynamic>> getDependentDropdowns(Map<String, dynamic> params) async {
    try {
      final response = await _dio.post(getDependentDropdownDataApi, data: params);
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
DropdownRepository dropdownRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return DropdownRepositoryImpl(dio);
}
