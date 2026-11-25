import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebasePhoneAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Initiate Firebase Phone Number verification
  static Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(PhoneAuthCredential credential) onVerificationCompleted,
    required Function(FirebaseAuthException exception) onVerificationFailed,
    required Function(String verificationId) onCodeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    debugPrint('[FirebasePhoneAuth] Requesting OTP for: $phoneNumber');
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint('[FirebasePhoneAuth] Instant verification completed');
        onVerificationCompleted(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('[FirebasePhoneAuth] Verification failed: ${e.message} (${e.code})');
        onVerificationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('[FirebasePhoneAuth] Code sent, verificationId: $verificationId');
        onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('[FirebasePhoneAuth] Auto retrieval timeout: $verificationId');
        onCodeAutoRetrievalTimeout(verificationId);
      },
      forceResendingToken: forceResendingToken,
    );
  }

  /// Verify SMS code using verification ID and SMS Code
  static Future<UserCredential> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _auth.signInWithCredential(credential);
  }
}
