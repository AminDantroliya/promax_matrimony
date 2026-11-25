// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberListModel {

 dynamic get id;@JsonKey(name: 'member_id', readValue: _readMemberId) dynamic get memberId;@JsonKey(name: 'matri_id') dynamic get matriId; dynamic get fullname; dynamic get gender; dynamic get birthdate;@JsonKey(name: 'country_name', readValue: _readCountryName) dynamic get countryName;@JsonKey(name: 'state_name', readValue: _readStateName) dynamic get stateName;@JsonKey(name: 'city_name', readValue: _readCityName) dynamic get cityName;@JsonKey(name: 'plan_name') dynamic get planName;@JsonKey(name: 'plan_status', readValue: _readPlanStatus) dynamic get planStatus; dynamic get photo1;@JsonKey(name: 'photo1_status') dynamic get photo1Status; dynamic get photo2;@JsonKey(name: 'photo2_status') dynamic get photo2Status; dynamic get photo3;@JsonKey(name: 'photo3_status') dynamic get photo3Status; dynamic get photo4;@JsonKey(name: 'photo4_status') dynamic get photo4Status;@JsonKey(name: 'photo_visibility') dynamic get photoVisibility;@JsonKey(name: 'block_profile_id') dynamic get blockProfileId;@JsonKey(name: 'profile_title') dynamic get profileTitle;@JsonKey(name: 'religion', readValue: _readReligion) dynamic get religion;@JsonKey(name: 'sub_title') dynamic get subTitle;@JsonKey(name: 'interest_state', readValue: _readStringSafe) String? get interestState;@JsonKey(name: 'interest_status', readValue: _readStringSafe) String? get interestStatus;@JsonKey(name: 'interest_id') dynamic get interestId;@JsonKey(name: 'total_reminder_count', readValue: _readIntSafe) int? get totalReminderCount;@JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount) int? get pendingReminderCount;@JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder) bool? get canSendReminder;@JsonKey(name: 'is_shortlisted') dynamic get isShortlisted;@JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected) dynamic get isPhotoProtected;@JsonKey(name: 'profile_image') dynamic get profileImage;@JsonKey(name: 'receiver_response') dynamic get receiverResponse;@JsonKey(name: 'is_block') dynamic get isBlock;@JsonKey(name: 'sender_member_id') dynamic get senderMemberId;@JsonKey(name: 'receiver_member_id') dynamic get receiverMemberId;@JsonKey(name: 'active_call_minute') dynamic get activeCallMinute;@JsonKey(name: 'sent_date', readValue: _readSentDate) dynamic get sentDate;@JsonKey(name: 'sender_matri_id') dynamic get senderMatriId;@JsonKey(name: 'receiver_matri_id') dynamic get receiverMatriId; dynamic get sender; dynamic get receiver;@JsonKey(name: 'matchPercent') dynamic get matchPercent;@JsonKey(name: 'is_online') dynamic get isOnline;@JsonKey(name: 'is_online_text') dynamic get isOnlineText;@JsonKey(name: 'mobile_verify_status') dynamic get mobileVerifyStatus;@JsonKey(name: 'id_proof_status') dynamic get idProofStatus;@JsonKey(name: 'education_details', readValue: _readEducationDetails) dynamic get educationDetails;@JsonKey(name: 'send_type', readValue: _readSendType) dynamic get sendType;@JsonKey(name: 'response') dynamic get response;@JsonKey(name: 'video_call_setting') dynamic get videoCallSetting;@JsonKey(name: 'voice_call_setting') dynamic get voiceCallSetting;
