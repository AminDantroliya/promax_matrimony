import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../models/dashboard_models.dart';
import '../../../../utils/api_urls.dart';

part 'home_repository.g.dart';

class HomeRepository extends BaseRepository {
  HomeRepository(super.dio);

  Future<DashboardResponseModel> getDashboardData() async {
    final response = await getRequest(getDashboardDataApi);
    return DashboardResponseModel(
      status: response.status,
      message: response.message,
      data: response.status == "success" ? DashboardData.fromJson(response.object) : null,
    );
  }

  Future<void> updateCallHistory(Map<String, dynamic> params) async {
    await postRequest(updateCallHistoryApi, params);
  }

  Future<void> updateLatLong(Map<String, dynamic> params) async {
    await postRequest(updateLatLongApi, params);
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(ref.watch(dioProvider));
}
