import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_notifier.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  int build() {
    return 0; // Initial unreadNotificationCount
  }

  void updateUnreadCount(int count) {
    state = count;
  }
}
