import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:pinput/pinput.dart';

import '../../../../services/app_session_service.dart';
import '../../../../services/firebase_phone_auth_service.dart';
import '../../../../utils/app_debug.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/app_button.dart';
import '../../profile/providers/profile_notifier.dart';

import '../providers/dashboard_notifier.dart';

class VerifyMobileDialog extends ConsumerStatefulWidget {
  final String phoneNumber;

  const VerifyMobileDialog({super.key, required this.phoneNumber});

  @override
  ConsumerState<VerifyMobileDialog> createState() => _VerifyMobileDialogState();
}

class _VerifyMobileDialogState extends ConsumerState<VerifyMobileDialog> {
  int endTime = 0;
  bool isOtpSent = false;
  String? currentVerificationId;
  int? currentResendToken;
  final TextEditingController otpController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> verifyOtpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otpController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String otpMethod = AppSessionService.getValue('otp_login_method') ?? 'firebase';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? Colors.white38 : Colors.black38;

    final defaultPinTheme = PinTheme(
      width: 45,
      height: 48,
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? const Color(0xFF1E1E2D) : Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: appPrimaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isOtpSent
                    ? Icons.sms_outlined
                    : Icons.phone_android_rounded,
                size: 38,
                color: appPrimaryColor,
              ),
            ),
            const Gap(18),
            Text(
              isOtpSent ? 'verify_your_otp'.tr : 'verify_your_mobile'.tr,
              style: AppFont.font(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Gap(10),
            if (!isOtpSent)
              _buildPhoneInput(isDark,otpMethod)
            else
              _buildOtpInput(isDark, defaultPinTheme, borderColor,otpMethod),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput(bool isDark , String otpMethod) {
    return Column(
      children: [
        if (widget.phoneNumber.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.phone_iphone_rounded,
                  size: 20,
                  color: appPrimaryColor,
                ),
                const Gap(8),
                Text(
                  widget.phoneNumber,
                  style: AppFont.font(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
        ],
        Text(
          'verify_otp_subtitle'.tr,
          textAlign: TextAlign.center,
          style: AppFont.font(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Gap(24),
        Row(
          children: [
            Expanded(
              child: AppSecondaryButton(
                label: 'btn_cancel'.tr,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Gap(15),
            Expanded(
              child: AppPrimaryButton(
                label: 'generate_otp'.tr,
                onPressed: () async {
                  showLoading(context);
                  if (otpMethod == 'firebase') {
                    try {
                      await FirebasePhoneAuthService.sendOtp(
                        phoneNumber: widget.phoneNumber,
                        forceResendingToken: currentResendToken,
                        onCodeSent: (verificationId, resendToken) {
                          hideLoading();
                          showToast('otp_resent_successfully'.tr);
                          setState(() {
                            currentVerificationId = verificationId;
                            currentResendToken = resendToken;
                            endTime =
                                DateTime.now().millisecondsSinceEpoch + 1000 * 60;
                            isOtpSent = true;
                          });
                        },
                        onVerificationCompleted: (credential) {
                          hideLoading();
                        },
                        onVerificationFailed: (e) {
                          hideLoading();
                          showToast(e.message ?? 'error_generating_otp'.tr);
                        },
                        onCodeAutoRetrievalTimeout: (vId) {
                          hideLoading();
                        },
                      );
                    } catch (e) {
                      hideLoading();
                      showToast(e.toString());
                    }
                  } else {
                    try {
                      final res = await ref
                          .read(myProfileProvider.notifier)
                          .generateMobileOtp();
                      hideLoading();
                      final isSuccess = res.status.toLowerCase() == "success" ||
                          res.status == "1" ||
                          res.status.toLowerCase() == "true";
                      if (isSuccess) {
                        showToast(res.message.isNotEmpty
                            ? res.message
                            : 'otp_resent_successfully'.tr);
                        setState(() {
                          endTime =
                              DateTime.now().millisecondsSinceEpoch + 1000 * 60;
                          isOtpSent = true;
                        });
                      } else {
                        showToast(res.message.isNotEmpty
                            ? res.message
                            : 'error_generating_otp'.tr);
                      }
                    } catch (e) {
                      hideLoading();
                      showToast(e.toString());
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtpInput(
    bool isDark,
    PinTheme defaultPinTheme,
    Color borderColor,
    String otpMethod
  ) {
    return Column(
      children: [
        Text(
          'enter_otp'.tr,
          textAlign: TextAlign.center,
          style: AppFont.font(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Gap(16),
        Form(
          key: verifyOtpFormKey,
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
                separatorBuilder: (index) => const SizedBox(width: 6),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'empty_field_error'.tr;
                  if (value.length != 6) return 'invalid_otp_error'.tr;
                  return null;
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: appPrimaryColor, width: 1.5),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(14),
        CountdownTimer(
          endTime: endTime,
          widgetBuilder: (context, time) {
            if (time == null) {
              return TextButton(
                onPressed: () async {
                  showLoading(context);
                  if (otpMethod == 'firebase') {
                    try {
                      await FirebasePhoneAuthService.sendOtp(
                        phoneNumber: widget.phoneNumber,
                        forceResendingToken: currentResendToken,
                        onCodeSent: (verificationId, resendToken) {
                          hideLoading();
                          showToast('otp_resent_successfully'.tr);
                          setState(() {
                            currentVerificationId = verificationId;
                            currentResendToken = resendToken;
                            otpController.clear();
                            endTime =
                                DateTime.now().millisecondsSinceEpoch + 1000 * 60;
                          });
                        },
                        onVerificationCompleted: (credential) {
                          hideLoading();
                        },
                        onVerificationFailed: (e) {
                          hideLoading();
                          showToast(e.message ?? 'error_resending_otp'.tr);
                        },
                        onCodeAutoRetrievalTimeout: (vId) {
                          hideLoading();
                        },
                      );
                    } catch (e) {
                      hideLoading();
                      showToast(e.toString());
                    }
                  } else {
                    try {
                      final res = await ref
                          .read(myProfileProvider.notifier)
                          .resendMobileOtp();
                      hideLoading();
                      final isSuccess = res.status.toLowerCase() == "success" ||
                          res.status == "1" ||
                          res.status.toLowerCase() == "true";
                      if (isSuccess) {
                        showToast(res.message.isNotEmpty
                            ? res.message
                            : 'otp_resent_successfully'.tr);
                        setState(() {
                          otpController.clear();
                          endTime =
                              DateTime.now().millisecondsSinceEpoch + 1000 * 60;
                        });
                      } else {
                        showToast(res.message.isNotEmpty
                            ? res.message
                            : 'error_resending_otp'.tr);
                      }
                    } catch (e) {
                      hideLoading();
                      showToast(e.toString());
                    }
                  }
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'not_received'.tr,
                        style: AppFont.font(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: 'resend'.tr,
                        style: AppFont.font(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return customTextBoldStyle(
              "00 : ${time.sec.toString().padLeft(2, '0')}",
              16,
              TextAlign.center,
              borderColor,
            );
          },
        ),
        const Gap(20),
        Row(
          children: [
            Expanded(
              child: AppSecondaryButton(
                label: 'btn_cancel'.tr,
                onPressed: () {
                  setState(() => isOtpSent = false);
                },
              ),
            ),
            const Gap(15),
            Expanded(
              child: AppPrimaryButton(
                label: 'btn_verify'.tr,
                onPressed: () async {
                  if (!verifyOtpFormKey.currentState!.validate()) return;
                  hideKeyboard(context);
                  String? firebaseToken;

                  if (otpMethod == 'firebase') {
                    if (currentVerificationId != null &&
                        currentVerificationId!.isNotEmpty) {
                      try {
                        showLoading(context);
                        final userCredential =
                            await FirebasePhoneAuthService.signInWithSmsCode(
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

                  showLoading(context);
                  try {
                    final res = await ref
                        .read(myProfileProvider.notifier)
                        .verifyMobileOtp(
                          otpController.text.trim(),
                          firebaseToken: firebaseToken,
                        );
                    hideLoading();
                    final isSuccess = res.status.toLowerCase() == "success" ||
                        res.status == "1" ||
                        res.status.toLowerCase() == "true";
                    if (isSuccess) {
                      showToast(res.message.isNotEmpty
                          ? res.message
                          : 'mobile_verified_successfully'.tr);
                      ref.read(dashboardProvider.notifier).refresh();
                      if (mounted) Navigator.pop(context);
                    } else {
                      showToast(res.message.isNotEmpty
                          ? res.message
                          : 'invalid_otp'.tr);
                    }
                  } catch (e) {
                    hideLoading();
                    showToast(e.toString());
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EmailVerificationDialog extends ConsumerWidget {
  const EmailVerificationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? const Color(0xFF1E1E2D) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: appPrimaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_unread_rounded,
                size: 40,
                color: appPrimaryColor,
              ),
            ),
            const Gap(20),
            Text(
              'verify_your_email'.tr,
              style: AppFont.font(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Gap(10),
            Text(
              'verify_your_email_message'.tr,
              textAlign: TextAlign.center,
              style: AppFont.font(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(label: 'btn_cancel'.tr, onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: AppPrimaryButton(label: 'btn_confirm'.tr, onPressed: () async {
                      showLoading(context);
                      try {
                        final res = await ref.read(myProfileProvider.notifier).verifyEmail();
                        hideLoading();
                        if (res.message.isNotEmpty) {
                          showToast(res.message);
                        } else {
                          showToast('verification_email_sent'.tr);
                        }
                        if (context.mounted) Navigator.pop(context);
                      } catch (e) {
                        hideLoading();
                        showToast(e.toString());
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PendingProfileDialog extends ConsumerWidget {
  const PendingProfileDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
              size: 40,
            ),
            const Gap(10),
            customTextBoldStyle(
              'pending_verification'.tr,
              16,
              TextAlign.center,
              Theme.of(context).colorScheme.onSurface,
            ),
            const Gap(10),
            customTextNormalStyle(
              'under_review_text'.tr,
              14,
              TextAlign.center,
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const Gap(25),
            SizedBox(
              width: double.infinity,
              child: AppSecondaryButton(label: 'okay'.tr, onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRemainingTime {
  final int? sec;
  CustomRemainingTime({this.sec});
}

class CountdownTimer extends StatefulWidget {
  final int endTime;
  final Widget Function(BuildContext, CustomRemainingTime?) widgetBuilder;

  const CountdownTimer({
    super.key,
    required this.endTime,
    required this.widgetBuilder,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endTime != widget.endTime) {
      _timer?.cancel();
      _calculateRemainingTime();
      _startTimer();
    }
  }

  void _calculateRemainingTime() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = widget.endTime - now;
    _secondsRemaining = diff > 0 ? (diff / 1000).round() : 0;
  }

  void _startTimer() {
    if (_secondsRemaining <= 0) return;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_secondsRemaining <= 0) {
      return widget.widgetBuilder(context, null);
    }
    return widget.widgetBuilder(context, CustomRemainingTime(sec: _secondsRemaining));
  }
}
