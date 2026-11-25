// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMemberListResponseModel {

 int? get code; String? get status; String? get message; ChatMemberListData? get data;
/// Create a copy of ChatMemberListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMemberListResponseModelCopyWith<ChatMemberListResponseModel> get copyWith => _$ChatMemberListResponseModelCopyWithImpl<ChatMemberListResponseModel>(this as ChatMemberListResponseModel, _$identity);

  /// Serializes this ChatMemberListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMemberListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMemberListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMemberListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as ChatMemberListResponseModel;
  return 'ChatMemberListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ChatMemberListResponseModelCopyWith<$Res>  {
  factory $ChatMemberListResponseModelCopyWith(ChatMemberListResponseModel value, $Res Function(ChatMemberListResponseModel) _then) = _$ChatMemberListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, ChatMemberListData? data
});


$ChatMemberListDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ChatMemberListResponseModelCopyWithImpl<$Res>
    implements $ChatMemberListResponseModelCopyWith<$Res> {
  _$ChatMemberListResponseModelCopyWithImpl(this._self, this._then);

  final ChatMemberListResponseModel _self;
  final $Res Function(ChatMemberListResponseModel) _then;

/// Create a copy of ChatMemberListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(ChatMemberListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatMemberListData?,
  ));
}
/// Create a copy of ChatMemberListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMemberListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ChatMemberListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMemberListResponseModel].
extension ChatMemberListResponseModelPatterns on ChatMemberListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMemberListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMemberListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMemberListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatMemberListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMemberListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMemberListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ChatMemberListData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMemberListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ChatMemberListData? data)  $default,) {final _that = this;
switch (_that) {
case _ChatMemberListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  ChatMemberListData? data)?  $default,) {final _that = this;
switch (_that) {
case _ChatMemberListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMemberListResponseModel implements ChatMemberListResponseModel {
  const _ChatMemberListResponseModel({this.code, this.status, this.message, this.data});
  factory _ChatMemberListResponseModel.fromJson(Map<String, dynamic> json) => _$ChatMemberListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  ChatMemberListData? data;

/// Create a copy of ChatMemberListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMemberListResponseModelCopyWith<_ChatMemberListResponseModel> get copyWith => __$ChatMemberListResponseModelCopyWithImpl<_ChatMemberListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMemberListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMemberListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'ChatMemberListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ChatMemberListResponseModelCopyWith<$Res> implements $ChatMemberListResponseModelCopyWith<$Res> {
  factory _$ChatMemberListResponseModelCopyWith(_ChatMemberListResponseModel value, $Res Function(_ChatMemberListResponseModel) _then) = __$ChatMemberListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, ChatMemberListData? data
});


@override $ChatMemberListDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ChatMemberListResponseModelCopyWithImpl<$Res>
    implements _$ChatMemberListResponseModelCopyWith<$Res> {
  __$ChatMemberListResponseModelCopyWithImpl(this._self, this._then);

  final _ChatMemberListResponseModel _self;
  final $Res Function(_ChatMemberListResponseModel) _then;

/// Create a copy of ChatMemberListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_ChatMemberListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatMemberListData?,
  ));
}

/// Create a copy of ChatMemberListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMemberListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ChatMemberListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ChatMemberListData {

@JsonKey(name: 'resultCount') int? get resultCount;@JsonKey(name: 'resultList') List<ChatMember>? get resultList;
/// Create a copy of ChatMemberListData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMemberListDataCopyWith<ChatMemberListData> get copyWith => _$ChatMemberListDataCopyWithImpl<ChatMemberListData>(this as ChatMemberListData, _$identity);

  /// Serializes this ChatMemberListData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMemberListData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMemberListData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMemberListData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as ChatMemberListData;
  return 'ChatMemberListData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $ChatMemberListDataCopyWith<$Res>  {
  factory $ChatMemberListDataCopyWith(ChatMemberListData value, $Res Function(ChatMemberListData) _then) = _$ChatMemberListDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<ChatMember>? resultList
});




}
/// @nodoc
class _$ChatMemberListDataCopyWithImpl<$Res>
    implements $ChatMemberListDataCopyWith<$Res> {
  _$ChatMemberListDataCopyWithImpl(this._self, this._then);

  final ChatMemberListData _self;
  final $Res Function(ChatMemberListData) _then;

/// Create a copy of ChatMemberListData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(ChatMemberListData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<ChatMember>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMemberListData].
extension ChatMemberListDataPatterns on ChatMemberListData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMemberListData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMemberListData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMemberListData value)  $default,){
final _that = this;
switch (_that) {
case _ChatMemberListData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMemberListData value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMemberListData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<ChatMember>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMemberListData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<ChatMember>? resultList)  $default,) {final _that = this;
switch (_that) {
case _ChatMemberListData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<ChatMember>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _ChatMemberListData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMemberListData implements ChatMemberListData {
  const _ChatMemberListData({@JsonKey(name: 'resultCount') this.resultCount, @JsonKey(name: 'resultList')  List<ChatMember>? resultList}): _resultList = resultList;
  factory _ChatMemberListData.fromJson(Map<String, dynamic> json) => _$ChatMemberListDataFromJson(json);

@override@JsonKey(name: 'resultCount') final  int? resultCount;
 final  List<ChatMember>? _resultList;
@override@JsonKey(name: 'resultList') List<ChatMember>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ChatMemberListData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMemberListDataCopyWith<_ChatMemberListData> get copyWith => __$ChatMemberListDataCopyWithImpl<_ChatMemberListData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMemberListDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMemberListData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'ChatMemberListData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$ChatMemberListDataCopyWith<$Res> implements $ChatMemberListDataCopyWith<$Res> {
  factory _$ChatMemberListDataCopyWith(_ChatMemberListData value, $Res Function(_ChatMemberListData) _then) = __$ChatMemberListDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<ChatMember>? resultList
});




}
/// @nodoc
class __$ChatMemberListDataCopyWithImpl<$Res>
    implements _$ChatMemberListDataCopyWith<$Res> {
  __$ChatMemberListDataCopyWithImpl(this._self, this._then);

  final _ChatMemberListData _self;
  final $Res Function(_ChatMemberListData) _then;

/// Create a copy of ChatMemberListData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_ChatMemberListData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<ChatMember>?,
  ));
}


}


/// @nodoc
mixin _$ChatMember {

 int? get id;@JsonKey(name: 'member1_id') int? get member1Id;@JsonKey(name: 'member1_matri_id') String? get member1MatriId;@JsonKey(name: 'member2_id') int? get member2Id;@JsonKey(name: 'member2_matri_id') String? get member2MatriId;@JsonKey(name: 'member1_block') bool? get member1Block;@JsonKey(name: 'member2_block') bool? get member2Block;@JsonKey(name: 'last_message_date') String? get lastMessageDate;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'deleted_at') String? get deletedAt;@JsonKey(name: 'last_message') String? get lastMessage;@JsonKey(name: 'profile_title') String? get profileTitle;@JsonKey(name: 'sub_title') String? get subTitle;@JsonKey(name: 'profile_image') String? get profileImage;@JsonKey(name: 'is_photo_protected') bool? get isPhotoProtectedBool;@JsonKey(name: 'is_shortlisted') bool? get isShortlistedBool;@JsonKey(name: 'is_interest') bool? get isInterest;@JsonKey(name: 'isBlocked') bool? get isBlocked;@JsonKey(name: 'is_online') String? get isOnline;@JsonKey(name: 'matchPercent') int? get matchPercent;
