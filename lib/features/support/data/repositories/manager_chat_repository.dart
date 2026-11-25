import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../utils/api_urls.dart';

part 'manager_chat_repository.g.dart';

class ManagerChatRepository extends BaseRepository {
  ManagerChatRepository(super.dio);

  Future<Map<String, dynamic>> getMessages(Map<String, dynamic> params) async {
    final response = await postRequest(getPersonalizeChatMessagesApi, params);
    return response.object;
  }

  Future<String> sendMessage(String message) async {
    final response = await postRequest(sendPersonalizeChatMessageApi, {
      "message": message,
    });
    return response.status;
  }
}

@riverpod
ManagerChatRepository managerChatRepository(Ref ref) {
  return ManagerChatRepository(ref.watch(dioProvider));
}
