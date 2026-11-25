import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import '../../profile/providers/profile_notifier.dart';
import '../utils/home_helpers.dart';

class HomeHeroCard2 extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const HomeHeroCard2({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;
    final config = ref.watch(appConfigProvider);
    final myProfile = ref.watch(myProfileProvider).value;
    final hasActivePlan = HomeHelpers.hasActivePlan(
      data: data,
      myProfile: myProfile,
    );

    final badgeBg = config.premiumBadgeColor ?? primaryColor;
    final badgeFg = config.premiumBadgeTextColor ?? Colors.white;
    final progressColor = config.progressColor ?? primaryColor;

    final completionPct = data.profilePercentage != null
        ? (int.tryParse(data.profilePercentage.toString()) ?? 0)
        : 0;
    final photoUrl = data.profileImage;
    final title = data.profileTitle ?? '';
    final subtitle = data.subTitle ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Photo & Info gesture target
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/my-profile'),
                  child: Row(
                    children: [
                      // Profile Photo with Pink Ring
                      Stack(
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: (photoUrl != null && photoUrl.isNotEmpty)
                                  ? Image.network(
                                      photoUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, stack) =>
                                          Image.asset(AppAssets.placeholderMale),
                                    )
                                  : Image.asset(AppAssets.placeholderMale),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title.isNotEmpty)
                              Text(
                                title,
                                style: AppFont.font(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF16182F),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (subtitle.isNotEmpty) ...[
                              const Gap(3),
                              Text(
                                subtitle,
                                style: AppFont.font(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF8A90A6),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            if (ref.watch(featureProvider('showPremiumBadge'))) ...[
                              const Gap(8),
                              // Premium / Upgrade Badge Button
                              GestureDetector(
                                onTap: () => context.push(
                                  hasActivePlan ? '/current-plan' : '/plans',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeBg,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icPremium,
                                        colorFilter: ColorFilter.mode(
                                          badgeFg,
                                          BlendMode.srcIn,
                                        ),
                                        height: 12,
                                        width: 12,
                                      ),
                                      const Gap(4),
                                      Text(
                                        (hasActivePlan
                                                ? 'premium_member'.tr
                                                : 'upgrade_plan'.tr)
                                            .toUpperCase(),
                                        style: AppFont.font(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          color: badgeFg,
                                          letterSpacing: 0.5,
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
                    ],
                  ),
                ),
              ),
              const Gap(10),
              // Circular Progress Indicator
              GestureDetector(
                onTap: () => context.push('/my-profile'),
                child: SizedBox(
                  width: 62,
                  height: 62,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 62,
                        height: 62,
                        child: CircularProgressIndicator(
                          value: (completionPct / 100.0).clamp(0.0, 1.0),
                          strokeWidth: 3.5,
                          strokeCap: StrokeCap.round,
                          backgroundColor:
                              progressColor.withValues(alpha: 0.12),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(progressColor),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$completionPct%',
                            style: AppFont.font(
                              fontSize: completionPct >= 100 ? 11 : 12,
                              fontWeight: FontWeight.w800,
                              color: progressColor,
                              letterSpacing: -0.4,
                              height: 1.1,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            'done_caps'.tr,
                            style: AppFont.font(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8A90A6),
                              letterSpacing: 0.2,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const Gap(16),

          // 3 Light Stat Cards (Calls, Matches, Chats)
          Row(
            children: [
              Expanded(
                child: _buildLightStatCard(
                  context: context,
                  iconAsset: AppAssets.icProfileCardCall,
                  iconColor: primaryColor,
                  bgColor: primaryColor.withValues(alpha: 0.08),
                  count: '${data.callCount ?? 0}',
                  label: 'calls_caps'.tr,
                  onTap: () => context.push('/call-history'),
                ),
              ),
              const Gap(10),
              Expanded(
                child: _buildLightStatCard(
                  context: context,
                  iconAsset: AppAssets.icProfileCardMatch,
                  iconColor: secondaryColor,
                  bgColor: secondaryColor.withValues(alpha: 0.08),
                  count: '${data.matchesCount ?? 0}',
                  label: 'matches_caps'.tr,
                  onTap: () {
                    ref.read(homePageIndexProvider.notifier).setIndex(3);
                    context.go('/home');
                  },
                ),
              ),
              const Gap(10),
              Expanded(
                child: _buildLightStatCard(
                  context: context,
                  iconAsset: AppAssets.icProfileCardChat,
                  iconColor: primaryColor,
                  bgColor: primaryColor.withValues(alpha: 0.14),
                  count: '${data.chatCount ?? 0}',
                  label: 'chats_caps'.tr,
                  onTap: () {
                    ref.read(homePageIndexProvider.notifier).setIndex(2);
                    context.go('/home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLightStatCard({
    required BuildContext context,
    required String iconAsset,
    required Color iconColor,
    required Color bgColor,
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              height: 16,
              width: 16,
            ),
            const Gap(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: AppFont.font(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF16182F),
                  ),
                ),
                Text(
                  label,
                  style: AppFont.font(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8A90A6),
                    letterSpacing: 0.5,
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