/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMemberCopyWith<ChatMember> get copyWith => _$ChatMemberCopyWithImpl<ChatMember>(this as ChatMember, _$identity);

  /// Serializes this ChatMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.member1Id, _this.member1Id) || other.member1Id == _this.member1Id)&&(identical(other.member1MatriId, _this.member1MatriId) || other.member1MatriId == _this.member1MatriId)&&(identical(other.member2Id, _this.member2Id) || other.member2Id == _this.member2Id)&&(identical(other.member2MatriId, _this.member2MatriId) || other.member2MatriId == _this.member2MatriId)&&(identical(other.member1Block, _this.member1Block) || other.member1Block == _this.member1Block)&&(identical(other.member2Block, _this.member2Block) || other.member2Block == _this.member2Block)&&(identical(other.lastMessageDate, _this.lastMessageDate) || other.lastMessageDate == _this.lastMessageDate)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.deletedAt, _this.deletedAt) || other.deletedAt == _this.deletedAt)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage)&&(identical(other.profileTitle, _this.profileTitle) || other.profileTitle == _this.profileTitle)&&(identical(other.subTitle, _this.subTitle) || other.subTitle == _this.subTitle)&&(identical(other.profileImage, _this.profileImage) || other.profileImage == _this.profileImage)&&(identical(other.isPhotoProtectedBool, _this.isPhotoProtectedBool) || other.isPhotoProtectedBool == _this.isPhotoProtectedBool)&&(identical(other.isShortlistedBool, _this.isShortlistedBool) || other.isShortlistedBool == _this.isShortlistedBool)&&(identical(other.isInterest, _this.isInterest) || other.isInterest == _this.isInterest)&&(identical(other.isBlocked, _this.isBlocked) || other.isBlocked == _this.isBlocked)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.matchPercent, _this.matchPercent) || other.matchPercent == _this.matchPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMember;
  return Object.hashAll([runtimeType,_this.id,_this.member1Id,_this.member1MatriId,_this.member2Id,_this.member2MatriId,_this.member1Block,_this.member2Block,_this.lastMessageDate,_this.createdAt,_this.updatedAt,_this.deletedAt,_this.lastMessage,_this.profileTitle,_this.subTitle,_this.profileImage,_this.isPhotoProtectedBool,_this.isShortlistedBool,_this.isInterest,_this.isBlocked,_this.isOnline,_this.matchPercent]);
}

@override
String toString() {
  final _this = this as ChatMember;
  return 'ChatMember(id: ${_this.id}, member1Id: ${_this.member1Id}, member1MatriId: ${_this.member1MatriId}, member2Id: ${_this.member2Id}, member2MatriId: ${_this.member2MatriId}, member1Block: ${_this.member1Block}, member2Block: ${_this.member2Block}, lastMessageDate: ${_this.lastMessageDate}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, deletedAt: ${_this.deletedAt}, lastMessage: ${_this.lastMessage}, profileTitle: ${_this.profileTitle}, subTitle: ${_this.subTitle}, profileImage: ${_this.profileImage}, isPhotoProtectedBool: ${_this.isPhotoProtectedBool}, isShortlistedBool: ${_this.isShortlistedBool}, isInterest: ${_this.isInterest}, isBlocked: ${_this.isBlocked}, isOnline: ${_this.isOnline}, matchPercent: ${_this.matchPercent})';
}


}

/// @nodoc
abstract mixin class $ChatMemberCopyWith<$Res>  {
  factory $ChatMemberCopyWith(ChatMember value, $Res Function(ChatMember) _then) = _$ChatMemberCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'member1_id') int? member1Id,@JsonKey(name: 'member1_matri_id') String? member1MatriId,@JsonKey(name: 'member2_id') int? member2Id,@JsonKey(name: 'member2_matri_id') String? member2MatriId,@JsonKey(name: 'member1_block') bool? member1Block,@JsonKey(name: 'member2_block') bool? member2Block,@JsonKey(name: 'last_message_date') String? lastMessageDate,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'deleted_at') String? deletedAt,@JsonKey(name: 'last_message') String? lastMessage,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'is_photo_protected') bool? isPhotoProtectedBool,@JsonKey(name: 'is_shortlisted') bool? isShortlistedBool,@JsonKey(name: 'is_interest') bool? isInterest,@JsonKey(name: 'isBlocked') bool? isBlocked,@JsonKey(name: 'is_online') String? isOnline,@JsonKey(name: 'matchPercent') int? matchPercent
});




}
/// @nodoc
class _$ChatMemberCopyWithImpl<$Res>
    implements $ChatMemberCopyWith<$Res> {
  _$ChatMemberCopyWithImpl(this._self, this._then);

  final ChatMember _self;
  final $Res Function(ChatMember) _then;

/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? member1Id = freezed,Object? member1MatriId = freezed,Object? member2Id = freezed,Object? member2MatriId = freezed,Object? member1Block = freezed,Object? member2Block = freezed,Object? lastMessageDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,Object? lastMessage = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtectedBool = freezed,Object? isShortlistedBool = freezed,Object? isInterest = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? matchPercent = freezed,}) {
  return _then(ChatMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,member1Id: freezed == member1Id ? _self.member1Id : member1Id // ignore: cast_nullable_to_non_nullable
as int?,member1MatriId: freezed == member1MatriId ? _self.member1MatriId : member1MatriId // ignore: cast_nullable_to_non_nullable
as String?,member2Id: freezed == member2Id ? _self.member2Id : member2Id // ignore: cast_nullable_to_non_nullable
as int?,member2MatriId: freezed == member2MatriId ? _self.member2MatriId : member2MatriId // ignore: cast_nullable_to_non_nullable
as String?,member1Block: freezed == member1Block ? _self.member1Block : member1Block // ignore: cast_nullable_to_non_nullable
as bool?,member2Block: freezed == member2Block ? _self.member2Block : member2Block // ignore: cast_nullable_to_non_nullable
as bool?,lastMessageDate: freezed == lastMessageDate ? _self.lastMessageDate : lastMessageDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,isPhotoProtectedBool: freezed == isPhotoProtectedBool ? _self.isPhotoProtectedBool : isPhotoProtectedBool // ignore: cast_nullable_to_non_nullable
as bool?,isShortlistedBool: freezed == isShortlistedBool ? _self.isShortlistedBool : isShortlistedBool // ignore: cast_nullable_to_non_nullable
as bool?,isInterest: freezed == isInterest ? _self.isInterest : isInterest // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as String?,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMember].
extension ChatMemberPatterns on ChatMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMember value)  $default,){
final _that = this;
switch (_that) {
case _ChatMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMember value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'member1_id')  int? member1Id, @JsonKey(name: 'member1_matri_id')  String? member1MatriId, @JsonKey(name: 'member2_id')  int? member2Id, @JsonKey(name: 'member2_matri_id')  String? member2MatriId, @JsonKey(name: 'member1_block')  bool? member1Block, @JsonKey(name: 'member2_block')  bool? member2Block, @JsonKey(name: 'last_message_date')  String? lastMessageDate, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'deleted_at')  String? deletedAt, @JsonKey(name: 'last_message')  String? lastMessage, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtectedBool, @JsonKey(name: 'is_shortlisted')  bool? isShortlistedBool, @JsonKey(name: 'is_interest')  bool? isInterest, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'matchPercent')  int? matchPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
return $default(_that.id,_that.member1Id,_that.member1MatriId,_that.member2Id,_that.member2MatriId,_that.member1Block,_that.member2Block,_that.lastMessageDate,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.lastMessage,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtectedBool,_that.isShortlistedBool,_that.isInterest,_that.isBlocked,_that.isOnline,_that.matchPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'member1_id')  int? member1Id, @JsonKey(name: 'member1_matri_id')  String? member1MatriId, @JsonKey(name: 'member2_id')  int? member2Id, @JsonKey(name: 'member2_matri_id')  String? member2MatriId, @JsonKey(name: 'member1_block')  bool? member1Block, @JsonKey(name: 'member2_block')  bool? member2Block, @JsonKey(name: 'last_message_date')  String? lastMessageDate, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'deleted_at')  String? deletedAt, @JsonKey(name: 'last_message')  String? lastMessage, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtectedBool, @JsonKey(name: 'is_shortlisted')  bool? isShortlistedBool, @JsonKey(name: 'is_interest')  bool? isInterest, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'matchPercent')  int? matchPercent)  $default,) {final _that = this;
switch (_that) {
case _ChatMember():
return $default(_that.id,_that.member1Id,_that.member1MatriId,_that.member2Id,_that.member2MatriId,_that.member1Block,_that.member2Block,_that.lastMessageDate,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.lastMessage,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtectedBool,_that.isShortlistedBool,_that.isInterest,_that.isBlocked,_that.isOnline,_that.matchPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'member1_id')  int? member1Id, @JsonKey(name: 'member1_matri_id')  String? member1MatriId, @JsonKey(name: 'member2_id')  int? member2Id, @JsonKey(name: 'member2_matri_id')  String? member2MatriId, @JsonKey(name: 'member1_block')  bool? member1Block, @JsonKey(name: 'member2_block')  bool? member2Block, @JsonKey(name: 'last_message_date')  String? lastMessageDate, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'deleted_at')  String? deletedAt, @JsonKey(name: 'last_message')  String? lastMessage, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtectedBool, @JsonKey(name: 'is_shortlisted')  bool? isShortlistedBool, @JsonKey(name: 'is_interest')  bool? isInterest, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'matchPercent')  int? matchPercent)?  $default,) {final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
return $default(_that.id,_that.member1Id,_that.member1MatriId,_that.member2Id,_that.member2MatriId,_that.member1Block,_that.member2Block,_that.lastMessageDate,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.lastMessage,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtectedBool,_that.isShortlistedBool,_that.isInterest,_that.isBlocked,_that.isOnline,_that.matchPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMember extends ChatMember {
  const _ChatMember({this.id, @JsonKey(name: 'member1_id') this.member1Id, @JsonKey(name: 'member1_matri_id') this.member1MatriId, @JsonKey(name: 'member2_id') this.member2Id, @JsonKey(name: 'member2_matri_id') this.member2MatriId, @JsonKey(name: 'member1_block') this.member1Block, @JsonKey(name: 'member2_block') this.member2Block, @JsonKey(name: 'last_message_date') this.lastMessageDate, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'deleted_at') this.deletedAt, @JsonKey(name: 'last_message') this.lastMessage, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'is_photo_protected') this.isPhotoProtectedBool, @JsonKey(name: 'is_shortlisted') this.isShortlistedBool, @JsonKey(name: 'is_interest') this.isInterest, @JsonKey(name: 'isBlocked') this.isBlocked, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'matchPercent') this.matchPercent}): super._();
  factory _ChatMember.fromJson(Map<String, dynamic> json) => _$ChatMemberFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'member1_id') final  int? member1Id;
