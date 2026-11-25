// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationListResponseModel {

 int? get code; String? get status; String? get message; NotificationData? get data;
/// Create a copy of NotificationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationListResponseModelCopyWith<NotificationListResponseModel> get copyWith => _$NotificationListResponseModelCopyWithImpl<NotificationListResponseModel>(this as NotificationListResponseModel, _$identity);

  /// Serializes this NotificationListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as NotificationListResponseModel;
  return 'NotificationListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $NotificationListResponseModelCopyWith<$Res>  {
  factory $NotificationListResponseModelCopyWith(NotificationListResponseModel value, $Res Function(NotificationListResponseModel) _then) = _$NotificationListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, NotificationData? data
});


$NotificationDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$NotificationListResponseModelCopyWithImpl<$Res>
    implements $NotificationListResponseModelCopyWith<$Res> {
  _$NotificationListResponseModelCopyWithImpl(this._self, this._then);

  final NotificationListResponseModel _self;
  final $Res Function(NotificationListResponseModel) _then;

/// Create a copy of NotificationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(NotificationListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NotificationData?,
  ));
}
/// Create a copy of NotificationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $NotificationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationListResponseModel].
extension NotificationListResponseModelPatterns on NotificationListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  NotificationData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  NotificationData? data)  $default,) {final _that = this;
switch (_that) {
case _NotificationListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  NotificationData? data)?  $default,) {final _that = this;
switch (_that) {
case _NotificationListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationListResponseModel implements NotificationListResponseModel {
  const _NotificationListResponseModel({this.code, this.status, this.message, this.data});
  factory _NotificationListResponseModel.fromJson(Map<String, dynamic> json) => _$NotificationListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  NotificationData? data;

/// Create a copy of NotificationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationListResponseModelCopyWith<_NotificationListResponseModel> get copyWith => __$NotificationListResponseModelCopyWithImpl<_NotificationListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'NotificationListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$NotificationListResponseModelCopyWith<$Res> implements $NotificationListResponseModelCopyWith<$Res> {
  factory _$NotificationListResponseModelCopyWith(_NotificationListResponseModel value, $Res Function(_NotificationListResponseModel) _then) = __$NotificationListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, NotificationData? data
});


@override $NotificationDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$NotificationListResponseModelCopyWithImpl<$Res>
    implements _$NotificationListResponseModelCopyWith<$Res> {
  __$NotificationListResponseModelCopyWithImpl(this._self, this._then);

  final _NotificationListResponseModel _self;
  final $Res Function(_NotificationListResponseModel) _then;

/// Create a copy of NotificationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_NotificationListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NotificationData?,
  ));
}

/// Create a copy of NotificationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $NotificationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$NotificationData {

@JsonKey(name: 'resultCount') int? get resultCount;@JsonKey(name: 'resultList') List<NotificationItem>? get resultList;
/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDataCopyWith<NotificationData> get copyWith => _$NotificationDataCopyWithImpl<NotificationData>(this as NotificationData, _$identity);

  /// Serializes this NotificationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as NotificationData;
  return 'NotificationData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $NotificationDataCopyWith<$Res>  {
  factory $NotificationDataCopyWith(NotificationData value, $Res Function(NotificationData) _then) = _$NotificationDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<NotificationItem>? resultList
});




}
/// @nodoc
class _$NotificationDataCopyWithImpl<$Res>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._self, this._then);

  final NotificationData _self;
  final $Res Function(NotificationData) _then;

