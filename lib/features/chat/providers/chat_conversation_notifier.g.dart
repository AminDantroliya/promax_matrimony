// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_conversation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatConversationNotifier)
final chatConversationProvider = ChatConversationNotifierFamily._();

final class ChatConversationNotifierProvider
    extends
        $AsyncNotifierProvider<
          ChatConversationNotifier,
          ChatConversationState
        > {
  ChatConversationNotifierProvider._({
    required ChatConversationNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatConversationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatConversationNotifierHash();

  @override
  String toString() {
    return r'chatConversationProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatConversationNotifier create() => ChatConversationNotifier();

  @override
  bool operator ==(Object other) {
    return other is ChatConversationNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatConversationNotifierHash() =>
    r'2e80b98f2082873c260922218b5d08cf57e68377';

final class ChatConversationNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatConversationNotifier,
          AsyncValue<ChatConversationState>,
          ChatConversationState,
          FutureOr<ChatConversationState>,
          String
        > {
  ChatConversationNotifierFamily._()
    : super(
        retry: null,
        name: r'chatConversationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatConversationNotifierProvider call(String receiverMemberId) =>
      ChatConversationNotifierProvider._(
        argument: receiverMemberId,
        from: this,
      );

  @override
  String toString() => r'chatConversationProvider';
}

abstract class _$ChatConversationNotifier
    extends $AsyncNotifier<ChatConversationState> {
  late final _$args = ref.$arg as String;
  String get receiverMemberId => _$args;

  FutureOr<ChatConversationState> build(String receiverMemberId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ChatConversationState>, ChatConversationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ChatConversationState>,
                ChatConversationState
              >,
              AsyncValue<ChatConversationState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
