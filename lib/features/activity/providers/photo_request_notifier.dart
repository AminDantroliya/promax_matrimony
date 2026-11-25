import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/common/data/models/member_models.dart';
import '../../activity/data/repositories/activity_repository.dart';
import '../../../../utils/api_urls.dart';

part 'photo_request_notifier.freezed.dart';
part 'photo_request_notifier.g.dart';

@freezed
abstract class PhotoRequestState with _$PhotoRequestState {
  const factory PhotoRequestState({
    @Default([]) List<MemberListModel> items,
    @Default(1) int page,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(0) int totalCount,
    @Default(0) int sentCount,
    @Default(0) int receivedCount,
    @Default(0) int acceptedCount,
    @Default(0) int pendingReceivedCount,
    @Default('All') String statusFilter,
    Object? error,
  }) = _PhotoRequestState;
}

@riverpod
class PhotoRequestNotifier extends _$PhotoRequestNotifier {
  @override
  PhotoRequestState build(String type) {
    return const PhotoRequestState();
  }

  Future<void> fetchPhotoRequests({bool isRefresh = true, String? statusFilter}) async {
    final activeFilter = statusFilter ?? state.statusFilter;
    if (isRefresh) {
      state = state.copyWith(isLoading: true, page: 1, items: [], statusFilter: activeFilter);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(activityRepositoryProvider);
      
      // Map sent/received type to request_sent/request_received
      final apiType = type == "sent" ? "request_sent" : "request_received";

      final Map<String, dynamic> params = {
        "page": state.page.toString(),
        "limit": "10",
        "type": apiType,
      };

      if (activeFilter != "All") {
        params["response_status"] = activeFilter;
      }

      final response = await repository.getActivityProfileList(getPhotoRequestListApi, params);
      
      final newItems = response.data?.resultArr ?? [];
      final totalCount = response.data?.resultCount ?? 0;
      final sentCount = response.data?.sentCount ?? 0;
      final receivedCount = response.data?.receivedCount ?? 0;
      final acceptedCount = response.data?.acceptedCount ?? 0;
      final pendingReceivedCount = response.data?.pendingReceivedCount ?? 0;

      state = state.copyWith(
        items: isRefresh ? newItems : [...state.items, ...newItems],
        totalCount: totalCount,
        sentCount: sentCount,
        receivedCount: receivedCount,
        acceptedCount: acceptedCount,
        pendingReceivedCount: pendingReceivedCount,
        page: state.page + 1,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
    }
  }

  Future<bool> performAction(String id, String action) async {
    try {
      final repository = ref.read(activityRepositoryProvider);
      if (action.toLowerCase() == "remove") {
        final params = {
          "photo_request_id": id,
        };
        final status = await repository.activityAction(removePhotoRequestApi, params);
        if (status == "success") {
          fetchPhotoRequests(isRefresh: true);
          return true;
        }
      } else {
        final params = {
          "photo_request_id": id,
          "action": action.toLowerCase() == "accepted" || action.toLowerCase() == "accept"
              ? "accept"
              : "reject",
        };
        final status = await repository.activityAction(photoRequestActionApi, params);
        if (status == "success") {
          fetchPhotoRequests(isRefresh: true);
          return true;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
