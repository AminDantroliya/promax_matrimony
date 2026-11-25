import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/widgets/membership_upgrade_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/display_over_other_apps_bottom_sheet.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/features/common/data/repositories/action_repository.dart';
import 'package:pro_matrimony/features/home/providers/zego_notifier.dart';
import 'package:pro_matrimony/features/plan/data/models/plan_models.dart';
import 'package:pro_matrimony/features/plan/providers/plan_notifier.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/features/search/providers/search_notifier.dart';
import 'package:pro_matrimony/features/search/providers/matches_notifier.dart';
import 'package:pro_matrimony/features/matches/providers/ai_match_notifier.dart';
import 'package:pro_matrimony/features/activity/providers/activity_notifier.dart';

/// Syncs interest state updates to all active Riverpod list providers so card UIs update dynamically.
void syncInterestActionToAllProviders(
  WidgetRef ref,
  String memberId, {
  required bool isInterested,
}) {
  try {
    ref
        .read(searchResultProvider.notifier)
        .updateMemberAction(
          memberId: memberId,
          isInterested: isInterested,
          interestState: isInterested ? 'sent' : 'not_sent',
        );
  } catch (_) {}

  try {
    ref
        .read(aiMatchProvider.notifier)
        .updateMemberAction(
          memberId: memberId,
          isInterested: isInterested,
          interestState: isInterested ? 'sent' : 'not_sent',
        );
  } catch (_) {}

  for (final url in MatchType.values) {
    try {
      ref
          .read(matchesProvider(url).notifier)
          .updateMemberAction(
            memberId: memberId,
            isInterested: isInterested,
            interestState: isInterested ? 'sent' : 'not_sent',
          );
    } catch (_) {}
  }

  final urls = [
    getViewedProfileListApi,
    getViewedContactListApi,
    getRecentJoinedListApi,
    getRecentLoginListApi,
    getBlockedListApi,
    getShortlistedListApi,
  ];

  for (final url in urls) {
    try {
      ref
          .read(
            activityProvider(url, extraParams: {"type": "who_viewed"}).notifier,
          )
          .updateMemberAction(
            memberId: memberId,
            isInterested: isInterested,
            interestState: isInterested ? 'sent' : 'not_sent',
          );
      ref
          .read(
            activityProvider(url, extraParams: {"type": "i_viewed"}).notifier,
          )
          .updateMemberAction(
            memberId: memberId,
            isInterested: isInterested,
            interestState: isInterested ? 'sent' : 'not_sent',
          );
      ref
          .read(activityProvider(url).notifier)
          .updateMemberAction(
            memberId: memberId,
            isInterested: isInterested,
            interestState: isInterested ? 'sent' : 'not_sent',
          );
    } catch (_) {}
  }
}

/// Syncs shortlist state updates to all active Riverpod list providers so card UIs update dynamically.
void syncShortlistActionToAllProviders(
  WidgetRef ref,
  String memberId, {
  required bool isShortlisted,
}) {
  try {
    ref
        .read(searchResultProvider.notifier)
        .updateMemberAction(memberId: memberId, isShortlisted: isShortlisted);
  } catch (_) {}

  try {
    ref
        .read(aiMatchProvider.notifier)
        .updateMemberAction(memberId: memberId, isShortlisted: isShortlisted);
  } catch (_) {}

  for (final url in MatchType.values) {
    try {
      ref
          .read(matchesProvider(url).notifier)
          .updateMemberAction(memberId: memberId, isShortlisted: isShortlisted);
    } catch (_) {}
  }

  final urls = [
    getViewedProfileListApi,
    getViewedContactListApi,
    getRecentJoinedListApi,
    getRecentLoginListApi,
    getBlockedListApi,
    getShortlistedListApi,
  ];

  for (final url in urls) {
    try {
      ref
          .read(
            activityProvider(url, extraParams: {"type": "who_viewed"}).notifier,
          )
          .updateMemberAction(memberId: memberId, isShortlisted: isShortlisted);
      ref
          .read(
            activityProvider(url, extraParams: {"type": "i_viewed"}).notifier,
          )
          .updateMemberAction(memberId: memberId, isShortlisted: isShortlisted);
      ref
          .read(activityProvider(url).notifier)
          .updateMemberAction(memberId: memberId, isShortlisted: isShortlisted);
    } catch (_) {}
  }
}

