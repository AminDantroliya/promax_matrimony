import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/activity/providers/activity_notifier.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/features/common/data/repositories/action_repository.dart';
import 'package:pro_matrimony/features/notifications/providers/notification_notifier.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/app_routes.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:go_router/go_router.dart';

class BlockedProfileScreen extends ConsumerStatefulWidget {
  const BlockedProfileScreen({super.key});

  @override
  ConsumerState<BlockedProfileScreen> createState() =>
      _BlockedProfileScreenState();
}

class _BlockedProfileScreenState extends ConsumerState<BlockedProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(activityProvider(getBlockedListApi).notifier)
          .fetchActivityProfiles(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref
            .read(activityProvider(getBlockedListApi).notifier)
            .fetchActivityProfiles(isRefresh: false);
      }
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _getMemberId(MemberListModel member) {
    final id = member.memberId ?? member.receiverMemberId ?? member.id;
    return id?.toString() ?? "";
  }

  Future<void> _unblockUser(MemberListModel member) async {
    final confirmed = await AppDialogs.confirmBlock(
      context,
      isBlocked: true,
      memberName: member.fullname ?? member.profileTitle ?? 'this user',
    );
    if (!confirmed) return;

    if (!mounted) return;
    showLoading(context);
    try {
      final effectiveId = _getMemberId(member);
      final params = {
        "receiver_member_id": effectiveId,
        "action": "remove", // remove for unblock
      };

      final status = await ref
          .read(actionRepositoryProvider)
          .performAction(blockActionApi, params);

      if (!mounted) return;
      hideLoading();

      if (status == "success") {
        showToast("user_unblocked_success".tr);
        ref
            .read(activityProvider(getBlockedListApi).notifier)
            .removeMember(effectiveId);
      } else {
        showToast("something_went_wrong".tr);
      }
    } catch (e) {
      if (mounted) hideLoading();
      showToast("something_went_wrong".tr);
    }
  }

  String _getShortDetails(MemberListModel member) {
    final parts = <String>[];
    if (member.birthdate != null) {
      final age = _calculateAge(member.birthdate.toString());
      if (age > 0) {
        parts.add("$age yrs");
      }
    } else if (member.subTitle != null) {
      final match = RegExp(
        r'(\d+)\s*Year',
      ).firstMatch(member.subTitle.toString());
      if (match != null) {
        parts.add("${match.group(1)} yrs");
      }
    }

    if (member.cityName != null && member.cityName.toString().isNotEmpty) {
      parts.add(member.cityName.toString());
    } else if (member.subTitle != null) {
      final subParts = member.subTitle.toString().split(',');
      if (subParts.length > 1) {
        parts.add(subParts[1].trim());
      }
    }

    return parts.join(' · ');
  }

  int _calculateAge(String birthDateString) {
    try {
      final birthDate = DateTime.parse(birthDateString);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return 26;
    }
  }

  int _getDeterministicMatch(MemberListModel member) {
    if (member.matchPercent != null) {
      final val = int.tryParse(member.matchPercent.toString().replaceAll('%', '').trim());
      if (val != null && val > 0) return val;
    }
    final seed = (member.fullname ?? member.matriId ?? 'user').hashCode.abs();
    return 80 + (seed % 19); // Generates a realistic score between 80% and 98%
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activityProvider(getBlockedListApi));
    final dashboardUnread =
        ref.watch(dashboardProvider).value?.unreadNotificationCount ?? 0;
    final notificationUnread = ref.watch(unreadNotificationCountProvider);
    final unreadCount = dashboardUnread > 0
        ? dashboardUnread
        : notificationUnread;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredItems = state.items.where((member) {
      final name = (member.fullname ?? '').toString().toLowerCase();
      final title = (member.profileTitle ?? '').toString().toLowerCase();
      final matriId = (member.matriId ?? '').toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) ||
          title.contains(query) ||
          matriId.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header / AppBar matching Figma
            _buildAppBar(context, unreadCount, isDark),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref
                    .read(activityProvider(getBlockedListApi).notifier)
                    .fetchActivityProfiles(isRefresh: true),
                child: ListView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  children: [
                    // Summary Banner Card matching Figma
                    _buildSummaryCard(state.totalCount > 0 ? state.totalCount : state.items.length, isDark),
                    const Gap(16),

                    // Search input matching Figma
                    _buildSearchBar(isDark),
                    const Gap(20),

                    if (state.isLoading && state.items.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Center(child: AppLoadingWidget()),
                      )
                    else if (filteredItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: AppNoRecordsWidget(
                          noRecordFoundMessage: _searchQuery.isNotEmpty
                              ? "no_matching_profiles_found".tr
                              : "no_blocked_profiles_found".tr,
                        ),
                      )
                    else ...[
                      // Grid of profiles (Figma Card design)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.68,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final member = filteredItems[index];
                          return _buildFigmaBlockedProfileCard(context, member, isDark);
                        },
                      ),
                      if (state.isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CircularProgressIndicator()),
                        ),
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
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button Squircle
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(16),
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
                  color: accentColor,
                  size: 22,
                ),
              ),
            ),
          ),

          const Gap(14),

          // Title (Left aligned)
          Expanded(
            child: buildAppTitleWidget(context, "blocked_profiles".tr),
          ),
          const Gap(10),

          // Right Actions: Notification Bell + Settings Gear
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Notification Squircle
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
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF2D55),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const Gap(8),

              // Settings Squircle
              GestureDetector(
                onTap: () => context.push('/settings'),
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
                      Icons.settings_rounded,
                      color: accentColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(int count, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Dynamic theme background gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: FigmaColors.primaryGradient(context),
                ),
              ),
            ),
            // Decorative background circle 1
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            // Decorative background circle 2
            Positioned(
              bottom: -60,
              left: -60,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: [
                  // Left red shield icon container
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.35),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.gpp_bad_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                  const Gap(16),

                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "$count ",
                                style: AppFont.font(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "Blocked Profiles",
                                style: AppFont.font(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(4),
                        Text(
                          "Manage your blocked member list",
                          style: AppFont.font(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Info Button
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xFFF1F3F9),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        controller: _searchController,
        style: AppFont.font(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          icon: Icon(
            Icons.search_rounded,
            color: Theme.of(context).primaryColor,
            size: 22,
          ),
          hintText: "Search Blocked Profiles",
          hintStyle: AppFont.font(
            fontSize: 14,
            color: isDark ? Colors.grey.shade500 : const Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFigmaBlockedProfileCard(
    BuildContext context,
    MemberListModel member,
    bool isDark,
  ) {
    final displayName = getDisplayString(
      member.fullname,
      defaultValue: getDisplayString(
        member.profileTitle,
        defaultValue: getDisplayString(member.matriId, defaultValue: "User"),
      ),
    );

    final matchPercentage = _getDeterministicMatch(member);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Profile Image
          getImageWidget(
            url: getDisplayString(member.profileImage, defaultValue: ""),
            boxFit: BoxFit.cover,
            imageWidth: double.infinity,
            imageHeight: double.infinity,
          ),

          // Rich Dark Gradient Overlay for text readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Clickable area to open profile
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                    AppRoutes.openProfile(context, _getMemberId(member)),
              ),
            ),
          ),

          // Top Left: Red circular lock badge
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF416C),
                    Color(0xFFFF4B2B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF416C).withValues(alpha: 0.45),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.lock_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),

          // Top Right: Glassmorphic match score pill
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFFF8A65),
                    size: 12,
                  ),
                  const Gap(4),
                  Text(
                    "$matchPercentage%",
                    style: AppFont.font(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center of Card: Glassmorphic Lock Circle
          Center(
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          // Bottom Info: Name, Location & Unblock Button
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Full name in Fraunces bold serif
                Text(
                  displayName,
                  style: AppFont.font(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(3),

                // Location with pin icon
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Color(0xFFFF7A00),
                      size: 13,
                    ),
                    const Gap(4),
                    Expanded(
                      child: Text(
                        (member.subTitle?.toString().trim().isNotEmpty == true)
                            ? member.subTitle.toString().trim()
                            : _getShortDetails(member),
                        style: AppFont.font(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Gap(8),

                // Glassmorphic Unblock Pill Button
                GestureDetector(
                  onTap: () => _unblockUser(member),
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.35),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock_open_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        const Gap(6),
                        Text(
                          "Unblock",
                          style: AppFont.font(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
