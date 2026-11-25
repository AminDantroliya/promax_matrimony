// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardResponseModel {

 int? get code; String? get status; String? get message; DashboardData? get data;
/// Create a copy of DashboardResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardResponseModelCopyWith<DashboardResponseModel> get copyWith => _$DashboardResponseModelCopyWithImpl<DashboardResponseModel>(this as DashboardResponseModel, _$identity);

  /// Serializes this DashboardResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DashboardResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DashboardResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as DashboardResponseModel;
  return 'DashboardResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $DashboardResponseModelCopyWith<$Res>  {
  factory $DashboardResponseModelCopyWith(DashboardResponseModel value, $Res Function(DashboardResponseModel) _then) = _$DashboardResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, DashboardData? data
});


$DashboardDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$DashboardResponseModelCopyWithImpl<$Res>
    implements $DashboardResponseModelCopyWith<$Res> {
  _$DashboardResponseModelCopyWithImpl(this._self, this._then);

  final DashboardResponseModel _self;
  final $Res Function(DashboardResponseModel) _then;

/// Create a copy of DashboardResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(DashboardResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DashboardData?,
  ));
}
/// Create a copy of DashboardResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DashboardDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardResponseModel].
extension DashboardResponseModelPatterns on DashboardResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  DashboardData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  DashboardData? data)  $default,) {final _that = this;
switch (_that) {
case _DashboardResponseModel():
return $default(_that.code,_that.status,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  DashboardData? data)?  $default,) {final _that = this;
switch (_that) {
case _DashboardResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardResponseModel implements DashboardResponseModel {
  const _DashboardResponseModel({this.code, this.status, this.message, this.data});
  factory _DashboardResponseModel.fromJson(Map<String, dynamic> json) => _$DashboardResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  DashboardData? data;

/// Create a copy of DashboardResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardResponseModelCopyWith<_DashboardResponseModel> get copyWith => __$DashboardResponseModelCopyWithImpl<_DashboardResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'DashboardResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$DashboardResponseModelCopyWith<$Res> implements $DashboardResponseModelCopyWith<$Res> {
  factory _$DashboardResponseModelCopyWith(_DashboardResponseModel value, $Res Function(_DashboardResponseModel) _then) = __$DashboardResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, DashboardData? data
});


@override $DashboardDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$DashboardResponseModelCopyWithImpl<$Res>
    implements _$DashboardResponseModelCopyWith<$Res> {
  __$DashboardResponseModelCopyWithImpl(this._self, this._then);

  final _DashboardResponseModel _self;
  final $Res Function(_DashboardResponseModel) _then;

/// Create a copy of DashboardResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_DashboardResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DashboardData?,
  ));
}

/// Create a copy of DashboardResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DashboardDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$DashboardData {

@JsonKey(name: 'profile_image') String? get profileImage;@JsonKey(name: 'user_type') dynamic get userType;@JsonKey(name: 'profile_title') String? get profileTitle;@JsonKey(name: 'sub_title') String? get subTitle;@JsonKey(name: 'profile_percentage') dynamic get profilePercentage;@JsonKey(name: 'unreadChatCount') int? get unreadChatCount;@JsonKey(name: 'unread_notification_count') int? get unreadNotificationCount;@JsonKey(name: 'mobile_verify_status') String? get mobileVerifyStatus;@JsonKey(name: 'email_verify_status') String? get emailVerifyStatus;@JsonKey(name: 'call_count') int? get callCount; int? get suggestedMatchCount; int? get fixMeetingsCount; int? get todayNoMeeting;@JsonKey(name: 'matches_count') int? get matchesCount; int? get voiceCallCount;@JsonKey(name: 'chat_count') int? get chatCount;@JsonKey(name: 'photos_count') int? get photosCount;@JsonKey(name: 'interest_count') dynamic get interestCount; dynamic get shortlistCount; dynamic get blockedCount; dynamic get photoRequestCount; dynamic get viewedProfileCount; dynamic get viewedContactCount; List<AnnouncementBanner>? get annocementBannerArr; List<MemberListModel>? get todayMatches; List<MemberListModel>? get recentlyJoinedMember; List<MemberListModel>? get recommendedMatches; List<MemberListModel>? get whoViewMyProfile;@JsonKey(name: 'interest_list') List<MemberListModel>? get receivedInterest; List<MemberListModel>? get recentlyLoginMember; List<MemberListModel>? get recommedMatchesMember; List<MemberListModel>? get premiumMatchesMember; List<MemberListModel>? get nearByMatchesMember;@JsonKey(name: 'featuredMember') List<MemberListModel>? get featuredMember;@JsonKey(name: 'successStories') List<SuccessStory>? get successStories;@JsonKey(name: 'plan_status') String? get planStatus;@JsonKey(name: 'current_plan') CurrentPlan? get currentPlan;@JsonKey(name: 'auto_interest_enabled') int? get autoInterestEnabled;@JsonKey(name: 'daily_interest_limit') int? get dailyInterestLimit;@JsonKey(name: 'min_match_percentage') int? get minMatchPercentage;@JsonKey(name: 'site_setting') Map<String, dynamic>? get siteSetting;@JsonKey(name: 'latitude') String? get latitude;@JsonKey(name: 'longitude') String? get longitude;@JsonKey(name: 'android_device_id') String? get androidDeviceId;@JsonKey(name: 'ios_device_id') String? get iosDeviceId;
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this as DashboardData, _$identity);

  /// Serializes this DashboardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DashboardData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.profileImage, _this.profileImage) || other.profileImage == _this.profileImage)&&const DeepCollectionEquality().equals(other.userType, _this.userType)&&(identical(other.profileTitle, _this.profileTitle) || other.profileTitle == _this.profileTitle)&&(identical(other.subTitle, _this.subTitle) || other.subTitle == _this.subTitle)&&const DeepCollectionEquality().equals(other.profilePercentage, _this.profilePercentage)&&(identical(other.unreadChatCount, _this.unreadChatCount) || other.unreadChatCount == _this.unreadChatCount)&&(identical(other.unreadNotificationCount, _this.unreadNotificationCount) || other.unreadNotificationCount == _this.unreadNotificationCount)&&(identical(other.mobileVerifyStatus, _this.mobileVerifyStatus) || other.mobileVerifyStatus == _this.mobileVerifyStatus)&&(identical(other.emailVerifyStatus, _this.emailVerifyStatus) || other.emailVerifyStatus == _this.emailVerifyStatus)&&(identical(other.callCount, _this.callCount) || other.callCount == _this.callCount)&&(identical(other.suggestedMatchCount, _this.suggestedMatchCount) || other.suggestedMatchCount == _this.suggestedMatchCount)&&(identical(other.fixMeetingsCount, _this.fixMeetingsCount) || other.fixMeetingsCount == _this.fixMeetingsCount)&&(identical(other.todayNoMeeting, _this.todayNoMeeting) || other.todayNoMeeting == _this.todayNoMeeting)&&(identical(other.matchesCount, _this.matchesCount) || other.matchesCount == _this.matchesCount)&&(identical(other.voiceCallCount, _this.voiceCallCount) || other.voiceCallCount == _this.voiceCallCount)&&(identical(other.chatCount, _this.chatCount) || other.chatCount == _this.chatCount)&&(identical(other.photosCount, _this.photosCount) || other.photosCount == _this.photosCount)&&const DeepCollectionEquality().equals(other.interestCount, _this.interestCount)&&const DeepCollectionEquality().equals(other.shortlistCount, _this.shortlistCount)&&const DeepCollectionEquality().equals(other.blockedCount, _this.blockedCount)&&const DeepCollectionEquality().equals(other.photoRequestCount, _this.photoRequestCount)&&const DeepCollectionEquality().equals(other.viewedProfileCount, _this.viewedProfileCount)&&const DeepCollectionEquality().equals(other.viewedContactCount, _this.viewedContactCount)&&const DeepCollectionEquality().equals(other.annocementBannerArr, _this.annocementBannerArr)&&const DeepCollectionEquality().equals(other.todayMatches, _this.todayMatches)&&const DeepCollectionEquality().equals(other.recentlyJoinedMember, _this.recentlyJoinedMember)&&const DeepCollectionEquality().equals(other.recommendedMatches, _this.recommendedMatches)&&const DeepCollectionEquality().equals(other.whoViewMyProfile, _this.whoViewMyProfile)&&const DeepCollectionEquality().equals(other.receivedInterest, _this.receivedInterest)&&const DeepCollectionEquality().equals(other.recentlyLoginMember, _this.recentlyLoginMember)&&const DeepCollectionEquality().equals(other.recommedMatchesMember, _this.recommedMatchesMember)&&const DeepCollectionEquality().equals(other.premiumMatchesMember, _this.premiumMatchesMember)&&const DeepCollectionEquality().equals(other.nearByMatchesMember, _this.nearByMatchesMember)&&const DeepCollectionEquality().equals(other.featuredMember, _this.featuredMember)&&const DeepCollectionEquality().equals(other.successStories, _this.successStories)&&(identical(other.planStatus, _this.planStatus) || other.planStatus == _this.planStatus)&&(identical(other.currentPlan, _this.currentPlan) || other.currentPlan == _this.currentPlan)&&(identical(other.autoInterestEnabled, _this.autoInterestEnabled) || other.autoInterestEnabled == _this.autoInterestEnabled)&&(identical(other.dailyInterestLimit, _this.dailyInterestLimit) || other.dailyInterestLimit == _this.dailyInterestLimit)&&(identical(other.minMatchPercentage, _this.minMatchPercentage) || other.minMatchPercentage == _this.minMatchPercentage)&&const DeepCollectionEquality().equals(other.siteSetting, _this.siteSetting)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.androidDeviceId, _this.androidDeviceId) || other.androidDeviceId == _this.androidDeviceId)&&(identical(other.iosDeviceId, _this.iosDeviceId) || other.iosDeviceId == _this.iosDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DashboardData;
  return Object.hashAll([runtimeType,_this.profileImage,const DeepCollectionEquality().hash(_this.userType),_this.profileTitle,_this.subTitle,const DeepCollectionEquality().hash(_this.profilePercentage),_this.unreadChatCount,_this.unreadNotificationCount,_this.mobileVerifyStatus,_this.emailVerifyStatus,_this.callCount,_this.suggestedMatchCount,_this.fixMeetingsCount,_this.todayNoMeeting,_this.matchesCount,_this.voiceCallCount,_this.chatCount,_this.photosCount,const DeepCollectionEquality().hash(_this.interestCount),const DeepCollectionEquality().hash(_this.shortlistCount),const DeepCollectionEquality().hash(_this.blockedCount),const DeepCollectionEquality().hash(_this.photoRequestCount),const DeepCollectionEquality().hash(_this.viewedProfileCount),const DeepCollectionEquality().hash(_this.viewedContactCount),const DeepCollectionEquality().hash(_this.annocementBannerArr),const DeepCollectionEquality().hash(_this.todayMatches),const DeepCollectionEquality().hash(_this.recentlyJoinedMember),const DeepCollectionEquality().hash(_this.recommendedMatches),const DeepCollectionEquality().hash(_this.whoViewMyProfile),const DeepCollectionEquality().hash(_this.receivedInterest),const DeepCollectionEquality().hash(_this.recentlyLoginMember),const DeepCollectionEquality().hash(_this.recommedMatchesMember),const DeepCollectionEquality().hash(_this.premiumMatchesMember),const DeepCollectionEquality().hash(_this.nearByMatchesMember),const DeepCollectionEquality().hash(_this.featuredMember),const DeepCollectionEquality().hash(_this.successStories),_this.planStatus,_this.currentPlan,_this.autoInterestEnabled,_this.dailyInterestLimit,_this.minMatchPercentage,const DeepCollectionEquality().hash(_this.siteSetting),_this.latitude,_this.longitude,_this.androidDeviceId,_this.iosDeviceId]);
}

