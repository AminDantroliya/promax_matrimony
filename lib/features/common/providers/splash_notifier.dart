import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  FutureOr<void> build() async {
    // Perform initialization logic here
    await Future.delayed(const Duration(seconds: 2));
  }
}
