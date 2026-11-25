import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import '../../../../features/activity/data/models/activity_models.dart';

part 'connection_repository.g.dart';

class ConnectionRepository extends BaseRepository {
  ConnectionRepository(super.dio);

  Future<ActivityProfileListResponseModel> getConnections(
    Map<String, dynamic> params,
  ) async {
    final response = await postRequest(getConnectionListApi, params);
    return ActivityProfileListResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> connectionAction(
    Map<String, dynamic> params,
  ) async {
    final response = await postRequest(connectionActionApi, params);
    if (response.object is Map<String, dynamic>) {
      final map = Map<String, dynamic>.from(response.object as Map);
      map['status'] ??= response.status;
      map['message'] ??= response.message;
      return map;
    }
    return response.data;
  }

  Future<Map<String, dynamic>> removeInterest(
    Map<String, dynamic> params,
  ) async {
    final response = await postRequest(removeConnectionApi, params);
    if (response.object is Map<String, dynamic>) {
      final map = Map<String, dynamic>.from(response.object as Map);
      map['status'] ??= response.status;
      map['message'] ??= response.message;
      return map;
    }
    return response.data;
  }
}

@riverpod
ConnectionRepository connectionRepository(Ref ref) {
  return ConnectionRepository(ref.watch(dioProvider));
}
