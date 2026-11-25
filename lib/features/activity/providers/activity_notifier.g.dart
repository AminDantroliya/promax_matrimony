// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityNotifier)
final activityProvider = ActivityNotifierFamily._();

final class ActivityNotifierProvider
    extends $NotifierProvider<ActivityNotifier, PagingState<MemberListModel>> {
  ActivityNotifierProvider._({
    required ActivityNotifierFamily super.from,
    required (String, {Map<String, dynamic>? extraParams}) super.argument,
  }) : super(
         retry: null,
         name: r'activityProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityNotifierHash();

  @override
  String toString() {
    return r'activityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ActivityNotifier create() => ActivityNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<MemberListModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<MemberListModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityNotifierHash() => r'7a68c6744d711d706714ad7fce1cb770901fe057';

final class ActivityNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ActivityNotifier,
          PagingState<MemberListModel>,
          PagingState<MemberListModel>,
          PagingState<MemberListModel>,
          (String, {Map<String, dynamic>? extraParams})
        > {
  ActivityNotifierFamily._()
    : super(
        retry: null,
        name: r'activityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ActivityNotifierProvider call(
    String url, {
    Map<String, dynamic>? extraParams,
  }) => ActivityNotifierProvider._(
    argument: (url, extraParams: extraParams),
    from: this,
  );

  @override
  String toString() => r'activityProvider';
}

abstract class _$ActivityNotifier
    extends $Notifier<PagingState<MemberListModel>> {
  late final _$args = ref.$arg as (String, {Map<String, dynamic>? extraParams});
  String get url => _$args.$1;
  Map<String, dynamic>? get extraParams => _$args.extraParams;

  PagingState<MemberListModel> build(
    String url, {
    Map<String, dynamic>? extraParams,
  });
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
    return element.handleCreate(
      ref,
      () => build(_$args.$1, extraParams: _$args.extraParams),
    );
  }
}