/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(NotificationData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<NotificationItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationData].
extension NotificationDataPatterns on NotificationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationData value)  $default,){
final _that = this;
switch (_that) {
case _NotificationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationData value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<NotificationItem>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<NotificationItem>? resultList)  $default,) {final _that = this;
switch (_that) {
case _NotificationData():
return $default(_that.resultCount,_that.resultList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<NotificationItem>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationData implements NotificationData {
  const _NotificationData({@JsonKey(name: 'resultCount') this.resultCount, @JsonKey(name: 'resultList')  List<NotificationItem>? resultList}): _resultList = resultList;
  factory _NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

@override@JsonKey(name: 'resultCount') final  int? resultCount;
 final  List<NotificationItem>? _resultList;
@override@JsonKey(name: 'resultList') List<NotificationItem>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDataCopyWith<_NotificationData> get copyWith => __$NotificationDataCopyWithImpl<_NotificationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'NotificationData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$NotificationDataCopyWith<$Res> implements $NotificationDataCopyWith<$Res> {
  factory _$NotificationDataCopyWith(_NotificationData value, $Res Function(_NotificationData) _then) = __$NotificationDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<NotificationItem>? resultList
});




}
/// @nodoc
class __$NotificationDataCopyWithImpl<$Res>
    implements _$NotificationDataCopyWith<$Res> {
  __$NotificationDataCopyWithImpl(this._self, this._then);

  final _NotificationData _self;
  final $Res Function(_NotificationData) _then;

/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_NotificationData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<NotificationItem>?,
  ));
}


}


/// @nodoc
mixin _$NotificationItem {

 dynamic get id;@JsonKey(name: 'sender_member_id') dynamic get senderMemberId;@JsonKey(name: 'receiver_member_id') dynamic get receiverMemberId;@JsonKey(name: 'sender_matri_id') dynamic get senderMatriId;@JsonKey(name: 'receiver_matri_id') dynamic get receiverMatriId; dynamic get title; dynamic get message; dynamic get action;@JsonKey(name: 'notication_by') dynamic get notificationBy; dynamic get image;@JsonKey(name: 'is_read') dynamic get isRead; dynamic get status;@JsonKey(name: 'created_at') dynamic get createdAt;@JsonKey(name: 'profile_title') dynamic get profileTitle;@JsonKey(name: 'sub_title') dynamic get subTitle;@JsonKey(name: 'profile_image') dynamic get profileImage;@JsonKey(name: 'is_photo_protected') dynamic get isPhotoProtected;@JsonKey(name: 'is_shortlisted') dynamic get isShortlisted;@JsonKey(name: 'is_interest') dynamic get isInterest;@JsonKey(name: 'isBlocked') dynamic get isBlocked;@JsonKey(name: 'is_online') dynamic get isOnline;@JsonKey(name: 'matchPercent') dynamic get matchPercent;
/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationItemCopyWith<NotificationItem> get copyWith => _$NotificationItemCopyWithImpl<NotificationItem>(this as NotificationItem, _$identity);

  /// Serializes this NotificationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationItem&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.senderMemberId, _this.senderMemberId)&&const DeepCollectionEquality().equals(other.receiverMemberId, _this.receiverMemberId)&&const DeepCollectionEquality().equals(other.senderMatriId, _this.senderMatriId)&&const DeepCollectionEquality().equals(other.receiverMatriId, _this.receiverMatriId)&&const DeepCollectionEquality().equals(other.title, _this.title)&&const DeepCollectionEquality().equals(other.message, _this.message)&&const DeepCollectionEquality().equals(other.action, _this.action)&&const DeepCollectionEquality().equals(other.notificationBy, _this.notificationBy)&&const DeepCollectionEquality().equals(other.image, _this.image)&&const DeepCollectionEquality().equals(other.isRead, _this.isRead)&&const DeepCollectionEquality().equals(other.status, _this.status)&&const DeepCollectionEquality().equals(other.createdAt, _this.createdAt)&&const DeepCollectionEquality().equals(other.profileTitle, _this.profileTitle)&&const DeepCollectionEquality().equals(other.subTitle, _this.subTitle)&&const DeepCollectionEquality().equals(other.profileImage, _this.profileImage)&&const DeepCollectionEquality().equals(other.isPhotoProtected, _this.isPhotoProtected)&&const DeepCollectionEquality().equals(other.isShortlisted, _this.isShortlisted)&&const DeepCollectionEquality().equals(other.isInterest, _this.isInterest)&&const DeepCollectionEquality().equals(other.isBlocked, _this.isBlocked)&&const DeepCollectionEquality().equals(other.isOnline, _this.isOnline)&&const DeepCollectionEquality().equals(other.matchPercent, _this.matchPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationItem;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.senderMemberId),const DeepCollectionEquality().hash(_this.receiverMemberId),const DeepCollectionEquality().hash(_this.senderMatriId),const DeepCollectionEquality().hash(_this.receiverMatriId),const DeepCollectionEquality().hash(_this.title),const DeepCollectionEquality().hash(_this.message),const DeepCollectionEquality().hash(_this.action),const DeepCollectionEquality().hash(_this.notificationBy),const DeepCollectionEquality().hash(_this.image),const DeepCollectionEquality().hash(_this.isRead),const DeepCollectionEquality().hash(_this.status),const DeepCollectionEquality().hash(_this.createdAt),const DeepCollectionEquality().hash(_this.profileTitle),const DeepCollectionEquality().hash(_this.subTitle),const DeepCollectionEquality().hash(_this.profileImage),const DeepCollectionEquality().hash(_this.isPhotoProtected),const DeepCollectionEquality().hash(_this.isShortlisted),const DeepCollectionEquality().hash(_this.isInterest),const DeepCollectionEquality().hash(_this.isBlocked),const DeepCollectionEquality().hash(_this.isOnline),const DeepCollectionEquality().hash(_this.matchPercent)]);
}

