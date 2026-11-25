import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/verification/data/repositories/verification_repository.dart';

part 'verification_notifier.freezed.dart';
part 'verification_notifier.g.dart';

@freezed
abstract class VerificationState with _$VerificationState {
  const factory VerificationState({
    @Default(false) bool isLoading,
    @Default(false) bool isOtpSent,
    @Default("") String referenceId,
    Object? error,
    String? successMessage,
  }) = _VerificationState;
}

@riverpod
class VerificationNotifier extends _$VerificationNotifier {
  @override
  VerificationState build() {
    return const VerificationState();
  }

  Future<bool> generateAadhaarOtp(String aadhaarNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(verificationRepositoryProvider);
      final response = await repository.generateAadhaarOtp({"aadhar_number": aadhaarNumber});
      
      if (response['status'] == "success") {
        state = state.copyWith(
          isLoading: false,
          isOtpSent: true,
          referenceId: response['data']['reference_id'].toString(),
        );
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: response['message']);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  Future<bool> verifyAadhaarOtp(String aadhaarNumber, String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(verificationRepositoryProvider);
      final response = await repository.verifyAadhaarOtp({
        "reference_id": state.referenceId,
        "aadhar_number": aadhaarNumber,
        "otp": otp,
      });

      if (response['status'] == "success") {
        state = state.copyWith(isLoading: false, successMessage: response['message']);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: response['message']);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  Future<bool> verifyPan(String name, String number) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(verificationRepositoryProvider);
      final response = await repository.verifyPan({"pan_name": name, "pan_number": number});

      if (response['status'] == "success") {
        state = state.copyWith(isLoading: false, successMessage: response['message']);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: response['message']);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }

  Future<bool> verifyVoterId(String name, String number) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(verificationRepositoryProvider);
      final response = await repository.verifyVoterId({"voter_id_name": name, "voter_id_number": number});

      if (response['status'] == "success") {
        state = state.copyWith(isLoading: false, successMessage: response['message']);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: response['message']);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
      return false;
    }
  }
}
