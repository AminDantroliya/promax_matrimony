// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
//
// MaintenanceGuard — wraps the root widget tree and shows a full-screen
// maintenance UI when the backend sets isMaintenanceMode = true.
//
// Placement in widget tree:
//   MaintenanceGuard → ForceUpdateGuard → GoRouter child
//
// Rules:
//   • MaintenanceScreen uses the localisation KEY from AppConfig.maintenanceMsgKey
//   • All text — title, message, button — uses existing localisation keys
//   • No raw strings are ever displayed
//   • Exit button terminates the app (user cannot bypass maintenance mode)

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';


// ---------------------------------------------------------------------------
// MaintenanceGuard
// ---------------------------------------------------------------------------

class MaintenanceGuard extends ConsumerWidget {
  final Widget child;
  const MaintenanceGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);

    if (!config.isMaintenanceMode) return child;

    return _MaintenanceScreen(msgKey: config.maintenanceMsgKey);
  }
}

// ---------------------------------------------------------------------------
// _MaintenanceScreen — full-screen, no back navigation
// ---------------------------------------------------------------------------

class _MaintenanceScreen extends ConsumerWidget {
  /// Localisation KEY — the widget calls msgKey.tr to resolve the text.
  /// Backend sends the key, not the text itself.
  final String msgKey;

  const _MaintenanceScreen({required this.msgKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigProvider);
    final theme = Theme.of(context);

    return PopScope(
      canPop: false, // No back button during maintenance
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(200),
                    width: getProportionateScreenHeight(200),
                    child: Lottie.asset(AppAssets.maintenance),
                  ),
                  // Title — uses existing 'maintenance_title' localisation key
                  customTextBoldStyle(
                    'maintenance_title'.trParams({'appName': appConfig.appName}),
                    17,
                    TextAlign.center,
                    theme.colorScheme.onSurface,
                  ),
                  const Gap(16),
                  // Message — resolves the backend-supplied localisation KEY
                  Text(
                    msgKey.tr,
                    textAlign: TextAlign.center,
                    style: AppFont.font(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  const Gap(30),
                  // Exit — 'btn_exit' is an existing localisation key
                  AppPrimaryButton(
                    label: 'btn_exit'.tr,
                    onPressed: () => exit(0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
