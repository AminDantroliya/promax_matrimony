// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_member_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatMemberNotifier)
final chatMemberProvider = ChatMemberNotifierFamily._();

final class ChatMemberNotifierProvider
    extends $AsyncNotifierProvider<ChatMemberNotifier, ChatMemberState> {
  ChatMemberNotifierProvider._({
    required ChatMemberNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatMemberProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatMemberNotifierHash();

  @override
  String toString() {
    return r'chatMemberProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatMemberNotifier create() => ChatMemberNotifier();

  @override
  bool operator ==(Object other) {
    return other is ChatMemberNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatMemberNotifierHash() =>
    r'c24742ef10fcae8f2fc9fd35dbd95ca94d6bd8e3';

final class ChatMemberNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatMemberNotifier,
          AsyncValue<ChatMemberState>,
          ChatMemberState,
          FutureOr<ChatMemberState>,
          String
        > {
  ChatMemberNotifierFamily._()
    : super(
        retry: null,
        name: r'chatMemberProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatMemberNotifierProvider call(String type) =>
      ChatMemberNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'chatMemberProvider';
}

abstract class _$ChatMemberNotifier extends $AsyncNotifier<ChatMemberState> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  FutureOr<ChatMemberState> build(String type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChatMemberState>, ChatMemberState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatMemberState>, ChatMemberState>,
              AsyncValue<ChatMemberState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