/// Create a copy of MemberListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberListModelCopyWith<MemberListModel> get copyWith => _$MemberListModelCopyWithImpl<MemberListModel>(this as MemberListModel, _$identity);

  /// Serializes this MemberListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberListModel&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.memberId, _this.memberId)&&const DeepCollectionEquality().equals(other.matriId, _this.matriId)&&const DeepCollectionEquality().equals(other.fullname, _this.fullname)&&const DeepCollectionEquality().equals(other.gender, _this.gender)&&const DeepCollectionEquality().equals(other.birthdate, _this.birthdate)&&const DeepCollectionEquality().equals(other.countryName, _this.countryName)&&const DeepCollectionEquality().equals(other.stateName, _this.stateName)&&const DeepCollectionEquality().equals(other.cityName, _this.cityName)&&const DeepCollectionEquality().equals(other.planName, _this.planName)&&const DeepCollectionEquality().equals(other.planStatus, _this.planStatus)&&const DeepCollectionEquality().equals(other.photo1, _this.photo1)&&const DeepCollectionEquality().equals(other.photo1Status, _this.photo1Status)&&const DeepCollectionEquality().equals(other.photo2, _this.photo2)&&const DeepCollectionEquality().equals(other.photo2Status, _this.photo2Status)&&const DeepCollectionEquality().equals(other.photo3, _this.photo3)&&const DeepCollectionEquality().equals(other.photo3Status, _this.photo3Status)&&const DeepCollectionEquality().equals(other.photo4, _this.photo4)&&const DeepCollectionEquality().equals(other.photo4Status, _this.photo4Status)&&const DeepCollectionEquality().equals(other.photoVisibility, _this.photoVisibility)&&const DeepCollectionEquality().equals(other.blockProfileId, _this.blockProfileId)&&const DeepCollectionEquality().equals(other.profileTitle, _this.profileTitle)&&const DeepCollectionEquality().equals(other.religion, _this.religion)&&const DeepCollectionEquality().equals(other.subTitle, _this.subTitle)&&(identical(other.interestState, _this.interestState) || other.interestState == _this.interestState)&&(identical(other.interestStatus, _this.interestStatus) || other.interestStatus == _this.interestStatus)&&const DeepCollectionEquality().equals(other.interestId, _this.interestId)&&(identical(other.totalReminderCount, _this.totalReminderCount) || other.totalReminderCount == _this.totalReminderCount)&&(identical(other.pendingReminderCount, _this.pendingReminderCount) || other.pendingReminderCount == _this.pendingReminderCount)&&(identical(other.canSendReminder, _this.canSendReminder) || other.canSendReminder == _this.canSendReminder)&&const DeepCollectionEquality().equals(other.isShortlisted, _this.isShortlisted)&&const DeepCollectionEquality().equals(other.isPhotoProtected, _this.isPhotoProtected)&&const DeepCollectionEquality().equals(other.profileImage, _this.profileImage)&&const DeepCollectionEquality().equals(other.receiverResponse, _this.receiverResponse)&&const DeepCollectionEquality().equals(other.isBlock, _this.isBlock)&&const DeepCollectionEquality().equals(other.senderMemberId, _this.senderMemberId)&&const DeepCollectionEquality().equals(other.receiverMemberId, _this.receiverMemberId)&&const DeepCollectionEquality().equals(other.activeCallMinute, _this.activeCallMinute)&&const DeepCollectionEquality().equals(other.sentDate, _this.sentDate)&&const DeepCollectionEquality().equals(other.senderMatriId, _this.senderMatriId)&&const DeepCollectionEquality().equals(other.receiverMatriId, _this.receiverMatriId)&&const DeepCollectionEquality().equals(other.sender, _this.sender)&&const DeepCollectionEquality().equals(other.receiver, _this.receiver)&&const DeepCollectionEquality().equals(other.matchPercent, _this.matchPercent)&&const DeepCollectionEquality().equals(other.isOnline, _this.isOnline)&&const DeepCollectionEquality().equals(other.isOnlineText, _this.isOnlineText)&&const DeepCollectionEquality().equals(other.mobileVerifyStatus, _this.mobileVerifyStatus)&&const DeepCollectionEquality().equals(other.idProofStatus, _this.idProofStatus)&&const DeepCollectionEquality().equals(other.educationDetails, _this.educationDetails)&&const DeepCollectionEquality().equals(other.sendType, _this.sendType)&&const DeepCollectionEquality().equals(other.response, _this.response)&&const DeepCollectionEquality().equals(other.videoCallSetting, _this.videoCallSetting)&&const DeepCollectionEquality().equals(other.voiceCallSetting, _this.voiceCallSetting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberListModel;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.memberId),const DeepCollectionEquality().hash(_this.matriId),const DeepCollectionEquality().hash(_this.fullname),const DeepCollectionEquality().hash(_this.gender),const DeepCollectionEquality().hash(_this.birthdate),const DeepCollectionEquality().hash(_this.countryName),const DeepCollectionEquality().hash(_this.stateName),const DeepCollectionEquality().hash(_this.cityName),const DeepCollectionEquality().hash(_this.planName),const DeepCollectionEquality().hash(_this.planStatus),const DeepCollectionEquality().hash(_this.photo1),const DeepCollectionEquality().hash(_this.photo1Status),const DeepCollectionEquality().hash(_this.photo2),const DeepCollectionEquality().hash(_this.photo2Status),const DeepCollectionEquality().hash(_this.photo3),const DeepCollectionEquality().hash(_this.photo3Status),const DeepCollectionEquality().hash(_this.photo4),const DeepCollectionEquality().hash(_this.photo4Status),const DeepCollectionEquality().hash(_this.photoVisibility),const DeepCollectionEquality().hash(_this.blockProfileId),const DeepCollectionEquality().hash(_this.profileTitle),const DeepCollectionEquality().hash(_this.religion),const DeepCollectionEquality().hash(_this.subTitle),_this.interestState,_this.interestStatus,const DeepCollectionEquality().hash(_this.interestId),_this.totalReminderCount,_this.pendingReminderCount,_this.canSendReminder,const DeepCollectionEquality().hash(_this.isShortlisted),const DeepCollectionEquality().hash(_this.isPhotoProtected),const DeepCollectionEquality().hash(_this.profileImage),const DeepCollectionEquality().hash(_this.receiverResponse),const DeepCollectionEquality().hash(_this.isBlock),const DeepCollectionEquality().hash(_this.senderMemberId),const DeepCollectionEquality().hash(_this.receiverMemberId),const DeepCollectionEquality().hash(_this.activeCallMinute),const DeepCollectionEquality().hash(_this.sentDate),const DeepCollectionEquality().hash(_this.senderMatriId),const DeepCollectionEquality().hash(_this.receiverMatriId),const DeepCollectionEquality().hash(_this.sender),const DeepCollectionEquality().hash(_this.receiver),const DeepCollectionEquality().hash(_this.matchPercent),const DeepCollectionEquality().hash(_this.isOnline),const DeepCollectionEquality().hash(_this.isOnlineText),const DeepCollectionEquality().hash(_this.mobileVerifyStatus),const DeepCollectionEquality().hash(_this.idProofStatus),const DeepCollectionEquality().hash(_this.educationDetails),const DeepCollectionEquality().hash(_this.sendType),const DeepCollectionEquality().hash(_this.response),const DeepCollectionEquality().hash(_this.videoCallSetting),const DeepCollectionEquality().hash(_this.voiceCallSetting)]);
}

@override
String toString() {
  final _this = this as MemberListModel;
  return 'MemberListModel(id: ${_this.id}, memberId: ${_this.memberId}, matriId: ${_this.matriId}, fullname: ${_this.fullname}, gender: ${_this.gender}, birthdate: ${_this.birthdate}, countryName: ${_this.countryName}, stateName: ${_this.stateName}, cityName: ${_this.cityName}, planName: ${_this.planName}, planStatus: ${_this.planStatus}, photo1: ${_this.photo1}, photo1Status: ${_this.photo1Status}, photo2: ${_this.photo2}, photo2Status: ${_this.photo2Status}, photo3: ${_this.photo3}, photo3Status: ${_this.photo3Status}, photo4: ${_this.photo4}, photo4Status: ${_this.photo4Status}, photoVisibility: ${_this.photoVisibility}, blockProfileId: ${_this.blockProfileId}, profileTitle: ${_this.profileTitle}, religion: ${_this.religion}, subTitle: ${_this.subTitle}, interestState: ${_this.interestState}, interestStatus: ${_this.interestStatus}, interestId: ${_this.interestId}, totalReminderCount: ${_this.totalReminderCount}, pendingReminderCount: ${_this.pendingReminderCount}, canSendReminder: ${_this.canSendReminder}, isShortlisted: ${_this.isShortlisted}, isPhotoProtected: ${_this.isPhotoProtected}, profileImage: ${_this.profileImage}, receiverResponse: ${_this.receiverResponse}, isBlock: ${_this.isBlock}, senderMemberId: ${_this.senderMemberId}, receiverMemberId: ${_this.receiverMemberId}, activeCallMinute: ${_this.activeCallMinute}, sentDate: ${_this.sentDate}, senderMatriId: ${_this.senderMatriId}, receiverMatriId: ${_this.receiverMatriId}, sender: ${_this.sender}, receiver: ${_this.receiver}, matchPercent: ${_this.matchPercent}, isOnline: ${_this.isOnline}, isOnlineText: ${_this.isOnlineText}, mobileVerifyStatus: ${_this.mobileVerifyStatus}, idProofStatus: ${_this.idProofStatus}, educationDetails: ${_this.educationDetails}, sendType: ${_this.sendType}, response: ${_this.response}, videoCallSetting: ${_this.videoCallSetting}, voiceCallSetting: ${_this.voiceCallSetting})';
}


}

