import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/search_models.dart';
import '../../../../utils/api_urls.dart';

part 'search_repository.g.dart';

class SearchRepository extends BaseRepository {
  SearchRepository(super.dio);

  Future<SearchResultListResponseModel> searchMembers(Map<String, dynamic> params) async {
    final response = await postRequest(searchResultListApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<void> saveSearch(Map<String, dynamic> params) async {
    await postRequest(saveSearchApi, params);
  }

  Future<SavedSearchListResponseModel> getSavedSearchList(Map<String, dynamic> params) async {
    final response = await postRequest(getSavedSearchListApi, params);
    return SavedSearchListResponseModel.fromJson(response.data);
  }

  Future<void> deleteSavedSearch(String id) async {
    await postRequest(deleteSavedSearchApi, {"id": id});
  }

  Future<SearchResultListResponseModel> getRecommendedMatches(Map<String, dynamic> params) async {
    final response = await postRequest(getRecommendedMatchesApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getPremiumMatches(Map<String, dynamic> params) async {
    final response = await postRequest(getPremiumMatchesApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getSuggestedMatches(Map<String, dynamic> params) async {
    final response = await postRequest(getSuggestedMatchesApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getPersonalizedAdminMatches(Map<String, dynamic> params) async {
    final response = await postRequest(receiveAdminMatchesApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<void> updateAdminMatchAction(String matchId, String action) async {
    final String actionValue =
        (action == "accept" || action == "1") ? "accept" : "reject";
    await postRequest(acceptRejectAdminMatchesApi, {
      "match_id": int.tryParse(matchId) ?? matchId,
      "action": actionValue,
    });
  }

  Future<SearchResultListResponseModel> getAdminMatches(Map<String, dynamic> params) async {
    final response = await postRequest(getAdminMatchesApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getRecentlyJoinedMatches(Map<String, dynamic> params) async {
    final response = await postRequest(getRecentJoinedListApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getRecentlyLoginMatches(Map<String, dynamic> params) async {
    final response = await postRequest(getRecentLoginListApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getAiMatchMakingList(Map<String, dynamic> params) async {
    final response = await postRequest(aiMatchMakingListApi, params);
    return SearchResultListResponseModel.fromJson(response.data);
  }

  Future<SearchResultListResponseModel> getBestMatchesToday({Map<String, dynamic>? params}) async {
    final response = await getRequest(aiMatchMakingBestMatchesTodayApi, queryParameters: params);
    return SearchResultListResponseModel.fromJson(response.data);
  }
}

@riverpod
SearchRepository searchRepository(Ref ref) {
  return SearchRepository(ref.watch(dioProvider));
}