@override@JsonKey(name: 'member1_matri_id') final  String? member1MatriId;
@override@JsonKey(name: 'member2_id') final  int? member2Id;
@override@JsonKey(name: 'member2_matri_id') final  String? member2MatriId;
@override@JsonKey(name: 'member1_block') final  bool? member1Block;
@override@JsonKey(name: 'member2_block') final  bool? member2Block;
@override@JsonKey(name: 'last_message_date') final  String? lastMessageDate;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'deleted_at') final  String? deletedAt;
@override@JsonKey(name: 'last_message') final  String? lastMessage;
@override@JsonKey(name: 'profile_title') final  String? profileTitle;
@override@JsonKey(name: 'sub_title') final  String? subTitle;
@override@JsonKey(name: 'profile_image') final  String? profileImage;
@override@JsonKey(name: 'is_photo_protected') final  bool? isPhotoProtectedBool;
@override@JsonKey(name: 'is_shortlisted') final  bool? isShortlistedBool;
@override@JsonKey(name: 'is_interest') final  bool? isInterest;
@override@JsonKey(name: 'isBlocked') final  bool? isBlocked;
@override@JsonKey(name: 'is_online') final  String? isOnline;
@override@JsonKey(name: 'matchPercent') final  int? matchPercent;

/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMemberCopyWith<_ChatMember> get copyWith => __$ChatMemberCopyWithImpl<_ChatMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMember&&(identical(other.id, id) || other.id == id)&&(identical(other.member1Id, member1Id) || other.member1Id == member1Id)&&(identical(other.member1MatriId, member1MatriId) || other.member1MatriId == member1MatriId)&&(identical(other.member2Id, member2Id) || other.member2Id == member2Id)&&(identical(other.member2MatriId, member2MatriId) || other.member2MatriId == member2MatriId)&&(identical(other.member1Block, member1Block) || other.member1Block == member1Block)&&(identical(other.member2Block, member2Block) || other.member2Block == member2Block)&&(identical(other.lastMessageDate, lastMessageDate) || other.lastMessageDate == lastMessageDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.profileTitle, profileTitle) || other.profileTitle == profileTitle)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isPhotoProtectedBool, isPhotoProtectedBool) || other.isPhotoProtectedBool == isPhotoProtectedBool)&&(identical(other.isShortlistedBool, isShortlistedBool) || other.isShortlistedBool == isShortlistedBool)&&(identical(other.isInterest, isInterest) || other.isInterest == isInterest)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.matchPercent, matchPercent) || other.matchPercent == matchPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,member1Id,member1MatriId,member2Id,member2MatriId,member1Block,member2Block,lastMessageDate,createdAt,updatedAt,deletedAt,lastMessage,profileTitle,subTitle,profileImage,isPhotoProtectedBool,isShortlistedBool,isInterest,isBlocked,isOnline,matchPercent]);
}

@override
String toString() {
    return 'ChatMember(id: $id, member1Id: $member1Id, member1MatriId: $member1MatriId, member2Id: $member2Id, member2MatriId: $member2MatriId, member1Block: $member1Block, member2Block: $member2Block, lastMessageDate: $lastMessageDate, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, lastMessage: $lastMessage, profileTitle: $profileTitle, subTitle: $subTitle, profileImage: $profileImage, isPhotoProtectedBool: $isPhotoProtectedBool, isShortlistedBool: $isShortlistedBool, isInterest: $isInterest, isBlocked: $isBlocked, isOnline: $isOnline, matchPercent: $matchPercent)';
}


}

/// @nodoc
abstract mixin class _$ChatMemberCopyWith<$Res> implements $ChatMemberCopyWith<$Res> {
  factory _$ChatMemberCopyWith(_ChatMember value, $Res Function(_ChatMember) _then) = __$ChatMemberCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'member1_id') int? member1Id,@JsonKey(name: 'member1_matri_id') String? member1MatriId,@JsonKey(name: 'member2_id') int? member2Id,@JsonKey(name: 'member2_matri_id') String? member2MatriId,@JsonKey(name: 'member1_block') bool? member1Block,@JsonKey(name: 'member2_block') bool? member2Block,@JsonKey(name: 'last_message_date') String? lastMessageDate,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'deleted_at') String? deletedAt,@JsonKey(name: 'last_message') String? lastMessage,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'is_photo_protected') bool? isPhotoProtectedBool,@JsonKey(name: 'is_shortlisted') bool? isShortlistedBool,@JsonKey(name: 'is_interest') bool? isInterest,@JsonKey(name: 'isBlocked') bool? isBlocked,@JsonKey(name: 'is_online') String? isOnline,@JsonKey(name: 'matchPercent') int? matchPercent
});




}
/// @nodoc
class __$ChatMemberCopyWithImpl<$Res>
    implements _$ChatMemberCopyWith<$Res> {
  __$ChatMemberCopyWithImpl(this._self, this._then);

  final _ChatMember _self;
  final $Res Function(_ChatMember) _then;

/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? member1Id = freezed,Object? member1MatriId = freezed,Object? member2Id = freezed,Object? member2MatriId = freezed,Object? member1Block = freezed,Object? member2Block = freezed,Object? lastMessageDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,Object? lastMessage = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtectedBool = freezed,Object? isShortlistedBool = freezed,Object? isInterest = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? matchPercent = freezed,}) {
  return _then(_ChatMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,member1Id: freezed == member1Id ? _self.member1Id : member1Id // ignore: cast_nullable_to_non_nullable
as int?,member1MatriId: freezed == member1MatriId ? _self.member1MatriId : member1MatriId // ignore: cast_nullable_to_non_nullable
as String?,member2Id: freezed == member2Id ? _self.member2Id : member2Id // ignore: cast_nullable_to_non_nullable
as int?,member2MatriId: freezed == member2MatriId ? _self.member2MatriId : member2MatriId // ignore: cast_nullable_to_non_nullable
as String?,member1Block: freezed == member1Block ? _self.member1Block : member1Block // ignore: cast_nullable_to_non_nullable
as bool?,member2Block: freezed == member2Block ? _self.member2Block : member2Block // ignore: cast_nullable_to_non_nullable
as bool?,lastMessageDate: freezed == lastMessageDate ? _self.lastMessageDate : lastMessageDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,isPhotoProtectedBool: freezed == isPhotoProtectedBool ? _self.isPhotoProtectedBool : isPhotoProtectedBool // ignore: cast_nullable_to_non_nullable
as bool?,isShortlistedBool: freezed == isShortlistedBool ? _self.isShortlistedBool : isShortlistedBool // ignore: cast_nullable_to_non_nullable
as bool?,isInterest: freezed == isInterest ? _self.isInterest : isInterest // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as String?,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ChatConversationListResponseModel {

 int? get code; String? get status; String? get message; ChatConversationData? get data;
/// Create a copy of ChatConversationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatConversationListResponseModelCopyWith<ChatConversationListResponseModel> get copyWith => _$ChatConversationListResponseModelCopyWithImpl<ChatConversationListResponseModel>(this as ChatConversationListResponseModel, _$identity);

  /// Serializes this ChatConversationListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatConversationListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatConversationListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatConversationListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as ChatConversationListResponseModel;
  return 'ChatConversationListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ChatConversationListResponseModelCopyWith<$Res>  {
  factory $ChatConversationListResponseModelCopyWith(ChatConversationListResponseModel value, $Res Function(ChatConversationListResponseModel) _then) = _$ChatConversationListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, ChatConversationData? data
});


$ChatConversationDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ChatConversationListResponseModelCopyWithImpl<$Res>
    implements $ChatConversationListResponseModelCopyWith<$Res> {
  _$ChatConversationListResponseModelCopyWithImpl(this._self, this._then);

  final ChatConversationListResponseModel _self;
  final $Res Function(ChatConversationListResponseModel) _then;

/// Create a copy of ChatConversationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(ChatConversationListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatConversationData?,
  ));
}
/// Create a copy of ChatConversationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConversationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ChatConversationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatConversationListResponseModel].
extension ChatConversationListResponseModelPatterns on ChatConversationListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatConversationListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatConversationListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatConversationListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatConversationListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatConversationListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatConversationListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ChatConversationData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatConversationListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ChatConversationData? data)  $default,) {final _that = this;
switch (_that) {
case _ChatConversationListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  ChatConversationData? data)?  $default,) {final _that = this;
switch (_that) {
case _ChatConversationListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatConversationListResponseModel implements ChatConversationListResponseModel {
  const _ChatConversationListResponseModel({this.code, this.status, this.message, this.data});
  factory _ChatConversationListResponseModel.fromJson(Map<String, dynamic> json) => _$ChatConversationListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  ChatConversationData? data;

/// Create a copy of ChatConversationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatConversationListResponseModelCopyWith<_ChatConversationListResponseModel> get copyWith => __$ChatConversationListResponseModelCopyWithImpl<_ChatConversationListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatConversationListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatConversationListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'ChatConversationListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ChatConversationListResponseModelCopyWith<$Res> implements $ChatConversationListResponseModelCopyWith<$Res> {
  factory _$ChatConversationListResponseModelCopyWith(_ChatConversationListResponseModel value, $Res Function(_ChatConversationListResponseModel) _then) = __$ChatConversationListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, ChatConversationData? data
});


@override $ChatConversationDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ChatConversationListResponseModelCopyWithImpl<$Res>
    implements _$ChatConversationListResponseModelCopyWith<$Res> {
  __$ChatConversationListResponseModelCopyWithImpl(this._self, this._then);

  final _ChatConversationListResponseModel _self;
  final $Res Function(_ChatConversationListResponseModel) _then;

/// Create a copy of ChatConversationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_ChatConversationListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatConversationData?,
  ));
}

/// Create a copy of ChatConversationListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConversationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ChatConversationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ChatConversationData {

@JsonKey(name: 'conversation_id') dynamic get conversationId;@JsonKey(name: 'profile_title') String? get profileTitle;@JsonKey(name: 'sub_title') String? get subTitle;@JsonKey(name: 'profile_image') String? get profileImage;@JsonKey(name: 'is_photo_protected') bool? get isPhotoProtectedBool;@JsonKey(name: 'isBlocked') bool? get isBlocked;@JsonKey(name: 'is_online') String? get isOnline;@JsonKey(name: 'is_online_text') String? get isOnlineText;@JsonKey(name: 'message_list_count') int? get messageListCount;@JsonKey(name: 'message_list') List<ChatMessage>? get messageList;@JsonKey(name: 'sender_member_id') dynamic get senderMemberId;@JsonKey(name: 'sender_member_matri_id') String? get senderMemberMatriId;@JsonKey(name: 'sender_member_photo_url') String? get senderMemberPhotoUrl;@JsonKey(name: 'sender_member_gender') String? get senderMemberGender;@JsonKey(name: 'receiver_member_id') dynamic get receiverMemberId;@JsonKey(name: 'sender_block') dynamic get senderBlock;@JsonKey(name: 'receiver_member_fullname') String? get receiverMemberFullname;@JsonKey(name: 'receiver_member_gender') String? get receiverMemberGender;@JsonKey(name: 'receiver_block') dynamic get receiverBlock;@JsonKey(name: 'is_block') int? get isBlock;@JsonKey(name: 'request_status') String? get requestStatus;@JsonKey(name: 'requested_by') dynamic get requestedBy;@JsonKey(name: 'is_chat_blocked') bool? get isChatBlocked;
/// Create a copy of ChatConversationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatConversationDataCopyWith<ChatConversationData> get copyWith => _$ChatConversationDataCopyWithImpl<ChatConversationData>(this as ChatConversationData, _$identity);

  /// Serializes this ChatConversationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatConversationData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatConversationData&&const DeepCollectionEquality().equals(other.conversationId, _this.conversationId)&&(identical(other.profileTitle, _this.profileTitle) || other.profileTitle == _this.profileTitle)&&(identical(other.subTitle, _this.subTitle) || other.subTitle == _this.subTitle)&&(identical(other.profileImage, _this.profileImage) || other.profileImage == _this.profileImage)&&(identical(other.isPhotoProtectedBool, _this.isPhotoProtectedBool) || other.isPhotoProtectedBool == _this.isPhotoProtectedBool)&&(identical(other.isBlocked, _this.isBlocked) || other.isBlocked == _this.isBlocked)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.isOnlineText, _this.isOnlineText) || other.isOnlineText == _this.isOnlineText)&&(identical(other.messageListCount, _this.messageListCount) || other.messageListCount == _this.messageListCount)&&const DeepCollectionEquality().equals(other.messageList, _this.messageList)&&const DeepCollectionEquality().equals(other.senderMemberId, _this.senderMemberId)&&(identical(other.senderMemberMatriId, _this.senderMemberMatriId) || other.senderMemberMatriId == _this.senderMemberMatriId)&&(identical(other.senderMemberPhotoUrl, _this.senderMemberPhotoUrl) || other.senderMemberPhotoUrl == _this.senderMemberPhotoUrl)&&(identical(other.senderMemberGender, _this.senderMemberGender) || other.senderMemberGender == _this.senderMemberGender)&&const DeepCollectionEquality().equals(other.receiverMemberId, _this.receiverMemberId)&&const DeepCollectionEquality().equals(other.senderBlock, _this.senderBlock)&&(identical(other.receiverMemberFullname, _this.receiverMemberFullname) || other.receiverMemberFullname == _this.receiverMemberFullname)&&(identical(other.receiverMemberGender, _this.receiverMemberGender) || other.receiverMemberGender == _this.receiverMemberGender)&&const DeepCollectionEquality().equals(other.receiverBlock, _this.receiverBlock)&&(identical(other.isBlock, _this.isBlock) || other.isBlock == _this.isBlock)&&(identical(other.requestStatus, _this.requestStatus) || other.requestStatus == _this.requestStatus)&&const DeepCollectionEquality().equals(other.requestedBy, _this.requestedBy)&&(identical(other.isChatBlocked, _this.isChatBlocked) || other.isChatBlocked == _this.isChatBlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatConversationData;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.conversationId),_this.profileTitle,_this.subTitle,_this.profileImage,_this.isPhotoProtectedBool,_this.isBlocked,_this.isOnline,_this.isOnlineText,_this.messageListCount,const DeepCollectionEquality().hash(_this.messageList),const DeepCollectionEquality().hash(_this.senderMemberId),_this.senderMemberMatriId,_this.senderMemberPhotoUrl,_this.senderMemberGender,const DeepCollectionEquality().hash(_this.receiverMemberId),const DeepCollectionEquality().hash(_this.senderBlock),_this.receiverMemberFullname,_this.receiverMemberGender,const DeepCollectionEquality().hash(_this.receiverBlock),_this.isBlock,_this.requestStatus,const DeepCollectionEquality().hash(_this.requestedBy),_this.isChatBlocked]);
}

@override
String toString() {
  final _this = this as ChatConversationData;
  return 'ChatConversationData(conversationId: ${_this.conversationId}, profileTitle: ${_this.profileTitle}, subTitle: ${_this.subTitle}, profileImage: ${_this.profileImage}, isPhotoProtectedBool: ${_this.isPhotoProtectedBool}, isBlocked: ${_this.isBlocked}, isOnline: ${_this.isOnline}, isOnlineText: ${_this.isOnlineText}, messageListCount: ${_this.messageListCount}, messageList: ${_this.messageList}, senderMemberId: ${_this.senderMemberId}, senderMemberMatriId: ${_this.senderMemberMatriId}, senderMemberPhotoUrl: ${_this.senderMemberPhotoUrl}, senderMemberGender: ${_this.senderMemberGender}, receiverMemberId: ${_this.receiverMemberId}, senderBlock: ${_this.senderBlock}, receiverMemberFullname: ${_this.receiverMemberFullname}, receiverMemberGender: ${_this.receiverMemberGender}, receiverBlock: ${_this.receiverBlock}, isBlock: ${_this.isBlock}, requestStatus: ${_this.requestStatus}, requestedBy: ${_this.requestedBy}, isChatBlocked: ${_this.isChatBlocked})';
}


}

