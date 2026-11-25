import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zpns/zego_zpns.dart';
import '../../../../utils/app_debug.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/application_data.dart';
import '../../../../utils/utils.dart';

import '../../../../preference/session_keys.dart';
import '../../../../services/app_session_service.dart';
import '../../../../services/zego_initialization_service.dart';
import 'package:go_router/go_router.dart';
import '../../plan/providers/plan_notifier.dart';
import '../data/repositories/home_repository.dart';
import '../widgets/call_foreground_overlay.dart';

part 'zego_notifier.g.dart';

@Riverpod(keepAlive: true)
class ZegoNotifier extends _$ZegoNotifier {
  int _callDuration = 0;
  String _otherMatriId = "";
  bool _hasSyncedHistoryForCurrentCall = false;
  bool _isInitiator = false;
  int? _initializedAppId;
  String? _initializedAppSign;

  @override
  void build() {
    // Initialization only
  }

  Future<bool> initZegoCloud({bool forceReinit = false}) async {
    final bool enableVideoCall = ref.read(featureProvider('enableVideoCall'));
    final bool enableVoiceCall = ref.read(featureProvider('enableVoiceCall'));
    if (!enableVideoCall && !enableVoiceCall) {
      printLog(
        "ZEGO_INIT: Video and voice calling are disabled, skipping Zego Cloud init",
      );
      if (ZegoUIKitPrebuiltCallInvitationService().isInit) {
        try {
          await ZegoUIKitPrebuiltCallInvitationService().uninit();
        } catch (_) {}
      }
      return false;
    }

    String matriId =
        AppSessionService.getValue(SessionDetail.kMatriId)?.toString().trim() ?? "";
    final userId =
        AppSessionService.getValue(SessionDetail.kUserId)?.toString().trim() ?? "";

    // 1. If matriId is empty or invalid, try to recover from cached userProfileData
    if (matriId.isEmpty || matriId == "null" || matriId == "N/A") {
      final cachedProfile = AppSessionService.getValue("userProfileData");
      if (cachedProfile != null && cachedProfile.toString().isNotEmpty) {
        try {
          final profileMap = jsonDecode(cachedProfile.toString());
          if (profileMap is Map && profileMap['matri_id'] != null) {
            final raw = profileMap['matri_id'].toString().trim();
            if (raw.isNotEmpty && raw != 'null') {
              matriId = raw;
            }
          }
        } catch (_) {}
      }
    }

    // 2. If still empty, fall back to userId
    if (matriId.isEmpty || matriId == "null" || matriId == "N/A") {
      if (userId.isNotEmpty && userId != "null") {
        matriId = userId;
      }
    }

    if (matriId.isEmpty || matriId == "null" || matriId == "N/A") {
      printLog("ZEGO_INIT: Invalid or empty MatriId / UserId '$matriId'");
      return false;
    }

    // 3. Normalize Matri ID: If purely numeric (e.g. "116"), prefix with "PROMATRI"
    if (RegExp(r'^\d+$').hasMatch(matriId)) {
      matriId = "PROMATRI$matriId";
    }

    // Persist normalized Matri ID so session is always consistent
    await AppSessionService.setValue(SessionDetail.kMatriId, matriId);

    final currentAppId = zegoAppId;
    final currentAppSign = zegoAppSign;

    if (ZegoUIKitPrebuiltCallInvitationService().isInit && !forceReinit) {
      if (_initializedAppId != null && _initializedAppId != currentAppId) {
        printLog("ZEGO_INIT: App ID changed ($_initializedAppId -> $currentAppId), triggering re-init");
        forceReinit = true;
      } else if (_initializedAppSign != null && _initializedAppSign != currentAppSign) {
        printLog("ZEGO_INIT: App Sign changed, triggering re-init");
        forceReinit = true;
      } else {
        printLog("ZEGO_INIT: Already initialized for $matriId (appID: $currentAppId)");
        return true;
      }
    }

    if (forceReinit && ZegoUIKitPrebuiltCallInvitationService().isInit) {
      printLog("ZEGO_INIT: Force re-initializing Zego Cloud for $matriId (appID: $currentAppId)");
      try {
        await ZegoUIKitPrebuiltCallInvitationService().uninit();
      } catch (e) {
        printLog("ZEGO_UNINIT_ERROR: $e");
      }
    }

    printLog("ZEGO_INIT: Initializing Zego Cloud for $matriId (appID: $currentAppId)");

    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(
      ZegoInitializationService.navigatorKey,
    );

    await ZegoUIKitPrebuiltCallInvitationService().init(
      appID: currentAppId,
      appSign: currentAppSign,
      userID: matriId,
      userName: matriId,
      plugins: [ZegoUIKitSignalingPlugin()],
      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(
          showOnFullScreen: true,
          showOnLockedScreen: true,
          callChannel: ZegoCallAndroidNotificationChannelConfig(
            channelID: "zegouikit_call",
            channelName: "Call Notifications",
            sound: "call",
            icon: "ic_launcher",
            vibrate: true,
          ),
          missedCallChannel: ZegoCallAndroidNotificationChannelConfig(
            channelID: "zegouikit_call_missed",
            channelName: "Missed Call Notifications",
            icon: "ic_launcher",
            vibrate: true,
          ),
        ),
      ),
      config: ZegoCallInvitationConfig(
        endCallWhenInitiatorLeave: true,
        permissions: [],
        missedCall: ZegoCallInvitationMissedCallConfig(
          enabled: true,
          enableDialBack: false,
        ),
      ),
      uiConfig: ZegoCallInvitationUIConfig(
        withSafeArea: false,
        inviter: ZegoCallInvitationInviterUIConfig(
          useVideoViewAspectFill: true,
          showSubButtonsText: false,
          showMainButtonsText: false,
          microphoneButton: ZegoCallButtonUIConfig(visible: false),
          speakerButton: ZegoCallButtonUIConfig(visible: false),
          cameraButton: ZegoCallButtonUIConfig(visible: false),
          cancelButton: ZegoCallButtonUIConfig(visible: true),
          cameraSwitchButton: ZegoCallButtonUIConfig(
            visible: true,
            icon: const Icon(
              Icons.cameraswitch_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
        invitee: ZegoCallInvitationInviteeUIConfig(
          useVideoViewAspectFill: true,
          showSubButtonsText: false,
          showMainButtonsText: false,
          microphoneButton: ZegoCallButtonUIConfig(visible: false),
          speakerButton: ZegoCallButtonUIConfig(visible: false),
          cameraButton: ZegoCallButtonUIConfig(visible: false),
          declineButton: ZegoCallButtonUIConfig(visible: true),
          acceptButton: ZegoCallButtonUIConfig(visible: true),
          cameraSwitchButton: ZegoCallButtonUIConfig(
            visible: true,
            icon: const Icon(
              Icons.cameraswitch_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
      requireConfig: (ZegoCallInvitationData data) {
        _hasSyncedHistoryForCurrentCall = false;
        var config = (data.invitees.length > 1)
            ? ZegoCallInvitationType.videoCall == data.type
                  ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                  : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoCallInvitationType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        // ── Video Aspect Fill & PiP layout ──────────────────────────────────
        config.audioVideoView.useVideoViewAspectFill = true;

        // Position self camera preview box at bottom-right above action bar (145px margin prevents overlap)
        config.layout = ZegoLayout.pictureInPicture(
          smallViewPosition: ZegoViewPosition.bottomRight,
          smallViewMargin: const EdgeInsets.only(
            bottom: 145,
            left: 16,
            right: 16,
            top: 16,
          ),
        );

        // ── Hide Zego default top & bottom menu bars (foreground overlay renders controls) ──
        config.topMenuBar.isVisible = false;
        config.bottomMenuBar.isVisible = false;

        // ── Duration ─────────────────────────────────────────────────────────
        config.duration.isVisible = false;
        config.duration.onDurationUpdate = (Duration duration) {
          _callDuration = duration.inSeconds;
          printLog("call duration : (${duration.inSeconds})");

          // Only the Initiator (Caller) enforces max call duration limit from plan minutes
          if (_isInitiator && ApplicationData.remainingCallMinutes > 0) {
            final int maxAllowedSeconds =
                ApplicationData.remainingCallMinutes * 60;
            if (duration.inSeconds >= maxAllowedSeconds) {
              printLog("MAX_CALL_DURATION_REACHED: $maxAllowedSeconds seconds");
              ZegoUIKit().leaveRoom();
              showToast('call_duration_limit_reached'.tr);
            }
          }
        };

        // ── Audio/Video view ──────────────────────────────────────────────────
        config.audioVideoView.showUserNameOnView = false;
        config.audioVideoView.showMicrophoneStateOnView = false;

        // Smooth loading background while media stream establishes (prevents pitch-black screen)
        config.audioVideoView.backgroundBuilder =
            (
              BuildContext context,
              Size size,
              ZegoUIKitUser? user,
              Map<String, dynamic> extraInfo,
            ) {
              return Container(
                color: const Color(0xFF1E1F25),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          color: Color(0xFF6C5CE7),
                          strokeWidth: 2.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Connecting call...",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            };

        // ── Resolve other user ID & Matri ID ──────────────────────────────────
        final currentMatriId =
            AppSessionService.getValue(SessionDetail.kMatriId)?.toString() ??
            "";
        final currentUserId =
            AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? "";

        _isInitiator =
            (data.inviter != null && data.inviter!.id == currentMatriId);

        String resolvedOtherMatriId = "";
        String resolvedOtherUserId = "";

        if (_isInitiator) {
          // CALLER SIDE: The OTHER user is the callee (data.invitees.first)
          if (data.invitees.isNotEmpty) {
            resolvedOtherMatriId = data.invitees.first.id;
          }
          if (ApplicationData.otherUserId.isNotEmpty &&
              ApplicationData.otherUserId != currentUserId) {
            resolvedOtherUserId = ApplicationData.otherUserId;
          }
        } else {
          // RECEIVER SIDE: The OTHER user is the caller (data.inviter)
          if (data.inviter != null) {
            resolvedOtherMatriId = data.inviter!.id;
          }
          if (data.customData.isNotEmpty) {
            try {
              dynamic decoded = jsonDecode(data.customData);
              if (decoded is String) {
                decoded = jsonDecode(decoded);
              }
              if (decoded is Map) {
                resolvedOtherUserId = decoded["user_id"]?.toString() ?? "";
              }
            } catch (e) {
              printLog("Error parsing customData: $e");
            }
          }
        }

        if (resolvedOtherMatriId.isNotEmpty) {
          _otherMatriId = resolvedOtherMatriId;
          ApplicationData.otherMatriId = resolvedOtherMatriId;
        }
        if (resolvedOtherUserId.isNotEmpty) {
          ApplicationData.otherUserId = resolvedOtherUserId;
        }

        printLog(
          "RESOLVED_OTHER_USER: MatriId='$_otherMatriId', UserId='${ApplicationData.otherUserId}', isInitiator=$_isInitiator",
        );

        final fallbackName = (!_isInitiator && data.inviter != null)
            ? data.inviter!.name
            : (data.invitees.isNotEmpty ? data.invitees.first.name : "");

        // ── Attractive foreground overlay (profile info + visual polish) ──────
        // Applied to BOTH video and voice calls.
        config.foreground = CallForegroundOverlay(
          isVideoCall: data.type == ZegoCallInvitationType.videoCall,
          otherUserId: ApplicationData.otherUserId,
          fallbackName: fallbackName,
        );

        ApplicationData.callType = data.type.name;

        return config;
      },
      events: ZegoUIKitPrebuiltCallEvents(
        onCallEnd: (event, defaultAction) {
          printLog("ZegoCallRoomEvents : ${event.reason}");

          // 1. Sync call history & minutes FIRST while context and state are valid:
          _addCallHistory("LeaveRoom");

          // 2. Restore system UI status bar mode:
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );

          // 3. Delegate route teardown to Zego's defaultAction.
          // Note: DO NOT call nav.pop() manually here as defaultAction already pops Zego's route.
          defaultAction.call();

          // 4. FIX FOR BLANK SCREEN: Ensure navigation state is valid post-pop
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final navContext =
                ZegoInitializationService.navigatorKey.currentContext;
            if (navContext != null) {
              final navState =
                  ZegoInitializationService.navigatorKey.currentState;
              if (navState != null && !navState.canPop()) {
                printLog(
                  "ZEGO_CALL_END_POST_POP: Navigator stack has no pop targets. Ensuring Home Dashboard is active.",
                );
                try {
                  GoRouter.of(navContext).go('/home');
                } catch (e) {
                  printLog("Error resetting route post-call: $e");
                }
              }
            }
          });
        },
      ),
      invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
        // Enable immersive full-screen the moment the call invitation screen
        // appears (hides status bar + navigation bar so video is edge-to-edge).
        onOutgoingCallSent: (callID, caller, callType, callees, customData) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        },
        onIncomingCallReceived:
            (callID, caller, callType, callees, customData) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            },
        // Restore system UI when the invitation is over (before call starts).
        onIncomingCallDeclineButtonPressed: () {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Declined");
        },
        onIncomingCallCanceled: (callID, caller, customData) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Cancelled");
        },
        onIncomingCallTimeout: (callID, caller) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Timeout");
        },
        onOutgoingCallDeclined: (callID, callee, customData) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Declined");
        },
        onOutgoingCallRejectedCauseBusy: (callID, callee, customData) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Busy");
        },
        onOutgoingCallTimeout: (callID, callees, isVideoCall) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Timeout");
        },
        onOutgoingCallCancelButtonPressed: () {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          _addCallHistory("Cancelled");
        },
      ),
    );

    // Enable system calling UI (CallKit / Android System calling UI) for offline & lock screen calls.
    // MUST be called AFTER ZegoUIKitPrebuiltCallInvitationService().init() per Zego documentation.
    await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
      ZegoUIKitSignalingPlugin(),
    ]);

    // Register ZPNs push config per-user (must happen after Zego SDK init)
    ZPNsConfig zpnsConfig = ZPNsConfig();
    zpnsConfig.appType = 1;
    zpnsConfig.enableFCMPush = true;
    ZPNs.setPushConfig(zpnsConfig);

    ZPNs.getInstance()
        .registerPush(
          iOSEnvironment: ZPNsIOSEnvironment.Automatic,
          iOSNotificationArrivedConfig: ZPNsIOSNotificationArrivedConfig()
            ..isPresentBadge = true
            ..isPresentSound = true
            ..isPresentAlert = true,
          enableIOSVoIP: true,
        )
        .catchError((onError) {
          if (onError is PlatformException) {
            printLog("APP CALL NOTIFICATION ERROR :  ${onError.message ?? ""}");
          }
        });

    _initializedAppId = currentAppId;
    _initializedAppSign = currentAppSign;

    return true;
  }

  void syncCallHistoryOnDisconnect() {
    _addCallHistory("LeaveRoom");
  }

  void _addCallHistory(String reason) {
    if (reason == "LeaveRoom" && _hasSyncedHistoryForCurrentCall) {
      printLog(
        "CALL_HISTORY_API: Already processed for current call, skipping duplicate.",
      );
      return;
    }

    // Only the Caller (Initiator) executes call-history/add-call-minutes to deduct plan minutes
    final bool isCaller = _isInitiator || ApplicationData.isCallInitiator;
    if (!isCaller) {
      printLog(
        "CALL_HISTORY_API: Current user is Receiver (Callee). API skipped on receiver side.",
      );
      return;
    }

    final currentUserId =
        AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? "";
    final rawTargetId =
        (ApplicationData.otherUserId.isNotEmpty &&
            ApplicationData.otherUserId != currentUserId)
        ? ApplicationData.otherUserId
        : (ApplicationData.otherMatriId.isNotEmpty
              ? ApplicationData.otherMatriId
              : _otherMatriId);

    // Extract numeric ID if rawTargetId contains prefix like PROMATRI114 -> 114
    final numericMatch = RegExp(r'\d+').stringMatch(rawTargetId);
    final String targetUserId =
        (numericMatch != null && numericMatch.isNotEmpty)
        ? numericMatch
        : rawTargetId;

    if (targetUserId.isNotEmpty) {
      if (reason == "LeaveRoom") {
        _hasSyncedHistoryForCurrentCall = true;
      }

      final String callTypeStr =
          ApplicationData.callType.toLowerCase().contains("video")
          ? "videoCall"
          : "voiceCall";

      int activeMinutes = 0;
      if (reason == "LeaveRoom") {
        activeMinutes = (_callDuration / 60).ceil();
        if (activeMinutes < 1) activeMinutes = 1;
      }

      final Map<String, String> params = {
        'receiver_member_id': targetUserId,
        'type': callTypeStr,
        'active_call_minute': activeMinutes.toString(),
        'end_reason': reason,
      };

      printLog(
        "CALL_HISTORY_API PARAMS: $params (duration: $_callDuration sec)",
      );

      // Execute updateCallHistory API asynchronously
      ref
          .read(homeRepositoryProvider)
          .updateCallHistory(params)
          .then((_) {
            printLog(
              "CALL_HISTORY_API: Updated successfully for member $targetUserId",
            );
            // Only refresh current plan if call minutes were actually consumed (> 0)
            // and defer Riverpod invalidation to post-frame to allow Zego Navigator routes to pop cleanly.
            if (activeMinutes > 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (ref.mounted) {
                  ref.invalidate(currentPlanProvider);
                }
              });
            }
          })
          .catchError((err) {
            printLog("CALL_HISTORY_API ERROR: $err");
          });

      _callDuration = 0;
    } else {
      printLog(
        "CALL_HISTORY_API: Skipped as targetUserId is empty (raw: '$rawTargetId')",
      );
    }
  }
}