/// Syncs block state updates to all active Riverpod list providers so card UIs update dynamically.
void syncBlockActionToAllProviders(
  WidgetRef ref,
  String memberId, {
  required bool isBlocked,
}) {
  try {
    ref
        .read(searchResultProvider.notifier)
        .updateMemberAction(memberId: memberId, isBlocked: isBlocked);
  } catch (_) {}

  try {
    ref
        .read(aiMatchProvider.notifier)
        .updateMemberAction(memberId: memberId, isBlocked: isBlocked);
  } catch (_) {}

  for (final url in MatchType.values) {
    try {
      ref
          .read(matchesProvider(url).notifier)
          .updateMemberAction(memberId: memberId, isBlocked: isBlocked);
    } catch (_) {}
  }

  final urls = [
    getViewedProfileListApi,
    getViewedContactListApi,
    getRecentJoinedListApi,
    getRecentLoginListApi,
    getBlockedListApi,
    getShortlistedListApi,
  ];

  for (final url in urls) {
    try {
      ref
          .read(
            activityProvider(url, extraParams: {"type": "who_viewed"}).notifier,
          )
          .updateMemberAction(memberId: memberId, isBlocked: isBlocked);
      ref
          .read(
            activityProvider(url, extraParams: {"type": "i_viewed"}).notifier,
          )
          .updateMemberAction(memberId: memberId, isBlocked: isBlocked);
      ref
          .read(activityProvider(url).notifier)
          .updateMemberAction(memberId: memberId, isBlocked: isBlocked);
    } catch (_) {}
  }
}

// ── Method channel for Android native permission checks ─────────────────────
const _permissionChannel = MethodChannel('com.artofliving.matrimony/permissions');

/// Checks if Android 14+ USE_FULL_SCREEN_INTENT permission is granted.
/// Returns true on non-Android or Android < 14 (always considered granted).
Future<bool> _canUseFullScreenIntent() async {
  if (!Platform.isAndroid) return true;
  try {
    final bool result =
        await _permissionChannel.invokeMethod('canUseFullScreenIntent') ?? true;
    return result;
  } catch (_) {
    return true; // Assume granted on older versions / if channel not yet set up
  }
}

/// Opens Android Settings → Special App Access → Allow Full Screen Intents
Future<void> _openFullScreenIntentSettings() async {
  try {
    await _permissionChannel.invokeMethod('openFullScreenIntentSettings');
  } catch (e) {
    printLog("openFullScreenIntentSettings error: $e");
  }
}