/// @nodoc
abstract mixin class $ChatConversationDataCopyWith<$Res>  {
  factory $ChatConversationDataCopyWith(ChatConversationData value, $Res Function(ChatConversationData) _then) = _$ChatConversationDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'conversation_id') dynamic conversationId,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'is_photo_protected') bool? isPhotoProtectedBool,@JsonKey(name: 'isBlocked') bool? isBlocked,@JsonKey(name: 'is_online') String? isOnline,@JsonKey(name: 'is_online_text') String? isOnlineText,@JsonKey(name: 'message_list_count') int? messageListCount,@JsonKey(name: 'message_list') List<ChatMessage>? messageList,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'sender_member_matri_id') String? senderMemberMatriId,@JsonKey(name: 'sender_member_photo_url') String? senderMemberPhotoUrl,@JsonKey(name: 'sender_member_gender') String? senderMemberGender,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'sender_block') dynamic senderBlock,@JsonKey(name: 'receiver_member_fullname') String? receiverMemberFullname,@JsonKey(name: 'receiver_member_gender') String? receiverMemberGender,@JsonKey(name: 'receiver_block') dynamic receiverBlock,@JsonKey(name: 'is_block') int? isBlock,@JsonKey(name: 'request_status') String? requestStatus,@JsonKey(name: 'requested_by') dynamic requestedBy,@JsonKey(name: 'is_chat_blocked') bool? isChatBlocked
});




}
/// @nodoc
class _$ChatConversationDataCopyWithImpl<$Res>
    implements $ChatConversationDataCopyWith<$Res> {
  _$ChatConversationDataCopyWithImpl(this._self, this._then);

  final ChatConversationData _self;
  final $Res Function(ChatConversationData) _then;

/// Create a copy of ChatConversationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtectedBool = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? isOnlineText = freezed,Object? messageListCount = freezed,Object? messageList = freezed,Object? senderMemberId = freezed,Object? senderMemberMatriId = freezed,Object? senderMemberPhotoUrl = freezed,Object? senderMemberGender = freezed,Object? receiverMemberId = freezed,Object? senderBlock = freezed,Object? receiverMemberFullname = freezed,Object? receiverMemberGender = freezed,Object? receiverBlock = freezed,Object? isBlock = freezed,Object? requestStatus = freezed,Object? requestedBy = freezed,Object? isChatBlocked = freezed,}) {
  return _then(ChatConversationData(
conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,isPhotoProtectedBool: freezed == isPhotoProtectedBool ? _self.isPhotoProtectedBool : isPhotoProtectedBool // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as String?,isOnlineText: freezed == isOnlineText ? _self.isOnlineText : isOnlineText // ignore: cast_nullable_to_non_nullable
as String?,messageListCount: freezed == messageListCount ? _self.messageListCount : messageListCount // ignore: cast_nullable_to_non_nullable
as int?,messageList: freezed == messageList ? _self.messageList : messageList // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>?,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberMatriId: freezed == senderMemberMatriId ? _self.senderMemberMatriId : senderMemberMatriId // ignore: cast_nullable_to_non_nullable
as String?,senderMemberPhotoUrl: freezed == senderMemberPhotoUrl ? _self.senderMemberPhotoUrl : senderMemberPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,senderMemberGender: freezed == senderMemberGender ? _self.senderMemberGender : senderMemberGender // ignore: cast_nullable_to_non_nullable
as String?,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderBlock: freezed == senderBlock ? _self.senderBlock : senderBlock // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberFullname: freezed == receiverMemberFullname ? _self.receiverMemberFullname : receiverMemberFullname // ignore: cast_nullable_to_non_nullable
as String?,receiverMemberGender: freezed == receiverMemberGender ? _self.receiverMemberGender : receiverMemberGender // ignore: cast_nullable_to_non_nullable
as String?,receiverBlock: freezed == receiverBlock ? _self.receiverBlock : receiverBlock // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as int?,requestStatus: freezed == requestStatus ? _self.requestStatus : requestStatus // ignore: cast_nullable_to_non_nullable
as String?,requestedBy: freezed == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as dynamic,isChatBlocked: freezed == isChatBlocked ? _self.isChatBlocked : isChatBlocked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatConversationData].
extension ChatConversationDataPatterns on ChatConversationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatConversationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatConversationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatConversationData value)  $default,){
final _that = this;
switch (_that) {
case _ChatConversationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatConversationData value)?  $default,){
final _that = this;
switch (_that) {
case _ChatConversationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'conversation_id')  dynamic conversationId, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtectedBool, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'is_online_text')  String? isOnlineText, @JsonKey(name: 'message_list_count')  int? messageListCount, @JsonKey(name: 'message_list')  List<ChatMessage>? messageList, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'sender_member_matri_id')  String? senderMemberMatriId, @JsonKey(name: 'sender_member_photo_url')  String? senderMemberPhotoUrl, @JsonKey(name: 'sender_member_gender')  String? senderMemberGender, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'sender_block')  dynamic senderBlock, @JsonKey(name: 'receiver_member_fullname')  String? receiverMemberFullname, @JsonKey(name: 'receiver_member_gender')  String? receiverMemberGender, @JsonKey(name: 'receiver_block')  dynamic receiverBlock, @JsonKey(name: 'is_block')  int? isBlock, @JsonKey(name: 'request_status')  String? requestStatus, @JsonKey(name: 'requested_by')  dynamic requestedBy, @JsonKey(name: 'is_chat_blocked')  bool? isChatBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatConversationData() when $default != null:
return $default(_that.conversationId,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtectedBool,_that.isBlocked,_that.isOnline,_that.isOnlineText,_that.messageListCount,_that.messageList,_that.senderMemberId,_that.senderMemberMatriId,_that.senderMemberPhotoUrl,_that.senderMemberGender,_that.receiverMemberId,_that.senderBlock,_that.receiverMemberFullname,_that.receiverMemberGender,_that.receiverBlock,_that.isBlock,_that.requestStatus,_that.requestedBy,_that.isChatBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'conversation_id')  dynamic conversationId, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtectedBool, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'is_online_text')  String? isOnlineText, @JsonKey(name: 'message_list_count')  int? messageListCount, @JsonKey(name: 'message_list')  List<ChatMessage>? messageList, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'sender_member_matri_id')  String? senderMemberMatriId, @JsonKey(name: 'sender_member_photo_url')  String? senderMemberPhotoUrl, @JsonKey(name: 'sender_member_gender')  String? senderMemberGender, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'sender_block')  dynamic senderBlock, @JsonKey(name: 'receiver_member_fullname')  String? receiverMemberFullname, @JsonKey(name: 'receiver_member_gender')  String? receiverMemberGender, @JsonKey(name: 'receiver_block')  dynamic receiverBlock, @JsonKey(name: 'is_block')  int? isBlock, @JsonKey(name: 'request_status')  String? requestStatus, @JsonKey(name: 'requested_by')  dynamic requestedBy, @JsonKey(name: 'is_chat_blocked')  bool? isChatBlocked)  $default,) {final _that = this;
switch (_that) {
case _ChatConversationData():
return $default(_that.conversationId,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtectedBool,_that.isBlocked,_that.isOnline,_that.isOnlineText,_that.messageListCount,_that.messageList,_that.senderMemberId,_that.senderMemberMatriId,_that.senderMemberPhotoUrl,_that.senderMemberGender,_that.receiverMemberId,_that.senderBlock,_that.receiverMemberFullname,_that.receiverMemberGender,_that.receiverBlock,_that.isBlock,_that.requestStatus,_that.requestedBy,_that.isChatBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'conversation_id')  dynamic conversationId, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtectedBool, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'is_online_text')  String? isOnlineText, @JsonKey(name: 'message_list_count')  int? messageListCount, @JsonKey(name: 'message_list')  List<ChatMessage>? messageList, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'sender_member_matri_id')  String? senderMemberMatriId, @JsonKey(name: 'sender_member_photo_url')  String? senderMemberPhotoUrl, @JsonKey(name: 'sender_member_gender')  String? senderMemberGender, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'sender_block')  dynamic senderBlock, @JsonKey(name: 'receiver_member_fullname')  String? receiverMemberFullname, @JsonKey(name: 'receiver_member_gender')  String? receiverMemberGender, @JsonKey(name: 'receiver_block')  dynamic receiverBlock, @JsonKey(name: 'is_block')  int? isBlock, @JsonKey(name: 'request_status')  String? requestStatus, @JsonKey(name: 'requested_by')  dynamic requestedBy, @JsonKey(name: 'is_chat_blocked')  bool? isChatBlocked)?  $default,) {final _that = this;
switch (_that) {
case _ChatConversationData() when $default != null:
return $default(_that.conversationId,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtectedBool,_that.isBlocked,_that.isOnline,_that.isOnlineText,_that.messageListCount,_that.messageList,_that.senderMemberId,_that.senderMemberMatriId,_that.senderMemberPhotoUrl,_that.senderMemberGender,_that.receiverMemberId,_that.senderBlock,_that.receiverMemberFullname,_that.receiverMemberGender,_that.receiverBlock,_that.isBlock,_that.requestStatus,_that.requestedBy,_that.isChatBlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatConversationData extends ChatConversationData {
  const _ChatConversationData({@JsonKey(name: 'conversation_id') this.conversationId, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'is_photo_protected') this.isPhotoProtectedBool, @JsonKey(name: 'isBlocked') this.isBlocked, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'is_online_text') this.isOnlineText, @JsonKey(name: 'message_list_count') this.messageListCount, @JsonKey(name: 'message_list')  List<ChatMessage>? messageList, @JsonKey(name: 'sender_member_id') this.senderMemberId, @JsonKey(name: 'sender_member_matri_id') this.senderMemberMatriId, @JsonKey(name: 'sender_member_photo_url') this.senderMemberPhotoUrl, @JsonKey(name: 'sender_member_gender') this.senderMemberGender, @JsonKey(name: 'receiver_member_id') this.receiverMemberId, @JsonKey(name: 'sender_block') this.senderBlock, @JsonKey(name: 'receiver_member_fullname') this.receiverMemberFullname, @JsonKey(name: 'receiver_member_gender') this.receiverMemberGender, @JsonKey(name: 'receiver_block') this.receiverBlock, @JsonKey(name: 'is_block') this.isBlock, @JsonKey(name: 'request_status') this.requestStatus, @JsonKey(name: 'requested_by') this.requestedBy, @JsonKey(name: 'is_chat_blocked') this.isChatBlocked}): _messageList = messageList,super._();
  factory _ChatConversationData.fromJson(Map<String, dynamic> json) => _$ChatConversationDataFromJson(json);

@override@JsonKey(name: 'conversation_id') final  dynamic conversationId;
@override@JsonKey(name: 'profile_title') final  String? profileTitle;
@override@JsonKey(name: 'sub_title') final  String? subTitle;
@override@JsonKey(name: 'profile_image') final  String? profileImage;
@override@JsonKey(name: 'is_photo_protected') final  bool? isPhotoProtectedBool;
@override@JsonKey(name: 'isBlocked') final  bool? isBlocked;
@override@JsonKey(name: 'is_online') final  String? isOnline;
@override@JsonKey(name: 'is_online_text') final  String? isOnlineText;
@override@JsonKey(name: 'message_list_count') final  int? messageListCount;
 final  List<ChatMessage>? _messageList;
@override@JsonKey(name: 'message_list') List<ChatMessage>? get messageList {
  final value = _messageList;
  if (value == null) return null;
  if (_messageList is EqualUnmodifiableListView) return _messageList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'sender_member_id') final  dynamic senderMemberId;
@override@JsonKey(name: 'sender_member_matri_id') final  String? senderMemberMatriId;
@override@JsonKey(name: 'sender_member_photo_url') final  String? senderMemberPhotoUrl;
@override@JsonKey(name: 'sender_member_gender') final  String? senderMemberGender;
@override@JsonKey(name: 'receiver_member_id') final  dynamic receiverMemberId;
@override@JsonKey(name: 'sender_block') final  dynamic senderBlock;
@override@JsonKey(name: 'receiver_member_fullname') final  String? receiverMemberFullname;
@override@JsonKey(name: 'receiver_member_gender') final  String? receiverMemberGender;
@override@JsonKey(name: 'receiver_block') final  dynamic receiverBlock;
@override@JsonKey(name: 'is_block') final  int? isBlock;
@override@JsonKey(name: 'request_status') final  String? requestStatus;
@override@JsonKey(name: 'requested_by') final  dynamic requestedBy;
@override@JsonKey(name: 'is_chat_blocked') final  bool? isChatBlocked;

/// Create a copy of ChatConversationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatConversationDataCopyWith<_ChatConversationData> get copyWith => __$ChatConversationDataCopyWithImpl<_ChatConversationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatConversationDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatConversationData&&const DeepCollectionEquality().equals(other.conversationId, conversationId)&&(identical(other.profileTitle, profileTitle) || other.profileTitle == profileTitle)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isPhotoProtectedBool, isPhotoProtectedBool) || other.isPhotoProtectedBool == isPhotoProtectedBool)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isOnlineText, isOnlineText) || other.isOnlineText == isOnlineText)&&(identical(other.messageListCount, messageListCount) || other.messageListCount == messageListCount)&&const DeepCollectionEquality().equals(other.messageList, _messageList)&&const DeepCollectionEquality().equals(other.senderMemberId, senderMemberId)&&(identical(other.senderMemberMatriId, senderMemberMatriId) || other.senderMemberMatriId == senderMemberMatriId)&&(identical(other.senderMemberPhotoUrl, senderMemberPhotoUrl) || other.senderMemberPhotoUrl == senderMemberPhotoUrl)&&(identical(other.senderMemberGender, senderMemberGender) || other.senderMemberGender == senderMemberGender)&&const DeepCollectionEquality().equals(other.receiverMemberId, receiverMemberId)&&const DeepCollectionEquality().equals(other.senderBlock, senderBlock)&&(identical(other.receiverMemberFullname, receiverMemberFullname) || other.receiverMemberFullname == receiverMemberFullname)&&(identical(other.receiverMemberGender, receiverMemberGender) || other.receiverMemberGender == receiverMemberGender)&&const DeepCollectionEquality().equals(other.receiverBlock, receiverBlock)&&(identical(other.isBlock, isBlock) || other.isBlock == isBlock)&&(identical(other.requestStatus, requestStatus) || other.requestStatus == requestStatus)&&const DeepCollectionEquality().equals(other.requestedBy, requestedBy)&&(identical(other.isChatBlocked, isChatBlocked) || other.isChatBlocked == isChatBlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(conversationId),profileTitle,subTitle,profileImage,isPhotoProtectedBool,isBlocked,isOnline,isOnlineText,messageListCount,const DeepCollectionEquality().hash(_messageList),const DeepCollectionEquality().hash(senderMemberId),senderMemberMatriId,senderMemberPhotoUrl,senderMemberGender,const DeepCollectionEquality().hash(receiverMemberId),const DeepCollectionEquality().hash(senderBlock),receiverMemberFullname,receiverMemberGender,const DeepCollectionEquality().hash(receiverBlock),isBlock,requestStatus,const DeepCollectionEquality().hash(requestedBy),isChatBlocked]);
}

@override
String toString() {
    return 'ChatConversationData(conversationId: $conversationId, profileTitle: $profileTitle, subTitle: $subTitle, profileImage: $profileImage, isPhotoProtectedBool: $isPhotoProtectedBool, isBlocked: $isBlocked, isOnline: $isOnline, isOnlineText: $isOnlineText, messageListCount: $messageListCount, messageList: $messageList, senderMemberId: $senderMemberId, senderMemberMatriId: $senderMemberMatriId, senderMemberPhotoUrl: $senderMemberPhotoUrl, senderMemberGender: $senderMemberGender, receiverMemberId: $receiverMemberId, senderBlock: $senderBlock, receiverMemberFullname: $receiverMemberFullname, receiverMemberGender: $receiverMemberGender, receiverBlock: $receiverBlock, isBlock: $isBlock, requestStatus: $requestStatus, requestedBy: $requestedBy, isChatBlocked: $isChatBlocked)';
}


}

