import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../services/app_session_service.dart';
import '../../../../preference/session_keys.dart';
import '../../../../utils/utils.dart';

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

@freezed
abstract class ChatMemberListResponseModel with _$ChatMemberListResponseModel {
  const factory ChatMemberListResponseModel({
    int? code,
    String? status,
    String? message,
    ChatMemberListData? data,
  }) = _ChatMemberListResponseModel;

  factory ChatMemberListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberListResponseModelFromJson(json);
}

@freezed
abstract class ChatMemberListData with _$ChatMemberListData {
  const factory ChatMemberListData({
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'resultList') List<ChatMember>? resultList,
  }) = _ChatMemberListData;

  factory ChatMemberListData.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberListDataFromJson(json);
}

@freezed
abstract class ChatMember with _$ChatMember {
  const ChatMember._();

  const factory ChatMember({
    int? id,
    @JsonKey(name: 'member1_id') int? member1Id,
    @JsonKey(name: 'member1_matri_id') String? member1MatriId,
    @JsonKey(name: 'member2_id') int? member2Id,
    @JsonKey(name: 'member2_matri_id') String? member2MatriId,
    @JsonKey(name: 'member1_block') bool? member1Block,
    @JsonKey(name: 'member2_block') bool? member2Block,
    @JsonKey(name: 'last_message_date') String? lastMessageDate,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'profile_title') String? profileTitle,
    @JsonKey(name: 'sub_title') String? subTitle,
    @JsonKey(name: 'profile_image') String? profileImage,
    @JsonKey(name: 'is_photo_protected') bool? isPhotoProtectedBool,
    @JsonKey(name: 'is_shortlisted') bool? isShortlistedBool,
    @JsonKey(name: 'is_interest') bool? isInterest,
    @JsonKey(name: 'isBlocked') bool? isBlocked,
    @JsonKey(name: 'is_online') String? isOnline,
    @JsonKey(name: 'matchPercent') int? matchPercent,
  }) = _ChatMember;

  factory ChatMember.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberFromJson(json);

  dynamic get memberId {
    final currentUserIdStr = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    final currentUserId = int.tryParse(currentUserIdStr ?? '');
    if (currentUserId != null) {
      if (member1Id == currentUserId) {
        return member2Id;
      } else if (member2Id == currentUserId) {
        return member1Id;
      }
    } else if (currentUserIdStr != null && currentUserIdStr.isNotEmpty) {
      if (member1Id?.toString() == currentUserIdStr) {
        return member2Id;
      } else if (member2Id?.toString() == currentUserIdStr) {
        return member1Id;
      }
    }
    return member2Id ?? member1Id ?? id;
  }

  String? get fullname => profileTitle;

  String? get lastMessageText => lastMessage;

  String? get lastMessageTime {
    if (lastMessageDate == null || lastMessageDate!.isEmpty) return null;
    try {
      return getFormattedChatDate(lastMessageDate!);
    } catch (_) {
      return lastMessageDate;
    }
  }

  String? get memberOnlineStatus {
    if (isOnline?.toLowerCase() == "online") {
      return "Online";
    }
    return isOnline;
  }

  int? get isPhotoProtected => isPhotoProtectedBool == true ? 1 : 0;
  
  int? get isShortlisted => isShortlistedBool == true ? 1 : 0;

  int? get unreadMessageCount => null;
}

@freezed
abstract class ChatConversationListResponseModel with _$ChatConversationListResponseModel {
  const factory ChatConversationListResponseModel({
    int? code,
    String? status,
    String? message,
    ChatConversationData? data,
  }) = _ChatConversationListResponseModel;

  factory ChatConversationListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationListResponseModelFromJson(json);
}

@freezed
abstract class ChatConversationData with _$ChatConversationData {
  const ChatConversationData._();

  const factory ChatConversationData({
    @JsonKey(name: 'conversation_id') dynamic conversationId,
    @JsonKey(name: 'profile_title') String? profileTitle,
    @JsonKey(name: 'sub_title') String? subTitle,
    @JsonKey(name: 'profile_image') String? profileImage,
    @JsonKey(name: 'is_photo_protected') bool? isPhotoProtectedBool,
    @JsonKey(name: 'isBlocked') bool? isBlocked,
    @JsonKey(name: 'is_online') String? isOnline,
    @JsonKey(name: 'is_online_text') String? isOnlineText,
    @JsonKey(name: 'message_list_count') int? messageListCount,
    @JsonKey(name: 'message_list') List<ChatMessage>? messageList,
    
    // Legacy fields kept for parsing compatibility
    @JsonKey(name: 'sender_member_id') dynamic senderMemberId,
    @JsonKey(name: 'sender_member_matri_id') String? senderMemberMatriId,
    @JsonKey(name: 'sender_member_photo_url') String? senderMemberPhotoUrl,
    @JsonKey(name: 'sender_member_gender') String? senderMemberGender,
    @JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,
    @JsonKey(name: 'sender_block') dynamic senderBlock,
    @JsonKey(name: 'receiver_member_fullname') String? receiverMemberFullname,
    @JsonKey(name: 'receiver_member_gender') String? receiverMemberGender,
    @JsonKey(name: 'receiver_block') dynamic receiverBlock,
    @JsonKey(name: 'is_block') int? isBlock,
    // Chat request fields
    @JsonKey(name: 'request_status') String? requestStatus,
    @JsonKey(name: 'requested_by') dynamic requestedBy,
    @JsonKey(name: 'is_chat_blocked') bool? isChatBlocked,
  }) = _ChatConversationData;

  factory ChatConversationData.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationDataFromJson(json);

  String? get receiverOnlineStatus => isOnline;
  
  String? get receiverMemberMatriId => profileTitle;
  
  String? get receiverMemberPhotoUrl => profileImage;

  int? get receiverPhotoVisibility => (isPhotoProtectedBool == true) ? 0 : 1;
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    dynamic id,
    @JsonKey(name: 'conversation_id') dynamic conversationId,
    @JsonKey(name: 'sender_member_id') dynamic senderMemberId,
    @JsonKey(name: 'sender_member_matri_id') String? senderMemberMatriId,
    @JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,
    @JsonKey(name: 'receiver_member_matri_id') String? receiverMemberMatriId,
    String? message,
    @JsonKey(name: 'is_read') String? isRead,
    @JsonKey(name: 'blocked_member_id') dynamic blockedMemberId,
    @JsonKey(name: 'send_on') String? sendOn,
    @JsonKey(name: 'is_deleted') String? isDeleted,
    @JsonKey(name: 'is_sender') bool? isSender,
    @JsonKey(name: 'is_receiver') bool? isReceiver,
    @JsonKey(name: 'chat_status') int? chatStatus,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

extension ChatMessageExtension on ChatMessage {
  bool get isMessageReceiver {
    final currentUserIdStr = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (currentUserIdStr != null && senderMemberId != null) {
      return senderMemberId.toString() != currentUserIdStr;
    }
    return isReceiver ?? false;
  }

  bool get isMessageSender {
    final currentUserIdStr = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (currentUserIdStr != null && senderMemberId != null) {
      return senderMemberId.toString() == currentUserIdStr;
    }
    return isSender ?? false;
  }
}