/// @nodoc
abstract mixin class $MemberListModelCopyWith<$Res>  {
  factory $MemberListModelCopyWith(MemberListModel value, $Res Function(MemberListModel) _then) = _$MemberListModelCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'member_id', readValue: _readMemberId) dynamic memberId,@JsonKey(name: 'matri_id') dynamic matriId, dynamic fullname, dynamic gender, dynamic birthdate,@JsonKey(name: 'country_name', readValue: _readCountryName) dynamic countryName,@JsonKey(name: 'state_name', readValue: _readStateName) dynamic stateName,@JsonKey(name: 'city_name', readValue: _readCityName) dynamic cityName,@JsonKey(name: 'plan_name') dynamic planName,@JsonKey(name: 'plan_status', readValue: _readPlanStatus) dynamic planStatus, dynamic photo1,@JsonKey(name: 'photo1_status') dynamic photo1Status, dynamic photo2,@JsonKey(name: 'photo2_status') dynamic photo2Status, dynamic photo3,@JsonKey(name: 'photo3_status') dynamic photo3Status, dynamic photo4,@JsonKey(name: 'photo4_status') dynamic photo4Status,@JsonKey(name: 'photo_visibility') dynamic photoVisibility,@JsonKey(name: 'block_profile_id') dynamic blockProfileId,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'religion', readValue: _readReligion) dynamic religion,@JsonKey(name: 'sub_title') dynamic subTitle,@JsonKey(name: 'interest_state', readValue: _readStringSafe) String? interestState,@JsonKey(name: 'interest_status', readValue: _readStringSafe) String? interestStatus,@JsonKey(name: 'interest_id') dynamic interestId,@JsonKey(name: 'total_reminder_count', readValue: _readIntSafe) int? totalReminderCount,@JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount) int? pendingReminderCount,@JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder) bool? canSendReminder,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected) dynamic isPhotoProtected,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'receiver_response') dynamic receiverResponse,@JsonKey(name: 'is_block') dynamic isBlock,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'active_call_minute') dynamic activeCallMinute,@JsonKey(name: 'sent_date', readValue: _readSentDate) dynamic sentDate,@JsonKey(name: 'sender_matri_id') dynamic senderMatriId,@JsonKey(name: 'receiver_matri_id') dynamic receiverMatriId, dynamic sender, dynamic receiver,@JsonKey(name: 'matchPercent') dynamic matchPercent,@JsonKey(name: 'is_online') dynamic isOnline,@JsonKey(name: 'is_online_text') dynamic isOnlineText,@JsonKey(name: 'mobile_verify_status') dynamic mobileVerifyStatus,@JsonKey(name: 'id_proof_status') dynamic idProofStatus,@JsonKey(name: 'education_details', readValue: _readEducationDetails) dynamic educationDetails,@JsonKey(name: 'send_type', readValue: _readSendType) dynamic sendType,@JsonKey(name: 'response') dynamic response,@JsonKey(name: 'video_call_setting') dynamic videoCallSetting,@JsonKey(name: 'voice_call_setting') dynamic voiceCallSetting
});




}
/// @nodoc
class _$MemberListModelCopyWithImpl<$Res>
    implements $MemberListModelCopyWith<$Res> {
  _$MemberListModelCopyWithImpl(this._self, this._then);

  final MemberListModel _self;
  final $Res Function(MemberListModel) _then;

/// Create a copy of MemberListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? memberId = freezed,Object? matriId = freezed,Object? fullname = freezed,Object? gender = freezed,Object? birthdate = freezed,Object? countryName = freezed,Object? stateName = freezed,Object? cityName = freezed,Object? planName = freezed,Object? planStatus = freezed,Object? photo1 = freezed,Object? photo1Status = freezed,Object? photo2 = freezed,Object? photo2Status = freezed,Object? photo3 = freezed,Object? photo3Status = freezed,Object? photo4 = freezed,Object? photo4Status = freezed,Object? photoVisibility = freezed,Object? blockProfileId = freezed,Object? profileTitle = freezed,Object? religion = freezed,Object? subTitle = freezed,Object? interestState = freezed,Object? interestStatus = freezed,Object? interestId = freezed,Object? totalReminderCount = freezed,Object? pendingReminderCount = freezed,Object? canSendReminder = freezed,Object? isShortlisted = freezed,Object? isPhotoProtected = freezed,Object? profileImage = freezed,Object? receiverResponse = freezed,Object? isBlock = freezed,Object? senderMemberId = freezed,Object? receiverMemberId = freezed,Object? activeCallMinute = freezed,Object? sentDate = freezed,Object? senderMatriId = freezed,Object? receiverMatriId = freezed,Object? sender = freezed,Object? receiver = freezed,Object? matchPercent = freezed,Object? isOnline = freezed,Object? isOnlineText = freezed,Object? mobileVerifyStatus = freezed,Object? idProofStatus = freezed,Object? educationDetails = freezed,Object? sendType = freezed,Object? response = freezed,Object? videoCallSetting = freezed,Object? voiceCallSetting = freezed,}) {
  return _then(MemberListModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,matriId: freezed == matriId ? _self.matriId : matriId // ignore: cast_nullable_to_non_nullable
as dynamic,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as dynamic,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as dynamic,stateName: freezed == stateName ? _self.stateName : stateName // ignore: cast_nullable_to_non_nullable
as dynamic,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as dynamic,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as dynamic,planStatus: freezed == planStatus ? _self.planStatus : planStatus // ignore: cast_nullable_to_non_nullable
as dynamic,photo1: freezed == photo1 ? _self.photo1 : photo1 // ignore: cast_nullable_to_non_nullable
as dynamic,photo1Status: freezed == photo1Status ? _self.photo1Status : photo1Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo2: freezed == photo2 ? _self.photo2 : photo2 // ignore: cast_nullable_to_non_nullable
as dynamic,photo2Status: freezed == photo2Status ? _self.photo2Status : photo2Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo3: freezed == photo3 ? _self.photo3 : photo3 // ignore: cast_nullable_to_non_nullable
as dynamic,photo3Status: freezed == photo3Status ? _self.photo3Status : photo3Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo4: freezed == photo4 ? _self.photo4 : photo4 // ignore: cast_nullable_to_non_nullable
as dynamic,photo4Status: freezed == photo4Status ? _self.photo4Status : photo4Status // ignore: cast_nullable_to_non_nullable
as dynamic,photoVisibility: freezed == photoVisibility ? _self.photoVisibility : photoVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,blockProfileId: freezed == blockProfileId ? _self.blockProfileId : blockProfileId // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,interestState: freezed == interestState ? _self.interestState : interestState // ignore: cast_nullable_to_non_nullable
as String?,interestStatus: freezed == interestStatus ? _self.interestStatus : interestStatus // ignore: cast_nullable_to_non_nullable
as String?,interestId: freezed == interestId ? _self.interestId : interestId // ignore: cast_nullable_to_non_nullable
as dynamic,totalReminderCount: freezed == totalReminderCount ? _self.totalReminderCount : totalReminderCount // ignore: cast_nullable_to_non_nullable
as int?,pendingReminderCount: freezed == pendingReminderCount ? _self.pendingReminderCount : pendingReminderCount // ignore: cast_nullable_to_non_nullable
as int?,canSendReminder: freezed == canSendReminder ? _self.canSendReminder : canSendReminder // ignore: cast_nullable_to_non_nullable
as bool?,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,receiverResponse: freezed == receiverResponse ? _self.receiverResponse : receiverResponse // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,activeCallMinute: freezed == activeCallMinute ? _self.activeCallMinute : activeCallMinute // ignore: cast_nullable_to_non_nullable
as dynamic,sentDate: freezed == sentDate ? _self.sentDate : sentDate // ignore: cast_nullable_to_non_nullable
as dynamic,senderMatriId: freezed == senderMatriId ? _self.senderMatriId : senderMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMatriId: freezed == receiverMatriId ? _self.receiverMatriId : receiverMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as dynamic,receiver: freezed == receiver ? _self.receiver : receiver // ignore: cast_nullable_to_non_nullable
as dynamic,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as dynamic,isOnlineText: freezed == isOnlineText ? _self.isOnlineText : isOnlineText // ignore: cast_nullable_to_non_nullable
as dynamic,mobileVerifyStatus: freezed == mobileVerifyStatus ? _self.mobileVerifyStatus : mobileVerifyStatus // ignore: cast_nullable_to_non_nullable
as dynamic,idProofStatus: freezed == idProofStatus ? _self.idProofStatus : idProofStatus // ignore: cast_nullable_to_non_nullable
as dynamic,educationDetails: freezed == educationDetails ? _self.educationDetails : educationDetails // ignore: cast_nullable_to_non_nullable
as dynamic,sendType: freezed == sendType ? _self.sendType : sendType // ignore: cast_nullable_to_non_nullable
as dynamic,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,videoCallSetting: freezed == videoCallSetting ? _self.videoCallSetting : videoCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,voiceCallSetting: freezed == voiceCallSetting ? _self.voiceCallSetting : voiceCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberListModel].
extension MemberListModelPatterns on MemberListModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberListModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberListModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberListModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberListModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberListModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'member_id', readValue: _readMemberId)  dynamic memberId, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic fullname,  dynamic gender,  dynamic birthdate, @JsonKey(name: 'country_name', readValue: _readCountryName)  dynamic countryName, @JsonKey(name: 'state_name', readValue: _readStateName)  dynamic stateName, @JsonKey(name: 'city_name', readValue: _readCityName)  dynamic cityName, @JsonKey(name: 'plan_name')  dynamic planName, @JsonKey(name: 'plan_status', readValue: _readPlanStatus)  dynamic planStatus,  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status,  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status,  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status,  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility, @JsonKey(name: 'block_profile_id')  dynamic blockProfileId, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'religion', readValue: _readReligion)  dynamic religion, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'interest_state', readValue: _readStringSafe)  String? interestState, @JsonKey(name: 'interest_status', readValue: _readStringSafe)  String? interestStatus, @JsonKey(name: 'interest_id')  dynamic interestId, @JsonKey(name: 'total_reminder_count', readValue: _readIntSafe)  int? totalReminderCount, @JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount)  int? pendingReminderCount, @JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder)  bool? canSendReminder, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected)  dynamic isPhotoProtected, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'receiver_response')  dynamic receiverResponse, @JsonKey(name: 'is_block')  dynamic isBlock, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'active_call_minute')  dynamic activeCallMinute, @JsonKey(name: 'sent_date', readValue: _readSentDate)  dynamic sentDate, @JsonKey(name: 'sender_matri_id')  dynamic senderMatriId, @JsonKey(name: 'receiver_matri_id')  dynamic receiverMatriId,  dynamic sender,  dynamic receiver, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'is_online')  dynamic isOnline, @JsonKey(name: 'is_online_text')  dynamic isOnlineText, @JsonKey(name: 'mobile_verify_status')  dynamic mobileVerifyStatus, @JsonKey(name: 'id_proof_status')  dynamic idProofStatus, @JsonKey(name: 'education_details', readValue: _readEducationDetails)  dynamic educationDetails, @JsonKey(name: 'send_type', readValue: _readSendType)  dynamic sendType, @JsonKey(name: 'response')  dynamic response, @JsonKey(name: 'video_call_setting')  dynamic videoCallSetting, @JsonKey(name: 'voice_call_setting')  dynamic voiceCallSetting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberListModel() when $default != null:
return $default(_that.id,_that.memberId,_that.matriId,_that.fullname,_that.gender,_that.birthdate,_that.countryName,_that.stateName,_that.cityName,_that.planName,_that.planStatus,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.photoVisibility,_that.blockProfileId,_that.profileTitle,_that.religion,_that.subTitle,_that.interestState,_that.interestStatus,_that.interestId,_that.totalReminderCount,_that.pendingReminderCount,_that.canSendReminder,_that.isShortlisted,_that.isPhotoProtected,_that.profileImage,_that.receiverResponse,_that.isBlock,_that.senderMemberId,_that.receiverMemberId,_that.activeCallMinute,_that.sentDate,_that.senderMatriId,_that.receiverMatriId,_that.sender,_that.receiver,_that.matchPercent,_that.isOnline,_that.isOnlineText,_that.mobileVerifyStatus,_that.idProofStatus,_that.educationDetails,_that.sendType,_that.response,_that.videoCallSetting,_that.voiceCallSetting);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'member_id', readValue: _readMemberId)  dynamic memberId, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic fullname,  dynamic gender,  dynamic birthdate, @JsonKey(name: 'country_name', readValue: _readCountryName)  dynamic countryName, @JsonKey(name: 'state_name', readValue: _readStateName)  dynamic stateName, @JsonKey(name: 'city_name', readValue: _readCityName)  dynamic cityName, @JsonKey(name: 'plan_name')  dynamic planName, @JsonKey(name: 'plan_status', readValue: _readPlanStatus)  dynamic planStatus,  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status,  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status,  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status,  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility, @JsonKey(name: 'block_profile_id')  dynamic blockProfileId, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'religion', readValue: _readReligion)  dynamic religion, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'interest_state', readValue: _readStringSafe)  String? interestState, @JsonKey(name: 'interest_status', readValue: _readStringSafe)  String? interestStatus, @JsonKey(name: 'interest_id')  dynamic interestId, @JsonKey(name: 'total_reminder_count', readValue: _readIntSafe)  int? totalReminderCount, @JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount)  int? pendingReminderCount, @JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder)  bool? canSendReminder, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected)  dynamic isPhotoProtected, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'receiver_response')  dynamic receiverResponse, @JsonKey(name: 'is_block')  dynamic isBlock, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'active_call_minute')  dynamic activeCallMinute, @JsonKey(name: 'sent_date', readValue: _readSentDate)  dynamic sentDate, @JsonKey(name: 'sender_matri_id')  dynamic senderMatriId, @JsonKey(name: 'receiver_matri_id')  dynamic receiverMatriId,  dynamic sender,  dynamic receiver, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'is_online')  dynamic isOnline, @JsonKey(name: 'is_online_text')  dynamic isOnlineText, @JsonKey(name: 'mobile_verify_status')  dynamic mobileVerifyStatus, @JsonKey(name: 'id_proof_status')  dynamic idProofStatus, @JsonKey(name: 'education_details', readValue: _readEducationDetails)  dynamic educationDetails, @JsonKey(name: 'send_type', readValue: _readSendType)  dynamic sendType, @JsonKey(name: 'response')  dynamic response, @JsonKey(name: 'video_call_setting')  dynamic videoCallSetting, @JsonKey(name: 'voice_call_setting')  dynamic voiceCallSetting)  $default,) {final _that = this;
switch (_that) {
case _MemberListModel():
return $default(_that.id,_that.memberId,_that.matriId,_that.fullname,_that.gender,_that.birthdate,_that.countryName,_that.stateName,_that.cityName,_that.planName,_that.planStatus,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.photoVisibility,_that.blockProfileId,_that.profileTitle,_that.religion,_that.subTitle,_that.interestState,_that.interestStatus,_that.interestId,_that.totalReminderCount,_that.pendingReminderCount,_that.canSendReminder,_that.isShortlisted,_that.isPhotoProtected,_that.profileImage,_that.receiverResponse,_that.isBlock,_that.senderMemberId,_that.receiverMemberId,_that.activeCallMinute,_that.sentDate,_that.senderMatriId,_that.receiverMatriId,_that.sender,_that.receiver,_that.matchPercent,_that.isOnline,_that.isOnlineText,_that.mobileVerifyStatus,_that.idProofStatus,_that.educationDetails,_that.sendType,_that.response,_that.videoCallSetting,_that.voiceCallSetting);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'member_id', readValue: _readMemberId)  dynamic memberId, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic fullname,  dynamic gender,  dynamic birthdate, @JsonKey(name: 'country_name', readValue: _readCountryName)  dynamic countryName, @JsonKey(name: 'state_name', readValue: _readStateName)  dynamic stateName, @JsonKey(name: 'city_name', readValue: _readCityName)  dynamic cityName, @JsonKey(name: 'plan_name')  dynamic planName, @JsonKey(name: 'plan_status', readValue: _readPlanStatus)  dynamic planStatus,  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status,  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status,  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status,  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility, @JsonKey(name: 'block_profile_id')  dynamic blockProfileId, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'religion', readValue: _readReligion)  dynamic religion, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'interest_state', readValue: _readStringSafe)  String? interestState, @JsonKey(name: 'interest_status', readValue: _readStringSafe)  String? interestStatus, @JsonKey(name: 'interest_id')  dynamic interestId, @JsonKey(name: 'total_reminder_count', readValue: _readIntSafe)  int? totalReminderCount, @JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount)  int? pendingReminderCount, @JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder)  bool? canSendReminder, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected)  dynamic isPhotoProtected, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'receiver_response')  dynamic receiverResponse, @JsonKey(name: 'is_block')  dynamic isBlock, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'active_call_minute')  dynamic activeCallMinute, @JsonKey(name: 'sent_date', readValue: _readSentDate)  dynamic sentDate, @JsonKey(name: 'sender_matri_id')  dynamic senderMatriId, @JsonKey(name: 'receiver_matri_id')  dynamic receiverMatriId,  dynamic sender,  dynamic receiver, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'is_online')  dynamic isOnline, @JsonKey(name: 'is_online_text')  dynamic isOnlineText, @JsonKey(name: 'mobile_verify_status')  dynamic mobileVerifyStatus, @JsonKey(name: 'id_proof_status')  dynamic idProofStatus, @JsonKey(name: 'education_details', readValue: _readEducationDetails)  dynamic educationDetails, @JsonKey(name: 'send_type', readValue: _readSendType)  dynamic sendType, @JsonKey(name: 'response')  dynamic response, @JsonKey(name: 'video_call_setting')  dynamic videoCallSetting, @JsonKey(name: 'voice_call_setting')  dynamic voiceCallSetting)?  $default,) {final _that = this;
switch (_that) {
case _MemberListModel() when $default != null:
return $default(_that.id,_that.memberId,_that.matriId,_that.fullname,_that.gender,_that.birthdate,_that.countryName,_that.stateName,_that.cityName,_that.planName,_that.planStatus,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.photoVisibility,_that.blockProfileId,_that.profileTitle,_that.religion,_that.subTitle,_that.interestState,_that.interestStatus,_that.interestId,_that.totalReminderCount,_that.pendingReminderCount,_that.canSendReminder,_that.isShortlisted,_that.isPhotoProtected,_that.profileImage,_that.receiverResponse,_that.isBlock,_that.senderMemberId,_that.receiverMemberId,_that.activeCallMinute,_that.sentDate,_that.senderMatriId,_that.receiverMatriId,_that.sender,_that.receiver,_that.matchPercent,_that.isOnline,_that.isOnlineText,_that.mobileVerifyStatus,_that.idProofStatus,_that.educationDetails,_that.sendType,_that.response,_that.videoCallSetting,_that.voiceCallSetting);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberListModel implements MemberListModel {
  const _MemberListModel({this.id, @JsonKey(name: 'member_id', readValue: _readMemberId) this.memberId, @JsonKey(name: 'matri_id') this.matriId, this.fullname, this.gender, this.birthdate, @JsonKey(name: 'country_name', readValue: _readCountryName) this.countryName, @JsonKey(name: 'state_name', readValue: _readStateName) this.stateName, @JsonKey(name: 'city_name', readValue: _readCityName) this.cityName, @JsonKey(name: 'plan_name') this.planName, @JsonKey(name: 'plan_status', readValue: _readPlanStatus) this.planStatus, this.photo1, @JsonKey(name: 'photo1_status') this.photo1Status, this.photo2, @JsonKey(name: 'photo2_status') this.photo2Status, this.photo3, @JsonKey(name: 'photo3_status') this.photo3Status, this.photo4, @JsonKey(name: 'photo4_status') this.photo4Status, @JsonKey(name: 'photo_visibility') this.photoVisibility, @JsonKey(name: 'block_profile_id') this.blockProfileId, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'religion', readValue: _readReligion) this.religion, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'interest_state', readValue: _readStringSafe) this.interestState, @JsonKey(name: 'interest_status', readValue: _readStringSafe) this.interestStatus, @JsonKey(name: 'interest_id') this.interestId, @JsonKey(name: 'total_reminder_count', readValue: _readIntSafe) this.totalReminderCount, @JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount) this.pendingReminderCount, @JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder) this.canSendReminder, @JsonKey(name: 'is_shortlisted') this.isShortlisted, @JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected) this.isPhotoProtected, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'receiver_response') this.receiverResponse, @JsonKey(name: 'is_block') this.isBlock, @JsonKey(name: 'sender_member_id') this.senderMemberId, @JsonKey(name: 'receiver_member_id') this.receiverMemberId, @JsonKey(name: 'active_call_minute') this.activeCallMinute, @JsonKey(name: 'sent_date', readValue: _readSentDate) this.sentDate, @JsonKey(name: 'sender_matri_id') this.senderMatriId, @JsonKey(name: 'receiver_matri_id') this.receiverMatriId, this.sender, this.receiver, @JsonKey(name: 'matchPercent') this.matchPercent, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'is_online_text') this.isOnlineText, @JsonKey(name: 'mobile_verify_status') this.mobileVerifyStatus, @JsonKey(name: 'id_proof_status') this.idProofStatus, @JsonKey(name: 'education_details', readValue: _readEducationDetails) this.educationDetails, @JsonKey(name: 'send_type', readValue: _readSendType) this.sendType, @JsonKey(name: 'response') this.response, @JsonKey(name: 'video_call_setting') this.videoCallSetting, @JsonKey(name: 'voice_call_setting') this.voiceCallSetting});
  factory _MemberListModel.fromJson(Map<String, dynamic> json) => _$MemberListModelFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'member_id', readValue: _readMemberId) final  dynamic memberId;
