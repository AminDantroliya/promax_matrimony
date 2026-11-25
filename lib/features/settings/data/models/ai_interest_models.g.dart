// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_interest_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiInterestSettingsResponse _$AiInterestSettingsResponseFromJson(
  Map<String, dynamic> json,
) => _AiInterestSettingsResponse(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$AiInterestSettingsResponseToJson(
  _AiInterestSettingsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
};

_AiInterestListResponse _$AiInterestListResponseFromJson(
  Map<String, dynamic> json,
) => _AiInterestListResponse(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : AiInterestListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AiInterestListResponseToJson(
  _AiInterestListResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_AiInterestListData _$AiInterestListDataFromJson(Map<String, dynamic> json) =>
    _AiInterestListData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultList: (json['resultList'] as List<dynamic>?)
          ?.map((e) => AiInterestMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AiInterestListDataToJson(_AiInterestListData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_AiInterestMatch _$AiInterestMatchFromJson(Map<String, dynamic> json) =>
    _AiInterestMatch(
      id: (json['id'] as num?)?.toInt(),
      memberId: (json['member_id'] as num?)?.toInt(),
      matchedMemberId: (json['matched_member_id'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      matchDate: json['match_date'] as String?,
      queueStatus: json['queue_status'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      profileTitle: json['profile_title'] as String?,
      subTitle: json['sub_title'] as String?,
      profileImage: json['profile_image'] as String?,
      isPhotoProtected: json['is_photo_protected'] as bool?,
      isShortlisted: json['is_shortlisted'] as bool?,
      isInterest: json['is_interest'] as bool?,
      isBlocked: json['isBlocked'] as bool?,
      isOnline: json['is_online'] as String?,
      isOnlineText: json['is_online_text'] as String?,
      matchPercent: json['matchPercent'],
      matchedMember: json['matched_member'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AiInterestMatchToJson(_AiInterestMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'matched_member_id': instance.matchedMemberId,
      'score': instance.score,
      'match_date': instance.matchDate,
      'queue_status': instance.queueStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'profile_title': instance.profileTitle,
      'sub_title': instance.subTitle,
      'profile_image': instance.profileImage,
      'is_photo_protected': instance.isPhotoProtected,
      'is_shortlisted': instance.isShortlisted,
      'is_interest': instance.isInterest,
      'isBlocked': instance.isBlocked,
      'is_online': instance.isOnline,
      'is_online_text': instance.isOnlineText,
      'matchPercent': instance.matchPercent,
      'matched_member': instance.matchedMember,
    };
