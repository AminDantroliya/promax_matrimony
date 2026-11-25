import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/matches_models.dart';
import '../../../../utils/api_urls.dart';

part 'matches_repository.g.dart';

class MatchesRepository extends BaseRepository {
  MatchesRepository(super.dio);

  Future<MatchesListResponseModel> getMatches(
    String url,
    Map<String, dynamic> params,
  ) async {
    final response = await postRequest(url, params);
    return MatchesListResponseModel.fromJson(response.data);
  }

  Future<void> addShortlist(String memberId) async {
    await postRequest(shortlistActionApi, {
      "receiver_member_id": memberId,
      "action": "add",
    });
  }

  Future<void> addInterest(String memberId) async {
    await postRequest(sendConnectionApi, {"receiver_member_id": memberId});
  }

  Future<void> blockProfile(String memberId) async {
    await postRequest(blockActionApi, {
      "receiver_member_id": memberId,
      "action": "add",
    });
  }
}

@riverpod
MatchesRepository matchesRepository(Ref ref) {
  return MatchesRepository(ref.watch(dioProvider));
}
