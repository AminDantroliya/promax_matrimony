import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../features/notifications/providers/notification_notifier.dart';
import '../features/home/providers/dashboard_notifier.dart';
import '../preference/session_keys.dart';
import '../services/app_session_service.dart';
import '../utils/utils.dart';

class AppAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isShowActions;
  final List<Widget>? actions;

  const AppAppBar({
    super.key,
    required this.title,
    required this.isShowActions,
    this.actions,
  });

  @override
  Size get preferredSize {
    try {
      final double statusBarHeight =
          WidgetsBinding.instance.platformDispatcher.views.isEmpty
          ? 24.0
          : WidgetsBinding.instance.platformDispatcher.views.first.padding.top /
                WidgetsBinding
                    .instance
                    .platformDispatcher
                    .views
                    .first
                    .devicePixelRatio;
      return Size.fromHeight(kToolbarHeight + statusBarHeight);
    } catch (_) {
      return const Size.fromHeight(kToolbarHeight + 24.0);
    }
  }

  Widget _buildSplitTitle(BuildContext context, String rawTitle, bool isDark) {
    return buildAppTitleWidget(context, rawTitle.tr);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showActions = isShowActions ?? false;
    final isLoggedIn =
        AppSessionService.getValue(SessionDetail.kIsLoggedIn) == true;

    final dashboardUnread = (showActions && isLoggedIn)
        ? (ref.watch(dashboardProvider).value?.unreadNotificationCount ?? 0)
        : 0;
    final notificationUnread = (showActions && isLoggedIn)
        ? ref.watch(unreadNotificationCountProvider)
        : 0;
    final unreadCount = dashboardUnread > 0
        ? dashboardUnread
        : notificationUnread;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left back arrow squircle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFF1F3F9),
                width: 1.2,
              ),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: accentColor, size: 22),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Left aligned split title
          const Gap(14),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildSplitTitle(context, title ?? "", isDark),
            ),
          ),
          if (actions != null || isShowActions == true) const Gap(10),

          // Right balancing container or actions
          if (actions != null)
            IconTheme(
              data: IconThemeData(color: accentColor),
              child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
            )
          else if (isShowActions == true)
            GestureDetector(
              onTap: () => context.push('/notifications'),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : const Color(0xFFF1F3F9),
                    width: 1.2,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.icAppbarNotifications,
                      colorFilter: ColorFilter.mode(
                        accentColor,
                        BlendMode.srcIn,
                      ),
                      width: 22,
                      height: 22,
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Color(
                              0xFFFF2D55,
                            ), // Badge dot / count background
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: Center(
                            child: Text(
                              unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildAppTitleWidget(
  BuildContext context,
  String rawTitle, {
  double fontSize = 20,
  TextAlign textAlign = TextAlign.start,
  Color? primaryColor,
  Color? secondaryColor,
}) {
  if (rawTitle.trim().isEmpty) return const SizedBox.shrink();

  final isDark = Theme.of(context).brightness == Brightness.dark;
  final defaultPrimaryColor =
      primaryColor ??
      (isDark ? Colors.white : Theme.of(context).colorScheme.onSurface);
  final defaultSecondaryColor =
      secondaryColor ?? Theme.of(context).primaryColor;

  // Capitalize first character of every word
  final formattedTitle = rawTitle
      .trim()
      .split(RegExp(r'\s+'))
      .map((word) {
        if (word.isEmpty) return word;
        return word[0].toUpperCase() + word.substring(1);
      })
      .join(' ');

  final words = formattedTitle.split(RegExp(r'\s+'));

  if (words.length == 1) {
    return Text(
      words.first,
      textAlign: textAlign,
      style: AppFont.font(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: defaultSecondaryColor,
      ),
    );
  }

  final firstPart = "${words.sublist(0, words.length - 1).join(' ')} ";
  final lastWord = words.last;

  return RichText(
    textAlign: textAlign,
    text: TextSpan(
      children: [
        TextSpan(
          text: firstPart,
          style: AppFont.font(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: defaultPrimaryColor,
          ),
        ),
        TextSpan(
          text: lastWord,
          style: AppFont.font(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: defaultSecondaryColor,
          ),
        ),
      ],
    ),
  );
}
