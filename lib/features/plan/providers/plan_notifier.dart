import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/plan_models.dart';
import '../data/repositories/plan_repository.dart';

part 'plan_notifier.g.dart';

@riverpod
class PlanNotifier extends _$PlanNotifier {
  @override
  FutureOr<PlanListData?> build() async {
    final response = await ref.read(planRepositoryProvider).getPlanList();
    return response.data;
  }
}

@riverpod
class CurrentPlanNotifier extends _$CurrentPlanNotifier {
  @override
  FutureOr<CurrentPlanData?> build() async {
    final response = await ref.read(planRepositoryProvider).getCurrentPlan();
    return response?.data;
  }
}

@riverpod
class PlanHistoryNotifier extends _$PlanHistoryNotifier {
  @override
  FutureOr<List<CurrentPlan>?> build() async {
    final response = await ref.read(planRepositoryProvider).getPlanHistory({
      'page': 1,
      'limit': 10,
    });
    return response.data?.resultList;
  }
}
