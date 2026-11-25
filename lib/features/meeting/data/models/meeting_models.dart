import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_models.freezed.dart';
part 'meeting_models.g.dart';

Object? _readResultList(Map json, String key) {
  return json['resultArr'] ?? json['resultList'];
}

@freezed
abstract class MeetingListResponse with _$MeetingListResponse {
  const factory MeetingListResponse({
    int? code,
    String? status,
    String? message,
    MeetingData? data,
  }) = _MeetingListResponse;

  factory MeetingListResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingListResponseFromJson(json);
}

@freezed
abstract class MeetingData with _$MeetingData {
  const factory MeetingData({
    int? resultCount,
    @JsonKey(name: 'resultArr', readValue: _readResultList) List<Meeting>? resultArr,
  }) = _MeetingData;

  factory MeetingData.fromJson(Map<String, dynamic> json) =>
      _$MeetingDataFromJson(json);
}

@freezed
abstract class Meeting with _$Meeting {
  const factory Meeting({
    @JsonKey(name: 'member_id') dynamic memberId,
    @JsonKey(name: 'first_name') dynamic firstName,
    @JsonKey(name: 'matri_id') dynamic matriId,
    dynamic fullname,
    dynamic gender,
    dynamic birthdate,
    dynamic photo1,
    @JsonKey(name: 'photo1_status') dynamic photo1Status,
    dynamic photo2,
    @JsonKey(name: 'photo2_status') dynamic photo2Status,
    dynamic photo3,
    @JsonKey(name: 'photo3_status') dynamic photo3Status,
    dynamic photo4,
    @JsonKey(name: 'photo4_status') dynamic photo4Status,
    @JsonKey(name: 'religion_name') dynamic religionName,
    @JsonKey(name: 'city_full_name') dynamic cityFullName,
    dynamic height,
    @JsonKey(name: 'caste_name') dynamic casteName,
    @JsonKey(name: 'mtongue_name') dynamic mtongueName,
    @JsonKey(name: 'education_name') dynamic educationName,
    @JsonKey(name: 'employee_name') dynamic employeeName,
    @JsonKey(name: 'photo_visibility') dynamic photoVisibility,
    dynamic status,
    @JsonKey(name: 'country_name') dynamic countryName,
    @JsonKey(name: 'state_name') dynamic stateName,
    @JsonKey(name: 'city_name') dynamic cityName,
    @JsonKey(name: 'profile_image') dynamic profileImage,
    @JsonKey(name: 'profile_title') dynamic profileTitle,
    @JsonKey(name: 'sub_title') dynamic subTitle,
    @JsonKey(name: 'is_interested') dynamic isInterested,
    @JsonKey(name: 'is_shortlisted') dynamic isShortlisted,
    @JsonKey(name: 'is_photoProtected') dynamic isPhotoProtected,
    @JsonKey(name: 'is_block') dynamic isBlock,
    dynamic id,
    @JsonKey(name: 'member1_id') dynamic member1Id,
    @JsonKey(name: 'member1_matri_id') dynamic member1MatriId,
    @JsonKey(name: 'member2_id') dynamic member2Id,
    @JsonKey(name: 'member2_matri_id') dynamic member2MatriId,
    @JsonKey(name: 'staff_id') dynamic staffId,
    @JsonKey(name: 'date_time') dynamic dateTime,
    dynamic description,
    dynamic address,
    @JsonKey(name: 'google_map_link') dynamic googleMapLink,
    @JsonKey(name: 'member1_status') dynamic member1Status,
    @JsonKey(name: 'member1_reject_remark') dynamic member1RejectRemark,
    @JsonKey(name: 'member2_status') dynamic member2Status,
    @JsonKey(name: 'member2_reject_remark') dynamic member2RejectRemark,
    dynamic member1,
    dynamic member2,
    @JsonKey(name: 'meeting_status') dynamic meetingStatus,
    @JsonKey(name: 'meeting_remark') dynamic meetingRemark,
    dynamic age,
    @JsonKey(name: 'id_proof_verify_status') dynamic aadharVerificationStatus,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
}
