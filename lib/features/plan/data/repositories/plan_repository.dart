import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import '../models/plan_models.dart';

part 'plan_repository.g.dart';

class PlanRepository extends BaseRepository {
  PlanRepository(super.dio);

  Future<PlanListResponseModel> getPlanList() async {
    final response = await getRequest(getPlanListApi);
    return PlanListResponseModel.fromJson(response.data);
  }

  Future<CurrentPlanResponseModel?> getCurrentPlan() async {
    final response = await getRequest(getCurrentPlanApi);
    if (response.data['data'] is! Map) {
      return null;
    }
    return CurrentPlanResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> getPlanCouponList(Map<String, dynamic> params) async {
    final response = await postRequest(getPlanCouponListApi, params);
    return response.object;
  }

  Future<Map<String, dynamic>> assignPlan(Map<String, dynamic> params) async {
    final response = await postRequest(assignPlanApi, params);
    return response.object;
  }

  Future<PlanHistoryResponseModel> getPlanHistory(Map<String, dynamic> params) async {
    final response = await postRequest(getPlanHistoryApi, params);
    return PlanHistoryResponseModel.fromJson(response.data);
  }

  Future<CheckoutResponseModel> getPlanCheckout(Map<String, dynamic> params) async {
    final response = await postRequest(getPlanCheckoutApi, params);
    return CheckoutResponseModel.fromJson(response.data);
  }

  Future<CalculatePlanResponseModel> calculatePlanPrice(Map<String, dynamic> params) async {
    final response = await postRequest(calculatePlanPriceApi, params);
    return CalculatePlanResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> assignPlanNew(Map<String, dynamic> params) async {
    final response = await postRequest(assignPlanNewApi, params);
    return response.data;
  }

  Future<List<AddOnPlan>> getAddonPackageList() async {
    final response = await getRequest(getAddonPackageListApi);
    final data = response.data;
    if (data['data'] is List) {
      return (data['data'] as List)
          .map((e) => AddOnPlan.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

@riverpod
PlanRepository planRepository(Ref ref) {
  return PlanRepository(ref.watch(dioProvider));
}
