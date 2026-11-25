import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:pinput/pinput.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import '../providers/auth_notifier.dart';
import '../../../../utils/utils.dart';
import '../providers/register_notifier.dart';
import '../../../../core/routing/router_provider.dart';
import '../../../../services/app_session_service.dart';
import '../../../../widgets/app_common_background.dart';
import 'package:pro_matrimony/services/firebase_phone_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String countryCode;
  final String mobile;

  final bool isRegister;
  final String registrationToken;
  final String? verificationId;
  final int? resendToken;

  const VerifyOtpScreen({
    super.key,
    required this.countryCode,
    required this.mobile,
    this.isRegister = false,
    this.registrationToken = '',
    this.verificationId,
    this.resendToken,
  });

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final _verifyOtpFormKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  Timer? _timer;
  int _secondsRemaining = 60; // 1 minute timer
  String? currentVerificationId;
  int? currentResendToken;

  @override
  void initState() {
    super.initState();
    currentVerificationId = widget.verificationId;
    currentResendToken = widget.resendToken;
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _resendOtp() async {
    otpController.clear();
    hideKeyboard(context);
    final otpMethod =
        AppSessionService.getValue('otp_login_method') ?? 'firebase';

    if (otpMethod == 'firebase') {
      final fullPhoneNumber = '${widget.countryCode}${widget.mobile}';
      try {
        if (mounted) showLoading(context);
        await FirebasePhoneAuthService.sendOtp(
          phoneNumber: fullPhoneNumber,
          forceResendingToken: currentResendToken,
          onCodeSent: (newVerificationId, newResendToken) {
            hideLoading();
            setState(() {
              currentVerificationId = newVerificationId;
              currentResendToken = newResendToken;
            });
            _startTimer();
            showToast('otp_resent_successfully'.tr);
          },
          onVerificationCompleted: (credential) {
            hideLoading();
          },
          onVerificationFailed: (exception) {
            hideLoading();
            showToast(exception.message ?? 'resend_failed'.tr);
          },
          onCodeAutoRetrievalTimeout: (vId) {
            hideLoading();
          },
        );
      } catch (e) {
        hideLoading();
        showToast('Error resending OTP: $e');
      }
      return;
    }

    try {
      if (widget.isRegister) {
        final params = {
          'country_code': widget.countryCode,
          'mobile': widget.mobile,
          'registration_token': widget.registrationToken,
        };
        final result = await ref
            .read(registerProvider.notifier)
            .registerResendOtp(params);
        if (result != null && result['status'] == 'success') {
          _startTimer();
          showToast('otp_resent_successfully'.tr);
        } else {
          showToast(ref.read(registerProvider).error ?? 'resend_failed'.tr);
        }
      } else {
        final result = await ref
            .read(authProvider.notifier)
            .loginWithOtp(widget.mobile, widget.countryCode);
        if (result != null && result['status'] == 'success') {
          _startTimer();
          showToast('otp_resent_successfully'.tr);
        }
      }
    } catch (e) {
      showToast('Error resending OTP: $e');
    }
  }

  Future<void> _submitOtp() async {
    if (_verifyOtpFormKey.currentState!.validate()) {
      hideKeyboard(context);
      final otpMethod =
          AppSessionService.getValue('otp_login_method') ?? 'firebase';

      String? firebaseToken;

      if (otpMethod == 'firebase') {
        if (currentVerificationId != null &&
            currentVerificationId!.isNotEmpty) {
          try {
            if (mounted) showLoading(context);
            final userCredential = await FirebasePhoneAuthService.signInWithSmsCode(
              verificationId: currentVerificationId!,
              smsCode: otpController.text.trim(),
            );
            firebaseToken = await userCredential.user?.getIdToken() ??
                await FirebaseAuth.instance.currentUser?.getIdToken();
            printLog("FIREBASE_TOKEN $firebaseToken");
            hideLoading();
          } on FirebaseAuthException catch (e) {
            hideLoading();
            showToast(e.message ?? 'invalid_otp_error'.tr);
            return;
          } catch (e) {
            hideLoading();
            showToast('invalid_otp_error'.tr);
            return;
          }
        }
      }

      final deviceId = await getDeviceId();

      if (widget.isRegister) {
        final params = {
          'country_code': widget.countryCode,
          'mobile': widget.mobile,
          'otp': otpController.text,
          'user_agent': getUserAgent(),
          'android_device_id': Platform.isAndroid ? deviceId : '',
          'ios_device_id': Platform.isIOS ? deviceId : '',
          'registration_token': widget.registrationToken,
        };
        if (firebaseToken != null && firebaseToken.isNotEmpty){
          params.putIfAbsent('firebase_token', () => firebaseToken.toString());
        }
        final result = await ref.read(registerProvider.notifier).registerVerifyOtp(params);
        if (result != null && mounted) {
          context.go('/register');
        } else if (mounted) {
          showToast(ref.read(registerProvider).error ?? 'Verification failed');
        }
      } else {
        ref.read(authProvider.notifier).verifyOtp(
              widget.mobile,
              widget.countryCode,
              otpController.text,
              firebaseToken: firebaseToken,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);
    final authState = ref.watch(authProvider);
    final registerState = ref.watch(registerProvider);
    final isLoading =
        authState.maybeWhen(loading: () => true, orElse: () => false) ||
        registerState.isLoading;

    ref.listen(authProvider, (previous, next) {
      if (widget.isRegister) return;
      next.whenOrNull(
        data: (response) {
          if (response?.status == "success") {
            final registerStepStr = AppSessionService.getValue('registerStep');
            final step = int.tryParse(registerStepStr?.toString() ?? '9') ?? 9;
            context.go(getRouteForRegisterStep(step));
          }
        },
        error: (error, stack) {
          showToast('Error: $error');
        },
      );
    });

    // Pinput styling matching dynamic theme
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: AppFont.font(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: isDarkMode ? Colors.white : const Color(0xFF16182F),
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF222438) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white12 : const Color(0xFFE0D8D0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: config.primaryColor, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: AppFont.font(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [config.gradientStart, config.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: config.primaryColor.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.red, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: AppAuthBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ── Top Header & Phone Card Area ─────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // Header Row: Back button (1/3 indicator removed)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const Gap(6),
                                Text(
                                  'Back',
                                  style: AppFont.font(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                      const Gap(16),

                      // Glass Info Card: SENT TO + Phone Number + Actions
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Heart Icon Container (dynamic gradient)
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        config.gradientStart,
                                        config.gradientEnd,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),

                                // Tag: SMS SENT
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF4ADE80),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Gap(6),
                                      Text(
                                        'SMS SENT',
                                        style: AppFont.font(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const Gap(12),

                            Text(
                              'SENT TO',
                              style: AppFont.font(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.6),
                                letterSpacing: 0.8,
                              ),
                            ),
                            const Gap(2),
                            Text(
                              '${widget.countryCode} ${widget.mobile}',
                              style: AppFont.font(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),

                            const Gap(12),

                            // Action Pill: Change
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        const Gap(4),
                                        Text(
                                          'Change',
                                          style: AppFont.font(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(8),

                // ── Dynamic Bottom Sheet Container ──────────────────────
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF161726)
                          : config.scaffoldBgColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000),
                          blurRadius: 30,
                          offset: Offset(0, -10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Form(
                        key: _verifyOtpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Headline: Enter the 6-digit code
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Enter the ',
                                  style: AppFont.font(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF16182F),
                                  ),
                                ),
                                Text(
                                  '6-digit code',
                                  style: AppFont.font(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: config.primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            const Gap(4),

                            Center(
                              child: Text(
                                'Check your messages for the verification code',
                                textAlign: TextAlign.center,
                                style: AppFont.font(
                                  fontSize: 13,
                                  color: isDarkMode
                                      ? Colors.white60
                                      : const Color(0xFF8A90A6),
                                ),
                              ),
                            ),

                            const Gap(24),

                            // Pinput 6-Digit OTP Box wrapped in m_ui.Material & Localizations
                            Center(
                              child: Localizations.override(
                                context: context,
                                delegates: const [
                                  m_ui.DefaultMaterialLocalizations.delegate,
                                ],
                                child: m_ui.Material(
                                  type: m_ui.MaterialType.transparency,
                                  child: Pinput(
                                    length: 6,
                                    controller: otpController,
                                    focusNode: focusNode,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    errorPinTheme: errorPinTheme,
                                    separatorBuilder: (index) =>
                                        const SizedBox(width: 6),
                                    readOnly: isLoading,
                                    onCompleted: (pin) => _submitOtp(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'empty_field_error'.tr;
                                      } else if (value.length != 6) {
                                        return 'invalid_otp_error'.tr;
                                      }
                                      return null;
                                    },
                                    hapticFeedbackType:
                                        HapticFeedbackType.lightImpact,
                                  ),
                                ),
                              ),
                            ),

                            const Gap(16),

                            // Resend & Expiry Timer Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: _secondsRemaining == 0
                                      ? _resendOtp
                                      : null,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.refresh_rounded,
                                        size: 16,
                                        color: _secondsRemaining == 0
                                            ? config.primaryColor
                                            : (isDarkMode
                                                ? Colors.white54
                                                : const Color(0xFF8A90A6)),
                                      ),
                                      const Gap(4),
                                      Text(
                                        'Resend code',
                                        style: AppFont.font(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: _secondsRemaining == 0
                                              ? config.primaryColor
                                              : (isDarkMode
                                                  ? Colors.white54
                                                  : const Color(0xFF8A90A6)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Timer Badge (hidden when seconds remain 0)
                                if (_secondsRemaining > 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? const Color(0xFF222438)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? Colors.white12
                                            : const Color(0xFFE0D8D0),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: config.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const Gap(6),
                                        Text(
                                          'Expires in ',
                                          style: AppFont.font(
                                            fontSize: 12,
                                            color: isDarkMode
                                                ? Colors.white60
                                                : const Color(0xFF8A90A6),
                                          ),
                                        ),
                                        Text(
                                          '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                          style: AppFont.font(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: config.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),

                            const Gap(24),

                            // Primary Button: Verify & Continue (auto-detect card removed)
                            FigmaPrimaryButton(
                              text: 'Verify & Continue',
                              isLoading: isLoading,
                              customGradient: LinearGradient(
                                colors: [
                                  config.gradientStart,
                                  config.gradientEnd,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              trailingIcon: const Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: isLoading ? null : _submitOtp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
