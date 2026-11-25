import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/success_stories/providers/success_story_notifier.dart';
import 'package:pro_matrimony/features/success_stories/widgets/success_story_widgets.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/app_loading_widget.dart';
import '../../../widgets/app_no_records_widget.dart';

class SuccessStoriesScreen extends ConsumerStatefulWidget {
  const SuccessStoriesScreen({super.key});

  @override
  ConsumerState<SuccessStoriesScreen> createState() =>
      _SuccessStoriesScreenState();
}

class _SuccessStoriesScreenState extends ConsumerState<SuccessStoriesScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = "all"; // "all", "video", "upload"

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(successStoryProvider.notifier).fetchSuccessStories();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final type = _selectedCategory == "video" ? "video_story" : null;
        ref
            .read(successStoryProvider.notifier)
            .fetchSuccessStories(isRefresh: false, type: type);
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
    final state = ref.watch(successStoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgApp,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Bar Header
            AppAppBar(title: 'success_stories'.tr, isShowActions: false),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  final type = _selectedCategory == "video"
                      ? "video_story"
                      : null;
                  return ref
                      .read(successStoryProvider.notifier)
                      .fetchSuccessStories(type: type, isPullToRefresh: true);
                },
                color: Theme.of(context).primaryColor,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      // 3. Category Switcher Pills
                      _buildCategorySwitcher(isDark),
                      const Gap(16),

                      // 4. List View or loading states
                      state.isLoading && state.items.isEmpty
                          ? const SizedBox(
                              height: 200,
                              child: Center(child: AppLoadingWidget()),
                            )
                          : state.items.isEmpty
                          ? const SizedBox(
                              height: 200,
                              child: Center(child: AppNoRecordsWidget()),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.items.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final story = state.items[index];
                                return SuccessStoryListItem(
                                  story: story,
                                  index: index,
                                );
                              },
                            ),
                      if (state.isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AppLoadingWidget(),
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



  Widget _buildCategorySwitcher(bool isDark) {
    return Row(
      children: [
        _buildSwitcherTab(
          "all",
          "all_stories".tr,
          AppAssets.successStoryAll,
          isDark,
        ),
        const Gap(10),
        _buildSwitcherTab(
          "video",
          "video_lbl".tr,
          AppAssets.successStoryVideo,
          isDark,
        ),
        const Gap(10),
        _buildSwitcherTab(
          "upload",
          "btn_upload".tr,
          AppAssets.uploadSuccessStory,
          isDark,
        ),
      ],
    );
  }

  Widget _buildSwitcherTab(
    String category,
    String label,
    String svgAsset,
    bool isDark,
  ) {
    final active = _selectedCategory == category;
    final primaryColor = Theme.of(context).primaryColor;
    final primaryGradient = FigmaColors.primaryGradient(context);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (category == "upload") {
            context.push('/add-success-story');
            return;
          }
          setState(() {
            _selectedCategory = category;
          });
          final type = category == "video" ? "video_story" : null;
          ref
              .read(successStoryProvider.notifier)
              .fetchSuccessStories(isRefresh: true, type: type);
        },
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            gradient: active ? primaryGradient : null,
            color: active
                ? primaryColor
                : (isDark
                      ? AppColors.white.withValues(alpha: 0.05)
                      : AppColors.white),
            borderRadius: BorderRadius.circular(22),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.30),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : AppShadows.card,
            border: Border.all(
              color: active
                  ? Colors.transparent
                  : (isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : const Color(0xFFF1F5F9)),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgAsset,
                colorFilter: ColorFilter.mode(
                  active
                      ? AppColors.white
                      : (isDark ? Colors.white70 : AppColors.textSecondary),
                  BlendMode.srcIn,
                ),
                width: 16,
                height: 16,
              ),
              const Gap(6),
              Text(
                label,
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: active
                      ? AppColors.white
                      : (isDark ? Colors.white70 : AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
