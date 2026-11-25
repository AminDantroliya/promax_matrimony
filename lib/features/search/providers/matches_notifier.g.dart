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
    required MatchType super.argument,
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

String _$matchesNotifierHash() => r'8308dab23e2140cf9eec459ab57c1fa904af7813';

final class MatchesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MatchesNotifier,
          PagingState<MemberListModel>,
          PagingState<MemberListModel>,
          PagingState<MemberListModel>,
          MatchType
        > {
  MatchesNotifierFamily._()
    : super(
        retry: null,
        name: r'matchesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  MatchesNotifierProvider call(MatchType type) =>
      MatchesNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'matchesProvider';
}

abstract class _$MatchesNotifier
    extends $Notifier<PagingState<MemberListModel>> {
  late final _$args = ref.$arg as MatchType;
  MatchType get type => _$args;

  PagingState<MemberListModel> build(MatchType type);
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
