// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_chat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(managerChatRepository)
final managerChatRepositoryProvider = ManagerChatRepositoryProvider._();

final class ManagerChatRepositoryProvider
    extends
        $FunctionalProvider<
          ManagerChatRepository,
          ManagerChatRepository,
          ManagerChatRepository
        >
    with $Provider<ManagerChatRepository> {
  ManagerChatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'managerChatRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$managerChatRepositoryHash();

  @$internal
  @override
  $ProviderElement<ManagerChatRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ManagerChatRepository create(Ref ref) {
    return managerChatRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManagerChatRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManagerChatRepository>(value),
    );
  }
}

String _$managerChatRepositoryHash() =>
    r'92db1c439e1c00490c4847cdadb64bb13bb14e0c';
