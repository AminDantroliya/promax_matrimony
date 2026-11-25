import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/utils.dart';
import 'app_button.dart';

class DisplayOverOtherAppsBottomSheet extends StatelessWidget {
  const DisplayOverOtherAppsBottomSheet({super.key});

  /// Displays the bottom sheet.
  /// Returns `true` if the user opted to "Open Settings", or `false` if dismissed / "Maybe Later".
  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) => const DisplayOverOtherAppsBottomSheet(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Drag Handle ──────────────────────────────────────────────
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Gap(20),

            // ── Header Icon with Soft Glow ───────────────────────────────
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withValues(alpha: isDark ? 0.25 : 0.15),
                      primaryColor.withValues(alpha: isDark ? 0.1 : 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.phone_in_talk_rounded,
                    size: 34,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            const Gap(20),

            // ── Title ────────────────────────────────────────────────────
            Center(
              child: Text(
                'enable_display_over_other_apps_title'.tr.isNotEmpty &&
                        'enable_display_over_other_apps_title'.tr !=
                            'enable_display_over_other_apps_title'
                    ? 'enable_display_over_other_apps_title'.tr
                    : 'Allow "Display Over Other Apps"',
                textAlign: TextAlign.center,
                style: AppFont.font(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const Gap(10),

            // ── Description ──────────────────────────────────────────────
            Center(
              child: Text(
                'enable_display_over_other_apps_desc'.tr.isNotEmpty &&
                        'enable_display_over_other_apps_desc'.tr !=
                            'enable_display_over_other_apps_desc'
                    ? 'enable_display_over_other_apps_desc'.tr
                    : 'To receive incoming voice and video calls when your screen is locked or while using other apps, please allow "Display over other apps" in device settings.',
                textAlign: TextAlign.center,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            const Gap(22),

            // ── Feature Highlights ───────────────────────────────────────
            _buildFeatureTile(
              context,
              icon: Icons.notifications_active_rounded,
              iconBgColor: const Color(0xFF22C55E).withValues(alpha: 0.12),
              iconColor: const Color(0xFF22C55E),
              title: 'incoming_call_popups'.tr.isNotEmpty &&
                      'incoming_call_popups'.tr != 'incoming_call_popups'
                  ? 'incoming_call_popups'.tr
                  : 'Incoming Call Popups',
              subtitle: 'incoming_call_popups_desc'.tr.isNotEmpty &&
                      'incoming_call_popups_desc'.tr != 'incoming_call_popups_desc'
                  ? 'incoming_call_popups_desc'.tr
                  : 'See incoming calls instantly over any app or lock screen',
            ),
            const Gap(12),
            _buildFeatureTile(
              context,
              icon: Icons.layers_rounded,
              iconBgColor: const Color(0xFF3B82F6).withValues(alpha: 0.12),
              iconColor: const Color(0xFF3B82F6),
              title: 'never_miss_match_call'.tr.isNotEmpty &&
                      'never_miss_match_call'.tr != 'never_miss_match_call'
                  ? 'never_miss_match_call'.tr
                  : 'Never Miss a Match',
              subtitle: 'never_miss_match_call_desc'.tr.isNotEmpty &&
                      'never_miss_match_call_desc'.tr != 'never_miss_match_call_desc'
                  ? 'never_miss_match_call_desc'.tr
                  : 'Ensure voice & video calls from interested matches reach you',
            ),
            const Gap(28),

            // ── Action Buttons ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    label: 'later'.tr.isNotEmpty && 'later'.tr != 'later'
                        ? 'later'.tr
                        : 'Later',
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: AppPrimaryButton(
                    label: 'open_settings'.tr.isNotEmpty &&
                            'open_settings'.tr != 'open_settings'
                        ? 'open_settings'.tr
                        : 'Open Settings',
                    onPressed: () {
                      Navigator.of(context).pop(true);
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

  Widget _buildFeatureTile(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : const Color(0xFFF8F9FD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFEAEBED),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap(2),
                Text(
                  subtitle,
                  style: AppFont.font(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
