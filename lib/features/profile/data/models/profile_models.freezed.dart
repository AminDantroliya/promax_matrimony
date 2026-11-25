// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyProfileResponseModel {

 int? get code; String? get status; String? get message; ProfileData? get data;
/// Create a copy of MyProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyProfileResponseModelCopyWith<MyProfileResponseModel> get copyWith => _$MyProfileResponseModelCopyWithImpl<MyProfileResponseModel>(this as MyProfileResponseModel, _$identity);

  /// Serializes this MyProfileResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyProfileResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyProfileResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyProfileResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as MyProfileResponseModel;
  return 'MyProfileResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $MyProfileResponseModelCopyWith<$Res>  {
  factory $MyProfileResponseModelCopyWith(MyProfileResponseModel value, $Res Function(MyProfileResponseModel) _then) = _$MyProfileResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, ProfileData? data
});


$ProfileDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$MyProfileResponseModelCopyWithImpl<$Res>
    implements $MyProfileResponseModelCopyWith<$Res> {
  _$MyProfileResponseModelCopyWithImpl(this._self, this._then);

  final MyProfileResponseModel _self;
  final $Res Function(MyProfileResponseModel) _then;

/// Create a copy of MyProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(MyProfileResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProfileData?,
  ));
}
/// Create a copy of MyProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ProfileDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyProfileResponseModel].
extension MyProfileResponseModelPatterns on MyProfileResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyProfileResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyProfileResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyProfileResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _MyProfileResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyProfileResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _MyProfileResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ProfileData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyProfileResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ProfileData? data)  $default,) {final _that = this;
switch (_that) {
case _MyProfileResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  ProfileData? data)?  $default,) {final _that = this;
switch (_that) {
case _MyProfileResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyProfileResponseModel implements MyProfileResponseModel {
  const _MyProfileResponseModel({this.code, this.status, this.message, this.data});
  factory _MyProfileResponseModel.fromJson(Map<String, dynamic> json) => _$MyProfileResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  ProfileData? data;

/// Create a copy of MyProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyProfileResponseModelCopyWith<_MyProfileResponseModel> get copyWith => __$MyProfileResponseModelCopyWithImpl<_MyProfileResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyProfileResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyProfileResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'MyProfileResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MyProfileResponseModelCopyWith<$Res> implements $MyProfileResponseModelCopyWith<$Res> {
  factory _$MyProfileResponseModelCopyWith(_MyProfileResponseModel value, $Res Function(_MyProfileResponseModel) _then) = __$MyProfileResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, ProfileData? data
});


@override $ProfileDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$MyProfileResponseModelCopyWithImpl<$Res>
    implements _$MyProfileResponseModelCopyWith<$Res> {
  __$MyProfileResponseModelCopyWithImpl(this._self, this._then);

  final _MyProfileResponseModel _self;
  final $Res Function(_MyProfileResponseModel) _then;

/// Create a copy of MyProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_MyProfileResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProfileData?,
  ));
}

/// Create a copy of MyProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ProfileDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$OtherMemberProfileResponseModel {

 int? get code; String? get status; String? get message; ProfileData? get data;@JsonKey(name: 'user_not_found_status') dynamic get userNotFoundStatus;@JsonKey(name: 'user_not_found_title') String? get userNotFoundTitle;@JsonKey(name: 'user_not_found_message') String? get userNotFoundMessage;@JsonKey(name: 'remaining_contacts') dynamic get remainingContacts;@JsonKey(name: 'has_viewed_contact') dynamic get hasViewedContact;@JsonKey(name: 'view_profile_allowed') dynamic get viewProfileAllowed;
/// Create a copy of OtherMemberProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherMemberProfileResponseModelCopyWith<OtherMemberProfileResponseModel> get copyWith => _$OtherMemberProfileResponseModelCopyWithImpl<OtherMemberProfileResponseModel>(this as OtherMemberProfileResponseModel, _$identity);

  /// Serializes this OtherMemberProfileResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OtherMemberProfileResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherMemberProfileResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data)&&const DeepCollectionEquality().equals(other.userNotFoundStatus, _this.userNotFoundStatus)&&(identical(other.userNotFoundTitle, _this.userNotFoundTitle) || other.userNotFoundTitle == _this.userNotFoundTitle)&&(identical(other.userNotFoundMessage, _this.userNotFoundMessage) || other.userNotFoundMessage == _this.userNotFoundMessage)&&const DeepCollectionEquality().equals(other.remainingContacts, _this.remainingContacts)&&const DeepCollectionEquality().equals(other.hasViewedContact, _this.hasViewedContact)&&const DeepCollectionEquality().equals(other.viewProfileAllowed, _this.viewProfileAllowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OtherMemberProfileResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data,const DeepCollectionEquality().hash(_this.userNotFoundStatus),_this.userNotFoundTitle,_this.userNotFoundMessage,const DeepCollectionEquality().hash(_this.remainingContacts),const DeepCollectionEquality().hash(_this.hasViewedContact),const DeepCollectionEquality().hash(_this.viewProfileAllowed));
}

@override
String toString() {
  final _this = this as OtherMemberProfileResponseModel;
  return 'OtherMemberProfileResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data}, userNotFoundStatus: ${_this.userNotFoundStatus}, userNotFoundTitle: ${_this.userNotFoundTitle}, userNotFoundMessage: ${_this.userNotFoundMessage}, remainingContacts: ${_this.remainingContacts}, hasViewedContact: ${_this.hasViewedContact}, viewProfileAllowed: ${_this.viewProfileAllowed})';
}


}

/// @nodoc
abstract mixin class $OtherMemberProfileResponseModelCopyWith<$Res>  {
  factory $OtherMemberProfileResponseModelCopyWith(OtherMemberProfileResponseModel value, $Res Function(OtherMemberProfileResponseModel) _then) = _$OtherMemberProfileResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, ProfileData? data,@JsonKey(name: 'user_not_found_status') dynamic userNotFoundStatus,@JsonKey(name: 'user_not_found_title') String? userNotFoundTitle,@JsonKey(name: 'user_not_found_message') String? userNotFoundMessage,@JsonKey(name: 'remaining_contacts') dynamic remainingContacts,@JsonKey(name: 'has_viewed_contact') dynamic hasViewedContact,@JsonKey(name: 'view_profile_allowed') dynamic viewProfileAllowed
});


$ProfileDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$OtherMemberProfileResponseModelCopyWithImpl<$Res>
    implements $OtherMemberProfileResponseModelCopyWith<$Res> {
  _$OtherMemberProfileResponseModelCopyWithImpl(this._self, this._then);

  final OtherMemberProfileResponseModel _self;
  final $Res Function(OtherMemberProfileResponseModel) _then;

/// Create a copy of OtherMemberProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,Object? userNotFoundStatus = freezed,Object? userNotFoundTitle = freezed,Object? userNotFoundMessage = freezed,Object? remainingContacts = freezed,Object? hasViewedContact = freezed,Object? viewProfileAllowed = freezed,}) {
  return _then(OtherMemberProfileResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProfileData?,userNotFoundStatus: freezed == userNotFoundStatus ? _self.userNotFoundStatus : userNotFoundStatus // ignore: cast_nullable_to_non_nullable
as dynamic,userNotFoundTitle: freezed == userNotFoundTitle ? _self.userNotFoundTitle : userNotFoundTitle // ignore: cast_nullable_to_non_nullable
as String?,userNotFoundMessage: freezed == userNotFoundMessage ? _self.userNotFoundMessage : userNotFoundMessage // ignore: cast_nullable_to_non_nullable
as String?,remainingContacts: freezed == remainingContacts ? _self.remainingContacts : remainingContacts // ignore: cast_nullable_to_non_nullable
as dynamic,hasViewedContact: freezed == hasViewedContact ? _self.hasViewedContact : hasViewedContact // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileAllowed: freezed == viewProfileAllowed ? _self.viewProfileAllowed : viewProfileAllowed // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of OtherMemberProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ProfileDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [OtherMemberProfileResponseModel].
extension OtherMemberProfileResponseModelPatterns on OtherMemberProfileResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtherMemberProfileResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtherMemberProfileResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtherMemberProfileResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _OtherMemberProfileResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtherMemberProfileResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _OtherMemberProfileResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ProfileData? data, @JsonKey(name: 'user_not_found_status')  dynamic userNotFoundStatus, @JsonKey(name: 'user_not_found_title')  String? userNotFoundTitle, @JsonKey(name: 'user_not_found_message')  String? userNotFoundMessage, @JsonKey(name: 'remaining_contacts')  dynamic remainingContacts, @JsonKey(name: 'has_viewed_contact')  dynamic hasViewedContact, @JsonKey(name: 'view_profile_allowed')  dynamic viewProfileAllowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtherMemberProfileResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data,_that.userNotFoundStatus,_that.userNotFoundTitle,_that.userNotFoundMessage,_that.remainingContacts,_that.hasViewedContact,_that.viewProfileAllowed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ProfileData? data, @JsonKey(name: 'user_not_found_status')  dynamic userNotFoundStatus, @JsonKey(name: 'user_not_found_title')  String? userNotFoundTitle, @JsonKey(name: 'user_not_found_message')  String? userNotFoundMessage, @JsonKey(name: 'remaining_contacts')  dynamic remainingContacts, @JsonKey(name: 'has_viewed_contact')  dynamic hasViewedContact, @JsonKey(name: 'view_profile_allowed')  dynamic viewProfileAllowed)  $default,) {final _that = this;
switch (_that) {
case _OtherMemberProfileResponseModel():
return $default(_that.code,_that.status,_that.message,_that.data,_that.userNotFoundStatus,_that.userNotFoundTitle,_that.userNotFoundMessage,_that.remainingContacts,_that.hasViewedContact,_that.viewProfileAllowed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  ProfileData? data, @JsonKey(name: 'user_not_found_status')  dynamic userNotFoundStatus, @JsonKey(name: 'user_not_found_title')  String? userNotFoundTitle, @JsonKey(name: 'user_not_found_message')  String? userNotFoundMessage, @JsonKey(name: 'remaining_contacts')  dynamic remainingContacts, @JsonKey(name: 'has_viewed_contact')  dynamic hasViewedContact, @JsonKey(name: 'view_profile_allowed')  dynamic viewProfileAllowed)?  $default,) {final _that = this;
switch (_that) {
case _OtherMemberProfileResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data,_that.userNotFoundStatus,_that.userNotFoundTitle,_that.userNotFoundMessage,_that.remainingContacts,_that.hasViewedContact,_that.viewProfileAllowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtherMemberProfileResponseModel implements OtherMemberProfileResponseModel {
  const _OtherMemberProfileResponseModel({this.code, this.status, this.message, this.data, @JsonKey(name: 'user_not_found_status') this.userNotFoundStatus, @JsonKey(name: 'user_not_found_title') this.userNotFoundTitle, @JsonKey(name: 'user_not_found_message') this.userNotFoundMessage, @JsonKey(name: 'remaining_contacts') this.remainingContacts, @JsonKey(name: 'has_viewed_contact') this.hasViewedContact, @JsonKey(name: 'view_profile_allowed') this.viewProfileAllowed});
  factory _OtherMemberProfileResponseModel.fromJson(Map<String, dynamic> json) => _$OtherMemberProfileResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  ProfileData? data;
@override@JsonKey(name: 'user_not_found_status') final  dynamic userNotFoundStatus;
@override@JsonKey(name: 'user_not_found_title') final  String? userNotFoundTitle;
@override@JsonKey(name: 'user_not_found_message') final  String? userNotFoundMessage;
@override@JsonKey(name: 'remaining_contacts') final  dynamic remainingContacts;
@override@JsonKey(name: 'has_viewed_contact') final  dynamic hasViewedContact;
@override@JsonKey(name: 'view_profile_allowed') final  dynamic viewProfileAllowed;

/// Create a copy of OtherMemberProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtherMemberProfileResponseModelCopyWith<_OtherMemberProfileResponseModel> get copyWith => __$OtherMemberProfileResponseModelCopyWithImpl<_OtherMemberProfileResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtherMemberProfileResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtherMemberProfileResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&const DeepCollectionEquality().equals(other.userNotFoundStatus, userNotFoundStatus)&&(identical(other.userNotFoundTitle, userNotFoundTitle) || other.userNotFoundTitle == userNotFoundTitle)&&(identical(other.userNotFoundMessage, userNotFoundMessage) || other.userNotFoundMessage == userNotFoundMessage)&&const DeepCollectionEquality().equals(other.remainingContacts, remainingContacts)&&const DeepCollectionEquality().equals(other.hasViewedContact, hasViewedContact)&&const DeepCollectionEquality().equals(other.viewProfileAllowed, viewProfileAllowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data,const DeepCollectionEquality().hash(userNotFoundStatus),userNotFoundTitle,userNotFoundMessage,const DeepCollectionEquality().hash(remainingContacts),const DeepCollectionEquality().hash(hasViewedContact),const DeepCollectionEquality().hash(viewProfileAllowed));
}

@override
String toString() {
    return 'OtherMemberProfileResponseModel(code: $code, status: $status, message: $message, data: $data, userNotFoundStatus: $userNotFoundStatus, userNotFoundTitle: $userNotFoundTitle, userNotFoundMessage: $userNotFoundMessage, remainingContacts: $remainingContacts, hasViewedContact: $hasViewedContact, viewProfileAllowed: $viewProfileAllowed)';
}


}

/// @nodoc
abstract mixin class _$OtherMemberProfileResponseModelCopyWith<$Res> implements $OtherMemberProfileResponseModelCopyWith<$Res> {
  factory _$OtherMemberProfileResponseModelCopyWith(_OtherMemberProfileResponseModel value, $Res Function(_OtherMemberProfileResponseModel) _then) = __$OtherMemberProfileResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, ProfileData? data,@JsonKey(name: 'user_not_found_status') dynamic userNotFoundStatus,@JsonKey(name: 'user_not_found_title') String? userNotFoundTitle,@JsonKey(name: 'user_not_found_message') String? userNotFoundMessage,@JsonKey(name: 'remaining_contacts') dynamic remainingContacts,@JsonKey(name: 'has_viewed_contact') dynamic hasViewedContact,@JsonKey(name: 'view_profile_allowed') dynamic viewProfileAllowed
});


@override $ProfileDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$OtherMemberProfileResponseModelCopyWithImpl<$Res>
    implements _$OtherMemberProfileResponseModelCopyWith<$Res> {
  __$OtherMemberProfileResponseModelCopyWithImpl(this._self, this._then);

  final _OtherMemberProfileResponseModel _self;
  final $Res Function(_OtherMemberProfileResponseModel) _then;

/// Create a copy of OtherMemberProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,Object? userNotFoundStatus = freezed,Object? userNotFoundTitle = freezed,Object? userNotFoundMessage = freezed,Object? remainingContacts = freezed,Object? hasViewedContact = freezed,Object? viewProfileAllowed = freezed,}) {
  return _then(_OtherMemberProfileResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProfileData?,userNotFoundStatus: freezed == userNotFoundStatus ? _self.userNotFoundStatus : userNotFoundStatus // ignore: cast_nullable_to_non_nullable
as dynamic,userNotFoundTitle: freezed == userNotFoundTitle ? _self.userNotFoundTitle : userNotFoundTitle // ignore: cast_nullable_to_non_nullable
as String?,userNotFoundMessage: freezed == userNotFoundMessage ? _self.userNotFoundMessage : userNotFoundMessage // ignore: cast_nullable_to_non_nullable
as String?,remainingContacts: freezed == remainingContacts ? _self.remainingContacts : remainingContacts // ignore: cast_nullable_to_non_nullable
as dynamic,hasViewedContact: freezed == hasViewedContact ? _self.hasViewedContact : hasViewedContact // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileAllowed: freezed == viewProfileAllowed ? _self.viewProfileAllowed : viewProfileAllowed // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of OtherMemberProfileResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ProfileDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ProfileData {

 dynamic get id;@JsonKey(name: 'user_type') dynamic get userType;@JsonKey(name: 'matri_id') dynamic get matriId; dynamic get email; dynamic get mobile;@JsonKey(name: 'first_name') dynamic get firstName;@JsonKey(name: 'last_name') dynamic get lastName; dynamic get fullname; dynamic get birthdate; dynamic get gender;@JsonKey(name: 'country_id') dynamic get countryId;@JsonKey(name: 'state_id') dynamic get stateId; dynamic get city; dynamic get address;@JsonKey(name: 'marital_status') dynamic get maritalStatus;@JsonKey(name: 'total_children') dynamic get totalChildren;@JsonKey(name: 'status_children') dynamic get statusChildren; dynamic get religion; dynamic get caste; dynamic get subcaste; dynamic get manglik; dynamic get star; dynamic get gothra; dynamic get moonsign;@JsonKey(name: 'mother_tongue') dynamic get motherTongue; dynamic get height; dynamic get weight; dynamic get diet; dynamic get smoke; dynamic get drink;@JsonKey(name: 'body_type') dynamic get bodyType;@JsonKey(name: 'skin_tone') dynamic get skinTone;@JsonKey(name: 'education_level') dynamic get educationLevel;@JsonKey(name: 'education_details') dynamic get educationDetails;@JsonKey(name: 'employee_in') dynamic get employeeIn;@JsonKey(name: 'employee_in_details') dynamic get employeeInDetails;@JsonKey(name: 'occupation') dynamic get occupation;@JsonKey(name: 'occupation_details') dynamic get occupationDetails;@JsonKey(name: 'designation_level') dynamic get designationLevel; dynamic get income;@JsonKey(name: 'family_type') dynamic get familyType;@JsonKey(name: 'family_status') dynamic get familyStatus;@JsonKey(name: 'no_of_brother') dynamic get noOfBrother;@JsonKey(name: 'no_of_sister') dynamic get noOfSister;@JsonKey(name: 'no_of_married_brother') dynamic get noOfMarriedBrother;@JsonKey(name: 'no_of_married_sister') dynamic get noOfMarriedSister;@JsonKey(name: 'photo1') dynamic get photo1;@JsonKey(name: 'photo1_status') dynamic get photo1Status;@JsonKey(name: 'photo2') dynamic get photo2;@JsonKey(name: 'photo2_status') dynamic get photo2Status;@JsonKey(name: 'photo3') dynamic get photo3;@JsonKey(name: 'photo3_status') dynamic get photo3Status;@JsonKey(name: 'photo4') dynamic get photo4;@JsonKey(name: 'photo4_status') dynamic get photo4Status;@JsonKey(name: 'plan_name') dynamic get planName;@JsonKey(name: 'plan_status') dynamic get planStatus;@JsonKey(name: 'country_name') dynamic get countryName;@JsonKey(name: 'state_name') dynamic get stateName;@JsonKey(name: 'city_name') dynamic get cityName;@JsonKey(name: 'religion_name') dynamic get religionName;@JsonKey(name: 'caste_name') dynamic get casteName;@JsonKey(name: 'occupation_name') dynamic get occupationName;@JsonKey(name: 'education_name') dynamic get educationName;@JsonKey(name: 'interest_state') String? get interestState;@JsonKey(name: 'interest_status') String? get interestStatus;@JsonKey(name: 'interest_id') dynamic get interestId;@JsonKey(name: 'total_reminder_count') int? get totalReminderCount;@JsonKey(name: 'pending_reminder_count') int? get pendingReminderCount;@JsonKey(name: 'can_send_reminder') bool? get canSendReminder;@JsonKey(name: 'is_shortlisted') dynamic get isShortlisted;@JsonKey(name: 'is_block') dynamic get isBlock;@JsonKey(name: 'profile_title') dynamic get profileTitle;@JsonKey(name: 'myprofilTab') List<TabData>? get myProfileTab;@JsonKey(name: 'partnerPreferenceTab') List<TabData>? get partnerPreferenceTab;@JsonKey(name: 'id_proof_front') dynamic get idProofFront;@JsonKey(name: 'id_proof_back') dynamic get idProofBack;@JsonKey(name: 'id_proof_status') dynamic get idProofStatus;@JsonKey(name: 'id_proof_type') dynamic get idProofType;@JsonKey(name: 'horoscope_file') dynamic get horoscopeFile;@JsonKey(name: 'horoscope_status') dynamic get horoscopeStatus;@JsonKey(name: 'profile_image') dynamic get profileImage;@JsonKey(name: 'is_photo_protected') dynamic get isPhotoProtected;@JsonKey(name: 'is_photo_request_sent') dynamic get isPhotoRequestSent;@JsonKey(name: 'father_name') dynamic get fatherName;@JsonKey(name: 'father_occupation') dynamic get fatherOccupation;@JsonKey(name: 'father_mobile_number') dynamic get fatherMobileNumber;@JsonKey(name: 'father_present') dynamic get fatherPresent;@JsonKey(name: 'mother_name') dynamic get motherName;@JsonKey(name: 'mother_occupation') dynamic get motherOccupation;@JsonKey(name: 'mother_mobile_number') dynamic get motherMobileNumber;@JsonKey(name: 'mother_present') dynamic get motherPresent;@JsonKey(name: 'family_details') dynamic get familyDetails;@JsonKey(name: 'residence_type') dynamic get residenceType;@JsonKey(name: 'alternate_number') dynamic get alternateNumber;@JsonKey(name: 'nri_country') dynamic get nriCountry;@JsonKey(name: 'part_religion') dynamic get partReligion;@JsonKey(name: 'part_caste') dynamic get partCaste;@JsonKey(name: 'part_country') dynamic get partCountry;@JsonKey(name: 'part_state') dynamic get partState;@JsonKey(name: 'part_income') dynamic get partIncome;@JsonKey(name: 'part_marital_status') dynamic get partMaritalStatus;@JsonKey(name: 'part_education') dynamic get partEducation;@JsonKey(name: 'part_occupation') dynamic get partOccupation;@JsonKey(name: 'part_mothertongue') dynamic get partMothertongue;@JsonKey(name: 'part_manglik') dynamic get partManglik;@JsonKey(name: 'part_frm_age') dynamic get partFrmAge;@JsonKey(name: 'part_to_age') dynamic get partToAge;@JsonKey(name: 'part_height') dynamic get partHeight;@JsonKey(name: 'part_height_to') dynamic get partHeightTo;@JsonKey(name: 'profile_text') dynamic get profileText;@JsonKey(name: 'sub_title') dynamic get subTitle; dynamic get age;@JsonKey(name: 'height_str') dynamic get heightStr;@JsonKey(name: 'matchPercent') dynamic get matchPercent;@JsonKey(name: 'completed_profile') dynamic get completedProfile;@JsonKey(name: 'mobile_verify_status') dynamic get mobileVerifyStatus;@JsonKey(name: 'cpass_status') dynamic get cpassStatus;@JsonKey(name: 'profileby') dynamic get profileBy; dynamic get horoscope; dynamic get birthplace; dynamic get birthtime;@JsonKey(name: 'video_call_setting') dynamic get videoCallSetting;@JsonKey(name: 'voice_call_setting') dynamic get voiceCallSetting; dynamic get pincode;@JsonKey(name: 'residence_type_other') dynamic get residenceTypeOther;@JsonKey(name: 'photo_visibility') dynamic get photoVisibility;@JsonKey(name: 'contact_visibility') dynamic get contactVisibility;@JsonKey(name: 'brother_details_arr') List<dynamic>? get brotherDetailsArr;@JsonKey(name: 'sister_details_arr') List<dynamic>? get sisterDetailsArr;@JsonKey(name: 'paternal_family') List<dynamic>? get paternalFamily;@JsonKey(name: 'maternal_family') List<dynamic>? get maternalFamily;@JsonKey(name: 'download_biodata') dynamic get downloadBiodata;@JsonKey(name: 'view_profile_allowed') dynamic get viewProfileAllowed;
/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<ProfileData> get copyWith => _$ProfileDataCopyWithImpl<ProfileData>(this as ProfileData, _$identity);

  /// Serializes this ProfileData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileData&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.userType, _this.userType)&&const DeepCollectionEquality().equals(other.matriId, _this.matriId)&&const DeepCollectionEquality().equals(other.email, _this.email)&&const DeepCollectionEquality().equals(other.mobile, _this.mobile)&&const DeepCollectionEquality().equals(other.firstName, _this.firstName)&&const DeepCollectionEquality().equals(other.lastName, _this.lastName)&&const DeepCollectionEquality().equals(other.fullname, _this.fullname)&&const DeepCollectionEquality().equals(other.birthdate, _this.birthdate)&&const DeepCollectionEquality().equals(other.gender, _this.gender)&&const DeepCollectionEquality().equals(other.countryId, _this.countryId)&&const DeepCollectionEquality().equals(other.stateId, _this.stateId)&&const DeepCollectionEquality().equals(other.city, _this.city)&&const DeepCollectionEquality().equals(other.address, _this.address)&&const DeepCollectionEquality().equals(other.maritalStatus, _this.maritalStatus)&&const DeepCollectionEquality().equals(other.totalChildren, _this.totalChildren)&&const DeepCollectionEquality().equals(other.statusChildren, _this.statusChildren)&&const DeepCollectionEquality().equals(other.religion, _this.religion)&&const DeepCollectionEquality().equals(other.caste, _this.caste)&&const DeepCollectionEquality().equals(other.subcaste, _this.subcaste)&&const DeepCollectionEquality().equals(other.manglik, _this.manglik)&&const DeepCollectionEquality().equals(other.star, _this.star)&&const DeepCollectionEquality().equals(other.gothra, _this.gothra)&&const DeepCollectionEquality().equals(other.moonsign, _this.moonsign)&&const DeepCollectionEquality().equals(other.motherTongue, _this.motherTongue)&&const DeepCollectionEquality().equals(other.height, _this.height)&&const DeepCollectionEquality().equals(other.weight, _this.weight)&&const DeepCollectionEquality().equals(other.diet, _this.diet)&&const DeepCollectionEquality().equals(other.smoke, _this.smoke)&&const DeepCollectionEquality().equals(other.drink, _this.drink)&&const DeepCollectionEquality().equals(other.bodyType, _this.bodyType)&&const DeepCollectionEquality().equals(other.skinTone, _this.skinTone)&&const DeepCollectionEquality().equals(other.educationLevel, _this.educationLevel)&&const DeepCollectionEquality().equals(other.educationDetails, _this.educationDetails)&&const DeepCollectionEquality().equals(other.employeeIn, _this.employeeIn)&&const DeepCollectionEquality().equals(other.employeeInDetails, _this.employeeInDetails)&&const DeepCollectionEquality().equals(other.occupation, _this.occupation)&&const DeepCollectionEquality().equals(other.occupationDetails, _this.occupationDetails)&&const DeepCollectionEquality().equals(other.designationLevel, _this.designationLevel)&&const DeepCollectionEquality().equals(other.income, _this.income)&&const DeepCollectionEquality().equals(other.familyType, _this.familyType)&&const DeepCollectionEquality().equals(other.familyStatus, _this.familyStatus)&&const DeepCollectionEquality().equals(other.noOfBrother, _this.noOfBrother)&&const DeepCollectionEquality().equals(other.noOfSister, _this.noOfSister)&&const DeepCollectionEquality().equals(other.noOfMarriedBrother, _this.noOfMarriedBrother)&&const DeepCollectionEquality().equals(other.noOfMarriedSister, _this.noOfMarriedSister)&&const DeepCollectionEquality().equals(other.photo1, _this.photo1)&&const DeepCollectionEquality().equals(other.photo1Status, _this.photo1Status)&&const DeepCollectionEquality().equals(other.photo2, _this.photo2)&&const DeepCollectionEquality().equals(other.photo2Status, _this.photo2Status)&&const DeepCollectionEquality().equals(other.photo3, _this.photo3)&&const DeepCollectionEquality().equals(other.photo3Status, _this.photo3Status)&&const DeepCollectionEquality().equals(other.photo4, _this.photo4)&&const DeepCollectionEquality().equals(other.photo4Status, _this.photo4Status)&&const DeepCollectionEquality().equals(other.planName, _this.planName)&&const DeepCollectionEquality().equals(other.planStatus, _this.planStatus)&&const DeepCollectionEquality().equals(other.countryName, _this.countryName)&&const DeepCollectionEquality().equals(other.stateName, _this.stateName)&&const DeepCollectionEquality().equals(other.cityName, _this.cityName)&&const DeepCollectionEquality().equals(other.religionName, _this.religionName)&&const DeepCollectionEquality().equals(other.casteName, _this.casteName)&&const DeepCollectionEquality().equals(other.occupationName, _this.occupationName)&&const DeepCollectionEquality().equals(other.educationName, _this.educationName)&&(identical(other.interestState, _this.interestState) || other.interestState == _this.interestState)&&(identical(other.interestStatus, _this.interestStatus) || other.interestStatus == _this.interestStatus)&&const DeepCollectionEquality().equals(other.interestId, _this.interestId)&&(identical(other.totalReminderCount, _this.totalReminderCount) || other.totalReminderCount == _this.totalReminderCount)&&(identical(other.pendingReminderCount, _this.pendingReminderCount) || other.pendingReminderCount == _this.pendingReminderCount)&&(identical(other.canSendReminder, _this.canSendReminder) || other.canSendReminder == _this.canSendReminder)&&const DeepCollectionEquality().equals(other.isShortlisted, _this.isShortlisted)&&const DeepCollectionEquality().equals(other.isBlock, _this.isBlock)&&const DeepCollectionEquality().equals(other.profileTitle, _this.profileTitle)&&const DeepCollectionEquality().equals(other.myProfileTab, _this.myProfileTab)&&const DeepCollectionEquality().equals(other.partnerPreferenceTab, _this.partnerPreferenceTab)&&const DeepCollectionEquality().equals(other.idProofFront, _this.idProofFront)&&const DeepCollectionEquality().equals(other.idProofBack, _this.idProofBack)&&const DeepCollectionEquality().equals(other.idProofStatus, _this.idProofStatus)&&const DeepCollectionEquality().equals(other.idProofType, _this.idProofType)&&const DeepCollectionEquality().equals(other.horoscopeFile, _this.horoscopeFile)&&const DeepCollectionEquality().equals(other.horoscopeStatus, _this.horoscopeStatus)&&const DeepCollectionEquality().equals(other.profileImage, _this.profileImage)&&const DeepCollectionEquality().equals(other.isPhotoProtected, _this.isPhotoProtected)&&const DeepCollectionEquality().equals(other.isPhotoRequestSent, _this.isPhotoRequestSent)&&const DeepCollectionEquality().equals(other.fatherName, _this.fatherName)&&const DeepCollectionEquality().equals(other.fatherOccupation, _this.fatherOccupation)&&const DeepCollectionEquality().equals(other.fatherMobileNumber, _this.fatherMobileNumber)&&const DeepCollectionEquality().equals(other.fatherPresent, _this.fatherPresent)&&const DeepCollectionEquality().equals(other.motherName, _this.motherName)&&const DeepCollectionEquality().equals(other.motherOccupation, _this.motherOccupation)&&const DeepCollectionEquality().equals(other.motherMobileNumber, _this.motherMobileNumber)&&const DeepCollectionEquality().equals(other.motherPresent, _this.motherPresent)&&const DeepCollectionEquality().equals(other.familyDetails, _this.familyDetails)&&const DeepCollectionEquality().equals(other.residenceType, _this.residenceType)&&const DeepCollectionEquality().equals(other.alternateNumber, _this.alternateNumber)&&const DeepCollectionEquality().equals(other.nriCountry, _this.nriCountry)&&const DeepCollectionEquality().equals(other.partReligion, _this.partReligion)&&const DeepCollectionEquality().equals(other.partCaste, _this.partCaste)&&const DeepCollectionEquality().equals(other.partCountry, _this.partCountry)&&const DeepCollectionEquality().equals(other.partState, _this.partState)&&const DeepCollectionEquality().equals(other.partIncome, _this.partIncome)&&const DeepCollectionEquality().equals(other.partMaritalStatus, _this.partMaritalStatus)&&const DeepCollectionEquality().equals(other.partEducation, _this.partEducation)&&const DeepCollectionEquality().equals(other.partOccupation, _this.partOccupation)&&const DeepCollectionEquality().equals(other.partMothertongue, _this.partMothertongue)&&const DeepCollectionEquality().equals(other.partManglik, _this.partManglik)&&const DeepCollectionEquality().equals(other.partFrmAge, _this.partFrmAge)&&const DeepCollectionEquality().equals(other.partToAge, _this.partToAge)&&const DeepCollectionEquality().equals(other.partHeight, _this.partHeight)&&const DeepCollectionEquality().equals(other.partHeightTo, _this.partHeightTo)&&const DeepCollectionEquality().equals(other.profileText, _this.profileText)&&const DeepCollectionEquality().equals(other.subTitle, _this.subTitle)&&const DeepCollectionEquality().equals(other.age, _this.age)&&const DeepCollectionEquality().equals(other.heightStr, _this.heightStr)&&const DeepCollectionEquality().equals(other.matchPercent, _this.matchPercent)&&const DeepCollectionEquality().equals(other.completedProfile, _this.completedProfile)&&const DeepCollectionEquality().equals(other.mobileVerifyStatus, _this.mobileVerifyStatus)&&const DeepCollectionEquality().equals(other.cpassStatus, _this.cpassStatus)&&const DeepCollectionEquality().equals(other.profileBy, _this.profileBy)&&const DeepCollectionEquality().equals(other.horoscope, _this.horoscope)&&const DeepCollectionEquality().equals(other.birthplace, _this.birthplace)&&const DeepCollectionEquality().equals(other.birthtime, _this.birthtime)&&const DeepCollectionEquality().equals(other.videoCallSetting, _this.videoCallSetting)&&const DeepCollectionEquality().equals(other.voiceCallSetting, _this.voiceCallSetting)&&const DeepCollectionEquality().equals(other.pincode, _this.pincode)&&const DeepCollectionEquality().equals(other.residenceTypeOther, _this.residenceTypeOther)&&const DeepCollectionEquality().equals(other.photoVisibility, _this.photoVisibility)&&const DeepCollectionEquality().equals(other.contactVisibility, _this.contactVisibility)&&const DeepCollectionEquality().equals(other.brotherDetailsArr, _this.brotherDetailsArr)&&const DeepCollectionEquality().equals(other.sisterDetailsArr, _this.sisterDetailsArr)&&const DeepCollectionEquality().equals(other.paternalFamily, _this.paternalFamily)&&const DeepCollectionEquality().equals(other.maternalFamily, _this.maternalFamily)&&const DeepCollectionEquality().equals(other.downloadBiodata, _this.downloadBiodata)&&const DeepCollectionEquality().equals(other.viewProfileAllowed, _this.viewProfileAllowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileData;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.userType),const DeepCollectionEquality().hash(_this.matriId),const DeepCollectionEquality().hash(_this.email),const DeepCollectionEquality().hash(_this.mobile),const DeepCollectionEquality().hash(_this.firstName),const DeepCollectionEquality().hash(_this.lastName),const DeepCollectionEquality().hash(_this.fullname),const DeepCollectionEquality().hash(_this.birthdate),const DeepCollectionEquality().hash(_this.gender),const DeepCollectionEquality().hash(_this.countryId),const DeepCollectionEquality().hash(_this.stateId),const DeepCollectionEquality().hash(_this.city),const DeepCollectionEquality().hash(_this.address),const DeepCollectionEquality().hash(_this.maritalStatus),const DeepCollectionEquality().hash(_this.totalChildren),const DeepCollectionEquality().hash(_this.statusChildren),const DeepCollectionEquality().hash(_this.religion),const DeepCollectionEquality().hash(_this.caste),const DeepCollectionEquality().hash(_this.subcaste),const DeepCollectionEquality().hash(_this.manglik),const DeepCollectionEquality().hash(_this.star),const DeepCollectionEquality().hash(_this.gothra),const DeepCollectionEquality().hash(_this.moonsign),const DeepCollectionEquality().hash(_this.motherTongue),const DeepCollectionEquality().hash(_this.height),const DeepCollectionEquality().hash(_this.weight),const DeepCollectionEquality().hash(_this.diet),const DeepCollectionEquality().hash(_this.smoke),const DeepCollectionEquality().hash(_this.drink),const DeepCollectionEquality().hash(_this.bodyType),const DeepCollectionEquality().hash(_this.skinTone),const DeepCollectionEquality().hash(_this.educationLevel),const DeepCollectionEquality().hash(_this.educationDetails),const DeepCollectionEquality().hash(_this.employeeIn),const DeepCollectionEquality().hash(_this.employeeInDetails),const DeepCollectionEquality().hash(_this.occupation),const DeepCollectionEquality().hash(_this.occupationDetails),const DeepCollectionEquality().hash(_this.designationLevel),const DeepCollectionEquality().hash(_this.income),const DeepCollectionEquality().hash(_this.familyType),const DeepCollectionEquality().hash(_this.familyStatus),const DeepCollectionEquality().hash(_this.noOfBrother),const DeepCollectionEquality().hash(_this.noOfSister),const DeepCollectionEquality().hash(_this.noOfMarriedBrother),const DeepCollectionEquality().hash(_this.noOfMarriedSister),const DeepCollectionEquality().hash(_this.photo1),const DeepCollectionEquality().hash(_this.photo1Status),const DeepCollectionEquality().hash(_this.photo2),const DeepCollectionEquality().hash(_this.photo2Status),const DeepCollectionEquality().hash(_this.photo3),const DeepCollectionEquality().hash(_this.photo3Status),const DeepCollectionEquality().hash(_this.photo4),const DeepCollectionEquality().hash(_this.photo4Status),const DeepCollectionEquality().hash(_this.planName),const DeepCollectionEquality().hash(_this.planStatus),const DeepCollectionEquality().hash(_this.countryName),const DeepCollectionEquality().hash(_this.stateName),const DeepCollectionEquality().hash(_this.cityName),const DeepCollectionEquality().hash(_this.religionName),const DeepCollectionEquality().hash(_this.casteName),const DeepCollectionEquality().hash(_this.occupationName),const DeepCollectionEquality().hash(_this.educationName),_this.interestState,_this.interestStatus,const DeepCollectionEquality().hash(_this.interestId),_this.totalReminderCount,_this.pendingReminderCount,_this.canSendReminder,const DeepCollectionEquality().hash(_this.isShortlisted),const DeepCollectionEquality().hash(_this.isBlock),const DeepCollectionEquality().hash(_this.profileTitle),const DeepCollectionEquality().hash(_this.myProfileTab),const DeepCollectionEquality().hash(_this.partnerPreferenceTab),const DeepCollectionEquality().hash(_this.idProofFront),const DeepCollectionEquality().hash(_this.idProofBack),const DeepCollectionEquality().hash(_this.idProofStatus),const DeepCollectionEquality().hash(_this.idProofType),const DeepCollectionEquality().hash(_this.horoscopeFile),const DeepCollectionEquality().hash(_this.horoscopeStatus),const DeepCollectionEquality().hash(_this.profileImage),const DeepCollectionEquality().hash(_this.isPhotoProtected),const DeepCollectionEquality().hash(_this.isPhotoRequestSent),const DeepCollectionEquality().hash(_this.fatherName),const DeepCollectionEquality().hash(_this.fatherOccupation),const DeepCollectionEquality().hash(_this.fatherMobileNumber),const DeepCollectionEquality().hash(_this.fatherPresent),const DeepCollectionEquality().hash(_this.motherName),const DeepCollectionEquality().hash(_this.motherOccupation),const DeepCollectionEquality().hash(_this.motherMobileNumber),const DeepCollectionEquality().hash(_this.motherPresent),const DeepCollectionEquality().hash(_this.familyDetails),const DeepCollectionEquality().hash(_this.residenceType),const DeepCollectionEquality().hash(_this.alternateNumber),const DeepCollectionEquality().hash(_this.nriCountry),const DeepCollectionEquality().hash(_this.partReligion),const DeepCollectionEquality().hash(_this.partCaste),const DeepCollectionEquality().hash(_this.partCountry),const DeepCollectionEquality().hash(_this.partState),const DeepCollectionEquality().hash(_this.partIncome),const DeepCollectionEquality().hash(_this.partMaritalStatus),const DeepCollectionEquality().hash(_this.partEducation),const DeepCollectionEquality().hash(_this.partOccupation),const DeepCollectionEquality().hash(_this.partMothertongue),const DeepCollectionEquality().hash(_this.partManglik),const DeepCollectionEquality().hash(_this.partFrmAge),const DeepCollectionEquality().hash(_this.partToAge),const DeepCollectionEquality().hash(_this.partHeight),const DeepCollectionEquality().hash(_this.partHeightTo),const DeepCollectionEquality().hash(_this.profileText),const DeepCollectionEquality().hash(_this.subTitle),const DeepCollectionEquality().hash(_this.age),const DeepCollectionEquality().hash(_this.heightStr),const DeepCollectionEquality().hash(_this.matchPercent),const DeepCollectionEquality().hash(_this.completedProfile),const DeepCollectionEquality().hash(_this.mobileVerifyStatus),const DeepCollectionEquality().hash(_this.cpassStatus),const DeepCollectionEquality().hash(_this.profileBy),const DeepCollectionEquality().hash(_this.horoscope),const DeepCollectionEquality().hash(_this.birthplace),const DeepCollectionEquality().hash(_this.birthtime),const DeepCollectionEquality().hash(_this.videoCallSetting),const DeepCollectionEquality().hash(_this.voiceCallSetting),const DeepCollectionEquality().hash(_this.pincode),const DeepCollectionEquality().hash(_this.residenceTypeOther),const DeepCollectionEquality().hash(_this.photoVisibility),const DeepCollectionEquality().hash(_this.contactVisibility),const DeepCollectionEquality().hash(_this.brotherDetailsArr),const DeepCollectionEquality().hash(_this.sisterDetailsArr),const DeepCollectionEquality().hash(_this.paternalFamily),const DeepCollectionEquality().hash(_this.maternalFamily),const DeepCollectionEquality().hash(_this.downloadBiodata),const DeepCollectionEquality().hash(_this.viewProfileAllowed)]);
}

@override
String toString() {
  final _this = this as ProfileData;
  return 'ProfileData(id: ${_this.id}, userType: ${_this.userType}, matriId: ${_this.matriId}, email: ${_this.email}, mobile: ${_this.mobile}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, fullname: ${_this.fullname}, birthdate: ${_this.birthdate}, gender: ${_this.gender}, countryId: ${_this.countryId}, stateId: ${_this.stateId}, city: ${_this.city}, address: ${_this.address}, maritalStatus: ${_this.maritalStatus}, totalChildren: ${_this.totalChildren}, statusChildren: ${_this.statusChildren}, religion: ${_this.religion}, caste: ${_this.caste}, subcaste: ${_this.subcaste}, manglik: ${_this.manglik}, star: ${_this.star}, gothra: ${_this.gothra}, moonsign: ${_this.moonsign}, motherTongue: ${_this.motherTongue}, height: ${_this.height}, weight: ${_this.weight}, diet: ${_this.diet}, smoke: ${_this.smoke}, drink: ${_this.drink}, bodyType: ${_this.bodyType}, skinTone: ${_this.skinTone}, educationLevel: ${_this.educationLevel}, educationDetails: ${_this.educationDetails}, employeeIn: ${_this.employeeIn}, employeeInDetails: ${_this.employeeInDetails}, occupation: ${_this.occupation}, occupationDetails: ${_this.occupationDetails}, designationLevel: ${_this.designationLevel}, income: ${_this.income}, familyType: ${_this.familyType}, familyStatus: ${_this.familyStatus}, noOfBrother: ${_this.noOfBrother}, noOfSister: ${_this.noOfSister}, noOfMarriedBrother: ${_this.noOfMarriedBrother}, noOfMarriedSister: ${_this.noOfMarriedSister}, photo1: ${_this.photo1}, photo1Status: ${_this.photo1Status}, photo2: ${_this.photo2}, photo2Status: ${_this.photo2Status}, photo3: ${_this.photo3}, photo3Status: ${_this.photo3Status}, photo4: ${_this.photo4}, photo4Status: ${_this.photo4Status}, planName: ${_this.planName}, planStatus: ${_this.planStatus}, countryName: ${_this.countryName}, stateName: ${_this.stateName}, cityName: ${_this.cityName}, religionName: ${_this.religionName}, casteName: ${_this.casteName}, occupationName: ${_this.occupationName}, educationName: ${_this.educationName}, interestState: ${_this.interestState}, interestStatus: ${_this.interestStatus}, interestId: ${_this.interestId}, totalReminderCount: ${_this.totalReminderCount}, pendingReminderCount: ${_this.pendingReminderCount}, canSendReminder: ${_this.canSendReminder}, isShortlisted: ${_this.isShortlisted}, isBlock: ${_this.isBlock}, profileTitle: ${_this.profileTitle}, myProfileTab: ${_this.myProfileTab}, partnerPreferenceTab: ${_this.partnerPreferenceTab}, idProofFront: ${_this.idProofFront}, idProofBack: ${_this.idProofBack}, idProofStatus: ${_this.idProofStatus}, idProofType: ${_this.idProofType}, horoscopeFile: ${_this.horoscopeFile}, horoscopeStatus: ${_this.horoscopeStatus}, profileImage: ${_this.profileImage}, isPhotoProtected: ${_this.isPhotoProtected}, isPhotoRequestSent: ${_this.isPhotoRequestSent}, fatherName: ${_this.fatherName}, fatherOccupation: ${_this.fatherOccupation}, fatherMobileNumber: ${_this.fatherMobileNumber}, fatherPresent: ${_this.fatherPresent}, motherName: ${_this.motherName}, motherOccupation: ${_this.motherOccupation}, motherMobileNumber: ${_this.motherMobileNumber}, motherPresent: ${_this.motherPresent}, familyDetails: ${_this.familyDetails}, residenceType: ${_this.residenceType}, alternateNumber: ${_this.alternateNumber}, nriCountry: ${_this.nriCountry}, partReligion: ${_this.partReligion}, partCaste: ${_this.partCaste}, partCountry: ${_this.partCountry}, partState: ${_this.partState}, partIncome: ${_this.partIncome}, partMaritalStatus: ${_this.partMaritalStatus}, partEducation: ${_this.partEducation}, partOccupation: ${_this.partOccupation}, partMothertongue: ${_this.partMothertongue}, partManglik: ${_this.partManglik}, partFrmAge: ${_this.partFrmAge}, partToAge: ${_this.partToAge}, partHeight: ${_this.partHeight}, partHeightTo: ${_this.partHeightTo}, profileText: ${_this.profileText}, subTitle: ${_this.subTitle}, age: ${_this.age}, heightStr: ${_this.heightStr}, matchPercent: ${_this.matchPercent}, completedProfile: ${_this.completedProfile}, mobileVerifyStatus: ${_this.mobileVerifyStatus}, cpassStatus: ${_this.cpassStatus}, profileBy: ${_this.profileBy}, horoscope: ${_this.horoscope}, birthplace: ${_this.birthplace}, birthtime: ${_this.birthtime}, videoCallSetting: ${_this.videoCallSetting}, voiceCallSetting: ${_this.voiceCallSetting}, pincode: ${_this.pincode}, residenceTypeOther: ${_this.residenceTypeOther}, photoVisibility: ${_this.photoVisibility}, contactVisibility: ${_this.contactVisibility}, brotherDetailsArr: ${_this.brotherDetailsArr}, sisterDetailsArr: ${_this.sisterDetailsArr}, paternalFamily: ${_this.paternalFamily}, maternalFamily: ${_this.maternalFamily}, downloadBiodata: ${_this.downloadBiodata}, viewProfileAllowed: ${_this.viewProfileAllowed})';
}


}

/// @nodoc
abstract mixin class $ProfileDataCopyWith<$Res>  {
  factory $ProfileDataCopyWith(ProfileData value, $Res Function(ProfileData) _then) = _$ProfileDataCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'user_type') dynamic userType,@JsonKey(name: 'matri_id') dynamic matriId, dynamic email, dynamic mobile,@JsonKey(name: 'first_name') dynamic firstName,@JsonKey(name: 'last_name') dynamic lastName, dynamic fullname, dynamic birthdate, dynamic gender,@JsonKey(name: 'country_id') dynamic countryId,@JsonKey(name: 'state_id') dynamic stateId, dynamic city, dynamic address,@JsonKey(name: 'marital_status') dynamic maritalStatus,@JsonKey(name: 'total_children') dynamic totalChildren,@JsonKey(name: 'status_children') dynamic statusChildren, dynamic religion, dynamic caste, dynamic subcaste, dynamic manglik, dynamic star, dynamic gothra, dynamic moonsign,@JsonKey(name: 'mother_tongue') dynamic motherTongue, dynamic height, dynamic weight, dynamic diet, dynamic smoke, dynamic drink,@JsonKey(name: 'body_type') dynamic bodyType,@JsonKey(name: 'skin_tone') dynamic skinTone,@JsonKey(name: 'education_level') dynamic educationLevel,@JsonKey(name: 'education_details') dynamic educationDetails,@JsonKey(name: 'employee_in') dynamic employeeIn,@JsonKey(name: 'employee_in_details') dynamic employeeInDetails,@JsonKey(name: 'occupation') dynamic occupation,@JsonKey(name: 'occupation_details') dynamic occupationDetails,@JsonKey(name: 'designation_level') dynamic designationLevel, dynamic income,@JsonKey(name: 'family_type') dynamic familyType,@JsonKey(name: 'family_status') dynamic familyStatus,@JsonKey(name: 'no_of_brother') dynamic noOfBrother,@JsonKey(name: 'no_of_sister') dynamic noOfSister,@JsonKey(name: 'no_of_married_brother') dynamic noOfMarriedBrother,@JsonKey(name: 'no_of_married_sister') dynamic noOfMarriedSister,@JsonKey(name: 'photo1') dynamic photo1,@JsonKey(name: 'photo1_status') dynamic photo1Status,@JsonKey(name: 'photo2') dynamic photo2,@JsonKey(name: 'photo2_status') dynamic photo2Status,@JsonKey(name: 'photo3') dynamic photo3,@JsonKey(name: 'photo3_status') dynamic photo3Status,@JsonKey(name: 'photo4') dynamic photo4,@JsonKey(name: 'photo4_status') dynamic photo4Status,@JsonKey(name: 'plan_name') dynamic planName,@JsonKey(name: 'plan_status') dynamic planStatus,@JsonKey(name: 'country_name') dynamic countryName,@JsonKey(name: 'state_name') dynamic stateName,@JsonKey(name: 'city_name') dynamic cityName,@JsonKey(name: 'religion_name') dynamic religionName,@JsonKey(name: 'caste_name') dynamic casteName,@JsonKey(name: 'occupation_name') dynamic occupationName,@JsonKey(name: 'education_name') dynamic educationName,@JsonKey(name: 'interest_state') String? interestState,@JsonKey(name: 'interest_status') String? interestStatus,@JsonKey(name: 'interest_id') dynamic interestId,@JsonKey(name: 'total_reminder_count') int? totalReminderCount,@JsonKey(name: 'pending_reminder_count') int? pendingReminderCount,@JsonKey(name: 'can_send_reminder') bool? canSendReminder,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_block') dynamic isBlock,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'myprofilTab') List<TabData>? myProfileTab,@JsonKey(name: 'partnerPreferenceTab') List<TabData>? partnerPreferenceTab,@JsonKey(name: 'id_proof_front') dynamic idProofFront,@JsonKey(name: 'id_proof_back') dynamic idProofBack,@JsonKey(name: 'id_proof_status') dynamic idProofStatus,@JsonKey(name: 'id_proof_type') dynamic idProofType,@JsonKey(name: 'horoscope_file') dynamic horoscopeFile,@JsonKey(name: 'horoscope_status') dynamic horoscopeStatus,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'is_photo_protected') dynamic isPhotoProtected,@JsonKey(name: 'is_photo_request_sent') dynamic isPhotoRequestSent,@JsonKey(name: 'father_name') dynamic fatherName,@JsonKey(name: 'father_occupation') dynamic fatherOccupation,@JsonKey(name: 'father_mobile_number') dynamic fatherMobileNumber,@JsonKey(name: 'father_present') dynamic fatherPresent,@JsonKey(name: 'mother_name') dynamic motherName,@JsonKey(name: 'mother_occupation') dynamic motherOccupation,@JsonKey(name: 'mother_mobile_number') dynamic motherMobileNumber,@JsonKey(name: 'mother_present') dynamic motherPresent,@JsonKey(name: 'family_details') dynamic familyDetails,@JsonKey(name: 'residence_type') dynamic residenceType,@JsonKey(name: 'alternate_number') dynamic alternateNumber,@JsonKey(name: 'nri_country') dynamic nriCountry,@JsonKey(name: 'part_religion') dynamic partReligion,@JsonKey(name: 'part_caste') dynamic partCaste,@JsonKey(name: 'part_country') dynamic partCountry,@JsonKey(name: 'part_state') dynamic partState,@JsonKey(name: 'part_income') dynamic partIncome,@JsonKey(name: 'part_marital_status') dynamic partMaritalStatus,@JsonKey(name: 'part_education') dynamic partEducation,@JsonKey(name: 'part_occupation') dynamic partOccupation,@JsonKey(name: 'part_mothertongue') dynamic partMothertongue,@JsonKey(name: 'part_manglik') dynamic partManglik,@JsonKey(name: 'part_frm_age') dynamic partFrmAge,@JsonKey(name: 'part_to_age') dynamic partToAge,@JsonKey(name: 'part_height') dynamic partHeight,@JsonKey(name: 'part_height_to') dynamic partHeightTo,@JsonKey(name: 'profile_text') dynamic profileText,@JsonKey(name: 'sub_title') dynamic subTitle, dynamic age,@JsonKey(name: 'height_str') dynamic heightStr,@JsonKey(name: 'matchPercent') dynamic matchPercent,@JsonKey(name: 'completed_profile') dynamic completedProfile,@JsonKey(name: 'mobile_verify_status') dynamic mobileVerifyStatus,@JsonKey(name: 'cpass_status') dynamic cpassStatus,@JsonKey(name: 'profileby') dynamic profileBy, dynamic horoscope, dynamic birthplace, dynamic birthtime,@JsonKey(name: 'video_call_setting') dynamic videoCallSetting,@JsonKey(name: 'voice_call_setting') dynamic voiceCallSetting, dynamic pincode,@JsonKey(name: 'residence_type_other') dynamic residenceTypeOther,@JsonKey(name: 'photo_visibility') dynamic photoVisibility,@JsonKey(name: 'contact_visibility') dynamic contactVisibility,@JsonKey(name: 'brother_details_arr') List<dynamic>? brotherDetailsArr,@JsonKey(name: 'sister_details_arr') List<dynamic>? sisterDetailsArr,@JsonKey(name: 'paternal_family') List<dynamic>? paternalFamily,@JsonKey(name: 'maternal_family') List<dynamic>? maternalFamily,@JsonKey(name: 'download_biodata') dynamic downloadBiodata,@JsonKey(name: 'view_profile_allowed') dynamic viewProfileAllowed
});




}
/// @nodoc
class _$ProfileDataCopyWithImpl<$Res>
    implements $ProfileDataCopyWith<$Res> {
  _$ProfileDataCopyWithImpl(this._self, this._then);

  final ProfileData _self;
  final $Res Function(ProfileData) _then;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userType = freezed,Object? matriId = freezed,Object? email = freezed,Object? mobile = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? fullname = freezed,Object? birthdate = freezed,Object? gender = freezed,Object? countryId = freezed,Object? stateId = freezed,Object? city = freezed,Object? address = freezed,Object? maritalStatus = freezed,Object? totalChildren = freezed,Object? statusChildren = freezed,Object? religion = freezed,Object? caste = freezed,Object? subcaste = freezed,Object? manglik = freezed,Object? star = freezed,Object? gothra = freezed,Object? moonsign = freezed,Object? motherTongue = freezed,Object? height = freezed,Object? weight = freezed,Object? diet = freezed,Object? smoke = freezed,Object? drink = freezed,Object? bodyType = freezed,Object? skinTone = freezed,Object? educationLevel = freezed,Object? educationDetails = freezed,Object? employeeIn = freezed,Object? employeeInDetails = freezed,Object? occupation = freezed,Object? occupationDetails = freezed,Object? designationLevel = freezed,Object? income = freezed,Object? familyType = freezed,Object? familyStatus = freezed,Object? noOfBrother = freezed,Object? noOfSister = freezed,Object? noOfMarriedBrother = freezed,Object? noOfMarriedSister = freezed,Object? photo1 = freezed,Object? photo1Status = freezed,Object? photo2 = freezed,Object? photo2Status = freezed,Object? photo3 = freezed,Object? photo3Status = freezed,Object? photo4 = freezed,Object? photo4Status = freezed,Object? planName = freezed,Object? planStatus = freezed,Object? countryName = freezed,Object? stateName = freezed,Object? cityName = freezed,Object? religionName = freezed,Object? casteName = freezed,Object? occupationName = freezed,Object? educationName = freezed,Object? interestState = freezed,Object? interestStatus = freezed,Object? interestId = freezed,Object? totalReminderCount = freezed,Object? pendingReminderCount = freezed,Object? canSendReminder = freezed,Object? isShortlisted = freezed,Object? isBlock = freezed,Object? profileTitle = freezed,Object? myProfileTab = freezed,Object? partnerPreferenceTab = freezed,Object? idProofFront = freezed,Object? idProofBack = freezed,Object? idProofStatus = freezed,Object? idProofType = freezed,Object? horoscopeFile = freezed,Object? horoscopeStatus = freezed,Object? profileImage = freezed,Object? isPhotoProtected = freezed,Object? isPhotoRequestSent = freezed,Object? fatherName = freezed,Object? fatherOccupation = freezed,Object? fatherMobileNumber = freezed,Object? fatherPresent = freezed,Object? motherName = freezed,Object? motherOccupation = freezed,Object? motherMobileNumber = freezed,Object? motherPresent = freezed,Object? familyDetails = freezed,Object? residenceType = freezed,Object? alternateNumber = freezed,Object? nriCountry = freezed,Object? partReligion = freezed,Object? partCaste = freezed,Object? partCountry = freezed,Object? partState = freezed,Object? partIncome = freezed,Object? partMaritalStatus = freezed,Object? partEducation = freezed,Object? partOccupation = freezed,Object? partMothertongue = freezed,Object? partManglik = freezed,Object? partFrmAge = freezed,Object? partToAge = freezed,Object? partHeight = freezed,Object? partHeightTo = freezed,Object? profileText = freezed,Object? subTitle = freezed,Object? age = freezed,Object? heightStr = freezed,Object? matchPercent = freezed,Object? completedProfile = freezed,Object? mobileVerifyStatus = freezed,Object? cpassStatus = freezed,Object? profileBy = freezed,Object? horoscope = freezed,Object? birthplace = freezed,Object? birthtime = freezed,Object? videoCallSetting = freezed,Object? voiceCallSetting = freezed,Object? pincode = freezed,Object? residenceTypeOther = freezed,Object? photoVisibility = freezed,Object? contactVisibility = freezed,Object? brotherDetailsArr = freezed,Object? sisterDetailsArr = freezed,Object? paternalFamily = freezed,Object? maternalFamily = freezed,Object? downloadBiodata = freezed,Object? viewProfileAllowed = freezed,}) {
  return _then(ProfileData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as dynamic,matriId: freezed == matriId ? _self.matriId : matriId // ignore: cast_nullable_to_non_nullable
as dynamic,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as dynamic,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as dynamic,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as dynamic,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as dynamic,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as dynamic,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as dynamic,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as dynamic,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as dynamic,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as dynamic,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as dynamic,totalChildren: freezed == totalChildren ? _self.totalChildren : totalChildren // ignore: cast_nullable_to_non_nullable
as dynamic,statusChildren: freezed == statusChildren ? _self.statusChildren : statusChildren // ignore: cast_nullable_to_non_nullable
as dynamic,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as dynamic,caste: freezed == caste ? _self.caste : caste // ignore: cast_nullable_to_non_nullable
as dynamic,subcaste: freezed == subcaste ? _self.subcaste : subcaste // ignore: cast_nullable_to_non_nullable
as dynamic,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as dynamic,star: freezed == star ? _self.star : star // ignore: cast_nullable_to_non_nullable
as dynamic,gothra: freezed == gothra ? _self.gothra : gothra // ignore: cast_nullable_to_non_nullable
as dynamic,moonsign: freezed == moonsign ? _self.moonsign : moonsign // ignore: cast_nullable_to_non_nullable
as dynamic,motherTongue: freezed == motherTongue ? _self.motherTongue : motherTongue // ignore: cast_nullable_to_non_nullable
as dynamic,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as dynamic,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as dynamic,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as dynamic,smoke: freezed == smoke ? _self.smoke : smoke // ignore: cast_nullable_to_non_nullable
as dynamic,drink: freezed == drink ? _self.drink : drink // ignore: cast_nullable_to_non_nullable
as dynamic,bodyType: freezed == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as dynamic,skinTone: freezed == skinTone ? _self.skinTone : skinTone // ignore: cast_nullable_to_non_nullable
as dynamic,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as dynamic,educationDetails: freezed == educationDetails ? _self.educationDetails : educationDetails // ignore: cast_nullable_to_non_nullable
as dynamic,employeeIn: freezed == employeeIn ? _self.employeeIn : employeeIn // ignore: cast_nullable_to_non_nullable
as dynamic,employeeInDetails: freezed == employeeInDetails ? _self.employeeInDetails : employeeInDetails // ignore: cast_nullable_to_non_nullable
as dynamic,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as dynamic,occupationDetails: freezed == occupationDetails ? _self.occupationDetails : occupationDetails // ignore: cast_nullable_to_non_nullable
as dynamic,designationLevel: freezed == designationLevel ? _self.designationLevel : designationLevel // ignore: cast_nullable_to_non_nullable
as dynamic,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as dynamic,familyType: freezed == familyType ? _self.familyType : familyType // ignore: cast_nullable_to_non_nullable
as dynamic,familyStatus: freezed == familyStatus ? _self.familyStatus : familyStatus // ignore: cast_nullable_to_non_nullable
as dynamic,noOfBrother: freezed == noOfBrother ? _self.noOfBrother : noOfBrother // ignore: cast_nullable_to_non_nullable
as dynamic,noOfSister: freezed == noOfSister ? _self.noOfSister : noOfSister // ignore: cast_nullable_to_non_nullable
as dynamic,noOfMarriedBrother: freezed == noOfMarriedBrother ? _self.noOfMarriedBrother : noOfMarriedBrother // ignore: cast_nullable_to_non_nullable
as dynamic,noOfMarriedSister: freezed == noOfMarriedSister ? _self.noOfMarriedSister : noOfMarriedSister // ignore: cast_nullable_to_non_nullable
as dynamic,photo1: freezed == photo1 ? _self.photo1 : photo1 // ignore: cast_nullable_to_non_nullable
as dynamic,photo1Status: freezed == photo1Status ? _self.photo1Status : photo1Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo2: freezed == photo2 ? _self.photo2 : photo2 // ignore: cast_nullable_to_non_nullable
as dynamic,photo2Status: freezed == photo2Status ? _self.photo2Status : photo2Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo3: freezed == photo3 ? _self.photo3 : photo3 // ignore: cast_nullable_to_non_nullable
as dynamic,photo3Status: freezed == photo3Status ? _self.photo3Status : photo3Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo4: freezed == photo4 ? _self.photo4 : photo4 // ignore: cast_nullable_to_non_nullable
as dynamic,photo4Status: freezed == photo4Status ? _self.photo4Status : photo4Status // ignore: cast_nullable_to_non_nullable
as dynamic,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as dynamic,planStatus: freezed == planStatus ? _self.planStatus : planStatus // ignore: cast_nullable_to_non_nullable
as dynamic,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as dynamic,stateName: freezed == stateName ? _self.stateName : stateName // ignore: cast_nullable_to_non_nullable
as dynamic,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as dynamic,religionName: freezed == religionName ? _self.religionName : religionName // ignore: cast_nullable_to_non_nullable
as dynamic,casteName: freezed == casteName ? _self.casteName : casteName // ignore: cast_nullable_to_non_nullable
as dynamic,occupationName: freezed == occupationName ? _self.occupationName : occupationName // ignore: cast_nullable_to_non_nullable
as dynamic,educationName: freezed == educationName ? _self.educationName : educationName // ignore: cast_nullable_to_non_nullable
as dynamic,interestState: freezed == interestState ? _self.interestState : interestState // ignore: cast_nullable_to_non_nullable
as String?,interestStatus: freezed == interestStatus ? _self.interestStatus : interestStatus // ignore: cast_nullable_to_non_nullable
as String?,interestId: freezed == interestId ? _self.interestId : interestId // ignore: cast_nullable_to_non_nullable
as dynamic,totalReminderCount: freezed == totalReminderCount ? _self.totalReminderCount : totalReminderCount // ignore: cast_nullable_to_non_nullable
as int?,pendingReminderCount: freezed == pendingReminderCount ? _self.pendingReminderCount : pendingReminderCount // ignore: cast_nullable_to_non_nullable
as int?,canSendReminder: freezed == canSendReminder ? _self.canSendReminder : canSendReminder // ignore: cast_nullable_to_non_nullable
as bool?,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,myProfileTab: freezed == myProfileTab ? _self.myProfileTab : myProfileTab // ignore: cast_nullable_to_non_nullable
as List<TabData>?,partnerPreferenceTab: freezed == partnerPreferenceTab ? _self.partnerPreferenceTab : partnerPreferenceTab // ignore: cast_nullable_to_non_nullable
as List<TabData>?,idProofFront: freezed == idProofFront ? _self.idProofFront : idProofFront // ignore: cast_nullable_to_non_nullable
as dynamic,idProofBack: freezed == idProofBack ? _self.idProofBack : idProofBack // ignore: cast_nullable_to_non_nullable
as dynamic,idProofStatus: freezed == idProofStatus ? _self.idProofStatus : idProofStatus // ignore: cast_nullable_to_non_nullable
as dynamic,idProofType: freezed == idProofType ? _self.idProofType : idProofType // ignore: cast_nullable_to_non_nullable
as dynamic,horoscopeFile: freezed == horoscopeFile ? _self.horoscopeFile : horoscopeFile // ignore: cast_nullable_to_non_nullable
as dynamic,horoscopeStatus: freezed == horoscopeStatus ? _self.horoscopeStatus : horoscopeStatus // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoRequestSent: freezed == isPhotoRequestSent ? _self.isPhotoRequestSent : isPhotoRequestSent // ignore: cast_nullable_to_non_nullable
as dynamic,fatherName: freezed == fatherName ? _self.fatherName : fatherName // ignore: cast_nullable_to_non_nullable
as dynamic,fatherOccupation: freezed == fatherOccupation ? _self.fatherOccupation : fatherOccupation // ignore: cast_nullable_to_non_nullable
as dynamic,fatherMobileNumber: freezed == fatherMobileNumber ? _self.fatherMobileNumber : fatherMobileNumber // ignore: cast_nullable_to_non_nullable
as dynamic,fatherPresent: freezed == fatherPresent ? _self.fatherPresent : fatherPresent // ignore: cast_nullable_to_non_nullable
as dynamic,motherName: freezed == motherName ? _self.motherName : motherName // ignore: cast_nullable_to_non_nullable
as dynamic,motherOccupation: freezed == motherOccupation ? _self.motherOccupation : motherOccupation // ignore: cast_nullable_to_non_nullable
as dynamic,motherMobileNumber: freezed == motherMobileNumber ? _self.motherMobileNumber : motherMobileNumber // ignore: cast_nullable_to_non_nullable
as dynamic,motherPresent: freezed == motherPresent ? _self.motherPresent : motherPresent // ignore: cast_nullable_to_non_nullable
as dynamic,familyDetails: freezed == familyDetails ? _self.familyDetails : familyDetails // ignore: cast_nullable_to_non_nullable
as dynamic,residenceType: freezed == residenceType ? _self.residenceType : residenceType // ignore: cast_nullable_to_non_nullable
as dynamic,alternateNumber: freezed == alternateNumber ? _self.alternateNumber : alternateNumber // ignore: cast_nullable_to_non_nullable
as dynamic,nriCountry: freezed == nriCountry ? _self.nriCountry : nriCountry // ignore: cast_nullable_to_non_nullable
as dynamic,partReligion: freezed == partReligion ? _self.partReligion : partReligion // ignore: cast_nullable_to_non_nullable
as dynamic,partCaste: freezed == partCaste ? _self.partCaste : partCaste // ignore: cast_nullable_to_non_nullable
as dynamic,partCountry: freezed == partCountry ? _self.partCountry : partCountry // ignore: cast_nullable_to_non_nullable
as dynamic,partState: freezed == partState ? _self.partState : partState // ignore: cast_nullable_to_non_nullable
as dynamic,partIncome: freezed == partIncome ? _self.partIncome : partIncome // ignore: cast_nullable_to_non_nullable
as dynamic,partMaritalStatus: freezed == partMaritalStatus ? _self.partMaritalStatus : partMaritalStatus // ignore: cast_nullable_to_non_nullable
as dynamic,partEducation: freezed == partEducation ? _self.partEducation : partEducation // ignore: cast_nullable_to_non_nullable
as dynamic,partOccupation: freezed == partOccupation ? _self.partOccupation : partOccupation // ignore: cast_nullable_to_non_nullable
as dynamic,partMothertongue: freezed == partMothertongue ? _self.partMothertongue : partMothertongue // ignore: cast_nullable_to_non_nullable
as dynamic,partManglik: freezed == partManglik ? _self.partManglik : partManglik // ignore: cast_nullable_to_non_nullable
as dynamic,partFrmAge: freezed == partFrmAge ? _self.partFrmAge : partFrmAge // ignore: cast_nullable_to_non_nullable
as dynamic,partToAge: freezed == partToAge ? _self.partToAge : partToAge // ignore: cast_nullable_to_non_nullable
as dynamic,partHeight: freezed == partHeight ? _self.partHeight : partHeight // ignore: cast_nullable_to_non_nullable
as dynamic,partHeightTo: freezed == partHeightTo ? _self.partHeightTo : partHeightTo // ignore: cast_nullable_to_non_nullable
as dynamic,profileText: freezed == profileText ? _self.profileText : profileText // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as dynamic,heightStr: freezed == heightStr ? _self.heightStr : heightStr // ignore: cast_nullable_to_non_nullable
as dynamic,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,completedProfile: freezed == completedProfile ? _self.completedProfile : completedProfile // ignore: cast_nullable_to_non_nullable
as dynamic,mobileVerifyStatus: freezed == mobileVerifyStatus ? _self.mobileVerifyStatus : mobileVerifyStatus // ignore: cast_nullable_to_non_nullable
as dynamic,cpassStatus: freezed == cpassStatus ? _self.cpassStatus : cpassStatus // ignore: cast_nullable_to_non_nullable
as dynamic,profileBy: freezed == profileBy ? _self.profileBy : profileBy // ignore: cast_nullable_to_non_nullable
as dynamic,horoscope: freezed == horoscope ? _self.horoscope : horoscope // ignore: cast_nullable_to_non_nullable
as dynamic,birthplace: freezed == birthplace ? _self.birthplace : birthplace // ignore: cast_nullable_to_non_nullable
as dynamic,birthtime: freezed == birthtime ? _self.birthtime : birthtime // ignore: cast_nullable_to_non_nullable
as dynamic,videoCallSetting: freezed == videoCallSetting ? _self.videoCallSetting : videoCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,voiceCallSetting: freezed == voiceCallSetting ? _self.voiceCallSetting : voiceCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as dynamic,residenceTypeOther: freezed == residenceTypeOther ? _self.residenceTypeOther : residenceTypeOther // ignore: cast_nullable_to_non_nullable
as dynamic,photoVisibility: freezed == photoVisibility ? _self.photoVisibility : photoVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,contactVisibility: freezed == contactVisibility ? _self.contactVisibility : contactVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,brotherDetailsArr: freezed == brotherDetailsArr ? _self.brotherDetailsArr : brotherDetailsArr // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,sisterDetailsArr: freezed == sisterDetailsArr ? _self.sisterDetailsArr : sisterDetailsArr // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,paternalFamily: freezed == paternalFamily ? _self.paternalFamily : paternalFamily // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,maternalFamily: freezed == maternalFamily ? _self.maternalFamily : maternalFamily // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,downloadBiodata: freezed == downloadBiodata ? _self.downloadBiodata : downloadBiodata // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileAllowed: freezed == viewProfileAllowed ? _self.viewProfileAllowed : viewProfileAllowed // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileData].
extension ProfileDataPatterns on ProfileData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileData value)  $default,){
final _that = this;
switch (_that) {
case _ProfileData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileData value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'user_type')  dynamic userType, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic email,  dynamic mobile, @JsonKey(name: 'first_name')  dynamic firstName, @JsonKey(name: 'last_name')  dynamic lastName,  dynamic fullname,  dynamic birthdate,  dynamic gender, @JsonKey(name: 'country_id')  dynamic countryId, @JsonKey(name: 'state_id')  dynamic stateId,  dynamic city,  dynamic address, @JsonKey(name: 'marital_status')  dynamic maritalStatus, @JsonKey(name: 'total_children')  dynamic totalChildren, @JsonKey(name: 'status_children')  dynamic statusChildren,  dynamic religion,  dynamic caste,  dynamic subcaste,  dynamic manglik,  dynamic star,  dynamic gothra,  dynamic moonsign, @JsonKey(name: 'mother_tongue')  dynamic motherTongue,  dynamic height,  dynamic weight,  dynamic diet,  dynamic smoke,  dynamic drink, @JsonKey(name: 'body_type')  dynamic bodyType, @JsonKey(name: 'skin_tone')  dynamic skinTone, @JsonKey(name: 'education_level')  dynamic educationLevel, @JsonKey(name: 'education_details')  dynamic educationDetails, @JsonKey(name: 'employee_in')  dynamic employeeIn, @JsonKey(name: 'employee_in_details')  dynamic employeeInDetails, @JsonKey(name: 'occupation')  dynamic occupation, @JsonKey(name: 'occupation_details')  dynamic occupationDetails, @JsonKey(name: 'designation_level')  dynamic designationLevel,  dynamic income, @JsonKey(name: 'family_type')  dynamic familyType, @JsonKey(name: 'family_status')  dynamic familyStatus, @JsonKey(name: 'no_of_brother')  dynamic noOfBrother, @JsonKey(name: 'no_of_sister')  dynamic noOfSister, @JsonKey(name: 'no_of_married_brother')  dynamic noOfMarriedBrother, @JsonKey(name: 'no_of_married_sister')  dynamic noOfMarriedSister, @JsonKey(name: 'photo1')  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status, @JsonKey(name: 'photo2')  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status, @JsonKey(name: 'photo3')  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status, @JsonKey(name: 'photo4')  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'plan_name')  dynamic planName, @JsonKey(name: 'plan_status')  dynamic planStatus, @JsonKey(name: 'country_name')  dynamic countryName, @JsonKey(name: 'state_name')  dynamic stateName, @JsonKey(name: 'city_name')  dynamic cityName, @JsonKey(name: 'religion_name')  dynamic religionName, @JsonKey(name: 'caste_name')  dynamic casteName, @JsonKey(name: 'occupation_name')  dynamic occupationName, @JsonKey(name: 'education_name')  dynamic educationName, @JsonKey(name: 'interest_state')  String? interestState, @JsonKey(name: 'interest_status')  String? interestStatus, @JsonKey(name: 'interest_id')  dynamic interestId, @JsonKey(name: 'total_reminder_count')  int? totalReminderCount, @JsonKey(name: 'pending_reminder_count')  int? pendingReminderCount, @JsonKey(name: 'can_send_reminder')  bool? canSendReminder, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_block')  dynamic isBlock, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'myprofilTab')  List<TabData>? myProfileTab, @JsonKey(name: 'partnerPreferenceTab')  List<TabData>? partnerPreferenceTab, @JsonKey(name: 'id_proof_front')  dynamic idProofFront, @JsonKey(name: 'id_proof_back')  dynamic idProofBack, @JsonKey(name: 'id_proof_status')  dynamic idProofStatus, @JsonKey(name: 'id_proof_type')  dynamic idProofType, @JsonKey(name: 'horoscope_file')  dynamic horoscopeFile, @JsonKey(name: 'horoscope_status')  dynamic horoscopeStatus, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'is_photo_protected')  dynamic isPhotoProtected, @JsonKey(name: 'is_photo_request_sent')  dynamic isPhotoRequestSent, @JsonKey(name: 'father_name')  dynamic fatherName, @JsonKey(name: 'father_occupation')  dynamic fatherOccupation, @JsonKey(name: 'father_mobile_number')  dynamic fatherMobileNumber, @JsonKey(name: 'father_present')  dynamic fatherPresent, @JsonKey(name: 'mother_name')  dynamic motherName, @JsonKey(name: 'mother_occupation')  dynamic motherOccupation, @JsonKey(name: 'mother_mobile_number')  dynamic motherMobileNumber, @JsonKey(name: 'mother_present')  dynamic motherPresent, @JsonKey(name: 'family_details')  dynamic familyDetails, @JsonKey(name: 'residence_type')  dynamic residenceType, @JsonKey(name: 'alternate_number')  dynamic alternateNumber, @JsonKey(name: 'nri_country')  dynamic nriCountry, @JsonKey(name: 'part_religion')  dynamic partReligion, @JsonKey(name: 'part_caste')  dynamic partCaste, @JsonKey(name: 'part_country')  dynamic partCountry, @JsonKey(name: 'part_state')  dynamic partState, @JsonKey(name: 'part_income')  dynamic partIncome, @JsonKey(name: 'part_marital_status')  dynamic partMaritalStatus, @JsonKey(name: 'part_education')  dynamic partEducation, @JsonKey(name: 'part_occupation')  dynamic partOccupation, @JsonKey(name: 'part_mothertongue')  dynamic partMothertongue, @JsonKey(name: 'part_manglik')  dynamic partManglik, @JsonKey(name: 'part_frm_age')  dynamic partFrmAge, @JsonKey(name: 'part_to_age')  dynamic partToAge, @JsonKey(name: 'part_height')  dynamic partHeight, @JsonKey(name: 'part_height_to')  dynamic partHeightTo, @JsonKey(name: 'profile_text')  dynamic profileText, @JsonKey(name: 'sub_title')  dynamic subTitle,  dynamic age, @JsonKey(name: 'height_str')  dynamic heightStr, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'completed_profile')  dynamic completedProfile, @JsonKey(name: 'mobile_verify_status')  dynamic mobileVerifyStatus, @JsonKey(name: 'cpass_status')  dynamic cpassStatus, @JsonKey(name: 'profileby')  dynamic profileBy,  dynamic horoscope,  dynamic birthplace,  dynamic birthtime, @JsonKey(name: 'video_call_setting')  dynamic videoCallSetting, @JsonKey(name: 'voice_call_setting')  dynamic voiceCallSetting,  dynamic pincode, @JsonKey(name: 'residence_type_other')  dynamic residenceTypeOther, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility, @JsonKey(name: 'contact_visibility')  dynamic contactVisibility, @JsonKey(name: 'brother_details_arr')  List<dynamic>? brotherDetailsArr, @JsonKey(name: 'sister_details_arr')  List<dynamic>? sisterDetailsArr, @JsonKey(name: 'paternal_family')  List<dynamic>? paternalFamily, @JsonKey(name: 'maternal_family')  List<dynamic>? maternalFamily, @JsonKey(name: 'download_biodata')  dynamic downloadBiodata, @JsonKey(name: 'view_profile_allowed')  dynamic viewProfileAllowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
return $default(_that.id,_that.userType,_that.matriId,_that.email,_that.mobile,_that.firstName,_that.lastName,_that.fullname,_that.birthdate,_that.gender,_that.countryId,_that.stateId,_that.city,_that.address,_that.maritalStatus,_that.totalChildren,_that.statusChildren,_that.religion,_that.caste,_that.subcaste,_that.manglik,_that.star,_that.gothra,_that.moonsign,_that.motherTongue,_that.height,_that.weight,_that.diet,_that.smoke,_that.drink,_that.bodyType,_that.skinTone,_that.educationLevel,_that.educationDetails,_that.employeeIn,_that.employeeInDetails,_that.occupation,_that.occupationDetails,_that.designationLevel,_that.income,_that.familyType,_that.familyStatus,_that.noOfBrother,_that.noOfSister,_that.noOfMarriedBrother,_that.noOfMarriedSister,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.planName,_that.planStatus,_that.countryName,_that.stateName,_that.cityName,_that.religionName,_that.casteName,_that.occupationName,_that.educationName,_that.interestState,_that.interestStatus,_that.interestId,_that.totalReminderCount,_that.pendingReminderCount,_that.canSendReminder,_that.isShortlisted,_that.isBlock,_that.profileTitle,_that.myProfileTab,_that.partnerPreferenceTab,_that.idProofFront,_that.idProofBack,_that.idProofStatus,_that.idProofType,_that.horoscopeFile,_that.horoscopeStatus,_that.profileImage,_that.isPhotoProtected,_that.isPhotoRequestSent,_that.fatherName,_that.fatherOccupation,_that.fatherMobileNumber,_that.fatherPresent,_that.motherName,_that.motherOccupation,_that.motherMobileNumber,_that.motherPresent,_that.familyDetails,_that.residenceType,_that.alternateNumber,_that.nriCountry,_that.partReligion,_that.partCaste,_that.partCountry,_that.partState,_that.partIncome,_that.partMaritalStatus,_that.partEducation,_that.partOccupation,_that.partMothertongue,_that.partManglik,_that.partFrmAge,_that.partToAge,_that.partHeight,_that.partHeightTo,_that.profileText,_that.subTitle,_that.age,_that.heightStr,_that.matchPercent,_that.completedProfile,_that.mobileVerifyStatus,_that.cpassStatus,_that.profileBy,_that.horoscope,_that.birthplace,_that.birthtime,_that.videoCallSetting,_that.voiceCallSetting,_that.pincode,_that.residenceTypeOther,_that.photoVisibility,_that.contactVisibility,_that.brotherDetailsArr,_that.sisterDetailsArr,_that.paternalFamily,_that.maternalFamily,_that.downloadBiodata,_that.viewProfileAllowed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'user_type')  dynamic userType, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic email,  dynamic mobile, @JsonKey(name: 'first_name')  dynamic firstName, @JsonKey(name: 'last_name')  dynamic lastName,  dynamic fullname,  dynamic birthdate,  dynamic gender, @JsonKey(name: 'country_id')  dynamic countryId, @JsonKey(name: 'state_id')  dynamic stateId,  dynamic city,  dynamic address, @JsonKey(name: 'marital_status')  dynamic maritalStatus, @JsonKey(name: 'total_children')  dynamic totalChildren, @JsonKey(name: 'status_children')  dynamic statusChildren,  dynamic religion,  dynamic caste,  dynamic subcaste,  dynamic manglik,  dynamic star,  dynamic gothra,  dynamic moonsign, @JsonKey(name: 'mother_tongue')  dynamic motherTongue,  dynamic height,  dynamic weight,  dynamic diet,  dynamic smoke,  dynamic drink, @JsonKey(name: 'body_type')  dynamic bodyType, @JsonKey(name: 'skin_tone')  dynamic skinTone, @JsonKey(name: 'education_level')  dynamic educationLevel, @JsonKey(name: 'education_details')  dynamic educationDetails, @JsonKey(name: 'employee_in')  dynamic employeeIn, @JsonKey(name: 'employee_in_details')  dynamic employeeInDetails, @JsonKey(name: 'occupation')  dynamic occupation, @JsonKey(name: 'occupation_details')  dynamic occupationDetails, @JsonKey(name: 'designation_level')  dynamic designationLevel,  dynamic income, @JsonKey(name: 'family_type')  dynamic familyType, @JsonKey(name: 'family_status')  dynamic familyStatus, @JsonKey(name: 'no_of_brother')  dynamic noOfBrother, @JsonKey(name: 'no_of_sister')  dynamic noOfSister, @JsonKey(name: 'no_of_married_brother')  dynamic noOfMarriedBrother, @JsonKey(name: 'no_of_married_sister')  dynamic noOfMarriedSister, @JsonKey(name: 'photo1')  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status, @JsonKey(name: 'photo2')  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status, @JsonKey(name: 'photo3')  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status, @JsonKey(name: 'photo4')  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'plan_name')  dynamic planName, @JsonKey(name: 'plan_status')  dynamic planStatus, @JsonKey(name: 'country_name')  dynamic countryName, @JsonKey(name: 'state_name')  dynamic stateName, @JsonKey(name: 'city_name')  dynamic cityName, @JsonKey(name: 'religion_name')  dynamic religionName, @JsonKey(name: 'caste_name')  dynamic casteName, @JsonKey(name: 'occupation_name')  dynamic occupationName, @JsonKey(name: 'education_name')  dynamic educationName, @JsonKey(name: 'interest_state')  String? interestState, @JsonKey(name: 'interest_status')  String? interestStatus, @JsonKey(name: 'interest_id')  dynamic interestId, @JsonKey(name: 'total_reminder_count')  int? totalReminderCount, @JsonKey(name: 'pending_reminder_count')  int? pendingReminderCount, @JsonKey(name: 'can_send_reminder')  bool? canSendReminder, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_block')  dynamic isBlock, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'myprofilTab')  List<TabData>? myProfileTab, @JsonKey(name: 'partnerPreferenceTab')  List<TabData>? partnerPreferenceTab, @JsonKey(name: 'id_proof_front')  dynamic idProofFront, @JsonKey(name: 'id_proof_back')  dynamic idProofBack, @JsonKey(name: 'id_proof_status')  dynamic idProofStatus, @JsonKey(name: 'id_proof_type')  dynamic idProofType, @JsonKey(name: 'horoscope_file')  dynamic horoscopeFile, @JsonKey(name: 'horoscope_status')  dynamic horoscopeStatus, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'is_photo_protected')  dynamic isPhotoProtected, @JsonKey(name: 'is_photo_request_sent')  dynamic isPhotoRequestSent, @JsonKey(name: 'father_name')  dynamic fatherName, @JsonKey(name: 'father_occupation')  dynamic fatherOccupation, @JsonKey(name: 'father_mobile_number')  dynamic fatherMobileNumber, @JsonKey(name: 'father_present')  dynamic fatherPresent, @JsonKey(name: 'mother_name')  dynamic motherName, @JsonKey(name: 'mother_occupation')  dynamic motherOccupation, @JsonKey(name: 'mother_mobile_number')  dynamic motherMobileNumber, @JsonKey(name: 'mother_present')  dynamic motherPresent, @JsonKey(name: 'family_details')  dynamic familyDetails, @JsonKey(name: 'residence_type')  dynamic residenceType, @JsonKey(name: 'alternate_number')  dynamic alternateNumber, @JsonKey(name: 'nri_country')  dynamic nriCountry, @JsonKey(name: 'part_religion')  dynamic partReligion, @JsonKey(name: 'part_caste')  dynamic partCaste, @JsonKey(name: 'part_country')  dynamic partCountry, @JsonKey(name: 'part_state')  dynamic partState, @JsonKey(name: 'part_income')  dynamic partIncome, @JsonKey(name: 'part_marital_status')  dynamic partMaritalStatus, @JsonKey(name: 'part_education')  dynamic partEducation, @JsonKey(name: 'part_occupation')  dynamic partOccupation, @JsonKey(name: 'part_mothertongue')  dynamic partMothertongue, @JsonKey(name: 'part_manglik')  dynamic partManglik, @JsonKey(name: 'part_frm_age')  dynamic partFrmAge, @JsonKey(name: 'part_to_age')  dynamic partToAge, @JsonKey(name: 'part_height')  dynamic partHeight, @JsonKey(name: 'part_height_to')  dynamic partHeightTo, @JsonKey(name: 'profile_text')  dynamic profileText, @JsonKey(name: 'sub_title')  dynamic subTitle,  dynamic age, @JsonKey(name: 'height_str')  dynamic heightStr, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'completed_profile')  dynamic completedProfile, @JsonKey(name: 'mobile_verify_status')  dynamic mobileVerifyStatus, @JsonKey(name: 'cpass_status')  dynamic cpassStatus, @JsonKey(name: 'profileby')  dynamic profileBy,  dynamic horoscope,  dynamic birthplace,  dynamic birthtime, @JsonKey(name: 'video_call_setting')  dynamic videoCallSetting, @JsonKey(name: 'voice_call_setting')  dynamic voiceCallSetting,  dynamic pincode, @JsonKey(name: 'residence_type_other')  dynamic residenceTypeOther, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility, @JsonKey(name: 'contact_visibility')  dynamic contactVisibility, @JsonKey(name: 'brother_details_arr')  List<dynamic>? brotherDetailsArr, @JsonKey(name: 'sister_details_arr')  List<dynamic>? sisterDetailsArr, @JsonKey(name: 'paternal_family')  List<dynamic>? paternalFamily, @JsonKey(name: 'maternal_family')  List<dynamic>? maternalFamily, @JsonKey(name: 'download_biodata')  dynamic downloadBiodata, @JsonKey(name: 'view_profile_allowed')  dynamic viewProfileAllowed)  $default,) {final _that = this;
switch (_that) {
case _ProfileData():
return $default(_that.id,_that.userType,_that.matriId,_that.email,_that.mobile,_that.firstName,_that.lastName,_that.fullname,_that.birthdate,_that.gender,_that.countryId,_that.stateId,_that.city,_that.address,_that.maritalStatus,_that.totalChildren,_that.statusChildren,_that.religion,_that.caste,_that.subcaste,_that.manglik,_that.star,_that.gothra,_that.moonsign,_that.motherTongue,_that.height,_that.weight,_that.diet,_that.smoke,_that.drink,_that.bodyType,_that.skinTone,_that.educationLevel,_that.educationDetails,_that.employeeIn,_that.employeeInDetails,_that.occupation,_that.occupationDetails,_that.designationLevel,_that.income,_that.familyType,_that.familyStatus,_that.noOfBrother,_that.noOfSister,_that.noOfMarriedBrother,_that.noOfMarriedSister,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.planName,_that.planStatus,_that.countryName,_that.stateName,_that.cityName,_that.religionName,_that.casteName,_that.occupationName,_that.educationName,_that.interestState,_that.interestStatus,_that.interestId,_that.totalReminderCount,_that.pendingReminderCount,_that.canSendReminder,_that.isShortlisted,_that.isBlock,_that.profileTitle,_that.myProfileTab,_that.partnerPreferenceTab,_that.idProofFront,_that.idProofBack,_that.idProofStatus,_that.idProofType,_that.horoscopeFile,_that.horoscopeStatus,_that.profileImage,_that.isPhotoProtected,_that.isPhotoRequestSent,_that.fatherName,_that.fatherOccupation,_that.fatherMobileNumber,_that.fatherPresent,_that.motherName,_that.motherOccupation,_that.motherMobileNumber,_that.motherPresent,_that.familyDetails,_that.residenceType,_that.alternateNumber,_that.nriCountry,_that.partReligion,_that.partCaste,_that.partCountry,_that.partState,_that.partIncome,_that.partMaritalStatus,_that.partEducation,_that.partOccupation,_that.partMothertongue,_that.partManglik,_that.partFrmAge,_that.partToAge,_that.partHeight,_that.partHeightTo,_that.profileText,_that.subTitle,_that.age,_that.heightStr,_that.matchPercent,_that.completedProfile,_that.mobileVerifyStatus,_that.cpassStatus,_that.profileBy,_that.horoscope,_that.birthplace,_that.birthtime,_that.videoCallSetting,_that.voiceCallSetting,_that.pincode,_that.residenceTypeOther,_that.photoVisibility,_that.contactVisibility,_that.brotherDetailsArr,_that.sisterDetailsArr,_that.paternalFamily,_that.maternalFamily,_that.downloadBiodata,_that.viewProfileAllowed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'user_type')  dynamic userType, @JsonKey(name: 'matri_id')  dynamic matriId,  dynamic email,  dynamic mobile, @JsonKey(name: 'first_name')  dynamic firstName, @JsonKey(name: 'last_name')  dynamic lastName,  dynamic fullname,  dynamic birthdate,  dynamic gender, @JsonKey(name: 'country_id')  dynamic countryId, @JsonKey(name: 'state_id')  dynamic stateId,  dynamic city,  dynamic address, @JsonKey(name: 'marital_status')  dynamic maritalStatus, @JsonKey(name: 'total_children')  dynamic totalChildren, @JsonKey(name: 'status_children')  dynamic statusChildren,  dynamic religion,  dynamic caste,  dynamic subcaste,  dynamic manglik,  dynamic star,  dynamic gothra,  dynamic moonsign, @JsonKey(name: 'mother_tongue')  dynamic motherTongue,  dynamic height,  dynamic weight,  dynamic diet,  dynamic smoke,  dynamic drink, @JsonKey(name: 'body_type')  dynamic bodyType, @JsonKey(name: 'skin_tone')  dynamic skinTone, @JsonKey(name: 'education_level')  dynamic educationLevel, @JsonKey(name: 'education_details')  dynamic educationDetails, @JsonKey(name: 'employee_in')  dynamic employeeIn, @JsonKey(name: 'employee_in_details')  dynamic employeeInDetails, @JsonKey(name: 'occupation')  dynamic occupation, @JsonKey(name: 'occupation_details')  dynamic occupationDetails, @JsonKey(name: 'designation_level')  dynamic designationLevel,  dynamic income, @JsonKey(name: 'family_type')  dynamic familyType, @JsonKey(name: 'family_status')  dynamic familyStatus, @JsonKey(name: 'no_of_brother')  dynamic noOfBrother, @JsonKey(name: 'no_of_sister')  dynamic noOfSister, @JsonKey(name: 'no_of_married_brother')  dynamic noOfMarriedBrother, @JsonKey(name: 'no_of_married_sister')  dynamic noOfMarriedSister, @JsonKey(name: 'photo1')  dynamic photo1, @JsonKey(name: 'photo1_status')  dynamic photo1Status, @JsonKey(name: 'photo2')  dynamic photo2, @JsonKey(name: 'photo2_status')  dynamic photo2Status, @JsonKey(name: 'photo3')  dynamic photo3, @JsonKey(name: 'photo3_status')  dynamic photo3Status, @JsonKey(name: 'photo4')  dynamic photo4, @JsonKey(name: 'photo4_status')  dynamic photo4Status, @JsonKey(name: 'plan_name')  dynamic planName, @JsonKey(name: 'plan_status')  dynamic planStatus, @JsonKey(name: 'country_name')  dynamic countryName, @JsonKey(name: 'state_name')  dynamic stateName, @JsonKey(name: 'city_name')  dynamic cityName, @JsonKey(name: 'religion_name')  dynamic religionName, @JsonKey(name: 'caste_name')  dynamic casteName, @JsonKey(name: 'occupation_name')  dynamic occupationName, @JsonKey(name: 'education_name')  dynamic educationName, @JsonKey(name: 'interest_state')  String? interestState, @JsonKey(name: 'interest_status')  String? interestStatus, @JsonKey(name: 'interest_id')  dynamic interestId, @JsonKey(name: 'total_reminder_count')  int? totalReminderCount, @JsonKey(name: 'pending_reminder_count')  int? pendingReminderCount, @JsonKey(name: 'can_send_reminder')  bool? canSendReminder, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_block')  dynamic isBlock, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'myprofilTab')  List<TabData>? myProfileTab, @JsonKey(name: 'partnerPreferenceTab')  List<TabData>? partnerPreferenceTab, @JsonKey(name: 'id_proof_front')  dynamic idProofFront, @JsonKey(name: 'id_proof_back')  dynamic idProofBack, @JsonKey(name: 'id_proof_status')  dynamic idProofStatus, @JsonKey(name: 'id_proof_type')  dynamic idProofType, @JsonKey(name: 'horoscope_file')  dynamic horoscopeFile, @JsonKey(name: 'horoscope_status')  dynamic horoscopeStatus, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'is_photo_protected')  dynamic isPhotoProtected, @JsonKey(name: 'is_photo_request_sent')  dynamic isPhotoRequestSent, @JsonKey(name: 'father_name')  dynamic fatherName, @JsonKey(name: 'father_occupation')  dynamic fatherOccupation, @JsonKey(name: 'father_mobile_number')  dynamic fatherMobileNumber, @JsonKey(name: 'father_present')  dynamic fatherPresent, @JsonKey(name: 'mother_name')  dynamic motherName, @JsonKey(name: 'mother_occupation')  dynamic motherOccupation, @JsonKey(name: 'mother_mobile_number')  dynamic motherMobileNumber, @JsonKey(name: 'mother_present')  dynamic motherPresent, @JsonKey(name: 'family_details')  dynamic familyDetails, @JsonKey(name: 'residence_type')  dynamic residenceType, @JsonKey(name: 'alternate_number')  dynamic alternateNumber, @JsonKey(name: 'nri_country')  dynamic nriCountry, @JsonKey(name: 'part_religion')  dynamic partReligion, @JsonKey(name: 'part_caste')  dynamic partCaste, @JsonKey(name: 'part_country')  dynamic partCountry, @JsonKey(name: 'part_state')  dynamic partState, @JsonKey(name: 'part_income')  dynamic partIncome, @JsonKey(name: 'part_marital_status')  dynamic partMaritalStatus, @JsonKey(name: 'part_education')  dynamic partEducation, @JsonKey(name: 'part_occupation')  dynamic partOccupation, @JsonKey(name: 'part_mothertongue')  dynamic partMothertongue, @JsonKey(name: 'part_manglik')  dynamic partManglik, @JsonKey(name: 'part_frm_age')  dynamic partFrmAge, @JsonKey(name: 'part_to_age')  dynamic partToAge, @JsonKey(name: 'part_height')  dynamic partHeight, @JsonKey(name: 'part_height_to')  dynamic partHeightTo, @JsonKey(name: 'profile_text')  dynamic profileText, @JsonKey(name: 'sub_title')  dynamic subTitle,  dynamic age, @JsonKey(name: 'height_str')  dynamic heightStr, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'completed_profile')  dynamic completedProfile, @JsonKey(name: 'mobile_verify_status')  dynamic mobileVerifyStatus, @JsonKey(name: 'cpass_status')  dynamic cpassStatus, @JsonKey(name: 'profileby')  dynamic profileBy,  dynamic horoscope,  dynamic birthplace,  dynamic birthtime, @JsonKey(name: 'video_call_setting')  dynamic videoCallSetting, @JsonKey(name: 'voice_call_setting')  dynamic voiceCallSetting,  dynamic pincode, @JsonKey(name: 'residence_type_other')  dynamic residenceTypeOther, @JsonKey(name: 'photo_visibility')  dynamic photoVisibility, @JsonKey(name: 'contact_visibility')  dynamic contactVisibility, @JsonKey(name: 'brother_details_arr')  List<dynamic>? brotherDetailsArr, @JsonKey(name: 'sister_details_arr')  List<dynamic>? sisterDetailsArr, @JsonKey(name: 'paternal_family')  List<dynamic>? paternalFamily, @JsonKey(name: 'maternal_family')  List<dynamic>? maternalFamily, @JsonKey(name: 'download_biodata')  dynamic downloadBiodata, @JsonKey(name: 'view_profile_allowed')  dynamic viewProfileAllowed)?  $default,) {final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
return $default(_that.id,_that.userType,_that.matriId,_that.email,_that.mobile,_that.firstName,_that.lastName,_that.fullname,_that.birthdate,_that.gender,_that.countryId,_that.stateId,_that.city,_that.address,_that.maritalStatus,_that.totalChildren,_that.statusChildren,_that.religion,_that.caste,_that.subcaste,_that.manglik,_that.star,_that.gothra,_that.moonsign,_that.motherTongue,_that.height,_that.weight,_that.diet,_that.smoke,_that.drink,_that.bodyType,_that.skinTone,_that.educationLevel,_that.educationDetails,_that.employeeIn,_that.employeeInDetails,_that.occupation,_that.occupationDetails,_that.designationLevel,_that.income,_that.familyType,_that.familyStatus,_that.noOfBrother,_that.noOfSister,_that.noOfMarriedBrother,_that.noOfMarriedSister,_that.photo1,_that.photo1Status,_that.photo2,_that.photo2Status,_that.photo3,_that.photo3Status,_that.photo4,_that.photo4Status,_that.planName,_that.planStatus,_that.countryName,_that.stateName,_that.cityName,_that.religionName,_that.casteName,_that.occupationName,_that.educationName,_that.interestState,_that.interestStatus,_that.interestId,_that.totalReminderCount,_that.pendingReminderCount,_that.canSendReminder,_that.isShortlisted,_that.isBlock,_that.profileTitle,_that.myProfileTab,_that.partnerPreferenceTab,_that.idProofFront,_that.idProofBack,_that.idProofStatus,_that.idProofType,_that.horoscopeFile,_that.horoscopeStatus,_that.profileImage,_that.isPhotoProtected,_that.isPhotoRequestSent,_that.fatherName,_that.fatherOccupation,_that.fatherMobileNumber,_that.fatherPresent,_that.motherName,_that.motherOccupation,_that.motherMobileNumber,_that.motherPresent,_that.familyDetails,_that.residenceType,_that.alternateNumber,_that.nriCountry,_that.partReligion,_that.partCaste,_that.partCountry,_that.partState,_that.partIncome,_that.partMaritalStatus,_that.partEducation,_that.partOccupation,_that.partMothertongue,_that.partManglik,_that.partFrmAge,_that.partToAge,_that.partHeight,_that.partHeightTo,_that.profileText,_that.subTitle,_that.age,_that.heightStr,_that.matchPercent,_that.completedProfile,_that.mobileVerifyStatus,_that.cpassStatus,_that.profileBy,_that.horoscope,_that.birthplace,_that.birthtime,_that.videoCallSetting,_that.voiceCallSetting,_that.pincode,_that.residenceTypeOther,_that.photoVisibility,_that.contactVisibility,_that.brotherDetailsArr,_that.sisterDetailsArr,_that.paternalFamily,_that.maternalFamily,_that.downloadBiodata,_that.viewProfileAllowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileData implements ProfileData {
  const _ProfileData({this.id, @JsonKey(name: 'user_type') this.userType, @JsonKey(name: 'matri_id') this.matriId, this.email, this.mobile, @JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'last_name') this.lastName, this.fullname, this.birthdate, this.gender, @JsonKey(name: 'country_id') this.countryId, @JsonKey(name: 'state_id') this.stateId, this.city, this.address, @JsonKey(name: 'marital_status') this.maritalStatus, @JsonKey(name: 'total_children') this.totalChildren, @JsonKey(name: 'status_children') this.statusChildren, this.religion, this.caste, this.subcaste, this.manglik, this.star, this.gothra, this.moonsign, @JsonKey(name: 'mother_tongue') this.motherTongue, this.height, this.weight, this.diet, this.smoke, this.drink, @JsonKey(name: 'body_type') this.bodyType, @JsonKey(name: 'skin_tone') this.skinTone, @JsonKey(name: 'education_level') this.educationLevel, @JsonKey(name: 'education_details') this.educationDetails, @JsonKey(name: 'employee_in') this.employeeIn, @JsonKey(name: 'employee_in_details') this.employeeInDetails, @JsonKey(name: 'occupation') this.occupation, @JsonKey(name: 'occupation_details') this.occupationDetails, @JsonKey(name: 'designation_level') this.designationLevel, this.income, @JsonKey(name: 'family_type') this.familyType, @JsonKey(name: 'family_status') this.familyStatus, @JsonKey(name: 'no_of_brother') this.noOfBrother, @JsonKey(name: 'no_of_sister') this.noOfSister, @JsonKey(name: 'no_of_married_brother') this.noOfMarriedBrother, @JsonKey(name: 'no_of_married_sister') this.noOfMarriedSister, @JsonKey(name: 'photo1') this.photo1, @JsonKey(name: 'photo1_status') this.photo1Status, @JsonKey(name: 'photo2') this.photo2, @JsonKey(name: 'photo2_status') this.photo2Status, @JsonKey(name: 'photo3') this.photo3, @JsonKey(name: 'photo3_status') this.photo3Status, @JsonKey(name: 'photo4') this.photo4, @JsonKey(name: 'photo4_status') this.photo4Status, @JsonKey(name: 'plan_name') this.planName, @JsonKey(name: 'plan_status') this.planStatus, @JsonKey(name: 'country_name') this.countryName, @JsonKey(name: 'state_name') this.stateName, @JsonKey(name: 'city_name') this.cityName, @JsonKey(name: 'religion_name') this.religionName, @JsonKey(name: 'caste_name') this.casteName, @JsonKey(name: 'occupation_name') this.occupationName, @JsonKey(name: 'education_name') this.educationName, @JsonKey(name: 'interest_state') this.interestState, @JsonKey(name: 'interest_status') this.interestStatus, @JsonKey(name: 'interest_id') this.interestId, @JsonKey(name: 'total_reminder_count') this.totalReminderCount, @JsonKey(name: 'pending_reminder_count') this.pendingReminderCount, @JsonKey(name: 'can_send_reminder') this.canSendReminder, @JsonKey(name: 'is_shortlisted') this.isShortlisted, @JsonKey(name: 'is_block') this.isBlock, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'myprofilTab')  List<TabData>? myProfileTab, @JsonKey(name: 'partnerPreferenceTab')  List<TabData>? partnerPreferenceTab, @JsonKey(name: 'id_proof_front') this.idProofFront, @JsonKey(name: 'id_proof_back') this.idProofBack, @JsonKey(name: 'id_proof_status') this.idProofStatus, @JsonKey(name: 'id_proof_type') this.idProofType, @JsonKey(name: 'horoscope_file') this.horoscopeFile, @JsonKey(name: 'horoscope_status') this.horoscopeStatus, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'is_photo_protected') this.isPhotoProtected, @JsonKey(name: 'is_photo_request_sent') this.isPhotoRequestSent, @JsonKey(name: 'father_name') this.fatherName, @JsonKey(name: 'father_occupation') this.fatherOccupation, @JsonKey(name: 'father_mobile_number') this.fatherMobileNumber, @JsonKey(name: 'father_present') this.fatherPresent, @JsonKey(name: 'mother_name') this.motherName, @JsonKey(name: 'mother_occupation') this.motherOccupation, @JsonKey(name: 'mother_mobile_number') this.motherMobileNumber, @JsonKey(name: 'mother_present') this.motherPresent, @JsonKey(name: 'family_details') this.familyDetails, @JsonKey(name: 'residence_type') this.residenceType, @JsonKey(name: 'alternate_number') this.alternateNumber, @JsonKey(name: 'nri_country') this.nriCountry, @JsonKey(name: 'part_religion') this.partReligion, @JsonKey(name: 'part_caste') this.partCaste, @JsonKey(name: 'part_country') this.partCountry, @JsonKey(name: 'part_state') this.partState, @JsonKey(name: 'part_income') this.partIncome, @JsonKey(name: 'part_marital_status') this.partMaritalStatus, @JsonKey(name: 'part_education') this.partEducation, @JsonKey(name: 'part_occupation') this.partOccupation, @JsonKey(name: 'part_mothertongue') this.partMothertongue, @JsonKey(name: 'part_manglik') this.partManglik, @JsonKey(name: 'part_frm_age') this.partFrmAge, @JsonKey(name: 'part_to_age') this.partToAge, @JsonKey(name: 'part_height') this.partHeight, @JsonKey(name: 'part_height_to') this.partHeightTo, @JsonKey(name: 'profile_text') this.profileText, @JsonKey(name: 'sub_title') this.subTitle, this.age, @JsonKey(name: 'height_str') this.heightStr, @JsonKey(name: 'matchPercent') this.matchPercent, @JsonKey(name: 'completed_profile') this.completedProfile, @JsonKey(name: 'mobile_verify_status') this.mobileVerifyStatus, @JsonKey(name: 'cpass_status') this.cpassStatus, @JsonKey(name: 'profileby') this.profileBy, this.horoscope, this.birthplace, this.birthtime, @JsonKey(name: 'video_call_setting') this.videoCallSetting, @JsonKey(name: 'voice_call_setting') this.voiceCallSetting, this.pincode, @JsonKey(name: 'residence_type_other') this.residenceTypeOther, @JsonKey(name: 'photo_visibility') this.photoVisibility, @JsonKey(name: 'contact_visibility') this.contactVisibility, @JsonKey(name: 'brother_details_arr')  List<dynamic>? brotherDetailsArr, @JsonKey(name: 'sister_details_arr')  List<dynamic>? sisterDetailsArr, @JsonKey(name: 'paternal_family')  List<dynamic>? paternalFamily, @JsonKey(name: 'maternal_family')  List<dynamic>? maternalFamily, @JsonKey(name: 'download_biodata') this.downloadBiodata, @JsonKey(name: 'view_profile_allowed') this.viewProfileAllowed}): _myProfileTab = myProfileTab,_partnerPreferenceTab = partnerPreferenceTab,_brotherDetailsArr = brotherDetailsArr,_sisterDetailsArr = sisterDetailsArr,_paternalFamily = paternalFamily,_maternalFamily = maternalFamily;
  factory _ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'user_type') final  dynamic userType;
