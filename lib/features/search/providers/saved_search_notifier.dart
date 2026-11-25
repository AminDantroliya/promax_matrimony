import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/search/data/models/search_models.dart';
import '../../../features/search/data/repositories/search_repository.dart';

part 'saved_search_notifier.freezed.dart';
part 'saved_search_notifier.g.dart';

@freezed
abstract class SavedSearchState with _$SavedSearchState {
  const factory SavedSearchState({
    @Default([]) List<SavedSearchFilter> resultList,
    @Default(1) int page,
    @Default(0) int totalCount,
    @Default(false) bool isLoadingMore,
    @Default(null) SavedSearchListResponseModel? response,
  }) = _SavedSearchState;
}

@riverpod
class SavedSearchNotifier extends _$SavedSearchNotifier {
  @override
  FutureOr<SavedSearchState> build() async {
    return _fetchSavedSearchList(1);
  }

  Future<SavedSearchState> _fetchSavedSearchList(int page) async {
    final params = {
      "page": page.toString(),
      "limit": "10",
    };
    final response = await ref.read(searchRepositoryProvider).getSavedSearchList(params);
    return SavedSearchState(
      resultList: response.data?.resultList ?? [],
      page: page,
      totalCount: response.data?.resultCount ?? 0,
      response: response,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchSavedSearchList(1));
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore || currentState.resultList.length >= currentState.totalCount) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.page + 1;
    final params = {
      "page": nextPage.toString(),
      "limit": "10",
    };

    try {
      final response = await ref.read(searchRepositoryProvider).getSavedSearchList(params);
      state = AsyncValue.data(currentState.copyWith(
        resultList: [...currentState.resultList, ...(response.data?.resultList ?? [])],
        page: nextPage,
        isLoadingMore: false,
        response: response,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSearch(String id) async {
    await ref.read(searchRepositoryProvider).deleteSavedSearch(id);
    refresh();
  }
}
