import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/data/repositories/home_repository.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/services/lat_long_service.dart';

import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'zego_notifier.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  FutureOr<DashboardData?> build() async {
    return _fetchDashboardData();
  }

  Future<DashboardData?> _fetchDashboardData() async {
    final isLoggedIn =
        AppSessionService.getValue(SessionDetail.kIsLoggedIn) == true;
    final token =
        AppSessionService.getValue(SessionDetail.kAccessToken)?.toString() ?? '';
    if (!isLoggedIn || token.trim().isEmpty) {
      printLog("Dashboard Notifier: User is not logged in, skipping dashboard fetch");
      return null;
    }

    printLog("Dashboard Notifier: Start fetching data");
    final response = await ref.read(homeRepositoryProvider).getDashboardData();
    printLog("Dashboard Notifier: Response status is ${response.status}");
    if (response.status == "success" && response.data != null) {
      await _processSiteSettingZegoKeys(response.data?.siteSetting);
      return response.data;
    }
    printLog("Dashboard Notifier: Data fetch failed or status not success");
    throw Exception(response.message ?? "failed_to_load_dashboard");
  }

  Future<void> _processSiteSettingZegoKeys(Map<String, dynamic>? siteSetting) async {
    if (siteSetting == null) return;
    try {
      final dynamicAppId = siteSetting['zegocloud_appid']?.toString().trim();
      final dynamicAppSign = siteSetting['zegocloud_appsign_key']?.toString().trim();

      final previousAppId = AppSessionService.getValue(SessionDetail.kZegoAppId)?.toString().trim();
      final previousAppSign = AppSessionService.getValue(SessionDetail.kZegoAppSign)?.toString().trim();

      bool keysUpdated = false;
      if (dynamicAppId != null && dynamicAppId.isNotEmpty && dynamicAppId != 'null') {
        if (previousAppId != dynamicAppId) {
          await AppSessionService.setValue(SessionDetail.kZegoAppId, dynamicAppId);
          keysUpdated = true;
        }
      }
      if (dynamicAppSign != null && dynamicAppSign.isNotEmpty && dynamicAppSign != 'null') {
        if (previousAppSign != dynamicAppSign) {
          await AppSessionService.setValue(SessionDetail.kZegoAppSign, dynamicAppSign);
          keysUpdated = true;
        }
      }

      if (keysUpdated) {
        printLog("ZEGO_DYNAMIC: Dynamic Zego keys updated from dashboard site_setting (appId: $dynamicAppId)");
        try {
          await ref.read(zegoProvider.notifier).initZegoCloud(forceReinit: true);
        } catch (e) {
          printLog("ZEGO_DYNAMIC_ERROR: Could not re-init Zego Cloud: $e");
        }
      }
    } catch (e) {
      printLog("ZEGO_DYNAMIC_ERROR: Error processing dynamic Zego keys: $e");
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDashboardData());
    try {
      ref.read(myProfileProvider.notifier).refresh();
    } catch (_) {}
  }

  void clearNotificationBadge() {
    final currentData = state.value;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(unreadNotificationCount: 0),
      );
    }
  }

  /// Called once from Dashboard after data is available.
  /// Runs in background — updates lat/long and device_id if missing from response.
  Future<void> triggerLatLongUpdate() async {
    final dashboardData = state.value;
    if (dashboardData == null) {
      printLog('DashboardNotifier: dashboard data not available, skipping lat/long update.');
      return;
    }
    final repository = ref.read(homeRepositoryProvider);
    await LatLongService().tryUpdateLatLong(
      dashboardData: dashboardData,
      repository: repository,
    );
  }

  void updateMemberShortlist(String memberId, bool isShortlisted) {
    final currentData = state.value;
    if (currentData == null) return;

    MemberListModel updateItem(MemberListModel item) {
      final itemId = (item.id ?? item.memberId)?.toString();
      if (itemId == memberId) {
        return item.copyWith(isShortlisted: isShortlisted ? "1" : "0");
      }
      return item;
    }

    List<MemberListModel>? updateList(List<MemberListModel>? list) {
      if (list == null) return null;
      return list.map(updateItem).toList();
    }

    final updatedData = currentData.copyWith(
      todayMatches: updateList(currentData.todayMatches),
      recentlyJoinedMember: updateList(currentData.recentlyJoinedMember),
      recommendedMatches: updateList(currentData.recommendedMatches),
      whoViewMyProfile: updateList(currentData.whoViewMyProfile),
      receivedInterest: updateList(currentData.receivedInterest),
      recentlyLoginMember: updateList(currentData.recentlyLoginMember),
      recommedMatchesMember: updateList(currentData.recommedMatchesMember),
      premiumMatchesMember: updateList(currentData.premiumMatchesMember),
      nearByMatchesMember: updateList(currentData.nearByMatchesMember),
      featuredMember: updateList(currentData.featuredMember),
    );

    state = AsyncValue.data(updatedData);
  }

  void updateMemberInterestStatus(String connectionId, String responseStatus) {
    final currentData = state.value;
    if (currentData == null) return;

    MemberListModel updateItem(MemberListModel item) {
      final itemId = item.id?.toString();
      if (itemId == connectionId) {
        return item.copyWith(receiverResponse: responseStatus);
      }
      return item;
    }

    List<MemberListModel>? updateList(List<MemberListModel>? list) {
      if (list == null) return null;
      return list.map(updateItem).toList();
    }

    final updatedData = currentData.copyWith(
      receivedInterest: updateList(currentData.receivedInterest),
    );

    state = AsyncValue.data(updatedData);
  }
}
