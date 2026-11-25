import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/chat/data/models/chat_models.dart';
import '../../../features/chat/data/repositories/chat_repository.dart';
import '../../search/providers/search_notifier.dart';
import '../../../services/app_session_service.dart';
import '../../../preference/session_keys.dart';
import '../../../services/firebase_chat_service.dart';
import '../../../utils/application_data.dart';

part 'chat_notifier.g.dart';
part 'chat_notifier.freezed.dart';

@riverpod
class ChatMemberListNotifier extends _$ChatMemberListNotifier {
  String _searchKeyword = "";

  @override
  PagingState<ChatMember> build(String type) {
    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (myUserId != null) {
      final sub = FirebaseChatService.instance
          .streamLastMessages(myUserId)
          .listen((data) {
            if (data.isEmpty || state.items.isEmpty) return;
            
            bool stateChanged = false;
            final items = [...state.items];
            
            data.forEach((conversationId, msgData) {
              final idx = items.indexWhere((e) => e.id.toString() == conversationId);
              if (idx != -1) {
                final oldMember = items[idx];
                final newMsg = msgData['message']?.toString() ?? '';
                
                if (oldMember.lastMessage != newMsg) {
                  items[idx] = oldMember.copyWith(
                    lastMessage: newMsg,
                    lastMessageDate: DateTime.now().toString(),
                  );
                  stateChanged = true;
                }
              }
            });
            
            if (stateChanged) {
              state = state.copyWith(items: items);
            }
          });
          
      ref.onDispose(() {
        sub.cancel();
      });
    }
    return const PagingState();
  }

  Future<void> fetchMembers({bool isRefresh = true, String searchKeyword = ""}) async {
    if (isRefresh) {
      _searchKeyword = searchKeyword;
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(chatRepositoryProvider);
      final params = {
        "page": state.page.toString(),
        "limit": "20",
        "type": (type == "recent_chat") ? "recent" : type, // recent/online
        "search_keyword": _searchKeyword,
      };

      final response = await repository.getChatMemberList(params);
      
      final newItems = response.data?.resultList ?? [];
      final totalCount = response.data?.resultCount ?? 0;

      final conversationIds = newItems.map((e) => e.id.toString()).toList();
      if (conversationIds.isNotEmpty) {
        FirebaseChatService.instance.updateMyChatStatusBulk(conversationIds, 1);
      }

      state = state.copyWith(
        items: isRefresh ? newItems : [...state.items, ...newItems],
        totalCount: totalCount,
        page: state.page + 1,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
    }
  }
}

@freezed
abstract class ChatConversationState with _$ChatConversationState {
  const factory ChatConversationState({
    @Default(PagingState<ChatMessage>()) PagingState<ChatMessage> pagingState,
    ChatConversationData? headerData,
    @Default(0) int otherUserChatStatus,
    /// Locally overridable request/block status (updated optimistically after API calls)
    String? localRequestStatus,
    int? localRequestedBy,
    bool? localIsChatBlocked,
  }) = _ChatConversationState;
}

@riverpod
class ChatConversationNotifier extends _$ChatConversationNotifier {
  StreamSubscription<int>? _otherUserStatusSub;
  StreamSubscription<Map<String, dynamic>?>? _lastMessageSub;
  String? _activeConversationId;

  @override
  ChatConversationState build(String receiverId) {
    ref.onDispose(() {
      _otherUserStatusSub?.cancel();
      _lastMessageSub?.cancel();
      if (_activeConversationId != null &&
          FirebaseChatService.instance.currentConversationId == _activeConversationId) {
        FirebaseChatService.instance.updateMyChatStatus(_activeConversationId!, 1);
        FirebaseChatService.instance.currentConversationId = null;
      }
    });
    return const ChatConversationState(
      pagingState: PagingState<ChatMessage>(isLoading: true),
    );
  }