@override@JsonKey(name: 'matri_id') final  dynamic matriId;
@override final  dynamic email;
@override final  dynamic mobile;
@override@JsonKey(name: 'first_name') final  dynamic firstName;
@override@JsonKey(name: 'last_name') final  dynamic lastName;
@override final  dynamic fullname;
@override final  dynamic birthdate;
@override final  dynamic gender;
@override@JsonKey(name: 'country_id') final  dynamic countryId;
@override@JsonKey(name: 'state_id') final  dynamic stateId;
@override final  dynamic city;
@override final  dynamic address;
@override@JsonKey(name: 'marital_status') final  dynamic maritalStatus;
@override@JsonKey(name: 'total_children') final  dynamic totalChildren;
@override@JsonKey(name: 'status_children') final  dynamic statusChildren;
@override final  dynamic religion;
@override final  dynamic caste;
@override final  dynamic subcaste;
@override final  dynamic manglik;
@override final  dynamic star;
@override final  dynamic gothra;
@override final  dynamic moonsign;
@override@JsonKey(name: 'mother_tongue') final  dynamic motherTongue;
@override final  dynamic height;
@override final  dynamic weight;
@override final  dynamic diet;
@override final  dynamic smoke;
@override final  dynamic drink;
@override@JsonKey(name: 'body_type') final  dynamic bodyType;
@override@JsonKey(name: 'skin_tone') final  dynamic skinTone;
@override@JsonKey(name: 'education_level') final  dynamic educationLevel;
@override@JsonKey(name: 'education_details') final  dynamic educationDetails;
@override@JsonKey(name: 'employee_in') final  dynamic employeeIn;
@override@JsonKey(name: 'employee_in_details') final  dynamic employeeInDetails;
@override@JsonKey(name: 'occupation') final  dynamic occupation;
@override@JsonKey(name: 'occupation_details') final  dynamic occupationDetails;
@override@JsonKey(name: 'designation_level') final  dynamic designationLevel;
@override final  dynamic income;
@override@JsonKey(name: 'family_type') final  dynamic familyType;
@override@JsonKey(name: 'family_status') final  dynamic familyStatus;
@override@JsonKey(name: 'no_of_brother') final  dynamic noOfBrother;
@override@JsonKey(name: 'no_of_sister') final  dynamic noOfSister;
@override@JsonKey(name: 'no_of_married_brother') final  dynamic noOfMarriedBrother;
@override@JsonKey(name: 'no_of_married_sister') final  dynamic noOfMarriedSister;
@override@JsonKey(name: 'photo1') final  dynamic photo1;
@override@JsonKey(name: 'photo1_status') final  dynamic photo1Status;
@override@JsonKey(name: 'photo2') final  dynamic photo2;
@override@JsonKey(name: 'photo2_status') final  dynamic photo2Status;
@override@JsonKey(name: 'photo3') final  dynamic photo3;
@override@JsonKey(name: 'photo3_status') final  dynamic photo3Status;
@override@JsonKey(name: 'photo4') final  dynamic photo4;
@override@JsonKey(name: 'photo4_status') final  dynamic photo4Status;
@override@JsonKey(name: 'plan_name') final  dynamic planName;
@override@JsonKey(name: 'plan_status') final  dynamic planStatus;
@override@JsonKey(name: 'country_name') final  dynamic countryName;
@override@JsonKey(name: 'state_name') final  dynamic stateName;
@override@JsonKey(name: 'city_name') final  dynamic cityName;
@override@JsonKey(name: 'religion_name') final  dynamic religionName;
@override@JsonKey(name: 'caste_name') final  dynamic casteName;
@override@JsonKey(name: 'occupation_name') final  dynamic occupationName;
@override@JsonKey(name: 'education_name') final  dynamic educationName;
@override@JsonKey(name: 'interest_state') final  String? interestState;
@override@JsonKey(name: 'interest_status') final  String? interestStatus;
@override@JsonKey(name: 'interest_id') final  dynamic interestId;
@override@JsonKey(name: 'total_reminder_count') final  int? totalReminderCount;
@override@JsonKey(name: 'pending_reminder_count') final  int? pendingReminderCount;
@override@JsonKey(name: 'can_send_reminder') final  bool? canSendReminder;
@override@JsonKey(name: 'is_shortlisted') final  dynamic isShortlisted;
@override@JsonKey(name: 'is_block') final  dynamic isBlock;
@override@JsonKey(name: 'profile_title') final  dynamic profileTitle;
 final  List<TabData>? _myProfileTab;
