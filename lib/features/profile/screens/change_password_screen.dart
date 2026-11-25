import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';

import '../../auth/providers/change_password_notifier.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _oldVisible = true;
  bool _newVisible = true;
  bool _confirmVisible = true;

  @override
  void dispose() {
    _oldPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = ref.watch(changePasswordProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(changePasswordProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous?.isLoading == true) {
            showToast('password_changed_success'.tr);
            context.pop();
          }
        },
        error: (error, stack) {
          showToast('Error: $error');
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative background circles
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? colorPrimary.withValues(alpha: 0.08)
                      : colorPrimary.withValues(alpha: 0.03),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -120,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? colorPrimary.withValues(alpha: 0.06)
                      : colorPrimary.withValues(alpha: 0.03),
                ),
              ),
            ),

            // Content
            Column(
              children: [
                AppAppBar(title: 'change_password'.tr, isShowActions: false),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(16),

                          // Illustration Lock/Shield Icon (Dynamic vector design matching Figma mockup)
                          Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    gradient: FigmaColors.primaryGradient(context),
                                    borderRadius: BorderRadius.circular(28),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.white,
                                      size: 44,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -2,
                                  right: -2,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF22C55E),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark
                                            ? premiumScreenBgDark
                                            : Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(24),

                          // Header titles below illustration (Serif styling matching Figma)
                          Text(
                            'reset_your_password'.tr,
                            style: AppFont.font(
                              color: isDark ? Colors.white : premiumDarkText,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(6),
                          Text(
                            'need_current_password_sub'.tr,
                            style: AppFont.font(
                              color: isDark ? Colors.white30 : premiumSubtitle,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(32),

                          // Form Input Fields
                          _buildFigmaPasswordField(
                            label: 'old_password'.tr,
                            controller: _oldPassCtrl,
                            obscure: _oldVisible,
                            onToggle: () =>
                                setState(() => _oldVisible = !_oldVisible),
                            prefixIcon: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.08)
                                    : const Color(0xFFF1F3FB),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.lock_outline_rounded,
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF8D94AB),
                                size: 20,
                              ),
                            ),
                            validator: (v) {
                              if (isNullFromBlankString(v))
                                return 'empty_old_password_error'.tr;
                              if (v!.trim() == _newPassCtrl.text.trim()) {
                                return 'old_new_password_must_differ'.tr;
                              }
                              return null;
                            },
                            isDark: isDark,
                          ),
                          const Gap(16),

                          _buildFigmaPasswordField(
                            label: 'new_password'.tr,
                            controller: _newPassCtrl,
                            obscure: _newVisible,
                            onToggle: () =>
                                setState(() => _newVisible = !_newVisible),
                            prefixIcon: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: FigmaColors.primaryGradient(context),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.vpn_key_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            validator: (v) {
                              if (isNullFromBlankString(v))
                                return 'empty_new_password_error'.tr;
                              if (v!.trim() == _oldPassCtrl.text.trim()) {
                                return 'old_new_password_must_differ'.tr;
                              }
                              return null;
                            },
                            isDark: isDark,
                          ),
                          const Gap(16),

                          _buildFigmaPasswordField(
                            label: 'confirm_password'.tr,
                            controller: _confirmPassCtrl,
                            obscure: _confirmVisible,
                            onToggle: () => setState(
                              () => _confirmVisible = !_confirmVisible,
                            ),
                            prefixIcon: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.08)
                                    : const Color(0xFFF1F3FB),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.shield_outlined,
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF8D94AB),
                                size: 20,
                              ),
                            ),
                            validator: (v) {
                              if (isNullFromBlankString(v))
                                return 'empty_confirm_password_error'.tr;
                              if (v!.trim() != _newPassCtrl.text.trim()) {
                                return 'not_matched_password_error'.tr;
                              }
                              return null;
                            },
                            isDark: isDark,
                          ),
                          const Gap(40),

                          // Submit Action
                          changePasswordState.maybeWhen(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            orElse: () => _buildSaveButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  hideKeyboard(context);
                                  ref
                                      .read(changePasswordProvider.notifier)
                                      .changePassword(
                                        oldPassword: _oldPassCtrl.text.trim(),
                                        newPassword: _newPassCtrl.text.trim(),
                                        confirmPassword: _confirmPassCtrl.text
                                            .trim(),
                                      );
                                }
                              },
                              isDark: isDark,
                            ),
                          ),
                          const Gap(24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 8),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: isDark ? Colors.white : Colors.black87,
                size: 20,
              ),
            ),
          ),
          const Gap(14),
          // Title text (Left aligned)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppTitleWidget(context, "change_password".tr),
                const Gap(4),
                Text(
                  'control_who_can_see_you_sub'.tr,
                  style: AppFont.font(
                    color: isDark ? Colors.white30 : premiumSubtitle,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFigmaPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    required Widget prefixIcon,
    required String? Function(String?) validator,
    required bool isDark,
  }) {
    final config = ref.watch(appConfigProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: AppInputFieldStyle.buildContainerDecoration(
        context: context,
        config: config,
      ),
      child: Row(
        children: [
          // Left Icon Box
          prefixIcon,
          const Gap(14),
          // TextFormField Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label.toUpperCase(),
                  style: AppFont.font(
                    color: isDark ? Colors.white30 : premiumSubtitle,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                TextFormField(
                  controller: controller,
                  obscureText: obscure,
                  obscuringCharacter: '•',
                  validator: validator,
                  style: AppFont.font(
                    color: isDark ? Colors.white : premiumDarkText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          // Suffix Icon Circular Toggle
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFF1F3FB),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: isDark ? Colors.white60 : const Color(0xFF8D94AB),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton({
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return FigmaPrimaryButton(
      text: 'save_password'.tr,
      onPressed: onPressed,
      leadingIcon: const Icon(Icons.shield_outlined, color: Colors.white, size: 20),
    );
  }
}
