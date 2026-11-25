import 'dart:convert';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/auth_repository.dart';
import '../data/models/auth_models.dart';
import '../../../services/app_session_service.dart';
import '../../../preference/session_keys.dart';
import '../../../utils/utils.dart';
import '../../home/providers/dashboard_notifier.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<LoginResponseModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final params = {
        'username': username,
        'password': password,
        'user_agent': getUserAgent(),
      };
      final result = await ref.read(authRepositoryProvider).login(params);
      if (result.status == "success") {
        await _saveSession(result);
        state = AsyncValue.data(result);
      } else {
        state = AsyncValue.error(result.message ?? "Login failed", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginWithFirebase(Map<String, dynamic> params) async {
    state = const AsyncValue.loading();
    try { 
      final result = await ref.read(authRepositoryProvider).loginWithFirebase(params);
      if (result.status == "success") {
        await _saveSession(result);
        state = AsyncValue.data(result);
      } else {
        state = AsyncValue.error(result.message ?? "Login failed", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> forgotPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      final msg = await ref.read(authRepositoryProvider).forgotPassword({'email': email});
      state = const AsyncValue.data(null);
      return msg;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> loginWithOtp(String mobile, String countryCode) async {
    state = const AsyncValue.loading();
    try {
      final otpMethod = AppSessionService.getValue('otp_login_method') ?? 'firebase';
      final params = {
        'mobile': mobile,
        'country_code': countryCode,
        'otp_login_method': otpMethod,
      };
      final result = await ref.read(authRepositoryProvider).generateOtp(params);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> verifyOtp(
    String mobile,
    String countryCode,
    String otp, {
    String? firebaseToken,
  }) async {
    state = const AsyncValue.loading();
    try {
      final deviceId = await getDeviceId();
      final userAgent = getUserAgent();
      final otpMethod = AppSessionService.getValue('otp_login_method') ?? 'firebase';

      final params = <String, dynamic>{
        'mobile': mobile,
        'country_code': countryCode,
        'otp': otp,
        'user_agent': userAgent,
        'android_device_id': Platform.isAndroid ? deviceId : '',
        'ios_device_id': Platform.isIOS ? deviceId : '',
        'otp_login_method': otpMethod,
      };
      if (firebaseToken != null && firebaseToken.isNotEmpty) {
        params['firebase_token'] = firebaseToken;
      }
      final result = await ref.read(authRepositoryProvider).verifyOtp(params);
      if (result.status == "success") {
        await _saveSession(result);
        state = AsyncValue.data(result);
      } else {
        state = AsyncValue.error(result.message ?? "Verification failed", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _saveSession(LoginResponseModel result) async {
    final data = result.data;
    final member = data?.memberData;
    if (data != null && member != null) {
      await AppSessionService.setValue(SessionDetail.kAccessToken, data.token ?? '');
      await AppSessionService.setValue(SessionDetail.kUserId, member.id?.toString() ?? '');
      await AppSessionService.setValue(SessionDetail.kMatriId, member.matriId ?? '');
      await AppSessionService.setValue(SessionDetail.kGender, member.gender ?? '');
      await AppSessionService.setValue(SessionDetail.kUserType, member.userType?.toString() ?? '');
      await AppSessionService.setValue(SessionDetail.kIsLoggedIn, true);
      
      // Cache the full user profile details inside SharedPreferences
      await AppSessionService.setValue("userProfileData", json.encode(member.toJson()));

      ref.invalidate(dashboardProvider);
    }
  }
}
