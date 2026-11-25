import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../../core/network/base_repository.dart';
import '../../../features/profile/data/models/profile_models.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import '../../../services/app_session_service.dart';
import '../../../utils/application_data.dart';

part 'profile_notifier.g.dart';

@riverpod
class MyProfileNotifier extends _$MyProfileNotifier {
  @override
  FutureOr<ProfileData?> build() async {
    // Try to load cached user profile details first for instant UI render
    final jsonStr = AppSessionService.getValue("userProfileData") as String?;
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final decoded = json.decode(jsonStr);
        final data = ProfileData.fromJson(decoded);
        ApplicationData.isMemberPaid =
            data.planStatus != "Not Paid" && data.planStatus != "Expired";

        // Fetch fresh data in background to ensure plan & profile are up to date
        _fetchFreshProfileInBackground();

        return data;
      } catch (e) {
        // Fallback to fetch from API on JSON parsing error
      }
    }

    return _fetchFreshProfile();
  }

  void _fetchFreshProfileInBackground() async {
    try {
      final response = await ref.read(profileRepositoryProvider).getMyProfile();
      if (response.data != null) {
        await AppSessionService.setValue(
          "userProfileData",
          json.encode(response.data!.toJson()),
        );
        ApplicationData.isMemberPaid =
            response.data?.planStatus != "Not Paid" &&
            response.data?.planStatus != "Expired";
        state = AsyncValue.data(response.data);
      }
    } catch (_) {}
  }

  Future<ProfileData?> _fetchFreshProfile() async {
    final response = await ref.read(profileRepositoryProvider).getMyProfile();
    if (response.data != null) {
      await AppSessionService.setValue(
        "userProfileData",
        json.encode(response.data!.toJson()),
      );
      ApplicationData.isMemberPaid =
          response.data?.planStatus != "Not Paid" &&
          response.data?.planStatus != "Expired";
    }
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(profileRepositoryProvider).getMyProfile();
      if (response.data != null) {
        await AppSessionService.setValue(
          "userProfileData",
          json.encode(response.data!.toJson()),
        );
        ApplicationData.isMemberPaid =
            response.data?.planStatus != "Not Paid" &&
            response.data?.planStatus != "Expired";
      }
      return response.data;
    });
  }

  Future<void> updateProfile(Map<String, dynamic> params) async {
    await ref.read(profileRepositoryProvider).updateMyProfile(params);
    await refresh();
  }

  Future<void> uploadPhoto(String url, Map<String, dynamic> data) async {
    final status = await ref
        .read(profileRepositoryProvider)
        .uploadPhoto(url, FormData.fromMap(data));
    if (status == "success") {
      await refresh();
    }
  }

  Future<void> deletePhoto(String url, Map<String, dynamic> params) async {
    final status = await ref
        .read(profileRepositoryProvider)
        .deletePhoto(url, params);
    if (status == "success") {
      await refresh();
    }
  }

  Future<ApiResponse> verifyEmail() async {
    return await ref.read(profileRepositoryProvider).verifyEmail();
  }

  Future<ApiResponse> generateMobileOtp() async {
    return await ref.read(profileRepositoryProvider).verifyMobileGenerateOtp();
  }

  Future<ApiResponse> resendMobileOtp() async {
    return await ref.read(profileRepositoryProvider).verifyMobileResendOtp();
  }

  Future<ApiResponse> verifyMobileOtp(String otp, {String? firebaseToken}) async {
    final response = await ref
        .read(profileRepositoryProvider)
        .verifyMobileVerifyOtp(otp, firebaseToken: firebaseToken);
    final isSuccess =
        response.status.toLowerCase() == "success" ||
        response.status == "1" ||
        response.status.toLowerCase() == "true";
    if (isSuccess) {
      await refresh();
    }
    return response;
  }
}

@riverpod
class OtherProfileNotifier extends _$OtherProfileNotifier {
  @override
  FutureOr<ProfileData?> build(String memberId) async {
    final response = await ref
        .read(profileRepositoryProvider)
        .getOtherMemberProfile(memberId);
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(profileRepositoryProvider)
          .getOtherMemberProfile(memberId);
      return response.data;
    });
  }
}
