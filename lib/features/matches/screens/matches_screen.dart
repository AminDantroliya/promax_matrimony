import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import 'matches_list_screen.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
       if (_tabController.indexIsChanging) return;
       setState(() {
         _selectedTab = _tabController.index;
       });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'match'.tr, isShowActions: false),
            AppPillTabBar(
              tabs: ['recommended_tab'.tr, 'premium_tab'.tr, 'suggested_tab'.tr],
              selectedIndex: _selectedTab,
              onTap: (v) {
                setState(() {
                  _selectedTab = v;
                  _tabController.animateTo(v);
                });
              },
              isScrollable: true,
            ),
            const Gap(10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MatchesListScreen(url: getRecommendedMatchesApi, title: 'recommended_tab'.tr),
                  MatchesListScreen(url: getPremiumMatchesApi, title: 'premium_tab'.tr),
                  MatchesListScreen(url: getSuggestedMatchesApi, title: 'suggested_tab'.tr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
