import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/logout_bottom_sheet.dart';

import '../../../home/data/models/dashboard_models.dart';
import '../../../home/providers/dashboard_notifier.dart';
import '../../../home/providers/home_notifier.dart';
import '../../../home/utils/home_helpers.dart';
import '../../../home/widgets/verification_dialogs.dart';
import '../../providers/profile_notifier.dart';

class MyProfileDesign2 extends ConsumerStatefulWidget {
  const MyProfileDesign2({super.key});

  @override
  ConsumerState<MyProfileDesign2> createState() => _MyProfileDesign2State();
}

class _MyProfileDesign2State extends ConsumerState<MyProfileDesign2> {
  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final myProfileAsync = ref.watch(myProfileProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F1017)
          : (Theme.of(context).scaffoldBackgroundColor == Colors.transparent
                ? const Color(0xFFFAF7F5)
                : Theme.of(context).scaffoldBackgroundColor),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopNavBar(context, isDark, dashboardAsync),
              const Gap(14),
              _buildHeroCard(
                context,
                ref,
                dashboardAsync,
                myProfileAsync,
                isDark,
              ),
              const Gap(26),

              // 01 — Account
              _buildFigmaSectionHeader(context, "01", "account_lbl".tr),
              const Gap(10),
              _buildAccountMenuCard(context, isDark),
              const Gap(24),

              // 02 — Preferences
              _buildFigmaSectionHeader(context, "02", "preferences_lbl".tr),
              const Gap(10),
              _buildPreferencesMenuCard(context, isDark),
              const Gap(24),

              // 03 — Others
              _buildFigmaSectionHeader(context, "03", "others_lbl".tr),
              const Gap(10),
              _buildOthersMenuCard(context, ref, isDark),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top Navigation Bar (Figma Design 2) ────────────────────────────────────
  Widget _buildTopNavBar(
    BuildContext context,
    bool isDark,
    AsyncValue<DashboardData?> dashboardAsync,
  ) {
    final unreadNotifications =
        dashboardAsync.value?.unreadNotificationCount ?? 0;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 4),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
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
          const Gap(14),

          // Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "account_lbl".tr,
                  style: AppFont.font(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF16182F),
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  "my_profile".tr,
                  style: AppFont.font(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8F96AC),
                  ),
                ),
              ],
            ),
          ),

          // Notification Bell Button
          GestureDetector(
            onTap: () => context.push('/notifications'),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.figmaNotificationsOutline,
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white : const Color(0xFF16182F),
                      BlendMode.srcIn,
                    ),
                    width: 19,
                    height: 19,
                  ),
                  if (unreadNotifications > 0)
                    Positioned(
                      top: 10,
                      right: 11,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(10),

          // Edit Profile Button
          GestureDetector(
            onTap: () => context.push('/profile-view-my'),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaEditOutline,
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
        ],
      ),
    );
  }

  // ── Hero Card (Luxury Dark Plum Gradient) ──────────────────────────────────
  Widget _buildHeroCard(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<DashboardData?> dashboardAsync,
    AsyncValue<dynamic> myProfileAsync,
    bool isDark,
  ) {
    return dashboardAsync.when(
      data: (data) {
        if (data == null) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final myProfile = myProfileAsync.value;
        final completeness =
            double.tryParse(data.profilePercentage?.toString() ?? "0") ?? 0;
        final config = ref.watch(appConfigProvider);
        final Color cardGradStart = config.gradientStart;
        final Color cardGradEnd = (config.gradientStart != config.gradientEnd)
            ? config.gradientEnd
            : (Theme.of(context).primaryColor != Theme.of(context).colorScheme.secondary
                ? Theme.of(context).colorScheme.secondary
                : HSLColor.fromColor(cardGradStart)
                    .withLightness((HSLColor.fromColor(cardGradStart).lightness - 0.15).clamp(0.1, 0.9))
                    .toColor());

        final progressColors = config.getProgressGradient(
          cardPrimary: cardGradStart,
          cardSecondary: cardGradEnd,
        );
        final progressStart = progressColors.first;

        final displayName =
            (data.profileTitle != null && data.profileTitle!.trim().isNotEmpty)
            ? data.profileTitle!
            : (myProfile?.fullname?.toString() ?? "User Profile");

        final emailStatus =
            (data.emailVerifyStatus ?? myProfile?.emailVerifyStatus)
                ?.toString()
                .trim()
                .toLowerCase();
        final isEmailVerified = emailStatus == "verify" ||
            emailStatus == "verified" ||
            emailStatus == "yes" ||
            emailStatus == "1";

        final mobileStatus =
            (data.mobileVerifyStatus ?? myProfile?.mobileVerifyStatus)
                ?.toString()
                .trim()
                .toLowerCase();
        final isMobileVerified = mobileStatus == "yes" ||
            mobileStatus == "verify" ||
            mobileStatus == "verified" ||
            mobileStatus == "1";

        final String rawAge = myProfile?.age?.toString() ?? "";
        final numMatch = RegExp(r'\d+').firstMatch(rawAge);
        final String ageStr = numMatch != null
            ? "${numMatch.group(0)} ${'yrs'.tr}"
            : (rawAge.isNotEmpty ? rawAge : "");
        final String heightStr = formatDisplayHeight(
          myProfile?.heightStr?.toString().isNotEmpty == true
              ? myProfile!.heightStr.toString()
              : myProfile?.height?.toString(),
          appendHeight: false,
        );
        final String cityStr = HomeHelpers.getDisplayCity(
          myProfile?.cityName ?? myProfile?.city,
        );

        final String subTitleDetails = [
          ageStr,
          heightStr,
          cityStr,
        ].where((s) => s.isNotEmpty).join(' • ');

        final displaySubtitle = subTitleDetails.isNotEmpty
            ? subTitleDetails
            : (data.subTitle ?? "");

        final bool isPaid = ApplicationData.isMemberPaid == true;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cardGradStart, cardGradEnd],
            ),
            boxShadow: [
              BoxShadow(
                color: cardGradEnd.withValues(alpha: 0.35),
                blurRadius: 30,
                spreadRadius: 0,
                offset: const Offset(0, 14),
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                // Top Right Subtle Glow Circle
                Positioned(
                  top: -80,
                  right: -80,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                // Bottom Left Subtle Glow Circle
                Positioned(
                  bottom: -60,
                  left: -60,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Avatar, Name & Details, Action Icons
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Avatar
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.20),
                                width: 1.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: getImageWidget(
                                url:
                                    data.profileImage ??
                                    myProfile?.photo1 ??
                                    "",
                                isMyPhoto: true,
                                boxFit: BoxFit.cover,
                                imageWidth: 68,
                                imageHeight: 68,
                              ),
                            ),
                          ),
                          const Gap(14),

                          // Name, Subtitle, Premium Badge
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName,
                                  style: AppFont.font(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: -0.2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(4),
                                if (displaySubtitle.isNotEmpty)
                                  Text(
                                    displaySubtitle,
                                    style: AppFont.font(
                                      fontSize: 12,
                                      color: Colors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (ref.watch(
                                  featureProvider('showPremiumBadge'),
                                )) ...[
                                  const Gap(8),
                                  _buildPremiumBadge(isPaid),
                                ],
                              ],
                            ),
                          ),
                          const Gap(10),

                          // Action Buttons: Call & Mail Verification (same as Dashboard)
                          Column(
                            children: [
                              _heroActionCircle(
                                svgPath: AppAssets.figmaVoiceCall,
                                onTap: () {
                                  if (!isMobileVerified) {
                                    final phone =
                                        myProfile?.mobile?.toString() ?? "";
                                    showDialog(
                                      context: context,
                                      builder: (context) => VerifyMobileDialog(
                                        phoneNumber: phone,
                                      ),
                                    );
                                  } else {
                                    showToast(
                                      '${'mobile'.tr} ${'verified_status'.tr}',
                                    );
                                  }
                                },
                                isVerified: isMobileVerified,
                              ),
                              const Gap(8),
                              _heroActionCircle(
                                icon: Icons.mail_outline_rounded,
                                onTap: () {
                                  if (!isEmailVerified) {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const EmailVerificationDialog(),
                                    );
                                  } else {
                                    showToast(
                                      '${'email'.tr} ${'verified_status'.tr}',
                                    );
                                  }
                                },
                                isVerified: isEmailVerified,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(20),

                      // Profile Completion Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'profile_completion_lbl'.tr,
                            style: AppFont.font(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.70),
                            ),
                          ),
                          Text(
                            "${completeness.toInt()}%",
                            style: AppFont.font(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color:
                                  (progressStart.computeLuminance() -
                                              cardGradStart.computeLuminance())
                                          .abs() <
                                      0.2
                                  ? const Color(0xFFFFD166)
                                  : progressStart,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      LinearPercentIndicator(
                        lineHeight: 6,
                        percent: (completeness / 100).clamp(0.0, 1.0),
                        linearGradient: LinearGradient(colors: progressColors),
                        backgroundColor: Colors.white.withValues(alpha: 0.80),
                        barRadius: const Radius.circular(10),
                        padding: EdgeInsets.zero,
                      ),
                      const Gap(20),

                      // Bottom Stats Row (Rounded Tiles)
                      Row(
                        children: [
                          if (ref.watch(featureProvider('enableVoiceCall')) ||
                              ref.watch(featureProvider('enableVideoCall'))) ...[
                            Expanded(
                              child: _buildSquircleStatTile(
                                svgPath: AppAssets.icProfileCardCall,
                                count: data.callCount?.toString() ?? "0",
                                label: 'calls'.tr,
                                onTap: () => context.push('/call-history'),
                              ),
                            ),
                            const Gap(8),
                          ],
                          Expanded(
                            child: _buildSquircleStatTile(
                              svgPath: AppAssets.icProfileCardMatch,
                              count: data.matchesCount?.toString() ?? "0",
                              label: 'matches'.tr,
                              onTap: () {
                                ref
                                    .read(homePageIndexProvider.notifier)
                                    .setIndex(3);
                                context.go('/home');
                              },
                            ),
                          ),
                          if (ref.watch(featureProvider('enableChat'))) ...[
                            const Gap(8),
                            Expanded(
                              child: _buildSquircleStatTile(
                                svgPath: AppAssets.icProfileCardChat,
                                count: data.chatCount?.toString() ?? "0",
                                label: 'chats'.tr,
                                onTap: () {
                                  ref
                                      .read(homePageIndexProvider.notifier)
                                      .setIndex(2);
                                  context.go('/home');
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => SizedBox(
        height: 220,
        child: Center(
          child: Text(
            "Error loading profile",
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBadge(bool isPaid) {
    if (isPaid) {
      return GestureDetector(
        onTap: () => context.push('/current-plan'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF3C785),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                size: 13,
                color: Color(0xFF2B1C04),
              ),
              const Gap(4),
              Text(
                'premium_lbl'.tr.toUpperCase(),
                style: AppFont.font(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2B1C04),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => context.push('/plans'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.workspace_premium_rounded,
              size: 13,
              color: Colors.white,
            ),
            const Gap(4),
            Text(
              'upgrade_plan'.tr.toUpperCase(),
              style: AppFont.font(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroActionCircle({
    String? svgPath,
    IconData? icon,
    required VoidCallback onTap,
    bool isVerified = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
                width: 1.0,
              ),
            ),
            child: Center(
              child: icon != null
                  ? Icon(
                      icon,
                      color: Colors.white,
                      size: 22,
                    )
                  : svgPath != null
                      ? SvgPicture.asset(
                          svgPath,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 22,
                          height: 22,
                        )
                      : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: isVerified
                    ? const Color(0xFF34C759)
                    : const Color(0xFFFF9500),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isVerified ? Icons.check : Icons.priority_high_rounded,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquircleStatTile({
    required String svgPath,
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgPath,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 17,
                  height: 17,
                ),
              ),
            ),
            const Gap(5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    count,
                    style: AppFont.font(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      label,
                      style: AppFont.font(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.70),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Numbered Section Headers (Figma Design 2) ──────────────────────────────
  Widget _buildFigmaSectionHeader(
    BuildContext context,
    String number,
    String title,
  ) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$number — ",
                  style: AppFont.font(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: AppFont.font(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Expanded(
            child: Container(
              height: 1,
              color: primaryColor.withValues(alpha: 0.25),
            ),
          ),
        ],
      ),
    );
  }

  // ── Download Biodata Action ───────────────────────────────────────────────
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

  // ── Section 01: Account Grouped Menu Card ─────────────────────────────────
  Widget _buildAccountMenuCard(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaEditProfile,
            fallbackIcon: Icons.badge_outlined,
            title: "edit_profile".tr,
            subtitle: "update_your_details_sub".tr,
            onTap: () => context.push('/profile-view-my'),
            isDark: isDark,
          ),
          if (ref.watch(featureProvider('enableBiodataDownload'))) ...[
            _buildDivider(isDark),
            _buildMenuItem(
              context: context,
              iconPath: AppAssets.figmaDownloadBiodata,
              fallbackIcon: Icons.download_rounded,
              title: "download_biodata".tr,
              subtitle: "download_biodata_sub".tr,
              onTap: () => _handleDownloadBiodata(context, ref),
              isDark: isDark,
            ),
          ],
          _buildDivider(isDark),
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaChangePassword,
            fallbackIcon: Icons.key_rounded,
            title: "change_password".tr,
            subtitle: "secure_your_account_sub".tr,
            onTap: () => context.push('/change-password'),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  // ── Section 02: Preferences Grouped Menu Card ──────────────────────────────
  Widget _buildPreferencesMenuCard(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaPhotoSettings,
            fallbackIcon: Icons.image_outlined,
            title: "photo_settings".tr,
            subtitle: "privacy_visibility_sub".tr,
            onTap: () =>
                context.push('/privacy-settings', extra: {'scrollTo': 'photo'}),
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaContact,
            fallbackIcon: Icons.phone_outlined,
            title: "contact_settings".tr,
            subtitle: "manage_your_contacts_sub".tr,
            onTap: () => context.push(
              '/privacy-settings',
              extra: {'scrollTo': 'contact'},
            ),
            isDark: isDark,
          ),
          if (ref.watch(featureProvider('enableVideoCall'))) ...[
            _buildDivider(isDark),
            _buildMenuItem(
              context: context,
              iconPath: AppAssets.figmaVideoCallOutline,
              fallbackIcon: Icons.videocam_outlined,
              title: "video_call_settings".tr,
              subtitle: "video_call_privacy_sub".tr,
              onTap: () =>
                  context.push('/privacy-settings', extra: {'scrollTo': 'video'}),
              isDark: isDark,
            ),
          ],
          if (ref.watch(featureProvider('enableVoiceCall'))) ...[
            _buildDivider(isDark),
            _buildMenuItem(
              context: context,
              iconPath: AppAssets.figmaVoiceCallOutline,
              fallbackIcon: Icons.phone_in_talk_outlined,
              title: "voice_call_settings".tr,
              subtitle: "voice_call_privacy_sub".tr,
              onTap: () =>
                  context.push('/privacy-settings', extra: {'scrollTo': 'voice'}),
              isDark: isDark,
            ),
          ],
          _buildDivider(isDark),
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaNotificationsOutline,
            fallbackIcon: Icons.notifications_none_rounded,
            title: "push_notification_settings".tr,
            subtitle: "manage_push_alerts_sub".tr,
            onTap: () => context.push('/push-notification-settings'),
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaDocument,
            fallbackIcon: Icons.email_outlined,
            title: "email_notification_settings".tr,
            subtitle: "manage_email_alerts_sub".tr,
            onTap: () => context.push('/email-notification-settings'),
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaDocument,
            fallbackIcon: Icons.sms_outlined,
            title: "sms_notification_settings".tr,
            subtitle: "manage_sms_alerts_sub".tr,
            onTap: () => context.push('/sms-notification-settings'),
            isDark: isDark,
          ),
          if (ref.watch(featureProvider('enableAiAutoInterest'))) ...[
            _buildDivider(isDark),
            _buildMenuItem(
              context: context,
              iconPath: AppAssets.figmaConnect,
              fallbackIcon: Icons.auto_awesome_rounded,
              title: "ai_auto_send_interest_settings".tr,
              subtitle: "ai_powered_match_automation".tr,
              onTap: () async {
                final allowed = await checkAiInterestPermission(context, ref);
                if (allowed && context.mounted) {
                  context.push('/auto-send-interest');
                }
              },
              isDark: isDark,
            ),
          ],
          _buildDivider(isDark),
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaSettingsOutline,
            fallbackIcon: Icons.settings_outlined,
            title: "general_settings".tr,
            subtitle: "app_configuration_sub".tr,
            onTap: () => context.push('/settings'),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  // ── Section 03: Others Grouped Menu Card ──────────────────────────────────
  Widget _buildOthersMenuCard(BuildContext context, WidgetRef ref, bool isDark) {
    final enableSuccessStories = ref.watch(featureProvider('enableSuccessStories'));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          if (enableSuccessStories) ...[
            _buildMenuItem(
              context: context,
              iconPath: AppAssets.figmaSuccessStory,
              fallbackIcon: Icons.favorite_rounded,
              title: "success_stories".tr,
              subtitle: "inspiring_journeys_sub".tr,
              onTap: () => context.push('/success-stories'),
              isDark: isDark,
            ),
            _buildDivider(isDark),
          ],
          _buildMenuItem(
            context: context,
            iconPath: AppAssets.figmaLogout,
            fallbackIcon: Icons.logout_rounded,
            title: "logout".tr,
            subtitle: "logout_your_account_sub".tr,
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

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFFF1F1F5),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String iconPath,
    required IconData fallbackIcon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
    Widget? trailingWidget,
  }) {
    final primaryColor = Theme.of(context).primaryColor;
    final errorColor = Theme.of(context).colorScheme.error;
    final actionColor = isDestructive ? errorColor : primaryColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: trailingWidget != null ? null : onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Leading Icon Container
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? errorColor.withValues(alpha: 0.12)
                      : (isDark
                            ? primaryColor.withValues(alpha: 0.15)
                            : primaryColor.withValues(alpha: 0.08)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(actionColor, BlendMode.srcIn),
                    width: 20,
                    height: 20,
                    placeholderBuilder: (_) =>
                        Icon(fallbackIcon, color: actionColor, size: 20),
                  ),
                ),
              ),
              const Gap(14),

              // Title & Subtitle Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppFont.font(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: isDestructive
                            ? errorColor
                            : (isDark ? Colors.white : const Color(0xFF16182F)),
                      ),
                    ),
                    const Gap(2),
                    Text(
                      subtitle,
                      style: AppFont.font(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8E90A6),
                      ),
                    ),
                  ],
                ),
              ),

              // Trailing Widget or Navigation Chevron
              if (trailingWidget != null)
                trailingWidget
              else
                SvgPicture.asset(
                  AppAssets.figmaNavigationForward,
                  colorFilter: ColorFilter.mode(
                    isDark ? const Color(0xFF8E90A6) : const Color(0xFFC4C5D6),
                    BlendMode.srcIn,
                  ),
                  width: 14,
                  height: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
