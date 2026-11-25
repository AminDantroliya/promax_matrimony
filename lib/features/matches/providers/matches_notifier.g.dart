// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MatchesNotifier)
final matchesProvider = MatchesNotifierFamily._();

final class MatchesNotifierProvider
    extends $NotifierProvider<MatchesNotifier, PagingState<MemberListModel>> {
  MatchesNotifierProvider._({
    required MatchesNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'matchesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$matchesNotifierHash();

  @override
  String toString() {
    return r'matchesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MatchesNotifier create() => MatchesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<MemberListModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<MemberListModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MatchesNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$matchesNotifierHash() => r'342bc7323985f4d810433b0f085d884e2d67a321';

final class MatchesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MatchesNotifier,
          PagingState<MemberListModel>,
          PagingState<MemberListModel>,
          PagingState<MemberListModel>,
          String
        > {
  MatchesNotifierFamily._()
    : super(
        retry: null,
        name: r'matchesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  MatchesNotifierProvider call(String url) =>
      MatchesNotifierProvider._(argument: url, from: this);

  @override
  String toString() => r'matchesProvider';
}

abstract class _$MatchesNotifier
    extends $Notifier<PagingState<MemberListModel>> {
  late final _$args = ref.$arg as String;
  String get url => _$args;

  PagingState<MemberListModel> build(String url);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<PagingState<MemberListModel>, PagingState<MemberListModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                PagingState<MemberListModel>,
                PagingState<MemberListModel>
              >,
              PagingState<MemberListModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(MemberActionNotifier)
final memberActionProvider = MemberActionNotifierProvider._();

final class MemberActionNotifierProvider
    extends $NotifierProvider<MemberActionNotifier, AsyncValue<void>> {
  MemberActionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberActionNotifierHash();

  @$internal
  @override
  MemberActionNotifier create() => MemberActionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$memberActionNotifierHash() =>
    r'38989126fa2a83aa0e791f62cb1444f5c53337ba';

abstract class _$MemberActionNotifier extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
