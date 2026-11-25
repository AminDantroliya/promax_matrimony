// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityProfileListResponseModel _$ActivityProfileListResponseModelFromJson(
  Map<String, dynamic> json,
) => _ActivityProfileListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : ActivityData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActivityProfileListResponseModelToJson(
  _ActivityProfileListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_ActivityData _$ActivityDataFromJson(Map<String, dynamic> json) =>
    _ActivityData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultArr: (_readResultList(json, 'resultArr') as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sentCount: (json['sentCount'] as num?)?.toInt(),
      receivedCount: (json['receivedCount'] as num?)?.toInt(),
      acceptedCount: (json['acceptedCount'] as num?)?.toInt(),
      pendingReceivedCount: (json['pendingReceivedCount'] as num?)?.toInt(),
      incomingCount: (json['incomingCount'] as num?)?.toInt(),
      outgoingCount: (json['outgoingCount'] as num?)?.toInt(),
      missedCount: (json['missedCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActivityDataToJson(_ActivityData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultArr': instance.resultArr,
      'sentCount': instance.sentCount,
      'receivedCount': instance.receivedCount,
      'acceptedCount': instance.acceptedCount,
      'pendingReceivedCount': instance.pendingReceivedCount,
      'incomingCount': instance.incomingCount,
      'outgoingCount': instance.outgoingCount,
      'missedCount': instance.missedCount,
    };
