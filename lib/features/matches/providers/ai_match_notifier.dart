import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../search/providers/search_notifier.dart';
import '../../search/data/repositories/search_repository.dart';
import '../../common/data/models/member_models.dart';

part 'ai_match_notifier.g.dart';

/// Criteria for the AI matchmaking filter screen
class AiMatchCriteria {
  final String? fromAge;
  final String? toAge;
  final String? fromHeight;
  final String? toHeight;
  final String? maritalStatus;
  final String? motherTongue;
  final String? religion;
  final String? caste;
  final String? countryId;
  final String? educationLevel;
  final int minMatchPercentage;
  final bool withPhoto;
  final bool isTodayBestMatches;

  const AiMatchCriteria({
    this.fromAge,
    this.toAge,
    this.fromHeight,
    this.toHeight,
    this.maritalStatus,
    this.motherTongue,
    this.religion,
    this.caste,
    this.countryId,
    this.educationLevel,
    this.minMatchPercentage = 60,
    this.withPhoto = false,
    this.isTodayBestMatches = false,
  });

  Map<String, dynamic> toParams() {
    final params = <String, dynamic>{};
    if (fromAge != null && fromAge!.isNotEmpty) params['part_frm_age'] = fromAge;
    if (toAge != null && toAge!.isNotEmpty) params['part_to_age'] = toAge;
    if (fromHeight != null && fromHeight!.isNotEmpty) params['part_height'] = fromHeight;
    if (toHeight != null && toHeight!.isNotEmpty) params['part_height_to'] = toHeight;
    if (maritalStatus != null && maritalStatus!.isNotEmpty) params['marital_status'] = maritalStatus;
    if (motherTongue != null && motherTongue!.isNotEmpty) params['mother_tongue'] = motherTongue;
    if (religion != null && religion!.isNotEmpty) params['religion'] = religion;
    if (caste != null && caste!.isNotEmpty) params['caste'] = caste;
    if (countryId != null && countryId!.isNotEmpty) params['country_id'] = countryId;
    if (educationLevel != null && educationLevel!.isNotEmpty) params['education_level'] = educationLevel;
    params['min_match_percentage'] = minMatchPercentage;
    return params;
  }
}

@riverpod
class AiMatchNotifier extends _$AiMatchNotifier {
  @override
  PagingState<MemberListModel> build() => const PagingState();

  Future<void> search(AiMatchCriteria criteria, {bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(isLoading: true, page: 1, items: []);
    } else {
      if (state.isLoadingMore || state.items.length >= state.totalCount) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final repo = ref.read(searchRepositoryProvider);
      final params = {
        'page': isRefresh ? 1 : state.page,
        'limit': 10,
        ...criteria.toParams(),
      };

      final response = criteria.isTodayBestMatches
          ? await repo.getBestMatchesToday()
          : await repo.getAiMatchMakingList(params);
      final newItems = response.data?.resultList ?? [];
      final updatedItems = isRefresh ? newItems : [...state.items, ...newItems];
      final totalCount = updatedItems.isEmpty ? 0 : (response.data?.resultCount ?? 0);

      state = state.copyWith(
        items: updatedItems,
        totalCount: totalCount,
        page: (isRefresh ? 1 : state.page) + 1,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e);
    }
  }

  void updateMemberAction({
    required String memberId,
    bool? isShortlisted,
    bool? isInterested,
    bool? isBlocked,
    String? interestState,
  }) {
    final updatedItems = state.items.map((member) {
      if ((member.id ?? member.memberId).toString() == memberId) {
        return member.copyWith(
          isShortlisted: isShortlisted != null ? (isShortlisted ? 1 : 0) : member.isShortlisted,
          interestState: interestState ?? (isInterested != null ? (isInterested ? 'sent' : 'not_sent') : member.interestState),
          isBlock: isBlocked != null ? (isBlocked ? 1 : 0) : member.isBlock,
        );
      }
      return member;
    }).toList();
    state = state.copyWith(items: updatedItems);
  }
}
