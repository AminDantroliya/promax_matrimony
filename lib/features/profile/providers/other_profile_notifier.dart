import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/profile/data/models/profile_models.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import '../../../features/settings/data/repositories/settings_repository.dart';
import '../../connection/data/repositories/connection_repository.dart';
import '../../../../utils/api_urls.dart';
import '../../../../utils/utils.dart';
import '../../home/providers/dashboard_notifier.dart';
import '../../search/providers/search_notifier.dart';
import '../../matches/providers/ai_match_notifier.dart';
import '../../matches/providers/matches_notifier.dart';
import 'dart:async';

part 'other_profile_notifier.g.dart';

// All known URL keys used by matchesProvider family
const kMatchesUrls = [
  getRecommendedMatchesApi,
  getPremiumMatchesApi,
  getNearByMeMatchesApi,
  getSuggestedMatchesApi,
  getRecentJoinedListApi,
  getRecentLoginListApi,
];

@riverpod
class OtherProfileNotifier extends _$OtherProfileNotifier {
  @override
  FutureOr<OtherMemberProfileResponseModel> build(String memberId) async {
    return _fetchProfile();
  }

  bool? _getIsPhotoProtectedFromLists() {
    try {
      final dashboard = ref.read(dashboardProvider).value;
      if (dashboard != null) {
        final allDashboardMembers = [
          ...?dashboard.recentlyJoinedMember,
          ...?dashboard.recentlyLoginMember,
          ...?dashboard.todayMatches,
          ...?dashboard.recommendedMatches,
          ...?dashboard.whoViewMyProfile,
          ...?dashboard.receivedInterest,
          ...?dashboard.recommedMatchesMember,
          ...?dashboard.premiumMatchesMember,
          ...?dashboard.nearByMatchesMember,
          ...?dashboard.featuredMember,
        ];
        for (final m in allDashboardMembers) {
          if ((m.memberId ?? m.id).toString() == memberId) {
            return checkIsPhotoProtected(m);
          }
        }
      }
    } catch (_) {}

    try {
      final searchState = ref.read(searchResultProvider);
      final match = searchState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return checkIsPhotoProtected(match);
    } catch (_) {}

    try {
      final aiState = ref.read(aiMatchProvider);
      final match = aiState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return checkIsPhotoProtected(match);
    } catch (_) {}

    for (final url in kMatchesUrls) {
      try {
        final matchesState = ref.read(matchesProvider(url));
        final match = matchesState.items.firstWhere(
          (e) => (e.id ?? e.memberId).toString() == memberId,
        );
        return checkIsPhotoProtected(match);
      } catch (_) {}
    }

    return null;
  }

  bool? _getIsInterestedFromLists() {
    try {
      final searchState = ref.read(searchResultProvider);
      final match = searchState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return checkIsInterest(match);
    } catch (_) {}

    try {
      final aiState = ref.read(aiMatchProvider);
      final match = aiState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return checkIsInterest(match);
    } catch (_) {}

    // Check all known matchesProvider URL instances
    for (final url in kMatchesUrls) {
      try {
        final matchesState = ref.read(matchesProvider(url));
        final match = matchesState.items.firstWhere(
          (e) => (e.id ?? e.memberId).toString() == memberId,
        );
        final result = checkIsInterest(match);
        if (result) return true;
      } catch (_) {}
    }

    return null;
  }

  bool? _getIsShortlistedFromLists() {
    try {
      final searchState = ref.read(searchResultProvider);
      final match = searchState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return match.isShortlisted == 1 || match.isShortlisted?.toString() == '1';
    } catch (_) {}

    try {
      final aiState = ref.read(aiMatchProvider);
      final match = aiState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return match.isShortlisted == 1 || match.isShortlisted?.toString() == '1';
    } catch (_) {}

    return null;
  }

  bool? _getIsBlockedFromLists() {
    try {
      final searchState = ref.read(searchResultProvider);
      final match = searchState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return match.isBlock == 1 || match.isBlock?.toString() == '1';
    } catch (_) {}

    try {
      final aiState = ref.read(aiMatchProvider);
      final match = aiState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == memberId,
      );
      return match.isBlock == 1 || match.isBlock?.toString() == '1';
    } catch (_) {}

