import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../features/settings/data/repositories/settings_repository.dart';
import '../services/app_session_service.dart';
import '../utils/api_urls.dart';
import '../utils/app_debug.dart';
import '../utils/utils.dart';
import '../utils/application_data.dart';
import 'app_button.dart';

class LogoutBottomSheet extends ConsumerWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Gap(24),
            // Title
            customTextBoldStyle(
              'logout'.tr,
              20,
              TextAlign.start,
              theme.colorScheme.onSurface,
            ),
            const Gap(12),
            // Message
            customTextNormalStyle(
              'logout_message'.tr,
              15,
              TextAlign.start,
              theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const Gap(24),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    label: 'btn_cancel'.tr,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: AppPrimaryButton(
                    label: 'logout'.tr,
                    onPressed: () async {
                      showLoading(context);

                      try {
                        printLog("IS_FIREBASE_LOGIN ${FirebaseAuth.instance.currentUser?.phoneNumber != null ? "YES:(${FirebaseAuth.instance.currentUser?.phoneNumber})" : "NO"}");
                        if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
                          await FirebaseAuth.instance.signOut();
                        }

                        await ref.read(settingsRepositoryProvider).performAction(logoutApi, {});

                        await AppSessionService.clear();
                        ApplicationData.isMemberPaid = false;
                        ZegoUIKitPrebuiltCallInvitationService().uninit();
                        _getNewFirebaseToken();

                        if (context.mounted) {
                          hideLoading();
                          context.go('/intro');
                        }
                      } catch (e) {
                        if (context.mounted) hideLoading();
                        printLog("Logout error: $e");
                        if (context.mounted) context.go('/intro');
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

  void _getNewFirebaseToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      printLog('FIREBASE_TOKEN_DELETED_SUCCESSFULLY');
      final token = await FirebaseMessaging.instance.getToken();
      printLog('generatedToken : $token');
      AppSessionService.setValue(SessionDetail.kFcmToken, token);
    } catch (e) {
      printLog('FAILED_TO_DELETE_TOKEN : $e');
    }
  }
}

