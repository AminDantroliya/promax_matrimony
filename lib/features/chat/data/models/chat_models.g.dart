// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMemberListResponseModel _$ChatMemberListResponseModelFromJson(
  Map<String, dynamic> json,
) => _ChatMemberListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : ChatMemberListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatMemberListResponseModelToJson(
  _ChatMemberListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_ChatMemberListData _$ChatMemberListDataFromJson(Map<String, dynamic> json) =>
    _ChatMemberListData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultList: (json['resultList'] as List<dynamic>?)
          ?.map((e) => ChatMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMemberListDataToJson(_ChatMemberListData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_ChatMember _$ChatMemberFromJson(Map<String, dynamic> json) => _ChatMember(
  id: (json['id'] as num?)?.toInt(),
  member1Id: (json['member1_id'] as num?)?.toInt(),
  member1MatriId: json['member1_matri_id'] as String?,
  member2Id: (json['member2_id'] as num?)?.toInt(),
  member2MatriId: json['member2_matri_id'] as String?,
  member1Block: json['member1_block'] as bool?,
  member2Block: json['member2_block'] as bool?,
  lastMessageDate: json['last_message_date'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  deletedAt: json['deleted_at'] as String?,
  lastMessage: json['last_message'] as String?,
  profileTitle: json['profile_title'] as String?,
  subTitle: json['sub_title'] as String?,
  profileImage: json['profile_image'] as String?,
  isPhotoProtectedBool: json['is_photo_protected'] as bool?,
  isShortlistedBool: json['is_shortlisted'] as bool?,
  isInterest: json['is_interest'] as bool?,
  isBlocked: json['isBlocked'] as bool?,
  isOnline: json['is_online'] as String?,
  matchPercent: (json['matchPercent'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChatMemberToJson(_ChatMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member1_id': instance.member1Id,
      'member1_matri_id': instance.member1MatriId,
      'member2_id': instance.member2Id,
      'member2_matri_id': instance.member2MatriId,
      'member1_block': instance.member1Block,
      'member2_block': instance.member2Block,
      'last_message_date': instance.lastMessageDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'last_message': instance.lastMessage,
      'profile_title': instance.profileTitle,
      'sub_title': instance.subTitle,
      'profile_image': instance.profileImage,
      'is_photo_protected': instance.isPhotoProtectedBool,
      'is_shortlisted': instance.isShortlistedBool,
      'is_interest': instance.isInterest,
      'isBlocked': instance.isBlocked,
      'is_online': instance.isOnline,
      'matchPercent': instance.matchPercent,
    };

_ChatConversationListResponseModel _$ChatConversationListResponseModelFromJson(
  Map<String, dynamic> json,
) => _ChatConversationListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : ChatConversationData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatConversationListResponseModelToJson(
  _ChatConversationListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_ChatConversationData _$ChatConversationDataFromJson(
  Map<String, dynamic> json,
) => _ChatConversationData(
  conversationId: json['conversation_id'],
  profileTitle: json['profile_title'] as String?,
  subTitle: json['sub_title'] as String?,
  profileImage: json['profile_image'] as String?,
  isPhotoProtectedBool: json['is_photo_protected'] as bool?,
  isBlocked: json['isBlocked'] as bool?,
  isOnline: json['is_online'] as String?,
  isOnlineText: json['is_online_text'] as String?,
  messageListCount: (json['message_list_count'] as num?)?.toInt(),
  messageList: (json['message_list'] as List<dynamic>?)
      ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
  senderMemberId: json['sender_member_id'],
  senderMemberMatriId: json['sender_member_matri_id'] as String?,
  senderMemberPhotoUrl: json['sender_member_photo_url'] as String?,
  senderMemberGender: json['sender_member_gender'] as String?,
  receiverMemberId: json['receiver_member_id'],
  senderBlock: json['sender_block'],
  receiverMemberFullname: json['receiver_member_fullname'] as String?,
  receiverMemberGender: json['receiver_member_gender'] as String?,
  receiverBlock: json['receiver_block'],
  isBlock: (json['is_block'] as num?)?.toInt(),
  requestStatus: json['request_status'] as String?,
  requestedBy: json['requested_by'],
  isChatBlocked: json['is_chat_blocked'] as bool?,
);

Map<String, dynamic> _$ChatConversationDataToJson(
  _ChatConversationData instance,
) => <String, dynamic>{
  'conversation_id': instance.conversationId,
  'profile_title': instance.profileTitle,
  'sub_title': instance.subTitle,
  'profile_image': instance.profileImage,
  'is_photo_protected': instance.isPhotoProtectedBool,
  'isBlocked': instance.isBlocked,
  'is_online': instance.isOnline,
  'is_online_text': instance.isOnlineText,
  'message_list_count': instance.messageListCount,
  'message_list': instance.messageList,
  'sender_member_id': instance.senderMemberId,
  'sender_member_matri_id': instance.senderMemberMatriId,
  'sender_member_photo_url': instance.senderMemberPhotoUrl,
  'sender_member_gender': instance.senderMemberGender,
  'receiver_member_id': instance.receiverMemberId,
  'sender_block': instance.senderBlock,
  'receiver_member_fullname': instance.receiverMemberFullname,
  'receiver_member_gender': instance.receiverMemberGender,
  'receiver_block': instance.receiverBlock,
  'is_block': instance.isBlock,
  'request_status': instance.requestStatus,
  'requested_by': instance.requestedBy,
  'is_chat_blocked': instance.isChatBlocked,
};

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'],
  conversationId: json['conversation_id'],
  senderMemberId: json['sender_member_id'],
  senderMemberMatriId: json['sender_member_matri_id'] as String?,
  receiverMemberId: json['receiver_member_id'],
  receiverMemberMatriId: json['receiver_member_matri_id'] as String?,
  message: json['message'] as String?,
  isRead: json['is_read'] as String?,
  blockedMemberId: json['blocked_member_id'],
  sendOn: json['send_on'] as String?,
  isDeleted: json['is_deleted'] as String?,
  isSender: json['is_sender'] as bool?,
  isReceiver: json['is_receiver'] as bool?,
  chatStatus: (json['chat_status'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'sender_member_id': instance.senderMemberId,
      'sender_member_matri_id': instance.senderMemberMatriId,
      'receiver_member_id': instance.receiverMemberId,
      'receiver_member_matri_id': instance.receiverMemberMatriId,
      'message': instance.message,
      'is_read': instance.isRead,
      'blocked_member_id': instance.blockedMemberId,
      'send_on': instance.sendOn,
      'is_deleted': instance.isDeleted,
      'is_sender': instance.isSender,
      'is_receiver': instance.isReceiver,
      'chat_status': instance.chatStatus,
    };
