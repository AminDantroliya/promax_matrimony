import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'more_menu_config.dart';
import '../../profile/providers/profile_notifier.dart';

import '../../chat/screens/chat_tab_screen.dart';
import '../../home/providers/home_notifier.dart';
import 'package:zego_uikit/zego_uikit.dart';
import '../../home/providers/zego_notifier.dart';
import '../../home/providers/dashboard_notifier.dart';
import '../../home/screens/home_screen.dart';
import '../../matches/screens/matches_tab_screen.dart';

import '../../profile/screens/view_my_profile_screen.dart';
import '../../search/screens/search_tab_screen.dart';
import '../../../widgets/bottom_nav/bottom_nav_bar_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final Set<int> _loadedPages = {0}; // Track which pages have been loaded
  bool _latLongUpdateTriggered =
      false; // Ensure we only trigger once per lifecycle

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool enableVideoCall = ref.read(featureProvider('enableVideoCall'));
      final bool enableVoiceCall = ref.read(featureProvider('enableVoiceCall'));
      final bool isCallingEnabled = enableVideoCall || enableVoiceCall;

      if (isCallingEnabled) {
        await ref.read(zegoProvider.notifier).initZegoCloud();
        if (mounted) {
          bool isCallActive = false;
          try {
            final roomId = ZegoUIKit().getRoom().id;
            final roomState = ZegoUIKit().getRoomStateStream().value;
            isCallActive =
                roomId.isNotEmpty ||
                roomState.reason == ZegoRoomStateChangedReason.Logined;
          } catch (_) {}
          if (!isCallActive) {
            // If systemAlertWindow was just granted, force-reinit Zego so its
            // Notification Manager properly initializes with the new permission.
            final bool systemAlertJustGranted =
                await requestLockScreenCallPermissions(context, ref: ref);
            if (systemAlertJustGranted && mounted) {
              printLog(
                "DASHBOARD: systemAlertWindow just granted — forcing Zego re-init",
              );
              await ref
                  .read(zegoProvider.notifier)
                  .initZegoCloud(forceReinit: true);
            }
          }
        }
      }
      // Schedule a deferred check: wait for dashboard data then update lat/long.
      _scheduleLatLongUpdate();
    });
  }

  /// Waits for dashboard data (up to a few seconds) then triggers the
  /// one-time background lat/long + device_id update.
  void _scheduleLatLongUpdate() {
    if (_latLongUpdateTriggered) return;
    // Listen once; as soon as data is available trigger the update.
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted || _latLongUpdateTriggered) return;
      _latLongUpdateTriggered = true;
      ref.read(dashboardProvider.notifier).triggerLatLongUpdate();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    final currentIndex = ref.read(homePageIndexProvider);
    if (currentIndex != 0) {
      ref.read(homePageIndexProvider.notifier).setIndex(0);
      return false;
    }

    return await _showExitPopup();
  }

  Future<bool> _showExitPopup() async {
    final confirm = await AppDialogs.confirm(
      context,
      title: "exit_text".tr,
      message: "do_you_want_to_exit".tr,
      confirmLabel: "exit_text".tr,
    );
    if (confirm) {
      exit(0);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final currentIndex = ref.watch(homePageIndexProvider);
    final enableChat = ref.watch(featureProvider('enableChat'));
    if (!enableChat && currentIndex == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(homePageIndexProvider.notifier).setIndex(0);
        }
      });
    }
    _loadedPages.add(currentIndex); // Mark current page as loaded

    final List<Widget> pages = [
      const HomeScreen(),
      _loadedPages.contains(1)
          ? const SearchTabScreen()
          : const SizedBox.shrink(),
      _loadedPages.contains(2)
          ? const ChatTabScreen()
          : const SizedBox.shrink(),
      _loadedPages.contains(3)
          ? const MatchesTabScreen()
          : const SizedBox.shrink(),
      _loadedPages.contains(4)
          ? const ViewMyProfileScreen(showAppBar: false)
          : const SizedBox.shrink(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _onWillPop();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.scaffoldBackgroundColor,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              if (currentIndex < 4) ...[
                _buildSharedFigmaHeader(context, isDarkMode),
              ],
              Expanded(
                child: IndexedStack(index: currentIndex, children: pages),
              ),
            ],
          ),
        ),
        // Dynamic bottom navigation bar (Admin switchable designs)
        bottomNavigationBar: BottomNavBarWidget(
          currentIndex: currentIndex,
          onTabSelected: (index) {
            if (index == 4) {
              _showMoreBottomSheet(context, isDarkMode);
            } else {
              ref.read(homePageIndexProvider.notifier).setIndex(index);
            }
          },
        ),
      ),
    );
  }

  void _showMoreBottomSheet(BuildContext context, bool isDarkMode) {
    final dashboardData = ref.watch(dashboardProvider).value;
    final myProfile = ref.read(myProfileProvider).value;
    final userType = dashboardData?.userType ?? myProfile?.userType;
    final isPersonalized = userType?.toString() == "1";
    final appConfig = ref.read(appConfigProvider);
    final theme = Theme.of(context);
    final sections = getMoreMenuSections(
      dashboardData: dashboardData,
      isPersonalized: isPersonalized,
      features: appConfig.features,
      primaryColor: theme.primaryColor,
      accentColor: theme.colorScheme.secondary,
    );

    final dynamicSheetBg = isDarkMode
        ? const Color(0xFF161722)
        : (appConfig.moreMenuBgColor ?? appConfig.scaffoldBgColor);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: dynamicSheetBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final sheetBg = isDark
            ? const Color(0xFF161722)
            : (appConfig.moreMenuBgColor ?? appConfig.scaffoldBgColor);
        final cardBg = isDark
            ? const Color(0xFF1C1D2D)
            : (appConfig.moreOptionCardBgColor ?? Colors.white);

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle at top
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white24
                      : theme.dividerColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Scrollable menu list section wise
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...sections.map(
                        (section) => _buildSection(
                          context,
                          section,
                          isDark,
                          cardBg,
                        ),
                      ),
                      if (isPersonalized) ...[
                        const Gap(4),
                        _buildChatWithAdminBanner(context, isDark),
                      ],
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context,
    MoreMenuSection section,
    bool isDarkMode,
    Color cardBg,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 3.5,
              height: 14,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(8),
            Text(
              section.titleKey.tr.toUpperCase(),
              style: AppFont.font(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: isDarkMode
                    ? const Color(0xFFF1EDF5)
                    : (theme.textTheme.titleMedium?.color ??
                        const Color(0xFF1E202C)),
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const Gap(12),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: section.items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.88,
          ),
          itemBuilder: (context, index) {
            final item = section.items[index];
            return _buildMenuItemCard(context, item, isDarkMode, cardBg);
          },
        ),
        const Gap(20),
      ],
    );
  }

  Widget _buildMenuItemCard(
    BuildContext context,
    MoreMenuItem item,
    bool isDarkMode,
    Color cardBg,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (item.customTap != null) {
          item.customTap!();
        } else if (item.labelKey == 'matches' || item.labelKey == 'new_matches') {
          ref.read(matchesSelectedTabProvider.notifier).setTab(0);
          ref.read(homePageIndexProvider.notifier).setIndex(3);
        } else if (item.labelKey == 'suggested_matches') {
          ref.read(matchesSelectedTabProvider.notifier).setTab(3);
          ref.read(homePageIndexProvider.notifier).setIndex(3);
        } else {
          context.push(item.routePath);
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 12, 6, 10),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withValues(alpha: 0.06)
                : theme.dividerColor.withValues(alpha: 0.08),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: isDarkMode ? 0.25 : 0.035,
              ),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Squircle Icon Container
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? item.baseColor.withValues(alpha: 0.16)
                        : item.pastelBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      item.svgIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                if (item.badgeCount > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: cardBg,
                          width: 1.5,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Center(
                        child: Text(
                          item.badgeCount > 99
                              ? '99+'
                              : item.badgeCount.toString(),
                          style: AppFont.font(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            height: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                if (item.hasNewBadge)
                  Positioned(
                    top: -5,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A854),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: cardBg,
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        '• NEW',
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 7.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const Gap(8),
            Text(
              item.labelKey.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFont.font(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: isDarkMode
                    ? const Color(0xFFF1EDF5)
                    : (theme.textTheme.bodyMedium?.color ??
                        const Color(0xFF1E202C)),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatWithAdminBanner(BuildContext context, bool isDarkMode) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        context.push('/help-support');
      },
      child: Container(
        margin: const EdgeInsets.only(top: 6, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primaryColor,
              theme.colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Icon with Online Dot
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icMenuChatWithAdmin,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  right: -1,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D26A),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.primaryColor,
                        width: 2.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(14),
            // Middle Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Chat with ',
                          style: AppFont.font(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        TextSpan(
                          text: 'Admin',
                          style: AppFont.font(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(3),
                  Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00D26A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(5),
                      Flexible(
                        child: Text(
                          'Get instant support · Online now',
                          style: AppFont.font(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(10),
            // Right Arrow Button
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderNameWidget(
    BuildContext context,
    String fullname,
    bool isDark,
  ) {
    if (fullname.trim().isEmpty) return const SizedBox.shrink();

    final words = fullname.trim().split(RegExp(r'\s+'));
    final primaryColor = Theme.of(context).primaryColor;
    final defaultTextColor = isDark ? Colors.white : const Color(0xFF16182F);

    if (words.length == 1) {
      return Text(
        words.first,
        style: AppFont.font(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.0,
          letterSpacing: -0.3,
          color: defaultTextColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final firstPart = "${words.sublist(0, words.length - 1).join(' ')} ";
    final lastWord = words.last;

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstPart,
            style: AppFont.font(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.0,
              letterSpacing: -0.3,
              color: defaultTextColor,
            ),
          ),
          TextSpan(
            text: lastWord,
            style: AppFont.font(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              height: 1.0,
              letterSpacing: -0.3,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedFigmaHeader(BuildContext context, bool isDark) {
    final myProfile = ref.watch(myProfileProvider).value;
    final fullname = myProfile?.fullname ?? "user".tr;
    final dashboardData = ref.watch(dashboardProvider).value;
    final unreadNotificationCount = dashboardData?.unreadNotificationCount ?? 0;

    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = "good_morning".tr;
    } else if (hour < 17) {
      greeting = "good_afternoon".tr;
    } else {
      greeting = "good_evening".tr;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          // Circle profile photo (52x52)
          GestureDetector(
            onTap: () => context.push('/my-profile'),
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: getImageWidget(
                  url:
                      (dashboardData?.profileImage
                              ?.toString()
                              .trim()
                              .isNotEmpty ==
                          true)
                      ? dashboardData!.profileImage.toString()
                      : (myProfile?.profileImage
                                ?.toString()
                                .trim()
                                .isNotEmpty ==
                            true)
                      ? myProfile!.profileImage.toString()
                      : (myProfile?.photo1?.toString().trim().isNotEmpty ==
                            true)
                      ? myProfile!.photo1.toString()
                      : "",
                  boxFit: BoxFit.cover,
                  isMyPhoto: true,
                  imageWidth: 52,
                  imageHeight: 52,
                ),
              ),
            ),
          ),
          const Gap(14),
          // Greeting texts & Fraunces styled name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  greeting,
                  style: AppFont.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? const Color(0xFF8E90A6)
                        : const Color(0xFF7C809B),
                  ),
                ),
                const Gap(3),
                _buildHeaderNameWidget(context, fullname, isDark),
              ],
            ),
          ),
          // Notification Bell
          if (ref.watch(featureProvider('enableNotifications'))) ...[
            _circularHeaderButton(
              svgPath: AppAssets.icAppbarNotifications,
              badgeCount: unreadNotificationCount,
              onTap: () => context.push('/notifications'),
              isDark: isDark,
              context: context,
            ),
            const Gap(10),
          ],
          // Settings button
          _circularHeaderButton(
            svgPath: AppAssets.icAppbarSettings,
            onTap: () => context.push('/settings'),
            isDark: isDark,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _circularHeaderButton({
    required String svgPath,
    int badgeCount = 0,
    required VoidCallback onTap,
    required bool isDark,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52, // Match the height of profile avatar (52px!)
        width: 52,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161722) : Colors.white,
          borderRadius: BorderRadius.circular(16), // Premium squircle radius 16
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
              svgPath,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
            if (badgeCount > 0)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, // Badge dot / count background
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Center(
                    child: Text(
                      badgeCount.toString(),
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
    );
  }
}
