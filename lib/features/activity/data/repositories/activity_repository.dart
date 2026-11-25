import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import '../models/activity_models.dart';

part 'activity_repository.g.dart';

class ActivityRepository extends BaseRepository {
  ActivityRepository(super.dio);

  Future<ActivityProfileListResponseModel> getActivityProfileList(
      String url, Map<String, dynamic> params) async {
    final response = await postRequest(url, params);
    return ActivityProfileListResponseModel.fromJson(response.data);
  }

  Future<ActivityProfileListResponseModel> getMeetingList(Map<String, dynamic> params) async {
    final response = await postRequest(getMyMeetingListApi, params);
    return ActivityProfileListResponseModel.fromJson(response.data);
  }

  Future<String> activityAction(String url, Map<String, dynamic> params) async {
    final response = await postRequest(url, params);
    return response.status;
  }
}

@riverpod
ActivityRepository activityRepository(Ref ref) {
  return ActivityRepository(ref.watch(dioProvider));
}
