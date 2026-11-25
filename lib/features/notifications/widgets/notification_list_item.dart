import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/services/app_notification_handler.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';

import '../data/models/notification_models.dart';

class NotificationListItem extends ConsumerWidget {
  final NotificationItem notification;
  const NotificationListItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(1, 2),
            ),
        ],
      ),
      child: InkWell(
        onTap: () => _handleNavigation(context, ref),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextSemiBoldStyle(
                notification.title?.toString() ?? "notification".tr,
                getProportionateScreenWidth(14),
                TextAlign.start,
                Theme.of(context).colorScheme.onSurface,
              ),
              const Gap(5),
              customTextNormalStyle(
                notification.message?.toString() ?? "",
                getProportionateScreenWidth(13),
                TextAlign.start,
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const Gap(8),
              customTextSingleLineNormalStyle(
                getFormattedDate(notification.createdAt?.toString() ?? ""),
                getProportionateScreenWidth(11),
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7).withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, WidgetRef ref) async {
    final action = (notification.action ?? '').toString().toLowerCase().trim();
    final senderId = notification.senderMemberId?.toString() ?? '';

    switch (action) {
      case "featured_profile":
      case "featured":
      case "featured_member":
      case "featured_members":
        context.push('/my-profile');
        break;
      case "viewed_profile":
      case "viewed_contact_details":
        if (senderId.isNotEmpty) {
          context.push('/profile-other/$senderId');
        }
        break;
      case "interest_received":
        context.push('/connections', extra: 'received');
        break;
      case "membership_purchase_success":
      case "membership_purchase":
      case "payment_received":
      case "plan_subscribed":
      case "plan_subscription":
      case "admin_plan_assign":
      case "admin_plan_assigned":
      case "admin_assign_plan":
      case "admin_plan":
      case "plan_assigned":
      case "plan_assign":
      case "membership_plan_assigned":
      case "membership_plan_assign":
      case "membership_assigned":
      case "membership_assign":
      case "assign_plan":
      case "assign_membership_plan":
      case "membership_plan":
      case "current_plan":
        context.push('/current-plan');
        break;
      case "plan_expired":
        context.push('/plans');
        break;
      case "accept_connection":
      case "reject_connection":
      case "accept_interest":
      case "accept_interest_received":
        context.push('/connections');
        break;
      case "photo_request_received":
        context.push('/photo-requests', extra: 'received');
        break;
      case "photo_request_accept":
      case "photo_request_reject":
        context.push('/photo-requests');
        break;
      case "new_chat_request":
      case "chat_message_received":
      case "chat_request_accepted":
        if (senderId.isNotEmpty) {
          final hasAccess = await checkChatPermission(context, ref);
          if (!hasAccess || !context.mounted) return;
          context.push(
            '/chat-conversation/$senderId',
            extra: {'receiverName': notification.profileTitle?.toString() ?? 'user'.tr},
          );
        } else {
          context.push('/dashboard');
        }
        break;
      case "personalize_chat_from_admin":
      case "personalized_chat_from_admin":
        context.push('/chat-with-admin');
        break;
      case "match_from_admin":
        AppNotificationHandler.handleMatchFromAdminRedirection(
          context: context,
          ref: ref,
        );
        break;
      default:
        if (action.contains('plan') || action.contains('membership')) {
          if (action.contains('expire')) {
            context.push('/plans');
          } else {
            context.push('/current-plan');
          }
          break;
        }
        if (senderId.isNotEmpty) {
          context.push('/profile-other/$senderId');
        } else {
          context.push('/connections');
        }
        break;
    }
  }
}
