// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(actionRepository)
final actionRepositoryProvider = ActionRepositoryProvider._();

final class ActionRepositoryProvider
    extends
        $FunctionalProvider<
          ActionRepository,
          ActionRepository,
          ActionRepository
        >
    with $Provider<ActionRepository> {
  ActionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'actionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$actionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ActionRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ActionRepository create(Ref ref) {
    return actionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActionRepository>(value),
    );
  }
}

String _$actionRepositoryHash() => r'521e320af5f80ad511c9a1f3050f7bca4222f318';
