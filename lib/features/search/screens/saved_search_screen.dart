import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';

import '../providers/search_notifier.dart';
import '../widgets/saved_search_list_item.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

class SavedSearchScreen extends ConsumerStatefulWidget {
  const SavedSearchScreen({super.key});

  @override
  ConsumerState<SavedSearchScreen> createState() => _SavedSearchScreenState();
}

class _SavedSearchScreenState extends ConsumerState<SavedSearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(savedSearchProvider.notifier).fetchSavedSearches(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        ref.read(savedSearchProvider.notifier).fetchSavedSearches(isRefresh: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(savedSearchProvider);

    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: AppLoadingWidget());
    }

    if (state.items.isEmpty && !state.isLoading) {
      return const AppNoRecordsWidget();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bookmark_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                    const Gap(6),
                    Text(
                      'all_searches_caps'.tr,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                        color: const Color(0xFF8D94AB),
                      ),
                    ),
                  ],
                ),
                Text(
                  'saved_count'.trParams({'count': state.totalCount.toString()}),
                  style: AppFont.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: state.items.length,
              padding: const EdgeInsets.only(bottom: 120),
              itemBuilder: (context, index) {
                return SavedSearchListItem(model: state.items[index]);
              },
            ),
          ),
          if (state.isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LoadingPaginationWidget(show: true),
            ),
        ],
      ),
    );
  }
}