@override
String toString() {
  final _this = this as DashboardData;
  return 'DashboardData(profileImage: ${_this.profileImage}, userType: ${_this.userType}, profileTitle: ${_this.profileTitle}, subTitle: ${_this.subTitle}, profilePercentage: ${_this.profilePercentage}, unreadChatCount: ${_this.unreadChatCount}, unreadNotificationCount: ${_this.unreadNotificationCount}, mobileVerifyStatus: ${_this.mobileVerifyStatus}, emailVerifyStatus: ${_this.emailVerifyStatus}, callCount: ${_this.callCount}, suggestedMatchCount: ${_this.suggestedMatchCount}, fixMeetingsCount: ${_this.fixMeetingsCount}, todayNoMeeting: ${_this.todayNoMeeting}, matchesCount: ${_this.matchesCount}, voiceCallCount: ${_this.voiceCallCount}, chatCount: ${_this.chatCount}, photosCount: ${_this.photosCount}, interestCount: ${_this.interestCount}, shortlistCount: ${_this.shortlistCount}, blockedCount: ${_this.blockedCount}, photoRequestCount: ${_this.photoRequestCount}, viewedProfileCount: ${_this.viewedProfileCount}, viewedContactCount: ${_this.viewedContactCount}, annocementBannerArr: ${_this.annocementBannerArr}, todayMatches: ${_this.todayMatches}, recentlyJoinedMember: ${_this.recentlyJoinedMember}, recommendedMatches: ${_this.recommendedMatches}, whoViewMyProfile: ${_this.whoViewMyProfile}, receivedInterest: ${_this.receivedInterest}, recentlyLoginMember: ${_this.recentlyLoginMember}, recommedMatchesMember: ${_this.recommedMatchesMember}, premiumMatchesMember: ${_this.premiumMatchesMember}, nearByMatchesMember: ${_this.nearByMatchesMember}, featuredMember: ${_this.featuredMember}, successStories: ${_this.successStories}, planStatus: ${_this.planStatus}, currentPlan: ${_this.currentPlan}, autoInterestEnabled: ${_this.autoInterestEnabled}, dailyInterestLimit: ${_this.dailyInterestLimit}, minMatchPercentage: ${_this.minMatchPercentage}, siteSetting: ${_this.siteSetting}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, androidDeviceId: ${_this.androidDeviceId}, iosDeviceId: ${_this.iosDeviceId})';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res>  {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'user_type') dynamic userType,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_percentage') dynamic profilePercentage,@JsonKey(name: 'unreadChatCount') int? unreadChatCount,@JsonKey(name: 'unread_notification_count') int? unreadNotificationCount,@JsonKey(name: 'mobile_verify_status') String? mobileVerifyStatus,@JsonKey(name: 'email_verify_status') String? emailVerifyStatus,@JsonKey(name: 'call_count') int? callCount, int? suggestedMatchCount, int? fixMeetingsCount, int? todayNoMeeting,@JsonKey(name: 'matches_count') int? matchesCount, int? voiceCallCount,@JsonKey(name: 'chat_count') int? chatCount,@JsonKey(name: 'photos_count') int? photosCount,@JsonKey(name: 'interest_count') dynamic interestCount, dynamic shortlistCount, dynamic blockedCount, dynamic photoRequestCount, dynamic viewedProfileCount, dynamic viewedContactCount, List<AnnouncementBanner>? annocementBannerArr, List<MemberListModel>? todayMatches, List<MemberListModel>? recentlyJoinedMember, List<MemberListModel>? recommendedMatches, List<MemberListModel>? whoViewMyProfile,@JsonKey(name: 'interest_list') List<MemberListModel>? receivedInterest, List<MemberListModel>? recentlyLoginMember, List<MemberListModel>? recommedMatchesMember, List<MemberListModel>? premiumMatchesMember, List<MemberListModel>? nearByMatchesMember,@JsonKey(name: 'featuredMember') List<MemberListModel>? featuredMember,@JsonKey(name: 'successStories') List<SuccessStory>? successStories,@JsonKey(name: 'plan_status') String? planStatus,@JsonKey(name: 'current_plan') CurrentPlan? currentPlan,@JsonKey(name: 'auto_interest_enabled') int? autoInterestEnabled,@JsonKey(name: 'daily_interest_limit') int? dailyInterestLimit,@JsonKey(name: 'min_match_percentage') int? minMatchPercentage,@JsonKey(name: 'site_setting') Map<String, dynamic>? siteSetting,@JsonKey(name: 'latitude') String? latitude,@JsonKey(name: 'longitude') String? longitude,@JsonKey(name: 'android_device_id') String? androidDeviceId,@JsonKey(name: 'ios_device_id') String? iosDeviceId
});