@override@JsonKey(name: 'myprofilTab') List<TabData>? get myProfileTab {
  final value = _myProfileTab;
  if (value == null) return null;
  if (_myProfileTab is EqualUnmodifiableListView) return _myProfileTab;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TabData>? _partnerPreferenceTab;
@override@JsonKey(name: 'partnerPreferenceTab') List<TabData>? get partnerPreferenceTab {
  final value = _partnerPreferenceTab;
  if (value == null) return null;
  if (_partnerPreferenceTab is EqualUnmodifiableListView) return _partnerPreferenceTab;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'id_proof_front') final  dynamic idProofFront;
@override@JsonKey(name: 'id_proof_back') final  dynamic idProofBack;
@override@JsonKey(name: 'id_proof_status') final  dynamic idProofStatus;
@override@JsonKey(name: 'id_proof_type') final  dynamic idProofType;
@override@JsonKey(name: 'horoscope_file') final  dynamic horoscopeFile;
@override@JsonKey(name: 'horoscope_status') final  dynamic horoscopeStatus;
@override@JsonKey(name: 'profile_image') final  dynamic profileImage;
@override@JsonKey(name: 'is_photo_protected') final  dynamic isPhotoProtected;
@override@JsonKey(name: 'is_photo_request_sent') final  dynamic isPhotoRequestSent;
@override@JsonKey(name: 'father_name') final  dynamic fatherName;
@override@JsonKey(name: 'father_occupation') final  dynamic fatherOccupation;
@override@JsonKey(name: 'father_mobile_number') final  dynamic fatherMobileNumber;
@override@JsonKey(name: 'father_present') final  dynamic fatherPresent;
@override@JsonKey(name: 'mother_name') final  dynamic motherName;
@override@JsonKey(name: 'mother_occupation') final  dynamic motherOccupation;
@override@JsonKey(name: 'mother_mobile_number') final  dynamic motherMobileNumber;
@override@JsonKey(name: 'mother_present') final  dynamic motherPresent;
@override@JsonKey(name: 'family_details') final  dynamic familyDetails;
@override@JsonKey(name: 'residence_type') final  dynamic residenceType;
@override@JsonKey(name: 'alternate_number') final  dynamic alternateNumber;
@override@JsonKey(name: 'nri_country') final  dynamic nriCountry;
@override@JsonKey(name: 'part_religion') final  dynamic partReligion;
@override@JsonKey(name: 'part_caste') final  dynamic partCaste;
@override@JsonKey(name: 'part_country') final  dynamic partCountry;
@override@JsonKey(name: 'part_state') final  dynamic partState;
@override@JsonKey(name: 'part_income') final  dynamic partIncome;
@override@JsonKey(name: 'part_marital_status') final  dynamic partMaritalStatus;
@override@JsonKey(name: 'part_education') final  dynamic partEducation;
@override@JsonKey(name: 'part_occupation') final  dynamic partOccupation;
@override@JsonKey(name: 'part_mothertongue') final  dynamic partMothertongue;
@override@JsonKey(name: 'part_manglik') final  dynamic partManglik;
@override@JsonKey(name: 'part_frm_age') final  dynamic partFrmAge;
@override@JsonKey(name: 'part_to_age') final  dynamic partToAge;
@override@JsonKey(name: 'part_height') final  dynamic partHeight;
@override@JsonKey(name: 'part_height_to') final  dynamic partHeightTo;
@override@JsonKey(name: 'profile_text') final  dynamic profileText;
@override@JsonKey(name: 'sub_title') final  dynamic subTitle;
@override final  dynamic age;
@override@JsonKey(name: 'height_str') final  dynamic heightStr;
@override@JsonKey(name: 'matchPercent') final  dynamic matchPercent;
@override@JsonKey(name: 'completed_profile') final  dynamic completedProfile;
@override@JsonKey(name: 'mobile_verify_status') final  dynamic mobileVerifyStatus;
@override@JsonKey(name: 'cpass_status') final  dynamic cpassStatus;
@override@JsonKey(name: 'profileby') final  dynamic profileBy;
@override final  dynamic horoscope;
@override final  dynamic birthplace;
@override final  dynamic birthtime;
@override@JsonKey(name: 'video_call_setting') final  dynamic videoCallSetting;
@override@JsonKey(name: 'voice_call_setting') final  dynamic voiceCallSetting;
@override final  dynamic pincode;
@override@JsonKey(name: 'residence_type_other') final  dynamic residenceTypeOther;
@override@JsonKey(name: 'photo_visibility') final  dynamic photoVisibility;
@override@JsonKey(name: 'contact_visibility') final  dynamic contactVisibility;
 final  List<dynamic>? _brotherDetailsArr;
@override@JsonKey(name: 'brother_details_arr') List<dynamic>? get brotherDetailsArr {
  final value = _brotherDetailsArr;
  if (value == null) return null;
  if (_brotherDetailsArr is EqualUnmodifiableListView) return _brotherDetailsArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _sisterDetailsArr;
@override@JsonKey(name: 'sister_details_arr') List<dynamic>? get sisterDetailsArr {
  final value = _sisterDetailsArr;
  if (value == null) return null;
  if (_sisterDetailsArr is EqualUnmodifiableListView) return _sisterDetailsArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _paternalFamily;
@override@JsonKey(name: 'paternal_family') List<dynamic>? get paternalFamily {
  final value = _paternalFamily;
  if (value == null) return null;
  if (_paternalFamily is EqualUnmodifiableListView) return _paternalFamily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _maternalFamily;
@override@JsonKey(name: 'maternal_family') List<dynamic>? get maternalFamily {
  final value = _maternalFamily;
  if (value == null) return null;
  if (_maternalFamily is EqualUnmodifiableListView) return _maternalFamily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'download_biodata') final  dynamic downloadBiodata;
@override@JsonKey(name: 'view_profile_allowed') final  dynamic viewProfileAllowed;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDataCopyWith<_ProfileData> get copyWith => __$ProfileDataCopyWithImpl<_ProfileData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileData&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.userType, userType)&&const DeepCollectionEquality().equals(other.matriId, matriId)&&const DeepCollectionEquality().equals(other.email, email)&&const DeepCollectionEquality().equals(other.mobile, mobile)&&const DeepCollectionEquality().equals(other.firstName, firstName)&&const DeepCollectionEquality().equals(other.lastName, lastName)&&const DeepCollectionEquality().equals(other.fullname, fullname)&&const DeepCollectionEquality().equals(other.birthdate, birthdate)&&const DeepCollectionEquality().equals(other.gender, gender)&&const DeepCollectionEquality().equals(other.countryId, countryId)&&const DeepCollectionEquality().equals(other.stateId, stateId)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.maritalStatus, maritalStatus)&&const DeepCollectionEquality().equals(other.totalChildren, totalChildren)&&const DeepCollectionEquality().equals(other.statusChildren, statusChildren)&&const DeepCollectionEquality().equals(other.religion, religion)&&const DeepCollectionEquality().equals(other.caste, caste)&&const DeepCollectionEquality().equals(other.subcaste, subcaste)&&const DeepCollectionEquality().equals(other.manglik, manglik)&&const DeepCollectionEquality().equals(other.star, star)&&const DeepCollectionEquality().equals(other.gothra, gothra)&&const DeepCollectionEquality().equals(other.moonsign, moonsign)&&const DeepCollectionEquality().equals(other.motherTongue, motherTongue)&&const DeepCollectionEquality().equals(other.height, height)&&const DeepCollectionEquality().equals(other.weight, weight)&&const DeepCollectionEquality().equals(other.diet, diet)&&const DeepCollectionEquality().equals(other.smoke, smoke)&&const DeepCollectionEquality().equals(other.drink, drink)&&const DeepCollectionEquality().equals(other.bodyType, bodyType)&&const DeepCollectionEquality().equals(other.skinTone, skinTone)&&const DeepCollectionEquality().equals(other.educationLevel, educationLevel)&&const DeepCollectionEquality().equals(other.educationDetails, educationDetails)&&const DeepCollectionEquality().equals(other.employeeIn, employeeIn)&&const DeepCollectionEquality().equals(other.employeeInDetails, employeeInDetails)&&const DeepCollectionEquality().equals(other.occupation, occupation)&&const DeepCollectionEquality().equals(other.occupationDetails, occupationDetails)&&const DeepCollectionEquality().equals(other.designationLevel, designationLevel)&&const DeepCollectionEquality().equals(other.income, income)&&const DeepCollectionEquality().equals(other.familyType, familyType)&&const DeepCollectionEquality().equals(other.familyStatus, familyStatus)&&const DeepCollectionEquality().equals(other.noOfBrother, noOfBrother)&&const DeepCollectionEquality().equals(other.noOfSister, noOfSister)&&const DeepCollectionEquality().equals(other.noOfMarriedBrother, noOfMarriedBrother)&&const DeepCollectionEquality().equals(other.noOfMarriedSister, noOfMarriedSister)&&const DeepCollectionEquality().equals(other.photo1, photo1)&&const DeepCollectionEquality().equals(other.photo1Status, photo1Status)&&const DeepCollectionEquality().equals(other.photo2, photo2)&&const DeepCollectionEquality().equals(other.photo2Status, photo2Status)&&const DeepCollectionEquality().equals(other.photo3, photo3)&&const DeepCollectionEquality().equals(other.photo3Status, photo3Status)&&const DeepCollectionEquality().equals(other.photo4, photo4)&&const DeepCollectionEquality().equals(other.photo4Status, photo4Status)&&const DeepCollectionEquality().equals(other.planName, planName)&&const DeepCollectionEquality().equals(other.planStatus, planStatus)&&const DeepCollectionEquality().equals(other.countryName, countryName)&&const DeepCollectionEquality().equals(other.stateName, stateName)&&const DeepCollectionEquality().equals(other.cityName, cityName)&&const DeepCollectionEquality().equals(other.religionName, religionName)&&const DeepCollectionEquality().equals(other.casteName, casteName)&&const DeepCollectionEquality().equals(other.occupationName, occupationName)&&const DeepCollectionEquality().equals(other.educationName, educationName)&&(identical(other.interestState, interestState) || other.interestState == interestState)&&(identical(other.interestStatus, interestStatus) || other.interestStatus == interestStatus)&&const DeepCollectionEquality().equals(other.interestId, interestId)&&(identical(other.totalReminderCount, totalReminderCount) || other.totalReminderCount == totalReminderCount)&&(identical(other.pendingReminderCount, pendingReminderCount) || other.pendingReminderCount == pendingReminderCount)&&(identical(other.canSendReminder, canSendReminder) || other.canSendReminder == canSendReminder)&&const DeepCollectionEquality().equals(other.isShortlisted, isShortlisted)&&const DeepCollectionEquality().equals(other.isBlock, isBlock)&&const DeepCollectionEquality().equals(other.profileTitle, profileTitle)&&const DeepCollectionEquality().equals(other.myProfileTab, _myProfileTab)&&const DeepCollectionEquality().equals(other.partnerPreferenceTab, _partnerPreferenceTab)&&const DeepCollectionEquality().equals(other.idProofFront, idProofFront)&&const DeepCollectionEquality().equals(other.idProofBack, idProofBack)&&const DeepCollectionEquality().equals(other.idProofStatus, idProofStatus)&&const DeepCollectionEquality().equals(other.idProofType, idProofType)&&const DeepCollectionEquality().equals(other.horoscopeFile, horoscopeFile)&&const DeepCollectionEquality().equals(other.horoscopeStatus, horoscopeStatus)&&const DeepCollectionEquality().equals(other.profileImage, profileImage)&&const DeepCollectionEquality().equals(other.isPhotoProtected, isPhotoProtected)&&const DeepCollectionEquality().equals(other.isPhotoRequestSent, isPhotoRequestSent)&&const DeepCollectionEquality().equals(other.fatherName, fatherName)&&const DeepCollectionEquality().equals(other.fatherOccupation, fatherOccupation)&&const DeepCollectionEquality().equals(other.fatherMobileNumber, fatherMobileNumber)&&const DeepCollectionEquality().equals(other.fatherPresent, fatherPresent)&&const DeepCollectionEquality().equals(other.motherName, motherName)&&const DeepCollectionEquality().equals(other.motherOccupation, motherOccupation)&&const DeepCollectionEquality().equals(other.motherMobileNumber, motherMobileNumber)&&const DeepCollectionEquality().equals(other.motherPresent, motherPresent)&&const DeepCollectionEquality().equals(other.familyDetails, familyDetails)&&const DeepCollectionEquality().equals(other.residenceType, residenceType)&&const DeepCollectionEquality().equals(other.alternateNumber, alternateNumber)&&const DeepCollectionEquality().equals(other.nriCountry, nriCountry)&&const DeepCollectionEquality().equals(other.partReligion, partReligion)&&const DeepCollectionEquality().equals(other.partCaste, partCaste)&&const DeepCollectionEquality().equals(other.partCountry, partCountry)&&const DeepCollectionEquality().equals(other.partState, partState)&&const DeepCollectionEquality().equals(other.partIncome, partIncome)&&const DeepCollectionEquality().equals(other.partMaritalStatus, partMaritalStatus)&&const DeepCollectionEquality().equals(other.partEducation, partEducation)&&const DeepCollectionEquality().equals(other.partOccupation, partOccupation)&&const DeepCollectionEquality().equals(other.partMothertongue, partMothertongue)&&const DeepCollectionEquality().equals(other.partManglik, partManglik)&&const DeepCollectionEquality().equals(other.partFrmAge, partFrmAge)&&const DeepCollectionEquality().equals(other.partToAge, partToAge)&&const DeepCollectionEquality().equals(other.partHeight, partHeight)&&const DeepCollectionEquality().equals(other.partHeightTo, partHeightTo)&&const DeepCollectionEquality().equals(other.profileText, profileText)&&const DeepCollectionEquality().equals(other.subTitle, subTitle)&&const DeepCollectionEquality().equals(other.age, age)&&const DeepCollectionEquality().equals(other.heightStr, heightStr)&&const DeepCollectionEquality().equals(other.matchPercent, matchPercent)&&const DeepCollectionEquality().equals(other.completedProfile, completedProfile)&&const DeepCollectionEquality().equals(other.mobileVerifyStatus, mobileVerifyStatus)&&const DeepCollectionEquality().equals(other.cpassStatus, cpassStatus)&&const DeepCollectionEquality().equals(other.profileBy, profileBy)&&const DeepCollectionEquality().equals(other.horoscope, horoscope)&&const DeepCollectionEquality().equals(other.birthplace, birthplace)&&const DeepCollectionEquality().equals(other.birthtime, birthtime)&&const DeepCollectionEquality().equals(other.videoCallSetting, videoCallSetting)&&const DeepCollectionEquality().equals(other.voiceCallSetting, voiceCallSetting)&&const DeepCollectionEquality().equals(other.pincode, pincode)&&const DeepCollectionEquality().equals(other.residenceTypeOther, residenceTypeOther)&&const DeepCollectionEquality().equals(other.photoVisibility, photoVisibility)&&const DeepCollectionEquality().equals(other.contactVisibility, contactVisibility)&&const DeepCollectionEquality().equals(other.brotherDetailsArr, _brotherDetailsArr)&&const DeepCollectionEquality().equals(other.sisterDetailsArr, _sisterDetailsArr)&&const DeepCollectionEquality().equals(other.paternalFamily, _paternalFamily)&&const DeepCollectionEquality().equals(other.maternalFamily, _maternalFamily)&&const DeepCollectionEquality().equals(other.downloadBiodata, downloadBiodata)&&const DeepCollectionEquality().equals(other.viewProfileAllowed, viewProfileAllowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(userType),const DeepCollectionEquality().hash(matriId),const DeepCollectionEquality().hash(email),const DeepCollectionEquality().hash(mobile),const DeepCollectionEquality().hash(firstName),const DeepCollectionEquality().hash(lastName),const DeepCollectionEquality().hash(fullname),const DeepCollectionEquality().hash(birthdate),const DeepCollectionEquality().hash(gender),const DeepCollectionEquality().hash(countryId),const DeepCollectionEquality().hash(stateId),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(maritalStatus),const DeepCollectionEquality().hash(totalChildren),const DeepCollectionEquality().hash(statusChildren),const DeepCollectionEquality().hash(religion),const DeepCollectionEquality().hash(caste),const DeepCollectionEquality().hash(subcaste),const DeepCollectionEquality().hash(manglik),const DeepCollectionEquality().hash(star),const DeepCollectionEquality().hash(gothra),const DeepCollectionEquality().hash(moonsign),const DeepCollectionEquality().hash(motherTongue),const DeepCollectionEquality().hash(height),const DeepCollectionEquality().hash(weight),const DeepCollectionEquality().hash(diet),const DeepCollectionEquality().hash(smoke),const DeepCollectionEquality().hash(drink),const DeepCollectionEquality().hash(bodyType),const DeepCollectionEquality().hash(skinTone),const DeepCollectionEquality().hash(educationLevel),const DeepCollectionEquality().hash(educationDetails),const DeepCollectionEquality().hash(employeeIn),const DeepCollectionEquality().hash(employeeInDetails),const DeepCollectionEquality().hash(occupation),const DeepCollectionEquality().hash(occupationDetails),const DeepCollectionEquality().hash(designationLevel),const DeepCollectionEquality().hash(income),const DeepCollectionEquality().hash(familyType),const DeepCollectionEquality().hash(familyStatus),const DeepCollectionEquality().hash(noOfBrother),const DeepCollectionEquality().hash(noOfSister),const DeepCollectionEquality().hash(noOfMarriedBrother),const DeepCollectionEquality().hash(noOfMarriedSister),const DeepCollectionEquality().hash(photo1),const DeepCollectionEquality().hash(photo1Status),const DeepCollectionEquality().hash(photo2),const DeepCollectionEquality().hash(photo2Status),const DeepCollectionEquality().hash(photo3),const DeepCollectionEquality().hash(photo3Status),const DeepCollectionEquality().hash(photo4),const DeepCollectionEquality().hash(photo4Status),const DeepCollectionEquality().hash(planName),const DeepCollectionEquality().hash(planStatus),const DeepCollectionEquality().hash(countryName),const DeepCollectionEquality().hash(stateName),const DeepCollectionEquality().hash(cityName),const DeepCollectionEquality().hash(religionName),const DeepCollectionEquality().hash(casteName),const DeepCollectionEquality().hash(occupationName),const DeepCollectionEquality().hash(educationName),interestState,interestStatus,const DeepCollectionEquality().hash(interestId),totalReminderCount,pendingReminderCount,canSendReminder,const DeepCollectionEquality().hash(isShortlisted),const DeepCollectionEquality().hash(isBlock),const DeepCollectionEquality().hash(profileTitle),const DeepCollectionEquality().hash(_myProfileTab),const DeepCollectionEquality().hash(_partnerPreferenceTab),const DeepCollectionEquality().hash(idProofFront),const DeepCollectionEquality().hash(idProofBack),const DeepCollectionEquality().hash(idProofStatus),const DeepCollectionEquality().hash(idProofType),const DeepCollectionEquality().hash(horoscopeFile),const DeepCollectionEquality().hash(horoscopeStatus),const DeepCollectionEquality().hash(profileImage),const DeepCollectionEquality().hash(isPhotoProtected),const DeepCollectionEquality().hash(isPhotoRequestSent),const DeepCollectionEquality().hash(fatherName),const DeepCollectionEquality().hash(fatherOccupation),const DeepCollectionEquality().hash(fatherMobileNumber),const DeepCollectionEquality().hash(fatherPresent),const DeepCollectionEquality().hash(motherName),const DeepCollectionEquality().hash(motherOccupation),const DeepCollectionEquality().hash(motherMobileNumber),const DeepCollectionEquality().hash(motherPresent),const DeepCollectionEquality().hash(familyDetails),const DeepCollectionEquality().hash(residenceType),const DeepCollectionEquality().hash(alternateNumber),const DeepCollectionEquality().hash(nriCountry),const DeepCollectionEquality().hash(partReligion),const DeepCollectionEquality().hash(partCaste),const DeepCollectionEquality().hash(partCountry),const DeepCollectionEquality().hash(partState),const DeepCollectionEquality().hash(partIncome),const DeepCollectionEquality().hash(partMaritalStatus),const DeepCollectionEquality().hash(partEducation),const DeepCollectionEquality().hash(partOccupation),const DeepCollectionEquality().hash(partMothertongue),const DeepCollectionEquality().hash(partManglik),const DeepCollectionEquality().hash(partFrmAge),const DeepCollectionEquality().hash(partToAge),const DeepCollectionEquality().hash(partHeight),const DeepCollectionEquality().hash(partHeightTo),const DeepCollectionEquality().hash(profileText),const DeepCollectionEquality().hash(subTitle),const DeepCollectionEquality().hash(age),const DeepCollectionEquality().hash(heightStr),const DeepCollectionEquality().hash(matchPercent),const DeepCollectionEquality().hash(completedProfile),const DeepCollectionEquality().hash(mobileVerifyStatus),const DeepCollectionEquality().hash(cpassStatus),const DeepCollectionEquality().hash(profileBy),const DeepCollectionEquality().hash(horoscope),const DeepCollectionEquality().hash(birthplace),const DeepCollectionEquality().hash(birthtime),const DeepCollectionEquality().hash(videoCallSetting),const DeepCollectionEquality().hash(voiceCallSetting),const DeepCollectionEquality().hash(pincode),const DeepCollectionEquality().hash(residenceTypeOther),const DeepCollectionEquality().hash(photoVisibility),const DeepCollectionEquality().hash(contactVisibility),const DeepCollectionEquality().hash(_brotherDetailsArr),const DeepCollectionEquality().hash(_sisterDetailsArr),const DeepCollectionEquality().hash(_paternalFamily),const DeepCollectionEquality().hash(_maternalFamily),const DeepCollectionEquality().hash(downloadBiodata),const DeepCollectionEquality().hash(viewProfileAllowed)]);
}