@override
String toString() {
  final _this = this as NotificationItem;
  return 'NotificationItem(id: ${_this.id}, senderMemberId: ${_this.senderMemberId}, receiverMemberId: ${_this.receiverMemberId}, senderMatriId: ${_this.senderMatriId}, receiverMatriId: ${_this.receiverMatriId}, title: ${_this.title}, message: ${_this.message}, action: ${_this.action}, notificationBy: ${_this.notificationBy}, image: ${_this.image}, isRead: ${_this.isRead}, status: ${_this.status}, createdAt: ${_this.createdAt}, profileTitle: ${_this.profileTitle}, subTitle: ${_this.subTitle}, profileImage: ${_this.profileImage}, isPhotoProtected: ${_this.isPhotoProtected}, isShortlisted: ${_this.isShortlisted}, isInterest: ${_this.isInterest}, isBlocked: ${_this.isBlocked}, isOnline: ${_this.isOnline}, matchPercent: ${_this.matchPercent})';
}


}

/// @nodoc
abstract mixin class $NotificationItemCopyWith<$Res>  {
  factory $NotificationItemCopyWith(NotificationItem value, $Res Function(NotificationItem) _then) = _$NotificationItemCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'sender_matri_id') dynamic senderMatriId,@JsonKey(name: 'receiver_matri_id') dynamic receiverMatriId, dynamic title, dynamic message, dynamic action,@JsonKey(name: 'notication_by') dynamic notificationBy, dynamic image,@JsonKey(name: 'is_read') dynamic isRead, dynamic status,@JsonKey(name: 'created_at') dynamic createdAt,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'sub_title') dynamic subTitle,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'is_photo_protected') dynamic isPhotoProtected,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_interest') dynamic isInterest,@JsonKey(name: 'isBlocked') dynamic isBlocked,@JsonKey(name: 'is_online') dynamic isOnline,@JsonKey(name: 'matchPercent') dynamic matchPercent
});




}
/// @nodoc
class _$NotificationItemCopyWithImpl<$Res>
    implements $NotificationItemCopyWith<$Res> {
  _$NotificationItemCopyWithImpl(this._self, this._then);

  final NotificationItem _self;
  final $Res Function(NotificationItem) _then;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? senderMemberId = freezed,Object? receiverMemberId = freezed,Object? senderMatriId = freezed,Object? receiverMatriId = freezed,Object? title = freezed,Object? message = freezed,Object? action = freezed,Object? notificationBy = freezed,Object? image = freezed,Object? isRead = freezed,Object? status = freezed,Object? createdAt = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtected = freezed,Object? isShortlisted = freezed,Object? isInterest = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? matchPercent = freezed,}) {
  return _then(NotificationItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMatriId: freezed == senderMatriId ? _self.senderMatriId : senderMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMatriId: freezed == receiverMatriId ? _self.receiverMatriId : receiverMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as dynamic,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as dynamic,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as dynamic,notificationBy: freezed == notificationBy ? _self.notificationBy : notificationBy // ignore: cast_nullable_to_non_nullable
as dynamic,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as dynamic,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isInterest: freezed == isInterest ? _self.isInterest : isInterest // ignore: cast_nullable_to_non_nullable
as dynamic,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as dynamic,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as dynamic,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationItem].
extension NotificationItemPatterns on NotificationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationItem value)  $default,){
final _that = this;
switch (_that) {
case _NotificationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationItem value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'sender_matri_id')  dynamic senderMatriId, @JsonKey(name: 'receiver_matri_id')  dynamic receiverMatriId,  dynamic title,  dynamic message,  dynamic action, @JsonKey(name: 'notication_by')  dynamic notificationBy,  dynamic image, @JsonKey(name: 'is_read')  dynamic isRead,  dynamic status, @JsonKey(name: 'created_at')  dynamic createdAt, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'is_photo_protected')  dynamic isPhotoProtected, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_interest')  dynamic isInterest, @JsonKey(name: 'isBlocked')  dynamic isBlocked, @JsonKey(name: 'is_online')  dynamic isOnline, @JsonKey(name: 'matchPercent')  dynamic matchPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
return $default(_that.id,_that.senderMemberId,_that.receiverMemberId,_that.senderMatriId,_that.receiverMatriId,_that.title,_that.message,_that.action,_that.notificationBy,_that.image,_that.isRead,_that.status,_that.createdAt,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtected,_that.isShortlisted,_that.isInterest,_that.isBlocked,_that.isOnline,_that.matchPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'sender_matri_id')  dynamic senderMatriId, @JsonKey(name: 'receiver_matri_id')  dynamic receiverMatriId,  dynamic title,  dynamic message,  dynamic action, @JsonKey(name: 'notication_by')  dynamic notificationBy,  dynamic image, @JsonKey(name: 'is_read')  dynamic isRead,  dynamic status, @JsonKey(name: 'created_at')  dynamic createdAt, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'is_photo_protected')  dynamic isPhotoProtected, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_interest')  dynamic isInterest, @JsonKey(name: 'isBlocked')  dynamic isBlocked, @JsonKey(name: 'is_online')  dynamic isOnline, @JsonKey(name: 'matchPercent')  dynamic matchPercent)  $default,) {final _that = this;
switch (_that) {
case _NotificationItem():
return $default(_that.id,_that.senderMemberId,_that.receiverMemberId,_that.senderMatriId,_that.receiverMatriId,_that.title,_that.message,_that.action,_that.notificationBy,_that.image,_that.isRead,_that.status,_that.createdAt,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtected,_that.isShortlisted,_that.isInterest,_that.isBlocked,_that.isOnline,_that.matchPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'sender_matri_id')  dynamic senderMatriId, @JsonKey(name: 'receiver_matri_id')  dynamic receiverMatriId,  dynamic title,  dynamic message,  dynamic action, @JsonKey(name: 'notication_by')  dynamic notificationBy,  dynamic image, @JsonKey(name: 'is_read')  dynamic isRead,  dynamic status, @JsonKey(name: 'created_at')  dynamic createdAt, @JsonKey(name: 'profile_title')  dynamic profileTitle, @JsonKey(name: 'sub_title')  dynamic subTitle, @JsonKey(name: 'profile_image')  dynamic profileImage, @JsonKey(name: 'is_photo_protected')  dynamic isPhotoProtected, @JsonKey(name: 'is_shortlisted')  dynamic isShortlisted, @JsonKey(name: 'is_interest')  dynamic isInterest, @JsonKey(name: 'isBlocked')  dynamic isBlocked, @JsonKey(name: 'is_online')  dynamic isOnline, @JsonKey(name: 'matchPercent')  dynamic matchPercent)?  $default,) {final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
return $default(_that.id,_that.senderMemberId,_that.receiverMemberId,_that.senderMatriId,_that.receiverMatriId,_that.title,_that.message,_that.action,_that.notificationBy,_that.image,_that.isRead,_that.status,_that.createdAt,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtected,_that.isShortlisted,_that.isInterest,_that.isBlocked,_that.isOnline,_that.matchPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationItem implements NotificationItem {
  const _NotificationItem({this.id, @JsonKey(name: 'sender_member_id') this.senderMemberId, @JsonKey(name: 'receiver_member_id') this.receiverMemberId, @JsonKey(name: 'sender_matri_id') this.senderMatriId, @JsonKey(name: 'receiver_matri_id') this.receiverMatriId, this.title, this.message, this.action, @JsonKey(name: 'notication_by') this.notificationBy, this.image, @JsonKey(name: 'is_read') this.isRead, this.status, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'is_photo_protected') this.isPhotoProtected, @JsonKey(name: 'is_shortlisted') this.isShortlisted, @JsonKey(name: 'is_interest') this.isInterest, @JsonKey(name: 'isBlocked') this.isBlocked, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'matchPercent') this.matchPercent});
  factory _NotificationItem.fromJson(Map<String, dynamic> json) => _$NotificationItemFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'sender_member_id') final  dynamic senderMemberId;
