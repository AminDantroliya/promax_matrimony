// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_chat_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ManagerChatNotifier)
final managerChatProvider = ManagerChatNotifierProvider._();

final class ManagerChatNotifierProvider
    extends $NotifierProvider<ManagerChatNotifier, PagingState<ChatMessage>> {
  ManagerChatNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'managerChatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$managerChatNotifierHash();

  @$internal
  @override
  ManagerChatNotifier create() => ManagerChatNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<ChatMessage> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<ChatMessage>>(value),
    );
  }
}

String _$managerChatNotifierHash() =>
    r'c6058ce1eea94ef1c8584dba45f5bf3d0631fe3e';

abstract class _$ManagerChatNotifier
    extends $Notifier<PagingState<ChatMessage>> {
  PagingState<ChatMessage> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<PagingState<ChatMessage>, PagingState<ChatMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PagingState<ChatMessage>, PagingState<ChatMessage>>,
              PagingState<ChatMessage>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