/// Prompts the user for lock screen call notification permissions (Notifications & System Alert Window / Appear on top)
/// when the app is opened or initialized.
/// Returns true if systemAlertWindow was newly granted (caller should re-init Zego).
Future<bool> requestLockScreenCallPermissions(
  BuildContext context, {
  WidgetRef? ref,
}) async {
  bool systemAlertJustGranted = false;
  try {
    if (ref != null) {
      final bool enableVideoCall = ref.read(featureProvider('enableVideoCall'));
      final bool enableVoiceCall = ref.read(featureProvider('enableVoiceCall'));
      if (!enableVideoCall && !enableVoiceCall) {
        printLog(
          "PERMISSIONS: Video and voice calling are disabled, skipping lock screen call permissions",
        );
        return false;
      }
    }

    // 1. Request Notification Permission (Android 13+ & iOS)
    final notificationStatus = await Permission.notification.status;
    if (!notificationStatus.isGranted) {
      await Permission.notification.request();
    }

    if (context.mounted &&
        Theme.of(context).platform == TargetPlatform.android) {
      // 2. Request System Alert Window ("Display over other apps" / Lock Screen Call display)
      final alertStatus = await Permission.systemAlertWindow.status;
      if (!alertStatus.isGranted && context.mounted) {
        // Show informative bottomsheet before navigating user to system settings
        final shouldOpenSettings =
            await DisplayOverOtherAppsBottomSheet.show(context);
        if (shouldOpenSettings) {
          await Permission.systemAlertWindow.request();
          // Check again after user returns from settings
          final alertStatusAfter = await Permission.systemAlertWindow.status;
          if (alertStatusAfter.isGranted) {
            systemAlertJustGranted = true;
          }
        }
      }

      // 3. Check USE_FULL_SCREEN_INTENT (Android 14+ / API 34+) — must be granted explicitly
      final canFullScreen = await _canUseFullScreenIntent();
      if (!canFullScreen && context.mounted) {
        printLog(
          "USE_FULL_SCREEN_INTENT not granted — prompting user to grant in settings",
        );
        // Show a dialog directing the user to grant it
        final confirmed = await AppDialogs.confirm(
          context,
          title: 'enable_full_screen_calls_title'.tr,
          message: 'enable_full_screen_calls_desc'.tr,
          confirmLabel: 'open_settings'.tr,
          cancelLabel: 'btn_cancel'.tr,
        );
        if (confirmed && context.mounted) {
          await _openFullScreenIntentSettings();
        }
      }
    }
  } catch (e) {
    printLog("Error requesting lock screen call permissions: $e");
  }
  return systemAlertJustGranted;
}

/// Request camera and microphone permissions dynamically on-demand
/// when the user taps on Video Call or Voice Call buttons.
Future<bool> checkAndRequestCallPermissions({required bool isVideo}) async {
  if (isVideo) {
    final cameraStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();
    if (!cameraStatus.isGranted || !micStatus.isGranted) {
      showToast('camera_mic_permission_req'.tr);
      return false;
    }
    return true;
  } else {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      showToast('mic_permission_req'.tr);
      return false;
    }
    return true;
  }
}

