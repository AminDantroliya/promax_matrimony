import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/features/home/widgets/home_ai_hero_banner.dart';
import 'package:pro_matrimony/features/home/widgets/home_compact_profile_bar.dart';
import 'package:pro_matrimony/features/home/widgets/home_interests_received_section.dart';
import 'package:pro_matrimony/features/home/widgets/home_matches_section.dart';
import 'package:pro_matrimony/features/home/widgets/home_plan_progress_card.dart';
import 'package:pro_matrimony/features/home/widgets/home_profile_horizontal_list.dart';
import 'package:pro_matrimony/features/home/widgets/home_stats_row.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';

class Dashboard3View extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const Dashboard3View({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),

          // ── 1. COMPACT PROFILE BAR & PROGRESS LINE ─────────────────────────
          HomeCompactProfileBar(data: data, isDark: isDark),

          const Gap(16),

          // ── 2. 3 QUICK STATS CARDS ─────────────────────────────────────────
          HomeStatsRow(data: data, isDark: isDark),

          const Gap(18),

          // ── 3. AI HERO BANNER & AI INTEREST CARD ───────────────────────────
          if (ref.watch(featureProvider('enableAiMatchmaking'))) ...[
            if (ref.watch(featureProvider('showAiHeroBanner'))) ...[
              HomeAiHeroBanner(isDark: isDark),
              const Gap(12),
            ],
            _buildAiInterestCard(context, ref, isDark),
            const Gap(18),
          ],

          // ── 4. INTERESTS RECEIVED SECTION ─────────────────────────────────
          HomeInterestsReceivedSection(data: data, isDark: isDark),
          if (data.receivedInterest?.isNotEmpty == true) const Gap(24),

          // ── 5. SEGMENTED MATCHES SECTION ───────────────────────────────────
          HomeMatchesSection(data: data),
          const Gap(24),

          // ── 6. RECOMMENDED MATCHES ────────────────────────────────────────
          HomeProfileHorizontalList(
            titlePrefix: '${'recommended_matches'.tr} ',
            titleSuffix: '',
            list: data.recommedMatchesMember ?? [],
            onViewAll: () {
              ref.read(matchesSelectedTabProvider.notifier).setTab(0);
              ref.read(homePageIndexProvider.notifier).setIndex(3);
            },
          ),
          if (data.recommedMatchesMember?.isNotEmpty == true) const Gap(24),

          // ── 7. PREMIUM MATCHES ──────────────────────────────────────────
          HomeProfileHorizontalList(
            titlePrefix: 'premium_space'.tr,
            titleSuffix: 'matches_lbl'.tr,
            list: data.premiumMatchesMember ?? [],
            onViewAll: () {
              ref.read(matchesSelectedTabProvider.notifier).setTab(1);
              ref.read(homePageIndexProvider.notifier).setIndex(3);
            },
          ),
          if (data.premiumMatchesMember?.isNotEmpty == true) const Gap(24),

          // ── 8. DETAILED MEMBERSHIP PROGRESS CARD ───────────────────────────
          if (ref.watch(featureProvider('enableMembershipPlans'))) ...[
            HomePlanProgressCard(data: data, isDark: isDark),
            const Gap(24),
          ],

          const Gap(100),
        ],
      ),
    );
  }

  Widget _buildAiInterestCard(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          final allowed = await checkAiInterestPermission(context, ref);
          if (allowed && context.mounted) {
            context.push('/auto-send-interest');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? theme.colorScheme.surface : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : const Color(0xFFF1F3F9),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SvgPicture.asset(
                  AppAssets.icAIMatch,
                  colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'auto_send_interest'.tr,
                            style: AppFont.font(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : const Color(0xFF16182F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'AI',
                            style: AppFont.font(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(3),
                    Text(
                      'ai_sends_daily_top_matches'.tr,
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? const Color(0xFF8E90A6)
                            : const Color(0xFF7A7A8C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaNavigationForward,
                    colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    height: 12,
                    width: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
