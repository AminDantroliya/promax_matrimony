import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/widgets/generic_member_list_view.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import '../providers/activity_notifier.dart';
import '../widgets/blocked_member_list_item.dart';
import '../widgets/shortlisted_member_list_item.dart';
import '../widgets/call_history_list_item.dart';

import '../../../widgets/profile_cards/profile_card_widget.dart';

class ActivityMemberListScreen extends ConsumerStatefulWidget {
  final String url;
  final Map<String, dynamic>? extraParams;
  final String? noRecordMsg;
  final bool isGrid;

  const ActivityMemberListScreen({
    super.key,
    required this.url,
    this.extraParams,
    this.noRecordMsg,
    this.isGrid = false,
  });

  @override
  ConsumerState<ActivityMemberListScreen> createState() =>
      _ActivityMemberListScreenState();
}

class _ActivityMemberListScreenState
    extends ConsumerState<ActivityMemberListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(
            activityProvider(
              widget.url,
              extraParams: widget.extraParams,
            ).notifier,
          )
          .fetchActivityProfiles(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final position = _scrollController.position;
        if (position.maxScrollExtent > 0 &&
            position.userScrollDirection == ScrollDirection.reverse &&
            position.pixels >= position.maxScrollExtent - 200) {
          final state = ref.read(
            activityProvider(
              widget.url,
              extraParams: widget.extraParams,
            ),
          );
          final notifier = ref.read(
            activityProvider(
              widget.url,
              extraParams: widget.extraParams,
            ).notifier,
          );
          if (!state.isLoading && !state.isLoadingMore && notifier.hasMore) {
            notifier.fetchActivityProfiles(isRefresh: false);
          }
        }
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
    final activityState = ref.watch(
      activityProvider(widget.url, extraParams: widget.extraParams),
    );

    return GenericMemberListView(
      state: activityState,
      scrollController: _scrollController,
      isGrid: widget.isGrid,
      onRefresh: () => ref
          .read(
            activityProvider(
              widget.url,
              extraParams: widget.extraParams,
            ).notifier,
          )
          .fetchActivityProfiles(isRefresh: true),
      itemBuilder: (context, member, index) {
        if (widget.url == getBlockedListApi) {
          return BlockedMemberListItem(
            memberModel: member,
            index: index,
            url: widget.url,
          );
        }
        if (widget.url == getShortlistedListApi) {
          return ShortlistedMemberListItem(
            memberModel: member,
            index: index,
            url: widget.url,
          );
        }
        if (widget.url == videoCallHistoryListApi || widget.url == voiceCallHistoryListApi) {
          return CallHistoryListItem(
            member: member,
            index: index,
            isVideo: widget.url == videoCallHistoryListApi,
          );
        }
        if (widget.url == getViewedProfileListApi ||
            widget.url == getViewedContactListApi ||
            widget.url == getRecentJoinedListApi ||
            widget.url == getRecentLoginListApi ||
            widget.url == getFeaturedMemberListApi) {
          if (widget.isGrid) {
            return ProfileCardWidget(
              memberModel: member,
              cardStyle: 'card_4',
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProfileCardWidget(
              memberModel: member,
            ),
          );
        }
        return null; // Use default
      },
      noRecordMessage: widget.noRecordMsg,
    );
  }
}
