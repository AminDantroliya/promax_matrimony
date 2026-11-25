import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/features/home/widgets/home_dedicated_match_grid.dart';
import 'package:pro_matrimony/features/home/widgets/home_hero_card_2.dart';
import 'package:pro_matrimony/features/home/widgets/home_interests_received_section.dart';
import 'package:pro_matrimony/features/home/widgets/home_plan_card_2.dart';
import 'package:pro_matrimony/features/matches/dynamic/screens/dynamic_ai_match_filter_screen.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';

class Dashboard2View extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const Dashboard2View({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyJoinedList = data.recentlyJoinedMember ?? [];
    final recentlyLoginList = data.recentlyLoginMember ?? [];

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),

          // ── 1. LIGHT HERO CARD WITH CIRCULAR PROGRESS ──────────────────────
          HomeHeroCard2(data: data, isDark: isDark),

          const Gap(18),

          // ── 2. HORIZONTAL AI TOOLS GRID ────────────────────────────────────
          if (ref.watch(featureProvider('enableAiMatchmaking'))) ...[
            _buildAiToolsRow(context, ref),
            const Gap(16),
          ],

          // ── 3. INTERESTS RECEIVED SECTION ──────────────────────────────────
          HomeInterestsReceivedSection(data: data, isDark: isDark),
          if (data.receivedInterest?.isNotEmpty == true) const Gap(16),

          // ── 4. RECENTLY JOIN DEDICATED SECTION ──────────────────────────────
          if (recentlyJoinedList.isNotEmpty) ...[
            HomeDedicatedMatchGrid(
              titlePrefix: '${'recently_joined'.tr.split(' ').first} ',
              titleSuffix: 'recently_joined'.tr.split(' ').length > 1
                  ? 'recently_joined'.tr.split(' ').sublist(1).join(' ')
                  : 'Join',
              list: recentlyJoinedList,
              onSeeAll: () => context.push('/recently-joined-matches'),
            ),
            const Gap(16),
          ],

          // ── 5. RECENTLY LOGIN DEDICATED SECTION ─────────────────────────────
          if (recentlyLoginList.isNotEmpty) ...[
            HomeDedicatedMatchGrid(
              titlePrefix: '${'recent_login_lbl'.tr.split(' ').first} ',
              titleSuffix: 'recent_login_lbl'.tr.split(' ').length > 1
                  ? 'recent_login_lbl'.tr.split(' ').sublist(1).join(' ')
                  : 'Login',
              list: recentlyLoginList,
              onSeeAll: () => context.push('/recently-login-matches'),
            ),
            const Gap(16),
          ],

          // ── 6. RECOMMENDED MATCHES SECTION ─────────────────────────────────
          if (data.recommedMatchesMember?.isNotEmpty == true) ...[
            HomeDedicatedMatchGrid(
              titlePrefix: '${'recommended_matches'.tr.split(' ').first} ',
              titleSuffix: 'recommended_matches'.tr.split(' ').length > 1
                  ? 'recommended_matches'.tr.split(' ').sublist(1).join(' ')
                  : '',
              list: data.recommedMatchesMember ?? [],
              onSeeAll: () {
                ref.read(matchesSelectedTabProvider.notifier).setTab(0);
                ref.read(homePageIndexProvider.notifier).setIndex(3);
              },
            ),
            const Gap(16),
          ],

          // ── 7. PREMIUM MATCHES SECTION ─────────────────────────────────────
          if (data.premiumMatchesMember?.isNotEmpty == true) ...[
            HomeDedicatedMatchGrid(
              titlePrefix: 'premium_space'.tr,
              titleSuffix: 'matches_lbl'.tr,
              list: data.premiumMatchesMember ?? [],
              onSeeAll: () {
                ref.read(matchesSelectedTabProvider.notifier).setTab(1);
                ref.read(homePageIndexProvider.notifier).setIndex(3);
              },
            ),
            const Gap(16),
          ],

          // ── 8. COMPACT MEMBERSHIP PLAN BANNER ──────────────────────────────
          if (ref.watch(featureProvider('enableMembershipPlans'))) ...[
            HomePlanCard2(data: data, isDark: isDark),
            const Gap(16),
          ],

          const Gap(75),
        ],
      ),
    );
  }

  Widget _buildAiToolsRow(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // AI Match Finder Card (Secondary Color Theme Gradient)
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DynamicAiMatchFilterScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      secondaryColor,
                      secondaryColor.withValues(alpha: 0.82),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: secondaryColor.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.icAIMatchCard,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ai_match_finder'.tr,
                            style: AppFont.font(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'personalized_by_ai'.tr,
                            style: AppFont.font(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Gap(4),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.figmaNavigationForward,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          height: 10,
                          width: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Gap(12),

          // Auto Send Interest Card (Primary Color Theme Gradient)
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final allowed = await checkAiInterestPermission(context, ref);
                if (allowed && context.mounted) {
                  context.push('/auto-send-interest');
                }
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      primaryColor.withValues(alpha: 0.82),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.icAIMatch,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'auto_send_interest'.tr,
                            style: AppFont.font(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'ai_sends_daily'.tr,
                            style: AppFont.font(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