@override
String toString() {
    return 'ProfileData(id: $id, userType: $userType, matriId: $matriId, email: $email, mobile: $mobile, firstName: $firstName, lastName: $lastName, fullname: $fullname, birthdate: $birthdate, gender: $gender, countryId: $countryId, stateId: $stateId, city: $city, address: $address, maritalStatus: $maritalStatus, totalChildren: $totalChildren, statusChildren: $statusChildren, religion: $religion, caste: $caste, subcaste: $subcaste, manglik: $manglik, star: $star, gothra: $gothra, moonsign: $moonsign, motherTongue: $motherTongue, height: $height, weight: $weight, diet: $diet, smoke: $smoke, drink: $drink, bodyType: $bodyType, skinTone: $skinTone, educationLevel: $educationLevel, educationDetails: $educationDetails, employeeIn: $employeeIn, employeeInDetails: $employeeInDetails, occupation: $occupation, occupationDetails: $occupationDetails, designationLevel: $designationLevel, income: $income, familyType: $familyType, familyStatus: $familyStatus, noOfBrother: $noOfBrother, noOfSister: $noOfSister, noOfMarriedBrother: $noOfMarriedBrother, noOfMarriedSister: $noOfMarriedSister, photo1: $photo1, photo1Status: $photo1Status, photo2: $photo2, photo2Status: $photo2Status, photo3: $photo3, photo3Status: $photo3Status, photo4: $photo4, photo4Status: $photo4Status, planName: $planName, planStatus: $planStatus, countryName: $countryName, stateName: $stateName, cityName: $cityName, religionName: $religionName, casteName: $casteName, occupationName: $occupationName, educationName: $educationName, interestState: $interestState, interestStatus: $interestStatus, interestId: $interestId, totalReminderCount: $totalReminderCount, pendingReminderCount: $pendingReminderCount, canSendReminder: $canSendReminder, isShortlisted: $isShortlisted, isBlock: $isBlock, profileTitle: $profileTitle, myProfileTab: $myProfileTab, partnerPreferenceTab: $partnerPreferenceTab, idProofFront: $idProofFront, idProofBack: $idProofBack, idProofStatus: $idProofStatus, idProofType: $idProofType, horoscopeFile: $horoscopeFile, horoscopeStatus: $horoscopeStatus, profileImage: $profileImage, isPhotoProtected: $isPhotoProtected, isPhotoRequestSent: $isPhotoRequestSent, fatherName: $fatherName, fatherOccupation: $fatherOccupation, fatherMobileNumber: $fatherMobileNumber, fatherPresent: $fatherPresent, motherName: $motherName, motherOccupation: $motherOccupation, motherMobileNumber: $motherMobileNumber, motherPresent: $motherPresent, familyDetails: $familyDetails, residenceType: $residenceType, alternateNumber: $alternateNumber, nriCountry: $nriCountry, partReligion: $partReligion, partCaste: $partCaste, partCountry: $partCountry, partState: $partState, partIncome: $partIncome, partMaritalStatus: $partMaritalStatus, partEducation: $partEducation, partOccupation: $partOccupation, partMothertongue: $partMothertongue, partManglik: $partManglik, partFrmAge: $partFrmAge, partToAge: $partToAge, partHeight: $partHeight, partHeightTo: $partHeightTo, profileText: $profileText, subTitle: $subTitle, age: $age, heightStr: $heightStr, matchPercent: $matchPercent, completedProfile: $completedProfile, mobileVerifyStatus: $mobileVerifyStatus, cpassStatus: $cpassStatus, profileBy: $profileBy, horoscope: $horoscope, birthplace: $birthplace, birthtime: $birthtime, videoCallSetting: $videoCallSetting, voiceCallSetting: $voiceCallSetting, pincode: $pincode, residenceTypeOther: $residenceTypeOther, photoVisibility: $photoVisibility, contactVisibility: $contactVisibility, brotherDetailsArr: $brotherDetailsArr, sisterDetailsArr: $sisterDetailsArr, paternalFamily: $paternalFamily, maternalFamily: $maternalFamily, downloadBiodata: $downloadBiodata, viewProfileAllowed: $viewProfileAllowed)';
}


}

