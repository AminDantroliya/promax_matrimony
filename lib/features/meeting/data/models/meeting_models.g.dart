// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingListResponse _$MeetingListResponseFromJson(Map<String, dynamic> json) =>
    _MeetingListResponse(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : MeetingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeetingListResponseToJson(
  _MeetingListResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_MeetingData _$MeetingDataFromJson(Map<String, dynamic> json) => _MeetingData(
  resultCount: (json['resultCount'] as num?)?.toInt(),
  resultArr: (_readResultList(json, 'resultArr') as List<dynamic>?)
      ?.map((e) => Meeting.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MeetingDataToJson(_MeetingData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultArr': instance.resultArr,
    };

_Meeting _$MeetingFromJson(Map<String, dynamic> json) => _Meeting(
  memberId: json['member_id'],
  firstName: json['first_name'],
  matriId: json['matri_id'],
  fullname: json['fullname'],
  gender: json['gender'],
  birthdate: json['birthdate'],
  photo1: json['photo1'],
  photo1Status: json['photo1_status'],
  photo2: json['photo2'],
  photo2Status: json['photo2_status'],
  photo3: json['photo3'],
  photo3Status: json['photo3_status'],
  photo4: json['photo4'],
  photo4Status: json['photo4_status'],
  religionName: json['religion_name'],
  cityFullName: json['city_full_name'],
  height: json['height'],
  casteName: json['caste_name'],
  mtongueName: json['mtongue_name'],
  educationName: json['education_name'],
  employeeName: json['employee_name'],
  photoVisibility: json['photo_visibility'],
  status: json['status'],
  countryName: json['country_name'],
  stateName: json['state_name'],
  cityName: json['city_name'],
  profileImage: json['profile_image'],
  profileTitle: json['profile_title'],
  subTitle: json['sub_title'],
  isInterested: json['is_interested'],
  isShortlisted: json['is_shortlisted'],
  isPhotoProtected: json['is_photoProtected'],
  isBlock: json['is_block'],
  id: json['id'],
  member1Id: json['member1_id'],
  member1MatriId: json['member1_matri_id'],
  member2Id: json['member2_id'],
  member2MatriId: json['member2_matri_id'],
  staffId: json['staff_id'],
  dateTime: json['date_time'],
  description: json['description'],
  address: json['address'],
  googleMapLink: json['google_map_link'],
  member1Status: json['member1_status'],
  member1RejectRemark: json['member1_reject_remark'],
  member2Status: json['member2_status'],
  member2RejectRemark: json['member2_reject_remark'],
  member1: json['member1'],
  member2: json['member2'],
  meetingStatus: json['meeting_status'],
  meetingRemark: json['meeting_remark'],
  age: json['age'],
  aadharVerificationStatus: json['id_proof_verify_status'],
);

Map<String, dynamic> _$MeetingToJson(_Meeting instance) => <String, dynamic>{
  'member_id': instance.memberId,
  'first_name': instance.firstName,
  'matri_id': instance.matriId,
  'fullname': instance.fullname,
  'gender': instance.gender,
  'birthdate': instance.birthdate,
  'photo1': instance.photo1,
  'photo1_status': instance.photo1Status,
  'photo2': instance.photo2,
  'photo2_status': instance.photo2Status,
  'photo3': instance.photo3,
  'photo3_status': instance.photo3Status,
  'photo4': instance.photo4,
  'photo4_status': instance.photo4Status,
  'religion_name': instance.religionName,
  'city_full_name': instance.cityFullName,
  'height': instance.height,
  'caste_name': instance.casteName,
  'mtongue_name': instance.mtongueName,
  'education_name': instance.educationName,
  'employee_name': instance.employeeName,
  'photo_visibility': instance.photoVisibility,
  'status': instance.status,
  'country_name': instance.countryName,
  'state_name': instance.stateName,
  'city_name': instance.cityName,
  'profile_image': instance.profileImage,
  'profile_title': instance.profileTitle,
  'sub_title': instance.subTitle,
  'is_interested': instance.isInterested,
  'is_shortlisted': instance.isShortlisted,
  'is_photoProtected': instance.isPhotoProtected,
  'is_block': instance.isBlock,
  'id': instance.id,
  'member1_id': instance.member1Id,
  'member1_matri_id': instance.member1MatriId,
  'member2_id': instance.member2Id,
  'member2_matri_id': instance.member2MatriId,
  'staff_id': instance.staffId,
  'date_time': instance.dateTime,
  'description': instance.description,
  'address': instance.address,
  'google_map_link': instance.googleMapLink,
  'member1_status': instance.member1Status,
  'member1_reject_remark': instance.member1RejectRemark,
  'member2_status': instance.member2Status,
  'member2_reject_remark': instance.member2RejectRemark,
  'member1': instance.member1,
  'member2': instance.member2,
  'meeting_status': instance.meetingStatus,
  'meeting_remark': instance.meetingRemark,
  'age': instance.age,
  'id_proof_verify_status': instance.aadharVerificationStatus,
};
