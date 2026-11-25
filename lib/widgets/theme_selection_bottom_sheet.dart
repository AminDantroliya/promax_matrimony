import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import '../app_theme/theme_provider.dart';

class ThemeSelectionBottomSheet extends ConsumerWidget {
  const ThemeSelectionBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
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
      builder: (context) => const ThemeSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentMode = ref.watch(themeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle
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

            // Header Title & Subtitle
            Text(
              "Theme",
              style: AppFont.font(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Gap(4),
            Text(
              "Choose your preferred app appearance",
              style: AppFont.font(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const Gap(20),

            // Theme Option Items
            _buildThemeOption(
              context: context,
              ref: ref,
              title: "Light Theme",
              subtitle: "Always use light theme",
              icon: Icons.light_mode_rounded,
              mode: ThemeMode.light,
              isSelected: currentMode == ThemeMode.light,
              isDark: isDark,
            ),
            const Gap(10),
            _buildThemeOption(
              context: context,
              ref: ref,
              title: "Dark Theme",
              subtitle: "Always use dark theme",
              icon: Icons.dark_mode_rounded,
              mode: ThemeMode.dark,
              isSelected: currentMode == ThemeMode.dark,
              isDark: isDark,
            ),
            const Gap(10),
            _buildThemeOption(
              context: context,
              ref: ref,
              title: "System Theme",
              subtitle: "Follow system appearance",
              icon: Icons.phone_android_rounded,
              mode: ThemeMode.system,
              isSelected: currentMode == ThemeMode.system,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode mode,
    required bool isSelected,
    required bool isDark,
  }) {
    final brandColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        ref.read(themeProvider.notifier).setThemeMode(mode);
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF222045) : const Color(0xFFF3F4FD))
              : (isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : const Color(0xFFFAFAFC)),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? brandColor
                : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFF0F0F6)),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isSelected
                    ? brandColor.withValues(alpha: 0.12)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : const Color(0xFFF1F3FB)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? brandColor
                    : (isDark ? Colors.white70 : const Color(0xFF6E7890)),
                size: 20,
              ),
            ),
            const Gap(14),

            // Titles
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? (isDark ? Colors.white : brandColor)
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.white60
                          : const Color(0xFF7A7A9E),
                    ),
                  ),
                ],
              ),
            ),

            // Radio check indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? brandColor : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? brandColor
                      : (isDark ? Colors.white30 : const Color(0xFFDCDCE6)),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
