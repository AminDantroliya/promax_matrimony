import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/search/dynamic/screens/dynamic_quick_search_screen.dart';
import 'package:pro_matrimony/features/search/dynamic/screens/dynamic_advanced_search_screen.dart';
import 'package:pro_matrimony/features/search/screens/keyword_search_screen.dart';
import 'package:pro_matrimony/features/search/screens/id_search_screen.dart';
import 'package:pro_matrimony/features/search/screens/saved_search_screen.dart';
import 'package:pro_matrimony/utils/utils.dart';

class SearchTabScreen extends ConsumerStatefulWidget {
  const SearchTabScreen({super.key});

  @override
  ConsumerState<SearchTabScreen> createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends ConsumerState<SearchTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener(() {
      if (mounted && !_tabController.indexIsChanging) {
        setState(() {});
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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            const Gap(10),
            AppTabBar(
              tabs: [
                'quick'.tr,
                'advanced'.tr,
                'keyword'.tr,
                'by_id'.tr,
                'saved'.tr,
              ],
              icons: const [
                Icon(Icons.auto_awesome_rounded),
                Icon(Icons.tune_rounded),
                Icon(Icons.abc_rounded),
                Icon(Icons.tag_rounded),
                Icon(Icons.bookmark_outline_rounded),
              ],
              selectedIndex: _tabController.index,
              onTap: (index) => _tabController.animateTo(index),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const DynamicQuickSearchScreen(),
                  const DynamicAdvancedSearchScreen(),
                  const KeywordSearchScreen(),
                  const IdSearchScreen(),
                  const SavedSearchScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
