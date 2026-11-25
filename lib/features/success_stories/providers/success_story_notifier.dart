import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/success_stories/data/models/success_story_models.dart';
import '../data/repositories/success_story_repository.dart';
import '../../search/providers/search_notifier.dart';

part 'success_story_notifier.g.dart';

@riverpod
class SuccessStoryNotifier extends _$SuccessStoryNotifier {
  @override
  PagingState<SuccessStory> build() {
    return const PagingState();
  }

  Future<void> fetchSuccessStories({
    bool isRefresh = true,
    bool isPullToRefresh = false,
    String? type,
  }) async {
    if (isRefresh) {
      if (state.isLoading) return;
      state = state.copyWith(
        isLoading: true,
        isLoadingMore: false,
        page: 1,
        items: isPullToRefresh ? state.items : [],
      );
    } else {
      if (state.isLoading || state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(successStoryRepositoryProvider);
      final params = {
        "page": state.page.toString(),
        "limit": "10",
      };
      if (type != null && type.isNotEmpty) {
        params["type"] = type;
      }

      final response = await repository.getSuccessStoryList(params);
      
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
}

@riverpod
Future<SuccessStory> successStoryDetails(Ref ref, int storyId) async {
  final repository = ref.read(successStoryRepositoryProvider);
  final response = await repository.getSuccessStoryDetails({"success_story_id": storyId.toString()});
  if (response.data == null) {
    throw Exception(response.message ?? "Failed to load story details");
  }
  return response.data!;
}
