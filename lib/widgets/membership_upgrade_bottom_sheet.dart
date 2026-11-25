import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import '../utils/utils.dart';
import 'app_button.dart';

class MembershipUpgradeBottomSheet extends StatelessWidget {
  final String message;

  const MembershipUpgradeBottomSheet({super.key, required this.message});

  static Future<void> show(BuildContext context, String message) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) => MembershipUpgradeBottomSheet(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              'upgrade_your_membership'.tr,
              20,
              TextAlign.start,
              theme.colorScheme.onSurface,
            ),
            const Gap(12),
            // Message
            customTextNormalStyle(
              message.isNotEmpty ? message : 'upgrade_your_membership_message'.tr,
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
                    label: 'upgrade_now'.tr,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.push('/plans');
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
}