  void _initFirebaseBindings(String conversationId) {
    _activeConversationId = conversationId;
    FirebaseChatService.instance.currentConversationId = conversationId;

    // 1. Ensure conversation objects exist in Firebase
    FirebaseChatService.instance.ensureConversationObjectsExist(conversationId, receiverId);

    // 2. Set my status to 2 (seen)
    FirebaseChatService.instance.updateMyChatStatus(conversationId, 2);

    // 3. Listen to other user's status changes
    _otherUserStatusSub?.cancel();
    _otherUserStatusSub = FirebaseChatService.instance
        .streamOtherUserStatus(conversationId, receiverId)
        .listen((status) {
          if (status == 2) {
            final updatedItems = state.pagingState.items.map((m) {
              if (m.isMessageSender && (m.chatStatus == null || m.chatStatus! < 2)) {
                return m.copyWith(chatStatus: 2);
              }
              return m;
            }).toList();
            state = state.copyWith(
              otherUserChatStatus: status,
              pagingState: state.pagingState.copyWith(items: updatedItems),
            );
          } else {
            state = state.copyWith(otherUserChatStatus: status);
          }
        });

    // 4. Listen to other user's last message to append dynamically
    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (myUserId != null) {
      _lastMessageSub?.cancel();
      _lastMessageSub = FirebaseChatService.instance
          .streamLastMessageForConversation(myUserId, conversationId)
          .listen((msgData) {
            if (msgData == null) return;
            final senderId = msgData['sender_id']?.toString();
            if (senderId != receiverId) return;

            final messageId = msgData['message_id'];
            final messageText = msgData['message']?.toString() ?? '';

            final alreadyExists = state.pagingState.items.any((e) =>
                e.id.toString() == messageId.toString() ||
                (e.message == messageText && e.isMessageReceiver)
            );

            final updatedItems = state.pagingState.items.map((m) {
              if (m.isMessageSender && (m.chatStatus == null || m.chatStatus! < 2)) {
                return m.copyWith(chatStatus: 2);
              }
              return m;
            }).toList();

            if (!alreadyExists) {
              final chatMessage = ChatMessage(
                id: messageId,
                conversationId: conversationId,
                senderMemberId: senderId,
                receiverMemberId: myUserId,
                message: messageText,
                isReceiver: true,
                isSender: false,
                sendOn: DateTime.now().toString(),
              );
              state = state.copyWith(
                otherUserChatStatus: 2,
                pagingState: state.pagingState.copyWith(
                  items: [chatMessage, ...updatedItems],
                  totalCount: state.pagingState.totalCount + 1,
                ),
              );
            } else {
              state = state.copyWith(
                otherUserChatStatus: 2,
                pagingState: state.pagingState.copyWith(items: updatedItems),
              );
            }

            // User is currently viewing conversation: re-assert chat_status is 2 (seen)
            if (FirebaseChatService.instance.currentConversationId == conversationId) {
              FirebaseChatService.instance.updateMyChatStatus(conversationId, 2);
            }
          });
    }
  }

  Future<void> fetchMessages({bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(
        pagingState: state.pagingState.copyWith(
          isLoading: true,
          page: 1,
          items: state.headerData == null ? [] : state.pagingState.items,
        ),
      );
    } else {
      if (state.pagingState.isLoadingMore || state.pagingState.items.length >= (state.pagingState.totalCount)) return;
      state = state.copyWith(
        pagingState: state.pagingState.copyWith(isLoadingMore: true),
      );
    }

    try {
      final repository = ref.read(chatRepositoryProvider);
      final params = {
        "page": state.pagingState.page.toString(),
        "limit": "10",
        "receiver_id": receiverId,
      };

      final response = await repository.getChatConversationList(params);
      
      final newItems = response.data?.messageList ?? [];
      final totalCount = response.data?.messageListCount ?? 0;

      state = state.copyWith(
        headerData: response.data,
        localRequestStatus: null,
        localRequestedBy: null,
        pagingState: state.pagingState.copyWith(
          items: isRefresh ? newItems : [...state.pagingState.items, ...newItems],
          totalCount: totalCount,
          page: state.pagingState.page + 1,
          isLoading: false,
          isLoadingMore: false,
        ),
      );

      final conversationId = response.data?.conversationId?.toString();
      if (conversationId != null) {
        ApplicationData.activeConversationId = conversationId;
        _initFirebaseBindings(conversationId);

        // Ensure last message is synchronized
        final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
        final lastMsg = newItems.firstOrNull;
        if (lastMsg != null && lastMsg.isMessageSender && myUserId != null) {
          FirebaseChatService.instance.updateLastMessage(
            receiverId: receiverId,
            conversationId: conversationId,
            messageText: lastMsg.message ?? '',
            messageId: lastMsg.id,
            senderId: myUserId,
          );
        }
      }
    } catch (e) {
      state = state.copyWith(
        pagingState: state.pagingState.copyWith(isLoading: false, isLoadingMore: false, error: e),
      );
    }
  }

