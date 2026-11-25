// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
//
// ForceUpdateGuard — wraps the root widget tree and intercepts navigation
// when the backend signals that a force (or soft) update is required.
//
// Placement in widget tree:
//   MaintenanceGuard → ForceUpdateGuard → GoRouter child
//
// Rules:
//   • isForceUpdate = true  → hard block, WillPopScope prevents back navigation
//   • isForceUpdate = false → soft dialog with "Later" dismiss option
//   • All text uses localisation keys from ForceUpdateConfig — never raw strings
//   • Store URL comes from FlavorConfig (via AppConfig), platform-aware

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';

import '../../config/app_config.dart';

// ---------------------------------------------------------------------------
// Version comparison helper
// ---------------------------------------------------------------------------

/// Returns true if [current] is strictly lower than [minimum].
/// Compares semver segments: major.minor.patch
bool _isVersionLower(String current, String minimum) {
  List<int> parse(String v) =>
      v.split('.').map((s) => int.tryParse(s) ?? 0).toList();

  final c = parse(current);
  final m = parse(minimum);

  for (int i = 0; i < 3; i++) {
    final cv = i < c.length ? c[i] : 0;
    final mv = i < m.length ? m[i] : 0;
    if (cv < mv) return true;
    if (cv > mv) return false;
  }
  return false; // equal — no update needed
}

// ---------------------------------------------------------------------------
// ForceUpdateGuard
// ---------------------------------------------------------------------------

class ForceUpdateGuard extends ConsumerWidget {
  final Widget child;
  const ForceUpdateGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceUpdate = ref.watch(forceUpdateProvider);

    // No force-update config from backend → pass through
    if (forceUpdate == null) return child;

    final versionAsync = ref.watch(appVersionProvider);

    return versionAsync.when(
      loading: () => child, // still loading version info → show app normally
      error: (err, stack) => child, // can't read version → don't block the user
      data: (currentVersion) {
        final needsUpdate = _isVersionLower(currentVersion, forceUpdate.minVersion);
        if (!needsUpdate) return child;

        if (forceUpdate.isForceUpdate) {
          // Hard block — no back, no dismiss
          return _ForceUpdateScreen(config: forceUpdate, isHard: true);
        } else {
          // Soft: show the app but present a dismissible update dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showSoftUpdateDialog(context, ref, forceUpdate);
          });
          return child;
        }
      },
    );
  }

  static void _showSoftUpdateDialog(
    BuildContext context,
    WidgetRef ref,
    ForceUpdateConfig config,
  ) async {
    final appConfig = ref.read(appConfigProvider);
    final confirmed = await AppDialogs.confirm(
      context,
      title: config.titleKey.tr,
      message: config.messageKey.tr,
      cancelLabel: 'btn_skip'.tr,
      confirmLabel: 'btn_update_now'.tr,
    );
    if (confirmed) {
      _launchStore(
        androidUrl: appConfig.playStoreUrl,
        iosUrl: appConfig.appStoreUrl,
      );
    }
  }
}

// ---------------------------------------------------------------------------
// _ForceUpdateScreen (hard block — embedded directly, not navigated to)
// ---------------------------------------------------------------------------

class _ForceUpdateScreen extends ConsumerWidget {
  final ForceUpdateConfig config;
  final bool isHard;

  const _ForceUpdateScreen({required this.config, required this.isHard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigProvider);
    final theme = Theme.of(context);

    return PopScope(
      canPop: !isHard, // prevents back navigation when hard update
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppAssets.appUpdate,
                    height: getProportionateScreenWidth(200),
                    width: getProportionateScreenWidth(200),
                  ),
                  // Title — uses localisation key from ForceUpdateConfig
                  customTextBoldStyle(
                    config.titleKey.trParams({'appName': appConfig.appName}),
                    17,
                    TextAlign.center,
                    theme.colorScheme.onSurface,
                  ),
                  const Gap(16),
                  // Message — uses localisation key from ForceUpdateConfig
                  Text(
                    config.messageKey.tr,
                    textAlign: TextAlign.center,
                    style: AppFont.font(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  const Gap(30),
                  // "Update Now" — existing localisation key
                  AppPrimaryButton(
                    label: 'btn_update_now'.tr,
                    onPressed: () => _launchStore(
                      androidUrl: appConfig.playStoreUrl,
                      iosUrl: appConfig.appStoreUrl,
                    ),
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

// ---------------------------------------------------------------------------
// Store launcher helper
// ---------------------------------------------------------------------------

Future<void> _launchStore({
  required String androidUrl,
  required String iosUrl,
}) async {
  final url = Platform.isIOS ? iosUrl : androidUrl;
  if (url.isEmpty) return;
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } on PlatformException {
    // Fallback: open in browser
    final webUrl = Platform.isAndroid && androidUrl.contains('market://')
        ? androidUrl.replaceFirst(
            'market://',
            'https://play.google.com/store/apps/',
          )
        : url;
    await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
  }
}
