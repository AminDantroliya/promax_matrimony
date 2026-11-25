// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationListResponseModel _$NotificationListResponseModelFromJson(
  Map<String, dynamic> json,
) => _NotificationListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : NotificationData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NotificationListResponseModelToJson(
  _NotificationListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    _NotificationData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultList: (json['resultList'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationDataToJson(_NotificationData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    _NotificationItem(
      id: json['id'],
      senderMemberId: json['sender_member_id'],
      receiverMemberId: json['receiver_member_id'],
      senderMatriId: json['sender_matri_id'],
      receiverMatriId: json['receiver_matri_id'],
      title: json['title'],
      message: json['message'],
      action: json['action'],
      notificationBy: json['notication_by'],
      image: json['image'],
      isRead: json['is_read'],
      status: json['status'],
      createdAt: json['created_at'],
      profileTitle: json['profile_title'],
      subTitle: json['sub_title'],
      profileImage: json['profile_image'],
      isPhotoProtected: json['is_photo_protected'],
      isShortlisted: json['is_shortlisted'],
      isInterest: json['is_interest'],
      isBlocked: json['isBlocked'],
      isOnline: json['is_online'],
      matchPercent: json['matchPercent'],
    );

Map<String, dynamic> _$NotificationItemToJson(_NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_member_id': instance.senderMemberId,
      'receiver_member_id': instance.receiverMemberId,
      'sender_matri_id': instance.senderMatriId,
      'receiver_matri_id': instance.receiverMatriId,
      'title': instance.title,
      'message': instance.message,
      'action': instance.action,
      'notication_by': instance.notificationBy,
      'image': instance.image,
      'is_read': instance.isRead,
      'status': instance.status,
      'created_at': instance.createdAt,
      'profile_title': instance.profileTitle,
      'sub_title': instance.subTitle,
      'profile_image': instance.profileImage,
      'is_photo_protected': instance.isPhotoProtected,
      'is_shortlisted': instance.isShortlisted,
      'is_interest': instance.isInterest,
      'isBlocked': instance.isBlocked,
      'is_online': instance.isOnline,
      'matchPercent': instance.matchPercent,
    };
