// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatMemberListNotifier)
final chatMemberListProvider = ChatMemberListNotifierFamily._();

final class ChatMemberListNotifierProvider
    extends $NotifierProvider<ChatMemberListNotifier, PagingState<ChatMember>> {
  ChatMemberListNotifierProvider._({
    required ChatMemberListNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatMemberListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatMemberListNotifierHash();

  @override
  String toString() {
    return r'chatMemberListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatMemberListNotifier create() => ChatMemberListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<ChatMember> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<ChatMember>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMemberListNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatMemberListNotifierHash() =>
    r'7483e524d12139f105e99c36f1261184c23f6be5';

final class ChatMemberListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatMemberListNotifier,
          PagingState<ChatMember>,
          PagingState<ChatMember>,
          PagingState<ChatMember>,
          String
        > {
  ChatMemberListNotifierFamily._()
    : super(
        retry: null,
        name: r'chatMemberListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatMemberListNotifierProvider call(String type) =>
      ChatMemberListNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'chatMemberListProvider';
}

abstract class _$ChatMemberListNotifier
    extends $Notifier<PagingState<ChatMember>> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  PagingState<ChatMember> build(String type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<PagingState<ChatMember>, PagingState<ChatMember>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PagingState<ChatMember>, PagingState<ChatMember>>,
              PagingState<ChatMember>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ChatConversationNotifier)
final chatConversationProvider = ChatConversationNotifierFamily._();

final class ChatConversationNotifierProvider
    extends $NotifierProvider<ChatConversationNotifier, ChatConversationState> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatConversationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatConversationState>(value),
    );
  }

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
    r'0cb188ceda442ace7908898841997fefea6d2885';

final class ChatConversationNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatConversationNotifier,
          ChatConversationState,
          ChatConversationState,
          ChatConversationState,
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

  ChatConversationNotifierProvider call(String receiverId) =>
      ChatConversationNotifierProvider._(argument: receiverId, from: this);

  @override
  String toString() => r'chatConversationProvider';
}

abstract class _$ChatConversationNotifier
    extends $Notifier<ChatConversationState> {
  late final _$args = ref.$arg as String;
  String get receiverId => _$args;

  ChatConversationState build(String receiverId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ChatConversationState, ChatConversationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatConversationState, ChatConversationState>,
              ChatConversationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(otherUserChatStatusStream)
final otherUserChatStatusStreamProvider = OtherUserChatStatusStreamFamily._();

final class OtherUserChatStatusStreamProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  OtherUserChatStatusStreamProvider._({
    required OtherUserChatStatusStreamFamily super.from,
    required ({String conversationId, String otherUserId}) super.argument,
  }) : super(
         retry: null,
         name: r'otherUserChatStatusStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$otherUserChatStatusStreamHash();

  @override
  String toString() {
    return r'otherUserChatStatusStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    final argument =
        this.argument as ({String conversationId, String otherUserId});
    return otherUserChatStatusStream(
      ref,
      conversationId: argument.conversationId,
      otherUserId: argument.otherUserId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OtherUserChatStatusStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$otherUserChatStatusStreamHash() =>
    r'ee32796efed386cae860d4ab3a8b86cafecdb058';

final class OtherUserChatStatusStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<int>,
          ({String conversationId, String otherUserId})
        > {
  OtherUserChatStatusStreamFamily._()
    : super(
        retry: null,
        name: r'otherUserChatStatusStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OtherUserChatStatusStreamProvider call({
    required String conversationId,
    required String otherUserId,
  }) => OtherUserChatStatusStreamProvider._(
    argument: (conversationId: conversationId, otherUserId: otherUserId),
    from: this,
  );

  @override
  String toString() => r'otherUserChatStatusStreamProvider';
}
