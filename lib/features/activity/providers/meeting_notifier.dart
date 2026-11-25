import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/features/search/providers/search_notifier.dart';
import 'package:pro_matrimony/features/activity/data/repositories/activity_repository.dart';

part 'meeting_notifier.g.dart';

@riverpod
class MeetingNotifier extends _$MeetingNotifier {
  @override
  PagingState<MemberListModel> build() {
    return const PagingState();
  }

  Future<void> fetchMeetings({bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(activityRepositoryProvider);
      final params = {
        "page": state.page.toString(),
        "limit": "10",
      };

      final response = await repository.getMeetingList(params);
      
      final newItems = response.data?.resultArr ?? [];
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

  void removeMeeting(int index) {
    final updatedItems = List<MemberListModel>.from(state.items)..removeAt(index);
    state = state.copyWith(items: updatedItems, totalCount: state.totalCount - 1);
  }
}

