import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/features/matches/screens/matches_list_screen.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/utils.dart';

class MatchesTabScreen extends ConsumerStatefulWidget {
  const MatchesTabScreen({super.key});

  @override
  ConsumerState<MatchesTabScreen> createState() => _MatchesTabScreenState();
}

class _MatchesTabScreenState extends ConsumerState<MatchesTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialTab = ref.read(matchesSelectedTabProvider);
    final safeInitial = initialTab >= 0 && initialTab < 4 ? initialTab : 0;
    _tabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: safeInitial,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final currentTab = ref.read(matchesSelectedTabProvider);
      if (currentTab != _tabController.index) {
        ref
            .read(matchesSelectedTabProvider.notifier)
            .setTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(matchesSelectedTabProvider);
    final safeTab = selectedTab >= 0 && selectedTab < 4 ? selectedTab : 0;

    ref.listen<int>(matchesSelectedTabProvider, (previous, next) {
      final target = next >= 0 && next < 4 ? next : 0;
      if (_tabController.index != target) {
        _tabController.animateTo(target);
      }
    });

    if (_tabController.index != safeTab && !_tabController.indexIsChanging) {
      _tabController.index = safeTab;
    }

    return Column(
      children: [
        AppTabBar(
          tabs: [
            'recommended_tab'.tr,
            'premium_tab'.tr,
            'near_by_me_tab'.tr,
            'suggested_tab'.tr,
          ],
          selectedIndex: safeTab,
          onTap: (v) {
            _tabController.animateTo(v);
            ref.read(matchesSelectedTabProvider.notifier).setTab(v);
          },
        ),
        const Gap(6),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MatchesListScreen(
                url: getRecommendedMatchesApi,
                title: 'recommended_tab'.tr,
                hasBottomNavBar: true,
              ),
              MatchesListScreen(
                url: getPremiumMatchesApi,
                title: 'premium_tab'.tr,
                hasBottomNavBar: true,
              ),
              MatchesListScreen(
                url: getNearByMeMatchesApi,
                title: 'near_by_me_tab'.tr,
                hasBottomNavBar: true,
              ),
              MatchesListScreen(
                url: getSuggestedMatchesApi,
                title: 'suggested_tab'.tr,
                hasBottomNavBar: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
