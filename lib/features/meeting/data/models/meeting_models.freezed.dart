// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingListResponse {

 int? get code; String? get status; String? get message; MeetingData? get data;
/// Create a copy of MeetingListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingListResponseCopyWith<MeetingListResponse> get copyWith => _$MeetingListResponseCopyWithImpl<MeetingListResponse>(this as MeetingListResponse, _$identity);

  /// Serializes this MeetingListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingListResponse&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingListResponse;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as MeetingListResponse;
  return 'MeetingListResponse(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $MeetingListResponseCopyWith<$Res>  {
  factory $MeetingListResponseCopyWith(MeetingListResponse value, $Res Function(MeetingListResponse) _then) = _$MeetingListResponseCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, MeetingData? data
});


$MeetingDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$MeetingListResponseCopyWithImpl<$Res>
    implements $MeetingListResponseCopyWith<$Res> {
  _$MeetingListResponseCopyWithImpl(this._self, this._then);

  final MeetingListResponse _self;
  final $Res Function(MeetingListResponse) _then;

/// Create a copy of MeetingListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(MeetingListResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MeetingData?,
  ));
}
/// Create a copy of MeetingListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MeetingDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeetingListResponse].
extension MeetingListResponsePatterns on MeetingListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingListResponse value)  $default,){
final _that = this;
switch (_that) {
case _MeetingListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  MeetingData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  MeetingData? data)  $default,) {final _that = this;
switch (_that) {
case _MeetingListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  MeetingData? data)?  $default,) {final _that = this;
switch (_that) {
case _MeetingListResponse() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingListResponse implements MeetingListResponse {
  const _MeetingListResponse({this.code, this.status, this.message, this.data});
  factory _MeetingListResponse.fromJson(Map<String, dynamic> json) => _$MeetingListResponseFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  MeetingData? data;

/// Create a copy of MeetingListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingListResponseCopyWith<_MeetingListResponse> get copyWith => __$MeetingListResponseCopyWithImpl<_MeetingListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingListResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'MeetingListResponse(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MeetingListResponseCopyWith<$Res> implements $MeetingListResponseCopyWith<$Res> {
  factory _$MeetingListResponseCopyWith(_MeetingListResponse value, $Res Function(_MeetingListResponse) _then) = __$MeetingListResponseCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, MeetingData? data
});


@override $MeetingDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$MeetingListResponseCopyWithImpl<$Res>
    implements _$MeetingListResponseCopyWith<$Res> {
  __$MeetingListResponseCopyWithImpl(this._self, this._then);

  final _MeetingListResponse _self;
  final $Res Function(_MeetingListResponse) _then;

/// Create a copy of MeetingListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_MeetingListResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MeetingData?,
  ));
}

/// Create a copy of MeetingListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MeetingDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$MeetingData {

 int? get resultCount;@JsonKey(name: 'resultArr', readValue: _readResultList) List<Meeting>? get resultArr;
/// Create a copy of MeetingData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingDataCopyWith<MeetingData> get copyWith => _$MeetingDataCopyWithImpl<MeetingData>(this as MeetingData, _$identity);

  /// Serializes this MeetingData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultArr, _this.resultArr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultArr));
}

@override
String toString() {
  final _this = this as MeetingData;
  return 'MeetingData(resultCount: ${_this.resultCount}, resultArr: ${_this.resultArr})';
}


}

