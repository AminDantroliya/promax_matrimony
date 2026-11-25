import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../preference/session_keys.dart';
import '../../../../services/app_session_service.dart';

part 'member_models.freezed.dart';
part 'member_models.g.dart';

Object? _readSendType(Map json, String key) {
  return json['send_type'] ?? json['type'];
}

Object? _readSentDate(Map json, String key) {
  return json['sent_date'] ?? json['created_at'];
}

Object? _readPhotoProtected(Map json, String key) {
  final val = json['is_photoProtected'] ?? json['is_photo_protected'];
  if (val is bool) {
    return val ? 1 : 0;
  }
  return val;
}

Object? _readEducationDetails(Map json, String key) {
  if (json['education_details'] != null &&
      json['education_details'].toString().trim().isNotEmpty) {
    return json['education_details'];
  }
  if (json['sender'] is Map &&
      json['sender']['education_details'] != null &&
      json['sender']['education_details'].toString().trim().isNotEmpty) {
    return json['sender']['education_details'];
  }
  if (json['receiver'] is Map &&
      json['receiver']['education_details'] != null &&
      json['receiver']['education_details'].toString().trim().isNotEmpty) {
    return json['receiver']['education_details'];
  }
  return json['education_details'];
}

Object? _readCanSendReminder(Map json, String key) {
  final val = json['can_send_reminder'];
  if (val == null) return false;
  if (val is bool) return val;
  if (val is num) return val == 1;
  final str = val.toString().toLowerCase().trim();
  return str == 'true' || str == '1';
}

Object? _readStringSafe(Map json, String key) {
  final val = json[key];
  if (val == null) return null;
  return val.toString();
}

Object? _readIntSafe(Map json, String key) {
  final val = json[key];
  if (val == null) return null;
  if (val is int) return val;
  if (val is num) return val.toInt();
  return int.tryParse(val.toString());
}

Object? _readPendingReminderCount(Map json, String key) {
  final val = json['pending_reminder_count'];
  if (val == null) return 0;
  if (val is int) return val;
  if (val is num) return val.toInt();
  return int.tryParse(val.toString()) ?? 0;
}

Object? _readMemberId(Map json, String key) {
  if (json['member_id'] != null) return json['member_id'];

  final currentUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
  final receiverId = (json['receiver'] is Map ? json['receiver']['id'] : null) ?? json['receiver_member_id'];
  final senderId = (json['sender'] is Map ? json['sender']['id'] : null) ?? json['sender_member_id'];

  if (currentUserId != null && currentUserId.isNotEmpty) {
    if (receiverId?.toString() == currentUserId && senderId != null) {
      return senderId;
    }
    if (senderId?.toString() == currentUserId && receiverId != null) {
      return receiverId;
    }
  }

  if (json['receiver'] != null && json['receiver'] is Map) {
    return json['receiver']['id'] ?? json['receiver_member_id'];
  }
  if (json['sender'] != null && json['sender'] is Map) {
    return json['sender']['id'] ?? json['sender_member_id'];
  }
  return json['receiver_member_id'] ?? json['sender_member_id'] ?? json['id'];
}