@override@JsonKey(name: 'matri_id') final  dynamic matriId;
@override final  dynamic fullname;
@override final  dynamic gender;
@override final  dynamic birthdate;
@override@JsonKey(name: 'country_name', readValue: _readCountryName) final  dynamic countryName;
@override@JsonKey(name: 'state_name', readValue: _readStateName) final  dynamic stateName;
@override@JsonKey(name: 'city_name', readValue: _readCityName) final  dynamic cityName;
@override@JsonKey(name: 'plan_name') final  dynamic planName;
@override@JsonKey(name: 'plan_status', readValue: _readPlanStatus) final  dynamic planStatus;
@override final  dynamic photo1;
@override@JsonKey(name: 'photo1_status') final  dynamic photo1Status;
@override final  dynamic photo2;
@override@JsonKey(name: 'photo2_status') final  dynamic photo2Status;
@override final  dynamic photo3;
@override@JsonKey(name: 'photo3_status') final  dynamic photo3Status;
@override final  dynamic photo4;
@override@JsonKey(name: 'photo4_status') final  dynamic photo4Status;
@override@JsonKey(name: 'photo_visibility') final  dynamic photoVisibility;
@override@JsonKey(name: 'block_profile_id') final  dynamic blockProfileId;
@override@JsonKey(name: 'profile_title') final  dynamic profileTitle;
@override@JsonKey(name: 'religion', readValue: _readReligion) final  dynamic religion;
@override@JsonKey(name: 'sub_title') final  dynamic subTitle;
@override@JsonKey(name: 'interest_state', readValue: _readStringSafe) final  String? interestState;
@override@JsonKey(name: 'interest_status', readValue: _readStringSafe) final  String? interestStatus;
@override@JsonKey(name: 'interest_id') final  dynamic interestId;
@override@JsonKey(name: 'total_reminder_count', readValue: _readIntSafe) final  int? totalReminderCount;
@override@JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount) final  int? pendingReminderCount;
@override@JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder) final  bool? canSendReminder;
@override@JsonKey(name: 'is_shortlisted') final  dynamic isShortlisted;
@override@JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected) final  dynamic isPhotoProtected;
@override@JsonKey(name: 'profile_image') final  dynamic profileImage;
@override@JsonKey(name: 'receiver_response') final  dynamic receiverResponse;
@override@JsonKey(name: 'is_block') final  dynamic isBlock;
@override@JsonKey(name: 'sender_member_id') final  dynamic senderMemberId;
@override@JsonKey(name: 'receiver_member_id') final  dynamic receiverMemberId;
@override@JsonKey(name: 'active_call_minute') final  dynamic activeCallMinute;
@override@JsonKey(name: 'sent_date', readValue: _readSentDate) final  dynamic sentDate;
@override@JsonKey(name: 'sender_matri_id') final  dynamic senderMatriId;
@override@JsonKey(name: 'receiver_matri_id') final  dynamic receiverMatriId;
@override final  dynamic sender;
@override final  dynamic receiver;
@override@JsonKey(name: 'matchPercent') final  dynamic matchPercent;
@override@JsonKey(name: 'is_online') final  dynamic isOnline;
@override@JsonKey(name: 'is_online_text') final  dynamic isOnlineText;
@override@JsonKey(name: 'mobile_verify_status') final  dynamic mobileVerifyStatus;
@override@JsonKey(name: 'id_proof_status') final  dynamic idProofStatus;
@override@JsonKey(name: 'education_details', readValue: _readEducationDetails) final  dynamic educationDetails;
@override@JsonKey(name: 'send_type', readValue: _readSendType) final  dynamic sendType;
@override@JsonKey(name: 'response') final  dynamic response;
@override@JsonKey(name: 'video_call_setting') final  dynamic videoCallSetting;
@override@JsonKey(name: 'voice_call_setting') final  dynamic voiceCallSetting;

