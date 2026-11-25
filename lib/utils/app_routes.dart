import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralised navigation helpers — one place to change route paths.
///
/// Usage:
///   AppRoutes.openProfile(context, member.memberId.toString());
///   AppRoutes.openChat(context, memberId: member.memberId.toString(), receiverName: member.profileTitle ?? 'User');
///   AppRoutes.openReport(context, member.memberId.toString());
class AppRoutes {
  AppRoutes._();

  // ─── Route Path Constants ───────────────────────────────────────────────────

  static const String profile = '/profile-other';
  static const String chat = '/chat-conversation';
  static const String report = '/report-admin';
  static const String plans = '/plans';
  static const String notifications = '/notifications';

  // ─── Navigation Helpers ─────────────────────────────────────────────────────

  /// Navigate to the notifications screen.
  static void openNotifications(BuildContext context) =>
      context.push(notifications);

  /// Navigate to the other member's profile screen.
  static Future<dynamic> openProfile(BuildContext context, String memberId) =>
      context.push('$profile/$memberId');

  /// Navigate to the chat conversation screen.
  static void openChat(
    BuildContext context, {
    required String memberId,
    required String receiverName,
    String? receiverPhoto,
  }) => context.push(
    '$chat/$memberId',
    extra: {'receiverName': receiverName, 'receiverPhoto': receiverPhoto},
  );

  /// Navigate to the report-to-admin screen.
  static void openReport(BuildContext context, String memberId) =>
      context.push(report, extra: {'memberId': memberId});

  /// Navigate to the membership plans screen.
  static void openPlans(BuildContext context) => context.push(plans);
}
