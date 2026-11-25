import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/widgets/home_ai_cards.dart';
import 'package:pro_matrimony/features/home/widgets/home_hero_card.dart';
import 'package:pro_matrimony/features/home/widgets/home_interests_received_section.dart';
import 'package:pro_matrimony/features/home/widgets/home_matches_section.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/features/home/widgets/home_plan_card.dart';
import 'package:pro_matrimony/features/home/widgets/home_profile_horizontal_list.dart';
import 'package:pro_matrimony/utils/utils.dart';

class Dashboard1View extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const Dashboard1View({
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
          // ── CATEGORY 1: Dark Purple Hero Card & Completion Bar ────────────
          HomeHeroCard(data: data, isDark: isDark),
          const Gap(20),

          // ── AI Recommendation Cards ───────────────────────────────────────
          if (ref.watch(featureProvider('enableAiMatchmaking'))) ...[
            HomeAICards(isDark: isDark),
            const Gap(20),
          ],

          // ── Interests Received Section ─────────────────────────────────────
          HomeInterestsReceivedSection(data: data, isDark: isDark),
          if (data.receivedInterest?.isNotEmpty == true) const Gap(24),

          // ── Segmented Matches Section ("Recent Login" vs "New Joined") ─────
          HomeMatchesSection(data: data),
          const Gap(24),

          // ── Recommended Matches List ──────────────────────────────────────
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

          // ── Premium Matches List ──────────────────────────────────────────
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

          // ── Dark Purple Membership Subscription Card ──────────────────────
          if (ref.watch(featureProvider('enableMembershipPlans'))) ...[
            HomePlanCard(data: data, isDark: isDark),
            const Gap(24),
          ],

          const Gap(100),
        ],
      ),
    );
  }
}