/// Create a copy of MemberListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberListModelCopyWith<_MemberListModel> get copyWith => __$MemberListModelCopyWithImpl<_MemberListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberListModel&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.memberId, memberId)&&const DeepCollectionEquality().equals(other.matriId, matriId)&&const DeepCollectionEquality().equals(other.fullname, fullname)&&const DeepCollectionEquality().equals(other.gender, gender)&&const DeepCollectionEquality().equals(other.birthdate, birthdate)&&const DeepCollectionEquality().equals(other.countryName, countryName)&&const DeepCollectionEquality().equals(other.stateName, stateName)&&const DeepCollectionEquality().equals(other.cityName, cityName)&&const DeepCollectionEquality().equals(other.planName, planName)&&const DeepCollectionEquality().equals(other.planStatus, planStatus)&&const DeepCollectionEquality().equals(other.photo1, photo1)&&const DeepCollectionEquality().equals(other.photo1Status, photo1Status)&&const DeepCollectionEquality().equals(other.photo2, photo2)&&const DeepCollectionEquality().equals(other.photo2Status, photo2Status)&&const DeepCollectionEquality().equals(other.photo3, photo3)&&const DeepCollectionEquality().equals(other.photo3Status, photo3Status)&&const DeepCollectionEquality().equals(other.photo4, photo4)&&const DeepCollectionEquality().equals(other.photo4Status, photo4Status)&&const DeepCollectionEquality().equals(other.photoVisibility, photoVisibility)&&const DeepCollectionEquality().equals(other.blockProfileId, blockProfileId)&&const DeepCollectionEquality().equals(other.profileTitle, profileTitle)&&const DeepCollectionEquality().equals(other.religion, religion)&&const DeepCollectionEquality().equals(other.subTitle, subTitle)&&(identical(other.interestState, interestState) || other.interestState == interestState)&&(identical(other.interestStatus, interestStatus) || other.interestStatus == interestStatus)&&const DeepCollectionEquality().equals(other.interestId, interestId)&&(identical(other.totalReminderCount, totalReminderCount) || other.totalReminderCount == totalReminderCount)&&(identical(other.pendingReminderCount, pendingReminderCount) || other.pendingReminderCount == pendingReminderCount)&&(identical(other.canSendReminder, canSendReminder) || other.canSendReminder == canSendReminder)&&const DeepCollectionEquality().equals(other.isShortlisted, isShortlisted)&&const DeepCollectionEquality().equals(other.isPhotoProtected, isPhotoProtected)&&const DeepCollectionEquality().equals(other.profileImage, profileImage)&&const DeepCollectionEquality().equals(other.receiverResponse, receiverResponse)&&const DeepCollectionEquality().equals(other.isBlock, isBlock)&&const DeepCollectionEquality().equals(other.senderMemberId, senderMemberId)&&const DeepCollectionEquality().equals(other.receiverMemberId, receiverMemberId)&&const DeepCollectionEquality().equals(other.activeCallMinute, activeCallMinute)&&const DeepCollectionEquality().equals(other.sentDate, sentDate)&&const DeepCollectionEquality().equals(other.senderMatriId, senderMatriId)&&const DeepCollectionEquality().equals(other.receiverMatriId, receiverMatriId)&&const DeepCollectionEquality().equals(other.sender, sender)&&const DeepCollectionEquality().equals(other.receiver, receiver)&&const DeepCollectionEquality().equals(other.matchPercent, matchPercent)&&const DeepCollectionEquality().equals(other.isOnline, isOnline)&&const DeepCollectionEquality().equals(other.isOnlineText, isOnlineText)&&const DeepCollectionEquality().equals(other.mobileVerifyStatus, mobileVerifyStatus)&&const DeepCollectionEquality().equals(other.idProofStatus, idProofStatus)&&const DeepCollectionEquality().equals(other.educationDetails, educationDetails)&&const DeepCollectionEquality().equals(other.sendType, sendType)&&const DeepCollectionEquality().equals(other.response, response)&&const DeepCollectionEquality().equals(other.videoCallSetting, videoCallSetting)&&const DeepCollectionEquality().equals(other.voiceCallSetting, voiceCallSetting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(memberId),const DeepCollectionEquality().hash(matriId),const DeepCollectionEquality().hash(fullname),const DeepCollectionEquality().hash(gender),const DeepCollectionEquality().hash(birthdate),const DeepCollectionEquality().hash(countryName),const DeepCollectionEquality().hash(stateName),const DeepCollectionEquality().hash(cityName),const DeepCollectionEquality().hash(planName),const DeepCollectionEquality().hash(planStatus),const DeepCollectionEquality().hash(photo1),const DeepCollectionEquality().hash(photo1Status),const DeepCollectionEquality().hash(photo2),const DeepCollectionEquality().hash(photo2Status),const DeepCollectionEquality().hash(photo3),const DeepCollectionEquality().hash(photo3Status),const DeepCollectionEquality().hash(photo4),const DeepCollectionEquality().hash(photo4Status),const DeepCollectionEquality().hash(photoVisibility),const DeepCollectionEquality().hash(blockProfileId),const DeepCollectionEquality().hash(profileTitle),const DeepCollectionEquality().hash(religion),const DeepCollectionEquality().hash(subTitle),interestState,interestStatus,const DeepCollectionEquality().hash(interestId),totalReminderCount,pendingReminderCount,canSendReminder,const DeepCollectionEquality().hash(isShortlisted),const DeepCollectionEquality().hash(isPhotoProtected),const DeepCollectionEquality().hash(profileImage),const DeepCollectionEquality().hash(receiverResponse),const DeepCollectionEquality().hash(isBlock),const DeepCollectionEquality().hash(senderMemberId),const DeepCollectionEquality().hash(receiverMemberId),const DeepCollectionEquality().hash(activeCallMinute),const DeepCollectionEquality().hash(sentDate),const DeepCollectionEquality().hash(senderMatriId),const DeepCollectionEquality().hash(receiverMatriId),const DeepCollectionEquality().hash(sender),const DeepCollectionEquality().hash(receiver),const DeepCollectionEquality().hash(matchPercent),const DeepCollectionEquality().hash(isOnline),const DeepCollectionEquality().hash(isOnlineText),const DeepCollectionEquality().hash(mobileVerifyStatus),const DeepCollectionEquality().hash(idProofStatus),const DeepCollectionEquality().hash(educationDetails),const DeepCollectionEquality().hash(sendType),const DeepCollectionEquality().hash(response),const DeepCollectionEquality().hash(videoCallSetting),const DeepCollectionEquality().hash(voiceCallSetting)]);
}

