// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePageIndex)
final homePageIndexProvider = HomePageIndexProvider._();

final class HomePageIndexProvider
    extends $NotifierProvider<HomePageIndex, int> {
  HomePageIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePageIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homePageIndexHash();

  @$internal
  @override
  HomePageIndex create() => HomePageIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$homePageIndexHash() => r'dfc9e44a734de5a727b45994b8efebcb72fe32c1';

abstract class _$HomePageIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(MatchesSelectedTab)
final matchesSelectedTabProvider = MatchesSelectedTabProvider._();

final class MatchesSelectedTabProvider
    extends $NotifierProvider<MatchesSelectedTab, int> {
  MatchesSelectedTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'matchesSelectedTabProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$matchesSelectedTabHash();

  @$internal
  @override
  MatchesSelectedTab create() => MatchesSelectedTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$matchesSelectedTabHash() =>
    r'12dc9730f3f73c803b7b5b0ff267af868a3f70e1';

abstract class _$MatchesSelectedTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