/// @nodoc
abstract mixin class _$ProfileDataCopyWith<$Res> implements $ProfileDataCopyWith<$Res> {
  factory _$ProfileDataCopyWith(_ProfileData value, $Res Function(_ProfileData) _then) = __$ProfileDataCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'user_type') dynamic userType,@JsonKey(name: 'matri_id') dynamic matriId, dynamic email, dynamic mobile,@JsonKey(name: 'first_name') dynamic firstName,@JsonKey(name: 'last_name') dynamic lastName, dynamic fullname, dynamic birthdate, dynamic gender,@JsonKey(name: 'country_id') dynamic countryId,@JsonKey(name: 'state_id') dynamic stateId, dynamic city, dynamic address,@JsonKey(name: 'marital_status') dynamic maritalStatus,@JsonKey(name: 'total_children') dynamic totalChildren,@JsonKey(name: 'status_children') dynamic statusChildren, dynamic religion, dynamic caste, dynamic subcaste, dynamic manglik, dynamic star, dynamic gothra, dynamic moonsign,@JsonKey(name: 'mother_tongue') dynamic motherTongue, dynamic height, dynamic weight, dynamic diet, dynamic smoke, dynamic drink,@JsonKey(name: 'body_type') dynamic bodyType,@JsonKey(name: 'skin_tone') dynamic skinTone,@JsonKey(name: 'education_level') dynamic educationLevel,@JsonKey(name: 'education_details') dynamic educationDetails,@JsonKey(name: 'employee_in') dynamic employeeIn,@JsonKey(name: 'employee_in_details') dynamic employeeInDetails,@JsonKey(name: 'occupation') dynamic occupation,@JsonKey(name: 'occupation_details') dynamic occupationDetails,@JsonKey(name: 'designation_level') dynamic designationLevel, dynamic income,@JsonKey(name: 'family_type') dynamic familyType,@JsonKey(name: 'family_status') dynamic familyStatus,@JsonKey(name: 'no_of_brother') dynamic noOfBrother,@JsonKey(name: 'no_of_sister') dynamic noOfSister,@JsonKey(name: 'no_of_married_brother') dynamic noOfMarriedBrother,@JsonKey(name: 'no_of_married_sister') dynamic noOfMarriedSister,@JsonKey(name: 'photo1') dynamic photo1,@JsonKey(name: 'photo1_status') dynamic photo1Status,@JsonKey(name: 'photo2') dynamic photo2,@JsonKey(name: 'photo2_status') dynamic photo2Status,@JsonKey(name: 'photo3') dynamic photo3,@JsonKey(name: 'photo3_status') dynamic photo3Status,@JsonKey(name: 'photo4') dynamic photo4,@JsonKey(name: 'photo4_status') dynamic photo4Status,@JsonKey(name: 'plan_name') dynamic planName,@JsonKey(name: 'plan_status') dynamic planStatus,@JsonKey(name: 'country_name') dynamic countryName,@JsonKey(name: 'state_name') dynamic stateName,@JsonKey(name: 'city_name') dynamic cityName,@JsonKey(name: 'religion_name') dynamic religionName,@JsonKey(name: 'caste_name') dynamic casteName,@JsonKey(name: 'occupation_name') dynamic occupationName,@JsonKey(name: 'education_name') dynamic educationName,@JsonKey(name: 'interest_state') String? interestState,@JsonKey(name: 'interest_status') String? interestStatus,@JsonKey(name: 'interest_id') dynamic interestId,@JsonKey(name: 'total_reminder_count') int? totalReminderCount,@JsonKey(name: 'pending_reminder_count') int? pendingReminderCount,@JsonKey(name: 'can_send_reminder') bool? canSendReminder,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_block') dynamic isBlock,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'myprofilTab') List<TabData>? myProfileTab,@JsonKey(name: 'partnerPreferenceTab') List<TabData>? partnerPreferenceTab,@JsonKey(name: 'id_proof_front') dynamic idProofFront,@JsonKey(name: 'id_proof_back') dynamic idProofBack,@JsonKey(name: 'id_proof_status') dynamic idProofStatus,@JsonKey(name: 'id_proof_type') dynamic idProofType,@JsonKey(name: 'horoscope_file') dynamic horoscopeFile,@JsonKey(name: 'horoscope_status') dynamic horoscopeStatus,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'is_photo_protected') dynamic isPhotoProtected,@JsonKey(name: 'is_photo_request_sent') dynamic isPhotoRequestSent,@JsonKey(name: 'father_name') dynamic fatherName,@JsonKey(name: 'father_occupation') dynamic fatherOccupation,@JsonKey(name: 'father_mobile_number') dynamic fatherMobileNumber,@JsonKey(name: 'father_present') dynamic fatherPresent,@JsonKey(name: 'mother_name') dynamic motherName,@JsonKey(name: 'mother_occupation') dynamic motherOccupation,@JsonKey(name: 'mother_mobile_number') dynamic motherMobileNumber,@JsonKey(name: 'mother_present') dynamic motherPresent,@JsonKey(name: 'family_details') dynamic familyDetails,@JsonKey(name: 'residence_type') dynamic residenceType,@JsonKey(name: 'alternate_number') dynamic alternateNumber,@JsonKey(name: 'nri_country') dynamic nriCountry,@JsonKey(name: 'part_religion') dynamic partReligion,@JsonKey(name: 'part_caste') dynamic partCaste,@JsonKey(name: 'part_country') dynamic partCountry,@JsonKey(name: 'part_state') dynamic partState,@JsonKey(name: 'part_income') dynamic partIncome,@JsonKey(name: 'part_marital_status') dynamic partMaritalStatus,@JsonKey(name: 'part_education') dynamic partEducation,@JsonKey(name: 'part_occupation') dynamic partOccupation,@JsonKey(name: 'part_mothertongue') dynamic partMothertongue,@JsonKey(name: 'part_manglik') dynamic partManglik,@JsonKey(name: 'part_frm_age') dynamic partFrmAge,@JsonKey(name: 'part_to_age') dynamic partToAge,@JsonKey(name: 'part_height') dynamic partHeight,@JsonKey(name: 'part_height_to') dynamic partHeightTo,@JsonKey(name: 'profile_text') dynamic profileText,@JsonKey(name: 'sub_title') dynamic subTitle, dynamic age,@JsonKey(name: 'height_str') dynamic heightStr,@JsonKey(name: 'matchPercent') dynamic matchPercent,@JsonKey(name: 'completed_profile') dynamic completedProfile,@JsonKey(name: 'mobile_verify_status') dynamic mobileVerifyStatus,@JsonKey(name: 'cpass_status') dynamic cpassStatus,@JsonKey(name: 'profileby') dynamic profileBy, dynamic horoscope, dynamic birthplace, dynamic birthtime,@JsonKey(name: 'video_call_setting') dynamic videoCallSetting,@JsonKey(name: 'voice_call_setting') dynamic voiceCallSetting, dynamic pincode,@JsonKey(name: 'residence_type_other') dynamic residenceTypeOther,@JsonKey(name: 'photo_visibility') dynamic photoVisibility,@JsonKey(name: 'contact_visibility') dynamic contactVisibility,@JsonKey(name: 'brother_details_arr') List<dynamic>? brotherDetailsArr,@JsonKey(name: 'sister_details_arr') List<dynamic>? sisterDetailsArr,@JsonKey(name: 'paternal_family') List<dynamic>? paternalFamily,@JsonKey(name: 'maternal_family') List<dynamic>? maternalFamily,@JsonKey(name: 'download_biodata') dynamic downloadBiodata,@JsonKey(name: 'view_profile_allowed') dynamic viewProfileAllowed
});




}
/// @nodoc
class __$ProfileDataCopyWithImpl<$Res>
    implements _$ProfileDataCopyWith<$Res> {
  __$ProfileDataCopyWithImpl(this._self, this._then);

  final _ProfileData _self;
  final $Res Function(_ProfileData) _then;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userType = freezed,Object? matriId = freezed,Object? email = freezed,Object? mobile = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? fullname = freezed,Object? birthdate = freezed,Object? gender = freezed,Object? countryId = freezed,Object? stateId = freezed,Object? city = freezed,Object? address = freezed,Object? maritalStatus = freezed,Object? totalChildren = freezed,Object? statusChildren = freezed,Object? religion = freezed,Object? caste = freezed,Object? subcaste = freezed,Object? manglik = freezed,Object? star = freezed,Object? gothra = freezed,Object? moonsign = freezed,Object? motherTongue = freezed,Object? height = freezed,Object? weight = freezed,Object? diet = freezed,Object? smoke = freezed,Object? drink = freezed,Object? bodyType = freezed,Object? skinTone = freezed,Object? educationLevel = freezed,Object? educationDetails = freezed,Object? employeeIn = freezed,Object? employeeInDetails = freezed,Object? occupation = freezed,Object? occupationDetails = freezed,Object? designationLevel = freezed,Object? income = freezed,Object? familyType = freezed,Object? familyStatus = freezed,Object? noOfBrother = freezed,Object? noOfSister = freezed,Object? noOfMarriedBrother = freezed,Object? noOfMarriedSister = freezed,Object? photo1 = freezed,Object? photo1Status = freezed,Object? photo2 = freezed,Object? photo2Status = freezed,Object? photo3 = freezed,Object? photo3Status = freezed,Object? photo4 = freezed,Object? photo4Status = freezed,Object? planName = freezed,Object? planStatus = freezed,Object? countryName = freezed,Object? stateName = freezed,Object? cityName = freezed,Object? religionName = freezed,Object? casteName = freezed,Object? occupationName = freezed,Object? educationName = freezed,Object? interestState = freezed,Object? interestStatus = freezed,Object? interestId = freezed,Object? totalReminderCount = freezed,Object? pendingReminderCount = freezed,Object? canSendReminder = freezed,Object? isShortlisted = freezed,Object? isBlock = freezed,Object? profileTitle = freezed,Object? myProfileTab = freezed,Object? partnerPreferenceTab = freezed,Object? idProofFront = freezed,Object? idProofBack = freezed,Object? idProofStatus = freezed,Object? idProofType = freezed,Object? horoscopeFile = freezed,Object? horoscopeStatus = freezed,Object? profileImage = freezed,Object? isPhotoProtected = freezed,Object? isPhotoRequestSent = freezed,Object? fatherName = freezed,Object? fatherOccupation = freezed,Object? fatherMobileNumber = freezed,Object? fatherPresent = freezed,Object? motherName = freezed,Object? motherOccupation = freezed,Object? motherMobileNumber = freezed,Object? motherPresent = freezed,Object? familyDetails = freezed,Object? residenceType = freezed,Object? alternateNumber = freezed,Object? nriCountry = freezed,Object? partReligion = freezed,Object? partCaste = freezed,Object? partCountry = freezed,Object? partState = freezed,Object? partIncome = freezed,Object? partMaritalStatus = freezed,Object? partEducation = freezed,Object? partOccupation = freezed,Object? partMothertongue = freezed,Object? partManglik = freezed,Object? partFrmAge = freezed,Object? partToAge = freezed,Object? partHeight = freezed,Object? partHeightTo = freezed,Object? profileText = freezed,Object? subTitle = freezed,Object? age = freezed,Object? heightStr = freezed,Object? matchPercent = freezed,Object? completedProfile = freezed,Object? mobileVerifyStatus = freezed,Object? cpassStatus = freezed,Object? profileBy = freezed,Object? horoscope = freezed,Object? birthplace = freezed,Object? birthtime = freezed,Object? videoCallSetting = freezed,Object? voiceCallSetting = freezed,Object? pincode = freezed,Object? residenceTypeOther = freezed,Object? photoVisibility = freezed,Object? contactVisibility = freezed,Object? brotherDetailsArr = freezed,Object? sisterDetailsArr = freezed,Object? paternalFamily = freezed,Object? maternalFamily = freezed,Object? downloadBiodata = freezed,Object? viewProfileAllowed = freezed,}) {
  return _then(_ProfileData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as dynamic,matriId: freezed == matriId ? _self.matriId : matriId // ignore: cast_nullable_to_non_nullable
as dynamic,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as dynamic,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as dynamic,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as dynamic,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as dynamic,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as dynamic,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as dynamic,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as dynamic,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as dynamic,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as dynamic,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as dynamic,totalChildren: freezed == totalChildren ? _self.totalChildren : totalChildren // ignore: cast_nullable_to_non_nullable
as dynamic,statusChildren: freezed == statusChildren ? _self.statusChildren : statusChildren // ignore: cast_nullable_to_non_nullable
as dynamic,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as dynamic,caste: freezed == caste ? _self.caste : caste // ignore: cast_nullable_to_non_nullable
as dynamic,subcaste: freezed == subcaste ? _self.subcaste : subcaste // ignore: cast_nullable_to_non_nullable
as dynamic,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as dynamic,star: freezed == star ? _self.star : star // ignore: cast_nullable_to_non_nullable
as dynamic,gothra: freezed == gothra ? _self.gothra : gothra // ignore: cast_nullable_to_non_nullable
as dynamic,moonsign: freezed == moonsign ? _self.moonsign : moonsign // ignore: cast_nullable_to_non_nullable
as dynamic,motherTongue: freezed == motherTongue ? _self.motherTongue : motherTongue // ignore: cast_nullable_to_non_nullable
as dynamic,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as dynamic,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as dynamic,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as dynamic,smoke: freezed == smoke ? _self.smoke : smoke // ignore: cast_nullable_to_non_nullable
as dynamic,drink: freezed == drink ? _self.drink : drink // ignore: cast_nullable_to_non_nullable
as dynamic,bodyType: freezed == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as dynamic,skinTone: freezed == skinTone ? _self.skinTone : skinTone // ignore: cast_nullable_to_non_nullable
as dynamic,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as dynamic,educationDetails: freezed == educationDetails ? _self.educationDetails : educationDetails // ignore: cast_nullable_to_non_nullable
as dynamic,employeeIn: freezed == employeeIn ? _self.employeeIn : employeeIn // ignore: cast_nullable_to_non_nullable
as dynamic,employeeInDetails: freezed == employeeInDetails ? _self.employeeInDetails : employeeInDetails // ignore: cast_nullable_to_non_nullable
as dynamic,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as dynamic,occupationDetails: freezed == occupationDetails ? _self.occupationDetails : occupationDetails // ignore: cast_nullable_to_non_nullable
as dynamic,designationLevel: freezed == designationLevel ? _self.designationLevel : designationLevel // ignore: cast_nullable_to_non_nullable
as dynamic,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as dynamic,familyType: freezed == familyType ? _self.familyType : familyType // ignore: cast_nullable_to_non_nullable
as dynamic,familyStatus: freezed == familyStatus ? _self.familyStatus : familyStatus // ignore: cast_nullable_to_non_nullable
as dynamic,noOfBrother: freezed == noOfBrother ? _self.noOfBrother : noOfBrother // ignore: cast_nullable_to_non_nullable
as dynamic,noOfSister: freezed == noOfSister ? _self.noOfSister : noOfSister // ignore: cast_nullable_to_non_nullable
as dynamic,noOfMarriedBrother: freezed == noOfMarriedBrother ? _self.noOfMarriedBrother : noOfMarriedBrother // ignore: cast_nullable_to_non_nullable
as dynamic,noOfMarriedSister: freezed == noOfMarriedSister ? _self.noOfMarriedSister : noOfMarriedSister // ignore: cast_nullable_to_non_nullable
as dynamic,photo1: freezed == photo1 ? _self.photo1 : photo1 // ignore: cast_nullable_to_non_nullable
as dynamic,photo1Status: freezed == photo1Status ? _self.photo1Status : photo1Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo2: freezed == photo2 ? _self.photo2 : photo2 // ignore: cast_nullable_to_non_nullable
as dynamic,photo2Status: freezed == photo2Status ? _self.photo2Status : photo2Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo3: freezed == photo3 ? _self.photo3 : photo3 // ignore: cast_nullable_to_non_nullable
as dynamic,photo3Status: freezed == photo3Status ? _self.photo3Status : photo3Status // ignore: cast_nullable_to_non_nullable
as dynamic,photo4: freezed == photo4 ? _self.photo4 : photo4 // ignore: cast_nullable_to_non_nullable
as dynamic,photo4Status: freezed == photo4Status ? _self.photo4Status : photo4Status // ignore: cast_nullable_to_non_nullable
as dynamic,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as dynamic,planStatus: freezed == planStatus ? _self.planStatus : planStatus // ignore: cast_nullable_to_non_nullable
as dynamic,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as dynamic,stateName: freezed == stateName ? _self.stateName : stateName // ignore: cast_nullable_to_non_nullable
as dynamic,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as dynamic,religionName: freezed == religionName ? _self.religionName : religionName // ignore: cast_nullable_to_non_nullable
as dynamic,casteName: freezed == casteName ? _self.casteName : casteName // ignore: cast_nullable_to_non_nullable
as dynamic,occupationName: freezed == occupationName ? _self.occupationName : occupationName // ignore: cast_nullable_to_non_nullable
as dynamic,educationName: freezed == educationName ? _self.educationName : educationName // ignore: cast_nullable_to_non_nullable
as dynamic,interestState: freezed == interestState ? _self.interestState : interestState // ignore: cast_nullable_to_non_nullable
as String?,interestStatus: freezed == interestStatus ? _self.interestStatus : interestStatus // ignore: cast_nullable_to_non_nullable
as String?,interestId: freezed == interestId ? _self.interestId : interestId // ignore: cast_nullable_to_non_nullable
as dynamic,totalReminderCount: freezed == totalReminderCount ? _self.totalReminderCount : totalReminderCount // ignore: cast_nullable_to_non_nullable
as int?,pendingReminderCount: freezed == pendingReminderCount ? _self.pendingReminderCount : pendingReminderCount // ignore: cast_nullable_to_non_nullable
as int?,canSendReminder: freezed == canSendReminder ? _self.canSendReminder : canSendReminder // ignore: cast_nullable_to_non_nullable
as bool?,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,myProfileTab: freezed == myProfileTab ? _self._myProfileTab : myProfileTab // ignore: cast_nullable_to_non_nullable
as List<TabData>?,partnerPreferenceTab: freezed == partnerPreferenceTab ? _self._partnerPreferenceTab : partnerPreferenceTab // ignore: cast_nullable_to_non_nullable
as List<TabData>?,idProofFront: freezed == idProofFront ? _self.idProofFront : idProofFront // ignore: cast_nullable_to_non_nullable
as dynamic,idProofBack: freezed == idProofBack ? _self.idProofBack : idProofBack // ignore: cast_nullable_to_non_nullable
as dynamic,idProofStatus: freezed == idProofStatus ? _self.idProofStatus : idProofStatus // ignore: cast_nullable_to_non_nullable
as dynamic,idProofType: freezed == idProofType ? _self.idProofType : idProofType // ignore: cast_nullable_to_non_nullable
as dynamic,horoscopeFile: freezed == horoscopeFile ? _self.horoscopeFile : horoscopeFile // ignore: cast_nullable_to_non_nullable
as dynamic,horoscopeStatus: freezed == horoscopeStatus ? _self.horoscopeStatus : horoscopeStatus // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoRequestSent: freezed == isPhotoRequestSent ? _self.isPhotoRequestSent : isPhotoRequestSent // ignore: cast_nullable_to_non_nullable
as dynamic,fatherName: freezed == fatherName ? _self.fatherName : fatherName // ignore: cast_nullable_to_non_nullable
as dynamic,fatherOccupation: freezed == fatherOccupation ? _self.fatherOccupation : fatherOccupation // ignore: cast_nullable_to_non_nullable
as dynamic,fatherMobileNumber: freezed == fatherMobileNumber ? _self.fatherMobileNumber : fatherMobileNumber // ignore: cast_nullable_to_non_nullable
as dynamic,fatherPresent: freezed == fatherPresent ? _self.fatherPresent : fatherPresent // ignore: cast_nullable_to_non_nullable
as dynamic,motherName: freezed == motherName ? _self.motherName : motherName // ignore: cast_nullable_to_non_nullable
as dynamic,motherOccupation: freezed == motherOccupation ? _self.motherOccupation : motherOccupation // ignore: cast_nullable_to_non_nullable
as dynamic,motherMobileNumber: freezed == motherMobileNumber ? _self.motherMobileNumber : motherMobileNumber // ignore: cast_nullable_to_non_nullable
as dynamic,motherPresent: freezed == motherPresent ? _self.motherPresent : motherPresent // ignore: cast_nullable_to_non_nullable
as dynamic,familyDetails: freezed == familyDetails ? _self.familyDetails : familyDetails // ignore: cast_nullable_to_non_nullable
as dynamic,residenceType: freezed == residenceType ? _self.residenceType : residenceType // ignore: cast_nullable_to_non_nullable
as dynamic,alternateNumber: freezed == alternateNumber ? _self.alternateNumber : alternateNumber // ignore: cast_nullable_to_non_nullable
as dynamic,nriCountry: freezed == nriCountry ? _self.nriCountry : nriCountry // ignore: cast_nullable_to_non_nullable
as dynamic,partReligion: freezed == partReligion ? _self.partReligion : partReligion // ignore: cast_nullable_to_non_nullable
as dynamic,partCaste: freezed == partCaste ? _self.partCaste : partCaste // ignore: cast_nullable_to_non_nullable
as dynamic,partCountry: freezed == partCountry ? _self.partCountry : partCountry // ignore: cast_nullable_to_non_nullable
as dynamic,partState: freezed == partState ? _self.partState : partState // ignore: cast_nullable_to_non_nullable
as dynamic,partIncome: freezed == partIncome ? _self.partIncome : partIncome // ignore: cast_nullable_to_non_nullable
as dynamic,partMaritalStatus: freezed == partMaritalStatus ? _self.partMaritalStatus : partMaritalStatus // ignore: cast_nullable_to_non_nullable
as dynamic,partEducation: freezed == partEducation ? _self.partEducation : partEducation // ignore: cast_nullable_to_non_nullable
as dynamic,partOccupation: freezed == partOccupation ? _self.partOccupation : partOccupation // ignore: cast_nullable_to_non_nullable
as dynamic,partMothertongue: freezed == partMothertongue ? _self.partMothertongue : partMothertongue // ignore: cast_nullable_to_non_nullable
as dynamic,partManglik: freezed == partManglik ? _self.partManglik : partManglik // ignore: cast_nullable_to_non_nullable
as dynamic,partFrmAge: freezed == partFrmAge ? _self.partFrmAge : partFrmAge // ignore: cast_nullable_to_non_nullable
as dynamic,partToAge: freezed == partToAge ? _self.partToAge : partToAge // ignore: cast_nullable_to_non_nullable
as dynamic,partHeight: freezed == partHeight ? _self.partHeight : partHeight // ignore: cast_nullable_to_non_nullable
as dynamic,partHeightTo: freezed == partHeightTo ? _self.partHeightTo : partHeightTo // ignore: cast_nullable_to_non_nullable
as dynamic,profileText: freezed == profileText ? _self.profileText : profileText // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as dynamic,heightStr: freezed == heightStr ? _self.heightStr : heightStr // ignore: cast_nullable_to_non_nullable
as dynamic,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,completedProfile: freezed == completedProfile ? _self.completedProfile : completedProfile // ignore: cast_nullable_to_non_nullable
as dynamic,mobileVerifyStatus: freezed == mobileVerifyStatus ? _self.mobileVerifyStatus : mobileVerifyStatus // ignore: cast_nullable_to_non_nullable
as dynamic,cpassStatus: freezed == cpassStatus ? _self.cpassStatus : cpassStatus // ignore: cast_nullable_to_non_nullable
as dynamic,profileBy: freezed == profileBy ? _self.profileBy : profileBy // ignore: cast_nullable_to_non_nullable
as dynamic,horoscope: freezed == horoscope ? _self.horoscope : horoscope // ignore: cast_nullable_to_non_nullable
as dynamic,birthplace: freezed == birthplace ? _self.birthplace : birthplace // ignore: cast_nullable_to_non_nullable
as dynamic,birthtime: freezed == birthtime ? _self.birthtime : birthtime // ignore: cast_nullable_to_non_nullable
as dynamic,videoCallSetting: freezed == videoCallSetting ? _self.videoCallSetting : videoCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,voiceCallSetting: freezed == voiceCallSetting ? _self.voiceCallSetting : voiceCallSetting // ignore: cast_nullable_to_non_nullable
as dynamic,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as dynamic,residenceTypeOther: freezed == residenceTypeOther ? _self.residenceTypeOther : residenceTypeOther // ignore: cast_nullable_to_non_nullable
as dynamic,photoVisibility: freezed == photoVisibility ? _self.photoVisibility : photoVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,contactVisibility: freezed == contactVisibility ? _self.contactVisibility : contactVisibility // ignore: cast_nullable_to_non_nullable
as dynamic,brotherDetailsArr: freezed == brotherDetailsArr ? _self._brotherDetailsArr : brotherDetailsArr // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,sisterDetailsArr: freezed == sisterDetailsArr ? _self._sisterDetailsArr : sisterDetailsArr // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,paternalFamily: freezed == paternalFamily ? _self._paternalFamily : paternalFamily // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,maternalFamily: freezed == maternalFamily ? _self._maternalFamily : maternalFamily // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,downloadBiodata: freezed == downloadBiodata ? _self.downloadBiodata : downloadBiodata // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileAllowed: freezed == viewProfileAllowed ? _self.viewProfileAllowed : viewProfileAllowed // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$TabData {

 String? get sectionTitle; String? get sectionId; List<SectionValue>? get sectionValue;
/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabDataCopyWith<TabData> get copyWith => _$TabDataCopyWithImpl<TabData>(this as TabData, _$identity);

  /// Serializes this TabData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TabData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabData&&(identical(other.sectionTitle, _this.sectionTitle) || other.sectionTitle == _this.sectionTitle)&&(identical(other.sectionId, _this.sectionId) || other.sectionId == _this.sectionId)&&const DeepCollectionEquality().equals(other.sectionValue, _this.sectionValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TabData;
  return Object.hash(runtimeType,_this.sectionTitle,_this.sectionId,const DeepCollectionEquality().hash(_this.sectionValue));
}

@override
String toString() {
  final _this = this as TabData;
  return 'TabData(sectionTitle: ${_this.sectionTitle}, sectionId: ${_this.sectionId}, sectionValue: ${_this.sectionValue})';
}


}

