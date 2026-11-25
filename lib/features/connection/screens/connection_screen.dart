import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:pro_matrimony/features/notifications/providers/notification_notifier.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';

import '../providers/connection_notifier.dart';
import '../widgets/connection_list_item.dart';
import '../../settings/data/repositories/settings_repository.dart';
import '../../../utils/api_urls.dart';

class ConnectionScreen extends ConsumerStatefulWidget {
  final String initialTab; // "received" or "sent"

  const ConnectionScreen({super.key, this.initialTab = "received"});

  @override
  ConsumerState<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends ConsumerState<ConnectionScreen> {
  int _selectedTab = 0; // 0 for Sent, 1 for Received
  String _selectedStatusFilter = 'All'; // All, Pending, Accepted, Rejected
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Swap original tabs to match Figma (index 0 is Sent, index 1 is Received)
    _selectedTab = widget.initialTab == "received" ? 1 : 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
      // Also pre-fetch the other tab's data so we have counts
      final oppositeType = _selectedTab == 0 ? "received" : "sent";
      ref
          .read(connectionProvider(oppositeType).notifier)
          .fetchConnections(isRefresh: true, statusFilter: "All");
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _fetchData(isRefresh: false);
      }
    });
  }

  void _fetchData({bool isRefresh = true}) {
    final type = _selectedTab == 0 ? "sent" : "received";
    ref
        .read(connectionProvider(type).notifier)
        .fetchConnections(isRefresh: isRefresh, statusFilter: _selectedStatusFilter);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type = _selectedTab == 0 ? "sent" : "received";
    final state = ref.watch(connectionProvider(type));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get notifications count
    final dashboardUnread = ref.watch(dashboardProvider).value?.unreadNotificationCount ?? 0;
    final notificationUnread = ref.watch(unreadNotificationCountProvider);
    final unreadNotificationCount = dashboardUnread > 0 ? dashboardUnread : notificationUnread;

    // Watch both providers to get counts dynamically
    final sentState = ref.watch(connectionProvider("sent"));
    final receivedState = ref.watch(connectionProvider("received"));

    final finalSentCount = sentState.sentCount;
    final finalReceivedCount = receivedState.receivedCount;
    final finalAcceptedCount = _selectedTab == 0 ? sentState.acceptedCount : receivedState.acceptedCount;

    // Direct items list from notifier state
    final filteredItems = state.items;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            _buildAppBar(context, unreadNotificationCount, isDark),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _fetchData(isRefresh: true);
                },
                child: ListView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  children: [
                    // Conditional Stats Banner Card
                    _buildBannerCard(
                      finalSentCount,
                      finalReceivedCount,
                      finalAcceptedCount,
                      isDark,
                    ),
                    const Gap(16),

                    // Custom Segmented Tab Switcher
                    _buildCustomTabSelector(
                      finalSentCount,
                      finalReceivedCount,
                      isDark,
                    ),
                    const Gap(16),

                    // Sub-status Filters (Only on Sent Tab)
                    if (_selectedTab == 0) ...[
                      _buildSubFilters(isDark),
                      const Gap(16),
                    ],

                    // Section Title "NEW TODAY" (Only on Received Tab)
                    if (_selectedTab == 1) ...[
                      _buildSectionTitle(isDark),
                      const Gap(12),
                    ],

                    // Connection Cards List
                    if (state.isLoading && state.items.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Center(child: AppLoadingWidget()),
                      )
                    else if (filteredItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: AppNoRecordsWidget(
                          noRecordFoundMessage: _selectedStatusFilter != 'All'
                              ? 'no_connection_requests_found_status'.trParams({'status': _selectedStatusFilter})
                              : 'no_connection_requests_found'.tr,
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        separatorBuilder: (context, index) => const Gap(14),
                        itemBuilder: (context, index) {
                          final member = filteredItems[index];
                          return ConnectionListItem(
                            member: member,
                            isReceived: _selectedTab == 1,
                            onAction: (action) => _handleAction(
                              member.id!.toString(),
                              action,
                              receiverMemberId: (member.receiverMemberId ?? member.memberId ?? "").toString(),
                            ),
                          );
                        },
                      ),

                    if (state.isLoadingMore) ...[
                      const Gap(16),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, int unreadCount, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          InkWell(
            onTap: () => Navigator.pop(context),
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
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 22,
                ),
              ),
            ),
          ),
          const Gap(14),
          // Title (Left aligned)
          Expanded(
            child: buildAppTitleWidget(context, 'interests_title'.tr),
          ),
          const Gap(10),
          // Notifications Action
          InkWell(
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
                      AppAssets.figmaNotifications,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
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
                            color: Color(0xFFFF2D55), // Badge dot / count background
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

  Widget _buildBannerCard(int sent, int received, int accepted, bool isDark) {
    if (_selectedTab == 0) {
      // Sent Tab: 3-column connection stats card (Figma HERO)
      final finalAccepted = accepted;

      return Container(
        height: 108,
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.24),
              blurRadius: 38,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Sent Stats
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.call_made_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const Gap(6),
                  Text(
                    sent.toString().padLeft(2, '0'),
                    style: AppFont.font(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'sent_caps'.tr,
                    style: AppFont.font(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.75),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Vertical Divider
            Container(
              width: 1,
              height: 52,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            // 2. Received Stats
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.call_received_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const Gap(6),
                  Text(
                    received.toString().padLeft(2, '0'),
                    style: AppFont.font(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'received_caps'.tr,
                    style: AppFont.font(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.75),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Vertical Divider
            Container(
              width: 1,
              height: 52,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            // 3. Accepted Stats
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8567A),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE8567A).withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.figmaSendInterest,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                  const Gap(6),
                  Text(
                    finalAccepted.toString().padLeft(2, '0'),
                    style: AppFont.font(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'accepted_caps'.tr,
                    style: AppFont.font(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.75),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Received Tab: "You have X new Requests" card
      return Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.24),
              blurRadius: 38,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left glowing flame container
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.45),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            const Gap(16),
            // Middle Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: AppFont.font(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(text: "${'you_have'.tr} "),
                        TextSpan(
                          text: "$received ${'new_word'.tr}",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'track_all_connections'.tr,
                    style: AppFont.font(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Right sparkle star icon
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCustomTabSelector(int sent, int received, bool isDark) {
    final primaryColor = Theme.of(context).primaryColor;
    return AppTabBar(
      tabs: ['sent'.tr, 'received'.tr],
      badgeTexts: [
        sent.toString().padLeft(2, '0'),
        received.toString().padLeft(2, '0'),
      ],
      icons: const [
        Icon(Icons.call_made_rounded, size: 16),
        Icon(Icons.call_received_rounded, size: 16),
      ],
      selectedIndex: _selectedTab,
      outerPadding: EdgeInsets.zero,
      height: 48,
      activeGradient: FigmaColors.primaryGradient(context),
      activeTextColor: Colors.white,
      inactiveTextColor: isDark ? Colors.grey.shade400 : const Color(0xFF5B6176),
      activeIconColor: Colors.white,
      inactiveIconColor: isDark ? Colors.grey.shade500 : const Color(0xFF8E95A5),
      activeBadgeBgColor: Colors.white.withValues(alpha: 0.25),
      activeBadgeTextColor: Colors.white,
      inactiveBadgeBgColor: primaryColor.withValues(alpha: isDark ? 0.2 : 0.08),
      inactiveBadgeTextColor: primaryColor,
      trackColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      trackBorder: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : const Color(0xFFF0ECE9),
        width: 1.0,
      ),
      onTap: (index) {
        setState(() {
          _selectedTab = index;
          _selectedStatusFilter = 'All';
        });
        _fetchData();
      },
    );
  }

  Widget _buildSubFilters(bool isDark) {
    final filters = ['All', 'Pending', 'Accepted', 'Rejected'];
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const Gap(10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = _selectedStatusFilter == filter;

          Color dotColor = primaryColor;
          String label = filter;
          if (filter == 'All') {
            dotColor = primaryColor;
            label = 'All';
          } else if (filter == 'Pending') {
            dotColor = const Color(0xFFF59E0B);
            label = 'Pending';
          } else if (filter == 'Accepted') {
            dotColor = const Color(0xFF10B981);
            label = 'Accepted';
          } else if (filter == 'Rejected') {
            dotColor = const Color(0xFFEF4444);
            label = 'Declined';
          }

          final bg = isActive
              ? primaryColor.withValues(alpha: isDark ? 0.15 : 0.08)
              : (isDark ? const Color(0xFF1E293B) : Colors.white);

          final borderColor = isActive
              ? (isDark ? primaryColor : primaryColor.withValues(alpha: 0.35))
              : (isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFEFE8E8));

          final textColor = isActive
              ? (isDark ? Colors.white : primaryColor)
              : (isDark ? Colors.grey.shade400 : const Color(0xFF3A344A));

          return InkWell(
            onTap: () {
              setState(() {
                _selectedStatusFilter = filter;
              });
              _fetchData(isRefresh: true);
            },
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: borderColor,
                  width: isActive ? 1.2 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    label,
                    style: AppFont.font(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(bool isDark) {
    return Row(
      children: [
        Icon(
          Icons.swap_vertical_circle_outlined,
          color: isDark ? Colors.grey.shade500 : const Color(0xFF6E7890),
          size: 14,
        ),
        const Gap(6),
        Text(
          'new_today_caps'.tr,
          style: AppFont.font(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: isDark ? Colors.grey.shade500 : const Color(0xFF6E7890),
          ),
        ),
      ],
    );
  }

  void _handleAction(String connectionId, String action, {String? receiverMemberId}) async {
    showLoading(context);
    final type = _selectedTab == 0 ? "sent" : "received";
    
    if (action.toLowerCase() == "reminder") {
      final repository = ref.read(settingsRepositoryProvider);
      final params = {
        "receiver_member_id": receiverMemberId ?? "",
      };
      final result = await repository.performAction(sendConnectionApi, params);
      hideLoading();
      if (!mounted) return;
      if (result['status'] == "success") {
        showSuccessToast(
          context,
          result['message']?.toString() ?? 'reminder_sent_success'.tr,
          icon: Icons.notifications_active_rounded,
        );
        ref.read(connectionProvider(type).notifier).fetchConnections(isRefresh: true);
      } else {
        showErrorToast(context, result['message'] ?? 'failed_to_send_reminder'.tr);
      }
      return;
    }

    final success = await ref
        .read(connectionProvider(type).notifier)
        .performAction(connectionId, action);
    hideLoading();
    if (success) {
      if (action.toLowerCase() == "remove") {
        showToast('interest_request_removed_success'.tr);
      } else {
        showToast(
          'request_action_success'.trParams({
            'action': action.toLowerCase() == 'accept' || action.toLowerCase() == 'accepted'
                ? 'accepted_lbl'.tr
                : 'declined'.tr,
          }),
        );
      }
      // Also refresh the other tab's data so counts update correctly
      final oppositeType = _selectedTab == 0 ? "received" : "sent";
      ref
          .read(connectionProvider(oppositeType).notifier)
          .fetchConnections(isRefresh: true, statusFilter: "All");
    } else {
      showToast('action_failed'.tr);
    }
  }
}