  void addMessage(ChatMessage message) {
    state = state.copyWith(
      pagingState: state.pagingState.copyWith(
        items: [message, ...state.pagingState.items],
        totalCount: state.pagingState.totalCount + 1,
      ),
    );
  }

  Future<bool> sendMessage(String message) async {
    try {
      final repository = ref.read(chatRepositoryProvider);
      final conversationId = state.headerData?.conversationId;
      final params = {
        "receiver_id": receiverId,
        "message": message,
      };
      if (conversationId != null) {
        params["conversation_id"] = conversationId.toString();
      }
      
      final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
      
      final status = await repository.sendMessage(params);
      if (status != "success") {
        return false;
      }
      
      final messageId = DateTime.now().millisecondsSinceEpoch;
      if (conversationId != null && myUserId != null) {
        await FirebaseChatService.instance.updateLastMessage(
          receiverId: receiverId,
          conversationId: conversationId.toString(),
          messageText: message,
          messageId: messageId,
          senderId: myUserId,
        );
      }
      
      final sentMessage = ChatMessage(
        id: messageId,
        conversationId: conversationId?.toString(),
        senderMemberId: myUserId,
        receiverMemberId: receiverId,
        message: message,
        isReceiver: false,
        isSender: true,
        sendOn: DateTime.now().toString(),
        chatStatus: state.otherUserChatStatus,
      );
      addMessage(sentMessage);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Send / cancel / accept / reject chat request
  Future<Map<String, dynamic>> chatRequest(String action, {int? receiverIdInt}) async {
    try {
      final repository = ref.read(chatRepositoryProvider);
      final params = <String, dynamic>{'action': action};

      final conversationId = state.headerData?.conversationId;
      if (conversationId != null) {
        params['conversation_id'] = conversationId.toString();
      }
      params['receiver_id'] = receiverIdInt ?? int.tryParse(receiverId) ?? receiverId;

      final result = await repository.chatRequest(params);
      if (result['status'] == 'success') {
        // Optimistically update local state
        final myUserIdInt = int.tryParse(
          AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? '');
        switch (action) {
          case 'send':
            state = state.copyWith(
              localRequestStatus: 'pending',
              localRequestedBy: myUserIdInt,
            );
            break;
          case 'cancel':
          case 'reject':
            state = state.copyWith(
              localRequestStatus: 'none',
              localRequestedBy: null,
            );
            break;
          case 'accept':
            state = state.copyWith(localRequestStatus: 'accepted');
            break;
        }
        fetchMessages(isRefresh: true);
        return {
          'success': true,
          'status': 'success',
          'message': result['message']?.toString(),
        };
      }
      return {
        'success': false,
        'status': result['status'] ?? 'error',
        'message': result['message']?.toString(),
        'data': result['data'],
      };
    } catch (e) {
      return {'success': false, 'status': 'error', 'message': e.toString()};
    }
  }

  /// Block or unblock the chat user
  Future<bool> blockUnblock(String action) async {
    try {
      final repository = ref.read(chatRepositoryProvider);
      final params = {
        'receiver_id': int.tryParse(receiverId) ?? receiverId,
        'action': action,
      };
      final result = await repository.chatBlockUnblock(params);
      if (result['status'] == 'success') {
        state = state.copyWith(localIsChatBlocked: action == 'block');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

@riverpod
Stream<int> otherUserChatStatusStream(
  Ref ref, {
  required String conversationId,
  required String otherUserId,
}) {
  return FirebaseChatService.instance.streamOtherUserStatus(conversationId, otherUserId);
}
