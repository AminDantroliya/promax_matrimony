import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/constants.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';

class MaintenanceScreen extends ConsumerWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                customTextBoldStyle(
                  'maintenance_title'.tr.replaceAll('{appName}', appName),
                  17,
                  TextAlign.center,
                  Theme.of(context).colorScheme.onSurface,
                ),
                const Gap(16),
                Text(
                  'maintenance_message'.tr,
                  textAlign: TextAlign.center,
                  style: AppFont.font(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
                const Gap(30),
                AppPrimaryButton(label: 'btn_exit'.tr, onPressed: () => exit(0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