/// Helper method to validate call settings (0 = All paid member, 1 = Only Interest Accepted member),
/// interest status, system permissions, and initiate Zego Voice / Video Call.
Future<bool> initiateAppCall(
  BuildContext context,
  WidgetRef ref, {
  required dynamic targetModel,
  required bool isVideo,
  bool sendCallInvitation = true,
}) async {
  // 0. Check if calling feature is enabled in admin controls
  final bool isFeatureEnabled = ref.read(
    featureProvider(isVideo ? 'enableVideoCall' : 'enableVoiceCall'),
  );
  if (!isFeatureEnabled) {
    showToast(isVideo ? 'video_call_disabled'.tr : 'voice_call_disabled'.tr);
    return false;
  }

  // 1. Check if current user has blocked target member
  if (checkIsBlocked(targetModel)) {
    showToast('please_unblock_first_to_call'.tr);
    return false;
  }

  // 2. Check if target member has blocked current user
  if (checkIsBlockedByUser(targetModel)) {
    showToast('user_blocked_you_cannot_call'.tr);
    return false;
  }

  // 3. Check if interest status / state is Rejected or Declined
  final status =
      (getFieldValue(targetModel, 'interestStatus') ??
              getFieldValue(targetModel, 'interest_status'))
          ?.toString()
          .toLowerCase()
          .trim() ??
      '';
  final state =
      (getFieldValue(targetModel, 'interestState') ??
              getFieldValue(targetModel, 'interest_state'))
          ?.toString()
          .toLowerCase()
          .trim() ??
      '';

  if (status == 'rejected' ||
      state == 'rejected' ||
      status == 'decline' ||
      status == 'declined' ||
      status.contains('reject') ||
      state.contains('reject')) {
    showToast('interest_rejected_cannot_call'.tr);
    return false;
  }

  // 3. Check if current user is paid
  final bool isPaid = ApplicationData.isMemberPaid == true;
  if (!isPaid) {
    MembershipUpgradeBottomSheet.show(
      context,
      'upgrade_your_membership_message'.tr,
    );
    return false;
  }

  // 3.1 Check if current plan has remaining video/voice call minutes
  CurrentPlanData? planData;
  try {
    planData = await ref.read(currentPlanProvider.future);
  } catch (e) {
    printLog("Error fetching current plan in initiateAppCall: $e");
  }
  CurrentPlan? currentPlan = planData?.currentPlanArr;

  int remainingMinutes = 0;
  if (isVideo) {
    if (currentPlan?.videoMinutesTotal != null) {
      final total =
          int.tryParse(currentPlan!.videoMinutesTotal.toString()) ?? 0;
      final used =
          int.tryParse(currentPlan.videoMinutesUsed?.toString() ?? "0") ?? 0;
      remainingMinutes = total - used;
    } else {
      final parts = (currentPlan?.planVideoCallRemaining ?? "0 / 0").split('/');
      if (parts.length == 2) {
        remainingMinutes = int.tryParse(parts[0].trim()) ?? 0;
      }
    }
  } else {
    if (currentPlan?.audioMinutesTotal != null) {
      final total =
          int.tryParse(currentPlan!.audioMinutesTotal.toString()) ?? 0;
      final used =
          int.tryParse(currentPlan.audioMinutesUsed?.toString() ?? "0") ?? 0;
      remainingMinutes = total - used;
    } else {
      final parts = (currentPlan?.planAudioCallRemaining ?? "0 / 0").split('/');
      if (parts.length == 2) {
        remainingMinutes = int.tryParse(parts[0].trim()) ?? 0;
      }
    }
  }

  if (!context.mounted) return false;

  if (remainingMinutes <= 0) {
    MembershipUpgradeBottomSheet.show(
      context,
      isVideo
          ? 'no_video_call_minutes_message'.tr
          : 'no_audio_call_minutes_message'.tr,
    );
    return false;
  }

  // Save remaining call minutes for duration enforcer
  ApplicationData.remainingCallMinutes = remainingMinutes;

  // 2. Extract call settings (video_call_setting / voice_call_setting)
  // 0 = All paid member, 1 = Only Interest Accepted member
  dynamic rawSetting = isVideo
      ? (getFieldValue(targetModel, 'videoCallSetting') ??
            getFieldValue(targetModel, 'video_call_setting'))
      : (getFieldValue(targetModel, 'voiceCallSetting') ??
            getFieldValue(targetModel, 'voice_call_setting'));

  if (rawSetting == null || rawSetting.toString().trim().isEmpty) {
    final settingKey = isVideo ? 'video_call_setting' : 'voice_call_setting';
    final camelSettingKey = isVideo ? 'videoCallSetting' : 'voiceCallSetting';

    if (targetModel is MemberListModel) {
      if (targetModel.sender is Map) {
        rawSetting =
            targetModel.sender[settingKey] ??
            targetModel.sender[camelSettingKey];
      }
      if ((rawSetting == null || rawSetting.toString().trim().isEmpty) &&
          targetModel.receiver is Map) {
        rawSetting =
            targetModel.receiver[settingKey] ??
            targetModel.receiver[camelSettingKey];
      }
    } else if (targetModel is Map) {
      if (targetModel['sender'] is Map) {
        rawSetting =
            targetModel['sender'][settingKey] ??
            targetModel['sender'][camelSettingKey];
      }
      if ((rawSetting == null || rawSetting.toString().trim().isEmpty) &&
          targetModel['receiver'] is Map) {
        rawSetting =
            targetModel['receiver'][settingKey] ??
            targetModel['receiver'][camelSettingKey];
      }
    }
  }

  final int setting =
      (rawSetting == null || rawSetting.toString().trim().isEmpty)
      ? 0
      : (int.tryParse(rawSetting.toString()) ?? 0);

  // 3. Check interest state & status for call restrictions
  final bool isInterestRejected = checkIsInterestRejected(targetModel);
  if (isInterestRejected) {
    showToast('user_rejected_interest_cannot_call'.tr);
    return false;
  }

  if (setting == 1) {
    final bool isInterestSent = checkIsInterest(targetModel);
    final bool isInterestAccepted = checkIsInterestAccepted(targetModel);

    if (!isInterestSent) {
      // Interest not sent -> ask user to send express interest first
      final confirm = await AppDialogs.confirm(
        context,
        title: isVideo
            ? 'video_call_restriction'.tr
            : 'voice_call_restriction'.tr,
        message: 'call_restriction_interest_desc'.tr,
        confirmLabel: 'send_interest'.tr,
        cancelLabel: 'btn_cancel'.tr,
      );

      if (confirm == true && context.mounted) {
        final targetMemberId =
            (getFieldValue(targetModel, 'memberId') ??
                    getFieldValue(targetModel, 'member_id') ??
                    getFieldValue(targetModel, 'id'))
                ?.toString() ??
            "";
        if (targetMemberId.isNotEmpty) {
          showLoading(context);
          final result = await ref
              .read(actionRepositoryProvider)
              .sendInterest(receiverMemberId: targetMemberId);
          hideLoading();
          if (context.mounted) {
            handleInterestResult(
              context: context,
              mounted: context.mounted,
              result: result,
              onSuccess: () {
                showToast('interest_sent_success'.tr);
                syncInterestActionToAllProviders(
                  ref,
                  targetMemberId,
                  isInterested: true,
                );
              },
            );
          }
        }
      }
      return false;
    }

    if (!isInterestAccepted) {
      // Interest sent, but not accepted yet -> error toast
      showToast('interest_not_accepted_yet'.tr);
      return false;
    }
  }

  // 4. Check Camera / Mic system permissions
  final bool hasPermissions = await checkAndRequestCallPermissions(
    isVideo: isVideo,
  );
  if (!hasPermissions) return false;

  // 5. Target Matri ID & User ID extraction
  final String currentMatriId =
      AppSessionService.getValue(SessionDetail.kMatriId)?.toString() ?? "";
  final String currentUserId =
      AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? "";

  String targetMatriId = "";
  String targetUserId = "";

  final matriCandidates = [
    getFieldValue(targetModel, 'matriId'),
    getFieldValue(targetModel, 'matri_id'),
    getFieldValue(targetModel, 'receiverMatriId'),
    getFieldValue(targetModel, 'receiver_matri_id'),
    getFieldValue(targetModel, 'senderMatriId'),
    getFieldValue(targetModel, 'sender_matri_id'),
    getFieldValue(targetModel, 'viewerMatriId'),
    getFieldValue(targetModel, 'viewer_matri_id'),
    getFieldValue(targetModel, 'profileMatriId'),
    getFieldValue(targetModel, 'profile_matri_id'),
  ];
  if (targetModel is MemberListModel) {
    if (targetModel.sender is Map) {
      matriCandidates.add(targetModel.sender['matri_id']);
      matriCandidates.add(targetModel.sender['matriId']);
    }
    if (targetModel.receiver is Map) {
      matriCandidates.add(targetModel.receiver['matri_id']);
      matriCandidates.add(targetModel.receiver['matriId']);
    }
  }

  for (final cand in matriCandidates) {
    if (cand != null) {
      final str = cand.toString().trim();
      if (str.isNotEmpty && str != 'null' && str != currentMatriId) {
        targetMatriId = str;
        break;
      }
    }
  }

  final userCandidates = [
    getFieldValue(targetModel, 'memberId'),
    getFieldValue(targetModel, 'member_id'),
    getFieldValue(targetModel, 'receiverMemberId'),
    getFieldValue(targetModel, 'receiver_member_id'),
    getFieldValue(targetModel, 'senderMemberId'),
    getFieldValue(targetModel, 'sender_member_id'),
    getFieldValue(targetModel, 'viewerMemberId'),
    getFieldValue(targetModel, 'viewer_member_id'),
    getFieldValue(targetModel, 'viewedMemberId'),
    getFieldValue(targetModel, 'viewed_member_id'),
    getFieldValue(targetModel, 'id'),
  ];
  if (targetModel is MemberListModel) {
    if (targetModel.sender is Map) {
      userCandidates.add(targetModel.sender['id']);
      userCandidates.add(targetModel.sender['member_id']);
    }
    if (targetModel.receiver is Map) {
      userCandidates.add(targetModel.receiver['id']);
      userCandidates.add(targetModel.receiver['member_id']);
    }
  }

  for (final cand in userCandidates) {
    if (cand != null) {
      final str = cand.toString().trim();
      if (str.isNotEmpty && str != 'null' && str != currentUserId) {
        targetUserId = str;
        break;
      }
    }
  }

  if (targetMatriId.isEmpty && targetUserId.isEmpty) {
    final rawMatri =
        (getFieldValue(targetModel, 'matriId') ??
                getFieldValue(targetModel, 'matri_id'))
            ?.toString() ??
        "";
    final rawUser =
        (getFieldValue(targetModel, 'memberId') ??
                getFieldValue(targetModel, 'member_id') ??
                getFieldValue(targetModel, 'id'))
            ?.toString() ??
        "";
    if (rawMatri != currentMatriId) targetMatriId = rawMatri;
    if (rawUser != currentUserId) targetUserId = rawUser;
  }

  if (targetMatriId.isEmpty && targetUserId.isEmpty) {
    showToast('target_member_not_found'.tr);
    return false;
  }

  final String zegoTargetId = targetMatriId.isNotEmpty
      ? targetMatriId
      : targetUserId;

  // Set global application data for call history tracking
  ApplicationData.otherMatriId = zegoTargetId;
  ApplicationData.otherUserId = targetUserId.isNotEmpty
      ? targetUserId
      : zegoTargetId;
  ApplicationData.callType = isVideo ? "videoCall" : "voiceCall";

  // Ensure Zego Cloud invitation service is initialized
  if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
    printLog(
      "CALL_SEND: Zego not initialized. Initializing for current user...",
    );
    await ref.read(zegoProvider.notifier).initZegoCloud();
  }

  if (sendCallInvitation) {
    final currentUserId =
        AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? "";
    final callerMatriId =
        AppSessionService.getValue(SessionDetail.kMatriId)?.toString().trim() ?? "";
    final callerTitle = callerMatriId.isNotEmpty ? callerMatriId : "Incoming Call";
    final callMessage = isVideo ? "Incoming video call..." : "Incoming voice call...";

    bool sentResult = await ZegoUIKitPrebuiltCallInvitationService().send(
      invitees: [ZegoCallUser(zegoTargetId, zegoTargetId)],
      isVideoCall: isVideo,
      resourceID: "zegouikit_call",
      notificationTitle: callerTitle,
      notificationMessage: callMessage,
      customData: jsonEncode({"user_id": currentUserId}),
    );

    // If signaling was disconnected, force re-initialize signaling connection and retry
    if (!sentResult) {
      printLog(
        "CALL_SEND: Signaling plugin was disconnected. Re-initializing Zego Cloud signaling...",
      );
      await ref.read(zegoProvider.notifier).initZegoCloud(forceReinit: true);
      sentResult = await ZegoUIKitPrebuiltCallInvitationService().send(
        invitees: [ZegoCallUser(zegoTargetId, zegoTargetId)],
        isVideoCall: isVideo,
        resourceID: "zegouikit_call",
        notificationTitle: callerTitle,
        notificationMessage: callMessage,
        customData: jsonEncode({"user_id": currentUserId}),
      );
    }

    printLog("Zego call send result for $zegoTargetId: $sentResult");
  }

  return true;
}

