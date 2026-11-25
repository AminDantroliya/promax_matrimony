import 'package:flutter/material.dart';
import 'app_loading_widget.dart';
import 'app_no_records_widget.dart';
import '../features/common/data/models/member_models.dart';
import '../utils/utils.dart';
import 'package:gap/gap.dart';
import '../features/search/providers/search_notifier.dart';
import 'app_member_list_item.dart';
import '../utils/constants.dart';

typedef ItemBuilder<T> = Widget? Function(BuildContext context, T item, int index);

class GenericMemberListView<T> extends StatelessWidget {
  final PagingState<T> state;
  final ScrollController scrollController;
  final VoidCallback onRefresh;
  final ItemBuilder<T>? itemBuilder;
  final bool isGrid;
  final String? noRecordMessage;
  final bool showLoadingMore;

  const GenericMemberListView({
    super.key,
    required this.state,
    required this.scrollController,
    required this.onRefresh,
    this.itemBuilder,
    this.isGrid = false,
    this.noRecordMessage,
    this.showLoadingMore = true,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: AppLoadingWidget());
    }

    if (state.error != null && state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const Gap(16),
            customTextNormalStyle(
              "something_went_wrong".tr, 
              16, 
              TextAlign.center, 
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)
            ),
            const Gap(8),
            ElevatedButton(onPressed: onRefresh, child: Text("btn_retry".tr)),
          ],
        ),
      );
    }

    if (state.items.isEmpty && !state.isLoading) {
      return AppNoRecordsWidget(noRecordFoundMessage: noRecordMessage);
    }

    return Column(
      children: [
        Expanded(
          child: isGrid ? _buildGrid() : _buildList(),
        ),
        if (showLoadingMore && state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: LoadingPaginationWidget(show: true),
          ),
      ],
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: state.items.length,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        itemBuilder: (context, index) {
          final item = state.items[index];
          if (itemBuilder != null) {
            final customWidget = itemBuilder!(context, item, index);
            if (customWidget != null) return customWidget;
          }
          
          if (item is MemberListModel) {
            return AppMemberListItem(
              memberModel: item,
              index: index,
              design: listItemDesign,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildGrid() {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: GridView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items[index];
          if (itemBuilder != null) {
            final customWidget = itemBuilder!(context, item, index);
            if (customWidget != null) return customWidget;
          }
          
          if (item is MemberListModel) {
            return AppMemberListItem(
              memberModel: item,
              index: index,
              design: listItemDesign,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
