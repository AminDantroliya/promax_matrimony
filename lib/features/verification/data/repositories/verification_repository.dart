import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../utils/api_urls.dart';

part 'verification_repository.g.dart';

class VerificationRepository extends BaseRepository {
  VerificationRepository(super.dio);

  Future<Map<String, dynamic>> generateAadhaarOtp(Map<String, dynamic> params) async {
    final response = await postRequest(generateAadhaarOtpProfileApi, params);
    return response.object;
  }

  Future<Map<String, dynamic>> verifyAadhaarOtp(Map<String, dynamic> params) async {
    final response = await postRequest(verifyAadhaarOtpProfileApi, params);
    return response.object;
  }

  Future<Map<String, dynamic>> verifyPan(Map<String, dynamic> params) async {
    final response = await postRequest(verifyPanProfileApi, params);
    return response.object;
  }

  Future<Map<String, dynamic>> verifyVoterId(Map<String, dynamic> params) async {
    final response = await postRequest(verifyVoterIdProfileApi, params);
    return response.object;
  }
}

@riverpod
VerificationRepository verificationRepository(Ref ref) {
  return VerificationRepository(ref.watch(dioProvider));
}
