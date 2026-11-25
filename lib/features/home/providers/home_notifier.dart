import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@Riverpod(keepAlive: true)
class HomePageIndex extends _$HomePageIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}

@Riverpod(keepAlive: true)
class MatchesSelectedTab extends _$MatchesSelectedTab {
  @override
  int build() => 0;

  void setTab(int index) {
    state = index;
  }
}
