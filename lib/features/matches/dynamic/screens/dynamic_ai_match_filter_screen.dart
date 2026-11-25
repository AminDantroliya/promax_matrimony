import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/features/search/dynamic/providers/dynamic_search_notifier.dart';
import 'package:pro_matrimony/features/search/dynamic/widgets/dynamic_search_renderer.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';

class DynamicAiMatchFilterScreen extends ConsumerStatefulWidget {
  const DynamicAiMatchFilterScreen({super.key});

  @override
  ConsumerState<DynamicAiMatchFilterScreen> createState() =>
      _DynamicAiMatchFilterScreenState();
}

class _DynamicAiMatchFilterScreenState
    extends ConsumerState<DynamicAiMatchFilterScreen> {
  @override
  Widget build(BuildContext context) {
    final dropdownAsync = ref.watch(allDropdownsProvider);
    final searchState = ref.watch(dynamicAiMatchProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (searchState.isLoadingSchema && searchState.schema.sections.isEmpty) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              AppAppBar(title: 'ai_matchmaking'.tr, isShowActions: false),
              const Expanded(child: Center(child: AppLoadingWidget())),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'ai_matchmaking'.tr, isShowActions: false),
            Expanded(
              child: dropdownAsync.when(
                data: (dropdownData) {
                  if (!isDropdownDataProper(dropdownData)) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('failed_to_load_options'.tr),
                          const Gap(12),
                          ElevatedButton(
                            onPressed: () {
                              ApplicationData().setDropdownResponseModel = null;
                              ref.invalidate(allDropdownsProvider);
                            },
                            child: Text('retry'.tr),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await ref.read(dynamicAiMatchProvider.notifier).fetchSchema();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                      child: DynamicSearchRenderer(
                        searchType: 'ai_match_search',
                        searchPageTitle: 'AI Matchmaking',
                        isAiMatch: true,
                        headerWidget: _buildTodayBestMatchesButton(isDark),
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: AppLoadingWidget()),
                error: (e, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${'failed_to_load_options'.tr}: $e"),
                      const Gap(12),
                      ElevatedButton(
                        onPressed: () {
                          ApplicationData().setDropdownResponseModel = null;
                          ref.invalidate(allDropdownsProvider);
                        },
                        child: Text('retry'.tr),
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

  Widget _buildTodayBestMatchesButton(bool isDark) {
    return GestureDetector(
      onTap: () {
        ref
            .read(dynamicAiMatchProvider.notifier)
            .executeAiMatchSearch(context, isTodayBestMatches: true);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.28),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaAiFilter,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'view_todays_best_matches'.tr,
                    style: AppFont.font(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    'todays_best_matches_subtitle'.tr,
                    style: AppFont.font(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
