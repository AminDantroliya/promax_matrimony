import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/app_debug.dart';
import '../../../features/common/data/models/member_models.dart';
import '../../../features/matches/data/repositories/matches_repository.dart';
import '../../search/providers/search_notifier.dart';

part 'matches_notifier.g.dart';

@Riverpod(keepAlive: true)
class MatchesNotifier extends _$MatchesNotifier {
  bool _hasMore = true;
  bool _isFetching = false;
  DateTime? _lastFetchTime;

  @override
  PagingState<MemberListModel> build(String url) {
    _hasMore = true;
    _isFetching = false;
    _lastFetchTime = null;
    return const PagingState();
  }

  bool get hasMore => _hasMore;

  Future<void> fetchMatches({bool isRefresh = true}) async {
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
      final repository = ref.read(matchesRepositoryProvider);
      final pageToFetch = isRefresh ? 1 : state.page;
      final params = {
        "page": pageToFetch.toString(),
        "limit": "10",
      };

      final response = await repository.getMatches(url, params);
      
      final rawList = response.data?.resultList;
      final List<MemberListModel> newItems = rawList != null
          ? List<MemberListModel>.from(rawList)
          : <MemberListModel>[];
      final totalCount = response.data?.resultCount ?? 0;

      final currentItems = ref.mounted ? state.items : <MemberListModel>[];
      final List<MemberListModel> updatedItems = isRefresh
          ? newItems
          : <MemberListModel>[...currentItems, ...newItems];

      // Determine hasMore:
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
    } catch (e, stack) {
      printLog('MatchesNotifier fetchMatches error: $e\n$stack');
      _hasMore = false;
      if (ref.mounted) {
        state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    await fetchMatches(isRefresh: true);
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
          isBlock: isBlocked != null ? (isBlocked ? 1 : 0) : member.isBlock,
        );
      }
      return member;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }
}

@Riverpod(keepAlive: true)
class MemberActionNotifier extends _$MemberActionNotifier {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<bool> addInterest(String memberId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(matchesRepositoryProvider).addInterest(memberId);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> addShortlist(String memberId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(matchesRepositoryProvider).addShortlist(memberId);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> blockProfile(String memberId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(matchesRepositoryProvider).blockProfile(memberId);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}