/// Checks whether the user's active membership plan includes the Auto AI Interest feature (`ai_interest` == 1).
/// If allowed, returns true.
/// If not allowed, shows [MembershipUpgradeBottomSheet] with appropriate message and returns false.
Future<bool> checkAiInterestPermission(
  BuildContext context,
  WidgetRef ref,
) async {
  CurrentPlanData? planData;
  try {
    planData = await ref.read(currentPlanProvider.future);
  } catch (e) {
    printLog("Error fetching current plan in checkAiInterestPermission: $e");
  }

  final currentPlan = planData?.currentPlanArr;
  final aiInterestVal = currentPlan?.aiInterest;

  final bool hasAiInterestPermission =
      aiInterestVal == 1 ||
      aiInterestVal == "1" ||
      aiInterestVal == true ||
      aiInterestVal.toString().toLowerCase() == "yes";

  if (hasAiInterestPermission) {
    return true;
  }

  final message = 'plan_doesnt_have_ai_interest_feature'.tr;

  if (context.mounted) {
    MembershipUpgradeBottomSheet.show(context, message);
  }
  return false;
}

/// Checks whether the user's active membership plan includes Live Chat (`can_chat` == 1 / `chat` == 'yes').
/// If allowed, returns true.
/// If not allowed, shows [MembershipUpgradeBottomSheet] with appropriate message and returns false.
Future<bool> checkChatPermission(
  BuildContext context,
  WidgetRef ref, {
  bool showUpgradeSheet = true,
}) async {
  // 1. Check if user is a paid member
  if (ApplicationData.isMemberPaid != true) {
    if (showUpgradeSheet && context.mounted) {
      MembershipUpgradeBottomSheet.show(
        context,
        'upgrade_your_membership_message'.tr,
      );
    }
    return false;
  }

  // 2. Fetch or retrieve current plan
  CurrentPlanData? planData;
  final currentPlanVal = ref.read(currentPlanProvider).value;
  if (currentPlanVal != null) {
    planData = currentPlanVal;
  } else {
    try {
      planData = await ref.read(currentPlanProvider.future);
    } catch (e) {
      printLog("Error fetching current plan in checkChatPermission: $e");
    }
  }

  final currentPlan = planData?.currentPlanArr;
  if (currentPlan == null) {
    if (showUpgradeSheet && context.mounted) {
      MembershipUpgradeBottomSheet.show(
        context,
        'upgrade_your_membership_message'.tr,
      );
    }
    return false;
  }

  // 3. Check chat permission from plan
  final canChatVal = currentPlan.canChat;
  final chatVal = currentPlan.chat?.toString().toLowerCase().trim();

  bool hasChatPermission = false;
  if (canChatVal != null) {
    hasChatPermission =
        canChatVal == 1 ||
        canChatVal == "1" ||
        canChatVal == true ||
        canChatVal.toString().toLowerCase() == "true" ||
        canChatVal.toString().toLowerCase() == "yes";
  } else if (chatVal != null && chatVal.isNotEmpty) {
    hasChatPermission = chatVal == "yes" || chatVal == "1" || chatVal == "true";
  }

  if (hasChatPermission) {
    return true;
  }

  if (showUpgradeSheet && context.mounted) {
    final message = 'plan_doesnt_have_live_chat_feature'.tr;
    MembershipUpgradeBottomSheet.show(
      context,
      message.isNotEmpty && message != 'plan_doesnt_have_live_chat_feature'
          ? message
          : 'not_plan'.tr,
    );
  }
  return false;
}
