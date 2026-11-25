import 'package:flutter/material.dart';
import 'package:pro_matrimony/widgets/logout_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/theme_selection_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
});

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(appVersionProvider).value ?? '';
    final config = ref.watch(appConfigProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(
              title: 'setting_screen_title'.tr,
              isShowActions: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── General group ──
                    _buildSectionLabel(context, 'general_lbl'.tr, isDark),
                    const Gap(10),
                    _buildMenuCard(
                      context,
                      isDark,
                      items: [
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaContact,
                          title: 'contact_us'.tr,
                          subtitle: 'reach_out_support_sub'.tr,
                          onTap: () => context.push('/help-support'),
                          isDark: isDark,
                        ),
                        if (config.isDarkThemeSupported)
                          _buildThemeItem(context, ref, isDark),
                        if (config.isMultiLanguageSupported)
                          _menuItem(
                          context,
                            iconPath: AppAssets.icLanguage,
                            title: 'app_language'.tr,
                            subtitle: 'change_app_language_sub'.tr,
                            onTap: () => context.push('/language-setting'),
                            isDark: isDark,
                          ),
                      ],
                    ),

                    const Gap(20),

                    // ── Legal group ──
                    _buildSectionLabel(context, 'legal_lbl'.tr, isDark),
                    const Gap(10),
                    _buildMenuCard(
                      context,
                      isDark,
                      items: [
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaDocument,
                          title: 'refund_policy'.tr,
                          subtitle: 'read_refund_terms_sub'.tr,
                          onTap: () => context.push(
                            '/cms',
                            extra: {
                              'slug': 'refund-policy',
                              'title': 'refund_policy'.tr,
                            },
                          ),
                          isDark: isDark,
                        ),
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaDocument,
                          title: 'terms_and_conditions'.tr,
                          subtitle: 'terms_governing_use_sub'.tr,
                          onTap: () => context.push(
                            '/cms',
                            extra: {
                              'slug': 'terms-condition',
                              'title': 'terms_and_conditions'.tr,
                            },
                          ),
                          isDark: isDark,
                        ),
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaPrivacy,
                          title: 'privacy_policy'.tr,
                          subtitle: 'privacy_policy_sub'.tr,
                          onTap: () => context.push(
                            '/cms',
                            extra: {
                              'slug': 'privacy-policy',
                              'title': 'privacy_policy'.tr,
                            },
                          ),
                          isDark: isDark,
                        ),
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaAboutUs,
                          title: 'about_us'.tr,
                          subtitle: 'about_us_sub'.tr,
                          onTap: () => context.push(
                            '/cms',
                            extra: {
                              'slug': 'about-us',
                              'title': 'about_us'.tr,
                            },
                          ),
                          isDark: isDark,
                        ),
                      ],
                    ),

                    const Gap(20),

                    // ── Danger zone group ──
                    _buildSectionLabel(context, 'account_lbl'.tr, isDark),
                    const Gap(10),
                    _buildMenuCard(
                      context,
                      isDark,
                      items: [
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaBlock,
                          title: 'delete_profile'.tr,
                          subtitle: 'delete_profile_sub'.tr,
                          onTap: () => context.push('/delete-profile'),
                          isDark: isDark,
                          isDestructive: true,
                        ),
                        _menuItem(
                          context,
                          iconPath: AppAssets.figmaLogout,
                          title: 'logout'.tr,
                          subtitle: 'logout_sub'.tr,
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                            ),
                            builder: (_) => const LogoutBottomSheet(),
                          ),
                          isDark: isDark,
                          isDestructive: true,
                        ),
                      ],
                    ),

                    const Gap(30),

                    // ── App version ──
                    if (appVersion.isNotEmpty)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: customTextNormalStyle(
                            '${'version'.tr} : $appVersion',
                            12,
                            TextAlign.center,
                            Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section label (matches my_profile_screen style)
  Widget _buildSectionLabel(BuildContext context, String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: AppFont.font(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  /// Grouped card container (same style as my_profile_screen)
  Widget _buildMenuCard(
    BuildContext context,
    bool isDark, {
    required List<Widget> items,
  }) {
    // Filter out any null/empty items (e.g. conditional theme item)
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  /// Single menu item (identical to my_profile_screen's _buildFigmaMenuItem)
  Widget _menuItem(
    BuildContext context, {
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    final primaryColor = Theme.of(context).primaryColor;

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withValues(alpha: 0.1)
                : primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isDestructive ? Colors.red : primaryColor,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: AppFont.font(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDestructive
                ? Colors.red
                : (isDark ? Colors.white : const Color(0xFF16182F)),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppFont.font(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E90A6),
          ),
        ),
        trailing: SvgPicture.asset(
          AppAssets.figmaNavigationForward,
          colorFilter: ColorFilter.mode(
            isDark ? const Color(0xFF8E90A6) : const Color(0xFFC4C5D6),
            BlendMode.srcIn,
          ),
          width: 14,
          height: 14,
        ),
      ),
    );
  }

  Widget _buildThemeItem(BuildContext context, WidgetRef ref, bool isDark) {
    final themeMode = ref.watch(themeProvider);
    final primaryColor = Theme.of(context).primaryColor;
    String themeLabel;
    String themeIcon;

    switch (themeMode) {
      case ThemeMode.light:
        themeLabel = 'light_theme'.tr;
        themeIcon = AppAssets.figmaSettingsOutline;
        break;
      case ThemeMode.dark:
        themeLabel = 'dark_theme'.tr;
        themeIcon = AppAssets.figmaSettingsOutline;
        break;
      case ThemeMode.system:
        themeLabel = 'system_theme'.tr;
        themeIcon = AppAssets.figmaSettingsOutline;
        break;
    }

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        onTap: () => ThemeSelectionBottomSheet.show(context),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: SvgPicture.asset(
              themeIcon,
              colorFilter: ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: Text(
          'app_theme'.tr,
          style: AppFont.font(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF16182F),
          ),
        ),
        subtitle: Text(
          themeLabel,
          style: AppFont.font(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E90A6),
          ),
        ),
        trailing: SvgPicture.asset(
          AppAssets.figmaNavigationForward,
          colorFilter: ColorFilter.mode(
            isDark ? const Color(0xFF8E90A6) : const Color(0xFFC4C5D6),
            BlendMode.srcIn,
          ),
          width: 14,
          height: 14,
        ),
      ),
    );
  }
}
