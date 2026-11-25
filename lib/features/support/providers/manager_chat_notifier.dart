import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/app_session_service.dart';
import '../../../preference/session_keys.dart';
import '../../chat/data/models/chat_models.dart';
import '../../search/providers/search_notifier.dart';
import '../data/repositories/manager_chat_repository.dart';

part 'manager_chat_notifier.g.dart';

@riverpod
class ManagerChatNotifier extends _$ManagerChatNotifier {
  @override
  PagingState<ChatMessage> build() {
    return const PagingState();
  }

  Future<void> fetchMessages({bool isRefresh = true}) async {
    final targetPage = isRefresh ? 1 : state.page;
    if (isRefresh) {
      state = state.copyWith(
        isLoading: state.items.isEmpty,
        page: 1,
        items: state.items,
      );
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(managerChatRepositoryProvider);
      final params = {
        "page": targetPage.toString(),
        "limit": "10",
      };

      final response = await repository.getMessages(params);
      
      final dataObj = response;
      final List<ChatMessage> fetchedMessages = [];
      int totalCount = 0;
      
      totalCount = int.tryParse(dataObj['resultCount']?.toString() ?? '0') ?? 0;
      final rawList = dataObj['resultList'];
      if (rawList is List) {
        
        for (final item in rawList) {
          if (item is Map) {
            final senderType = item['sender_type']?.toString();
            final isSender = senderType == "2";
            final memberId = int.tryParse(item['member_id']?.toString() ?? '');
            
            fetchedMessages.add(
              ChatMessage(
                id: item['id'],
                senderMemberId: isSender ? memberId : 0,
                receiverMemberId: isSender ? 0 : memberId,
                message: item['message']?.toString(),
                sendOn: item['created_at']?.toString(),
                isSender: isSender,
                isReceiver: !isSender,
              ),
            );
          }
        }
      }

      state = state.copyWith(
        items: isRefresh ? fetchedMessages : [...state.items, ...fetchedMessages],
        totalCount: totalCount,
        page: targetPage + 1,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
    }
  }

  Future<bool> sendMessage(String message) async {
    try {
      final repository = ref.read(managerChatRepositoryProvider);
      final status = await repository.sendMessage(message);
      if (status == 'success') {
        final currentUserIdStr = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
        final currentUserId = int.tryParse(currentUserIdStr ?? '');
        
        final newMsg = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch,
          senderMemberId: currentUserId,
          receiverMemberId: 0,
          message: message,
          sendOn: DateTime.now().toUtc().toIso8601String(),
          isSender: true,
          isReceiver: false,
        );
        state = state.copyWith(
          items: [newMsg, ...state.items],
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