@override
String toString() {
    return 'MemberListModel(id: $id, memberId: $memberId, matriId: $matriId, fullname: $fullname, gender: $gender, birthdate: $birthdate, countryName: $countryName, stateName: $stateName, cityName: $cityName, planName: $planName, planStatus: $planStatus, photo1: $photo1, photo1Status: $photo1Status, photo2: $photo2, photo2Status: $photo2Status, photo3: $photo3, photo3Status: $photo3Status, photo4: $photo4, photo4Status: $photo4Status, photoVisibility: $photoVisibility, blockProfileId: $blockProfileId, profileTitle: $profileTitle, religion: $religion, subTitle: $subTitle, interestState: $interestState, interestStatus: $interestStatus, interestId: $interestId, totalReminderCount: $totalReminderCount, pendingReminderCount: $pendingReminderCount, canSendReminder: $canSendReminder, isShortlisted: $isShortlisted, isPhotoProtected: $isPhotoProtected, profileImage: $profileImage, receiverResponse: $receiverResponse, isBlock: $isBlock, senderMemberId: $senderMemberId, receiverMemberId: $receiverMemberId, activeCallMinute: $activeCallMinute, sentDate: $sentDate, senderMatriId: $senderMatriId, receiverMatriId: $receiverMatriId, sender: $sender, receiver: $receiver, matchPercent: $matchPercent, isOnline: $isOnline, isOnlineText: $isOnlineText, mobileVerifyStatus: $mobileVerifyStatus, idProofStatus: $idProofStatus, educationDetails: $educationDetails, sendType: $sendType, response: $response, videoCallSetting: $videoCallSetting, voiceCallSetting: $voiceCallSetting)';
}


}

