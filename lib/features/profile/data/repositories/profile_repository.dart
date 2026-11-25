import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../models/profile_models.dart';
import '../../../../utils/api_urls.dart';

part 'profile_repository.g.dart';

class ProfileRepository extends BaseRepository {
  ProfileRepository(super.dio);

  Future<MyProfileResponseModel> getMyProfile() async {
    final response = await getRequest(getMyProfileApi);
    return MyProfileResponseModel.fromJson(response.data);
  }

  Future<void> updateMyProfile(Map<String, dynamic> params) async {
    await postRequest(editMyProfileApi, params);
  }

  Future<OtherMemberProfileResponseModel> getOtherMemberProfile(String memberId) async {
    final response = await postRequest(getOtherMemberProfileApi, {"user_id": memberId});
    return OtherMemberProfileResponseModel.fromJson(response.data);
  }

  Future<ApiResponse> verifyEmail() async {
    return await getRequest(verifyEmailApi);
  }

  Future<ApiResponse> verifyMobileGenerateOtp() async {
    return await getRequest(verifyMobileGenerateOtpApi);
  }

  Future<ApiResponse> verifyMobileResendOtp() async {
    return await getRequest(verifyMobileResendOtpApi);
  }

  Future<ApiResponse> verifyMobileVerifyOtp(String otp, {String? firebaseToken}) async {
    final params = <String, dynamic>{"otp": otp};
    if (firebaseToken != null && firebaseToken.isNotEmpty) {
      params["firebase_token"] = firebaseToken;
    }
    return await postRequest(verifyMobileVerifyOtpApi, params);
  }

  Future<String> verifyMobileFirebase() async {
    final response = await getRequest(verifyMobileVerifyFirebaseApi);
    return response.status.toString();
  }

  Future<String> uploadPhoto(String url, FormData data) async {
    final response = await postMultipartRequest(url, data);
    return response.status.toString();
  }

  Future<String> deletePhoto(String url, Map<String, dynamic> params) async {
    final response = await postRequest(url, params);
    return response.status.toString();
  }

  Future<void> requestDeleteProfile(Map<String, dynamic> params) async {
    await postRequest(requestDeleteMyProfileApi, params);
  }

  Future<dynamic> getOtherMemberContactDetails(String memberId) async {
    final response = await postRequest(viewContactDetailsApi, {"user_id": memberId});
    return response.data;
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(ref.watch(dioProvider));
}
