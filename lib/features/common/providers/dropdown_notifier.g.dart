// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allDropdowns)
final allDropdownsProvider = AllDropdownsProvider._();

final class AllDropdownsProvider
    extends
        $FunctionalProvider<
          AsyncValue<DropdownData?>,
          DropdownData?,
          FutureOr<DropdownData?>
        >
    with $FutureModifier<DropdownData?>, $FutureProvider<DropdownData?> {
  AllDropdownsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allDropdownsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allDropdownsHash();

  @$internal
  @override
  $FutureProviderElement<DropdownData?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DropdownData?> create(Ref ref) {
    return allDropdowns(ref);
  }
}

String _$allDropdownsHash() => r'9387213c3e7c447fafd18eb96d919a3d7ebf07b0';

@ProviderFor(DependentDropdownNotifier)
final dependentDropdownProvider = DependentDropdownNotifierProvider._();

final class DependentDropdownNotifierProvider
    extends
        $NotifierProvider<
          DependentDropdownNotifier,
          Map<String, List<DropdownOptionModel>>
        > {
  DependentDropdownNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dependentDropdownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dependentDropdownNotifierHash();

  @$internal
  @override
  DependentDropdownNotifier create() => DependentDropdownNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<DropdownOptionModel>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<String, List<DropdownOptionModel>>>(value),
    );
  }
}

String _$dependentDropdownNotifierHash() =>
    r'b5605c95181691bc3dafb643bdf49a88dcb9475c';

abstract class _$DependentDropdownNotifier
    extends $Notifier<Map<String, List<DropdownOptionModel>>> {
  Map<String, List<DropdownOptionModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, List<DropdownOptionModel>>,
              Map<String, List<DropdownOptionModel>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, List<DropdownOptionModel>>,
                Map<String, List<DropdownOptionModel>>
              >,
              Map<String, List<DropdownOptionModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
