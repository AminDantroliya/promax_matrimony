import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/common/data/models/member_models.dart';
import '../../../features/search/data/models/search_models.dart';
import '../../../features/search/data/repositories/search_repository.dart';

part 'search_result_notifier.freezed.dart';
part 'search_result_notifier.g.dart';

@freezed
abstract class SearchResultState with _$SearchResultState {
  const factory SearchResultState({
    @Default([]) List<MemberListModel> memberList,
    @Default(1) int page,
    @Default(0) int totalCount,
    @Default(false) bool isLoadingMore,
    @Default(null) SearchResultListResponseModel? response,
    @Default({}) Map<String, dynamic> params,
  }) = _SearchResultState;
}

@riverpod
class SearchResultNotifier extends _$SearchResultNotifier {
  @override
  FutureOr<SearchResultState> build() async {
    return const SearchResultState();
  }

  Future<void> search(Map<String, dynamic> params) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final finalParams = {
        "page": "1",
        "limit": "10",
        ...params,
      };
      final response = await ref.read(searchRepositoryProvider).searchMembers(finalParams);
      return SearchResultState(
        memberList: response.data?.resultList ?? [],
        page: 1,
        totalCount: response.data?.resultCount ?? 0,
        params: params,
        response: response,
      );
    });
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore || currentState.memberList.length >= currentState.totalCount) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.page + 1;
    final finalParams = {
      "page": nextPage.toString(),
      "limit": "10",
      ...currentState.params,
    };

    try {
      final response = await ref.read(searchRepositoryProvider).searchMembers(finalParams);
      state = AsyncValue.data(currentState.copyWith(
        memberList: [...currentState.memberList, ...(response.data?.resultList ?? [])],
        page: nextPage,
        isLoadingMore: false,
        response: response,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