/// @nodoc
abstract mixin class $MeetingDataCopyWith<$Res>  {
  factory $MeetingDataCopyWith(MeetingData value, $Res Function(MeetingData) _then) = _$MeetingDataCopyWithImpl;
@useResult
$Res call({
 int? resultCount,@JsonKey(name: 'resultArr', readValue: _readResultList) List<Meeting>? resultArr
});




}
/// @nodoc
class _$MeetingDataCopyWithImpl<$Res>
    implements $MeetingDataCopyWith<$Res> {
  _$MeetingDataCopyWithImpl(this._self, this._then);

  final MeetingData _self;
  final $Res Function(MeetingData) _then;

/// Create a copy of MeetingData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultArr = freezed,}) {
  return _then(MeetingData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultArr: freezed == resultArr ? _self.resultArr : resultArr // ignore: cast_nullable_to_non_nullable
as List<Meeting>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingData].
extension MeetingDataPatterns on MeetingData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingData value)  $default,){
final _that = this;
switch (_that) {
case _MeetingData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingData value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<Meeting>? resultArr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingData() when $default != null:
return $default(_that.resultCount,_that.resultArr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<Meeting>? resultArr)  $default,) {final _that = this;
switch (_that) {
case _MeetingData():
return $default(_that.resultCount,_that.resultArr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<Meeting>? resultArr)?  $default,) {final _that = this;
switch (_that) {
case _MeetingData() when $default != null:
return $default(_that.resultCount,_that.resultArr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingData implements MeetingData {
  const _MeetingData({this.resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<Meeting>? resultArr}): _resultArr = resultArr;
  factory _MeetingData.fromJson(Map<String, dynamic> json) => _$MeetingDataFromJson(json);

@override final  int? resultCount;
 final  List<Meeting>? _resultArr;
@override@JsonKey(name: 'resultArr', readValue: _readResultList) List<Meeting>? get resultArr {
  final value = _resultArr;
  if (value == null) return null;
  if (_resultArr is EqualUnmodifiableListView) return _resultArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MeetingData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingDataCopyWith<_MeetingData> get copyWith => __$MeetingDataCopyWithImpl<_MeetingData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultArr, _resultArr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultArr));
}

@override
String toString() {
    return 'MeetingData(resultCount: $resultCount, resultArr: $resultArr)';
}


}

/// @nodoc
abstract mixin class _$MeetingDataCopyWith<$Res> implements $MeetingDataCopyWith<$Res> {
  factory _$MeetingDataCopyWith(_MeetingData value, $Res Function(_MeetingData) _then) = __$MeetingDataCopyWithImpl;
@override @useResult
$Res call({
 int? resultCount,@JsonKey(name: 'resultArr', readValue: _readResultList) List<Meeting>? resultArr
});




}
/// @nodoc
class __$MeetingDataCopyWithImpl<$Res>
    implements _$MeetingDataCopyWith<$Res> {
  __$MeetingDataCopyWithImpl(this._self, this._then);

  final _MeetingData _self;
  final $Res Function(_MeetingData) _then;

/// Create a copy of MeetingData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultArr = freezed,}) {
  return _then(_MeetingData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultArr: freezed == resultArr ? _self._resultArr : resultArr // ignore: cast_nullable_to_non_nullable
as List<Meeting>?,
  ));
}


}


/// @nodoc
mixin _$Meeting {

@JsonKey(name: 'member_id') dynamic get memberId;@JsonKey(name: 'first_name') dynamic get firstName;@JsonKey(name: 'matri_id') dynamic get matriId; dynamic get fullname; dynamic get gender; dynamic get birthdate; dynamic get photo1;@JsonKey(name: 'photo1_status') dynamic get photo1Status; dynamic get photo2;@JsonKey(name: 'photo2_status') dynamic get photo2Status; dynamic get photo3;@JsonKey(name: 'photo3_status') dynamic get photo3Status; dynamic get photo4;@JsonKey(name: 'photo4_status') dynamic get photo4Status;@JsonKey(name: 'religion_name') dynamic get religionName;@JsonKey(name: 'city_full_name') dynamic get cityFullName; dynamic get height;@JsonKey(name: 'caste_name') dynamic get casteName;@JsonKey(name: 'mtongue_name') dynamic get mtongueName;@JsonKey(name: 'education_name') dynamic get educationName;@JsonKey(name: 'employee_name') dynamic get employeeName;@JsonKey(name: 'photo_visibility') dynamic get photoVisibility; dynamic get status;@JsonKey(name: 'country_name') dynamic get countryName;@JsonKey(name: 'state_name') dynamic get stateName;@JsonKey(name: 'city_name') dynamic get cityName;@JsonKey(name: 'profile_image') dynamic get profileImage;@JsonKey(name: 'profile_title') dynamic get profileTitle;@JsonKey(name: 'sub_title') dynamic get subTitle;@JsonKey(name: 'is_interested') dynamic get isInterested;@JsonKey(name: 'is_shortlisted') dynamic get isShortlisted;@JsonKey(name: 'is_photoProtected') dynamic get isPhotoProtected;@JsonKey(name: 'is_block') dynamic get isBlock; dynamic get id;@JsonKey(name: 'member1_id') dynamic get member1Id;@JsonKey(name: 'member1_matri_id') dynamic get member1MatriId;@JsonKey(name: 'member2_id') dynamic get member2Id;@JsonKey(name: 'member2_matri_id') dynamic get member2MatriId;@JsonKey(name: 'staff_id') dynamic get staffId;@JsonKey(name: 'date_time') dynamic get dateTime; dynamic get description; dynamic get address;@JsonKey(name: 'google_map_link') dynamic get googleMapLink;@JsonKey(name: 'member1_status') dynamic get member1Status;@JsonKey(name: 'member1_reject_remark') dynamic get member1RejectRemark;@JsonKey(name: 'member2_status') dynamic get member2Status;@JsonKey(name: 'member2_reject_remark') dynamic get member2RejectRemark; dynamic get member1; dynamic get member2;@JsonKey(name: 'meeting_status') dynamic get meetingStatus;@JsonKey(name: 'meeting_remark') dynamic get meetingRemark; dynamic get age;@JsonKey(name: 'id_proof_verify_status') dynamic get aadharVerificationStatus;
/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingCopyWith<Meeting> get copyWith => _$MeetingCopyWithImpl<Meeting>(this as Meeting, _$identity);

  /// Serializes this Meeting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Meeting;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Meeting&&const DeepCollectionEquality().equals(other.memberId, _this.memberId)&&const DeepCollectionEquality().equals(other.firstName, _this.firstName)&&const DeepCollectionEquality().equals(other.matriId, _this.matriId)&&const DeepCollectionEquality().equals(other.fullname, _this.fullname)&&const DeepCollectionEquality().equals(other.gender, _this.gender)&&const DeepCollectionEquality().equals(other.birthdate, _this.birthdate)&&const DeepCollectionEquality().equals(other.photo1, _this.photo1)&&const DeepCollectionEquality().equals(other.photo1Status, _this.photo1Status)&&const DeepCollectionEquality().equals(other.photo2, _this.photo2)&&const DeepCollectionEquality().equals(other.photo2Status, _this.photo2Status)&&const DeepCollectionEquality().equals(other.photo3, _this.photo3)&&const DeepCollectionEquality().equals(other.photo3Status, _this.photo3Status)&&const DeepCollectionEquality().equals(other.photo4, _this.photo4)&&const DeepCollectionEquality().equals(other.photo4Status, _this.photo4Status)&&const DeepCollectionEquality().equals(other.religionName, _this.religionName)&&const DeepCollectionEquality().equals(other.cityFullName, _this.cityFullName)&&const DeepCollectionEquality().equals(other.height, _this.height)&&const DeepCollectionEquality().equals(other.casteName, _this.casteName)&&const DeepCollectionEquality().equals(other.mtongueName, _this.mtongueName)&&const DeepCollectionEquality().equals(other.educationName, _this.educationName)&&const DeepCollectionEquality().equals(other.employeeName, _this.employeeName)&&const DeepCollectionEquality().equals(other.photoVisibility, _this.photoVisibility)&&const DeepCollectionEquality().equals(other.status, _this.status)&&const DeepCollectionEquality().equals(other.countryName, _this.countryName)&&const DeepCollectionEquality().equals(other.stateName, _this.stateName)&&const DeepCollectionEquality().equals(other.cityName, _this.cityName)&&const DeepCollectionEquality().equals(other.profileImage, _this.profileImage)&&const DeepCollectionEquality().equals(other.profileTitle, _this.profileTitle)&&const DeepCollectionEquality().equals(other.subTitle, _this.subTitle)&&const DeepCollectionEquality().equals(other.isInterested, _this.isInterested)&&const DeepCollectionEquality().equals(other.isShortlisted, _this.isShortlisted)&&const DeepCollectionEquality().equals(other.isPhotoProtected, _this.isPhotoProtected)&&const DeepCollectionEquality().equals(other.isBlock, _this.isBlock)&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.member1Id, _this.member1Id)&&const DeepCollectionEquality().equals(other.member1MatriId, _this.member1MatriId)&&const DeepCollectionEquality().equals(other.member2Id, _this.member2Id)&&const DeepCollectionEquality().equals(other.member2MatriId, _this.member2MatriId)&&const DeepCollectionEquality().equals(other.staffId, _this.staffId)&&const DeepCollectionEquality().equals(other.dateTime, _this.dateTime)&&const DeepCollectionEquality().equals(other.description, _this.description)&&const DeepCollectionEquality().equals(other.address, _this.address)&&const DeepCollectionEquality().equals(other.googleMapLink, _this.googleMapLink)&&const DeepCollectionEquality().equals(other.member1Status, _this.member1Status)&&const DeepCollectionEquality().equals(other.member1RejectRemark, _this.member1RejectRemark)&&const DeepCollectionEquality().equals(other.member2Status, _this.member2Status)&&const DeepCollectionEquality().equals(other.member2RejectRemark, _this.member2RejectRemark)&&const DeepCollectionEquality().equals(other.member1, _this.member1)&&const DeepCollectionEquality().equals(other.member2, _this.member2)&&const DeepCollectionEquality().equals(other.meetingStatus, _this.meetingStatus)&&const DeepCollectionEquality().equals(other.meetingRemark, _this.meetingRemark)&&const DeepCollectionEquality().equals(other.age, _this.age)&&const DeepCollectionEquality().equals(other.aadharVerificationStatus, _this.aadharVerificationStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Meeting;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.memberId),const DeepCollectionEquality().hash(_this.firstName),const DeepCollectionEquality().hash(_this.matriId),const DeepCollectionEquality().hash(_this.fullname),const DeepCollectionEquality().hash(_this.gender),const DeepCollectionEquality().hash(_this.birthdate),const DeepCollectionEquality().hash(_this.photo1),const DeepCollectionEquality().hash(_this.photo1Status),const DeepCollectionEquality().hash(_this.photo2),const DeepCollectionEquality().hash(_this.photo2Status),const DeepCollectionEquality().hash(_this.photo3),const DeepCollectionEquality().hash(_this.photo3Status),const DeepCollectionEquality().hash(_this.photo4),const DeepCollectionEquality().hash(_this.photo4Status),const DeepCollectionEquality().hash(_this.religionName),const DeepCollectionEquality().hash(_this.cityFullName),const DeepCollectionEquality().hash(_this.height),const DeepCollectionEquality().hash(_this.casteName),const DeepCollectionEquality().hash(_this.mtongueName),const DeepCollectionEquality().hash(_this.educationName),const DeepCollectionEquality().hash(_this.employeeName),const DeepCollectionEquality().hash(_this.photoVisibility),const DeepCollectionEquality().hash(_this.status),const DeepCollectionEquality().hash(_this.countryName),const DeepCollectionEquality().hash(_this.stateName),const DeepCollectionEquality().hash(_this.cityName),const DeepCollectionEquality().hash(_this.profileImage),const DeepCollectionEquality().hash(_this.profileTitle),const DeepCollectionEquality().hash(_this.subTitle),const DeepCollectionEquality().hash(_this.isInterested),const DeepCollectionEquality().hash(_this.isShortlisted),const DeepCollectionEquality().hash(_this.isPhotoProtected),const DeepCollectionEquality().hash(_this.isBlock),const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.member1Id),const DeepCollectionEquality().hash(_this.member1MatriId),const DeepCollectionEquality().hash(_this.member2Id),const DeepCollectionEquality().hash(_this.member2MatriId),const DeepCollectionEquality().hash(_this.staffId),const DeepCollectionEquality().hash(_this.dateTime),const DeepCollectionEquality().hash(_this.description),const DeepCollectionEquality().hash(_this.address),const DeepCollectionEquality().hash(_this.googleMapLink),const DeepCollectionEquality().hash(_this.member1Status),const DeepCollectionEquality().hash(_this.member1RejectRemark),const DeepCollectionEquality().hash(_this.member2Status),const DeepCollectionEquality().hash(_this.member2RejectRemark),const DeepCollectionEquality().hash(_this.member1),const DeepCollectionEquality().hash(_this.member2),const DeepCollectionEquality().hash(_this.meetingStatus),const DeepCollectionEquality().hash(_this.meetingRemark),const DeepCollectionEquality().hash(_this.age),const DeepCollectionEquality().hash(_this.aadharVerificationStatus)]);
}

@override
String toString() {
  final _this = this as Meeting;
  return 'Meeting(memberId: ${_this.memberId}, firstName: ${_this.firstName}, matriId: ${_this.matriId}, fullname: ${_this.fullname}, gender: ${_this.gender}, birthdate: ${_this.birthdate}, photo1: ${_this.photo1}, photo1Status: ${_this.photo1Status}, photo2: ${_this.photo2}, photo2Status: ${_this.photo2Status}, photo3: ${_this.photo3}, photo3Status: ${_this.photo3Status}, photo4: ${_this.photo4}, photo4Status: ${_this.photo4Status}, religionName: ${_this.religionName}, cityFullName: ${_this.cityFullName}, height: ${_this.height}, casteName: ${_this.casteName}, mtongueName: ${_this.mtongueName}, educationName: ${_this.educationName}, employeeName: ${_this.employeeName}, photoVisibility: ${_this.photoVisibility}, status: ${_this.status}, countryName: ${_this.countryName}, stateName: ${_this.stateName}, cityName: ${_this.cityName}, profileImage: ${_this.profileImage}, profileTitle: ${_this.profileTitle}, subTitle: ${_this.subTitle}, isInterested: ${_this.isInterested}, isShortlisted: ${_this.isShortlisted}, isPhotoProtected: ${_this.isPhotoProtected}, isBlock: ${_this.isBlock}, id: ${_this.id}, member1Id: ${_this.member1Id}, member1MatriId: ${_this.member1MatriId}, member2Id: ${_this.member2Id}, member2MatriId: ${_this.member2MatriId}, staffId: ${_this.staffId}, dateTime: ${_this.dateTime}, description: ${_this.description}, address: ${_this.address}, googleMapLink: ${_this.googleMapLink}, member1Status: ${_this.member1Status}, member1RejectRemark: ${_this.member1RejectRemark}, member2Status: ${_this.member2Status}, member2RejectRemark: ${_this.member2RejectRemark}, member1: ${_this.member1}, member2: ${_this.member2}, meetingStatus: ${_this.meetingStatus}, meetingRemark: ${_this.meetingRemark}, age: ${_this.age}, aadharVerificationStatus: ${_this.aadharVerificationStatus})';
}


}

