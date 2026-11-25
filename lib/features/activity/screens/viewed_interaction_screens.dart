import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/activity/screens/activity_member_list_screen.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

class ViewedProfileScreen extends ConsumerStatefulWidget {
  const ViewedProfileScreen({super.key});

  @override
  ConsumerState<ViewedProfileScreen> createState() => _ViewedProfileScreenState();
}

class _ViewedProfileScreenState extends ConsumerState<ViewedProfileScreen> {
  int _selectedTab = 0; // 0 for "who_viewed", 1 for "i_viewed"
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final type = _selectedTab == 0 ? "who_viewed" : "i_viewed";
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with List/Grid toggle and notification
            AppAppBar(
              title: _selectedTab == 0 ? 'who_viewed_profile'.tr : 'i_viewed_profile'.tr,
              isShowActions: false,
              actions: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
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
                      child: Icon(
                        _isGridView
                            ? Icons.view_list_rounded
                            : Icons.grid_view_rounded,
                        color: accentColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () => context.push('/notifications'),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
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
                      child: SvgPicture.asset(
                        AppAssets.icAppbarNotifications,
                        colorFilter: ColorFilter.mode(
                          accentColor,
                          BlendMode.srcIn,
                        ),
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            AppTabBar(
              tabs: ["who_viewed".tr, "viewed_by_me".tr],
              selectedIndex: _selectedTab,
              onTap: (index) {
                if (_selectedTab != index) {
                  setState(() {
                    _selectedTab = index;
                  });
                }
              },
            ),
            const Gap(10),
            
            // Expanded Member List Screen
            Expanded(
              key: ValueKey('profile_viewed_${type}_$_isGridView'),
              child: ActivityMemberListScreen(
                url: getViewedProfileListApi,
                extraParams: {"type": type},
                isGrid: _isGridView,
                noRecordMsg: _selectedTab == 0 ? 'no_profiles_viewed_you'.tr : 'you_have_not_viewed_profiles'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewedContactScreen extends ConsumerStatefulWidget {
  const ViewedContactScreen({super.key});

  @override
  ConsumerState<ViewedContactScreen> createState() => _ViewedContactScreenState();
}

class _ViewedContactScreenState extends ConsumerState<ViewedContactScreen> {
  int _selectedTab = 0; // 0 for "who_viewed", 1 for "i_viewed"
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final type = _selectedTab == 0 ? "who_viewed" : "i_viewed";
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with List/Grid toggle and notification
            AppAppBar(
              title: _selectedTab == 0 ? 'who_viewed_contact'.tr : 'i_viewed_contact'.tr,
              isShowActions: false,
              actions: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
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
                      child: Icon(
                        _isGridView
                            ? Icons.view_list_rounded
                            : Icons.grid_view_rounded,
                        color: accentColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () => context.push('/notifications'),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
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
                      child: SvgPicture.asset(
                        AppAssets.icAppbarNotifications,
                        colorFilter: ColorFilter.mode(
                          accentColor,
                          BlendMode.srcIn,
                        ),
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            AppTabBar(
              tabs: ["who_viewed".tr, "viewed_by_me".tr],
              selectedIndex: _selectedTab,
              onTap: (index) {
                if (_selectedTab != index) {
                  setState(() {
                    _selectedTab = index;
                  });
                }
              },
            ),
            const Gap(10),
            
            // Expanded Member List Screen
            Expanded(
              key: ValueKey('contact_viewed_${type}_$_isGridView'),
              child: ActivityMemberListScreen(
                url: getViewedContactListApi,
                extraParams: {"type": type},
                isGrid: _isGridView,
                noRecordMsg: _selectedTab == 0 ? 'no_profiles_viewed_contact'.tr : 'you_have_not_viewed_contacts'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
