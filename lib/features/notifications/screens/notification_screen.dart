import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_notification_handler.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/glassmorphic_background.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../../home/providers/dashboard_notifier.dart';
import '../../search/providers/search_notifier.dart';
import '../data/models/notification_models.dart';
import '../providers/notification_notifier.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  final bool showAppBar;
  const NotificationScreen({super.key, this.showAppBar = true});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(notificationProvider.notifier)
          .fetchNotifications(isRefresh: true);
      ref.read(dashboardProvider.notifier).clearNotificationBadge();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref
            .read(notificationProvider.notifier)
            .fetchNotifications(isRefresh: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgApp,
      body: SafeArea(
        child: GlassmorphicBackground(
          child: Column(
            children: [
              _buildAppBar(context, isDark),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref
                      .read(notificationProvider.notifier)
                      .fetchNotifications(isRefresh: true),
                  color: AppColors.primary,
                  child: _buildScrollBody(state, isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return AppAppBar(
      title: 'notifications'.tr,
      isShowActions: false,
      actions: [
        GestureDetector(
          onTap: () => context.push('/push-notification-settings'),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.white.withValues(alpha: 0.05)
                  : AppColors.bgCard,
              borderRadius: AppRadius.mdRadius,
              boxShadow: AppShadows.card,
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFF1F3F9),
                width: 1.2,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.figmaSettings,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollBody(PagingState<NotificationItem> state, bool isDark) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: AppLoadingWidget());
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.items.isEmpty && !state.isLoading) ...[
            const Gap(60),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 48,
                    color: isDark ? Colors.white30 : AppColors.textMuted,
                  ),
                  const Gap(12),
                  Text(
                    'no_notifications_yet'.tr,
                    style: AppFont.font(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white70 : AppColors.textPrimary,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'no_notifications_desc'.tr,
                    style: AppFont.font(
                      fontSize: 12,
                      color: isDark ? Colors.white30 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (state.items.isNotEmpty) ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.items.length,
              separatorBuilder: (context, index) => const Gap(14),
              itemBuilder: (context, index) {
                final item = state.items[index];
                return _buildNotificationCard(item, isDark);
              },
            ),
            const Gap(24),
          ],

          if (state.isLoadingMore)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: AppLoadingWidget(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item, bool isDark) {
    final title = item.title?.toString() ?? 'notification'.tr;
    final message = item.message?.toString() ?? "";
    final isRead =
        item.isRead == 1 ||
        item.isRead == true ||
        item.isRead == "1" ||
        item.isRead?.toString().toLowerCase() == "true";
    final action = (item.action ?? "").toString().toLowerCase().trim();
    final act = action;

    final formattedDate = _getFormattedNotificationDate(
      item.createdAt?.toString(),
    );
    final relativeTime = _getRelativeTime(item.createdAt?.toString());

    final bool isProfileRelated =
        (act.contains('match') ||
            act.contains('view') ||
            act.contains('interest') ||
            act.contains('connection')) &&
        !act.contains('photo') &&
        !act.contains('proof') &&
        !act.contains('horoscope') &&
        !act.contains('plan') &&
        !act.contains('membership') &&
        !act.contains('approval') &&
        !act.contains('approved') &&
        !act.contains('featured');

    final String actionText = isProfileRelated
        ? 'view_profile'.tr
        : 'btn_view'.tr;
    final primaryColor = Theme.of(context).primaryColor;

    void onCardTap() {
      if (item.id != null) {
        ref.read(notificationProvider.notifier).markAsRead(item.id);
      }
      _handleRedirection(context, item);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: !isRead
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        primaryColor.withValues(alpha: 0.10),
                        const Color(0xFF191824),
                        const Color(0xFF161522),
                      ]
                    : [
                        primaryColor.withValues(alpha: 0.025),
                        Colors.white,
                      ],
              )
            : null,
        color: !isRead
            ? null
            : (isDark ? const Color(0xFF161522) : Colors.white),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: !isRead
              ? primaryColor.withValues(alpha: isDark ? 0.35 : 0.20)
              : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFF0F2F6)),
          width: !isRead ? 1.2 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: !isRead
                ? (isDark
                    ? primaryColor.withValues(alpha: 0.15)
                    : primaryColor.withValues(alpha: 0.05))
                : (isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.03)),
            blurRadius: !isRead ? 12 : 10,
            offset: Offset(0, !isRead ? 3 : 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Left vertical accent stripe for unread notifications
            if (!isRead)
              Positioned(
                left: 0,
                top: 14,
                bottom: 14,
                child: Container(
                  width: 4.5,
                  decoration: BoxDecoration(
                    gradient: FigmaColors.primaryGradient(context),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onCardTap,
                borderRadius: BorderRadius.circular(22),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Squircle Leading Icon / Avatar with unread indicator
                      _buildCardIconLeading(action, item, isDark, isRead: isRead),
                      const Gap(14),

                      // 2. Main Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row: Title + Relative Time
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFont.font(
                                      fontSize: 14.5,
                                      fontWeight: !isRead
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                      color: isDark
                                          ? Colors.white
                                          : (!isRead
                                                ? const Color(0xFF0F111E)
                                                : const Color(0xFF3F4254)),
                                    ),
                                  ),
                                ),
                                if (relativeTime.isNotEmpty) ...[
                                  const Gap(8),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1.5),
                                    child: Text(
                                      relativeTime,
                                      style: AppFont.font(
                                        fontSize: 11.5,
                                        fontWeight: !isRead
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: !isRead
                                            ? primaryColor
                                            : (isDark
                                                  ? Colors.white38
                                                  : const Color(0xFF8C8E9E)),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const Gap(6),

                            // Message Body
                            _buildHighlightedMessage(message, isDark, isRead: isRead),
                            const Gap(12),

                            // Bottom Row: Clock + Date and Action Pill Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Timestamp
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_filled,
                                      size: 13,
                                      color: !isRead
                                          ? primaryColor
                                          : (isDark ? Colors.white30 : const Color(0xFF9E9E9E)),
                                    ),
                                    const Gap(5),
                                    Text(
                                      formattedDate,
                                      style: AppFont.font(
                                        fontSize: 11.5,
                                        fontWeight: !isRead ? FontWeight.w600 : FontWeight.w500,
                                        color: isDark
                                            ? Colors.white38
                                            : const Color(0xFF6B6E82),
                                      ),
                                    ),
                                  ],
                                ),

                                // Pill Action Button
                                GestureDetector(
                                  onTap: onCardTap,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6.5,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: !isRead
                                          ? FigmaColors.primaryGradient(context)
                                          : null,
                                      color: !isRead
                                          ? null
                                          : (isDark
                                                ? Colors.white.withValues(
                                                    alpha: 0.08,
                                                  )
                                                : const Color(0xFFF1F3F7)),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: !isRead
                                          ? [
                                              BoxShadow(
                                                color: primaryColor.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      actionText,
                                      style: AppFont.font(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: !isRead
                                            ? Colors.white
                                            : (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF16182F)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardIconLeading(
    String action,
    NotificationItem item,
    bool isDark, {
    bool isRead = true,
  }) {
    final profileImageUrl = item.profileImage?.toString();
    final hasImage =
        profileImageUrl != null &&
        profileImageUrl.isNotEmpty &&
        profileImageUrl != "null";
    final act = action.toLowerCase();

    IconData iconData;
    Color iconColor;
    bool useGradient = false;

    if (act.contains('match') ||
        act.contains('interest') ||
        act.contains('accept_connection')) {
      iconData = Icons.favorite_rounded;
      iconColor = Theme.of(context).primaryColor;
      useGradient = true;
    } else if (act.contains('photo') ||
        act.contains('approve') ||
        act.contains('verify') ||
        act.contains('proof') ||
        act.contains('horoscope')) {
      iconData = Icons.shield_rounded;
      iconColor = const Color(0xFFE26176);
    } else if (act.contains('featured')) {
      iconData = Icons.star_rounded;
      iconColor = const Color(0xFFFFB300);
    } else if (act.contains('view') || act.contains('visit')) {
      iconData = Icons.visibility_rounded;
      iconColor = const Color(0xFF7A68EE);
    } else if (act.contains('chat') || act.contains('message')) {
      iconData = Icons.chat_bubble_rounded;
      iconColor = const Color(0xFF00B894);
    } else if (act.contains('plan') ||
        act.contains('payment') ||
        act.contains('subscribe') ||
        act.contains('membership')) {
      iconData = Icons.workspace_premium_rounded;
      iconColor = const Color(0xFFFF9800);
    } else {
      iconData = Icons.notifications_rounded;
      iconColor = Theme.of(context).primaryColor;
      useGradient = true;
    }

    final bool isSystemNotification =
        act.contains('photo') ||
        act.contains('approve') ||
        act.contains('verify') ||
        act.contains('proof') ||
        act.contains('horoscope') ||
        act.contains('featured') ||
        act.contains('plan') ||
        act.contains('payment') ||
        act.contains('subscribe') ||
        act.contains('membership');

    Widget baseWidget;

    // If an avatar image is available for user-to-user events (not system notifications)
    if (hasImage &&
        !isSystemNotification &&
        (act.contains('match') ||
            act.contains('view') ||
            act.contains('chat') ||
            act.contains('interest'))) {
      baseWidget = Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: getImageWidget(
                url: profileImageUrl,
                imageWidth: 50,
                imageHeight: 50,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                gradient: useGradient
                    ? FigmaColors.primaryGradient(context)
                    : null,
                color: useGradient ? null : iconColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? const Color(0xFF1E1C2B) : Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(iconData, color: Colors.white, size: 10),
              ),
            ),
          ),
        ],
      );
    } else {
      // Squircle Icon matching reference design
      baseWidget = Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: useGradient ? FigmaColors.primaryGradient(context) : null,
          color: useGradient ? null : iconColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: iconColor.withValues(alpha: !isRead ? 0.45 : 0.30),
              blurRadius: !isRead ? 12 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: Icon(iconData, color: Colors.white, size: 24)),
      );
    }

    if (isRead) {
      return baseWidget;
    }

    // Indicator badge dot for unread status
    return Stack(
      clipBehavior: Clip.none,
      children: [
        baseWidget,
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? const Color(0xFF161522) : Colors.white,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightedMessage(
    String message,
    bool isDark, {
    bool isRead = true,
  }) {
    if (message.isEmpty) return const SizedBox.shrink();

    final primaryColor = Theme.of(context).primaryColor;
    final defaultTextColor = isDark
        ? (!isRead ? Colors.white : Colors.white60)
        : (!isRead ? const Color(0xFF1E202B) : const Color(0xFF5A5E73));
    final defaultFontWeight = !isRead ? FontWeight.w500 : FontWeight.w400;

    final pattern = RegExp(
      r'(\b[A-Z]{1,5}\d{2,10}:?|\b\d+%\s*(?:compatibility(?:\s*match)?)?)',
      caseSensitive: false,
    );

    final matches = pattern.allMatches(message).toList();
    if (matches.isEmpty) {
      return Text(
        message,
        style: AppFont.font(
          fontSize: 12.5,
          height: 1.38,
          fontWeight: defaultFontWeight,
          color: defaultTextColor,
        ),
      );
    }

    final spans = <InlineSpan>[];
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: message.substring(currentIndex, match.start),
            style: AppFont.font(
              fontSize: 12.5,
              height: 1.38,
              fontWeight: defaultFontWeight,
              color: defaultTextColor,
            ),
          ),
        );
      }

      final matchedText = message.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: matchedText,
          style: AppFont.font(
            fontSize: 13,
            height: 1.38,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: primaryColor,
          ),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < message.length) {
      spans.add(
        TextSpan(
          text: message.substring(currentIndex),
          style: AppFont.font(
            fontSize: 12.5,
            height: 1.38,
            fontWeight: defaultFontWeight,
            color: defaultTextColor,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }

  String _getFormattedNotificationDate(String? serverDate) {
    if (serverDate == null ||
        serverDate.isEmpty ||
        serverDate == "0000-00-00 00:00:00") {
      return "";
    }
    try {
      final parsed =
          DateTime.tryParse(serverDate) ??
          DateFormat("yyyy-MM-dd HH:mm:ss").parse(serverDate);
      final dateStr = DateFormat('dd MMM').format(parsed);
      final timeStr = DateFormat('hh:mm a').format(parsed);
      return '$dateStr · $timeStr';
    } catch (_) {
      return serverDate;
    }
  }

  String _getRelativeTime(String? serverDate) {
    if (serverDate == null ||
        serverDate.isEmpty ||
        serverDate == "0000-00-00 00:00:00") {
      return "";
    }
    try {
      final parsed =
          DateTime.tryParse(serverDate) ??
          DateFormat("yyyy-MM-dd HH:mm:ss").parse(serverDate);
      final diff = DateTime.now().difference(parsed);
      if (diff.isNegative || diff.inSeconds < 60) {
        return 'just_now'.tr;
      } else if (diff.inMinutes < 60) {
        return "${diff.inMinutes}m ago";
      } else if (diff.inHours < 24) {
        return "${diff.inHours}h ago";
      } else if (diff.inDays < 7) {
        return "${diff.inDays}d ago";
      } else if (diff.inDays < 30) {
        return "${(diff.inDays / 7).floor()}w ago";
      } else if (diff.inDays < 365) {
        return "${(diff.inDays / 30).floor()}mo ago";
      } else {
        return "${(diff.inDays / 365).floor()}y ago";
      }
    } catch (_) {
      return "";
    }
  }

  void _handleRedirection(BuildContext context, NotificationItem item) async {
    final action = (item.action ?? '').toString().toLowerCase().trim();
    final String senderId =
        (item.senderMemberId != null &&
            item.senderMemberId.toString().isNotEmpty)
        ? item.senderMemberId.toString()
        : (item.senderMatriId != null &&
              item.senderMatriId.toString().isNotEmpty)
        ? item.senderMatriId.toString()
        : (item.notificationBy != null ? item.notificationBy.toString() : '');
    final title =
        item.profileTitle?.toString() ?? item.title?.toString() ?? 'user'.tr;

    final myUserId =
        AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? '';
    final myMatriId =
        AppSessionService.getValue(SessionDetail.kMatriId)?.toString() ?? '';
    final bool isSelfOrSystem =
        senderId.isEmpty || senderId == myUserId || senderId == myMatriId;

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
        context.push('/current-plan');
        break;

      case 'plan_expired':
        context.push('/plans');
        break;

      // 2. ID Proof verification (Manage Photos - Second Tab)
      case 'id_proof_approval':
      case 'id_proof_photo_approval':
        context.push('/manage-photos?index=1');
        break;

      // 3. Photo Approvals (Manage Photos - First Tab)
      case 'photos_approval':
      case 'profile_photo_approval':
        context.push('/manage-photos?index=0');
        break;

      // 4. Horoscope Approval (Manage Photos - Third Tab)
      case 'horoscope_approval':
      case 'horoscope_photo_approval':
        context.push('/manage-photos?index=2');
        break;

      // 5. Featured Profile
      case 'featured_profile':
      case 'featured':
      case 'featured_member':
      case 'featured_members':
        context.push('/my-profile');
        break;

      // 6. Profile Approved
      case 'profile_approved':
        context.push('/profile-view-my');
        break;

      // 7. Match From Admin
      case 'match_from_admin':
        AppNotificationHandler.handleMatchFromAdminRedirection(
          context: context,
          ref: ref,
        );
        break;

      // 8. Views
      case 'viewed_profile':
      case 'viewed_contact_details':
      case 'profile_view':
      case 'profile_viewed':
        if (!isSelfOrSystem && senderId.isNotEmpty) {
          context.push('/profile-other/$senderId');
        } else {
          context.push('/viewed-profiles');
        }
        break;

      // 9. Interest & Connections
      case 'interest_received':
        context.push('/connections', extra: 'received');
        break;
      case 'accept_connection':
      case 'reject_connection':
      case 'interest_reject':
      case 'interest_accept':
      case 'interest_reminder':
      case 'accept_interest':
      case 'accept_interest_received':
        context.push('/connections');
        break;

      // 10. Photo Requests
      case 'photo_request_received':
        context.push('/photo-requests', extra: 'received');
        break;
      case 'photo_request_accept':
      case 'photo_request_reject':
      case 'photo_request_rejected':
        ApplicationData.isToOpenPhotoRequestSentScreen = true;
        context.push('/photo-requests');
        break;

      // 11. Chat
      case 'new_chat_request':
      case 'chat_message_received':
      case 'chat_request_accepted':
        if (!isSelfOrSystem && senderId.isNotEmpty) {
          final hasAccess = await checkChatPermission(context, ref);
          if (!hasAccess || !context.mounted) break;
          context.push(
            '/chat-conversation/$senderId',
            extra: {'receiverName': title},
          );
        } else {
          context.push('/dashboard');
        }
        break;

      // 12. Personalized Chat From Admin
      case 'personalize_chat_from_admin':
      case 'personalized_chat_from_admin':
        context.push('/chat-with-admin');
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
        if (!isSelfOrSystem && senderId.isNotEmpty) {
          context.push('/profile-other/$senderId');
        } else {
          context.push('/dashboard');
        }
        break;
    }
  }
}