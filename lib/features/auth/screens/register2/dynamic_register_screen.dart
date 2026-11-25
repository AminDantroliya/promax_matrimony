import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app_theme/app_font.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import '../../../../config/providers/config_providers.dart';
import '../../../../widgets/register_base_layout.dart';
import 'package:pro_matrimony/services/registration_token_holder.dart';
import 'models/dynamic_form_models.dart';
import 'providers/dynamic_register_notifier.dart';
import 'widgets/dynamic_section_renderer.dart';

class DynamicRegisterScreen extends ConsumerStatefulWidget {
  final int? initialStep;
  const DynamicRegisterScreen({super.key, this.initialStep});

  @override
  ConsumerState<DynamicRegisterScreen> createState() =>
      _DynamicRegisterScreenState();
}

class _DynamicRegisterScreenState extends ConsumerState<DynamicRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!RegistrationTokenHolder.hasToken) {
        ref.read(dynamicRegisterProvider.notifier).resetRegistration();
      } else {
        int? targetStep = widget.initialStep;
        if (targetStep == null) {
          final stepStr = AppSessionService.getValue('registerStep')?.toString();
          if (stepStr != null) {
            targetStep = int.tryParse(stepStr);
          }
        }
        if (targetStep != null && targetStep > 0) {
          ref.read(dynamicRegisterProvider.notifier).jumpToStep(targetStep);
        }
      }
    });
  }

  Future<void> _handleNext() async {
    if (_formKey.currentState == null) return;
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(dynamicRegisterProvider.notifier);
    await notifier.submitCurrentStep(context);
  }

  void _showStepSwitcherModal(
    BuildContext context,
    List<FormSection> sections,
    int currentIndex,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E2038) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Registration Steps',
                        style: AppFont.font(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1E2038),
                        ),
                      ),
                      Text(
                        'Tap any step to test or edit directly',
                        style: AppFont.font(
                          fontSize: 12,
                          color: isDark
                              ? Colors.white60
                              : const Color(0xFF8A90A6),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: sections.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final sec = sections[index];
                    final isCurrent = index == currentIndex;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                        ref
                            .read(dynamicRegisterProvider.notifier)
                            .jumpToStep(index);
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? theme.primaryColor.withValues(
                                  alpha: isDark ? 0.25 : 0.1,
                                )
                              : (isDark
                                    ? const Color(0xFF282B4B)
                                    : const Color(0xFFF8FAFC)),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isCurrent
                                ? theme.primaryColor
                                : (isDark
                                      ? Colors.white12
                                      : const Color(0xFFE2E8F0)),
                            width: isCurrent ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCurrent
                                    ? theme.primaryColor
                                    : (isDark
                                          ? Colors.white10
                                          : const Color(0xFFE2E8F0)),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: AppFont.font(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: isCurrent
                                        ? Colors.white
                                        : (isDark
                                              ? Colors.white70
                                              : const Color(0xFF64748B)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sec.title,
                                    style: AppFont.font(
                                      fontSize: 14,
                                      fontWeight: isCurrent
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: isCurrent
                                          ? theme.primaryColor
                                          : (isDark
                                                ? Colors.white
                                                : const Color(0xFF1E2038)),
                                    ),
                                  ),
                                  if (sec.subtitle.isNotEmpty)
                                    Text(
                                      sec.subtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFont.font(
                                        fontSize: 11,
                                        color: isDark
                                            ? Colors.white54
                                            : const Color(0xFF8A90A6),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (isCurrent)
                              Icon(
                                Icons.check_circle_rounded,
                                color: theme.primaryColor,
                                size: 20,
                              )
                            else
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 13,
                                color: isDark
                                    ? Colors.white30
                                    : const Color(0xFFCBD5E1),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dynamicRegisterProvider);
    final theme = Theme.of(context);

    if (state.isLoadingSchema) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ),
        ),
      );
    }

    final enableIdentityVerification = ref.watch(
      featureProvider('enableIdentityVerification'),
    );
    final rawSections = state.schema.sections;
    final sections = rawSections.where((sec) {
      if (sec.stepKey == 'id_proof' && !enableIdentityVerification) {
        return false;
      }
      return true;
    }).toList();
    if (sections.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No registration steps found',
            style: AppFont.font(fontSize: 16),
          ),
        ),
      );
    }

    final currentSection =
        sections[state.currentStepIndex.clamp(0, sections.length - 1)];
    final isStep1 =
        state.currentStepIndex == 0 ||
        currentSection.stepKey == 'basic_credentials';

    // Bottom Login Link Widget (only on Step 1)
    Widget? footerWidget;
    if (isStep1) {
      footerWidget = Column(
        children: [
          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'OR',
                  style: AppFont.font(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8A90A6),
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              InkWell(
                onTap: () {
                  ref
                      .read(dynamicRegisterProvider.notifier)
                      .resetRegistration();
                  context.go('/login');
                },
                child: Text(
                  'Login',
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    final canGoBack = state.currentStepIndex >= 2;

    return PopScope(
      canPop: state.currentStepIndex <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(dynamicRegisterProvider.notifier).resetRegistration();
          return;
        }
        if (!didPop && canGoBack) {
          ref.read(dynamicRegisterProvider.notifier).previousStep();
        }
      },
      child: RegisterBaseLayout(
        currentStep: state.currentStepIndex + 1,
        totalSteps: sections.length,
        title: currentSection.title,
        subtitle: currentSection.subtitle,
        isLoading: state.isSubmitting,
        showBackButton: canGoBack,
        onLeave: () =>
            ref.read(dynamicRegisterProvider.notifier).resetRegistration(),
        onBack: canGoBack
            ? () => ref.read(dynamicRegisterProvider.notifier).previousStep()
            : null,
        onStepBadgeTap: () =>
            _showStepSwitcherModal(context, sections, state.currentStepIndex),
        onNext: _handleNext,
        footer: footerWidget,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: DynamicSectionRenderer(
              key: ValueKey(currentSection.stepKey),
              section: currentSection,
            ),
          ),
        ),
      ),
    );
  }
}