/// @nodoc
abstract mixin class $MeetingCopyWith<$Res>  {
  factory $MeetingCopyWith(Meeting value, $Res Function(Meeting) _then) = _$MeetingCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'member_id') dynamic memberId,@JsonKey(name: 'first_name') dynamic firstName,@JsonKey(name: 'matri_id') dynamic matriId, dynamic fullname, dynamic gender, dynamic birthdate, dynamic photo1,@JsonKey(name: 'photo1_status') dynamic photo1Status, dynamic photo2,@JsonKey(name: 'photo2_status') dynamic photo2Status, dynamic photo3,@JsonKey(name: 'photo3_status') dynamic photo3Status, dynamic photo4,@JsonKey(name: 'photo4_status') dynamic photo4Status,@JsonKey(name: 'religion_name') dynamic religionName,@JsonKey(name: 'city_full_name') dynamic cityFullName, dynamic height,@JsonKey(name: 'caste_name') dynamic casteName,@JsonKey(name: 'mtongue_name') dynamic mtongueName,@JsonKey(name: 'education_name') dynamic educationName,@JsonKey(name: 'employee_name') dynamic employeeName,@JsonKey(name: 'photo_visibility') dynamic photoVisibility, dynamic status,@JsonKey(name: 'country_name') dynamic countryName,@JsonKey(name: 'state_name') dynamic stateName,@JsonKey(name: 'city_name') dynamic cityName,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'sub_title') dynamic subTitle,@JsonKey(name: 'is_interested') dynamic isInterested,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_photoProtected') dynamic isPhotoProtected,@JsonKey(name: 'is_block') dynamic isBlock, dynamic id,@JsonKey(name: 'member1_id') dynamic member1Id,@JsonKey(name: 'member1_matri_id') dynamic member1MatriId,@JsonKey(name: 'member2_id') dynamic member2Id,@JsonKey(name: 'member2_matri_id') dynamic member2MatriId,@JsonKey(name: 'staff_id') dynamic staffId,@JsonKey(name: 'date_time') dynamic dateTime, dynamic description, dynamic address,@JsonKey(name: 'google_map_link') dynamic googleMapLink,@JsonKey(name: 'member1_status') dynamic member1Status,@JsonKey(name: 'member1_reject_remark') dynamic member1RejectRemark,@JsonKey(name: 'member2_status') dynamic member2Status,@JsonKey(name: 'member2_reject_remark') dynamic member2RejectRemark, dynamic member1, dynamic member2,@JsonKey(name: 'meeting_status') dynamic meetingStatus,@JsonKey(name: 'meeting_remark') dynamic meetingRemark, dynamic age,@JsonKey(name: 'id_proof_verify_status') dynamic aadharVerificationStatus
});




}
/// @nodoc
class _$MeetingCopyWithImpl<$Res>
    implements $MeetingCopyWith<$Res> {
  _$MeetingCopyWithImpl(this._self, this._then);

  final Meeting _self;
  final $Res Function(Meeting) _then;

/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = freezed,Object? firstName = freezed,Object? matriId = freezed,Object? fullname = freezed,Object? gender = freezed,Object? birthdate = freezed,Object? photo1 = freezed,Object? photo1Status = freezed,Object? photo2 = freezed,Object? photo2Status = freezed,Object? photo3 = freezed,Object? photo3Status = freezed,Object? photo4 = freezed,Object? photo4Status = freezed,Object? religionName = freezed,Object? cityFullName = freezed,Object? height = freezed,Object? casteName = freezed,Object? mtongueName = freezed,Object? educationName = freezed,Object? employeeName = freezed,Object? photoVisibility = freezed,Object? status = freezed,Object? countryName = freezed,Object? stateName = freezed,Object? cityName = freezed,Object? profileImage = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? isInterested = freezed,Object? isShortlisted = freezed,Object? isPhotoProtected = freezed,Object? isBlock = freezed,Object? id = freezed,Object? member1Id = freezed,Object? member1MatriId = freezed,Object? member2Id = freezed,Object? member2MatriId = freezed,Object? staffId = freezed,Object? dateTime = freezed,Object? description = freezed,Object? address = freezed,Object? googleMapLink = freezed,Object? member1Status = freezed,Object? member1RejectRemark = freezed,Object? member2Status = freezed,Object? member2RejectRemark = freezed,Object? member1 = freezed,Object? member2 = freezed,Object? meetingStatus = freezed,Object? meetingRemark = freezed,Object? age = freezed,Object? aadharVerificationStatus = freezed,}) {
  return _then(Meeting(
memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as dynamic,matriId: freezed == matriId ? _self.matriId : matriId // ignore: cast_nullable_to_non_nullable
as dynamic,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as dynamic,photo1: freezed == photo1 ? _self.photo1 : photo1 // ignore: cast_nullable_to_non_nullable
as dynamic,photo1Status: freezed == photo1Status ? _self.photo1Status : photo1Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo2: freezed == photo2 ? _self.photo2 : photo2 // ignore: cast_nullable_to_non_nullable
as dynamic,photo2Status: freezed == photo2Status ? _self.photo2Status : photo2Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo3: freezed == photo3 ? _self.photo3 : photo3 // ignore: cast_nullable_to_non_nullable
as dynamic,photo3Status: freezed == photo3Status ? _self.photo3Status : photo3Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo4: freezed == photo4 ? _self.photo4 : photo4 // ignore: cast_nullable_to_non_nullable
as dynamic,photo4Status: freezed == photo4Status ? _self.photo4Status : photo4Status // ignore: cast_nullable_to_non_nullable
as dynamic,religionName: freezed == religionName ? _self.religionName : religionName // ignore: cast_nullable_to_non_nullable
as dynamic,cityFullName: freezed == cityFullName ? _self.cityFullName : cityFullName // ignore: cast_nullable_to_non_nullable
as dynamic,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as dynamic,casteName: freezed == casteName ? _self.casteName : casteName // ignore: cast_nullable_to_non_nullable
as dynamic,mtongueName: freezed == mtongueName ? _self.mtongueName : mtongueName // ignore: cast_nullable_to_non_nullable
as dynamic,educationName: freezed == educationName ? _self.educationName : educationName // ignore: cast_nullable_to_non_nullable
as dynamic,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as dynamic,photoVisibility: freezed == photoVisibility ? _self.photoVisibility : photoVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as dynamic,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as dynamic,stateName: freezed == stateName ? _self.stateName : stateName // ignore: cast_nullable_to_non_nullable
as dynamic,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,isInterested: freezed == isInterested ? _self.isInterested : isInterested // ignore: cast_nullable_to_non_nullable
as dynamic,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as dynamic,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,member1Id: freezed == member1Id ? _self.member1Id : member1Id // ignore: cast_nullable_to_non_nullable
as dynamic,member1MatriId: freezed == member1MatriId ? _self.member1MatriId : member1MatriId // ignore: cast_nullable_to_non_nullable
as dynamic,member2Id: freezed == member2Id ? _self.member2Id : member2Id // ignore: cast_nullable_to_non_nullable
as dynamic,member2MatriId: freezed == member2MatriId ? _self.member2MatriId : member2MatriId // ignore: cast_nullable_to_non_nullable
as dynamic,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as dynamic,dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as dynamic,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as dynamic,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as dynamic,googleMapLink: freezed == googleMapLink ? _self.googleMapLink : googleMapLink // ignore: cast_nullable_to_non_nullable
as dynamic,member1Status: freezed == member1Status ? _self.member1Status : member1Status // ignore: cast_nullable_to_non_nullable
as dynamic,member1RejectRemark: freezed == member1RejectRemark ? _self.member1RejectRemark : member1RejectRemark // ignore: cast_nullable_to_non_nullable
as dynamic,member2Status: freezed == member2Status ? _self.member2Status : member2Status // ignore: cast_nullable_to_non_nullable
as dynamic,member2RejectRemark: freezed == member2RejectRemark ? _self.member2RejectRemark : member2RejectRemark // ignore: cast_nullable_to_non_nullable
as dynamic,member1: freezed == member1 ? _self.member1 : member1 // ignore: cast_nullable_to_non_nullable
as dynamic,member2: freezed == member2 ? _self.member2 : member2 // ignore: cast_nullable_to_non_nullable
as dynamic,meetingStatus: freezed == meetingStatus ? _self.meetingStatus : meetingStatus // ignore: cast_nullable_to_non_nullable
as dynamic,meetingRemark: freezed == meetingRemark ? _self.meetingRemark : meetingRemark // ignore: cast_nullable_to_non_nullable
as dynamic,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as dynamic,aadharVerificationStatus: freezed == aadharVerificationStatus ? _self.aadharVerificationStatus : aadharVerificationStatus // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [Meeting].
extension MeetingPatterns on Meeting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Meeting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Meeting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Meeting value)  $default,){
final _that = this;
switch (_that) {
case _Meeting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Meeting value)?  $default,){
final _that = this;
switch (_that) {
case _Meeting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'member_id')  dynamic memberId, @JsonKey(name: 'first_name')  dynamic firstName, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic fullname,  dynamic gender,  dynamic birthdate,  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status,  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status,  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status,  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'religion_name')  dynamic religionName, @JsonKey(name: 'city_full_name')  dynamic cityFullName,  dynamic height, @JsonKey(name: 'caste_name')  dynamic casteName, @JsonKey(name: 'mtongue_name')  dynamic mtongueName, @JsonKey(name: 'education_name')  dynamic educationName, @JsonKey(name: 'employee_name')  dynamic employeeName, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility,  dynamic status, @JsonKey(name: 'country_name')  dynamic countryName, @JsonKey(name: 'state_name')  dynamic stateName, @JsonKey(name: 'city_name')  dynamic cityName, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'is_interested')  dynamic isInterested, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_photoProtected')  dynamic isPhotoProtected, @JsonKey(name: 'is_block')  dynamic isBlock,  dynamic id, @JsonKey(name: 'member1_id')  dynamic member1Id, @JsonKey(name: 'member1_matri_id')  dynamic member1MatriId, @JsonKey(name: 'member2_id')  dynamic member2Id, @JsonKey(name: 'member2_matri_id')  dynamic member2MatriId, @JsonKey(name: 'staff_id')  dynamic staffId, @JsonKey(name: 'date_time')  dynamic dateTime,  dynamic description,  dynamic address, @JsonKey(name: 'google_map_link')  dynamic googleMapLink, @JsonKey(name: 'member1_status')  dynamic member1Status, @JsonKey(name: 'member1_reject_remark')  dynamic member1RejectRemark, @JsonKey(name: 'member2_status')  dynamic member2Status, @JsonKey(name: 'member2_reject_remark')  dynamic member2RejectRemark,  dynamic member1,  dynamic member2, @JsonKey(name: 'meeting_status')  dynamic meetingStatus, @JsonKey(name: 'meeting_remark')  dynamic meetingRemark,  dynamic age, @JsonKey(name: 'id_proof_verify_status')  dynamic aadharVerificationStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Meeting() when $default != null:
return $default(_that.memberId,_that.firstName,_that.matriId,_that.fullname,_that.gender,_that.birthdate,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.religionName,_that.cityFullName,_that.height,_that.casteName,_that.mtongueName,_that.educationName,_that.employeeName,_that.photoVisibility,_that.status,_that.countryName,_that.stateName,_that.cityName,_that.profileImage,_that.profileTitle,_that.subTitle,_that.isInterested,_that.isShortlisted,_that.isPhotoProtected,_that.isBlock,_that.id,_that.member1Id,_that.member1MatriId,_that.member2Id,_that.member2MatriId,_that.staffId,_that.dateTime,_that.description,_that.address,_that.googleMapLink,_that.member1Status,_that.member1RejectRemark,_that.member2Status,_that.member2RejectRemark,_that.member1,_that.member2,_that.meetingStatus,_that.meetingRemark,_that.age,_that.aadharVerificationStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'member_id')  dynamic memberId, @JsonKey(name: 'first_name')  dynamic firstName, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic fullname,  dynamic gender,  dynamic birthdate,  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status,  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status,  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status,  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'religion_name')  dynamic religionName, @JsonKey(name: 'city_full_name')  dynamic cityFullName,  dynamic height, @JsonKey(name: 'caste_name')  dynamic casteName, @JsonKey(name: 'mtongue_name')  dynamic mtongueName, @JsonKey(name: 'education_name')  dynamic educationName, @JsonKey(name: 'employee_name')  dynamic employeeName, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility,  dynamic status, @JsonKey(name: 'country_name')  dynamic countryName, @JsonKey(name: 'state_name')  dynamic stateName, @JsonKey(name: 'city_name')  dynamic cityName, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'is_interested')  dynamic isInterested, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_photoProtected')  dynamic isPhotoProtected, @JsonKey(name: 'is_block')  dynamic isBlock,  dynamic id, @JsonKey(name: 'member1_id')  dynamic member1Id, @JsonKey(name: 'member1_matri_id')  dynamic member1MatriId, @JsonKey(name: 'member2_id')  dynamic member2Id, @JsonKey(name: 'member2_matri_id')  dynamic member2MatriId, @JsonKey(name: 'staff_id')  dynamic staffId, @JsonKey(name: 'date_time')  dynamic dateTime,  dynamic description,  dynamic address, @JsonKey(name: 'google_map_link')  dynamic googleMapLink, @JsonKey(name: 'member1_status')  dynamic member1Status, @JsonKey(name: 'member1_reject_remark')  dynamic member1RejectRemark, @JsonKey(name: 'member2_status')  dynamic member2Status, @JsonKey(name: 'member2_reject_remark')  dynamic member2RejectRemark,  dynamic member1,  dynamic member2, @JsonKey(name: 'meeting_status')  dynamic meetingStatus, @JsonKey(name: 'meeting_remark')  dynamic meetingRemark,  dynamic age, @JsonKey(name: 'id_proof_verify_status')  dynamic aadharVerificationStatus)  $default,) {final _that = this;
switch (_that) {
case _Meeting():
return $default(_that.memberId,_that.firstName,_that.matriId,_that.fullname,_that.gender,_that.birthdate,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.religionName,_that.cityFullName,_that.height,_that.casteName,_that.mtongueName,_that.educationName,_that.employeeName,_that.photoVisibility,_that.status,_that.countryName,_that.stateName,_that.cityName,_that.profileImage,_that.profileTitle,_that.subTitle,_that.isInterested,_that.isShortlisted,_that.isPhotoProtected,_that.isBlock,_that.id,_that.member1Id,_that.member1MatriId,_that.member2Id,_that.member2MatriId,_that.staffId,_that.dateTime,_that.description,_that.address,_that.googleMapLink,_that.member1Status,_that.member1RejectRemark,_that.member2Status,_that.member2RejectRemark,_that.member1,_that.member2,_that.meetingStatus,_that.meetingRemark,_that.age,_that.aadharVerificationStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'member_id')  dynamic memberId, @JsonKey(name: 'first_name')  dynamic firstName, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic fullname,  dynamic gender,  dynamic birthdate,  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status,  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status,  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status,  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'religion_name')  dynamic religionName, @JsonKey(name: 'city_full_name')  dynamic cityFullName,  dynamic height, @JsonKey(name: 'caste_name')  dynamic casteName, @JsonKey(name: 'mtongue_name')  dynamic mtongueName, @JsonKey(name: 'education_name')  dynamic educationName, @JsonKey(name: 'employee_name')  dynamic employeeName, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility,  dynamic status, @JsonKey(name: 'country_name')  dynamic countryName, @JsonKey(name: 'state_name')  dynamic stateName, @JsonKey(name: 'city_name')  dynamic cityName, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'is_interested')  dynamic isInterested, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_photoProtected')  dynamic isPhotoProtected, @JsonKey(name: 'is_block')  dynamic isBlock,  dynamic id, @JsonKey(name: 'member1_id')  dynamic member1Id, @JsonKey(name: 'member1_matri_id')  dynamic member1MatriId, @JsonKey(name: 'member2_id')  dynamic member2Id, @JsonKey(name: 'member2_matri_id')  dynamic member2MatriId, @JsonKey(name: 'staff_id')  dynamic staffId, @JsonKey(name: 'date_time')  dynamic dateTime,  dynamic description,  dynamic address, @JsonKey(name: 'google_map_link')  dynamic googleMapLink, @JsonKey(name: 'member1_status')  dynamic member1Status, @JsonKey(name: 'member1_reject_remark')  dynamic member1RejectRemark, @JsonKey(name: 'member2_status')  dynamic member2Status, @JsonKey(name: 'member2_reject_remark')  dynamic member2RejectRemark,  dynamic member1,  dynamic member2, @JsonKey(name: 'meeting_status')  dynamic meetingStatus, @JsonKey(name: 'meeting_remark')  dynamic meetingRemark,  dynamic age, @JsonKey(name: 'id_proof_verify_status')  dynamic aadharVerificationStatus)?  $default,) {final _that = this;
switch (_that) {
case _Meeting() when $default != null:
return $default(_that.memberId,_that.firstName,_that.matriId,_that.fullname,_that.gender,_that.birthdate,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.religionName,_that.cityFullName,_that.height,_that.casteName,_that.mtongueName,_that.educationName,_that.employeeName,_that.photoVisibility,_that.status,_that.countryName,_that.stateName,_that.cityName,_that.profileImage,_that.profileTitle,_that.subTitle,_that.isInterested,_that.isShortlisted,_that.isPhotoProtected,_that.isBlock,_that.id,_that.member1Id,_that.member1MatriId,_that.member2Id,_that.member2MatriId,_that.staffId,_that.dateTime,_that.description,_that.address,_that.googleMapLink,_that.member1Status,_that.member1RejectRemark,_that.member2Status,_that.member2RejectRemark,_that.member1,_that.member2,_that.meetingStatus,_that.meetingRemark,_that.age,_that.aadharVerificationStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Meeting implements Meeting {
  const _Meeting({@JsonKey(name: 'member_id') this.memberId, @JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'matri_id') this.matriId, this.fullname, this.gender, this.birthdate, this.photo1, @JsonKey(name: 'photo1_status') this.photo1Status, this.photo2, @JsonKey(name: 'photo2_status') this.photo2Status, this.photo3, @JsonKey(name: 'photo3_status') this.photo3Status, this.photo4, @JsonKey(name: 'photo4_status') this.photo4Status, @JsonKey(name: 'religion_name') this.religionName, @JsonKey(name: 'city_full_name') this.cityFullName, this.height, @JsonKey(name: 'caste_name') this.casteName, @JsonKey(name: 'mtongue_name') this.mtongueName, @JsonKey(name: 'education_name') this.educationName, @JsonKey(name: 'employee_name') this.employeeName, @JsonKey(name: 'photo_visibility') this.photoVisibility, this.status, @JsonKey(name: 'country_name') this.countryName, @JsonKey(name: 'state_name') this.stateName, @JsonKey(name: 'city_name') this.cityName, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'is_interested') this.isInterested, @JsonKey(name: 'is_shortlisted') this.isShortlisted, @JsonKey(name: 'is_photoProtected') this.isPhotoProtected, @JsonKey(name: 'is_block') this.isBlock, this.id, @JsonKey(name: 'member1_id') this.member1Id, @JsonKey(name: 'member1_matri_id') this.member1MatriId, @JsonKey(name: 'member2_id') this.member2Id, @JsonKey(name: 'member2_matri_id') this.member2MatriId, @JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'date_time') this.dateTime, this.description, this.address, @JsonKey(name: 'google_map_link') this.googleMapLink, @JsonKey(name: 'member1_status') this.member1Status, @JsonKey(name: 'member1_reject_remark') this.member1RejectRemark, @JsonKey(name: 'member2_status') this.member2Status, @JsonKey(name: 'member2_reject_remark') this.member2RejectRemark, this.member1, this.member2, @JsonKey(name: 'meeting_status') this.meetingStatus, @JsonKey(name: 'meeting_remark') this.meetingRemark, this.age, @JsonKey(name: 'id_proof_verify_status') this.aadharVerificationStatus});
  factory _Meeting.fromJson(Map<String, dynamic> json) => _$MeetingFromJson(json);

