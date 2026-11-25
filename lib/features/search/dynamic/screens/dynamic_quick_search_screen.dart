import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/features/search/dynamic/providers/dynamic_search_notifier.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import '../widgets/dynamic_search_renderer.dart';

class DynamicQuickSearchScreen extends ConsumerStatefulWidget {
  const DynamicQuickSearchScreen({super.key});

  @override
  ConsumerState<DynamicQuickSearchScreen> createState() =>
      _DynamicQuickSearchScreenState();
}

class _DynamicQuickSearchScreenState
    extends ConsumerState<DynamicQuickSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final dropdownAsync = ref.watch(allDropdownsProvider);
    final searchState = ref.watch(dynamicQuickSearchProvider);
    final theme = Theme.of(context);

    if (searchState.isLoadingSchema && searchState.schema.sections.isEmpty) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const Center(child: AppLoadingWidget()),
      );
    }

    return dropdownAsync.when(
      data: (dropdownData) {
        if (!isDropdownDataProper(dropdownData)) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('failed_to_load_options'.tr),
                const SizedBox(height: 12),
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

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: RefreshIndicator(
            onRefresh: () async {
              await ref.read(dynamicQuickSearchProvider.notifier).fetchSchema();
            },
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: DynamicSearchRenderer(
                searchType: 'quick_search',
                searchPageTitle: 'Quick Search',
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: AppLoadingWidget()),
      error: (e, st) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${'failed_to_load_options'.tr}: $e"),
            const SizedBox(height: 12),
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
    );
  }
}
