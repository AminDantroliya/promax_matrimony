import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import 'matches_list_screen.dart';

class MatchesHubScreen extends ConsumerStatefulWidget {
  const MatchesHubScreen({super.key});

  @override
  ConsumerState<MatchesHubScreen> createState() => _MatchesHubScreenState();
}

class _MatchesHubScreenState extends ConsumerState<MatchesHubScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabAnimation);
  }

  void _handleTabAnimation() {
    if (_tabController.indexIsChanging) return;
    if (_selectedTab != _tabController.index) {
      setState(() {
        _selectedTab = _tabController.index;
      });
    }
  }

  void _syncTabController(int targetLength) {
    if (_tabController.length != targetLength) {
      _tabController.removeListener(_handleTabAnimation);
      _tabController.dispose();
      final newIndex = _selectedTab >= targetLength ? targetLength - 1 : _selectedTab;
      _tabController = TabController(length: targetLength, vsync: this, initialIndex: newIndex);
      _selectedTab = newIndex;
      _tabController.addListener(_handleTabAnimation);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabAnimation);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enableAdminMatches = ref.watch(featureProvider('enableAdminMatches'));

    final tabs = [
      'recommended_matches'.tr,
      'premium_matches'.tr,
      'suggested_matches'.tr,
      if (enableAdminMatches) 'admin_matches'.tr,
    ];

    final views = [
      MatchesListScreen(url: getRecommendedMatchesApi, title: 'recommended_matches'.tr),
      MatchesListScreen(url: getPremiumMemberMatchesApi, title: 'premium_matches'.tr),
      MatchesListScreen(url: getSuggestedMatchesApi, title: 'suggested_matches'.tr),
      if (enableAdminMatches) MatchesListScreen(url: getAdminMatchesApi, title: 'admin_matches'.tr),
    ];

    _syncTabController(tabs.length);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'matches'.tr, isShowActions: false),
            _buildTabSelector(tabs),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: views,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector(List<String> tabs) {
    return AppPillTabBar(
      tabs: tabs,
      selectedIndex: _selectedTab,
      onTap: (v) {
        setState(() {
          _selectedTab = v;
          _tabController.animateTo(v);
        });
      },
      isScrollable: true,
    );
  }
}