@override@JsonKey(name: 'member_id') final  dynamic memberId;
@override@JsonKey(name: 'first_name') final  dynamic firstName;
@override@JsonKey(name: 'matri_id') final  dynamic matriId;
@override final  dynamic fullname;
@override final  dynamic gender;
@override final  dynamic birthdate;
@override final  dynamic photo1;
@override@JsonKey(name: 'photo1_status') final  dynamic photo1Status;
@override final  dynamic photo2;
@override@JsonKey(name: 'photo2_status') final  dynamic photo2Status;
@override final  dynamic photo3;
@override@JsonKey(name: 'photo3_status') final  dynamic photo3Status;
@override final  dynamic photo4;
@override@JsonKey(name: 'photo4_status') final  dynamic photo4Status;
@override@JsonKey(name: 'religion_name') final  dynamic religionName;
@override@JsonKey(name: 'city_full_name') final  dynamic cityFullName;
@override final  dynamic height;
@override@JsonKey(name: 'caste_name') final  dynamic casteName;
@override@JsonKey(name: 'mtongue_name') final  dynamic mtongueName;
@override@JsonKey(name: 'education_name') final  dynamic educationName;
@override@JsonKey(name: 'employee_name') final  dynamic employeeName;
@override@JsonKey(name: 'photo_visibility') final  dynamic photoVisibility;
@override final  dynamic status;
@override@JsonKey(name: 'country_name') final  dynamic countryName;
@override@JsonKey(name: 'state_name') final  dynamic stateName;
@override@JsonKey(name: 'city_name') final  dynamic cityName;
@override@JsonKey(name: 'profile_image') final  dynamic profileImage;
@override@JsonKey(name: 'profile_title') final  dynamic profileTitle;
@override@JsonKey(name: 'sub_title') final  dynamic subTitle;
@override@JsonKey(name: 'is_interested') final  dynamic isInterested;
@override@JsonKey(name: 'is_shortlisted') final  dynamic isShortlisted;
@override@JsonKey(name: 'is_photoProtected') final  dynamic isPhotoProtected;
@override@JsonKey(name: 'is_block') final  dynamic isBlock;
@override final  dynamic id;
@override@JsonKey(name: 'member1_id') final  dynamic member1Id;
@override@JsonKey(name: 'member1_matri_id') final  dynamic member1MatriId;
@override@JsonKey(name: 'member2_id') final  dynamic member2Id;
@override@JsonKey(name: 'member2_matri_id') final  dynamic member2MatriId;
@override@JsonKey(name: 'staff_id') final  dynamic staffId;
@override@JsonKey(name: 'date_time') final  dynamic dateTime;
@override final  dynamic description;
@override final  dynamic address;
@override@JsonKey(name: 'google_map_link') final  dynamic googleMapLink;
@override@JsonKey(name: 'member1_status') final  dynamic member1Status;
@override@JsonKey(name: 'member1_reject_remark') final  dynamic member1RejectRemark;
@override@JsonKey(name: 'member2_status') final  dynamic member2Status;
@override@JsonKey(name: 'member2_reject_remark') final  dynamic member2RejectRemark;
@override final  dynamic member1;
@override final  dynamic member2;
@override@JsonKey(name: 'meeting_status') final  dynamic meetingStatus;
@override@JsonKey(name: 'meeting_remark') final  dynamic meetingRemark;
@override final  dynamic age;
@override@JsonKey(name: 'id_proof_verify_status') final  dynamic aadharVerificationStatus;

