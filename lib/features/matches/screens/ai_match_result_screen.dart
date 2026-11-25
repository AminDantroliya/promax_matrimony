import 'dart:math' show sin, pi;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';

import '../providers/ai_match_notifier.dart';
import '../../search/providers/search_notifier.dart';
import '../../../widgets/profile_cards/profile_card_widget.dart';
import '../../../widgets/app_loading_widget.dart';

class AiMatchResultScreen extends ConsumerStatefulWidget {
  final AiMatchCriteria criteria;
  const AiMatchResultScreen({super.key, required this.criteria});

  @override
  ConsumerState<AiMatchResultScreen> createState() =>
      _AiMatchResultScreenState();
}

class _AiMatchResultScreenState extends ConsumerState<AiMatchResultScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(aiMatchProvider.notifier)
          .search(widget.criteria, isRefresh: true);
    });
    _scrollController.addListener(() {
      if (!widget.criteria.isTodayBestMatches &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        ref
            .read(aiMatchProvider.notifier)
            .search(widget.criteria, isRefresh: false);
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
    final state = ref.watch(aiMatchProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveCount = state.items.isEmpty ? 0 : state.totalCount;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(effectiveCount, isDark, theme),
            _buildFilterTabsRow(isDark, theme),
            Expanded(child: _buildContent(state, isDark)),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  Widget _buildAppBar(int totalCount, bool isDark, ThemeData theme) {
    return AppAppBar(
      title: widget.criteria.isTodayBestMatches
          ? 'todays_best_matches'.tr
          : 'ai_matches_title'.tr,
      isShowActions: false,
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isGridView = !_isGridView),
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
                _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Filter tabs ──────────────────────────────────────────────────────────

  Widget _buildFilterTabsRow(bool isDark, ThemeData theme) {
    if (widget.criteria.isTodayBestMatches) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        children: [
          _buildAiBadgeChip(isDark),
          // const Gap(8),
          // _buildScoreChip(isDark),
        ],
      ),
    );
  }

  Widget _buildAiBadgeChip(bool isDark) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: FigmaColors.primaryGradient(context),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.figmaAiFilter,
            width: 14,
            height: 14,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          const Gap(6),
          Text(
            widget.criteria.isTodayBestMatches
                ? 'todays_best_matches'.tr
                : 'ai_picks'.tr,
            style: AppFont.font(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ── Content ──────────────────────────────────────────────────────────────

  Widget _buildContent(PagingState<MemberListModel> state, bool isDark) {
    if (state.isLoading && state.items.isEmpty) {
      return const _AiLoadingWidget();
    }
    if (state.items.isEmpty && !state.isLoading) {
      return const AppNoRecordsWidget();
    }
    return Column(
      children: [
        Expanded(
          child: _isGridView
              ? _buildGridView(state.items, isDark)
              : _buildListView(state.items, isDark),
        ),
        if (state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: LoadingPaginationWidget(show: true),
          ),
      ],
    );
  }

  Widget _buildListView(List<MemberListModel> items, bool isDark) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ProfileCardWidget(memberModel: items[index]),
      ),
    );
  }

  Widget _buildGridView(List<MemberListModel> items, bool isDark) {
    return GridView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (_, index) =>
          ProfileCardWidget(memberModel: items[index], cardStyle: 'card_4'),
    );
  }
}

// ── AI-Themed Loading Widget ──────────────────────────────────────────────────

class _AiLoadingWidget extends StatefulWidget {
  const _AiLoadingWidget();

  @override
  State<_AiLoadingWidget> createState() => _AiLoadingWidgetState();
}

class _AiLoadingWidgetState extends State<_AiLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _dotController;
  late AnimationController _scanController;
  late Animation<double> _pulseAnim;
  late Animation<double> _scanAnim;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scanAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _dotController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Pulsing AI orb with scan line ──
          ScaleTransition(
            scale: _pulseAnim,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context).primaryColor.withValues(alpha: 0.18),
                        Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Inner circle with gradient
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: FigmaColors.primaryGradient(context),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Scan line animation
                        AnimatedBuilder(
                          animation: _scanAnim,
                          builder: (_, _) {
                            return Positioned(
                              top: _scanAnim.value * 72,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withValues(alpha: 0.7),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // AI icon
                        SvgPicture.asset(
                          AppAssets.figmaAiFilter,
                          width: 30,
                          height: 30,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(24),
          // ── Animated text ──
          Text(
            'ai_finding_matches'.tr,
            style: AppFont.font(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            ),
          ),
          const Gap(6),
          Text(
            'analysing_compatibility_preferences'.tr,
            style: AppFont.font(
              fontSize: 12,
              color: isDark ? Colors.white54 : const Color(0xFF9CA3AF),
            ),
          ),
          const Gap(20),
          // ── Animated dots ──
          AnimatedBuilder(
            animation: _dotController,
            builder: (_, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  final phase = (_dotController.value - i * 0.2).clamp(
                    0.0,
                    1.0,
                  );
                  final opacity = (sin(phase * pi)).clamp(0.2, 1.0);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: FigmaColors.primaryGradient(context),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
