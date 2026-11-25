import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/auth_models.dart';
import '../../../../utils/api_urls.dart';
import '../../../../services/app_session_service.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(Map<String, dynamic> params);
  Future<LoginResponseModel> loginWithFirebase(Map<String, dynamic> params);
  Future<Map<String, dynamic>> generateOtp(Map<String, dynamic> params);
  Future<LoginResponseModel> verifyOtp(Map<String, dynamic> params);
  Future<String> forgotPassword(Map<String, dynamic> params);
  
  // Registration
  Future<Map<String, dynamic>> register(Map<String, dynamic> params);
  Future<Map<String, dynamic>> registerNext(Map<String, dynamic> params);
  Future<Map<String, dynamic>> registerNextStep(Map<String, dynamic> params);
  Future<Map<String, dynamic>> registerResendOtp(Map<String, dynamic> params);
  Future<Map<String, dynamic>> registerVerifyOtp(Map<String, dynamic> params);
  Future<Map<String, dynamic>> generateAboutMe(Map<String, dynamic> params);
  Future<Map<String, dynamic>> uploadPhoto(Map<String, dynamic> params);
  Future<Map<String, dynamic>> uploadIdProof(Map<String, dynamic> params);
  Future<String> generateAadhaarOtp(Map<String, dynamic> params);
  Future<void> verifyAadhaarOtp(Map<String, dynamic> params);
  Future<void> verifyPan(Map<String, dynamic> params);
  Future<void> verifyVoterId(Map<String, dynamic> params);
  Future<void> changePassword(Map<String, dynamic> params);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  Future<void> _saveRegisterStep(Map<String, dynamic>? data) async {
    if (data == null) return;
    // ── register_step ──────────────────────────────────────────────────────
    final step = data['register_step'] ??
                 data['data']?['register_step'] ??
                 data['data']?['member_data']?['register_step'] ??
                 data['member_data']?['register_step'];
    if (step != null) {
      await AppSessionService.setValue('registerStep', step.toString());
    }
    // ── register_step_status ───────────────────────────────────────────────
    final status = data['register_step_status'] ??
                   data['data']?['register_step_status'] ??
                   data['data']?['member_data']?['register_step_status'] ??
                   data['member_data']?['register_step_status'];
    if (status != null) {
      await AppSessionService.setValue('registerStepStatus', status.toString());
    }
  }

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> params) async {
    final response = await _dio.post(loginApi, data: params);
    await _saveRegisterStep(response.data);
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<LoginResponseModel> loginWithFirebase(Map<String, dynamic> params) async {
    final response = await _dio.post(firebaseLoginApi, data: params);
    await _saveRegisterStep(response.data);
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<Map<String, dynamic>> generateOtp(Map<String, dynamic> params) async {
    final response = await _dio.post(generateOtpApi, data: params);
    return response.data;
  }

  @override
  Future<LoginResponseModel> verifyOtp(Map<String, dynamic> params) async {
    final response = await _dio.post(verifyOtpApi, data: params);
    await _saveRegisterStep(response.data);
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<String> forgotPassword(Map<String, dynamic> params) async {
    final response = await _dio.post(forgotPasswordApi, data: params);
    if (response.data['status'] == 'success' || response.data['code'] == 200) {
      return response.data['message'] ?? 'Reset password link has been sent to your email address.';
    } else {
      throw response.data['message'] ?? 'Something went wrong';
    }
  }

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> params) async {
    final response = await _dio.post(registerApi, data: params);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> registerNext(Map<String, dynamic> params) async {
    final response = await _dio.post(registerNextApi, data: params);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> registerNextStep(Map<String, dynamic> params) async {
    final response = await _dio.post(registerNextStepApi, data: params);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> registerResendOtp(Map<String, dynamic> params) async {
    final response = await _dio.post(registerResendOtpApi, data: params);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> registerVerifyOtp(Map<String, dynamic> params) async {
    final response = await _dio.post(registerVerifyOtpApi, data: params);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> generateAboutMe(Map<String, dynamic> params) async {
    final response = await _dio.post(generateAboutMeApi, data: params);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> uploadPhoto(Map<String, dynamic> params) async {
    final formData = FormData.fromMap(params);
    final response = await _dio.post(registerNextStepApi, data: formData);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> uploadIdProof(Map<String, dynamic> params) async {
    final formData = FormData.fromMap(params);
    final response = await _dio.post(registerNextStepApi, data: formData);
    return response.data;
  }

  @override
  Future<String> generateAadhaarOtp(Map<String, dynamic> params) async {
    final response = await _dio.post(generateAadhaarOtpApi, data: params);
    return response.data['data']['reference_id'].toString();
  }

  @override
  Future<void> verifyAadhaarOtp(Map<String, dynamic> params) async {
    await _dio.post(verifyAadhaarOtpApi, data: params);
  }

  @override
  Future<void> verifyPan(Map<String, dynamic> params) async {
    await _dio.post(verifyPanApi, data: params);
  }

  @override
  Future<void> verifyVoterId(Map<String, dynamic> params) async {
    await _dio.post(verifyVoterIdApi, data: params);
  }

  @override
  Future<void> changePassword(Map<String, dynamic> params) async {
    await _dio.post(changePasswordApi, data: params);
  }

  @override
  Future<void> logout() async {
    await _dio.post(logoutApi);
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(dio);
}
