import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../app_theme/size_config.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/app_button.dart';
import 'register2/providers/dynamic_register_notifier.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final resolvedAppName = ref.watch(appConfigProvider).appName;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0B0C12), Color(0xFF161726)],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF5F7), Color(0xFFFFF0F3)],
                ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(SizeConfig.screenHeight! * 0.02),
                  // Luxurious Onboarding / Welcome Lounge Glass Frame
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    height: SizeConfig.screenHeight! * 0.4,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.white,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.black.withValues(alpha: 0.3)
                              : theme.primaryColor.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssets.welcomePng,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Gap(getProportionateScreenWidth(30)),
                  // Beautiful Headline with Pink highlight
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'welcome_title'.tr.replaceFirst('@appName', resolvedAppName),
                      textAlign: TextAlign.center,
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: getProportionateScreenWidth(26),
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                          letterSpacing: -0.5,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  Gap(getProportionateScreenWidth(15)),
                  // Sub-text descriptions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: customTextNormalStyle(
                      'welcome_message'.tr,
                      getProportionateScreenWidth(14),
                      TextAlign.center,
                      theme.colorScheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const Spacer(),
                  // Premium Interactive Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // Primary Action: Register / Create Account
                        AppPrimaryButton(
                          label: 'create_account'.tr,
                          onPressed: () {
                            ref
                                .read(dynamicRegisterProvider.notifier)
                                .resetRegistration();
                            context.push('/register');
                          },
                        ),
                        Gap(getProportionateScreenWidth(15)),
                        // Secondary Action: Login Outline button
                        AppSecondaryButton(
                          label: 'login'.tr,
                          onPressed: () => context.push('/login'),
                        ),
                      ],
                    ),
                  ),
                  Gap(SizeConfig.screenHeight! * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