Object? _readCountryName(Map json, String key) {
  if (json['country_data'] is Map && json['country_data']['country_name'] != null) {
    final val = json['country_data']['country_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['country_name'] != null) {
    final val = json['country_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  final co = json['country_id'] ?? json['country'];
  if (co != null) {
    final val = co.toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['sub_title'] is String) {
    final parts = (json['sub_title'] as String).split(',');
    if (parts.length > 5) {
      final val = parts[5].trim();
      if (val.isNotEmpty && int.tryParse(val) == null) return val;
    }
  }
  return null;
}

Object? _readStateName(Map json, String key) {
  if (json['state_data'] is Map && json['state_data']['state_name'] != null) {
    final val = json['state_data']['state_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['state_name'] != null) {
    final val = json['state_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  final st = json['state_id'] ?? json['state'];
  if (st != null) {
    final val = st.toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['sub_title'] is String) {
    final parts = (json['sub_title'] as String).split(',');
    if (parts.length > 4) {
      final val = parts[4].trim();
      if (val.isNotEmpty && int.tryParse(val) == null) return val;
    }
  }
  return null;
}

Object? _readCityName(Map json, String key) {
  if (json['city_data'] is Map && json['city_data']['city_name'] != null) {
    final val = json['city_data']['city_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['city_name'] != null) {
    final val = json['city_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  final ct = json['city_id'] ?? json['city'];
  if (ct != null) {
    final val = ct.toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['sub_title'] is String) {
    final parts = (json['sub_title'] as String).split(',');
    if (parts.length > 3) {
      final val = parts[3].trim();
      if (val.isNotEmpty && int.tryParse(val) == null) return val;
    }
  }
  return null;
}

Object? _readReligion(Map json, String key) {
  if (json['religion_data'] is Map && json['religion_data']['religion_name'] != null) {
    final val = json['religion_data']['religion_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['religion_name'] != null) {
    final val = json['religion_name'].toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  final rel = json['religion'];
  if (rel != null) {
    final val = rel.toString().trim();
    if (val.isNotEmpty && int.tryParse(val) == null) return val;
  }
  if (json['sub_title'] is String) {
    final parts = (json['sub_title'] as String).split(',');
    if (parts.length > 2) {
      final val = parts[2].trim();
      if (val.isNotEmpty && int.tryParse(val) == null) return val;
    }
  }
  return null;
}

Object? _readPlanStatus(Map json, String key) {
  final val = json['plan_status'] ?? json['planStatus'];
  if (val != null && val.toString().trim().isNotEmpty) return val;
  if (json['sender'] is Map && json['sender']['plan_status'] != null) {
    return json['sender']['plan_status'];
  }
  if (json['receiver'] is Map && json['receiver']['plan_status'] != null) {
    return json['receiver']['plan_status'];
  }
  return val;
}

@freezed
abstract class MemberListModel with _$MemberListModel {
  const factory MemberListModel({
    dynamic id,
    @JsonKey(name: 'member_id', readValue: _readMemberId) dynamic memberId,
    @JsonKey(name: 'matri_id') dynamic matriId,
    dynamic fullname,
    dynamic gender,
    dynamic birthdate,
    @JsonKey(name: 'country_name', readValue: _readCountryName) dynamic countryName,
    @JsonKey(name: 'state_name', readValue: _readStateName) dynamic stateName,
    @JsonKey(name: 'city_name', readValue: _readCityName) dynamic cityName,
    @JsonKey(name: 'plan_name') dynamic planName,
    @JsonKey(name: 'plan_status', readValue: _readPlanStatus) dynamic planStatus,
    dynamic photo1,
    @JsonKey(name: 'photo1_status') dynamic photo1Status,
    dynamic photo2,
    @JsonKey(name: 'photo2_status') dynamic photo2Status,
    dynamic photo3,
    @JsonKey(name: 'photo3_status') dynamic photo3Status,
    dynamic photo4,
    @JsonKey(name: 'photo4_status') dynamic photo4Status,
    @JsonKey(name: 'photo_visibility') dynamic photoVisibility,
    @JsonKey(name: 'block_profile_id') dynamic blockProfileId,
    @JsonKey(name: 'profile_title') dynamic profileTitle,
    @JsonKey(name: 'religion', readValue: _readReligion) dynamic religion,
    @JsonKey(name: 'sub_title') dynamic subTitle,
    @JsonKey(name: 'interest_state', readValue: _readStringSafe) String? interestState,
    @JsonKey(name: 'interest_status', readValue: _readStringSafe) String? interestStatus,
    @JsonKey(name: 'interest_id') dynamic interestId,
    @JsonKey(name: 'total_reminder_count', readValue: _readIntSafe) int? totalReminderCount,
    @JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount) int? pendingReminderCount,
    @JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder) bool? canSendReminder,
    @JsonKey(name: 'is_shortlisted') dynamic isShortlisted,
    @JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected) dynamic isPhotoProtected,
    @JsonKey(name: 'profile_image') dynamic profileImage,
    @JsonKey(name: 'receiver_response') dynamic receiverResponse,
    @JsonKey(name: 'is_block') dynamic isBlock,
    @JsonKey(name: 'sender_member_id') dynamic senderMemberId,
    @JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,
    @JsonKey(name: 'active_call_minute') dynamic activeCallMinute,
    @JsonKey(name: 'sent_date', readValue: _readSentDate) dynamic sentDate,
    @JsonKey(name: 'sender_matri_id') dynamic senderMatriId,
    @JsonKey(name: 'receiver_matri_id') dynamic receiverMatriId,
    dynamic sender,
    dynamic receiver,
    @JsonKey(name: 'matchPercent') dynamic matchPercent,
    @JsonKey(name: 'is_online') dynamic isOnline,
    @JsonKey(name: 'is_online_text') dynamic isOnlineText,
    @JsonKey(name: 'mobile_verify_status') dynamic mobileVerifyStatus,
    @JsonKey(name: 'id_proof_status') dynamic idProofStatus,
    @JsonKey(name: 'education_details', readValue: _readEducationDetails) dynamic educationDetails,
    @JsonKey(name: 'send_type', readValue: _readSendType) dynamic sendType,
    @JsonKey(name: 'response') dynamic response,
    @JsonKey(name: 'video_call_setting') dynamic videoCallSetting,
    @JsonKey(name: 'voice_call_setting') dynamic voiceCallSetting,
  }) = _MemberListModel;

  factory MemberListModel.fromJson(Map<String, dynamic> json) =>
      _$MemberListModelFromJson(json);
}