/// @nodoc
abstract mixin class _$ChatConversationDataCopyWith<$Res> implements $ChatConversationDataCopyWith<$Res> {
  factory _$ChatConversationDataCopyWith(_ChatConversationData value, $Res Function(_ChatConversationData) _then) = __$ChatConversationDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'conversation_id') dynamic conversationId,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'is_photo_protected') bool? isPhotoProtectedBool,@JsonKey(name: 'isBlocked') bool? isBlocked,@JsonKey(name: 'is_online') String? isOnline,@JsonKey(name: 'is_online_text') String? isOnlineText,@JsonKey(name: 'message_list_count') int? messageListCount,@JsonKey(name: 'message_list') List<ChatMessage>? messageList,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'sender_member_matri_id') String? senderMemberMatriId,@JsonKey(name: 'sender_member_photo_url') String? senderMemberPhotoUrl,@JsonKey(name: 'sender_member_gender') String? senderMemberGender,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'sender_block') dynamic senderBlock,@JsonKey(name: 'receiver_member_fullname') String? receiverMemberFullname,@JsonKey(name: 'receiver_member_gender') String? receiverMemberGender,@JsonKey(name: 'receiver_block') dynamic receiverBlock,@JsonKey(name: 'is_block') int? isBlock,@JsonKey(name: 'request_status') String? requestStatus,@JsonKey(name: 'requested_by') dynamic requestedBy,@JsonKey(name: 'is_chat_blocked') bool? isChatBlocked
});




}
/// @nodoc
class __$ChatConversationDataCopyWithImpl<$Res>
    implements _$ChatConversationDataCopyWith<$Res> {
  __$ChatConversationDataCopyWithImpl(this._self, this._then);

  final _ChatConversationData _self;
  final $Res Function(_ChatConversationData) _then;

/// Create a copy of ChatConversationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtectedBool = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? isOnlineText = freezed,Object? messageListCount = freezed,Object? messageList = freezed,Object? senderMemberId = freezed,Object? senderMemberMatriId = freezed,Object? senderMemberPhotoUrl = freezed,Object? senderMemberGender = freezed,Object? receiverMemberId = freezed,Object? senderBlock = freezed,Object? receiverMemberFullname = freezed,Object? receiverMemberGender = freezed,Object? receiverBlock = freezed,Object? isBlock = freezed,Object? requestStatus = freezed,Object? requestedBy = freezed,Object? isChatBlocked = freezed,}) {
  return _then(_ChatConversationData(
conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as dynamic,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,isPhotoProtectedBool: freezed == isPhotoProtectedBool ? _self.isPhotoProtectedBool : isPhotoProtectedBool // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as String?,isOnlineText: freezed == isOnlineText ? _self.isOnlineText : isOnlineText // ignore: cast_nullable_to_non_nullable
as String?,messageListCount: freezed == messageListCount ? _self.messageListCount : messageListCount // ignore: cast_nullable_to_non_nullable
as int?,messageList: freezed == messageList ? _self._messageList : messageList // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>?,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberMatriId: freezed == senderMemberMatriId ? _self.senderMemberMatriId : senderMemberMatriId // ignore: cast_nullable_to_non_nullable
as String?,senderMemberPhotoUrl: freezed == senderMemberPhotoUrl ? _self.senderMemberPhotoUrl : senderMemberPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,senderMemberGender: freezed == senderMemberGender ? _self.senderMemberGender : senderMemberGender // ignore: cast_nullable_to_non_nullable
as String?,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderBlock: freezed == senderBlock ? _self.senderBlock : senderBlock // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberFullname: freezed == receiverMemberFullname ? _self.receiverMemberFullname : receiverMemberFullname // ignore: cast_nullable_to_non_nullable
as String?,receiverMemberGender: freezed == receiverMemberGender ? _self.receiverMemberGender : receiverMemberGender // ignore: cast_nullable_to_non_nullable
as String?,receiverBlock: freezed == receiverBlock ? _self.receiverBlock : receiverBlock // ignore: cast_nullable_to_non_nullable
as dynamic,isBlock: freezed == isBlock ? _self.isBlock : isBlock // ignore: cast_nullable_to_non_nullable
as int?,requestStatus: freezed == requestStatus ? _self.requestStatus : requestStatus // ignore: cast_nullable_to_non_nullable
as String?,requestedBy: freezed == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as dynamic,isChatBlocked: freezed == isChatBlocked ? _self.isChatBlocked : isChatBlocked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ChatMessage {

 dynamic get id;@JsonKey(name: 'conversation_id') dynamic get conversationId;@JsonKey(name: 'sender_member_id') dynamic get senderMemberId;@JsonKey(name: 'sender_member_matri_id') String? get senderMemberMatriId;@JsonKey(name: 'receiver_member_id') dynamic get receiverMemberId;@JsonKey(name: 'receiver_member_matri_id') String? get receiverMemberMatriId; String? get message;@JsonKey(name: 'is_read') String? get isRead;@JsonKey(name: 'blocked_member_id') dynamic get blockedMemberId;@JsonKey(name: 'send_on') String? get sendOn;@JsonKey(name: 'is_deleted') String? get isDeleted;@JsonKey(name: 'is_sender') bool? get isSender;@JsonKey(name: 'is_receiver') bool? get isReceiver;@JsonKey(name: 'chat_status') int? get chatStatus;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.conversationId, _this.conversationId)&&const DeepCollectionEquality().equals(other.senderMemberId, _this.senderMemberId)&&(identical(other.senderMemberMatriId, _this.senderMemberMatriId) || other.senderMemberMatriId == _this.senderMemberMatriId)&&const DeepCollectionEquality().equals(other.receiverMemberId, _this.receiverMemberId)&&(identical(other.receiverMemberMatriId, _this.receiverMemberMatriId) || other.receiverMemberMatriId == _this.receiverMemberMatriId)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.isRead, _this.isRead) || other.isRead == _this.isRead)&&const DeepCollectionEquality().equals(other.blockedMemberId, _this.blockedMemberId)&&(identical(other.sendOn, _this.sendOn) || other.sendOn == _this.sendOn)&&(identical(other.isDeleted, _this.isDeleted) || other.isDeleted == _this.isDeleted)&&(identical(other.isSender, _this.isSender) || other.isSender == _this.isSender)&&(identical(other.isReceiver, _this.isReceiver) || other.isReceiver == _this.isReceiver)&&(identical(other.chatStatus, _this.chatStatus) || other.chatStatus == _this.chatStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.conversationId),const DeepCollectionEquality().hash(_this.senderMemberId),_this.senderMemberMatriId,const DeepCollectionEquality().hash(_this.receiverMemberId),_this.receiverMemberMatriId,_this.message,_this.isRead,const DeepCollectionEquality().hash(_this.blockedMemberId),_this.sendOn,_this.isDeleted,_this.isSender,_this.isReceiver,_this.chatStatus);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(id: ${_this.id}, conversationId: ${_this.conversationId}, senderMemberId: ${_this.senderMemberId}, senderMemberMatriId: ${_this.senderMemberMatriId}, receiverMemberId: ${_this.receiverMemberId}, receiverMemberMatriId: ${_this.receiverMemberMatriId}, message: ${_this.message}, isRead: ${_this.isRead}, blockedMemberId: ${_this.blockedMemberId}, sendOn: ${_this.sendOn}, isDeleted: ${_this.isDeleted}, isSender: ${_this.isSender}, isReceiver: ${_this.isReceiver}, chatStatus: ${_this.chatStatus})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'conversation_id') dynamic conversationId,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'sender_member_matri_id') String? senderMemberMatriId,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'receiver_member_matri_id') String? receiverMemberMatriId, String? message,@JsonKey(name: 'is_read') String? isRead,@JsonKey(name: 'blocked_member_id') dynamic blockedMemberId,@JsonKey(name: 'send_on') String? sendOn,@JsonKey(name: 'is_deleted') String? isDeleted,@JsonKey(name: 'is_sender') bool? isSender,@JsonKey(name: 'is_receiver') bool? isReceiver,@JsonKey(name: 'chat_status') int? chatStatus
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? conversationId = freezed,Object? senderMemberId = freezed,Object? senderMemberMatriId = freezed,Object? receiverMemberId = freezed,Object? receiverMemberMatriId = freezed,Object? message = freezed,Object? isRead = freezed,Object? blockedMemberId = freezed,Object? sendOn = freezed,Object? isDeleted = freezed,Object? isSender = freezed,Object? isReceiver = freezed,Object? chatStatus = freezed,}) {
  return _then(ChatMessage(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberMatriId: freezed == senderMemberMatriId ? _self.senderMemberMatriId : senderMemberMatriId // ignore: cast_nullable_to_non_nullable
as String?,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberMatriId: freezed == receiverMemberMatriId ? _self.receiverMemberMatriId : receiverMemberMatriId // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as String?,blockedMemberId: freezed == blockedMemberId ? _self.blockedMemberId : blockedMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,sendOn: freezed == sendOn ? _self.sendOn : sendOn // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as String?,isSender: freezed == isSender ? _self.isSender : isSender // ignore: cast_nullable_to_non_nullable
as bool?,isReceiver: freezed == isReceiver ? _self.isReceiver : isReceiver // ignore: cast_nullable_to_non_nullable
as bool?,chatStatus: freezed == chatStatus ? _self.chatStatus : chatStatus // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'conversation_id')  dynamic conversationId, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'sender_member_matri_id')  String? senderMemberMatriId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'receiver_member_matri_id')  String? receiverMemberMatriId,  String? message, @JsonKey(name: 'is_read')  String? isRead, @JsonKey(name: 'blocked_member_id')  dynamic blockedMemberId, @JsonKey(name: 'send_on')  String? sendOn, @JsonKey(name: 'is_deleted')  String? isDeleted, @JsonKey(name: 'is_sender')  bool? isSender, @JsonKey(name: 'is_receiver')  bool? isReceiver, @JsonKey(name: 'chat_status')  int? chatStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderMemberId,_that.senderMemberMatriId,_that.receiverMemberId,_that.receiverMemberMatriId,_that.message,_that.isRead,_that.blockedMemberId,_that.sendOn,_that.isDeleted,_that.isSender,_that.isReceiver,_that.chatStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'conversation_id')  dynamic conversationId, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'sender_member_matri_id')  String? senderMemberMatriId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'receiver_member_matri_id')  String? receiverMemberMatriId,  String? message, @JsonKey(name: 'is_read')  String? isRead, @JsonKey(name: 'blocked_member_id')  dynamic blockedMemberId, @JsonKey(name: 'send_on')  String? sendOn, @JsonKey(name: 'is_deleted')  String? isDeleted, @JsonKey(name: 'is_sender')  bool? isSender, @JsonKey(name: 'is_receiver')  bool? isReceiver, @JsonKey(name: 'chat_status')  int? chatStatus)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.conversationId,_that.senderMemberId,_that.senderMemberMatriId,_that.receiverMemberId,_that.receiverMemberMatriId,_that.message,_that.isRead,_that.blockedMemberId,_that.sendOn,_that.isDeleted,_that.isSender,_that.isReceiver,_that.chatStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'conversation_id')  dynamic conversationId, @JsonKey(name: 'sender_member_id')  dynamic senderMemberId, @JsonKey(name: 'sender_member_matri_id')  String? senderMemberMatriId, @JsonKey(name: 'receiver_member_id')  dynamic receiverMemberId, @JsonKey(name: 'receiver_member_matri_id')  String? receiverMemberMatriId,  String? message, @JsonKey(name: 'is_read')  String? isRead, @JsonKey(name: 'blocked_member_id')  dynamic blockedMemberId, @JsonKey(name: 'send_on')  String? sendOn, @JsonKey(name: 'is_deleted')  String? isDeleted, @JsonKey(name: 'is_sender')  bool? isSender, @JsonKey(name: 'is_receiver')  bool? isReceiver, @JsonKey(name: 'chat_status')  int? chatStatus)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderMemberId,_that.senderMemberMatriId,_that.receiverMemberId,_that.receiverMemberMatriId,_that.message,_that.isRead,_that.blockedMemberId,_that.sendOn,_that.isDeleted,_that.isSender,_that.isReceiver,_that.chatStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage implements ChatMessage {
  const _ChatMessage({this.id, @JsonKey(name: 'conversation_id') this.conversationId, @JsonKey(name: 'sender_member_id') this.senderMemberId, @JsonKey(name: 'sender_member_matri_id') this.senderMemberMatriId, @JsonKey(name: 'receiver_member_id') this.receiverMemberId, @JsonKey(name: 'receiver_member_matri_id') this.receiverMemberMatriId, this.message, @JsonKey(name: 'is_read') this.isRead, @JsonKey(name: 'blocked_member_id') this.blockedMemberId, @JsonKey(name: 'send_on') this.sendOn, @JsonKey(name: 'is_deleted') this.isDeleted, @JsonKey(name: 'is_sender') this.isSender, @JsonKey(name: 'is_receiver') this.isReceiver, @JsonKey(name: 'chat_status') this.chatStatus});
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'conversation_id') final  dynamic conversationId;
@override@JsonKey(name: 'sender_member_id') final  dynamic senderMemberId;
@override@JsonKey(name: 'sender_member_matri_id') final  String? senderMemberMatriId;
@override@JsonKey(name: 'receiver_member_id') final  dynamic receiverMemberId;
@override@JsonKey(name: 'receiver_member_matri_id') final  String? receiverMemberMatriId;
@override final  String? message;
@override@JsonKey(name: 'is_read') final  String? isRead;
@override@JsonKey(name: 'blocked_member_id') final  dynamic blockedMemberId;
@override@JsonKey(name: 'send_on') final  String? sendOn;
@override@JsonKey(name: 'is_deleted') final  String? isDeleted;
@override@JsonKey(name: 'is_sender') final  bool? isSender;
@override@JsonKey(name: 'is_receiver') final  bool? isReceiver;
@override@JsonKey(name: 'chat_status') final  int? chatStatus;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.conversationId, conversationId)&&const DeepCollectionEquality().equals(other.senderMemberId, senderMemberId)&&(identical(other.senderMemberMatriId, senderMemberMatriId) || other.senderMemberMatriId == senderMemberMatriId)&&const DeepCollectionEquality().equals(other.receiverMemberId, receiverMemberId)&&(identical(other.receiverMemberMatriId, receiverMemberMatriId) || other.receiverMemberMatriId == receiverMemberMatriId)&&(identical(other.message, message) || other.message == message)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.blockedMemberId, blockedMemberId)&&(identical(other.sendOn, sendOn) || other.sendOn == sendOn)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.isSender, isSender) || other.isSender == isSender)&&(identical(other.isReceiver, isReceiver) || other.isReceiver == isReceiver)&&(identical(other.chatStatus, chatStatus) || other.chatStatus == chatStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(conversationId),const DeepCollectionEquality().hash(senderMemberId),senderMemberMatriId,const DeepCollectionEquality().hash(receiverMemberId),receiverMemberMatriId,message,isRead,const DeepCollectionEquality().hash(blockedMemberId),sendOn,isDeleted,isSender,isReceiver,chatStatus);
}

