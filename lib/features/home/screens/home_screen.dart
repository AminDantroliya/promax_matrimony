import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_category.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/features/home/screens/views/dashboard_1_view.dart';
import 'package:pro_matrimony/features/home/screens/views/dashboard_2_view.dart';
import 'package:pro_matrimony/features/home/screens/views/dashboard_3_view.dart';
import 'package:pro_matrimony/features/home/widgets/home_error_view.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(dashboardProvider).value == null) {
        ref.read(dashboardProvider.notifier).refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);

    // Watch active dashboard category (or override directly for quick testing)
    final dashboardCategory = ref.watch(dashboardCategoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return dashboardAsync.when(
      data: (data) {
        if (data == null) {
          final isLoggedIn =
              AppSessionService.getValue(SessionDetail.kIsLoggedIn) == true;
          if (!isLoggedIn) {
            return HomeErrorView(isDark: isDark);
          }
          return const Center(child: AppLoadingWidget());
        }
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
          child: _buildDashboardCategoryView(dashboardCategory, data, isDark),
        );
      },
      loading: () => const Center(child: AppLoadingWidget()),
      error: (err, stack) =>
          HomeErrorView(isDark: isDark, errorMessage: err.toString()),
    );
  }

  Widget _buildDashboardCategoryView(
    DashboardCategory category,
    dynamic data,
    bool isDark,
  ) {
    switch (category) {
      case DashboardCategory.dashboard2:
        return Dashboard2View(data: data, isDark: isDark);
      case DashboardCategory.dashboard3:
        return Dashboard3View(data: data, isDark: isDark);
      case DashboardCategory.dashboard1:
        return Dashboard1View(data: data, isDark: isDark);
    }
  }
}