    return null;
  }

  void _syncToGlobalLists({bool? isShortlisted, bool? isInterested, bool? isBlocked, String? interestState}) {
    try {
      ref.read(searchResultProvider.notifier).updateMemberAction(
        memberId: memberId,
        isShortlisted: isShortlisted,
        isInterested: isInterested,
        isBlocked: isBlocked,
        interestState: interestState,
      );
    } catch (_) {}

    try {
      ref.read(aiMatchProvider.notifier).updateMemberAction(
        memberId: memberId,
        isShortlisted: isShortlisted,
        isInterested: isInterested,
        isBlocked: isBlocked,
        interestState: interestState,
      );
    } catch (_) {}

    // Sync to all known matchesProvider URL instances
    for (final url in kMatchesUrls) {
      try {
        ref.read(matchesProvider(url).notifier).updateMemberAction(
          memberId: memberId,
          isShortlisted: isShortlisted,
          isInterested: isInterested,
          isBlocked: isBlocked,
          interestState: interestState,
        );
      } catch (_) {}
    }
  }

  Future<OtherMemberProfileResponseModel> _fetchProfile() async {
    final repository = ref.read(profileRepositoryProvider);
    final response = await repository.getOtherMemberProfile(memberId);

    if (response.data != null) {
      final isIntList = _getIsInterestedFromLists();
      final isShortList = _getIsShortlistedFromLists();
      final isBlkList = _getIsBlockedFromLists();
      final isProtList = _getIsPhotoProtectedFromLists();

      final serverIntState = response.data!.interestState;
      final serverIsInterested = serverIntState != null && 
                                 serverIntState.toLowerCase() != 'not_sent' && 
                                 serverIntState.toLowerCase() != 'none';
      final serverIsShortlisted = response.data!.isShortlisted == 1 || 
                                  response.data!.isShortlisted?.toString() == '1';
      final serverIsBlocked = response.data!.isBlock == 1 || 
                              response.data!.isBlock?.toString() == '1';
      final serverIsProtected = checkIsPhotoProtected(response.data);

      final updatedData = response.data!.copyWith(
        interestState: (isIntList == true && !serverIsInterested) 
            ? "sent" 
            : response.data!.interestState,
        isShortlisted: (isShortList == true && !serverIsShortlisted) 
            ? "1" 
            : response.data!.isShortlisted,
        isBlock: (isBlkList == true && !serverIsBlocked) 
            ? "1" 
            : response.data!.isBlock,
        isPhotoProtected: (isProtList == true && !serverIsProtected)
            ? "1"
            : response.data!.isPhotoProtected,
      );
      return response.copyWith(data: updatedData);
    }
    return response;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }

  Future<bool> toggleShortlist() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return false;

    final isShortlisted = currentProfile.isShortlisted?.toString() == "1";
    final action = isShortlisted ? "remove" : "add";

    try {
      final repository = ref.read(settingsRepositoryProvider);
      final params = {
        "receiver_member_id": memberId,
        "action": action,
      };
      
      final result = await repository.performAction(shortlistActionApi, params);
      final isSuccess = result['status'] == "success";
      final isAlreadyShortlisted = result['message']?.toString().toLowerCase().contains("already shortlisted") ?? false;
      
      if (isSuccess || isAlreadyShortlisted) {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          final updatedProfile = currentData.data!.copyWith(
            isShortlisted: isSuccess ? (isShortlisted ? "0" : "1") : "1",
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(isShortlisted: isSuccess ? !isShortlisted : true);
        }
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  Future<String> _getInterestId(ProfileData profile) async {
    final existingId = profile.interestId?.toString().trim() ?? "";
    if (existingId.isNotEmpty && existingId != "0" && existingId != "null") {
      return existingId;
    }
    final fresh = await _fetchProfile();
    final freshId = fresh.data?.interestId?.toString().trim() ?? "";
    if (freshId.isNotEmpty && freshId != "0" && freshId != "null") {
      final currentData = state.value;
      if (currentData != null) {
        state = AsyncValue.data(currentData.copyWith(data: fresh.data));
      }
      return freshId;
    }
    return "";
  }

  Future<Map<String, dynamic>> sendInterest() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return {"status": "error", "message": "Profile not loaded"};

    try {
      final repository = ref.read(settingsRepositoryProvider);
      final params = {
        "receiver_member_id": memberId,
      };
      
      final result = await repository.performAction(sendConnectionApi, params);
      if (result['status'] == "success") {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          dynamic newInterestId;
          if (result['data'] is Map) {
            newInterestId = result['data']['interest_id'] ??
                result['data']['interest_request_id'] ??
                result['data']['express_interest_id'] ??
                result['data']['id'];
          } else {
            newInterestId = result['interest_id'] ??
                result['interest_request_id'] ??
                result['express_interest_id'] ??
                result['id'];
          }

          final updatedProfile = currentData.data!.copyWith(
            interestState: "sent",
            interestStatus: "Pending",
            interestId: newInterestId ?? currentData.data!.interestId,
            canSendReminder: false,
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(interestState: "sent");

          // If interestId was not in the immediate response, re-fetch profile in background to populate interestId
          if (updatedProfile.interestId == null ||
              updatedProfile.interestId.toString().isEmpty ||
              updatedProfile.interestId.toString() == '0') {
            _fetchProfile().then((fresh) {
              if (fresh.data != null && fresh.data!.interestId != null) {
                final cur = state.value;
                if (cur != null && cur.data != null) {
                  state = AsyncValue.data(
                    cur.copyWith(
                      data: cur.data!.copyWith(interestId: fresh.data!.interestId),
                    ),
                  );
                }
              }
            });
          }
        }
      }
      return result;
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> acceptInterest() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return {"status": "error", "message": "Profile not loaded"};

    try {
      final repository = ref.read(connectionRepositoryProvider);
      final interestIdStr = await _getInterestId(currentProfile);
      final params = {
        "interest_request_id": interestIdStr,
        "action": "accept",
      };
      final result = await repository.connectionAction(params);
      if (result['status'] == "success") {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          final updatedProfile = currentData.data!.copyWith(
            interestState: "received",
            interestStatus: "Accepted",
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(interestState: "received");
        }
      }
      return result;
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> rejectInterest() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return {"status": "error", "message": "Profile not loaded"};

    try {
      final repository = ref.read(connectionRepositoryProvider);
      final interestIdStr = await _getInterestId(currentProfile);
      final params = {
        "interest_request_id": interestIdStr,
        "action": "reject",
      };
      final result = await repository.connectionAction(params);
      if (result['status'] == "success") {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          final updatedProfile = currentData.data!.copyWith(
            interestState: "received",
            interestStatus: "Rejected",
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(interestState: "received");
        }
      }
      return result;
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendReminder() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return {"status": "error", "message": "Profile not loaded"};

    try {
      final repository = ref.read(settingsRepositoryProvider);
      final params = {
        "receiver_member_id": memberId,
      };
      
      final result = await repository.performAction(sendConnectionApi, params);
      if (result['status'] == "success") {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          final currentPending = currentProfile.pendingReminderCount ?? 0;
          final updatedProfile = currentData.data!.copyWith(
            interestState: "sent",
            interestStatus: "Pending",
            pendingReminderCount: currentPending > 0 ? currentPending - 1 : 0,
            canSendReminder: false,
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(interestState: "sent");
        }
      }
      return result;
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteInterest() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return {"status": "error", "message": "Profile not loaded"};

    try {
      final repository = ref.read(connectionRepositoryProvider);
      final interestIdStr = await _getInterestId(currentProfile);
      final params = {
        "interest_request_id": interestIdStr,
        "receiver_member_id": memberId,
      };
      final result = await repository.removeInterest(params);
      if (result['status'] == "success") {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          final updatedProfile = currentData.data!.copyWith(
            interestState: "none",
            interestStatus: "not_sent",
            interestId: null,
            canSendReminder: false,
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(interestState: "none");
        }
      }
      return result;
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<bool> toggleBlock() async {
    final currentProfile = state.value?.data;
    if (currentProfile == null) return false;

    final isBlocked = checkIsBlocked(currentProfile);
    final action = isBlocked ? "remove" : "add";

    try {
      final repository = ref.read(settingsRepositoryProvider);
      final params = {
        "receiver_member_id": memberId,
        "action": action,
      };
      
      final result = await repository.performAction(blockActionApi, params);
      if (result['status'] == "success") {
        final currentData = state.value;
        if (currentData != null && currentData.data != null) {
          final updatedProfile = currentData.data!.copyWith(
            isBlock: isBlocked ? "0" : "1",
          );
          state = AsyncValue.data(currentData.copyWith(data: updatedProfile));
          _syncToGlobalLists(isBlocked: !isBlocked);
        }
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  Future<dynamic> viewContactDetails() async {
    final repository = ref.read(profileRepositoryProvider);
    final result = await repository.getOtherMemberContactDetails(memberId);
    if (result['status'] == "success") {
      await refresh();
    }
    return result;
  }
}
