import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import '../../../../config/providers/config_providers.dart';

enum DashboardCategory {
  dashboard1,
  dashboard2,
  dashboard3;

  static DashboardCategory fromString(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return DashboardCategory.dashboard1;
    }
    final match = RegExp(r'(\d+)').firstMatch(value.toString());
    final id = match != null ? int.tryParse(match.group(1)!) : 1;
    switch (id) {
      case 2:
        return DashboardCategory.dashboard2;
      case 3:
        return DashboardCategory.dashboard3;
      case 1:
      default:
        return DashboardCategory.dashboard1;
    }
  }
}

class DashboardCategoryNotifier extends Notifier<DashboardCategory> {
  @override
  DashboardCategory build() {
    final saved = AppSessionService.getValue('dashboard_category');
    if (saved != null && saved.toString().trim().isNotEmpty) {
      return DashboardCategory.fromString(saved.toString());
    }
    final config = ref.watch(appConfigProvider);
    return DashboardCategory.fromString(config.dashboardDesign);
  }

  void setCategory(DashboardCategory category) {
    state = category;
    AppSessionService.setValue('dashboard_category', category.name);
  }
}

final dashboardCategoryProvider =
    NotifierProvider<DashboardCategoryNotifier, DashboardCategory>(
  DashboardCategoryNotifier.new,
);
