// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchesListResponseModel _$MatchesListResponseModelFromJson(
  Map<String, dynamic> json,
) => _MatchesListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : MatchesData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MatchesListResponseModelToJson(
  _MatchesListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_MatchesData _$MatchesDataFromJson(Map<String, dynamic> json) => _MatchesData(
  resultCount: (_readMatchesResultCount(json, 'resultCount') as num?)?.toInt(),
  resultList: (_readMatchesResultList(json, 'resultList') as List<dynamic>?)
      ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MatchesDataToJson(_MatchesData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };
