import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter/material.dart';
import 'package:pro_matrimony/features/activity/screens/activity_member_list_screen.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/utils/utils.dart';

class RecentJoinedScreen extends ConsumerStatefulWidget {
  const RecentJoinedScreen({super.key});

  @override
  ConsumerState<RecentJoinedScreen> createState() => _RecentJoinedScreenState();
}

class _RecentJoinedScreenState extends ConsumerState<RecentJoinedScreen> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(
              title: 'recently_joined'.tr,
              isShowActions: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () => setState(() => _isGridView = !_isGridView),
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
                          color: theme.colorScheme.secondary,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              key: ValueKey('recent_joined_$_isGridView'),
              child: ActivityMemberListScreen(
                url: getRecentJoinedListApi,
                isGrid: _isGridView,
                noRecordMsg: 'no_recently_joined_found'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
