import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/logout_bottom_sheet.dart';

import '../../../home/data/models/dashboard_category.dart';
import '../../../home/data/models/dashboard_models.dart';
import '../../../home/providers/dashboard_notifier.dart';
import '../../../home/widgets/home_compact_profile_bar.dart';
import '../../../home/widgets/home_hero_card.dart';
import '../../../home/widgets/home_hero_card_2.dart';
import '../../../home/widgets/home_stats_row.dart';
import '../../providers/profile_notifier.dart';

class MyProfileDesign1 extends ConsumerWidget {
  const MyProfileDesign1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final dashboardCategory = ref.watch(dashboardCategoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopNavBar(context, isDark),
              const Gap(10),
              _buildDynamicProfileHeader(
                context,
                ref,
                dashboardAsync,
                dashboardCategory,
                isDark,
              ),
              const Gap(24),
              _buildSectionHeader(context, "account_lbl"),
              _buildAccountMenuCard(context, ref, isDark),
              const Gap(24),
              _buildSectionHeader(context, "preferences_lbl"),
              _buildPreferencesMenuCard(context, ref, isDark),
              const Gap(24),
              _buildSectionHeader(context, "others_lbl"),
              _buildOthersMenuCard(context, ref, isDark),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title.tr.toUpperCase(),
        style: AppFont.font(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF8F96AC),
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildTopNavBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaBack,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : const Color(0xFF16182F),
                    BlendMode.srcIn,
                  ),
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ),
          Text(
            "my_profile".tr,
            style: AppFont.font(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF16182F),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/profile-view-my'),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaEdit,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : const Color(0xFF16182F),
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicProfileHeader(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<dynamic> dashboardAsync,
    DashboardCategory category,
    bool isDark,
  ) {
    return dashboardAsync.when(
      data: (data) {
        if (data == null) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final dashboardData = data as DashboardData;
        switch (category) {
          case DashboardCategory.dashboard1:
            return HomeHeroCard(data: dashboardData, isDark: isDark);
          case DashboardCategory.dashboard2:
            return HomeHeroCard2(data: dashboardData, isDark: isDark);
          case DashboardCategory.dashboard3:
            return Column(
              children: [
                HomeCompactProfileBar(data: dashboardData, isDark: isDark),
                const Gap(14),
                HomeStatsRow(data: dashboardData, isDark: isDark),
              ],
            );
        }
      },
      loading: () => const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => SizedBox(
        height: 180,
        child: Center(
          child: Text(
            "Error loading profile card",
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountMenuCard(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        children: [
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaEditProfile,
            title: "edit_profile",
            subtitle: "update_your_details_sub",
            onTap: () => context.push('/profile-view-my'),
            isDark: isDark,
          ),
          if (ref.watch(featureProvider('enableBiodataDownload')))
            _buildFigmaMenuItem(
              context: context,
              iconPath: AppAssets.figmaDownloadBiodata,
              title: "download_biodata",
              subtitle: "download_biodata_sub",
              onTap: () => _handleDownloadBiodata(context, ref),
              isDark: isDark,
            ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaChangePassword,
            title: "change_password",
            subtitle: "secure_your_account_sub",
            onTap: () => context.push('/change-password'),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  void _handleDownloadBiodata(BuildContext context, WidgetRef ref) async {
    final profile = ref.read(myProfileProvider).value;
    final biodataUrl = profile?.downloadBiodata?.toString();
    if (biodataUrl == null || biodataUrl.trim().isEmpty) {
      showToast('biodata_not_available'.tr);
      return;
    }

    showLoading(context);
    try {
      final dir = await getApplicationDocumentsDirectory();
      final identifier =
          profile?.matriId?.toString() ??
          profile?.id?.toString() ??
          'my_biodata';
      final localPath = "${dir.path}/biodata_$identifier.pdf";
      final file = File(localPath);

      if (!await file.exists()) {
        final dio = Dio();
        await dio.download(biodataUrl, localPath);
      }

      hideLoading();

      final result = await OpenFilex.open(localPath);
      if (result.type != ResultType.done) {
        showToast(
          'could_not_open_biodata'.trParams({'message': result.message}),
        );
      }
    } catch (e) {
      hideLoading();
      showToast('failed_to_download_biodata'.trParams({'error': e.toString()}));
    }
  }

  Widget _buildPreferencesMenuCard(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        children: [
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaPhotoSettings,
            title: "photo_settings",
            subtitle: "privacy_visibility_sub",
            onTap: () =>
                context.push('/privacy-settings', extra: {'scrollTo': 'photo'}),
            isDark: isDark,
          ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaContact,
            title: "contact_settings",
            subtitle: "manage_your_contacts_sub",
            onTap: () => context.push(
              '/privacy-settings',
              extra: {'scrollTo': 'contact'},
            ),
            isDark: isDark,
          ),
          if (ref.watch(featureProvider('enableVideoCall')))
            _buildFigmaMenuItem(
              context: context,
              iconPath: AppAssets.figmaVideoCallOutline,
              title: "video_call_settings",
              subtitle: "video_call_privacy_sub",
              onTap: () =>
                  context.push('/privacy-settings', extra: {'scrollTo': 'video'}),
              isDark: isDark,
            ),
          if (ref.watch(featureProvider('enableVoiceCall')))
            _buildFigmaMenuItem(
              context: context,
              iconPath: AppAssets.figmaVoiceCallOutline,
              title: "voice_call_settings",
              subtitle: "voice_call_privacy_sub",
              onTap: () =>
                  context.push('/privacy-settings', extra: {'scrollTo': 'voice'}),
              isDark: isDark,
            ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaNotificationsOutline,
            title: "push_notification_settings",
            subtitle: "manage_push_alerts_sub",
            onTap: () => context.push('/push-notification-settings'),
            isDark: isDark,
          ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaDocument,
            title: "email_notification_settings",
            subtitle: "manage_email_alerts_sub",
            onTap: () => context.push('/email-notification-settings'),
            isDark: isDark,
          ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaDocument,
            title: "sms_notification_settings",
            subtitle: "manage_sms_alerts_sub",
            onTap: () => context.push('/sms-notification-settings'),
            isDark: isDark,
          ),
          if (ref.watch(featureProvider('enableAiAutoInterest')))
            _buildFigmaMenuItem(
              context: context,
              iconPath: AppAssets.figmaConnect,
              title: "ai_auto_send_interest_settings",
              subtitle: "ai_powered_match_automation",
              onTap: () async {
                final allowed = await checkAiInterestPermission(context, ref);
                if (allowed && context.mounted) {
                  context.push('/auto-send-interest');
                }
              },
              isDark: isDark,
            ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaSettingsOutline,
            title: "general_settings",
            subtitle: "app_configuration_sub",
            onTap: () => context.push('/settings'),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildOthersMenuCard(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        children: [
          if (ref.watch(featureProvider('enableSuccessStories')))
            _buildFigmaMenuItem(
              context: context,
              iconPath: AppAssets.figmaSuccessStory,
              title: "success_stories",
              subtitle: "inspiring_journeys_sub",
              onTap: () => context.push('/success-stories'),
              isDark: isDark,
            ),
          _buildFigmaMenuItem(
            context: context,
            iconPath: AppAssets.figmaLogout,
            title: "logout",
            subtitle: "logout_your_account_sub",
            isDestructive: true,
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              builder: (_) => const LogoutBottomSheet(),
            ),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFigmaMenuItem({
    required BuildContext context,
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
    bool isNotificationToggle = false,
    WidgetRef? ref,
  }) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        onTap: isNotificationToggle ? null : onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withValues(alpha: 0.1)
                : Theme.of(context).primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isDestructive ? Colors.red : Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: Text(
          title.tr,
          style: AppFont.font(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDestructive
                ? Colors.red
                : (isDark ? Colors.white : const Color(0xFF16182F)),
          ),
        ),
        subtitle: Text(
          subtitle.tr,
          style: AppFont.font(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E90A6),
          ),
        ),
        trailing: isNotificationToggle
            ? (ref != null
                  ? _buildNotificationSwitch(context, ref)
                  : const SizedBox.shrink())
            : SvgPicture.asset(
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

  Widget _buildNotificationSwitch(BuildContext context, WidgetRef ref) {
    // Standard switch layout
    return Switch.adaptive(
      value: true, // Mocked value
      onChanged: (val) {},
      activeThumbColor: Theme.of(context).primaryColor,
    );
  }
}
