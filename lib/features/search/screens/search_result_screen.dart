import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:pro_matrimony/widgets/glassmorphic_background.dart';

import '../providers/search_notifier.dart';
import '../../notifications/providers/notification_notifier.dart';
import '../../home/providers/dashboard_notifier.dart';
import '../../../widgets/profile_cards/profile_card_widget.dart';
import '../../../features/common/data/models/member_models.dart';

class SearchResultScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? initialParams;
  const SearchResultScreen({super.key, this.initialParams});

  @override
  ConsumerState<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends ConsumerState<SearchResultScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView =
      false; // Default: Single-column List View, second option: 2-column Grid View
  String _selectedTab = 'All'; // Active tab: All, Premium, Verified

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialParams != null) {
        // Map legacy params to SearchCriteria
        final criteria = SearchCriteria(
          gender: widget.initialParams!['gender'],
          fromAge: widget.initialParams!['from_age'],
          toAge: widget.initialParams!['to_age'],
          fromHeight: widget.initialParams!['from_height'],
          toHeight: widget.initialParams!['to_height'],
          maritalStatus: widget.initialParams!['marital_status'],
          religion: widget.initialParams!['religion'],
          caste: widget.initialParams!['caste'],
          country: widget.initialParams!['country_id'],
          photoSearch: widget.initialParams!['photo_search'] == "Yes"
              ? "Yes"
              : null,
          matriId: widget.initialParams!['matri_id'],
        );
        ref.read(searchCriteriaProvider.notifier).updateCriteria(criteria);
      }
      ref.read(searchResultProvider.notifier).search(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final position = _scrollController.position;
        if (position.maxScrollExtent > 0 &&
            position.userScrollDirection == ScrollDirection.reverse &&
            position.pixels >= position.maxScrollExtent - 200) {
          final state = ref.read(searchResultProvider);
          final notifier = ref.read(searchResultProvider.notifier);
          if (!state.isLoading && !state.isLoadingMore && notifier.hasMore) {
            notifier.search(isRefresh: false);
          }
        }
      }
    });

    _searchController.addListener(() {
      // Local keyword dynamic filter (if needed, updates criteria and runs search)
      final text = _searchController.text.trim();
      final currentCriteria = ref.read(searchCriteriaProvider);
      if (currentCriteria.keyword != text) {
        ref
            .read(searchCriteriaProvider.notifier)
            .updateCriteria(
              currentCriteria.copyWith(keyword: text.isNotEmpty ? text : null),
            );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchResultProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Apply active category filtering directly from backend response
    List<MemberListModel> filteredItems = searchState.items;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassmorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Premium squircle Custom Header
              _buildCustomHeader(
                searchState.items.isEmpty ? 0 : searchState.totalCount,
                isDark,
                theme,
              ),

              // 2. Category scroll & Layout Toggle Row
              _buildFilterTabsRow(isDark, theme),

              // 4. Content list/grid view area
              Expanded(child: _buildContentArea(searchState, filteredItems)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomHeader(int totalCount, bool isDark, ThemeData theme) {
    final dashboardData = ref.watch(dashboardProvider).value;
    final dashboardUnread = dashboardData?.unreadNotificationCount ?? 0;
    final notificationUnread = ref.watch(unreadNotificationCountProvider);
    final unreadNotificationCount = dashboardUnread > 0
        ? dashboardUnread
        : notificationUnread;

    final accentColor = theme.colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left back arrow squircle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.05),
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
                icon: Icon(
                  Icons.arrow_back,
                  color: accentColor,
                  size: 22,
                ),
                onPressed: () => context.pop(),
              ),
            ),
          ),

          const Gap(14),
          // Title & subtitle (Left aligned)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildAppTitleWidget(context, "${'search'.tr} ${'result'.tr}"),
                const Gap(3),
                Text(
                  'curated_profiles_subtext'.trParams({
                    'count': totalCount.toString(),
                  }),
                  style: AppFont.font(
                    fontSize: 13,
                    color: isDark
                        ? Colors.white60
                        : const Color(0xFF9CA3AF), // Clean gray subtext
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),

          // Right layout toggle & notification squircles
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Layout View Toggle Squircle Button
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
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.25)
                            : Colors.black.withValues(alpha: 0.05),
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

              // Notification squircle
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
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.25)
                            : Colors.black.withValues(alpha: 0.05),
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
                          accentColor,
                          BlendMode.srcIn,
                        ),
                        width: 22,
                        height: 22,
                      ),
                      if (unreadNotificationCount > 0)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF2D55), // Red notification badge
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: Center(
                              child: Text(
                                unreadNotificationCount.toString(),
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
        ],
      ),
    );
  }

  Widget _buildFilterTabsRow(bool isDark, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildCategoryTab(
              'tab_all'.tr,
              AppAssets.figmaAll,
              isDark,
              theme,
            ),
            const Gap(8),
            _buildCategoryTab(
              'tab_premium'.tr,
              AppAssets.figmaDiamonds,
              isDark,
              theme,
            ),
            const Gap(8),
            _buildCategoryTab(
              'tab_verified'.tr,
              AppAssets.figmaVerified,
              isDark,
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(
    String tabName,
    String svgPath,
    bool isDark,
    ThemeData theme,
  ) {
    final isActive = _selectedTab == tabName;

    if (isActive) {
      return Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: BorderRadius.circular(65), // Fully rounded pill tab
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 16,
              height: 16,
            ),
            const Gap(6),
            Text(
              tabName,
              style: AppFont.font(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            _selectedTab = tabName;
          });
          final verifyVal = tabName == "Premium"
              ? "premium"
              : (tabName == "Verified" ? "verified" : null);
          final currentCriteria = ref.read(searchCriteriaProvider);
          ref
              .read(searchCriteriaProvider.notifier)
              .updateCriteria(
                currentCriteria.copyWith(verifyStatus: verifyVal),
              );
          ref.read(searchResultProvider.notifier).search(isRefresh: true);
        },
        borderRadius: BorderRadius.circular(65),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(65),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFE5E7EB),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svgPath,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white30 : const Color(0xFF9CA3AF),
                  BlendMode.srcIn,
                ),
                width: 16,
                height: 16,
              ),
              const Gap(6),
              Text(
                tabName,
                style: AppFont.font(
                  color: isDark
                      ? Colors.white70
                      : const Color(0xFF4B5563), // Slate grey
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildContentArea(
    PagingState searchState,
    List<MemberListModel> filteredItems,
  ) {
    if (searchState.isLoading && searchState.items.isEmpty) {
      return const AppLoadingWidget();
    }

    if (filteredItems.isEmpty && !searchState.isLoading) {
      return RefreshIndicator(
        onRefresh: () async {
          await ref.read(searchResultProvider.notifier).search(isRefresh: true);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: const [SizedBox(height: 100), AppNoRecordsWidget()],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(searchResultProvider.notifier).search(isRefresh: true);
      },
      child: Column(
        children: [
          Expanded(
            child: _isGridView
                ? _buildGridView(filteredItems)
                : _buildListView(filteredItems),
          ),
          if (searchState.isLoadingMore)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: LoadingPaginationWidget(show: true),
            ),
        ],
      ),
    );
  }

  Widget _buildListView(List<MemberListModel> items) {
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      itemCount: items.length,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      itemBuilder: (context, index) {
        final member = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ProfileCardWidget(memberModel: member),
        );
      },
    );
  }

  Widget _buildGridView(List<MemberListModel> items) {
    return GridView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      itemCount: items.length,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final member = items[index];
        return ProfileCardWidget(memberModel: member, cardStyle: 'card_4');
      },
    );
  }
}
