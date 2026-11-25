import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/common/data/models/member_models.dart';
import '../../activity/data/repositories/activity_repository.dart';
import '../../search/providers/search_notifier.dart';

part 'activity_notifier.g.dart';

@Riverpod(keepAlive: true)
class ActivityNotifier extends _$ActivityNotifier {
  bool _hasMore = true;
  bool _isFetching = false;
  DateTime? _lastFetchTime;

  @override
  PagingState<MemberListModel> build(String url, {Map<String, dynamic>? extraParams}) {
    _hasMore = true;
    _isFetching = false;
    _lastFetchTime = null;
    return const PagingState();
  }

  bool get hasMore => _hasMore;

  Future<void> fetchActivityProfiles({bool isRefresh = true}) async {
    if (isRefresh) {
      _hasMore = true;
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (_isFetching || state.isLoading || state.isLoadingMore || !_hasMore) return;
      if (_lastFetchTime != null &&
          DateTime.now().difference(_lastFetchTime!).inMilliseconds < 600) {
        return;
      }
      state = state.copyWith(isLoadingMore: true);
    }

    _isFetching = true;
    try {
      final repository = ref.read(activityRepositoryProvider);
      final pageToFetch = isRefresh ? 1 : state.page;
      final Map<String, dynamic> params = {
        "page": pageToFetch.toString(),
        "limit": "10",
      };
      
      if (extraParams != null) {
        params.addAll(extraParams!);
      }

      final response = await repository.getActivityProfileList(url, params);
      
      final rawList = response.data?.resultArr;
      final List<MemberListModel> newItems = rawList != null
          ? List<MemberListModel>.from(rawList)
          : <MemberListModel>[];
      final totalCount = response.data?.resultCount ?? 0;

      final currentItems = ref.mounted ? state.items : <MemberListModel>[];
      final List<MemberListModel> updatedItems = isRefresh
          ? newItems
          : <MemberListModel>[...currentItems, ...newItems];

      if (newItems.isEmpty || newItems.length < 10) {
        _hasMore = false;
      } else if (totalCount > 10 && updatedItems.length >= totalCount) {
        _hasMore = false;
      } else {
        _hasMore = true;
      }

      if (ref.mounted) {
        _lastFetchTime = DateTime.now();
        state = state.copyWith(
          items: updatedItems,
          totalCount: totalCount > 0 ? totalCount : updatedItems.length,
          page: pageToFetch + 1,
          isLoading: false,
          isLoadingMore: false,
        );
      }
    } catch (e) {
      _hasMore = false;
      if (ref.mounted) {
        state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
      }
    } finally {
      _isFetching = false;
    }
  }

  void updateMemberAction({
    required String memberId,
    bool? isShortlisted,
    bool? isInterested,
    bool? isBlocked,
    String? interestState,
  }) {
    final updatedItems = state.items.map((member) {
      if ((member.id ?? member.memberId).toString() == memberId) {
        return member.copyWith(
          isShortlisted: isShortlisted != null ? (isShortlisted ? 1 : 0) : member.isShortlisted,
          interestState: interestState ?? (isInterested != null ? (isInterested ? 'sent' : 'not_sent') : member.interestState),
          interestStatus: isInterested != null ? (isInterested ? 'Pending' : 'not_sent') : member.interestStatus,
          isBlock: isBlocked != null ? (isBlocked ? 1 : 0) : member.isBlock,
        );
      }
      return member;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void removeMember(String memberId) {
    final updatedItems = state.items.where((e) => (e.memberId ?? e.receiverMemberId ?? e.id).toString() != memberId).toList();
    state = state.copyWith(items: updatedItems, totalCount: state.totalCount - 1);
  }
}
