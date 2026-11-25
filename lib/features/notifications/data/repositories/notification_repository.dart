import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import '../models/notification_models.dart';

part 'notification_repository.g.dart';

class NotificationRepository extends BaseRepository {
  NotificationRepository(super.dio);

  Future<NotificationListResponseModel> getNotificationList(Map<String, dynamic> params) async {
    final response = await postRequest(getNotificationListApi, params);
    return NotificationListResponseModel.fromJson(response.data);
  }

  Future<void> updateNotificationToken(Map<String, dynamic> params) async {
    await postRequest(saveDeviceTokenApi, params);
  }
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(ref.watch(dioProvider));
}
