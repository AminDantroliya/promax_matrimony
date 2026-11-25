import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/glassmorphic_background.dart';
import '../providers/auth_notifier.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _forgotFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String? _emailError;
  bool _isSubmitting = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForgotPassword() async {
    if (_forgotFormKey.currentState!.validate()) {
      hideKeyboard(context);
      setState(() {
        _isSubmitting = true;
        _emailError = null;
      });

      try {
        final message = await ref
            .read(authProvider.notifier)
            .forgotPassword(emailController.text.trim());

        if (mounted) {
          showToast(message);
          context.pop();
        }
      } catch (error) {
        if (mounted) {
          showToast(error.toString());
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: GlassmorphicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _forgotFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Top Action Row (Back Button) ─────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF111827).withValues(
                                    alpha: isDarkMode ? 0.25 : 0.06,
                                  ),
                                  blurRadius: 24,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: config.primaryColor,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Gap(16),

                    // ── Central branded splash logo ──────────────────
                    Center(
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              AppAssets.figmaSmallCircle,
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                            Image.asset(
                              AppAssets.splashLogoPng,
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Gap(0),

                    // ── Headlines: Forgot Password ─────────────────────────────
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppFont.font(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(text: "${'forgot_password_title'.tr} "),
                          ],
                        ),
                      ),
                    ),

                    const Gap(8),

                    Center(
                      child: Text(
                        'forgot_password_message'.tr,
                        textAlign: TextAlign.center,
                        style: AppFont.font(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.6)
                              : const Color(0xFF8A90A6),
                        ),
                      ),
                    ),

                    const Gap(36),

                    // ── Floating design: Email input ─────────────────────────
                    // Text(
                    //   'email'.tr.toUpperCase(),
                    //   style: AppFont.font(
                    //     fontSize: 11,
                    //     fontWeight: FontWeight.w700,
                    //     letterSpacing: 1.5,
                    //     color: isDarkMode
                    //         ? Colors.white.withValues(alpha: 0.5)
                    //         : const Color(0xFF8A90A6),
                    //   ),
                    // ),
                    const Gap(8),
                    Container(
                      constraints: const BoxConstraints(minHeight: 64),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xFF161726) : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: _emailError != null
                              ? Colors.red.shade600
                              : (isDarkMode
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : const Color(0xFFEBEDF5)),
                          width: _emailError != null ? 1.5 : 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF101828).withValues(
                              alpha: isDarkMode ? 0.15 : 0.03,
                            ),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 22,
                          ),
                          hintText: 'enter_email'.tr,
                          hintStyle: AppFont.font(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8A90A6).withValues(alpha: 0.6),
                          ),
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                        ),
                        validator: (value) {
                          if (isNullFromBlankString(value)) {
                            if (_emailError != 'empty_email_error'.tr) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(() => _emailError = 'empty_email_error'.tr);
                                }
                              });
                            }
                            return '';
                          } else if (!emailValidatorRegExp.hasMatch(value!)) {
                            if (_emailError != 'invalid_email_error'.tr) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(() => _emailError = 'invalid_email_error'.tr);
                                }
                              });
                            }
                            return '';
                          }
                          if (_emailError != null) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                setState(() => _emailError = null);
                              }
                            });
                          }
                          return null;
                        },
                      ),
                    ),

                    if (_emailError != null) ...[
                      const Gap(6),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          _emailError!,
                          style: AppFont.font(
                            color: Colors.red.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],

                    const Gap(28),

                    // ── Action Button ────────────────────────────────────────
                    _isSubmitting
                        ? Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(config.buttonRadius),
                              color: config.primaryColor.withValues(alpha: 0.4),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(config.buttonRadius),
                              gradient: LinearGradient(
                                colors: [
                                  config.gradientStart,
                                  config.gradientEnd,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: config.primaryColor.withValues(alpha: 0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _submitForgotPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(config.buttonRadius),
                                ),
                              ),
                              child: Text(
                                'btn_submit'.tr,
                                style: AppFont.font(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                    const Gap(28),

                    // ── Or Continue With Divider ──────────────────────────────
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Divider(
                    //         color: isDarkMode
                    //             ? Colors.white.withValues(alpha: 0.08)
                    //             : const Color(0xFFE8ECEF),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 16),
                    //       child: Text(
                    //         'or_continue_with_text'.tr,
                    //         style: AppFont.font(
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w500,
                    //           color: isDarkMode
                    //               ? Colors.white.withValues(alpha: 0.4)
                    //               : const Color(0xFF8A90A6),
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Divider(
                    //         color: isDarkMode
                    //             ? Colors.white.withValues(alpha: 0.08)
                    //             : const Color(0xFFE8ECEF),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // const Gap(24),

                    // ── Login with OTP capsule button ────────────────────────
                    // Center(
                    //   child: InkWell(
                    //     onTap: () => context.push('/login-otp'),
                    //     borderRadius: BorderRadius.circular(28),
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: isDarkMode
                    //               ? Colors.white.withValues(alpha: 0.15)
                    //               : const Color(0xFFEBEDF5),
                    //         ),
                    //         borderRadius: BorderRadius.circular(28),
                    //       ),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Icon(
                    //             Icons.phone_android_rounded,
                    //             size: 18,
                    //             color: isDarkMode ? Colors.white70 : const Color(0xFF7342EB),
                    //           ),
                    //           const Gap(8),
                    //           Text(
                    //             'login_otp'.tr,
                    //             style: AppFont.font(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w700,
                    //               color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    // const Gap(28),

                    // ── Sign Up footer link ──────────────────────────────────
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () => context.push('/register'),
                    //     child: RichText(
                    //       textAlign: TextAlign.center,
                    //       text: TextSpan(
                    //         children: [
                    //           TextSpan(
                    //             text: "${'don_t_have_an_account'.tr} ",
                    //             style: AppFont.font(
                    //               color: isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 13,
                    //             ),
                    //           ),
                    //           TextSpan(
                    //             text: 'register'.tr,
                    //             style: AppFont.font(
                    //               color: const Color(0xFF7342EB),
                    //               fontWeight: FontWeight.w600,
                    //               fontSize: 13,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
