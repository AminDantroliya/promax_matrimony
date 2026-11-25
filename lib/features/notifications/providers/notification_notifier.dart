import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/notifications/data/models/notification_models.dart';
import '../../../preference/session_keys.dart';
import '../../../services/app_session_service.dart';
import '../data/repositories/notification_repository.dart';
import '../../search/providers/search_notifier.dart';
import '../../home/providers/dashboard_notifier.dart';

part 'notification_notifier.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  PagingState<NotificationItem> build() {
    return const PagingState();
  }

  Set<String> _getReadIds() {
    final list = AppSessionService.getValue(SessionDetail.kReadNotificationIds);
    if (list is List) {
      return list.map((e) => e.toString()).toSet();
    }
    return <String>{};
  }

  void _saveReadIds(Set<String> ids) {
    final list = ids.toList();
    if (list.length > 500) {
      list.removeRange(0, list.length - 500);
    }
    AppSessionService.setValue(SessionDetail.kReadNotificationIds, list);
  }

  int get unreadCount => state.items.where((e) {
        final isRead = e.isRead == true ||
            e.isRead == 1 ||
            e.isRead == "1" ||
            e.isRead?.toString().toLowerCase() == "true";
        return !isRead;
      }).length;

  void markAsRead(dynamic itemId) {
    if (itemId == null) return;
    final idStr = itemId.toString();
    final readIds = _getReadIds()..add(idStr);
    _saveReadIds(readIds);

    final updatedItems = state.items.map((item) {
      if (item.id?.toString() == idStr) {
        return item.copyWith(isRead: "1");
      }
      return item;
    }).toList();
    state = state.copyWith(items: updatedItems);
  }

  void markAllAsRead() {
    ref.read(dashboardProvider.notifier).clearNotificationBadge();
    if (state.items.isEmpty) return;
    final readIds = _getReadIds();
    for (final item in state.items) {
      if (item.id != null) {
        readIds.add(item.id.toString());
      }
    }
    _saveReadIds(readIds);

    final updatedItems = state.items.map((item) {
      return item.copyWith(isRead: "1");
    }).toList();
    state = state.copyWith(items: updatedItems);
  }

  Future<void> fetchNotifications({bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(notificationRepositoryProvider);
      final params = {
        "page": state.page.toString(),
        "limit": "10",
      };

      final response = await repository.getNotificationList(params);

      final newItems = response.data?.resultList ?? [];
      final totalCount = response.data?.resultCount ?? 0;

      final readIds = _getReadIds();
      final allRawItems = isRefresh ? newItems : [...state.items, ...newItems];

      final items = allRawItems.map((item) {
        final itemId = item.id?.toString();
        final isApiRead = item.isRead == 1 ||
            item.isRead == "1" ||
            item.isRead == true ||
            item.isRead?.toString().toLowerCase() == "true";
        if (isApiRead || (itemId != null && readIds.contains(itemId))) {
          return item.copyWith(isRead: "1");
        }
        return item.copyWith(isRead: "0");
      }).toList();

      state = state.copyWith(
        items: items,
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
int unreadNotificationCount(Ref ref) {
  return ref.watch(notificationProvider).items.where((e) {
    final isRead = e.isRead == true ||
        e.isRead == 1 ||
        e.isRead == "1" ||
        e.isRead?.toString().toLowerCase() == "true";
    return !isRead;
  }).length;
}