/// @nodoc
abstract mixin class _$MemberListModelCopyWith<$Res> implements $MemberListModelCopyWith<$Res> {
  factory _$MemberListModelCopyWith(_MemberListModel value, $Res Function(_MemberListModel) _then) = __$MemberListModelCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'member_id', readValue: _readMemberId) dynamic memberId,@JsonKey(name: 'matri_id') dynamic matriId, dynamic fullname, dynamic gender, dynamic birthdate,@JsonKey(name: 'country_name', readValue: _readCountryName) dynamic countryName,@JsonKey(name: 'state_name', readValue: _readStateName) dynamic stateName,@JsonKey(name: 'city_name', readValue: _readCityName) dynamic cityName,@JsonKey(name: 'plan_name') dynamic planName,@JsonKey(name: 'plan_status', readValue: _readPlanStatus) dynamic planStatus, dynamic photo1,@JsonKey(name: 'photo1_status') dynamic photo1Status, dynamic photo2,@JsonKey(name: 'photo2_status') dynamic photo2Status, dynamic photo3,@JsonKey(name: 'photo3_status') dynamic photo3Status, dynamic photo4,@JsonKey(name: 'photo4_status') dynamic photo4Status,@JsonKey(name: 'photo_visibility') dynamic photoVisibility,@JsonKey(name: 'block_profile_id') dynamic blockProfileId,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'religion', readValue: _readReligion) dynamic religion,@JsonKey(name: 'sub_title') dynamic subTitle,@JsonKey(name: 'interest_state', readValue: _readStringSafe) String? interestState,@JsonKey(name: 'interest_status', readValue: _readStringSafe) String? interestStatus,@JsonKey(name: 'interest_id') dynamic interestId,@JsonKey(name: 'total_reminder_count', readValue: _readIntSafe) int? totalReminderCount,@JsonKey(name: 'pending_reminder_count', readValue: _readPendingReminderCount) int? pendingReminderCount,@JsonKey(name: 'can_send_reminder', readValue: _readCanSendReminder) bool? canSendReminder,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_photoProtected', readValue: _readPhotoProtected) dynamic isPhotoProtected,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'receiver_response') dynamic receiverResponse,@JsonKey(name: 'is_block') dynamic isBlock,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'active_call_minute') dynamic activeCallMinute,@JsonKey(name: 'sent_date', readValue: _readSentDate) dynamic sentDate,@JsonKey(name: 'sender_matri_id') dynamic senderMatriId,@JsonKey(name: 'receiver_matri_id') dynamic receiverMatriId, dynamic sender, dynamic receiver,@JsonKey(name: 'matchPercent') dynamic matchPercent,@JsonKey(name: 'is_online') dynamic isOnline,@JsonKey(name: 'is_online_text') dynamic isOnlineText,@JsonKey(name: 'mobile_verify_status') dynamic mobileVerifyStatus,@JsonKey(name: 'id_proof_status') dynamic idProofStatus,@JsonKey(name: 'education_details', readValue: _readEducationDetails) dynamic educationDetails,@JsonKey(name: 'send_type', readValue: _readSendType) dynamic sendType,@JsonKey(name: 'response') dynamic response,@JsonKey(name: 'video_call_setting') dynamic videoCallSetting,@JsonKey(name: 'voice_call_setting') dynamic voiceCallSetting
});




}
/// @nodoc
class __$MemberListModelCopyWithImpl<$Res>
    implements _$MemberListModelCopyWith<$Res> {
  __$MemberListModelCopyWithImpl(this._self, this._then);

  final _MemberListModel _self;
  final $Res Function(_MemberListModel) _then;

/// Create a copy of MemberListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? memberId = freezed,Object? matriId = freezed,Object? fullname = freezed,Object? gender = freezed,Object? birthdate = freezed,Object? countryName = freezed,Object? stateName = freezed,Object? cityName = freezed,Object? planName = freezed,Object? planStatus = freezed,Object? photo1 = freezed,Object? photo1Status = freezed,Object? photo2 = freezed,Object? photo2Status = freezed,Object? photo3 = freezed,Object? photo3Status = freezed,Object? photo4 = freezed,Object? photo4Status = freezed,Object? photoVisibility = freezed,Object? blockProfileId = freezed,Object? profileTitle = freezed,Object? religion = freezed,Object? subTitle = freezed,Object? interestState = freezed,Object? interestStatus = freezed,Object? interestId = freezed,Object? totalReminderCount = freezed,Object? pendingReminderCount = freezed,Object? canSendReminder = freezed,Object? isShortlisted = freezed,Object? isPhotoProtected = freezed,Object? profileImage = freezed,Object? receiverResponse = freezed,Object? isBlock = freezed,Object? senderMemberId = freezed,Object? receiverMemberId = freezed,Object? activeCallMinute = freezed,Object? sentDate = freezed,Object? senderMatriId = freezed,Object? receiverMatriId = freezed,Object? sender = freezed,Object? receiver = freezed,Object? matchPercent = freezed,Object? isOnline = freezed,Object? isOnlineText = freezed,Object? mobileVerifyStatus = freezed,Object? idProofStatus = freezed,Object? educationDetails = freezed,Object? sendType = freezed,Object? response = freezed,Object? videoCallSetting = freezed,Object? voiceCallSetting = freezed,}) {
  return _then(_MemberListModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,matriId: freezed == matriId ? _self.matriId : matriId // ignore: cast_nullable_to_non_nullable
as dynamic,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as dynamic,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as dynamic,stateName: freezed == stateName ? _self.stateName : stateName // ignore: cast_nullable_to_non_nullable
as dynamic,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as dynamic,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as dynamic,planStatus: freezed == planStatus ? _self.planStatus : planStatus // ignore: cast_nullable_to_non_nullable
as dynamic,photo1: freezed == photo1 ? _self.photo1 : photo1 // ignore: cast_nullable_to_non_nullable
as dynamic,photo1Status: freezed == photo1Status ? _self.photo1Status : photo1Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo2: freezed == photo2 ? _self.photo2 : photo2 // ignore: cast_nullable_to_non_nullable
as dynamic,photo2Status: freezed == photo2Status ? _self.photo2Status : photo2Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo3: freezed == photo3 ? _self.photo3 : photo3 // ignore: cast_nullable_to_non_nullable
as dynamic,photo3Status: freezed == photo3Status ? _self.photo3Status : photo3Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo4: freezed == photo4 ? _self.photo4 : photo4 // ignore: cast_nullable_to_non_nullable
as dynamic,photo4Status: freezed == photo4Status ? _self.photo4Status : photo4Status // ignore: cast_nullable_to_non_nullable
as dynamic,photoVisibility: freezed == photoVisibility ? _self.photoVisibility : photoVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,blockProfileId: freezed == blockProfileId ? _self.blockProfileId : blockProfileId // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,interestState: freezed == interestState ? _self.interestState : interestState // ignore: cast_nullable_to_non_nullable
as String?,interestStatus: freezed == interestStatus ? _self.interestStatus : interestStatus // ignore: cast_nullable_to_non_nullable
as String?,interestId: freezed == interestId ? _self.interestId : interestId // ignore: cast_nullable_to_non_nullable
as dynamic,totalReminderCount: freezed == totalReminderCount ? _self.totalReminderCount : totalReminderCount // ignore: cast_nullable_to_non_nullable
as int?,pendingReminderCount: freezed == pendingReminderCount ? _self.pendingReminderCount : pendingReminderCount // ignore: cast_nullable_to_non_nullable
as int?,canSendReminder: freezed == canSendReminder ? _self.canSendReminder : canSendReminder // ignore: cast_nullable_to_non_nullable
as bool?,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,receiverResponse: freezed == receiverResponse ? _self.receiverResponse : receiverResponse // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,activeCallMinute: freezed == activeCallMinute ? _self.activeCallMinute : activeCallMinute // ignore: cast_nullable_to_non_nullable
as dynamic,sentDate: freezed == sentDate ? _self.sentDate : sentDate // ignore: cast_nullable_to_non_nullable
as dynamic,senderMatriId: freezed == senderMatriId ? _self.senderMatriId : senderMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMatriId: freezed == receiverMatriId ? _self.receiverMatriId : receiverMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as dynamic,receiver: freezed == receiver ? _self.receiver : receiver // ignore: cast_nullable_to_non_nullable
as dynamic,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as dynamic,isOnlineText: freezed == isOnlineText ? _self.isOnlineText : isOnlineText // ignore: cast_nullable_to_non_nullable
as dynamic,mobileVerifyStatus: freezed == mobileVerifyStatus ? _self.mobileVerifyStatus : mobileVerifyStatus // ignore: cast_nullable_to_non_nullable
as dynamic,idProofStatus: freezed == idProofStatus ? _self.idProofStatus : idProofStatus // ignore: cast_nullable_to_non_nullable
as dynamic,educationDetails: freezed == educationDetails ? _self.educationDetails : educationDetails // ignore: cast_nullable_to_non_nullable
as dynamic,sendType: freezed == sendType ? _self.sendType : sendType // ignore: cast_nullable_to_non_nullable
as dynamic,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,videoCallSetting: freezed == videoCallSetting ? _self.videoCallSetting : videoCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,voiceCallSetting: freezed == voiceCallSetting ? _self.voiceCallSetting : voiceCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
