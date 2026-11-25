import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

@freezed
abstract class NotificationListResponseModel with _$NotificationListResponseModel {
  const factory NotificationListResponseModel({
    int? code,
    String? status,
    String? message,
    NotificationData? data,
  }) = _NotificationListResponseModel;

  factory NotificationListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseModelFromJson(json);
}

@freezed
abstract class NotificationData with _$NotificationData {
  const factory NotificationData({
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'resultList') List<NotificationItem>? resultList,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

@freezed
abstract class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    dynamic id,
    @JsonKey(name: 'sender_member_id') dynamic senderMemberId,
    @JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,
    @JsonKey(name: 'sender_matri_id') dynamic senderMatriId,
    @JsonKey(name: 'receiver_matri_id') dynamic receiverMatriId,
    dynamic title,
    dynamic message,
    dynamic action,
    @JsonKey(name: 'notication_by') dynamic notificationBy,
    dynamic image,
    @JsonKey(name: 'is_read') dynamic isRead,
    dynamic status,
    @JsonKey(name: 'created_at') dynamic createdAt,
    @JsonKey(name: 'profile_title') dynamic profileTitle,
    @JsonKey(name: 'sub_title') dynamic subTitle,
    @JsonKey(name: 'profile_image') dynamic profileImage,
    @JsonKey(name: 'is_photo_protected') dynamic isPhotoProtected,
    @JsonKey(name: 'is_shortlisted') dynamic isShortlisted,
    @JsonKey(name: 'is_interest') dynamic isInterest,
    @JsonKey(name: 'isBlocked') dynamic isBlocked,
    @JsonKey(name: 'is_online') dynamic isOnline,
    @JsonKey(name: 'matchPercent') dynamic matchPercent,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(processNotificationItemJson(json));
}

Map<String, dynamic> processNotificationItemJson(Map<String, dynamic> json) {
  final map = Map<String, dynamic>.from(json);
  map['action'] ??= map['type'] ?? map['notification_type'] ?? map['noti_type'];
  map['sender_member_id'] ??= map['viewer_id'] ?? map['sender_id'] ?? map['member_id'];
  map['is_read'] ??= map['read_status'] ?? map['isRead'] ?? map['read'] ?? map['seen'];
  return map;
}
