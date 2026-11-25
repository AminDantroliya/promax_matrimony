import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pro_matrimony/features/home/data/repositories/home_repository.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/services/lat_long_service.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:pro_matrimony/widgets/app_text_helpers.dart';
import 'package:pro_matrimony/utils/app_routes.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';

import '../../../core/config/app_config.dart';
import '../../../widgets/profile_cards/profile_card_widget.dart';
import '../providers/matches_notifier.dart';
import '../widgets/dating_card_swiper.dart';
import '../widgets/matches_tour_overlay.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

class MatchesListScreen extends ConsumerStatefulWidget {
  final String url;
  final String title;
  final bool hasBottomNavBar;
  final bool showAllMatchesHeader;

  const MatchesListScreen({
    super.key,
    required this.url,
    required this.title,
    this.hasBottomNavBar = false,
    this.showAllMatchesHeader = false,
  });

  @override
  ConsumerState<MatchesListScreen> createState() => _MatchesListScreenState();
}

class _MatchesListScreenState extends ConsumerState<MatchesListScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentCardIndex = 0;
  bool _showTour = false;
  bool _isLocationDenied = false;
  bool _isCheckingLocation = false;
  bool _isGridView = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.url == getNearByMeMatchesApi) {
        final dashboardData = ref.read(dashboardProvider).value;
        final hasLocation = dashboardData?.latitude != null &&
            dashboardData!.latitude!.trim().isNotEmpty &&
            dashboardData.latitude != 'null' &&
            dashboardData.longitude != null &&
            dashboardData.longitude!.trim().isNotEmpty &&
            dashboardData.longitude != 'null';

        if (hasLocation) {
          ref.read(matchesProvider(widget.url).notifier).fetchMatches(isRefresh: true);
        } else {
          _checkAndRequestLocation();
        }
      } else {
        ref.read(matchesProvider(widget.url).notifier).fetchMatches(isRefresh: true);
      }
    });

    final hasCompleted = AppSessionService.getValue("hasCompletedSwipeTour");
    setState(() {
      _showTour = hasCompleted != true;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels;
      if (maxScroll > 0 &&
          position.userScrollDirection == ScrollDirection.reverse &&
          currentScroll >= maxScroll - 250) {
        final notifier = ref.read(matchesProvider(widget.url).notifier);
        final state = ref.read(matchesProvider(widget.url));
        if (!state.isLoading && !state.isLoadingMore && notifier.hasMore) {
          notifier.fetchMatches(isRefresh: false);
        }
      }
    }
  }

  Future<void> _checkAndRequestLocation() async {
    setState(() {
      _isCheckingLocation = true;
      _isLocationDenied = false;
    });

    try {
      // 1. Check/request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _isLocationDenied = true;
          _isCheckingLocation = false;
        });
        return;
      }

      // 2. Check if location services (GPS) are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLocationDenied = true;
          _isCheckingLocation = false;
        });
        _showGpsDisabledDialog();
        return;
      }

      final position = await LatLongService().requestAndGetLocation();
      if (position == null) {
        setState(() {
          _isLocationDenied = true;
          _isCheckingLocation = false;
        });
        return;
      }

      // Call API to update location
      final repository = ref.read(homeRepositoryProvider);
      await repository.updateLatLong({
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
      });

      // Refresh dashboard notifier so the dashboard data gets updated coordinates
      await ref.read(dashboardProvider.notifier).refresh();

      // Fetch nearby matches
      await ref.read(matchesProvider(widget.url).notifier).fetchMatches(isRefresh: true);

      setState(() {
        _isLocationDenied = false;
        _isCheckingLocation = false;
      });
    } catch (e) {
      printLog('Error in _checkAndRequestLocation: $e');
      setState(() {
        _isLocationDenied = true;
        _isCheckingLocation = false;
      });
    }
  }

  void _showGpsDisabledDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text("location_services_disabled".tr),
        content: Text("please_enable_gps".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("btn_cancel".tr),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Geolocator.openLocationSettings();
            },
            child: Text("settings".tr),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRetryLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showGpsDisabledDialog();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Open settings so user can enable it manually
      await Geolocator.openAppSettings();
    } else {
      await _checkAndRequestLocation();
    }
  }

  void _onSwipeLeft(int index, String memberId) {
    // Ignore/Pass action: client-side skip
    setState(() {
      _currentCardIndex = index + 1;
    });
    _checkPagination();
  }

  Future<void> _onSwipeRight(int index, String memberId) async {
    // Shortlist/Like action: trigger backend API
    setState(() {
      _currentCardIndex = index + 1;
    });
    
    await ref.read(memberActionProvider.notifier).addShortlist(memberId);
    
    _checkPagination();
  }

  void _checkPagination() {
    final state = ref.read(matchesProvider(widget.url));
    if (_currentCardIndex >= state.items.length - 3 || state.items.isEmpty) {
      ref.read(matchesProvider(widget.url).notifier).fetchMatches(isRefresh: false);
    }
  }

  void _onTapCard(int index, String memberId) {
    AppRoutes.openProfile(context, memberId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(matchesProvider(widget.url));

    ref.listen(matchesProvider(widget.url), (previous, next) {
      if (next.page <= 1 && next.items.length <= 10 && previous != null && previous.items.length > 10) {
        if (mounted) {
          setState(() {
            _currentCardIndex = 0;
          });
        }
      }
    });

    if (widget.hasBottomNavBar) {
      return _buildBody(state);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(state),
    );
  }

  Widget _buildBody(dynamic state) {
    if (widget.url == getNearByMeMatchesApi) {
      if (_isCheckingLocation) {
        return const Center(child: AppLoadingWidget());
      }
      if (_isLocationDenied) {
        return _buildLocationDeniedWidget();
      }
    }

    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: AppLoadingWidget());
    }

    if (state.items.isEmpty && !state.isLoading) {
      return const AppNoRecordsWidget();
    }

    final config = ref.watch(appConfigProvider);
    final isSwipable = config.isMatchSwipableProfile;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bottomInset = widget.hasBottomNavBar
        ? (78.0 + MediaQuery.of(context).padding.bottom)
        : 16.0;

    if (!isSwipable) {
      return Column(
        children: [
          // Top Layout Toggle Row (hidden when showAllMatchesHeader is false)
          if (widget.showAllMatchesHeader)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'all_matches'.tr,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : const Color(0xFF4B5563),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 44,
                      height: 44,
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
                ],
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (mounted) {
                  setState(() {
                    _currentCardIndex = 0;
                  });
                }
                await ref.read(matchesProvider(widget.url).notifier).refresh();
              },
              child: _isGridView
                  ? GridView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: EdgeInsets.fromLTRB(16, widget.showAllMatchesHeader ? 0 : 8, 16, bottomInset),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final member = state.items[index];
                        return ProfileCardWidget(
                          memberModel: member,
                          cardStyle: 'card_4',
                        );
                      },
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: widget.showAllMatchesHeader ? 0 : 8,
                        bottom: bottomInset,
                      ),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final member = state.items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ProfileCardWidget(memberModel: member),
                        );
                      },
                    ),
            ),
          ),
          if (state.isLoadingMore)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LoadingPaginationWidget(show: true),
            ),
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 4.0,
                  right: 4.0,
                  top: 0,
                  bottom: bottomInset,
                ),
                child: DatingCardSwiper(
                  items: state.items,
                  currentIndex: _currentCardIndex,
                  isLoadingMore: state.isLoadingMore,
                  onSwipeLeft: (index) {
                    if (index < state.items.length) {
                      final member = state.items[index];
                      _onSwipeLeft(index, (member.memberId ?? member.id).toString());
                    }
                  },
                  onSwipeRight: (index) {
                    if (index < state.items.length) {
                      final member = state.items[index];
                      _onSwipeRight(index, (member.memberId ?? member.id).toString());
                    }
                  },
                  onTapCard: (index) {
                    if (index < state.items.length) {
                      final member = state.items[index];
                      _onTapCard(index, (member.memberId ?? member.id).toString());
                    }
                  },
                  onEmpty: () {
                    _checkPagination();
                  },
                ),
              ),
              if (_showTour)
                MatchesTourOverlay(
                  bottom: bottomInset,
                  imageUrl: state.items.isNotEmpty
                      ? (state.items[_currentCardIndex < state.items.length
                              ? _currentCardIndex
                              : 0]
                          .profileImage ?? '')
                      : '',
                  onDismiss: () {
                    AppSessionService.setValue("hasCompletedSwipeTour", true);
                    setState(() {
                      _showTour = false;
                    });
                  },
                ),
            ],
          ),
        ),
        if (state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: LoadingPaginationWidget(show: true),
          ),
      ],
    );
  }

  Widget _buildLocationDeniedWidget() {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_off_rounded,
                size: 60,
                color: theme.primaryColor,
              ),
            ),
            const Gap(24),
            customTextBoldStyle(
              "location_permission_required".tr,
              20,
              TextAlign.center,
              theme.colorScheme.onSurface,
            ),
            const Gap(12),
            customTextNormalStyle(
              "location_denied_explanation".tr,
              14,
              TextAlign.center,
              theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const Gap(32),
            AppPrimaryButton(
              label: "retry_enable_location".tr,
              isLoading: _isCheckingLocation,
              onPressed: _handleRetryLocation,
              width: 220,
            ),
          ],
        ),
      ),
    );
  }
}
