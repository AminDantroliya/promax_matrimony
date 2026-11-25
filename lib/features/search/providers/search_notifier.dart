import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/common/data/models/member_models.dart';
import '../../../features/search/data/models/search_models.dart';
import '../../../features/search/data/repositories/search_repository.dart';

part 'search_notifier.freezed.dart';
part 'search_notifier.g.dart';

@freezed
abstract class SearchCriteria with _$SearchCriteria {
  const factory SearchCriteria({
    String? gender,
    String? fromAge,
    String? toAge,
    String? fromHeight,
    String? toHeight,
    String? religion,
    String? caste,
    String? country,
    String? state,
    String? city,
    String? maritalStatus,
    String? education,
    String? occupation,
    String? income,
    String? manglik,
    String? employeeIn,
    String? designation,
    String? eatingHabits,
    String? smoking,
    String? drinking,
    String? star,
    String? motherTongue,
    String? keyword,
    String? matriId,
    String? photoSearch,
    String? verifyStatus,
  }) = _SearchCriteria;

  factory SearchCriteria.empty() => const SearchCriteria();
}

@Riverpod(keepAlive: true)
class SearchCriteriaNotifier extends _$SearchCriteriaNotifier {
  @override
  SearchCriteria build() {
    return SearchCriteria.empty();
  }

  void updateCriteria(SearchCriteria criteria) {
    state = criteria;
  }

  void clearCriteria() {
    state = SearchCriteria.empty();
  }
}

@freezed
abstract class PagingState<T> with _$PagingState<T> {
  const factory PagingState({
    @Default([]) List<T> items,
    @Default(1) int page,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(0) int totalCount,
    Object? error,
  }) = _PagingState<T>;
}

@Riverpod(keepAlive: true)
class SearchResultNotifier extends _$SearchResultNotifier {
  bool _hasMore = true;
  bool _isFetching = false;
  DateTime? _lastFetchTime;

  @override
  PagingState<MemberListModel> build() {
    _hasMore = true;
    _isFetching = false;
    _lastFetchTime = null;
    return const PagingState();
  }

  bool get hasMore => _hasMore;

  Future<void> search({bool isRefresh = true}) async {
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
      final criteria = ref.read(searchCriteriaProvider);
      final repository = ref.read(searchRepositoryProvider);
      final pageToFetch = isRefresh ? 1 : state.page;
      
      final params = {
        "page": pageToFetch.toString(),
        "limit": "10",
      };

      if (criteria.gender != null) params["gender"] = criteria.gender!;
      if (criteria.fromAge != null) params["part_frm_age"] = criteria.fromAge!;
      if (criteria.toAge != null) params["part_to_age"] = criteria.toAge!;
      if (criteria.fromHeight != null) params["part_height"] = criteria.fromHeight!;
      if (criteria.toHeight != null) params["part_height_to"] = criteria.toHeight!;
      if (criteria.religion != null) params["religion"] = criteria.religion!;
      if (criteria.caste != null) params["caste"] = criteria.caste!;
      if (criteria.country != null) params["country_id"] = criteria.country!;
      if (criteria.state != null) params["state_id"] = criteria.state!;
      if (criteria.city != null) params["city"] = criteria.city!;
      if (criteria.maritalStatus != null) params["marital_status"] = criteria.maritalStatus!;
      if (criteria.education != null) params["education_level"] = criteria.education!;
      if (criteria.occupation != null) params["occupation"] = criteria.occupation!;
      if (criteria.income != null) params["income"] = criteria.income!;
      if (criteria.manglik != null) params["manglik"] = criteria.manglik!;
      if (criteria.motherTongue != null) params["mother_tongue"] = criteria.motherTongue!;
      if (criteria.keyword != null) params["keyword_search"] = criteria.keyword!;
      if (criteria.matriId != null) params["id_search"] = criteria.matriId!;
      if (criteria.photoSearch != null) params["photo_search"] = criteria.photoSearch!;
      if (criteria.employeeIn != null) params["employee_in"] = criteria.employeeIn!;
      if (criteria.designation != null) params["designation_level"] = criteria.designation!;
      if (criteria.eatingHabits != null) params["diet"] = criteria.eatingHabits!;
      if (criteria.smoking != null) params["smoke"] = criteria.smoking!;
      if (criteria.drinking != null) params["drink"] = criteria.drinking!;
      if (criteria.star != null) params["star"] = criteria.star!;
      if (criteria.verifyStatus != null) params["verify_status"] = criteria.verifyStatus!;

      final response = await repository.searchMembers(params);
      
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
    final updatedItems = state.items.where((e) => (e.id ?? e.memberId).toString() != memberId).toList();
    state = state.copyWith(items: updatedItems, totalCount: state.totalCount - 1);
  }
}

@riverpod
class SavedSearchNotifier extends _$SavedSearchNotifier {
  @override
  PagingState<SavedSearchFilter> build() {
    return const PagingState();
  }

  Future<void> fetchSavedSearches({bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(searchRepositoryProvider);
      final params = {
        "page": state.page.toString(),
        "limit": "10",
      };

      final response = await repository.getSavedSearchList(params);
      
      final newItems = response.data?.resultList ?? [];
      final totalCount = response.data?.resultCount ?? 0;

      state = state.copyWith(
        items: isRefresh ? newItems : [...state.items, ...newItems],
        totalCount: totalCount,
        page: state.page + 1,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
    }
  }

  Future<bool> deleteSavedSearch(String id) async {
    try {
      final repository = ref.read(searchRepositoryProvider);
      await repository.deleteSavedSearch(id);
      state = state.copyWith(
        items: state.items.where((e) => e.id.toString() != id).toList(),
        totalCount: state.totalCount - 1,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveSearch(Map<String, dynamic> params) async {
    try {
      final repository = ref.read(searchRepositoryProvider);
      await repository.saveSearch(params);
      fetchSavedSearches(isRefresh: true);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class SearchTabNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setTab(int val) {
    state = val;
  }
}

final searchTabProvider = NotifierProvider<SearchTabNotifier, int>(SearchTabNotifier.new);
