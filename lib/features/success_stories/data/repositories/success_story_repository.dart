import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import '../models/success_story_models.dart';

part 'success_story_repository.g.dart';

class SuccessStoryRepository extends BaseRepository {
  SuccessStoryRepository(super.dio);

  Future<SuccessStoryListResponseModel> getSuccessStoryList(Map<String, dynamic> params) async {
    final response = await postRequest(getSuccessStoryListApi, params);
    return SuccessStoryListResponseModel.fromJson(response.data);
  }

  Future<SuccessStoryDetailsResponseModel> getSuccessStoryDetails(Map<String, dynamic> params) async {
    final response = await postRequest(getSuccessStoryDetailsApi, params);
    return SuccessStoryDetailsResponseModel.fromJson(response.data);
  }

  Future<ApiResponse> addSuccessStory(FormData formData) async {
    return await postMultipartRequest(addSuccessStoryApi, formData);
  }
}

@riverpod
SuccessStoryRepository successStoryRepository(Ref ref) {
  return SuccessStoryRepository(ref.watch(dioProvider));
}
