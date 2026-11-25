import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/chat/data/models/chat_models.dart';
import '../../../features/chat/data/repositories/chat_repository.dart';

part 'chat_conversation_notifier.freezed.dart';
part 'chat_conversation_notifier.g.dart';

@freezed
abstract class ChatConversationState with _$ChatConversationState {
  const factory ChatConversationState({
    @Default([]) List<ChatMessage> messageList,
    @Default(1) int page,
    @Default(0) int totalCount,
    @Default(false) bool isLoadingMore,
    @Default(null) ChatConversationListResponseModel? response,
    @Default(null) ChatConversationData? data,
  }) = _ChatConversationState;
}

@riverpod
class ChatConversationNotifier extends _$ChatConversationNotifier {
  late final String _receiverMemberId;

  @override
  FutureOr<ChatConversationState> build(String receiverMemberId) async {
    _receiverMemberId = receiverMemberId;
    return _fetchConversationList(receiverMemberId, 1);
  }

  Future<ChatConversationState> _fetchConversationList(String receiverMemberId, int page) async {
    final params = {
      "receiver_member_id": receiverMemberId,
      "page": page.toString(),
      "limit": "20",
    };
    final response = await ref.read(chatRepositoryProvider).getChatConversationList(params);
    return ChatConversationState(
      messageList: response.data?.messageList ?? [],
      page: page,
      totalCount: response.data?.messageListCount ?? 0,
      response: response,
      data: response.data,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchConversationList(_receiverMemberId, 1));
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore || currentState.messageList.length >= currentState.totalCount) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.page + 1;
    final params = {
      "receiver_member_id": _receiverMemberId,
      "page": nextPage.toString(),
      "limit": "20",
    };

    try {
      final response = await ref.read(chatRepositoryProvider).getChatConversationList(params);
      state = AsyncValue.data(currentState.copyWith(
        messageList: [...currentState.messageList, ...(response.data?.messageList ?? [])],
        page: nextPage,
        isLoadingMore: false,
        response: response,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> sendMessage(String message) async {
    final params = {
      "receiver_member_id": _receiverMemberId,
      "message": message,
    };
    final status = await ref.read(chatRepositoryProvider).sendMessage(params);
    if (status == "success") {
      refresh();
      return true;
    }
    return false;
  }
}
