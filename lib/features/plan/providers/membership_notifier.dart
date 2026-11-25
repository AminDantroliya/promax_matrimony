import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/plan_models.dart';
import 'package:pro_matrimony/features/plan/data/repositories/plan_repository.dart';

part 'membership_notifier.freezed.dart';
part 'membership_notifier.g.dart';

@freezed
abstract class MembershipState with _$MembershipState {
  const factory MembershipState({
    @Default(false) bool isLoading,
    PlanListResponseModel? planList,
    CurrentPlanResponseModel? currentPlan,
    Object? error,
  }) = _MembershipState;
}

@riverpod
class MembershipNotifier extends _$MembershipNotifier {
  @override
  MembershipState build() {
    return const MembershipState();
  }

  Future<void> fetchPlans() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(planRepositoryProvider);
      final plans = await repository.getPlanList();
      state = state.copyWith(planList: plans, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> applyCoupon(String code, int planId) async {
    // Implementation for applying coupon
  }
}
