import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/services/zego_initialization_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/application_data.dart';

/// Centralized helper for managing and executing push notification tap/click
/// routing actions. Separates navigation rules from main entry points.
class AppNotificationHandler {
  static String? _lastHandledPayload;
  static DateTime? _lastHandledTime;

  /// Entry point called by widgets/Stateful classes when a notification tap is detected.
  static void handleNotificationClick(
    GoRouter router,
    String? payloadStr, {
    WidgetRef? ref,
  }) {
    printLog('AppNotificationHandler.handleNotificationClick: $payloadStr');
    if (payloadStr == null || payloadStr.isEmpty) return;

    final now = DateTime.now();
    if (_lastHandledPayload == payloadStr &&
        _lastHandledTime != null &&
        now.difference(_lastHandledTime!) < const Duration(seconds: 2)) {
      printLog('AppNotificationHandler: Ignoring duplicate notification click within 2s.');
      return;
    }
    _lastHandledPayload = payloadStr;
    _lastHandledTime = now;

    try {
      final payload = jsonDecode(payloadStr) as Map<String, dynamic>;
      if (ApplicationData().getIsFromBackgroundNotification) {
        _onBackgroundNotification(router, payload);
      } else {
        _onForegroundNotification(router, payload, ref: ref);
      }
    } catch (e) {
      printLog('Failed to parse notification payload: $e');
    }
  }

  static void _onBackgroundNotification(
    GoRouter router,
    Map<String, dynamic> payload,
  ) {
    router.go(
      '/splash',
      extra: {'is_from_notification': true, 'message_payload': payload},
    );
  }

  static void _onForegroundNotification(
    GoRouter router,
    Map<String, dynamic> payload, {
    WidgetRef? ref,
  }) {
    final String action = (payload['type']?.toString() ??
        payload['noti_type']?.toString() ??
        payload['notification_type']?.toString() ??
        payload['action']?.toString() ??
        '').toLowerCase().trim();

    final String otherId = payload['viewer_id']?.toString() ??
        payload['sender_id']?.toString() ??
        payload['member_id']?.toString() ??
        payload['matri_id']?.toString() ??
        payload['user_id']?.toString() ??
        payload['sender_member_id']?.toString() ??
        '';

    final bool isCallPayload = payload.containsKey('call_id') ||
        payload.containsKey('zego') ||
        payload.containsKey('call_type') ||
        action.toLowerCase().contains('call');

    printLog('****ACTION**** $action | OTHER_ID: $otherId | IS_CALL: $isCallPayload');

    if (isCallPayload) {
      printLog('AppNotificationHandler: Call payload detected. Skipping page routing to preserve active call screen.');
      return;
    }

    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? '';
    final myMatriId = AppSessionService.getValue(SessionDetail.kMatriId)?.toString() ?? '';
    final bool isSelfOrSystem = otherId.isEmpty || otherId == myUserId || otherId == myMatriId;

    switch (action) {
      // 1. Membership & Payment
      case 'membership_purchase_success':
      case 'membership_purchase':
      case 'payment_received':
      case 'plan_subscribed':
      case 'plan_subscription':
      case 'admin_plan_assign':
      case 'admin_plan_assigned':
      case 'admin_assign_plan':
      case 'admin_plan':
      case 'plan_assigned':
      case 'plan_assign':
      case 'membership_plan_assigned':
      case 'membership_plan_assign':
      case 'membership_assigned':
      case 'membership_assign':
      case 'assign_plan':
      case 'assign_membership_plan':
      case 'membership_plan':
      case 'current_plan':
        router.push('/current-plan');
        break;

      case 'plan_expired':
        router.push('/plans');
        break;

      // 2. ID Proof verification (Manage Photos - Second Tab)
      case 'id_proof_approval':
      case 'id_proof_photo_approval':
        router.push('/manage-photos?index=1');
        break;

      // 3. Photo Approvals (Manage Photos - First Tab)
      case 'photos_approval':
      case 'profile_photo_approval':
        router.push('/manage-photos?index=0');
        break;

      // 4. Horoscope Approval (Manage Photos - Third Tab)
      case 'horoscope_approval':
      case 'horoscope_photo_approval':
        router.push('/manage-photos?index=2');
        break;

      // 5. Featured Profile
      case 'featured_profile':
      case 'featured':
      case 'featured_member':
      case 'featured_members':
        router.go('/home');
        break;

      // 6. Profile Approved
      case 'profile_approved':
        router.push('/profile-view-my');
        break;

      // 7. Match From Admin
      case 'match_from_admin':
        handleMatchFromAdminRedirection(router: router, ref: ref);
        break;

      // 8. Views
      case 'viewed_profile':
      case 'viewed_contact_details':
      case 'profile_view':
      case 'profile_viewed':
        if (!isSelfOrSystem && otherId.isNotEmpty) {
          router.push('/profile-other/$otherId');
        } else {
          router.push('/viewed-profiles');
        }
        break;

      // 9. Interest & Connections
      case 'interest_received':
        router.push('/connections', extra: 'received');
        break;
      case 'accept_connection':
      case 'reject_connection':
      case 'interest_reject':
      case 'interest_accept':
      case 'interest_reminder':
      case 'accept_interest':
      case 'accept_interest_received':
        router.push('/connections');
        break;

      // 10. Photo Requests
      case 'photo_request_received':
        router.push('/photo-requests', extra: 'received');
        break;
      case 'photo_request_accept':
      case 'photo_request_reject':
      case 'photo_request_rejected':
        ApplicationData.isToOpenPhotoRequestSentScreen = true;
        router.push('/photo-requests');
        break;

      // 11. Chat
      case 'new_chat_request':
      case 'chat_message_received':
      case 'chat_request_accepted':
        final titleVal = payload['title']?.toString() ?? '';
        final senderName = titleVal.contains('from ')
            ? titleVal.split('from ').last
            : (titleVal.isNotEmpty ? titleVal : 'User');
        if (!isSelfOrSystem && otherId.isNotEmpty) {
          router.push(
            '/chat-conversation/$otherId',
            extra: {'receiverName': senderName},
          );
        } else {
          router.push('/dashboard');
        }
        break;

      // 12. Personalized Chat From Admin
      case 'personalize_chat_from_admin':
      case 'personalized_chat_from_admin':
        router.push('/chat-with-admin');
        break;

      default:
        printLog('Unhandled notification action: $action');
        if (isCallPayload) {
          printLog('Call payload in default handler — skipping profile redirection.');
          break;
        }
        if (action.contains('plan') || action.contains('membership')) {
          if (action.contains('expire')) {
            router.push('/plans');
          } else {
            router.push('/current-plan');
          }
          break;
        }
        if (!isSelfOrSystem && otherId.isNotEmpty) {
          router.push('/profile-other/$otherId');
        } else {
          router.push('/notifications');
        }
        break;
    }
  }

