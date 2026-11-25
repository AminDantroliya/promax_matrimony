import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../utils/utils.dart';
import '../../profile/providers/profile_notifier.dart';
import '../data/models/dashboard_models.dart';
import '../providers/home_notifier.dart';
import '../utils/home_helpers.dart';
import 'verification_dialogs.dart';

class HomeHeroCard extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const HomeHeroCard({super.key, required this.data, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final myProfile = ref.watch(myProfileProvider).value;
    final hasActivePlan = HomeHelpers.hasActivePlan(
      data: data,
      myProfile: myProfile,
    );
    final completeness =
        double.tryParse(data.profilePercentage?.toString() ?? "0") ?? 0;

    final emailStatus =
        data.emailVerifyStatus?.toString().trim().toLowerCase();
    final isEmailVerified = emailStatus == "verify" ||
        emailStatus == "verified" ||
        emailStatus == "yes" ||
        emailStatus == "1";

    final mobileStatus =
        data.mobileVerifyStatus?.toString().trim().toLowerCase();
    final isMobileVerified = mobileStatus == "yes" ||
        mobileStatus == "verify" ||
        mobileStatus == "verified" ||
        mobileStatus == "1";

    final String rawAge = myProfile?.age?.toString() ?? "";
    final numMatch = RegExp(r'\d+').firstMatch(rawAge);
    final String ageStr = numMatch != null
        ? "${numMatch.group(0)} ${'yrs'.tr}"
        : (rawAge.isNotEmpty ? rawAge : "");
    final String cityStr = HomeHelpers.getDisplayCity(
      myProfile?.cityName ?? myProfile?.city,
    );
    final String subtitle = [
      cityStr,
      ageStr,
    ].where((s) => s.isNotEmpty).join(' · ');

    final primaryColor = Theme.of(context).primaryColor;

    // Dynamic Premium Badge Colors
    final Color badgeBg =
        config.premiumBadgeColor ??
        (config.accentColor != primaryColor
            ? config.accentColor
            : Colors.white.withValues(alpha: 0.22));
    final Color badgeFg =
        config.premiumBadgeTextColor ??
        (ThemeData.estimateBrightnessForColor(badgeBg) == Brightness.dark
            ? Colors.white
            : const Color(0xFF1E202C));

    final secondaryColor = Theme.of(context).colorScheme.secondary;

    // Dynamic Progress Colors (Multi-color gradient combination)
    final List<Color> progressColors = config.getProgressGradient(
      cardPrimary: primaryColor,
      cardSecondary: secondaryColor,
    );
    final Color progressStart = progressColors.first;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.25),
            blurRadius: 50,
            spreadRadius: 0,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Dynamic theme 2-color gradient from Admin Config
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Top Right Overlay Circle (Figma spec large tangent wave)
            Positioned(
              top: -150,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            // Bottom Left Overlay Circle (Figma spec large tangent wave)
            Positioned(
              bottom: -120,
              left: -120,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.10),
                ),
              ),
            ),
            // Card Content
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Squircle profile avatar with white border (84x84)
                      GestureDetector(
                        onTap: () => context.push('/my-profile'),
                        child: Container(
                          height: 84,
                          width: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.25),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: getImageWidget(
                              url: data.profileImage ?? myProfile?.photo1 ?? "",
                              boxFit: BoxFit.cover,
                              isMyPhoto: true,
                              imageWidth: 84,
                              imageHeight: 84,
                            ),
                          ),
                        ),
                      ),
                      const Gap(16),
                      // User details and premium badge
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.profileTitle ?? myProfile?.fullname ?? "",
                                style: AppFont.font(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            const Gap(4),
                            Text(
                              data.subTitle ?? subtitle,
                              style: AppFont.font(
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (ref.watch(
                              featureProvider('showPremiumBadge'),
                            )) ...[
                              const Gap(10),
                              // Premium / Upgrade badge (Dynamic Color)
                              GestureDetector(
                                onTap: () => context.push(
                                  hasActivePlan ? '/current-plan' : '/plans',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeBg,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: badgeBg.withValues(alpha: 0.35),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.workspace_premium_rounded,
                                        color: badgeFg,
                                        size: 13,
                                      ),
                                      const Gap(5),
                                      Text(
                                        (hasActivePlan
                                                ? 'premium_lbl'.tr
                                                : 'upgrade_plan'.tr)
                                            .toUpperCase(),
                                        style: AppFont.font(
                                          color: badgeFg,
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Gap(8),
                      // Right circle phone and verify actions
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
                ),
                // Progress section (Dynamic Colors)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'profile_completion_lbl'.tr,
                            style: AppFont.font(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${completeness.toInt()}%",
                            style: AppFont.font(
                              color:
                                  (progressStart.computeLuminance() -
                                              primaryColor.computeLuminance())
                                          .abs() <
                                      0.2
                                  ? const Color(0xFFFFD166)
                                  : progressStart,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      LinearPercentIndicator(
                        lineHeight: 8,
                        percent: (completeness / 100).clamp(0.0, 1.0),
                        linearGradient: LinearGradient(colors: progressColors),
                        backgroundColor: Colors.white.withValues(alpha: 0.80),
                        barRadius: const Radius.circular(10),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                const Gap(18),
                Divider(color: Colors.white.withValues(alpha: 0.12), height: 1),
                // Vertical Stats row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      if (ref.watch(featureProvider('enableVoiceCall')) ||
                          ref.watch(featureProvider('enableVideoCall'))) ...[
                        Expanded(
                          child: _heroStatItem(
                            svgPath: AppAssets.icProfileCardCall,
                            count: data.callCount?.toString() ?? "",
                            label: 'calls_lbl'.tr,
                            onTap: () => context.push('/call-history'),
                          ),
                        ),
                        _heroStatDivider(),
                      ],
                      Expanded(
                        child: _heroStatItem(
                          svgPath: AppAssets.icProfileCardMatch,
                          count: data.matchesCount?.toString() ?? "",
                          label: 'matches_lbl'.tr,
                          onTap: () {
                            ref
                                .read(homePageIndexProvider.notifier)
                                .setIndex(3);
                            context.go('/home');
                          },
                        ),
                      ),
                      if (ref.watch(featureProvider('enableChat'))) ...[
                        _heroStatDivider(),
                        Expanded(
                          child: _heroStatItem(
                            svgPath: AppAssets.icProfileCardChat,
                            count: data.chatCount?.toString() ?? "",
                            label: 'chats_lbl'.tr,
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
                ),
              ],
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

  Widget _heroStatDivider() {
    return Container(
      height: 38,
      width: 1.0,
      color: Colors.white.withValues(alpha: 0.12),
    );
  }

  Widget _heroStatItem({
    required String svgPath,
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.9),
                BlendMode.srcIn,
              ),
              width: 30,
              height: 30,
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  count,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.font(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.font(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
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
