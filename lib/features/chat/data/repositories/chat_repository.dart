import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/chat_models.dart';
import '../../../../utils/api_urls.dart';

part 'chat_repository.g.dart';

class ChatRepository extends BaseRepository {
  ChatRepository(super.dio);

  Future<ChatMemberListResponseModel> getChatMemberList(Map<String, dynamic> params) async {
    final response = await postRequest(getChatMemberListApi, params);
    return ChatMemberListResponseModel.fromJson(response.data);
  }

  Future<ChatConversationListResponseModel> getChatConversationList(Map<String, dynamic> params) async {
    final response = await postRequest(getChatConversationListApi, params);
    return ChatConversationListResponseModel.fromJson(response.data);
  }

  Future<String> sendMessage(Map<String, dynamic> params) async {
    final response = await postRequest(sendChatMessageApi, params);
    return response.status;
  }

  /// Send / cancel / accept / reject chat request
  Future<Map<String, dynamic>> chatRequest(Map<String, dynamic> params) async {
    final response = await postRequest(chatRequestApi, params);
    return response.data;
  }

  /// Block / unblock a chat user
  Future<Map<String, dynamic>> chatBlockUnblock(Map<String, dynamic> params) async {
    final response = await postRequest(chatBlockUnblockApi, params);
    return response.data;
  }
}

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(ref.watch(dioProvider));
}