  /// Handles redirection for 'match_from_admin'.
  /// Checks if user is personalized (userType == "1"):
  /// - If personalized: redirection is router.push('/admin-matches')
  /// - If not personalized: redirects to the Suggested Matches tab under the bottom menu Matches tab (index 3).
  static void handleMatchFromAdminRedirection({
    BuildContext? context,
    GoRouter? router,
    WidgetRef? ref,
  }) {
    final effectiveRouter =
        router ?? (context != null ? GoRouter.of(context) : null);

    bool isPersonalized =
        AppSessionService.getValue(SessionDetail.kUserType)?.toString() == "1";

    if (!isPersonalized && ref != null) {
      try {
        isPersonalized =
            (ref.read(myProfileProvider).value?.userType?.toString() == "1") ||
            (ref.read(dashboardProvider).value?.userType?.toString() == "1");
      } catch (_) {}
    }

    if (isPersonalized) {
      if (effectiveRouter != null) {
        effectiveRouter.push('/admin-matches');
      } else if (context != null) {
        context.push('/admin-matches');
      }
    } else {
      if (ref != null) {
        ref.read(homePageIndexProvider.notifier).setIndex(3);
        ref.read(matchesSelectedTabProvider.notifier).setTab(3);
      } else {
        final navCtx =
            context ?? ZegoInitializationService.navigatorKey.currentContext;
        if (navCtx != null) {
          try {
            final container = ProviderScope.containerOf(navCtx, listen: false);
            container.read(homePageIndexProvider.notifier).setIndex(3);
            container.read(matchesSelectedTabProvider.notifier).setTab(3);
          } catch (_) {}
        }
      }

      if (effectiveRouter != null) {
        effectiveRouter.go('/home');
      } else if (context != null) {
        context.go('/home');
      }
    }
  }
}