/// @nodoc
abstract mixin class $TabDataCopyWith<$Res>  {
  factory $TabDataCopyWith(TabData value, $Res Function(TabData) _then) = _$TabDataCopyWithImpl;
@useResult
$Res call({
 String? sectionTitle, String? sectionId, List<SectionValue>? sectionValue
});




}
/// @nodoc
class _$TabDataCopyWithImpl<$Res>
    implements $TabDataCopyWith<$Res> {
  _$TabDataCopyWithImpl(this._self, this._then);

  final TabData _self;
  final $Res Function(TabData) _then;

/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sectionTitle = freezed,Object? sectionId = freezed,Object? sectionValue = freezed,}) {
  return _then(TabData(
sectionTitle: freezed == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String?,sectionValue: freezed == sectionValue ? _self.sectionValue : sectionValue // ignore: cast_nullable_to_non_nullable
as List<SectionValue>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TabData].
extension TabDataPatterns on TabData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabData value)  $default,){
final _that = this;
switch (_that) {
case _TabData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabData value)?  $default,){
final _that = this;
switch (_that) {
case _TabData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sectionTitle,  String? sectionId,  List<SectionValue>? sectionValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabData() when $default != null:
return $default(_that.sectionTitle,_that.sectionId,_that.sectionValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sectionTitle,  String? sectionId,  List<SectionValue>? sectionValue)  $default,) {final _that = this;
switch (_that) {
case _TabData():
return $default(_that.sectionTitle,_that.sectionId,_that.sectionValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sectionTitle,  String? sectionId,  List<SectionValue>? sectionValue)?  $default,) {final _that = this;
switch (_that) {
case _TabData() when $default != null:
return $default(_that.sectionTitle,_that.sectionId,_that.sectionValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TabData implements TabData {
  const _TabData({this.sectionTitle, this.sectionId,  List<SectionValue>? sectionValue}): _sectionValue = sectionValue;
  factory _TabData.fromJson(Map<String, dynamic> json) => _$TabDataFromJson(json);

@override final  String? sectionTitle;
@override final  String? sectionId;
 final  List<SectionValue>? _sectionValue;
@override List<SectionValue>? get sectionValue {
  final value = _sectionValue;
  if (value == null) return null;
  if (_sectionValue is EqualUnmodifiableListView) return _sectionValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabDataCopyWith<_TabData> get copyWith => __$TabDataCopyWithImpl<_TabData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TabDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabData&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&const DeepCollectionEquality().equals(other.sectionValue, _sectionValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sectionTitle,sectionId,const DeepCollectionEquality().hash(_sectionValue));
}

@override
String toString() {
    return 'TabData(sectionTitle: $sectionTitle, sectionId: $sectionId, sectionValue: $sectionValue)';
}


}

/// @nodoc
abstract mixin class _$TabDataCopyWith<$Res> implements $TabDataCopyWith<$Res> {
  factory _$TabDataCopyWith(_TabData value, $Res Function(_TabData) _then) = __$TabDataCopyWithImpl;
@override @useResult
$Res call({
 String? sectionTitle, String? sectionId, List<SectionValue>? sectionValue
});




}
/// @nodoc
class __$TabDataCopyWithImpl<$Res>
    implements _$TabDataCopyWith<$Res> {
  __$TabDataCopyWithImpl(this._self, this._then);

  final _TabData _self;
  final $Res Function(_TabData) _then;

/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sectionTitle = freezed,Object? sectionId = freezed,Object? sectionValue = freezed,}) {
  return _then(_TabData(
sectionTitle: freezed == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String?,sectionValue: freezed == sectionValue ? _self._sectionValue : sectionValue // ignore: cast_nullable_to_non_nullable
as List<SectionValue>?,
  ));
}


}


/// @nodoc
mixin _$SectionValue {

 String? get key; String? get label; String? get value;@JsonKey(name: 'selected_ids') dynamic get selectedIds;
/// Create a copy of SectionValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionValueCopyWith<SectionValue> get copyWith => _$SectionValueCopyWithImpl<SectionValue>(this as SectionValue, _$identity);

  /// Serializes this SectionValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SectionValue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionValue&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.value, _this.value) || other.value == _this.value)&&const DeepCollectionEquality().equals(other.selectedIds, _this.selectedIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SectionValue;
  return Object.hash(runtimeType,_this.key,_this.label,_this.value,const DeepCollectionEquality().hash(_this.selectedIds));
}

@override
String toString() {
  final _this = this as SectionValue;
  return 'SectionValue(key: ${_this.key}, label: ${_this.label}, value: ${_this.value}, selectedIds: ${_this.selectedIds})';
}


}

/// @nodoc
abstract mixin class $SectionValueCopyWith<$Res>  {
  factory $SectionValueCopyWith(SectionValue value, $Res Function(SectionValue) _then) = _$SectionValueCopyWithImpl;
@useResult
$Res call({
 String? key, String? label, String? value,@JsonKey(name: 'selected_ids') dynamic selectedIds
});




}
/// @nodoc
class _$SectionValueCopyWithImpl<$Res>
    implements $SectionValueCopyWith<$Res> {
  _$SectionValueCopyWithImpl(this._self, this._then);

  final SectionValue _self;
  final $Res Function(SectionValue) _then;

/// Create a copy of SectionValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = freezed,Object? label = freezed,Object? value = freezed,Object? selectedIds = freezed,}) {
  return _then(SectionValue(
key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,selectedIds: freezed == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [SectionValue].
extension SectionValuePatterns on SectionValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectionValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectionValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectionValue value)  $default,){
final _that = this;
switch (_that) {
case _SectionValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectionValue value)?  $default,){
final _that = this;
switch (_that) {
case _SectionValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? key,  String? label,  String? value, @JsonKey(name: 'selected_ids')  dynamic selectedIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectionValue() when $default != null:
return $default(_that.key,_that.label,_that.value,_that.selectedIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? key,  String? label,  String? value, @JsonKey(name: 'selected_ids')  dynamic selectedIds)  $default,) {final _that = this;
switch (_that) {
case _SectionValue():
return $default(_that.key,_that.label,_that.value,_that.selectedIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? key,  String? label,  String? value, @JsonKey(name: 'selected_ids')  dynamic selectedIds)?  $default,) {final _that = this;
switch (_that) {
case _SectionValue() when $default != null:
return $default(_that.key,_that.label,_that.value,_that.selectedIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SectionValue implements SectionValue {
  const _SectionValue({this.key, this.label, this.value, @JsonKey(name: 'selected_ids') this.selectedIds});
  factory _SectionValue.fromJson(Map<String, dynamic> json) => _$SectionValueFromJson(json);

@override final  String? key;
@override final  String? label;
@override final  String? value;
@override@JsonKey(name: 'selected_ids') final  dynamic selectedIds;

/// Create a copy of SectionValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionValueCopyWith<_SectionValue> get copyWith => __$SectionValueCopyWithImpl<_SectionValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectionValueToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionValue&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,key,label,value,const DeepCollectionEquality().hash(selectedIds));
}

@override
String toString() {
    return 'SectionValue(key: $key, label: $label, value: $value, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class _$SectionValueCopyWith<$Res> implements $SectionValueCopyWith<$Res> {
  factory _$SectionValueCopyWith(_SectionValue value, $Res Function(_SectionValue) _then) = __$SectionValueCopyWithImpl;
@override @useResult
$Res call({
 String? key, String? label, String? value,@JsonKey(name: 'selected_ids') dynamic selectedIds
});




}
/// @nodoc
class __$SectionValueCopyWithImpl<$Res>
    implements _$SectionValueCopyWith<$Res> {
  __$SectionValueCopyWithImpl(this._self, this._then);

  final _SectionValue _self;
  final $Res Function(_SectionValue) _then;

/// Create a copy of SectionValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = freezed,Object? label = freezed,Object? value = freezed,Object? selectedIds = freezed,}) {
  return _then(_SectionValue(
key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,selectedIds: freezed == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
