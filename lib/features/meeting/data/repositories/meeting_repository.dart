import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../utils/api_urls.dart';
import '../models/meeting_models.dart';

part 'meeting_repository.g.dart';

class MeetingRepository extends BaseRepository {
  MeetingRepository(super.dio);

  Future<MeetingListResponse> getMeetings(Map<String, dynamic> params) async {
    final response = await postRequest(getMyMeetingListApi, params);
    return MeetingListResponse.fromJson(response.data);
  }

  Future<MeetingListResponse> getPersonalizedMeetings(Map<String, dynamic> params) async {
    final response = await postRequest(getMyMeetingsApi, params);
    return MeetingListResponse.fromJson(response.data);
  }

  Future<Map<String, dynamic>> updateMeetingStatus(Map<String, dynamic> params) async {
    final response = await postRequest(meetingActionApi, params);
    return response.object;
  }

  Future<void> updatePersonalizedMeetingStatus(Map<String, dynamic> params) async {
    await postRequest(acceptRejectMeetingApi, params);
  }
}

@riverpod
MeetingRepository meetingRepository(Ref ref) {
  return MeetingRepository(ref.watch(dioProvider));
}
