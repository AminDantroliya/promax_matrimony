import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_interest_models.freezed.dart';
part 'ai_interest_models.g.dart';

// ─── Settings Update Response ────────────────────────────────────────────────

@freezed
abstract class AiInterestSettingsResponse with _$AiInterestSettingsResponse {
  const factory AiInterestSettingsResponse({
    int? code,
    String? status,
    String? message,
  }) = _AiInterestSettingsResponse;

  factory AiInterestSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$AiInterestSettingsResponseFromJson(json);
}

// ─── Today's AI Match List ────────────────────────────────────────────────────

@freezed
abstract class AiInterestListResponse with _$AiInterestListResponse {
  const factory AiInterestListResponse({
    int? code,
    String? status,
    String? message,
    AiInterestListData? data,
  }) = _AiInterestListResponse;

  factory AiInterestListResponse.fromJson(Map<String, dynamic> json) =>
      _$AiInterestListResponseFromJson(json);
}

@freezed
abstract class AiInterestListData with _$AiInterestListData {
  const factory AiInterestListData({
    int? resultCount,
    @JsonKey(name: 'resultList') List<AiInterestMatch>? resultList,
  }) = _AiInterestListData;

  factory AiInterestListData.fromJson(Map<String, dynamic> json) =>
      _$AiInterestListDataFromJson(json);
}

@freezed
abstract class AiInterestMatch with _$AiInterestMatch {
  const factory AiInterestMatch({
    int? id,
    @JsonKey(name: 'member_id') int? memberId,
    @JsonKey(name: 'matched_member_id') int? matchedMemberId,
    int? score,
    @JsonKey(name: 'match_date') String? matchDate,
    @JsonKey(name: 'queue_status') bool? queueStatus,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'profile_title') String? profileTitle,
    @JsonKey(name: 'sub_title') String? subTitle,
    @JsonKey(name: 'profile_image') String? profileImage,
    @JsonKey(name: 'is_photo_protected') bool? isPhotoProtected,
    @JsonKey(name: 'is_shortlisted') bool? isShortlisted,
    @JsonKey(name: 'is_interest') bool? isInterest,
    @JsonKey(name: 'isBlocked') bool? isBlocked,
    @JsonKey(name: 'is_online') String? isOnline,
    @JsonKey(name: 'is_online_text') String? isOnlineText,
    @JsonKey(name: 'matchPercent') dynamic matchPercent,
    @JsonKey(name: 'matched_member') Map<String, dynamic>? matchedMember,
  }) = _AiInterestMatch;

  factory AiInterestMatch.fromJson(Map<String, dynamic> json) =>
      _$AiInterestMatchFromJson(json);
}
