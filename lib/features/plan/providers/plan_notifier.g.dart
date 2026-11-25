// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlanNotifier)
final planProvider = PlanNotifierProvider._();

final class PlanNotifierProvider
    extends $AsyncNotifierProvider<PlanNotifier, PlanListData?> {
  PlanNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planNotifierHash();

  @$internal
  @override
  PlanNotifier create() => PlanNotifier();
}

String _$planNotifierHash() => r'd5a669dc3eb462a4c9672a51de4e7998a837b3ab';

abstract class _$PlanNotifier extends $AsyncNotifier<PlanListData?> {
  FutureOr<PlanListData?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PlanListData?>, PlanListData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PlanListData?>, PlanListData?>,
              AsyncValue<PlanListData?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrentPlanNotifier)
final currentPlanProvider = CurrentPlanNotifierProvider._();

final class CurrentPlanNotifierProvider
    extends $AsyncNotifierProvider<CurrentPlanNotifier, CurrentPlanData?> {
  CurrentPlanNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPlanProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPlanNotifierHash();

  @$internal
  @override
  CurrentPlanNotifier create() => CurrentPlanNotifier();
}

String _$currentPlanNotifierHash() =>
    r'9ef1d16ff594192ea168866126a24eca80cfb23c';

abstract class _$CurrentPlanNotifier extends $AsyncNotifier<CurrentPlanData?> {
  FutureOr<CurrentPlanData?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CurrentPlanData?>, CurrentPlanData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CurrentPlanData?>, CurrentPlanData?>,
              AsyncValue<CurrentPlanData?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(PlanHistoryNotifier)
final planHistoryProvider = PlanHistoryNotifierProvider._();

final class PlanHistoryNotifierProvider
    extends $AsyncNotifierProvider<PlanHistoryNotifier, List<CurrentPlan>?> {
  PlanHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planHistoryNotifierHash();

  @$internal
  @override
  PlanHistoryNotifier create() => PlanHistoryNotifier();
}

String _$planHistoryNotifierHash() =>
    r'a45479d7fb9cb3e7a2e8fd4fe66829f050b19d5a';

abstract class _$PlanHistoryNotifier
    extends $AsyncNotifier<List<CurrentPlan>?> {
  FutureOr<List<CurrentPlan>?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CurrentPlan>?>, List<CurrentPlan>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CurrentPlan>?>, List<CurrentPlan>?>,
              AsyncValue<List<CurrentPlan>?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
