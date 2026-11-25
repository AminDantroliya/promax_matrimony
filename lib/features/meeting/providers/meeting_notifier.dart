import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../search/providers/search_notifier.dart';
import '../../profile/providers/profile_notifier.dart';
import '../data/models/meeting_models.dart';
import '../data/repositories/meeting_repository.dart';

part 'meeting_notifier.g.dart';

@riverpod
class MeetingNotifier extends _$MeetingNotifier {
  @override
  PagingState<Meeting> build() {
    return const PagingState();
  }

  Future<void> fetchMeetings({bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repository = ref.read(meetingRepositoryProvider);
      final myProfile = ref.read(myProfileProvider).value;
      final isPersonalized = myProfile?.userType?.toString() == "1";

      final params = {
        "page": state.page.toString(),
        "limit": "10",
      };

      final response = isPersonalized
          ? await repository.getPersonalizedMeetings(params)
          : await repository.getMeetings(params);
      
      final newItems = response.data?.resultArr ?? [];
      final totalCount = response.data?.resultCount ?? 0;

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

  Future<bool> updatePersonalizedStatus(
    Meeting meeting,
    String responseStatus, {
    String? remark,
  }) async {
    try {
      final myProfile = ref.read(myProfileProvider).value;
      final isMember1 = myProfile?.id?.toString() == meeting.member1Id?.toString();
      
      final memberLabel = isMember1 ? "member1_status" : "member2_status";
      final rejectBy = isMember1 ? "member1_reject_remark" : "member2_reject_remark";

      final params = {
        "meeting_id": meeting.id.toString(),
        "member_label": memberLabel,
        "response": responseStatus,
      };

      if (responseStatus == "2") {
        params["reject_by"] = rejectBy;
        params[rejectBy] = remark ?? "";
      }

      await ref.read(meetingRepositoryProvider).updatePersonalizedMeetingStatus(params);
      fetchMeetings(isRefresh: true);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateStatus(dynamic meetingOrId, String status, {String? remark}) async {
    try {
      final myProfile = ref.read(myProfileProvider).value;
      final isPersonalized = myProfile?.userType?.toString() == "1";

      if (isPersonalized) {
        if (meetingOrId is! Meeting) return false;

        // For personalized: Complete == status "1" with both accepted
        // We reuse the same endpoint but mark it as complete via meeting_status
        final bothAccepted =
            meetingOrId.member1Status?.toString() == "1" &&
            meetingOrId.member2Status?.toString() == "1";

        if (bothAccepted && status == "1") {
          // Complete flow for personalized
          final params = <String, String>{
            "meeting_id": meetingOrId.id.toString(),
            "meeting_status": "1",
          };
          if (remark != null && remark.isNotEmpty) {
            params["meeting_remark"] = remark;
          }
          await ref.read(meetingRepositoryProvider).updatePersonalizedMeetingStatus(params);
          fetchMeetings(isRefresh: true);
          return true;
        }

        // status is "1" (Accept) or "2" (Reject) for personalized meetings
        return await updatePersonalizedStatus(meetingOrId, status, remark: remark);
      }

      final meeting = meetingOrId is Meeting ? meetingOrId : null;
      final String meetingId = meetingOrId is Meeting
          ? meetingOrId.id.toString()
          : meetingOrId.toString();

      // Detect Complete: both members accepted and status == "1" from Complete button
      final bothAccepted = meeting != null &&
          meeting.member1Status?.toString() == "1" &&
          meeting.member2Status?.toString() == "1";

      final params = <String, String>{
        "id": meetingId,
        "match_id": meetingId,
        "response": status,
        "update_status": status,
      };

      if (bothAccepted && status == "1") {
        // Complete flow
        params["memberLabel"] = "meeting_status";
        params["response"] = "1";
        params["update_status"] = "1";
        if (remark != null && remark.isNotEmpty) {
          params["meeting_remark"] = remark;
        }
      } else if (status == "1") {
        params["memberLabel"] = "member1_status";
      } else if (status == "2") {
        params["memberLabel"] = "member1_status";
        params["rejectBy"] = "member1_reject_remark";
        if (remark != null) params["member1_reject_remark"] = remark;
      } else if (status == "3") {
        params["memberLabel"] = "meeting_status";
        params["rejectBy"] = "meeting_remark";
        if (remark != null) params["meeting_remark"] = remark;
      }

      final result = await ref.read(meetingRepositoryProvider).updateMeetingStatus(params);
      if (result['status'] == "success") {
        fetchMeetings(isRefresh: true);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
