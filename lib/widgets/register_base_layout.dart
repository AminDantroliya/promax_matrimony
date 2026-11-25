import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../config/app_config.dart';
import '../utils/utils.dart';
import '../utils/app_dialogs.dart';
import 'app_common_background.dart';

// Represents the 1-based step index directly (1–9)
int _stepIndex(int currentStep) {
  return currentStep;
}

class RegisterBaseLayout extends ConsumerWidget {
  final Widget child;
  final Widget? footer;
  final int currentStep;
  final int totalSteps;
  final String title;
  final String subtitle;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final VoidCallback? onStepBadgeTap;
  final VoidCallback? onLeave;
  final bool isLoading;
  final bool showExitPopup;
  final bool? showBackButton;

  const RegisterBaseLayout({
    super.key,
    required this.child,
    this.footer,
    required this.currentStep,
    this.totalSteps = 11,
    required this.title,
    required this.subtitle,
    this.onNext,
    this.onBack,
    this.onStepBadgeTap,
    this.onLeave,
    this.isLoading = false,
    this.showExitPopup = true,
    this.showBackButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final config = ref.watch(appConfigProvider);
    final stepIdx = _stepIndex(currentStep);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (onBack != null) {
          onBack!();
        } else if (showExitPopup) {
          _showExitDialog(context, theme, config);
        } else {
          onLeave?.call();
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: AppCommonBackground(
          child: SafeArea(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Navigation Row (fixed back button pill + STEP badge) ───
              _buildTopNavRow(context, theme, config, stepIdx),

              const Gap(8),

              // ── Title Section (Title only below appbar) ────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildFigmaTitle(title, theme),
              ),

              const Gap(16),

              // ── Main Content Container (Buttons inside scroll to avoid keyboard overlap) ──
              Expanded(
                child: SingleChildScrollView(
                  key: ValueKey('register_step_scroll_$stepIdx'),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      child,
                      const Gap(24),
                      _buildNavButtons(context, stepIdx, theme, config),
                      if (footer != null) ...[
                        const Gap(16),
                        footer!,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  // ── TOP NAV ROW (Pill Back Button + STEP Badge Capsule) ───────────────────
  Widget _buildTopNavRow(BuildContext context, ThemeData theme, AppConfig config, int stepIdx) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button pill capsule
          InkWell(
            onTap: onBack ?? () {
              if (showExitPopup) {
                _showExitDialog(context, theme, config);
              } else {
                onLeave?.call();
                context.pop();
              }
            },
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'back_word'.tr,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF16182F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right: STEP Pill Badge Capsule (e.g. STEP 3 · OF 7)
          InkWell(
            //onTap: onStepBadgeTap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: theme.primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'STEP $stepIdx · OF $totalSteps',
                    style: AppFont.font(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: theme.primaryColor,
                      letterSpacing: 1.0,
                    ),
                  ),
                  if (onStepBadgeTap != null) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 16,
                      color: theme.primaryColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── SPLIT-COLOR TITLE BUILDER ──────────────────────────────────────────────
  Widget _buildFigmaTitle(String title, ThemeData theme) {
    final words = title.split(' ');
    if (words.isEmpty) return const SizedBox.shrink();

    final lastWord = words.last;
    final previousWords = words.length > 1
        ? '${words.sublist(0, words.length - 1).join(' ')} '
        : '';

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: previousWords,
            style: AppFont.font(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF16182F),
              height: 1.3,
            ),
          ),
          TextSpan(
            text: lastWord,
            style: AppFont.font(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: theme.primaryColor,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAVIGATION BUTTONS ──────────────────────────────────────────────
  Widget _buildNavButtons(BuildContext context, int stepIdx, ThemeData theme, AppConfig config) {
    final shouldShowBack = showBackButton ?? (stepIdx > 2);
    final isLastStep = stepIdx == totalSteps;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          if (shouldShowBack) ...[
            Expanded(
              child: _outlinedButton(
                label: 'Previous',
                onTap: onBack ?? () => context.pop(),
                theme: theme,
                config: config,
              ),
            ),
            const Gap(12),
          ],
          Expanded(
            child: _filledButton(
              label: isLastStep
                  ? 'Submit'
                  : ((title.toLowerCase().contains('id') || title.toLowerCase().contains('verification'))
                      ? 'Verify Now'
                      : 'Continue'),
              showVerifyIcon: title.toLowerCase().contains('id') || title.toLowerCase().contains('verification'),
              onTap: isLoading ? null : onNext,
              isLoading: isLoading,
              theme: theme,
              config: config,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filledButton({
    required String label,
    bool showVerifyIcon = false,
    VoidCallback? onTap,
    bool isLoading = false,
    required ThemeData theme,
    required AppConfig config,
  }) {
    final isEnabled = onTap != null;

    return Container(
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(config.buttonRadius),
        gradient: isEnabled
            ? LinearGradient(
                colors: [config.gradientStart, config.gradientEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isEnabled
            ? null
            : theme.primaryColor.withValues(alpha: 0.3),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: config.gradientEnd.withValues(alpha: 0.4),
                  blurRadius: 34,
                  offset: const Offset(0, 14),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(config.buttonRadius),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      if (showVerifyIcon) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _outlinedButton({
    required String label,
    required VoidCallback onTap,
    required ThemeData theme,
    required AppConfig config,
  }) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(config.buttonRadius),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(config.buttonRadius),
          child: Center(
            child: Text(
              label,
              style: AppFont.font(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF16182F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── EXIT DIALOG ──────────────────────────────────────────────────────────
  void _showExitDialog(BuildContext context, ThemeData theme, AppConfig config) async {
    final leave = await AppDialogs.confirm(
      context,
      title: 'confirm_exit'.tr,
      message: 'confirm_exit_message'.tr,
      cancelLabel: 'btn_cancel'.tr,
      confirmLabel: 'btn_leave'.tr,
      gradientColors: [config.gradientStart, config.gradientEnd],
    );
    if (leave && context.mounted) {
      onLeave?.call();
      context.go('/login');
    }
  }
}