/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingCopyWith<_Meeting> get copyWith => __$MeetingCopyWithImpl<_Meeting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Meeting&&const DeepCollectionEquality().equals(other.memberId, memberId)&&const DeepCollectionEquality().equals(other.firstName, firstName)&&const DeepCollectionEquality().equals(other.matriId, matriId)&&const DeepCollectionEquality().equals(other.fullname, fullname)&&const DeepCollectionEquality().equals(other.gender, gender)&&const DeepCollectionEquality().equals(other.birthdate, birthdate)&&const DeepCollectionEquality().equals(other.photo1, photo1)&&const DeepCollectionEquality().equals(other.photo1Status, photo1Status)&&const DeepCollectionEquality().equals(other.photo2, photo2)&&const DeepCollectionEquality().equals(other.photo2Status, photo2Status)&&const DeepCollectionEquality().equals(other.photo3, photo3)&&const DeepCollectionEquality().equals(other.photo3Status, photo3Status)&&const DeepCollectionEquality().equals(other.photo4, photo4)&&const DeepCollectionEquality().equals(other.photo4Status, photo4Status)&&const DeepCollectionEquality().equals(other.religionName, religionName)&&const DeepCollectionEquality().equals(other.cityFullName, cityFullName)&&const DeepCollectionEquality().equals(other.height, height)&&const DeepCollectionEquality().equals(other.casteName, casteName)&&const DeepCollectionEquality().equals(other.mtongueName, mtongueName)&&const DeepCollectionEquality().equals(other.educationName, educationName)&&const DeepCollectionEquality().equals(other.employeeName, employeeName)&&const DeepCollectionEquality().equals(other.photoVisibility, photoVisibility)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.countryName, countryName)&&const DeepCollectionEquality().equals(other.stateName, stateName)&&const DeepCollectionEquality().equals(other.cityName, cityName)&&const DeepCollectionEquality().equals(other.profileImage, profileImage)&&const DeepCollectionEquality().equals(other.profileTitle, profileTitle)&&const DeepCollectionEquality().equals(other.subTitle, subTitle)&&const DeepCollectionEquality().equals(other.isInterested, isInterested)&&const DeepCollectionEquality().equals(other.isShortlisted, isShortlisted)&&const DeepCollectionEquality().equals(other.isPhotoProtected, isPhotoProtected)&&const DeepCollectionEquality().equals(other.isBlock, isBlock)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.member1Id, member1Id)&&const DeepCollectionEquality().equals(other.member1MatriId, member1MatriId)&&const DeepCollectionEquality().equals(other.member2Id, member2Id)&&const DeepCollectionEquality().equals(other.member2MatriId, member2MatriId)&&const DeepCollectionEquality().equals(other.staffId, staffId)&&const DeepCollectionEquality().equals(other.dateTime, dateTime)&&const DeepCollectionEquality().equals(other.description, description)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.googleMapLink, googleMapLink)&&const DeepCollectionEquality().equals(other.member1Status, member1Status)&&const DeepCollectionEquality().equals(other.member1RejectRemark, member1RejectRemark)&&const DeepCollectionEquality().equals(other.member2Status, member2Status)&&const DeepCollectionEquality().equals(other.member2RejectRemark, member2RejectRemark)&&const DeepCollectionEquality().equals(other.member1, member1)&&const DeepCollectionEquality().equals(other.member2, member2)&&const DeepCollectionEquality().equals(other.meetingStatus, meetingStatus)&&const DeepCollectionEquality().equals(other.meetingRemark, meetingRemark)&&const DeepCollectionEquality().equals(other.age, age)&&const DeepCollectionEquality().equals(other.aadharVerificationStatus, aadharVerificationStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(memberId),const DeepCollectionEquality().hash(firstName),const DeepCollectionEquality().hash(matriId),const DeepCollectionEquality().hash(fullname),const DeepCollectionEquality().hash(gender),const DeepCollectionEquality().hash(birthdate),const DeepCollectionEquality().hash(photo1),const DeepCollectionEquality().hash(photo1Status),const DeepCollectionEquality().hash(photo2),const DeepCollectionEquality().hash(photo2Status),const DeepCollectionEquality().hash(photo3),const DeepCollectionEquality().hash(photo3Status),const DeepCollectionEquality().hash(photo4),const DeepCollectionEquality().hash(photo4Status),const DeepCollectionEquality().hash(religionName),const DeepCollectionEquality().hash(cityFullName),const DeepCollectionEquality().hash(height),const DeepCollectionEquality().hash(casteName),const DeepCollectionEquality().hash(mtongueName),const DeepCollectionEquality().hash(educationName),const DeepCollectionEquality().hash(employeeName),const DeepCollectionEquality().hash(photoVisibility),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(countryName),const DeepCollectionEquality().hash(stateName),const DeepCollectionEquality().hash(cityName),const DeepCollectionEquality().hash(profileImage),const DeepCollectionEquality().hash(profileTitle),const DeepCollectionEquality().hash(subTitle),const DeepCollectionEquality().hash(isInterested),const DeepCollectionEquality().hash(isShortlisted),const DeepCollectionEquality().hash(isPhotoProtected),const DeepCollectionEquality().hash(isBlock),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(member1Id),const DeepCollectionEquality().hash(member1MatriId),const DeepCollectionEquality().hash(member2Id),const DeepCollectionEquality().hash(member2MatriId),const DeepCollectionEquality().hash(staffId),const DeepCollectionEquality().hash(dateTime),const DeepCollectionEquality().hash(description),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(googleMapLink),const DeepCollectionEquality().hash(member1Status),const DeepCollectionEquality().hash(member1RejectRemark),const DeepCollectionEquality().hash(member2Status),const DeepCollectionEquality().hash(member2RejectRemark),const DeepCollectionEquality().hash(member1),const DeepCollectionEquality().hash(member2),const DeepCollectionEquality().hash(meetingStatus),const DeepCollectionEquality().hash(meetingRemark),const DeepCollectionEquality().hash(age),const DeepCollectionEquality().hash(aadharVerificationStatus)]);
}