@override@JsonKey(name: 'receiver_member_id') final  dynamic receiverMemberId;
@override@JsonKey(name: 'sender_matri_id') final  dynamic senderMatriId;
@override@JsonKey(name: 'receiver_matri_id') final  dynamic receiverMatriId;
@override final  dynamic title;
@override final  dynamic message;
@override final  dynamic action;
@override@JsonKey(name: 'notication_by') final  dynamic notificationBy;
@override final  dynamic image;
@override@JsonKey(name: 'is_read') final  dynamic isRead;
@override final  dynamic status;
@override@JsonKey(name: 'created_at') final  dynamic createdAt;
@override@JsonKey(name: 'profile_title') final  dynamic profileTitle;
@override@JsonKey(name: 'sub_title') final  dynamic subTitle;
@override@JsonKey(name: 'profile_image') final  dynamic profileImage;
@override@JsonKey(name: 'is_photo_protected') final  dynamic isPhotoProtected;
@override@JsonKey(name: 'is_shortlisted') final  dynamic isShortlisted;
@override@JsonKey(name: 'is_interest') final  dynamic isInterest;
@override@JsonKey(name: 'isBlocked') final  dynamic isBlocked;
@override@JsonKey(name: 'is_online') final  dynamic isOnline;
@override@JsonKey(name: 'matchPercent') final  dynamic matchPercent;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationItemCopyWith<_NotificationItem> get copyWith => __$NotificationItemCopyWithImpl<_NotificationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationItem&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.senderMemberId, senderMemberId)&&const DeepCollectionEquality().equals(other.receiverMemberId, receiverMemberId)&&const DeepCollectionEquality().equals(other.senderMatriId, senderMatriId)&&const DeepCollectionEquality().equals(other.receiverMatriId, receiverMatriId)&&const DeepCollectionEquality().equals(other.title, title)&&const DeepCollectionEquality().equals(other.message, message)&&const DeepCollectionEquality().equals(other.action, action)&&const DeepCollectionEquality().equals(other.notificationBy, notificationBy)&&const DeepCollectionEquality().equals(other.image, image)&&const DeepCollectionEquality().equals(other.isRead, isRead)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.createdAt, createdAt)&&const DeepCollectionEquality().equals(other.profileTitle, profileTitle)&&const DeepCollectionEquality().equals(other.subTitle, subTitle)&&const DeepCollectionEquality().equals(other.profileImage, profileImage)&&const DeepCollectionEquality().equals(other.isPhotoProtected, isPhotoProtected)&&const DeepCollectionEquality().equals(other.isShortlisted, isShortlisted)&&const DeepCollectionEquality().equals(other.isInterest, isInterest)&&const DeepCollectionEquality().equals(other.isBlocked, isBlocked)&&const DeepCollectionEquality().equals(other.isOnline, isOnline)&&const DeepCollectionEquality().equals(other.matchPercent, matchPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(senderMemberId),const DeepCollectionEquality().hash(receiverMemberId),const DeepCollectionEquality().hash(senderMatriId),const DeepCollectionEquality().hash(receiverMatriId),const DeepCollectionEquality().hash(title),const DeepCollectionEquality().hash(message),const DeepCollectionEquality().hash(action),const DeepCollectionEquality().hash(notificationBy),const DeepCollectionEquality().hash(image),const DeepCollectionEquality().hash(isRead),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(createdAt),const DeepCollectionEquality().hash(profileTitle),const DeepCollectionEquality().hash(subTitle),const DeepCollectionEquality().hash(profileImage),const DeepCollectionEquality().hash(isPhotoProtected),const DeepCollectionEquality().hash(isShortlisted),const DeepCollectionEquality().hash(isInterest),const DeepCollectionEquality().hash(isBlocked),const DeepCollectionEquality().hash(isOnline),const DeepCollectionEquality().hash(matchPercent)]);
}