$CurrentPlanCopyWith<$Res>? get currentPlan;

}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileImage = freezed,Object? userType = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profilePercentage = freezed,Object? unreadChatCount = freezed,Object? unreadNotificationCount = freezed,Object? mobileVerifyStatus = freezed,Object? emailVerifyStatus = freezed,Object? callCount = freezed,Object? suggestedMatchCount = freezed,Object? fixMeetingsCount = freezed,Object? todayNoMeeting = freezed,Object? matchesCount = freezed,Object? voiceCallCount = freezed,Object? chatCount = freezed,Object? photosCount = freezed,Object? interestCount = freezed,Object? shortlistCount = freezed,Object? blockedCount = freezed,Object? photoRequestCount = freezed,Object? viewedProfileCount = freezed,Object? viewedContactCount = freezed,Object? annocementBannerArr = freezed,Object? todayMatches = freezed,Object? recentlyJoinedMember = freezed,Object? recommendedMatches = freezed,Object? whoViewMyProfile = freezed,Object? receivedInterest = freezed,Object? recentlyLoginMember = freezed,Object? recommedMatchesMember = freezed,Object? premiumMatchesMember = freezed,Object? nearByMatchesMember = freezed,Object? featuredMember = freezed,Object? successStories = freezed,Object? planStatus = freezed,Object? currentPlan = freezed,Object? autoInterestEnabled = freezed,Object? dailyInterestLimit = freezed,Object? minMatchPercentage = freezed,Object? siteSetting = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? androidDeviceId = freezed,Object? iosDeviceId = freezed,}) {
  return _then(DashboardData(
profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profilePercentage: freezed == profilePercentage ? _self.profilePercentage : profilePercentage // ignore: cast_nullable_to_non_nullable
as dynamic,unreadChatCount: freezed == unreadChatCount ? _self.unreadChatCount : unreadChatCount // ignore: cast_nullable_to_non_nullable
as int?,unreadNotificationCount: freezed == unreadNotificationCount ? _self.unreadNotificationCount : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
as int?,mobileVerifyStatus: freezed == mobileVerifyStatus ? _self.mobileVerifyStatus : mobileVerifyStatus // ignore: cast_nullable_to_non_nullable
as String?,emailVerifyStatus: freezed == emailVerifyStatus ? _self.emailVerifyStatus : emailVerifyStatus // ignore: cast_nullable_to_non_nullable
as String?,callCount: freezed == callCount ? _self.callCount : callCount // ignore: cast_nullable_to_non_nullable
as int?,suggestedMatchCount: freezed == suggestedMatchCount ? _self.suggestedMatchCount : suggestedMatchCount // ignore: cast_nullable_to_non_nullable
as int?,fixMeetingsCount: freezed == fixMeetingsCount ? _self.fixMeetingsCount : fixMeetingsCount // ignore: cast_nullable_to_non_nullable
as int?,todayNoMeeting: freezed == todayNoMeeting ? _self.todayNoMeeting : todayNoMeeting // ignore: cast_nullable_to_non_nullable
as int?,matchesCount: freezed == matchesCount ? _self.matchesCount : matchesCount // ignore: cast_nullable_to_non_nullable
as int?,voiceCallCount: freezed == voiceCallCount ? _self.voiceCallCount : voiceCallCount // ignore: cast_nullable_to_non_nullable
as int?,chatCount: freezed == chatCount ? _self.chatCount : chatCount // ignore: cast_nullable_to_non_nullable
as int?,photosCount: freezed == photosCount ? _self.photosCount : photosCount // ignore: cast_nullable_to_non_nullable
as int?,interestCount: freezed == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as dynamic,shortlistCount: freezed == shortlistCount ? _self.shortlistCount : shortlistCount // ignore: cast_nullable_to_non_nullable
as dynamic,blockedCount: freezed == blockedCount ? _self.blockedCount : blockedCount // ignore: cast_nullable_to_non_nullable
as dynamic,photoRequestCount: freezed == photoRequestCount ? _self.photoRequestCount : photoRequestCount // ignore: cast_nullable_to_non_nullable
as dynamic,viewedProfileCount: freezed == viewedProfileCount ? _self.viewedProfileCount : viewedProfileCount // ignore: cast_nullable_to_non_nullable
as dynamic,viewedContactCount: freezed == viewedContactCount ? _self.viewedContactCount : viewedContactCount // ignore: cast_nullable_to_non_nullable
as dynamic,annocementBannerArr: freezed == annocementBannerArr ? _self.annocementBannerArr : annocementBannerArr // ignore: cast_nullable_to_non_nullable
as List<AnnouncementBanner>?,todayMatches: freezed == todayMatches ? _self.todayMatches : todayMatches // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recentlyJoinedMember: freezed == recentlyJoinedMember ? _self.recentlyJoinedMember : recentlyJoinedMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recommendedMatches: freezed == recommendedMatches ? _self.recommendedMatches : recommendedMatches // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,whoViewMyProfile: freezed == whoViewMyProfile ? _self.whoViewMyProfile : whoViewMyProfile // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,receivedInterest: freezed == receivedInterest ? _self.receivedInterest : receivedInterest // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recentlyLoginMember: freezed == recentlyLoginMember ? _self.recentlyLoginMember : recentlyLoginMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recommedMatchesMember: freezed == recommedMatchesMember ? _self.recommedMatchesMember : recommedMatchesMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,premiumMatchesMember: freezed == premiumMatchesMember ? _self.premiumMatchesMember : premiumMatchesMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,nearByMatchesMember: freezed == nearByMatchesMember ? _self.nearByMatchesMember : nearByMatchesMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,featuredMember: freezed == featuredMember ? _self.featuredMember : featuredMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,successStories: freezed == successStories ? _self.successStories : successStories // ignore: cast_nullable_to_non_nullable
as List<SuccessStory>?,planStatus: freezed == planStatus ? _self.planStatus : planStatus // ignore: cast_nullable_to_non_nullable
as String?,currentPlan: freezed == currentPlan ? _self.currentPlan : currentPlan // ignore: cast_nullable_to_non_nullable
as CurrentPlan?,autoInterestEnabled: freezed == autoInterestEnabled ? _self.autoInterestEnabled : autoInterestEnabled // ignore: cast_nullable_to_non_nullable
as int?,dailyInterestLimit: freezed == dailyInterestLimit ? _self.dailyInterestLimit : dailyInterestLimit // ignore: cast_nullable_to_non_nullable
as int?,minMatchPercentage: freezed == minMatchPercentage ? _self.minMatchPercentage : minMatchPercentage // ignore: cast_nullable_to_non_nullable
as int?,siteSetting: freezed == siteSetting ? _self.siteSetting : siteSetting // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String?,androidDeviceId: freezed == androidDeviceId ? _self.androidDeviceId : androidDeviceId // ignore: cast_nullable_to_non_nullable
as String?,iosDeviceId: freezed == iosDeviceId ? _self.iosDeviceId : iosDeviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanCopyWith<$Res>? get currentPlan {
    if (_self.currentPlan == null) {
    return null;
  }

  return $CurrentPlanCopyWith<$Res>(_self.currentPlan!, (value) {
    return _then(_self.copyWith(currentPlan: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardData].
extension DashboardDataPatterns on DashboardData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardData value)  $default,){
final _that = this;
switch (_that) {
case _DashboardData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardData value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'user_type')  dynamic userType, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_percentage')  dynamic profilePercentage, @JsonKey(name: 'unreadChatCount')  int? unreadChatCount, @JsonKey(name: 'unread_notification_count')  int? unreadNotificationCount, @JsonKey(name: 'mobile_verify_status')  String? mobileVerifyStatus, @JsonKey(name: 'email_verify_status')  String? emailVerifyStatus, @JsonKey(name: 'call_count')  int? callCount,  int? suggestedMatchCount,  int? fixMeetingsCount,  int? todayNoMeeting, @JsonKey(name: 'matches_count')  int? matchesCount,  int? voiceCallCount, @JsonKey(name: 'chat_count')  int? chatCount, @JsonKey(name: 'photos_count')  int? photosCount, @JsonKey(name: 'interest_count')  dynamic interestCount,  dynamic shortlistCount,  dynamic blockedCount,  dynamic photoRequestCount,  dynamic viewedProfileCount,  dynamic viewedContactCount,  List<AnnouncementBanner>? annocementBannerArr,  List<MemberListModel>? todayMatches,  List<MemberListModel>? recentlyJoinedMember,  List<MemberListModel>? recommendedMatches,  List<MemberListModel>? whoViewMyProfile, @JsonKey(name: 'interest_list')  List<MemberListModel>? receivedInterest,  List<MemberListModel>? recentlyLoginMember,  List<MemberListModel>? recommedMatchesMember,  List<MemberListModel>? premiumMatchesMember,  List<MemberListModel>? nearByMatchesMember, @JsonKey(name: 'featuredMember')  List<MemberListModel>? featuredMember, @JsonKey(name: 'successStories')  List<SuccessStory>? successStories, @JsonKey(name: 'plan_status')  String? planStatus, @JsonKey(name: 'current_plan')  CurrentPlan? currentPlan, @JsonKey(name: 'auto_interest_enabled')  int? autoInterestEnabled, @JsonKey(name: 'daily_interest_limit')  int? dailyInterestLimit, @JsonKey(name: 'min_match_percentage')  int? minMatchPercentage, @JsonKey(name: 'site_setting')  Map<String, dynamic>? siteSetting, @JsonKey(name: 'latitude')  String? latitude, @JsonKey(name: 'longitude')  String? longitude, @JsonKey(name: 'android_device_id')  String? androidDeviceId, @JsonKey(name: 'ios_device_id')  String? iosDeviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.profileImage,_that.userType,_that.profileTitle,_that.subTitle,_that.profilePercentage,_that.unreadChatCount,_that.unreadNotificationCount,_that.mobileVerifyStatus,_that.emailVerifyStatus,_that.callCount,_that.suggestedMatchCount,_that.fixMeetingsCount,_that.todayNoMeeting,_that.matchesCount,_that.voiceCallCount,_that.chatCount,_that.photosCount,_that.interestCount,_that.shortlistCount,_that.blockedCount,_that.photoRequestCount,_that.viewedProfileCount,_that.viewedContactCount,_that.annocementBannerArr,_that.todayMatches,_that.recentlyJoinedMember,_that.recommendedMatches,_that.whoViewMyProfile,_that.receivedInterest,_that.recentlyLoginMember,_that.recommedMatchesMember,_that.premiumMatchesMember,_that.nearByMatchesMember,_that.featuredMember,_that.successStories,_that.planStatus,_that.currentPlan,_that.autoInterestEnabled,_that.dailyInterestLimit,_that.minMatchPercentage,_that.siteSetting,_that.latitude,_that.longitude,_that.androidDeviceId,_that.iosDeviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'user_type')  dynamic userType, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_percentage')  dynamic profilePercentage, @JsonKey(name: 'unreadChatCount')  int? unreadChatCount, @JsonKey(name: 'unread_notification_count')  int? unreadNotificationCount, @JsonKey(name: 'mobile_verify_status')  String? mobileVerifyStatus, @JsonKey(name: 'email_verify_status')  String? emailVerifyStatus, @JsonKey(name: 'call_count')  int? callCount,  int? suggestedMatchCount,  int? fixMeetingsCount,  int? todayNoMeeting, @JsonKey(name: 'matches_count')  int? matchesCount,  int? voiceCallCount, @JsonKey(name: 'chat_count')  int? chatCount, @JsonKey(name: 'photos_count')  int? photosCount, @JsonKey(name: 'interest_count')  dynamic interestCount,  dynamic shortlistCount,  dynamic blockedCount,  dynamic photoRequestCount,  dynamic viewedProfileCount,  dynamic viewedContactCount,  List<AnnouncementBanner>? annocementBannerArr,  List<MemberListModel>? todayMatches,  List<MemberListModel>? recentlyJoinedMember,  List<MemberListModel>? recommendedMatches,  List<MemberListModel>? whoViewMyProfile, @JsonKey(name: 'interest_list')  List<MemberListModel>? receivedInterest,  List<MemberListModel>? recentlyLoginMember,  List<MemberListModel>? recommedMatchesMember,  List<MemberListModel>? premiumMatchesMember,  List<MemberListModel>? nearByMatchesMember, @JsonKey(name: 'featuredMember')  List<MemberListModel>? featuredMember, @JsonKey(name: 'successStories')  List<SuccessStory>? successStories, @JsonKey(name: 'plan_status')  String? planStatus, @JsonKey(name: 'current_plan')  CurrentPlan? currentPlan, @JsonKey(name: 'auto_interest_enabled')  int? autoInterestEnabled, @JsonKey(name: 'daily_interest_limit')  int? dailyInterestLimit, @JsonKey(name: 'min_match_percentage')  int? minMatchPercentage, @JsonKey(name: 'site_setting')  Map<String, dynamic>? siteSetting, @JsonKey(name: 'latitude')  String? latitude, @JsonKey(name: 'longitude')  String? longitude, @JsonKey(name: 'android_device_id')  String? androidDeviceId, @JsonKey(name: 'ios_device_id')  String? iosDeviceId)  $default,) {final _that = this;
switch (_that) {
case _DashboardData():
return $default(_that.profileImage,_that.userType,_that.profileTitle,_that.subTitle,_that.profilePercentage,_that.unreadChatCount,_that.unreadNotificationCount,_that.mobileVerifyStatus,_that.emailVerifyStatus,_that.callCount,_that.suggestedMatchCount,_that.fixMeetingsCount,_that.todayNoMeeting,_that.matchesCount,_that.voiceCallCount,_that.chatCount,_that.photosCount,_that.interestCount,_that.shortlistCount,_that.blockedCount,_that.photoRequestCount,_that.viewedProfileCount,_that.viewedContactCount,_that.annocementBannerArr,_that.todayMatches,_that.recentlyJoinedMember,_that.recommendedMatches,_that.whoViewMyProfile,_that.receivedInterest,_that.recentlyLoginMember,_that.recommedMatchesMember,_that.premiumMatchesMember,_that.nearByMatchesMember,_that.featuredMember,_that.successStories,_that.planStatus,_that.currentPlan,_that.autoInterestEnabled,_that.dailyInterestLimit,_that.minMatchPercentage,_that.siteSetting,_that.latitude,_that.longitude,_that.androidDeviceId,_that.iosDeviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'user_type')  dynamic userType, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_percentage')  dynamic profilePercentage, @JsonKey(name: 'unreadChatCount')  int? unreadChatCount, @JsonKey(name: 'unread_notification_count')  int? unreadNotificationCount, @JsonKey(name: 'mobile_verify_status')  String? mobileVerifyStatus, @JsonKey(name: 'email_verify_status')  String? emailVerifyStatus, @JsonKey(name: 'call_count')  int? callCount,  int? suggestedMatchCount,  int? fixMeetingsCount,  int? todayNoMeeting, @JsonKey(name: 'matches_count')  int? matchesCount,  int? voiceCallCount, @JsonKey(name: 'chat_count')  int? chatCount, @JsonKey(name: 'photos_count')  int? photosCount, @JsonKey(name: 'interest_count')  dynamic interestCount,  dynamic shortlistCount,  dynamic blockedCount,  dynamic photoRequestCount,  dynamic viewedProfileCount,  dynamic viewedContactCount,  List<AnnouncementBanner>? annocementBannerArr,  List<MemberListModel>? todayMatches,  List<MemberListModel>? recentlyJoinedMember,  List<MemberListModel>? recommendedMatches,  List<MemberListModel>? whoViewMyProfile, @JsonKey(name: 'interest_list')  List<MemberListModel>? receivedInterest,  List<MemberListModel>? recentlyLoginMember,  List<MemberListModel>? recommedMatchesMember,  List<MemberListModel>? premiumMatchesMember,  List<MemberListModel>? nearByMatchesMember, @JsonKey(name: 'featuredMember')  List<MemberListModel>? featuredMember, @JsonKey(name: 'successStories')  List<SuccessStory>? successStories, @JsonKey(name: 'plan_status')  String? planStatus, @JsonKey(name: 'current_plan')  CurrentPlan? currentPlan, @JsonKey(name: 'auto_interest_enabled')  int? autoInterestEnabled, @JsonKey(name: 'daily_interest_limit')  int? dailyInterestLimit, @JsonKey(name: 'min_match_percentage')  int? minMatchPercentage, @JsonKey(name: 'site_setting')  Map<String, dynamic>? siteSetting, @JsonKey(name: 'latitude')  String? latitude, @JsonKey(name: 'longitude')  String? longitude, @JsonKey(name: 'android_device_id')  String? androidDeviceId, @JsonKey(name: 'ios_device_id')  String? iosDeviceId)?  $default,) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.profileImage,_that.userType,_that.profileTitle,_that.subTitle,_that.profilePercentage,_that.unreadChatCount,_that.unreadNotificationCount,_that.mobileVerifyStatus,_that.emailVerifyStatus,_that.callCount,_that.suggestedMatchCount,_that.fixMeetingsCount,_that.todayNoMeeting,_that.matchesCount,_that.voiceCallCount,_that.chatCount,_that.photosCount,_that.interestCount,_that.shortlistCount,_that.blockedCount,_that.photoRequestCount,_that.viewedProfileCount,_that.viewedContactCount,_that.annocementBannerArr,_that.todayMatches,_that.recentlyJoinedMember,_that.recommendedMatches,_that.whoViewMyProfile,_that.receivedInterest,_that.recentlyLoginMember,_that.recommedMatchesMember,_that.premiumMatchesMember,_that.nearByMatchesMember,_that.featuredMember,_that.successStories,_that.planStatus,_that.currentPlan,_that.autoInterestEnabled,_that.dailyInterestLimit,_that.minMatchPercentage,_that.siteSetting,_that.latitude,_that.longitude,_that.androidDeviceId,_that.iosDeviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardData implements DashboardData {
  const _DashboardData({@JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'user_type') this.userType, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'profile_percentage') this.profilePercentage, @JsonKey(name: 'unreadChatCount') this.unreadChatCount, @JsonKey(name: 'unread_notification_count') this.unreadNotificationCount, @JsonKey(name: 'mobile_verify_status') this.mobileVerifyStatus, @JsonKey(name: 'email_verify_status') this.emailVerifyStatus, @JsonKey(name: 'call_count') this.callCount, this.suggestedMatchCount, this.fixMeetingsCount, this.todayNoMeeting, @JsonKey(name: 'matches_count') this.matchesCount, this.voiceCallCount, @JsonKey(name: 'chat_count') this.chatCount, @JsonKey(name: 'photos_count') this.photosCount, @JsonKey(name: 'interest_count') this.interestCount, this.shortlistCount, this.blockedCount, this.photoRequestCount, this.viewedProfileCount, this.viewedContactCount,  List<AnnouncementBanner>? annocementBannerArr,  List<MemberListModel>? todayMatches,  List<MemberListModel>? recentlyJoinedMember,  List<MemberListModel>? recommendedMatches,  List<MemberListModel>? whoViewMyProfile, @JsonKey(name: 'interest_list')  List<MemberListModel>? receivedInterest,  List<MemberListModel>? recentlyLoginMember,  List<MemberListModel>? recommedMatchesMember,  List<MemberListModel>? premiumMatchesMember,  List<MemberListModel>? nearByMatchesMember, @JsonKey(name: 'featuredMember')  List<MemberListModel>? featuredMember, @JsonKey(name: 'successStories')  List<SuccessStory>? successStories, @JsonKey(name: 'plan_status') this.planStatus, @JsonKey(name: 'current_plan') this.currentPlan, @JsonKey(name: 'auto_interest_enabled') this.autoInterestEnabled, @JsonKey(name: 'daily_interest_limit') this.dailyInterestLimit, @JsonKey(name: 'min_match_percentage') this.minMatchPercentage, @JsonKey(name: 'site_setting')  Map<String, dynamic>? siteSetting, @JsonKey(name: 'latitude') this.latitude, @JsonKey(name: 'longitude') this.longitude, @JsonKey(name: 'android_device_id') this.androidDeviceId, @JsonKey(name: 'ios_device_id') this.iosDeviceId}): _annocementBannerArr = annocementBannerArr,_todayMatches = todayMatches,_recentlyJoinedMember = recentlyJoinedMember,_recommendedMatches = recommendedMatches,_whoViewMyProfile = whoViewMyProfile,_receivedInterest = receivedInterest,_recentlyLoginMember = recentlyLoginMember,_recommedMatchesMember = recommedMatchesMember,_premiumMatchesMember = premiumMatchesMember,_nearByMatchesMember = nearByMatchesMember,_featuredMember = featuredMember,_successStories = successStories,_siteSetting = siteSetting;
  factory _DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

@override@JsonKey(name: 'profile_image') final  String? profileImage;
@override@JsonKey(name: 'user_type') final  dynamic userType;
@override@JsonKey(name: 'profile_title') final  String? profileTitle;
@override@JsonKey(name: 'sub_title') final  String? subTitle;
@override@JsonKey(name: 'profile_percentage') final  dynamic profilePercentage;
@override@JsonKey(name: 'unreadChatCount') final  int? unreadChatCount;
@override@JsonKey(name: 'unread_notification_count') final  int? unreadNotificationCount;
@override@JsonKey(name: 'mobile_verify_status') final  String? mobileVerifyStatus;
@override@JsonKey(name: 'email_verify_status') final  String? emailVerifyStatus;
@override@JsonKey(name: 'call_count') final  int? callCount;
@override final  int? suggestedMatchCount;
@override final  int? fixMeetingsCount;
@override final  int? todayNoMeeting;
@override@JsonKey(name: 'matches_count') final  int? matchesCount;
@override final  int? voiceCallCount;
@override@JsonKey(name: 'chat_count') final  int? chatCount;
@override@JsonKey(name: 'photos_count') final  int? photosCount;
@override@JsonKey(name: 'interest_count') final  dynamic interestCount;
@override final  dynamic shortlistCount;
@override final  dynamic blockedCount;
@override final  dynamic photoRequestCount;
@override final  dynamic viewedProfileCount;
@override final  dynamic viewedContactCount;
 final  List<AnnouncementBanner>? _annocementBannerArr;
@override List<AnnouncementBanner>? get annocementBannerArr {
  final value = _annocementBannerArr;
  if (value == null) return null;
  if (_annocementBannerArr is EqualUnmodifiableListView) return _annocementBannerArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _todayMatches;
@override List<MemberListModel>? get todayMatches {
  final value = _todayMatches;
  if (value == null) return null;
  if (_todayMatches is EqualUnmodifiableListView) return _todayMatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _recentlyJoinedMember;
@override List<MemberListModel>? get recentlyJoinedMember {
  final value = _recentlyJoinedMember;
  if (value == null) return null;
  if (_recentlyJoinedMember is EqualUnmodifiableListView) return _recentlyJoinedMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _recommendedMatches;
@override List<MemberListModel>? get recommendedMatches {
  final value = _recommendedMatches;
  if (value == null) return null;
  if (_recommendedMatches is EqualUnmodifiableListView) return _recommendedMatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _whoViewMyProfile;
@override List<MemberListModel>? get whoViewMyProfile {
  final value = _whoViewMyProfile;
  if (value == null) return null;
  if (_whoViewMyProfile is EqualUnmodifiableListView) return _whoViewMyProfile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _receivedInterest;
@override@JsonKey(name: 'interest_list') List<MemberListModel>? get receivedInterest {
  final value = _receivedInterest;
  if (value == null) return null;
  if (_receivedInterest is EqualUnmodifiableListView) return _receivedInterest;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _recentlyLoginMember;
@override List<MemberListModel>? get recentlyLoginMember {
  final value = _recentlyLoginMember;
  if (value == null) return null;
  if (_recentlyLoginMember is EqualUnmodifiableListView) return _recentlyLoginMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _recommedMatchesMember;
@override List<MemberListModel>? get recommedMatchesMember {
  final value = _recommedMatchesMember;
  if (value == null) return null;
  if (_recommedMatchesMember is EqualUnmodifiableListView) return _recommedMatchesMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _premiumMatchesMember;
@override List<MemberListModel>? get premiumMatchesMember {
  final value = _premiumMatchesMember;
  if (value == null) return null;
  if (_premiumMatchesMember is EqualUnmodifiableListView) return _premiumMatchesMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _nearByMatchesMember;
@override List<MemberListModel>? get nearByMatchesMember {
  final value = _nearByMatchesMember;
  if (value == null) return null;
  if (_nearByMatchesMember is EqualUnmodifiableListView) return _nearByMatchesMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MemberListModel>? _featuredMember;
@override@JsonKey(name: 'featuredMember') List<MemberListModel>? get featuredMember {
  final value = _featuredMember;
  if (value == null) return null;
  if (_featuredMember is EqualUnmodifiableListView) return _featuredMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<SuccessStory>? _successStories;
@override@JsonKey(name: 'successStories') List<SuccessStory>? get successStories {
  final value = _successStories;
  if (value == null) return null;
  if (_successStories is EqualUnmodifiableListView) return _successStories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'plan_status') final  String? planStatus;
@override@JsonKey(name: 'current_plan') final  CurrentPlan? currentPlan;
@override@JsonKey(name: 'auto_interest_enabled') final  int? autoInterestEnabled;
@override@JsonKey(name: 'daily_interest_limit') final  int? dailyInterestLimit;
@override@JsonKey(name: 'min_match_percentage') final  int? minMatchPercentage;
 final  Map<String, dynamic>? _siteSetting;
@override@JsonKey(name: 'site_setting') Map<String, dynamic>? get siteSetting {
  final value = _siteSetting;
  if (value == null) return null;
  if (_siteSetting is EqualUnmodifiableMapView) return _siteSetting;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'latitude') final  String? latitude;
@override@JsonKey(name: 'longitude') final  String? longitude;
@override@JsonKey(name: 'android_device_id') final  String? androidDeviceId;
@override@JsonKey(name: 'ios_device_id') final  String? iosDeviceId;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataCopyWith<_DashboardData> get copyWith => __$DashboardDataCopyWithImpl<_DashboardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardData&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&const DeepCollectionEquality().equals(other.userType, userType)&&(identical(other.profileTitle, profileTitle) || other.profileTitle == profileTitle)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&const DeepCollectionEquality().equals(other.profilePercentage, profilePercentage)&&(identical(other.unreadChatCount, unreadChatCount) || other.unreadChatCount == unreadChatCount)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.mobileVerifyStatus, mobileVerifyStatus) || other.mobileVerifyStatus == mobileVerifyStatus)&&(identical(other.emailVerifyStatus, emailVerifyStatus) || other.emailVerifyStatus == emailVerifyStatus)&&(identical(other.callCount, callCount) || other.callCount == callCount)&&(identical(other.suggestedMatchCount, suggestedMatchCount) || other.suggestedMatchCount == suggestedMatchCount)&&(identical(other.fixMeetingsCount, fixMeetingsCount) || other.fixMeetingsCount == fixMeetingsCount)&&(identical(other.todayNoMeeting, todayNoMeeting) || other.todayNoMeeting == todayNoMeeting)&&(identical(other.matchesCount, matchesCount) || other.matchesCount == matchesCount)&&(identical(other.voiceCallCount, voiceCallCount) || other.voiceCallCount == voiceCallCount)&&(identical(other.chatCount, chatCount) || other.chatCount == chatCount)&&(identical(other.photosCount, photosCount) || other.photosCount == photosCount)&&const DeepCollectionEquality().equals(other.interestCount, interestCount)&&const DeepCollectionEquality().equals(other.shortlistCount, shortlistCount)&&const DeepCollectionEquality().equals(other.blockedCount, blockedCount)&&const DeepCollectionEquality().equals(other.photoRequestCount, photoRequestCount)&&const DeepCollectionEquality().equals(other.viewedProfileCount, viewedProfileCount)&&const DeepCollectionEquality().equals(other.viewedContactCount, viewedContactCount)&&const DeepCollectionEquality().equals(other.annocementBannerArr, _annocementBannerArr)&&const DeepCollectionEquality().equals(other.todayMatches, _todayMatches)&&const DeepCollectionEquality().equals(other.recentlyJoinedMember, _recentlyJoinedMember)&&const DeepCollectionEquality().equals(other.recommendedMatches, _recommendedMatches)&&const DeepCollectionEquality().equals(other.whoViewMyProfile, _whoViewMyProfile)&&const DeepCollectionEquality().equals(other.receivedInterest, _receivedInterest)&&const DeepCollectionEquality().equals(other.recentlyLoginMember, _recentlyLoginMember)&&const DeepCollectionEquality().equals(other.recommedMatchesMember, _recommedMatchesMember)&&const DeepCollectionEquality().equals(other.premiumMatchesMember, _premiumMatchesMember)&&const DeepCollectionEquality().equals(other.nearByMatchesMember, _nearByMatchesMember)&&const DeepCollectionEquality().equals(other.featuredMember, _featuredMember)&&const DeepCollectionEquality().equals(other.successStories, _successStories)&&(identical(other.planStatus, planStatus) || other.planStatus == planStatus)&&(identical(other.currentPlan, currentPlan) || other.currentPlan == currentPlan)&&(identical(other.autoInterestEnabled, autoInterestEnabled) || other.autoInterestEnabled == autoInterestEnabled)&&(identical(other.dailyInterestLimit, dailyInterestLimit) || other.dailyInterestLimit == dailyInterestLimit)&&(identical(other.minMatchPercentage, minMatchPercentage) || other.minMatchPercentage == minMatchPercentage)&&const DeepCollectionEquality().equals(other.siteSetting, _siteSetting)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.androidDeviceId, androidDeviceId) || other.androidDeviceId == androidDeviceId)&&(identical(other.iosDeviceId, iosDeviceId) || other.iosDeviceId == iosDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,profileImage,const DeepCollectionEquality().hash(userType),profileTitle,subTitle,const DeepCollectionEquality().hash(profilePercentage),unreadChatCount,unreadNotificationCount,mobileVerifyStatus,emailVerifyStatus,callCount,suggestedMatchCount,fixMeetingsCount,todayNoMeeting,matchesCount,voiceCallCount,chatCount,photosCount,const DeepCollectionEquality().hash(interestCount),const DeepCollectionEquality().hash(shortlistCount),const DeepCollectionEquality().hash(blockedCount),const DeepCollectionEquality().hash(photoRequestCount),const DeepCollectionEquality().hash(viewedProfileCount),const DeepCollectionEquality().hash(viewedContactCount),const DeepCollectionEquality().hash(_annocementBannerArr),const DeepCollectionEquality().hash(_todayMatches),const DeepCollectionEquality().hash(_recentlyJoinedMember),const DeepCollectionEquality().hash(_recommendedMatches),const DeepCollectionEquality().hash(_whoViewMyProfile),const DeepCollectionEquality().hash(_receivedInterest),const DeepCollectionEquality().hash(_recentlyLoginMember),const DeepCollectionEquality().hash(_recommedMatchesMember),const DeepCollectionEquality().hash(_premiumMatchesMember),const DeepCollectionEquality().hash(_nearByMatchesMember),const DeepCollectionEquality().hash(_featuredMember),const DeepCollectionEquality().hash(_successStories),planStatus,currentPlan,autoInterestEnabled,dailyInterestLimit,minMatchPercentage,const DeepCollectionEquality().hash(_siteSetting),latitude,longitude,androidDeviceId,iosDeviceId]);
}

@override
String toString() {
    return 'DashboardData(profileImage: $profileImage, userType: $userType, profileTitle: $profileTitle, subTitle: $subTitle, profilePercentage: $profilePercentage, unreadChatCount: $unreadChatCount, unreadNotificationCount: $unreadNotificationCount, mobileVerifyStatus: $mobileVerifyStatus, emailVerifyStatus: $emailVerifyStatus, callCount: $callCount, suggestedMatchCount: $suggestedMatchCount, fixMeetingsCount: $fixMeetingsCount, todayNoMeeting: $todayNoMeeting, matchesCount: $matchesCount, voiceCallCount: $voiceCallCount, chatCount: $chatCount, photosCount: $photosCount, interestCount: $interestCount, shortlistCount: $shortlistCount, blockedCount: $blockedCount, photoRequestCount: $photoRequestCount, viewedProfileCount: $viewedProfileCount, viewedContactCount: $viewedContactCount, annocementBannerArr: $annocementBannerArr, todayMatches: $todayMatches, recentlyJoinedMember: $recentlyJoinedMember, recommendedMatches: $recommendedMatches, whoViewMyProfile: $whoViewMyProfile, receivedInterest: $receivedInterest, recentlyLoginMember: $recentlyLoginMember, recommedMatchesMember: $recommedMatchesMember, premiumMatchesMember: $premiumMatchesMember, nearByMatchesMember: $nearByMatchesMember, featuredMember: $featuredMember, successStories: $successStories, planStatus: $planStatus, currentPlan: $currentPlan, autoInterestEnabled: $autoInterestEnabled, dailyInterestLimit: $dailyInterestLimit, minMatchPercentage: $minMatchPercentage, siteSetting: $siteSetting, latitude: $latitude, longitude: $longitude, androidDeviceId: $androidDeviceId, iosDeviceId: $iosDeviceId)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataCopyWith<$Res> implements $DashboardDataCopyWith<$Res> {
  factory _$DashboardDataCopyWith(_DashboardData value, $Res Function(_DashboardData) _then) = __$DashboardDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'user_type') dynamic userType,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_percentage') dynamic profilePercentage,@JsonKey(name: 'unreadChatCount') int? unreadChatCount,@JsonKey(name: 'unread_notification_count') int? unreadNotificationCount,@JsonKey(name: 'mobile_verify_status') String? mobileVerifyStatus,@JsonKey(name: 'email_verify_status') String? emailVerifyStatus,@JsonKey(name: 'call_count') int? callCount, int? suggestedMatchCount, int? fixMeetingsCount, int? todayNoMeeting,@JsonKey(name: 'matches_count') int? matchesCount, int? voiceCallCount,@JsonKey(name: 'chat_count') int? chatCount,@JsonKey(name: 'photos_count') int? photosCount,@JsonKey(name: 'interest_count') dynamic interestCount, dynamic shortlistCount, dynamic blockedCount, dynamic photoRequestCount, dynamic viewedProfileCount, dynamic viewedContactCount, List<AnnouncementBanner>? annocementBannerArr, List<MemberListModel>? todayMatches, List<MemberListModel>? recentlyJoinedMember, List<MemberListModel>? recommendedMatches, List<MemberListModel>? whoViewMyProfile,@JsonKey(name: 'interest_list') List<MemberListModel>? receivedInterest, List<MemberListModel>? recentlyLoginMember, List<MemberListModel>? recommedMatchesMember, List<MemberListModel>? premiumMatchesMember, List<MemberListModel>? nearByMatchesMember,@JsonKey(name: 'featuredMember') List<MemberListModel>? featuredMember,@JsonKey(name: 'successStories') List<SuccessStory>? successStories,@JsonKey(name: 'plan_status') String? planStatus,@JsonKey(name: 'current_plan') CurrentPlan? currentPlan,@JsonKey(name: 'auto_interest_enabled') int? autoInterestEnabled,@JsonKey(name: 'daily_interest_limit') int? dailyInterestLimit,@JsonKey(name: 'min_match_percentage') int? minMatchPercentage,@JsonKey(name: 'site_setting') Map<String, dynamic>? siteSetting,@JsonKey(name: 'latitude') String? latitude,@JsonKey(name: 'longitude') String? longitude,@JsonKey(name: 'android_device_id') String? androidDeviceId,@JsonKey(name: 'ios_device_id') String? iosDeviceId
});


@override $CurrentPlanCopyWith<$Res>? get currentPlan;

}
/// @nodoc
class __$DashboardDataCopyWithImpl<$Res>
    implements _$DashboardDataCopyWith<$Res> {
  __$DashboardDataCopyWithImpl(this._self, this._then);

  final _DashboardData _self;
  final $Res Function(_DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileImage = freezed,Object? userType = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profilePercentage = freezed,Object? unreadChatCount = freezed,Object? unreadNotificationCount = freezed,Object? mobileVerifyStatus = freezed,Object? emailVerifyStatus = freezed,Object? callCount = freezed,Object? suggestedMatchCount = freezed,Object? fixMeetingsCount = freezed,Object? todayNoMeeting = freezed,Object? matchesCount = freezed,Object? voiceCallCount = freezed,Object? chatCount = freezed,Object? photosCount = freezed,Object? interestCount = freezed,Object? shortlistCount = freezed,Object? blockedCount = freezed,Object? photoRequestCount = freezed,Object? viewedProfileCount = freezed,Object? viewedContactCount = freezed,Object? annocementBannerArr = freezed,Object? todayMatches = freezed,Object? recentlyJoinedMember = freezed,Object? recommendedMatches = freezed,Object? whoViewMyProfile = freezed,Object? receivedInterest = freezed,Object? recentlyLoginMember = freezed,Object? recommedMatchesMember = freezed,Object? premiumMatchesMember = freezed,Object? nearByMatchesMember = freezed,Object? featuredMember = freezed,Object? successStories = freezed,Object? planStatus = freezed,Object? currentPlan = freezed,Object? autoInterestEnabled = freezed,Object? dailyInterestLimit = freezed,Object? minMatchPercentage = freezed,Object? siteSetting = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? androidDeviceId = freezed,Object? iosDeviceId = freezed,}) {
  return _then(_DashboardData(
profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profilePercentage: freezed == profilePercentage ? _self.profilePercentage : profilePercentage // ignore: cast_nullable_to_non_nullable
as dynamic,unreadChatCount: freezed == unreadChatCount ? _self.unreadChatCount : unreadChatCount // ignore: cast_nullable_to_non_nullable
as int?,unreadNotificationCount: freezed == unreadNotificationCount ? _self.unreadNotificationCount : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
as int?,mobileVerifyStatus: freezed == mobileVerifyStatus ? _self.mobileVerifyStatus : mobileVerifyStatus // ignore: cast_nullable_to_non_nullable
as String?,emailVerifyStatus: freezed == emailVerifyStatus ? _self.emailVerifyStatus : emailVerifyStatus // ignore: cast_nullable_to_non_nullable
as String?,callCount: freezed == callCount ? _self.callCount : callCount // ignore: cast_nullable_to_non_nullable
as int?,suggestedMatchCount: freezed == suggestedMatchCount ? _self.suggestedMatchCount : suggestedMatchCount // ignore: cast_nullable_to_non_nullable
as int?,fixMeetingsCount: freezed == fixMeetingsCount ? _self.fixMeetingsCount : fixMeetingsCount // ignore: cast_nullable_to_non_nullable
as int?,todayNoMeeting: freezed == todayNoMeeting ? _self.todayNoMeeting : todayNoMeeting // ignore: cast_nullable_to_non_nullable
as int?,matchesCount: freezed == matchesCount ? _self.matchesCount : matchesCount // ignore: cast_nullable_to_non_nullable
as int?,voiceCallCount: freezed == voiceCallCount ? _self.voiceCallCount : voiceCallCount // ignore: cast_nullable_to_non_nullable
as int?,chatCount: freezed == chatCount ? _self.chatCount : chatCount // ignore: cast_nullable_to_non_nullable
as int?,photosCount: freezed == photosCount ? _self.photosCount : photosCount // ignore: cast_nullable_to_non_nullable
as int?,interestCount: freezed == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as dynamic,shortlistCount: freezed == shortlistCount ? _self.shortlistCount : shortlistCount // ignore: cast_nullable_to_non_nullable
as dynamic,blockedCount: freezed == blockedCount ? _self.blockedCount : blockedCount // ignore: cast_nullable_to_non_nullable
as dynamic,photoRequestCount: freezed == photoRequestCount ? _self.photoRequestCount : photoRequestCount // ignore: cast_nullable_to_non_nullable
as dynamic,viewedProfileCount: freezed == viewedProfileCount ? _self.viewedProfileCount : viewedProfileCount // ignore: cast_nullable_to_non_nullable
as dynamic,viewedContactCount: freezed == viewedContactCount ? _self.viewedContactCount : viewedContactCount // ignore: cast_nullable_to_non_nullable
as dynamic,annocementBannerArr: freezed == annocementBannerArr ? _self._annocementBannerArr : annocementBannerArr // ignore: cast_nullable_to_non_nullable
as List<AnnouncementBanner>?,todayMatches: freezed == todayMatches ? _self._todayMatches : todayMatches // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recentlyJoinedMember: freezed == recentlyJoinedMember ? _self._recentlyJoinedMember : recentlyJoinedMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recommendedMatches: freezed == recommendedMatches ? _self._recommendedMatches : recommendedMatches // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,whoViewMyProfile: freezed == whoViewMyProfile ? _self._whoViewMyProfile : whoViewMyProfile // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,receivedInterest: freezed == receivedInterest ? _self._receivedInterest : receivedInterest // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recentlyLoginMember: freezed == recentlyLoginMember ? _self._recentlyLoginMember : recentlyLoginMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,recommedMatchesMember: freezed == recommedMatchesMember ? _self._recommedMatchesMember : recommedMatchesMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,premiumMatchesMember: freezed == premiumMatchesMember ? _self._premiumMatchesMember : premiumMatchesMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,nearByMatchesMember: freezed == nearByMatchesMember ? _self._nearByMatchesMember : nearByMatchesMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,featuredMember: freezed == featuredMember ? _self._featuredMember : featuredMember // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,successStories: freezed == successStories ? _self._successStories : successStories // ignore: cast_nullable_to_non_nullable
as List<SuccessStory>?,planStatus: freezed == planStatus ? _self.planStatus : planStatus // ignore: cast_nullable_to_non_nullable
as String?,currentPlan: freezed == currentPlan ? _self.currentPlan : currentPlan // ignore: cast_nullable_to_non_nullable
as CurrentPlan?,autoInterestEnabled: freezed == autoInterestEnabled ? _self.autoInterestEnabled : autoInterestEnabled // ignore: cast_nullable_to_non_nullable
as int?,dailyInterestLimit: freezed == dailyInterestLimit ? _self.dailyInterestLimit : dailyInterestLimit // ignore: cast_nullable_to_non_nullable
as int?,minMatchPercentage: freezed == minMatchPercentage ? _self.minMatchPercentage : minMatchPercentage // ignore: cast_nullable_to_non_nullable
as int?,siteSetting: freezed == siteSetting ? _self._siteSetting : siteSetting // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String?,androidDeviceId: freezed == androidDeviceId ? _self.androidDeviceId : androidDeviceId // ignore: cast_nullable_to_non_nullable
as String?,iosDeviceId: freezed == iosDeviceId ? _self.iosDeviceId : iosDeviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanCopyWith<$Res>? get currentPlan {
    if (_self.currentPlan == null) {
    return null;
  }

  return $CurrentPlanCopyWith<$Res>(_self.currentPlan!, (value) {
    return _then(_self.copyWith(currentPlan: value));
  });
}
}


/// @nodoc
mixin _$AnnouncementBanner {

 int? get id; String? get image;@JsonKey(name: 'lang_code') String? get langCode;@JsonKey(name: 'lang_id') dynamic get langId; String? get status;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'is_deleted') dynamic get isDeleted;
/// Create a copy of AnnouncementBanner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementBannerCopyWith<AnnouncementBanner> get copyWith => _$AnnouncementBannerCopyWithImpl<AnnouncementBanner>(this as AnnouncementBanner, _$identity);

  /// Serializes this AnnouncementBanner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnnouncementBanner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementBanner&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.image, _this.image) || other.image == _this.image)&&(identical(other.langCode, _this.langCode) || other.langCode == _this.langCode)&&const DeepCollectionEquality().equals(other.langId, _this.langId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&const DeepCollectionEquality().equals(other.isDeleted, _this.isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnnouncementBanner;
  return Object.hash(runtimeType,_this.id,_this.image,_this.langCode,const DeepCollectionEquality().hash(_this.langId),_this.status,_this.createdAt,_this.updatedAt,const DeepCollectionEquality().hash(_this.isDeleted));
}

@override
String toString() {
  final _this = this as AnnouncementBanner;
  return 'AnnouncementBanner(id: ${_this.id}, image: ${_this.image}, langCode: ${_this.langCode}, langId: ${_this.langId}, status: ${_this.status}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, isDeleted: ${_this.isDeleted})';
}


}

/// @nodoc
abstract mixin class $AnnouncementBannerCopyWith<$Res>  {
  factory $AnnouncementBannerCopyWith(AnnouncementBanner value, $Res Function(AnnouncementBanner) _then) = _$AnnouncementBannerCopyWithImpl;
@useResult
$Res call({
 int? id, String? image,@JsonKey(name: 'lang_code') String? langCode,@JsonKey(name: 'lang_id') dynamic langId, String? status,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'is_deleted') dynamic isDeleted
});




}
/// @nodoc
class _$AnnouncementBannerCopyWithImpl<$Res>
    implements $AnnouncementBannerCopyWith<$Res> {
  _$AnnouncementBannerCopyWithImpl(this._self, this._then);

  final AnnouncementBanner _self;
  final $Res Function(AnnouncementBanner) _then;

/// Create a copy of AnnouncementBanner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? image = freezed,Object? langCode = freezed,Object? langId = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = freezed,}) {
  return _then(AnnouncementBanner(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,langCode: freezed == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String?,langId: freezed == langId ? _self.langId : langId // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementBanner].
extension AnnouncementBannerPatterns on AnnouncementBanner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementBanner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementBanner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementBanner value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementBanner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementBanner value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementBanner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? image, @JsonKey(name: 'lang_code')  String? langCode, @JsonKey(name: 'lang_id')  dynamic langId,  String? status, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementBanner() when $default != null:
return $default(_that.id,_that.image,_that.langCode,_that.langId,_that.status,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? image, @JsonKey(name: 'lang_code')  String? langCode, @JsonKey(name: 'lang_id')  dynamic langId,  String? status, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementBanner():
return $default(_that.id,_that.image,_that.langCode,_that.langId,_that.status,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? image, @JsonKey(name: 'lang_code')  String? langCode, @JsonKey(name: 'lang_id')  dynamic langId,  String? status, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementBanner() when $default != null:
return $default(_that.id,_that.image,_that.langCode,_that.langId,_that.status,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementBanner implements AnnouncementBanner {
  const _AnnouncementBanner({this.id, this.image, @JsonKey(name: 'lang_code') this.langCode, @JsonKey(name: 'lang_id') this.langId, this.status, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'is_deleted') this.isDeleted});
  factory _AnnouncementBanner.fromJson(Map<String, dynamic> json) => _$AnnouncementBannerFromJson(json);

@override final  int? id;
@override final  String? image;
@override@JsonKey(name: 'lang_code') final  String? langCode;
@override@JsonKey(name: 'lang_id') final  dynamic langId;
@override final  String? status;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'is_deleted') final  dynamic isDeleted;

/// Create a copy of AnnouncementBanner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementBannerCopyWith<_AnnouncementBanner> get copyWith => __$AnnouncementBannerCopyWithImpl<_AnnouncementBanner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementBannerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementBanner&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.langCode, langCode) || other.langCode == langCode)&&const DeepCollectionEquality().equals(other.langId, langId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.isDeleted, isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,image,langCode,const DeepCollectionEquality().hash(langId),status,createdAt,updatedAt,const DeepCollectionEquality().hash(isDeleted));
}

@override
String toString() {
    return 'AnnouncementBanner(id: $id, image: $image, langCode: $langCode, langId: $langId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementBannerCopyWith<$Res> implements $AnnouncementBannerCopyWith<$Res> {
  factory _$AnnouncementBannerCopyWith(_AnnouncementBanner value, $Res Function(_AnnouncementBanner) _then) = __$AnnouncementBannerCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? image,@JsonKey(name: 'lang_code') String? langCode,@JsonKey(name: 'lang_id') dynamic langId, String? status,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'is_deleted') dynamic isDeleted
});




}
/// @nodoc
class __$AnnouncementBannerCopyWithImpl<$Res>
    implements _$AnnouncementBannerCopyWith<$Res> {
  __$AnnouncementBannerCopyWithImpl(this._self, this._then);

  final _AnnouncementBanner _self;
  final $Res Function(_AnnouncementBanner) _then;

/// Create a copy of AnnouncementBanner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? image = freezed,Object? langCode = freezed,Object? langId = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = freezed,}) {
  return _then(_AnnouncementBanner(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,langCode: freezed == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String?,langId: freezed == langId ? _self.langId : langId // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