@override
String toString() {
    return 'Meeting(memberId: $memberId, firstName: $firstName, matriId: $matriId, fullname: $fullname, gender: $gender, birthdate: $birthdate, photo1: $photo1, photo1Status: $photo1Status, photo2: $photo2, photo2Status: $photo2Status, photo3: $photo3, photo3Status: $photo3Status, photo4: $photo4, photo4Status: $photo4Status, religionName: $religionName, cityFullName: $cityFullName, height: $height, casteName: $casteName, mtongueName: $mtongueName, educationName: $educationName, employeeName: $employeeName, photoVisibility: $photoVisibility, status: $status, countryName: $countryName, stateName: $stateName, cityName: $cityName, profileImage: $profileImage, profileTitle: $profileTitle, subTitle: $subTitle, isInterested: $isInterested, isShortlisted: $isShortlisted, isPhotoProtected: $isPhotoProtected, isBlock: $isBlock, id: $id, member1Id: $member1Id, member1MatriId: $member1MatriId, member2Id: $member2Id, member2MatriId: $member2MatriId, staffId: $staffId, dateTime: $dateTime, description: $description, address: $address, googleMapLink: $googleMapLink, member1Status: $member1Status, member1RejectRemark: $member1RejectRemark, member2Status: $member2Status, member2RejectRemark: $member2RejectRemark, member1: $member1, member2: $member2, meetingStatus: $meetingStatus, meetingRemark: $meetingRemark, age: $age, aadharVerificationStatus: $aadharVerificationStatus)';
}


}

