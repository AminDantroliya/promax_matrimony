import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/app_debug.dart';
import '../../common/data/models/member_models.dart';
import '../../profile/providers/profile_notifier.dart';
import '../data/models/search_models.dart';
import '../data/repositories/search_repository.dart';
import 'search_notifier.dart';

part 'matches_notifier.g.dart';

enum MatchType { recommended, premium, suggested, admin, recentlyJoined, recentlyLogin }

@Riverpod(keepAlive: true)
class MatchesNotifier extends _$MatchesNotifier {
  bool _hasMore = true;
  bool _isFetching = false;
  DateTime? _lastFetchTime;

  @override
  PagingState<MemberListModel> build(MatchType type) {
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
      final repository = ref.read(searchRepositoryProvider);
      final myProfile = ref.read(myProfileProvider).value;
      final isPersonalized = myProfile?.userType?.toString() == "1";
      final pageToFetch = isRefresh ? 1 : state.page;

      final params = {
        "page": pageToFetch.toString(),
        "limit": "10",
      };

      if (type == MatchType.suggested && !isPersonalized) {
        params["type"] = "suggested";
      }

      final response = await _fetchByType(repository, params, isPersonalized: isPersonalized);
      
      final rawList = response.data?.resultList;
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
    } catch (e, stack) {
      printLog('Search MatchesNotifier fetchMatches error: $e\n$stack');
      _hasMore = false;
      if (ref.mounted) {
        state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> updateMatchAction(String matchId, String action) async {
    try {
      final repository = ref.read(searchRepositoryProvider);
      await repository.updateAdminMatchAction(matchId, action);
      
      dynamic newResponse;
      if (action == "accept" || action == "1") {
        newResponse = 1;
      } else if (action == "reject" || action == "2") {
        newResponse = 2;
      }
      
      state = state.copyWith(
        items: state.items.map((item) {
          if (item.id?.toString() == matchId) {
            return item.copyWith(response: newResponse);
          }
          return item;
        }).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchResultListResponseModel> _fetchByType(
    SearchRepository repository,
    Map<String, dynamic> params, {
    required bool isPersonalized,
  }) {
    switch (type) {
      case MatchType.recommended:
        return repository.getRecommendedMatches(params);
      case MatchType.premium:
        return repository.getPremiumMatches(params);
      case MatchType.suggested:
        if (isPersonalized) {
          return repository.getPersonalizedAdminMatches(params);
        }
        return repository.getSuggestedMatches(params);
      case MatchType.admin:
        return repository.getAdminMatches(params);
      case MatchType.recentlyJoined:
        return repository.getRecentlyJoinedMatches(params);
      case MatchType.recentlyLogin:
        return repository.getRecentlyLoginMatches(params);
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
          isBlock: isBlocked != null ? (isBlocked ? 1 : 0) : member.isBlock,
        );
      }
      return member;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }
}
