import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/glassmorphic_background.dart';

import '../dynamic/screens/dynamic_advanced_search_screen.dart';
import '../dynamic/screens/dynamic_quick_search_screen.dart';
import 'id_search_screen.dart';
import 'saved_search_screen.dart';
import '../providers/search_notifier.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
       if (_tabController.indexIsChanging) return;
       ref.read(searchTabProvider.notifier).setTab(_tabController.index);
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
    ref.listen<int>(searchTabProvider, (previous, next) {
      if (next != _tabController.index) {
        _tabController.animateTo(next);
        setState(() {
          _selectedTab = next;
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassmorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppAppBar(title: 'search'.tr, isShowActions: false),
              _buildTabSelector(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    DynamicQuickSearchScreen(),
                    DynamicAdvancedSearchScreen(),
                    IdSearchScreen(),
                    SavedSearchScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: CustomSlidingSegmentedControl<int>(
        initialValue: _selectedTab,
        isStretch: true,
        children: {
          0: _tabText('quick'.tr, 0),
          1: _tabText('advanced'.tr, 1),
          2: _tabText('by_id'.tr, 2),
          3: _tabText('saved'.tr, 3),
        },
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(50),
        ),
        thumbDecoration: BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        onValueChanged: (v) {
          ref.read(searchTabProvider.notifier).setTab(v);
          setState(() {
            _selectedTab = v;
            _tabController.animateTo(v);
          });
        },
      ),
    );
  }

  Widget _tabText(String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        label,
        style: TextStyle(
          color: _selectedTab == index ? Colors.white : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