/// @nodoc
abstract mixin class _$MeetingCopyWith<$Res> implements $MeetingCopyWith<$Res> {
  factory _$MeetingCopyWith(_Meeting value, $Res Function(_Meeting) _then) = __$MeetingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'member_id') dynamic memberId,@JsonKey(name: 'first_name') dynamic firstName,@JsonKey(name: 'matri_id') dynamic matriId, dynamic fullname, dynamic gender, dynamic birthdate, dynamic photo1,@JsonKey(name: 'photo1_status') dynamic photo1Status, dynamic photo2,@JsonKey(name: 'photo2_status') dynamic photo2Status, dynamic photo3,@JsonKey(name: 'photo3_status') dynamic photo3Status, dynamic photo4,@JsonKey(name: 'photo4_status') dynamic photo4Status,@JsonKey(name: 'religion_name') dynamic religionName,@JsonKey(name: 'city_full_name') dynamic cityFullName, dynamic height,@JsonKey(name: 'caste_name') dynamic casteName,@JsonKey(name: 'mtongue_name') dynamic mtongueName,@JsonKey(name: 'education_name') dynamic educationName,@JsonKey(name: 'employee_name') dynamic employeeName,@JsonKey(name: 'photo_visibility') dynamic photoVisibility, dynamic status,@JsonKey(name: 'country_name') dynamic countryName,@JsonKey(name: 'state_name') dynamic stateName,@JsonKey(name: 'city_name') dynamic cityName,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'sub_title') dynamic subTitle,@JsonKey(name: 'is_interested') dynamic isInterested,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_photoProtected') dynamic isPhotoProtected,@JsonKey(name: 'is_block') dynamic isBlock, dynamic id,@JsonKey(name: 'member1_id') dynamic member1Id,@JsonKey(name: 'member1_matri_id') dynamic member1MatriId,@JsonKey(name: 'member2_id') dynamic member2Id,@JsonKey(name: 'member2_matri_id') dynamic member2MatriId,@JsonKey(name: 'staff_id') dynamic staffId,@JsonKey(name: 'date_time') dynamic dateTime, dynamic description, dynamic address,@JsonKey(name: 'google_map_link') dynamic googleMapLink,@JsonKey(name: 'member1_status') dynamic member1Status,@JsonKey(name: 'member1_reject_remark') dynamic member1RejectRemark,@JsonKey(name: 'member2_status') dynamic member2Status,@JsonKey(name: 'member2_reject_remark') dynamic member2RejectRemark, dynamic member1, dynamic member2,@JsonKey(name: 'meeting_status') dynamic meetingStatus,@JsonKey(name: 'meeting_remark') dynamic meetingRemark, dynamic age,@JsonKey(name: 'id_proof_verify_status') dynamic aadharVerificationStatus
});




}
/// @nodoc
class __$MeetingCopyWithImpl<$Res>
    implements _$MeetingCopyWith<$Res> {
  __$MeetingCopyWithImpl(this._self, this._then);

  final _Meeting _self;
  final $Res Function(_Meeting) _then;

/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = freezed,Object? firstName = freezed,Object? matriId = freezed,Object? fullname = freezed,Object? gender = freezed,Object? birthdate = freezed,Object? photo1 = freezed,Object? photo1Status = freezed,Object? photo2 = freezed,Object? photo2Status = freezed,Object? photo3 = freezed,Object? photo3Status = freezed,Object? photo4 = freezed,Object? photo4Status = freezed,Object? religionName = freezed,Object? cityFullName = freezed,Object? height = freezed,Object? casteName = freezed,Object? mtongueName = freezed,Object? educationName = freezed,Object? employeeName = freezed,Object? photoVisibility = freezed,Object? status = freezed,Object? countryName = freezed,Object? stateName = freezed,Object? cityName = freezed,Object? profileImage = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? isInterested = freezed,Object? isShortlisted = freezed,Object? isPhotoProtected = freezed,Object? isBlock = freezed,Object? id = freezed,Object? member1Id = freezed,Object? member1MatriId = freezed,Object? member2Id = freezed,Object? member2MatriId = freezed,Object? staffId = freezed,Object? dateTime = freezed,Object? description = freezed,Object? address = freezed,Object? googleMapLink = freezed,Object? member1Status = freezed,Object? member1RejectRemark = freezed,Object? member2Status = freezed,Object? member2RejectRemark = freezed,Object? member1 = freezed,Object? member2 = freezed,Object? meetingStatus = freezed,Object? meetingRemark = freezed,Object? age = freezed,Object? aadharVerificationStatus = freezed,}) {
  return _then(_Meeting(
memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as dynamic,matriId: freezed == matriId ? _self.matriId : matriId // ignore: cast_nullable_to_non_nullable
as dynamic,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as dynamic,photo1: freezed == photo1 ? _self.photo1 : photo1 // ignore: cast_nullable_to_non_nullable
as dynamic,photo1Status: freezed == photo1Status ? _self.photo1Status : photo1Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo2: freezed == photo2 ? _self.photo2 : photo2 // ignore: cast_nullable_to_non_nullable
as dynamic,photo2Status: freezed == photo2Status ? _self.photo2Status : photo2Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo3: freezed == photo3 ? _self.photo3 : photo3 // ignore: cast_nullable_to_non_nullable
as dynamic,photo3Status: freezed == photo3Status ? _self.photo3Status : photo3Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo4: freezed == photo4 ? _self.photo4 : photo4 // ignore: cast_nullable_to_non_nullable
as dynamic,photo4Status: freezed == photo4Status ? _self.photo4Status : photo4Status // ignore: cast_nullable_to_non_nullable
as dynamic,religionName: freezed == religionName ? _self.religionName : religionName // ignore: cast_nullable_to_non_nullable
as dynamic,cityFullName: freezed == cityFullName ? _self.cityFullName : cityFullName // ignore: cast_nullable_to_non_nullable
as dynamic,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as dynamic,casteName: freezed == casteName ? _self.casteName : casteName // ignore: cast_nullable_to_non_nullable
as dynamic,mtongueName: freezed == mtongueName ? _self.mtongueName : mtongueName // ignore: cast_nullable_to_non_nullable
as dynamic,educationName: freezed == educationName ? _self.educationName : educationName // ignore: cast_nullable_to_non_nullable
as dynamic,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as dynamic,photoVisibility: freezed == photoVisibility ? _self.photoVisibility : photoVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as dynamic,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as dynamic,stateName: freezed == stateName ? _self.stateName : stateName // ignore: cast_nullable_to_non_nullable
as dynamic,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,isInterested: freezed == isInterested ? _self.isInterested : isInterested // ignore: cast_nullable_to_non_nullable
as dynamic,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as dynamic,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,member1Id: freezed == member1Id ? _self.member1Id : member1Id // ignore: cast_nullable_to_non_nullable
as dynamic,member1MatriId: freezed == member1MatriId ? _self.member1MatriId : member1MatriId // ignore: cast_nullable_to_non_nullable
as dynamic,member2Id: freezed == member2Id ? _self.member2Id : member2Id // ignore: cast_nullable_to_non_nullable
as dynamic,member2MatriId: freezed == member2MatriId ? _self.member2MatriId : member2MatriId // ignore: cast_nullable_to_non_nullable
as dynamic,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as dynamic,dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as dynamic,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as dynamic,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as dynamic,googleMapLink: freezed == googleMapLink ? _self.googleMapLink : googleMapLink // ignore: cast_nullable_to_non_nullable
as dynamic,member1Status: freezed == member1Status ? _self.member1Status : member1Status // ignore: cast_nullable_to_non_nullable
as dynamic,member1RejectRemark: freezed == member1RejectRemark ? _self.member1RejectRemark : member1RejectRemark // ignore: cast_nullable_to_non_nullable
as dynamic,member2Status: freezed == member2Status ? _self.member2Status : member2Status // ignore: cast_nullable_to_non_nullable
as dynamic,member2RejectRemark: freezed == member2RejectRemark ? _self.member2RejectRemark : member2RejectRemark // ignore: cast_nullable_to_non_nullable
as dynamic,member1: freezed == member1 ? _self.member1 : member1 // ignore: cast_nullable_to_non_nullable
as dynamic,member2: freezed == member2 ? _self.member2 : member2 // ignore: cast_nullable_to_non_nullable
as dynamic,meetingStatus: freezed == meetingStatus ? _self.meetingStatus : meetingStatus // ignore: cast_nullable_to_non_nullable
as dynamic,meetingRemark: freezed == meetingRemark ? _self.meetingRemark : meetingRemark // ignore: cast_nullable_to_non_nullable
as dynamic,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as dynamic,aadharVerificationStatus: freezed == aadharVerificationStatus ? _self.aadharVerificationStatus : aadharVerificationStatus // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
