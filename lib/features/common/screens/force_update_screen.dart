import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/constants.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateScreen extends ConsumerWidget {
  const ForceUpdateScreen({super.key});

  Future<void> _openStore() async {
    const appStoreId = ''; // Need to provide actual App Store ID if available
    try {
      if (Platform.isAndroid) {
        await launchUrl(
          Uri.parse("market://details?id=$packageName"),
          mode: LaunchMode.externalApplication,
        );
      } else if (Platform.isIOS) {
        await launchUrl(
          Uri.parse("https://apps.apple.com/us/app/$appStoreId"),
          mode: LaunchMode.externalApplication,
        );
      }
    } on PlatformException {
      if (Platform.isAndroid) {
        await launchUrl(
          Uri.parse("https://play.google.com/store/apps/details?id=$packageName"),
          mode: LaunchMode.externalApplication,
        );
      } else if (Platform.isIOS) {
        await launchUrl(
          Uri.parse("https://apps.apple.com/us/app/$appStoreId"),
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppAssets.appUpdate,
                    height: getProportionateScreenWidth(200),
                    width: getProportionateScreenWidth(200)),
                customTextBoldStyle(
                  'force_update_message'.trParams({'appName': appName}),
                  17,
                  TextAlign.center,
                  theme.colorScheme.onSurface,
                ),
                const Gap(16),
                Text(
                  'force_update_sub_message'.tr,
                  textAlign: TextAlign.center,
                  style: AppFont.font(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
                const Gap(16),
                customTextBoldStyle(
                  'force_update_sub_message_2'.tr,
                  14,
                  TextAlign.center,
                  theme.colorScheme.onSurface,
                ),
                const Gap(30),
                AppPrimaryButton(label: 'btn_update_now'.tr, onPressed: _openStore),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
