import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import 'dart:io';

part 'support_repository.g.dart';

class SupportRepository extends BaseRepository {
  SupportRepository(super.dio);

  Future<Map<String, dynamic>> getSiteSettings() async {
    final response = await postRequest(getSiteSettingApi, {
      'device_type': Platform.isAndroid ? 'android' : 'ios',
    });
    return response.object;
  }

  Future<Map<String, dynamic>> contactUs(Map<String, dynamic> params) async {
    final response = await postRequest(contactUsApi, params);
    return response.data;
  }

  Future<Map<String, dynamic>> reportToAdmin(Map<String, dynamic> params) async {
    final response = await postRequest(reportToAdminApi, params);
    return response.data;
  }
}

@riverpod
SupportRepository supportRepository(Ref ref) {
  return SupportRepository(ref.watch(dioProvider));
}