@override
String toString() {
    return 'ChatMessage(id: $id, conversationId: $conversationId, senderMemberId: $senderMemberId, senderMemberMatriId: $senderMemberMatriId, receiverMemberId: $receiverMemberId, receiverMemberMatriId: $receiverMemberMatriId, message: $message, isRead: $isRead, blockedMemberId: $blockedMemberId, sendOn: $sendOn, isDeleted: $isDeleted, isSender: $isSender, isReceiver: $isReceiver, chatStatus: $chatStatus)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'conversation_id') dynamic conversationId,@JsonKey(name: 'sender_member_id') dynamic senderMemberId,@JsonKey(name: 'sender_member_matri_id') String? senderMemberMatriId,@JsonKey(name: 'receiver_member_id') dynamic receiverMemberId,@JsonKey(name: 'receiver_member_matri_id') String? receiverMemberMatriId, String? message,@JsonKey(name: 'is_read') String? isRead,@JsonKey(name: 'blocked_member_id') dynamic blockedMemberId,@JsonKey(name: 'send_on') String? sendOn,@JsonKey(name: 'is_deleted') String? isDeleted,@JsonKey(name: 'is_sender') bool? isSender,@JsonKey(name: 'is_receiver') bool? isReceiver,@JsonKey(name: 'chat_status') int? chatStatus
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? conversationId = freezed,Object? senderMemberId = freezed,Object? senderMemberMatriId = freezed,Object? receiverMemberId = freezed,Object? receiverMemberMatriId = freezed,Object? message = freezed,Object? isRead = freezed,Object? blockedMemberId = freezed,Object? sendOn = freezed,Object? isDeleted = freezed,Object? isSender = freezed,Object? isReceiver = freezed,Object? chatStatus = freezed,}) {
  return _then(_ChatMessage(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberId: freezed == senderMemberId ? _self.senderMemberId : senderMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,senderMemberMatriId: freezed == senderMemberMatriId ? _self.senderMemberMatriId : senderMemberMatriId // ignore: cast_nullable_to_non_nullable
as String?,receiverMemberId: freezed == receiverMemberId ? _self.receiverMemberId : receiverMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,receiverMemberMatriId: freezed == receiverMemberMatriId ? _self.receiverMemberMatriId : receiverMemberMatriId // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as String?,blockedMemberId: freezed == blockedMemberId ? _self.blockedMemberId : blockedMemberId // ignore: cast_nullable_to_non_nullable
as dynamic,sendOn: freezed == sendOn ? _self.sendOn : sendOn // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as String?,isSender: freezed == isSender ? _self.isSender : isSender // ignore: cast_nullable_to_non_nullable
as bool?,isReceiver: freezed == isReceiver ? _self.isReceiver : isReceiver // ignore: cast_nullable_to_non_nullable
as bool?,chatStatus: freezed == chatStatus ? _self.chatStatus : chatStatus // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