@override
String toString() {
    return 'NotificationItem(id: $id, senderMemberId: $senderMemberId, receiverMemberId: $receiverMemberId, senderMatriId: $senderMatriId, receiverMatriId: $receiverMatriId, title: $title, message: $message, action: $action, notificationBy: $notificationBy, image: $image, isRead: $isRead, status: $status, createdAt: $createdAt, profileTitle: $profileTitle, subTitle: $subTitle, profileImage: $profileImage, isPhotoProtected: $isPhotoProtected, isShortlisted: $isShortlisted, isInterest: $isInterest, isBlocked: $isBlocked, isOnline: $isOnline, matchPercent: $matchPercent)';
}


}

/// @nodoc
abstract mixin class _$NotificationItemCopyWith<$Res> implements $NotificationItemCopyWith<$Res> {
  factory _$NotificationItemCopyWith(_NotificationItem value, $Res Function(_NotificationItem) _then) = __$NotificationItemCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'sender_matri_id') dynamic senderMatriId,@JsonKey(name: 'receiver_matri_id') dynamic receiverMatriId, dynamic title, dynamic message, dynamic action,@JsonKey(name: 'notication_by') dynamic notificationBy, dynamic image,@JsonKey(name: 'is_read') dynamic isRead, dynamic status,@JsonKey(name: 'created_at') dynamic createdAt,@JsonKey(name: 'profile_title') dynamic profileTitle,@JsonKey(name: 'sub_title') dynamic subTitle,@JsonKey(name: 'profile_image') dynamic profileImage,@JsonKey(name: 'is_photo_protected') dynamic isPhotoProtected,@JsonKey(name: 'is_shortlisted') dynamic isShortlisted,@JsonKey(name: 'is_interest') dynamic isInterest,@JsonKey(name: 'isBlocked') dynamic isBlocked,@JsonKey(name: 'is_online') dynamic isOnline,@JsonKey(name: 'matchPercent') dynamic matchPercent
});




}
/// @nodoc
class __$NotificationItemCopyWithImpl<$Res>
    implements _$NotificationItemCopyWith<$Res> {
  __$NotificationItemCopyWithImpl(this._self, this._then);

  final _NotificationItem _self;
  final $Res Function(_NotificationItem) _then;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? senderMemberId = freezed,Object? receiverMemberId = freezed,Object? senderMatriId = freezed,Object? receiverMatriId = freezed,Object? title = freezed,Object? message = freezed,Object? action = freezed,Object? notificationBy = freezed,Object? image = freezed,Object? isRead = freezed,Object? status = freezed,Object? createdAt = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtected = freezed,Object? isShortlisted = freezed,Object? isInterest = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? matchPercent = freezed,}) {
  return _then(_NotificationItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMatriId: freezed == senderMatriId ? _self.senderMatriId : senderMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMatriId: freezed == receiverMatriId ? _self.receiverMatriId : receiverMatriId // ignore: cast_nullable_to_non_nullable
as dynamic,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as dynamic,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as dynamic,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as dynamic,notificationBy: freezed == notificationBy ? _self.notificationBy : notificationBy // ignore: cast_nullable_to_non_nullable
as dynamic,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as dynamic,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as dynamic,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as dynamic,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as dynamic,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as dynamic,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as dynamic,isInterest: freezed == isInterest ? _self.isInterest : isInterest // ignore: cast_nullable_to_non_nullable
as dynamic,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as dynamic,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as dynamic,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
