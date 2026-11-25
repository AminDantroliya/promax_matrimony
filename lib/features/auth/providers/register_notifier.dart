import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/data/repositories/auth_repository.dart';
import '../../../services/app_session_service.dart';
import '../../../services/registration_token_holder.dart';
import '../../../preference/session_keys.dart';

part 'register_notifier.g.dart';

const _sentinel = Object();

class RegisterState {
  final String registeredUserId;
  final String referenceId;
  final bool isLoading;
  final String? error;

  RegisterState({
    this.registeredUserId = "",
    this.referenceId = "",
    this.isLoading = false,
    this.error,
  });

  RegisterState copyWith({
    String? registeredUserId,
    String? referenceId,
    bool? isLoading,
    Object? error = _sentinel,
  }) {
    return RegisterState(
      registeredUserId: registeredUserId ?? this.registeredUserId,
      referenceId: referenceId ?? this.referenceId,
      isLoading: isLoading ?? this.isLoading,
      error: error == _sentinel ? this.error : (error as String?),
    );
  }
}

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    final cachedUserId =
        AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? "";
    return RegisterState(registeredUserId: cachedUserId);
  }

  Future<Map<String, dynamic>?> register(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final otpMethod =
          AppSessionService.getValue('otp_login_method') ?? 'firebase';
      final payload = Map<String, dynamic>.from(params);
      payload['otp_login_method'] ??= otpMethod;
      final result = await ref.read(authRepositoryProvider).register(payload);
      state = state.copyWith(isLoading: false);
      if (result['status'] == 'success') {
        if (result['data'] != null && result['data']['token'] != null) {
          RegistrationTokenHolder.setToken(result['data']['token'].toString());
        }
        if (result['data'] != null && result['data']['member_id'] != null) {
          final userId = result['data']['member_id'].toString();
          state = state.copyWith(registeredUserId: userId);
        }
        return result;
      } else {
        state = state.copyWith(error: result['message']);
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  Future<bool> registerNext(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .registerNext(params);
      final status = result['status']?.toString();
      final isSuccess = status == 'success' || status == '1';
      if (isSuccess) {
        state = state.copyWith(isLoading: false, error: null);
        return true;
      } else {
        final errorMsg = result['message']?.toString() ?? 'Registration failed';
        state = state.copyWith(isLoading: false, error: errorMsg);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> registerNextStep(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .registerNextStep(params);
      final status = result['status']?.toString();
      final isSuccess = status == 'success' || status == '1';
      if (isSuccess) {
        state = state.copyWith(isLoading: false, error: null);
        final step = params['step'];
        if (step != null) {
          await AppSessionService.setValue('registerStep', step.toString());
        }
        return true;
      } else {
        final errorMsg = result['message']?.toString() ?? 'Step failed';
        state = state.copyWith(isLoading: false, error: errorMsg);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>?> registerResendOtp(
    Map<String, dynamic> params,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final otpMethod =
          AppSessionService.getValue('otp_login_method') ?? 'firebase';
      final payload = Map<String, dynamic>.from(params);
      payload['otp_login_method'] ??= otpMethod;
      final result = await ref
          .read(authRepositoryProvider)
          .registerResendOtp(payload);
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> registerVerifyOtp(
    Map<String, dynamic> params,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final otpMethod =
          AppSessionService.getValue('otp_login_method') ?? 'firebase';
      final payload = Map<String, dynamic>.from(params);
      payload['otp_login_method'] ??= otpMethod;
      final result = await ref
          .read(authRepositoryProvider)
          .registerVerifyOtp(payload);
      state = state.copyWith(isLoading: false);
      if (result['status'] == 'success') {
        final userId = result['data']?['member_id']?.toString() ?? '';
        state = state.copyWith(registeredUserId: userId);

        if (result['data'] != null && result['data']['token'] != null) {
          RegistrationTokenHolder.setToken(result['data']['token'].toString());
        }

        return result;
      } else {
        state = state.copyWith(
          error: result['message'] ?? 'Verification failed',
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  Future<String?> generateAboutMe([String? memberId]) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final Map<String, dynamic> params = {};
      if (memberId != null && memberId.isNotEmpty) {
        params['member_id'] = memberId;
      }
      final result = await ref.read(authRepositoryProvider).generateAboutMe(params);
      state = state.copyWith(isLoading: false);
      if (result['status'] == 'success') {
        return result['data']['about_me']?.toString();
      }
      return null;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  Future<bool> uploadPhoto(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await ref.read(authRepositoryProvider).uploadPhoto(params);
      final status = result['status']?.toString();
      final isSuccess = status == 'success' || status == '1';
      if (isSuccess) {
        state = state.copyWith(isLoading: false, error: null);
        final step = params['step'];
        if (step != null) {
          await AppSessionService.setValue('registerStep', step.toString());
        }
        return true;
      } else {
        final errorMsg = result['message']?.toString() ?? 'Upload failed';
        state = state.copyWith(isLoading: false, error: errorMsg);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> uploadIdProof(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .uploadIdProof(params);
      final status = result['status']?.toString();
      final isSuccess = status == 'success' || status == '1';
      if (isSuccess) {
        state = state.copyWith(isLoading: false, error: null);
        final step = params['step'];
        if (step != null) {
          await AppSessionService.setValue('registerStep', step.toString());
        }
        return true;
      } else {
        final errorMsg = result['message']?.toString() ?? 'Upload failed';
        state = state.copyWith(isLoading: false, error: errorMsg);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> generateAadhaarOtp(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final refId = await ref
          .read(authRepositoryProvider)
          .generateAadhaarOtp(params);
      state = state.copyWith(referenceId: refId, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> verifyAadhaarOtp(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(authRepositoryProvider).verifyAadhaarOtp(params);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> verifyPan(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(authRepositoryProvider).verifyPan(params);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> verifyVoterId(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(authRepositoryProvider).verifyVoterId(params);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}
