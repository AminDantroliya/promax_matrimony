// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'success_story_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuccessStoryListResponseModel {

 int? get code; String? get status; String? get message; SuccessStoryData? get data;
/// Create a copy of SuccessStoryListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStoryListResponseModelCopyWith<SuccessStoryListResponseModel> get copyWith => _$SuccessStoryListResponseModelCopyWithImpl<SuccessStoryListResponseModel>(this as SuccessStoryListResponseModel, _$identity);

  /// Serializes this SuccessStoryListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SuccessStoryListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessStoryListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SuccessStoryListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as SuccessStoryListResponseModel;
  return 'SuccessStoryListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SuccessStoryListResponseModelCopyWith<$Res>  {
  factory $SuccessStoryListResponseModelCopyWith(SuccessStoryListResponseModel value, $Res Function(SuccessStoryListResponseModel) _then) = _$SuccessStoryListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, SuccessStoryData? data
});


$SuccessStoryDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SuccessStoryListResponseModelCopyWithImpl<$Res>
    implements $SuccessStoryListResponseModelCopyWith<$Res> {
  _$SuccessStoryListResponseModelCopyWithImpl(this._self, this._then);

  final SuccessStoryListResponseModel _self;
  final $Res Function(SuccessStoryListResponseModel) _then;

/// Create a copy of SuccessStoryListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(SuccessStoryListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SuccessStoryData?,
  ));
}
/// Create a copy of SuccessStoryListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuccessStoryDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SuccessStoryDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SuccessStoryListResponseModel].
extension SuccessStoryListResponseModelPatterns on SuccessStoryListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuccessStoryListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuccessStoryListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuccessStoryListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SuccessStoryListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuccessStoryListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SuccessStoryListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SuccessStoryData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuccessStoryListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SuccessStoryData? data)  $default,) {final _that = this;
switch (_that) {
case _SuccessStoryListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  SuccessStoryData? data)?  $default,) {final _that = this;
switch (_that) {
case _SuccessStoryListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuccessStoryListResponseModel implements SuccessStoryListResponseModel {
  const _SuccessStoryListResponseModel({this.code, this.status, this.message, this.data});
  factory _SuccessStoryListResponseModel.fromJson(Map<String, dynamic> json) => _$SuccessStoryListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  SuccessStoryData? data;

/// Create a copy of SuccessStoryListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessStoryListResponseModelCopyWith<_SuccessStoryListResponseModel> get copyWith => __$SuccessStoryListResponseModelCopyWithImpl<_SuccessStoryListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuccessStoryListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessStoryListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'SuccessStoryListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessStoryListResponseModelCopyWith<$Res> implements $SuccessStoryListResponseModelCopyWith<$Res> {
  factory _$SuccessStoryListResponseModelCopyWith(_SuccessStoryListResponseModel value, $Res Function(_SuccessStoryListResponseModel) _then) = __$SuccessStoryListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, SuccessStoryData? data
});


@override $SuccessStoryDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SuccessStoryListResponseModelCopyWithImpl<$Res>
    implements _$SuccessStoryListResponseModelCopyWith<$Res> {
  __$SuccessStoryListResponseModelCopyWithImpl(this._self, this._then);

  final _SuccessStoryListResponseModel _self;
  final $Res Function(_SuccessStoryListResponseModel) _then;

/// Create a copy of SuccessStoryListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SuccessStoryListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SuccessStoryData?,
  ));
}

/// Create a copy of SuccessStoryListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuccessStoryDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SuccessStoryDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SuccessStoryData {

@JsonKey(name: 'resultCount') int? get resultCount;@JsonKey(name: 'resultList') List<SuccessStory>? get resultList;
/// Create a copy of SuccessStoryData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStoryDataCopyWith<SuccessStoryData> get copyWith => _$SuccessStoryDataCopyWithImpl<SuccessStoryData>(this as SuccessStoryData, _$identity);

  /// Serializes this SuccessStoryData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SuccessStoryData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessStoryData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SuccessStoryData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as SuccessStoryData;
  return 'SuccessStoryData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $SuccessStoryDataCopyWith<$Res>  {
  factory $SuccessStoryDataCopyWith(SuccessStoryData value, $Res Function(SuccessStoryData) _then) = _$SuccessStoryDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<SuccessStory>? resultList
});




}
/// @nodoc
class _$SuccessStoryDataCopyWithImpl<$Res>
    implements $SuccessStoryDataCopyWith<$Res> {
  _$SuccessStoryDataCopyWithImpl(this._self, this._then);

  final SuccessStoryData _self;
  final $Res Function(SuccessStoryData) _then;

/// Create a copy of SuccessStoryData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(SuccessStoryData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<SuccessStory>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuccessStoryData].
extension SuccessStoryDataPatterns on SuccessStoryData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuccessStoryData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuccessStoryData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuccessStoryData value)  $default,){
final _that = this;
switch (_that) {
case _SuccessStoryData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuccessStoryData value)?  $default,){
final _that = this;
switch (_that) {
case _SuccessStoryData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<SuccessStory>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuccessStoryData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<SuccessStory>? resultList)  $default,) {final _that = this;
switch (_that) {
case _SuccessStoryData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<SuccessStory>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _SuccessStoryData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuccessStoryData implements SuccessStoryData {
  const _SuccessStoryData({@JsonKey(name: 'resultCount') this.resultCount, @JsonKey(name: 'resultList')  List<SuccessStory>? resultList}): _resultList = resultList;
  factory _SuccessStoryData.fromJson(Map<String, dynamic> json) => _$SuccessStoryDataFromJson(json);

@override@JsonKey(name: 'resultCount') final  int? resultCount;
 final  List<SuccessStory>? _resultList;
@override@JsonKey(name: 'resultList') List<SuccessStory>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SuccessStoryData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessStoryDataCopyWith<_SuccessStoryData> get copyWith => __$SuccessStoryDataCopyWithImpl<_SuccessStoryData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuccessStoryDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessStoryData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'SuccessStoryData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$SuccessStoryDataCopyWith<$Res> implements $SuccessStoryDataCopyWith<$Res> {
  factory _$SuccessStoryDataCopyWith(_SuccessStoryData value, $Res Function(_SuccessStoryData) _then) = __$SuccessStoryDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<SuccessStory>? resultList
});




}
/// @nodoc
class __$SuccessStoryDataCopyWithImpl<$Res>
    implements _$SuccessStoryDataCopyWith<$Res> {
  __$SuccessStoryDataCopyWithImpl(this._self, this._then);

  final _SuccessStoryData _self;
  final $Res Function(_SuccessStoryData) _then;

/// Create a copy of SuccessStoryData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_SuccessStoryData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<SuccessStory>?,
  ));
}


}


/// @nodoc
mixin _$SuccessStory {

 int? get id; String? get bridename; String? get brideid; String? get groomname; String? get groomid;@JsonKey(name: 'wedding_photo') String? get weddingphoto;@JsonKey(name: 'story_type') String? get storyType;@JsonKey(name: 'video_type') String? get videoType;@JsonKey(name: 'wedding_video_file') String? get weddingVideoFile;@JsonKey(name: 'wedding_video_thumbnail') String? get weddingVideoThumbnail;@JsonKey(name: 'video_link') String? get videoLink; String? get marriagedate; String? get successmessage; String? get slug;@JsonKey(name: 'seo_title') String? get seoTitle;@JsonKey(name: 'seo_keywords') String? get seoKeywords;@JsonKey(name: 'seo_description') String? get seoDescription; String? get status;@JsonKey(name: 'lang_code') String? get langCode;@JsonKey(name: 'lang_id') dynamic get langId;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'is_deleted') dynamic get isDeleted;@JsonKey(name: 'bride_profile_image') String? get brideProfileImage;@JsonKey(name: 'groom_profile_image') String? get groomProfileImage;
/// Create a copy of SuccessStory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStoryCopyWith<SuccessStory> get copyWith => _$SuccessStoryCopyWithImpl<SuccessStory>(this as SuccessStory, _$identity);

  /// Serializes this SuccessStory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SuccessStory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessStory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bridename, _this.bridename) || other.bridename == _this.bridename)&&(identical(other.brideid, _this.brideid) || other.brideid == _this.brideid)&&(identical(other.groomname, _this.groomname) || other.groomname == _this.groomname)&&(identical(other.groomid, _this.groomid) || other.groomid == _this.groomid)&&(identical(other.weddingphoto, _this.weddingphoto) || other.weddingphoto == _this.weddingphoto)&&(identical(other.storyType, _this.storyType) || other.storyType == _this.storyType)&&(identical(other.videoType, _this.videoType) || other.videoType == _this.videoType)&&(identical(other.weddingVideoFile, _this.weddingVideoFile) || other.weddingVideoFile == _this.weddingVideoFile)&&(identical(other.weddingVideoThumbnail, _this.weddingVideoThumbnail) || other.weddingVideoThumbnail == _this.weddingVideoThumbnail)&&(identical(other.videoLink, _this.videoLink) || other.videoLink == _this.videoLink)&&(identical(other.marriagedate, _this.marriagedate) || other.marriagedate == _this.marriagedate)&&(identical(other.successmessage, _this.successmessage) || other.successmessage == _this.successmessage)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.seoTitle, _this.seoTitle) || other.seoTitle == _this.seoTitle)&&(identical(other.seoKeywords, _this.seoKeywords) || other.seoKeywords == _this.seoKeywords)&&(identical(other.seoDescription, _this.seoDescription) || other.seoDescription == _this.seoDescription)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.langCode, _this.langCode) || other.langCode == _this.langCode)&&const DeepCollectionEquality().equals(other.langId, _this.langId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&const DeepCollectionEquality().equals(other.isDeleted, _this.isDeleted)&&(identical(other.brideProfileImage, _this.brideProfileImage) || other.brideProfileImage == _this.brideProfileImage)&&(identical(other.groomProfileImage, _this.groomProfileImage) || other.groomProfileImage == _this.groomProfileImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SuccessStory;
  return Object.hashAll([runtimeType,_this.id,_this.bridename,_this.brideid,_this.groomname,_this.groomid,_this.weddingphoto,_this.storyType,_this.videoType,_this.weddingVideoFile,_this.weddingVideoThumbnail,_this.videoLink,_this.marriagedate,_this.successmessage,_this.slug,_this.seoTitle,_this.seoKeywords,_this.seoDescription,_this.status,_this.langCode,const DeepCollectionEquality().hash(_this.langId),_this.createdAt,_this.updatedAt,const DeepCollectionEquality().hash(_this.isDeleted),_this.brideProfileImage,_this.groomProfileImage]);
}

@override
String toString() {
  final _this = this as SuccessStory;
  return 'SuccessStory(id: ${_this.id}, bridename: ${_this.bridename}, brideid: ${_this.brideid}, groomname: ${_this.groomname}, groomid: ${_this.groomid}, weddingphoto: ${_this.weddingphoto}, storyType: ${_this.storyType}, videoType: ${_this.videoType}, weddingVideoFile: ${_this.weddingVideoFile}, weddingVideoThumbnail: ${_this.weddingVideoThumbnail}, videoLink: ${_this.videoLink}, marriagedate: ${_this.marriagedate}, successmessage: ${_this.successmessage}, slug: ${_this.slug}, seoTitle: ${_this.seoTitle}, seoKeywords: ${_this.seoKeywords}, seoDescription: ${_this.seoDescription}, status: ${_this.status}, langCode: ${_this.langCode}, langId: ${_this.langId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, isDeleted: ${_this.isDeleted}, brideProfileImage: ${_this.brideProfileImage}, groomProfileImage: ${_this.groomProfileImage})';
}


}

/// @nodoc
abstract mixin class $SuccessStoryCopyWith<$Res>  {
  factory $SuccessStoryCopyWith(SuccessStory value, $Res Function(SuccessStory) _then) = _$SuccessStoryCopyWithImpl;
@useResult
$Res call({
 int? id, String? bridename, String? brideid, String? groomname, String? groomid,@JsonKey(name: 'wedding_photo') String? weddingphoto,@JsonKey(name: 'story_type') String? storyType,@JsonKey(name: 'video_type') String? videoType,@JsonKey(name: 'wedding_video_file') String? weddingVideoFile,@JsonKey(name: 'wedding_video_thumbnail') String? weddingVideoThumbnail,@JsonKey(name: 'video_link') String? videoLink, String? marriagedate, String? successmessage, String? slug,@JsonKey(name: 'seo_title') String? seoTitle,@JsonKey(name: 'seo_keywords') String? seoKeywords,@JsonKey(name: 'seo_description') String? seoDescription, String? status,@JsonKey(name: 'lang_code') String? langCode,@JsonKey(name: 'lang_id') dynamic langId,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'is_deleted') dynamic isDeleted,@JsonKey(name: 'bride_profile_image') String? brideProfileImage,@JsonKey(name: 'groom_profile_image') String? groomProfileImage
});




}
/// @nodoc
class _$SuccessStoryCopyWithImpl<$Res>
    implements $SuccessStoryCopyWith<$Res> {
  _$SuccessStoryCopyWithImpl(this._self, this._then);

  final SuccessStory _self;
  final $Res Function(SuccessStory) _then;

/// Create a copy of SuccessStory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? bridename = freezed,Object? brideid = freezed,Object? groomname = freezed,Object? groomid = freezed,Object? weddingphoto = freezed,Object? storyType = freezed,Object? videoType = freezed,Object? weddingVideoFile = freezed,Object? weddingVideoThumbnail = freezed,Object? videoLink = freezed,Object? marriagedate = freezed,Object? successmessage = freezed,Object? slug = freezed,Object? seoTitle = freezed,Object? seoKeywords = freezed,Object? seoDescription = freezed,Object? status = freezed,Object? langCode = freezed,Object? langId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = freezed,Object? brideProfileImage = freezed,Object? groomProfileImage = freezed,}) {
  return _then(SuccessStory(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,bridename: freezed == bridename ? _self.bridename : bridename // ignore: cast_nullable_to_non_nullable
as String?,brideid: freezed == brideid ? _self.brideid : brideid // ignore: cast_nullable_to_non_nullable
as String?,groomname: freezed == groomname ? _self.groomname : groomname // ignore: cast_nullable_to_non_nullable
as String?,groomid: freezed == groomid ? _self.groomid : groomid // ignore: cast_nullable_to_non_nullable
as String?,weddingphoto: freezed == weddingphoto ? _self.weddingphoto : weddingphoto // ignore: cast_nullable_to_non_nullable
as String?,storyType: freezed == storyType ? _self.storyType : storyType // ignore: cast_nullable_to_non_nullable
as String?,videoType: freezed == videoType ? _self.videoType : videoType // ignore: cast_nullable_to_non_nullable
as String?,weddingVideoFile: freezed == weddingVideoFile ? _self.weddingVideoFile : weddingVideoFile // ignore: cast_nullable_to_non_nullable
as String?,weddingVideoThumbnail: freezed == weddingVideoThumbnail ? _self.weddingVideoThumbnail : weddingVideoThumbnail // ignore: cast_nullable_to_non_nullable
as String?,videoLink: freezed == videoLink ? _self.videoLink : videoLink // ignore: cast_nullable_to_non_nullable
as String?,marriagedate: freezed == marriagedate ? _self.marriagedate : marriagedate // ignore: cast_nullable_to_non_nullable
as String?,successmessage: freezed == successmessage ? _self.successmessage : successmessage // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,seoTitle: freezed == seoTitle ? _self.seoTitle : seoTitle // ignore: cast_nullable_to_non_nullable
as String?,seoKeywords: freezed == seoKeywords ? _self.seoKeywords : seoKeywords // ignore: cast_nullable_to_non_nullable
as String?,seoDescription: freezed == seoDescription ? _self.seoDescription : seoDescription // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,langCode: freezed == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String?,langId: freezed == langId ? _self.langId : langId // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as dynamic,brideProfileImage: freezed == brideProfileImage ? _self.brideProfileImage : brideProfileImage // ignore: cast_nullable_to_non_nullable
as String?,groomProfileImage: freezed == groomProfileImage ? _self.groomProfileImage : groomProfileImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuccessStory].
extension SuccessStoryPatterns on SuccessStory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuccessStory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuccessStory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuccessStory value)  $default,){
final _that = this;
switch (_that) {
case _SuccessStory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuccessStory value)?  $default,){
final _that = this;
switch (_that) {
case _SuccessStory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? bridename,  String? brideid,  String? groomname,  String? groomid, @JsonKey(name: 'wedding_photo')  String? weddingphoto, @JsonKey(name: 'story_type')  String? storyType, @JsonKey(name: 'video_type')  String? videoType, @JsonKey(name: 'wedding_video_file')  String? weddingVideoFile, @JsonKey(name: 'wedding_video_thumbnail')  String? weddingVideoThumbnail, @JsonKey(name: 'video_link')  String? videoLink,  String? marriagedate,  String? successmessage,  String? slug, @JsonKey(name: 'seo_title')  String? seoTitle, @JsonKey(name: 'seo_keywords')  String? seoKeywords, @JsonKey(name: 'seo_description')  String? seoDescription,  String? status, @JsonKey(name: 'lang_code')  String? langCode, @JsonKey(name: 'lang_id')  dynamic langId, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted, @JsonKey(name: 'bride_profile_image')  String? brideProfileImage, @JsonKey(name: 'groom_profile_image')  String? groomProfileImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuccessStory() when $default != null:
return $default(_that.id,_that.bridename,_that.brideid,_that.groomname,_that.groomid,_that.weddingphoto,_that.storyType,_that.videoType,_that.weddingVideoFile,_that.weddingVideoThumbnail,_that.videoLink,_that.marriagedate,_that.successmessage,_that.slug,_that.seoTitle,_that.seoKeywords,_that.seoDescription,_that.status,_that.langCode,_that.langId,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.brideProfileImage,_that.groomProfileImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? bridename,  String? brideid,  String? groomname,  String? groomid, @JsonKey(name: 'wedding_photo')  String? weddingphoto, @JsonKey(name: 'story_type')  String? storyType, @JsonKey(name: 'video_type')  String? videoType, @JsonKey(name: 'wedding_video_file')  String? weddingVideoFile, @JsonKey(name: 'wedding_video_thumbnail')  String? weddingVideoThumbnail, @JsonKey(name: 'video_link')  String? videoLink,  String? marriagedate,  String? successmessage,  String? slug, @JsonKey(name: 'seo_title')  String? seoTitle, @JsonKey(name: 'seo_keywords')  String? seoKeywords, @JsonKey(name: 'seo_description')  String? seoDescription,  String? status, @JsonKey(name: 'lang_code')  String? langCode, @JsonKey(name: 'lang_id')  dynamic langId, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted, @JsonKey(name: 'bride_profile_image')  String? brideProfileImage, @JsonKey(name: 'groom_profile_image')  String? groomProfileImage)  $default,) {final _that = this;
switch (_that) {
case _SuccessStory():
return $default(_that.id,_that.bridename,_that.brideid,_that.groomname,_that.groomid,_that.weddingphoto,_that.storyType,_that.videoType,_that.weddingVideoFile,_that.weddingVideoThumbnail,_that.videoLink,_that.marriagedate,_that.successmessage,_that.slug,_that.seoTitle,_that.seoKeywords,_that.seoDescription,_that.status,_that.langCode,_that.langId,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.brideProfileImage,_that.groomProfileImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? bridename,  String? brideid,  String? groomname,  String? groomid, @JsonKey(name: 'wedding_photo')  String? weddingphoto, @JsonKey(name: 'story_type')  String? storyType, @JsonKey(name: 'video_type')  String? videoType, @JsonKey(name: 'wedding_video_file')  String? weddingVideoFile, @JsonKey(name: 'wedding_video_thumbnail')  String? weddingVideoThumbnail, @JsonKey(name: 'video_link')  String? videoLink,  String? marriagedate,  String? successmessage,  String? slug, @JsonKey(name: 'seo_title')  String? seoTitle, @JsonKey(name: 'seo_keywords')  String? seoKeywords, @JsonKey(name: 'seo_description')  String? seoDescription,  String? status, @JsonKey(name: 'lang_code')  String? langCode, @JsonKey(name: 'lang_id')  dynamic langId, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted, @JsonKey(name: 'bride_profile_image')  String? brideProfileImage, @JsonKey(name: 'groom_profile_image')  String? groomProfileImage)?  $default,) {final _that = this;
switch (_that) {
case _SuccessStory() when $default != null:
return $default(_that.id,_that.bridename,_that.brideid,_that.groomname,_that.groomid,_that.weddingphoto,_that.storyType,_that.videoType,_that.weddingVideoFile,_that.weddingVideoThumbnail,_that.videoLink,_that.marriagedate,_that.successmessage,_that.slug,_that.seoTitle,_that.seoKeywords,_that.seoDescription,_that.status,_that.langCode,_that.langId,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.brideProfileImage,_that.groomProfileImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuccessStory implements SuccessStory {
  const _SuccessStory({this.id, this.bridename, this.brideid, this.groomname, this.groomid, @JsonKey(name: 'wedding_photo') this.weddingphoto, @JsonKey(name: 'story_type') this.storyType, @JsonKey(name: 'video_type') this.videoType, @JsonKey(name: 'wedding_video_file') this.weddingVideoFile, @JsonKey(name: 'wedding_video_thumbnail') this.weddingVideoThumbnail, @JsonKey(name: 'video_link') this.videoLink, this.marriagedate, this.successmessage, this.slug, @JsonKey(name: 'seo_title') this.seoTitle, @JsonKey(name: 'seo_keywords') this.seoKeywords, @JsonKey(name: 'seo_description') this.seoDescription, this.status, @JsonKey(name: 'lang_code') this.langCode, @JsonKey(name: 'lang_id') this.langId, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'is_deleted') this.isDeleted, @JsonKey(name: 'bride_profile_image') this.brideProfileImage, @JsonKey(name: 'groom_profile_image') this.groomProfileImage});
  factory _SuccessStory.fromJson(Map<String, dynamic> json) => _$SuccessStoryFromJson(json);

@override final  int? id;
@override final  String? bridename;
@override final  String? brideid;
@override final  String? groomname;
@override final  String? groomid;
@override@JsonKey(name: 'wedding_photo') final  String? weddingphoto;
@override@JsonKey(name: 'story_type') final  String? storyType;
@override@JsonKey(name: 'video_type') final  String? videoType;
@override@JsonKey(name: 'wedding_video_file') final  String? weddingVideoFile;
@override@JsonKey(name: 'wedding_video_thumbnail') final  String? weddingVideoThumbnail;
@override@JsonKey(name: 'video_link') final  String? videoLink;
@override final  String? marriagedate;
@override final  String? successmessage;
@override final  String? slug;
@override@JsonKey(name: 'seo_title') final  String? seoTitle;
@override@JsonKey(name: 'seo_keywords') final  String? seoKeywords;
@override@JsonKey(name: 'seo_description') final  String? seoDescription;
@override final  String? status;
@override@JsonKey(name: 'lang_code') final  String? langCode;
@override@JsonKey(name: 'lang_id') final  dynamic langId;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'is_deleted') final  dynamic isDeleted;
@override@JsonKey(name: 'bride_profile_image') final  String? brideProfileImage;
@override@JsonKey(name: 'groom_profile_image') final  String? groomProfileImage;

/// Create a copy of SuccessStory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessStoryCopyWith<_SuccessStory> get copyWith => __$SuccessStoryCopyWithImpl<_SuccessStory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuccessStoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessStory&&(identical(other.id, id) || other.id == id)&&(identical(other.bridename, bridename) || other.bridename == bridename)&&(identical(other.brideid, brideid) || other.brideid == brideid)&&(identical(other.groomname, groomname) || other.groomname == groomname)&&(identical(other.groomid, groomid) || other.groomid == groomid)&&(identical(other.weddingphoto, weddingphoto) || other.weddingphoto == weddingphoto)&&(identical(other.storyType, storyType) || other.storyType == storyType)&&(identical(other.videoType, videoType) || other.videoType == videoType)&&(identical(other.weddingVideoFile, weddingVideoFile) || other.weddingVideoFile == weddingVideoFile)&&(identical(other.weddingVideoThumbnail, weddingVideoThumbnail) || other.weddingVideoThumbnail == weddingVideoThumbnail)&&(identical(other.videoLink, videoLink) || other.videoLink == videoLink)&&(identical(other.marriagedate, marriagedate) || other.marriagedate == marriagedate)&&(identical(other.successmessage, successmessage) || other.successmessage == successmessage)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.seoTitle, seoTitle) || other.seoTitle == seoTitle)&&(identical(other.seoKeywords, seoKeywords) || other.seoKeywords == seoKeywords)&&(identical(other.seoDescription, seoDescription) || other.seoDescription == seoDescription)&&(identical(other.status, status) || other.status == status)&&(identical(other.langCode, langCode) || other.langCode == langCode)&&const DeepCollectionEquality().equals(other.langId, langId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.isDeleted, isDeleted)&&(identical(other.brideProfileImage, brideProfileImage) || other.brideProfileImage == brideProfileImage)&&(identical(other.groomProfileImage, groomProfileImage) || other.groomProfileImage == groomProfileImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,bridename,brideid,groomname,groomid,weddingphoto,storyType,videoType,weddingVideoFile,weddingVideoThumbnail,videoLink,marriagedate,successmessage,slug,seoTitle,seoKeywords,seoDescription,status,langCode,const DeepCollectionEquality().hash(langId),createdAt,updatedAt,const DeepCollectionEquality().hash(isDeleted),brideProfileImage,groomProfileImage]);
}

@override
String toString() {
    return 'SuccessStory(id: $id, bridename: $bridename, brideid: $brideid, groomname: $groomname, groomid: $groomid, weddingphoto: $weddingphoto, storyType: $storyType, videoType: $videoType, weddingVideoFile: $weddingVideoFile, weddingVideoThumbnail: $weddingVideoThumbnail, videoLink: $videoLink, marriagedate: $marriagedate, successmessage: $successmessage, slug: $slug, seoTitle: $seoTitle, seoKeywords: $seoKeywords, seoDescription: $seoDescription, status: $status, langCode: $langCode, langId: $langId, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, brideProfileImage: $brideProfileImage, groomProfileImage: $groomProfileImage)';
}


}

/// @nodoc
abstract mixin class _$SuccessStoryCopyWith<$Res> implements $SuccessStoryCopyWith<$Res> {
  factory _$SuccessStoryCopyWith(_SuccessStory value, $Res Function(_SuccessStory) _then) = __$SuccessStoryCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? bridename, String? brideid, String? groomname, String? groomid,@JsonKey(name: 'wedding_photo') String? weddingphoto,@JsonKey(name: 'story_type') String? storyType,@JsonKey(name: 'video_type') String? videoType,@JsonKey(name: 'wedding_video_file') String? weddingVideoFile,@JsonKey(name: 'wedding_video_thumbnail') String? weddingVideoThumbnail,@JsonKey(name: 'video_link') String? videoLink, String? marriagedate, String? successmessage, String? slug,@JsonKey(name: 'seo_title') String? seoTitle,@JsonKey(name: 'seo_keywords') String? seoKeywords,@JsonKey(name: 'seo_description') String? seoDescription, String? status,@JsonKey(name: 'lang_code') String? langCode,@JsonKey(name: 'lang_id') dynamic langId,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'is_deleted') dynamic isDeleted,@JsonKey(name: 'bride_profile_image') String? brideProfileImage,@JsonKey(name: 'groom_profile_image') String? groomProfileImage
});




}
/// @nodoc
class __$SuccessStoryCopyWithImpl<$Res>
    implements _$SuccessStoryCopyWith<$Res> {
  __$SuccessStoryCopyWithImpl(this._self, this._then);

  final _SuccessStory _self;
  final $Res Function(_SuccessStory) _then;

/// Create a copy of SuccessStory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? bridename = freezed,Object? brideid = freezed,Object? groomname = freezed,Object? groomid = freezed,Object? weddingphoto = freezed,Object? storyType = freezed,Object? videoType = freezed,Object? weddingVideoFile = freezed,Object? weddingVideoThumbnail = freezed,Object? videoLink = freezed,Object? marriagedate = freezed,Object? successmessage = freezed,Object? slug = freezed,Object? seoTitle = freezed,Object? seoKeywords = freezed,Object? seoDescription = freezed,Object? status = freezed,Object? langCode = freezed,Object? langId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = freezed,Object? brideProfileImage = freezed,Object? groomProfileImage = freezed,}) {
  return _then(_SuccessStory(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,bridename: freezed == bridename ? _self.bridename : bridename // ignore: cast_nullable_to_non_nullable
as String?,brideid: freezed == brideid ? _self.brideid : brideid // ignore: cast_nullable_to_non_nullable
as String?,groomname: freezed == groomname ? _self.groomname : groomname // ignore: cast_nullable_to_non_nullable
as String?,groomid: freezed == groomid ? _self.groomid : groomid // ignore: cast_nullable_to_non_nullable
as String?,weddingphoto: freezed == weddingphoto ? _self.weddingphoto : weddingphoto // ignore: cast_nullable_to_non_nullable
as String?,storyType: freezed == storyType ? _self.storyType : storyType // ignore: cast_nullable_to_non_nullable
as String?,videoType: freezed == videoType ? _self.videoType : videoType // ignore: cast_nullable_to_non_nullable
as String?,weddingVideoFile: freezed == weddingVideoFile ? _self.weddingVideoFile : weddingVideoFile // ignore: cast_nullable_to_non_nullable
as String?,weddingVideoThumbnail: freezed == weddingVideoThumbnail ? _self.weddingVideoThumbnail : weddingVideoThumbnail // ignore: cast_nullable_to_non_nullable
as String?,videoLink: freezed == videoLink ? _self.videoLink : videoLink // ignore: cast_nullable_to_non_nullable
as String?,marriagedate: freezed == marriagedate ? _self.marriagedate : marriagedate // ignore: cast_nullable_to_non_nullable
as String?,successmessage: freezed == successmessage ? _self.successmessage : successmessage // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,seoTitle: freezed == seoTitle ? _self.seoTitle : seoTitle // ignore: cast_nullable_to_non_nullable
as String?,seoKeywords: freezed == seoKeywords ? _self.seoKeywords : seoKeywords // ignore: cast_nullable_to_non_nullable
as String?,seoDescription: freezed == seoDescription ? _self.seoDescription : seoDescription // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,langCode: freezed == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String?,langId: freezed == langId ? _self.langId : langId // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as dynamic,brideProfileImage: freezed == brideProfileImage ? _self.brideProfileImage : brideProfileImage // ignore: cast_nullable_to_non_nullable
as String?,groomProfileImage: freezed == groomProfileImage ? _self.groomProfileImage : groomProfileImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SuccessStoryDetailsResponseModel {

 int? get code; String? get status; String? get message; SuccessStory? get data;
/// Create a copy of SuccessStoryDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStoryDetailsResponseModelCopyWith<SuccessStoryDetailsResponseModel> get copyWith => _$SuccessStoryDetailsResponseModelCopyWithImpl<SuccessStoryDetailsResponseModel>(this as SuccessStoryDetailsResponseModel, _$identity);

  /// Serializes this SuccessStoryDetailsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SuccessStoryDetailsResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessStoryDetailsResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SuccessStoryDetailsResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as SuccessStoryDetailsResponseModel;
  return 'SuccessStoryDetailsResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SuccessStoryDetailsResponseModelCopyWith<$Res>  {
  factory $SuccessStoryDetailsResponseModelCopyWith(SuccessStoryDetailsResponseModel value, $Res Function(SuccessStoryDetailsResponseModel) _then) = _$SuccessStoryDetailsResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, SuccessStory? data
});


$SuccessStoryCopyWith<$Res>? get data;

}
/// @nodoc
class _$SuccessStoryDetailsResponseModelCopyWithImpl<$Res>
    implements $SuccessStoryDetailsResponseModelCopyWith<$Res> {
  _$SuccessStoryDetailsResponseModelCopyWithImpl(this._self, this._then);

  final SuccessStoryDetailsResponseModel _self;
  final $Res Function(SuccessStoryDetailsResponseModel) _then;

/// Create a copy of SuccessStoryDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(SuccessStoryDetailsResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SuccessStory?,
  ));
}
/// Create a copy of SuccessStoryDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuccessStoryCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SuccessStoryCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SuccessStoryDetailsResponseModel].
extension SuccessStoryDetailsResponseModelPatterns on SuccessStoryDetailsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuccessStoryDetailsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuccessStoryDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuccessStoryDetailsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SuccessStoryDetailsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuccessStoryDetailsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SuccessStoryDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SuccessStory? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuccessStoryDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SuccessStory? data)  $default,) {final _that = this;
switch (_that) {
case _SuccessStoryDetailsResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  SuccessStory? data)?  $default,) {final _that = this;
switch (_that) {
case _SuccessStoryDetailsResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuccessStoryDetailsResponseModel implements SuccessStoryDetailsResponseModel {
  const _SuccessStoryDetailsResponseModel({this.code, this.status, this.message, this.data});
  factory _SuccessStoryDetailsResponseModel.fromJson(Map<String, dynamic> json) => _$SuccessStoryDetailsResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  SuccessStory? data;

/// Create a copy of SuccessStoryDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessStoryDetailsResponseModelCopyWith<_SuccessStoryDetailsResponseModel> get copyWith => __$SuccessStoryDetailsResponseModelCopyWithImpl<_SuccessStoryDetailsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuccessStoryDetailsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessStoryDetailsResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'SuccessStoryDetailsResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessStoryDetailsResponseModelCopyWith<$Res> implements $SuccessStoryDetailsResponseModelCopyWith<$Res> {
  factory _$SuccessStoryDetailsResponseModelCopyWith(_SuccessStoryDetailsResponseModel value, $Res Function(_SuccessStoryDetailsResponseModel) _then) = __$SuccessStoryDetailsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, SuccessStory? data
});


@override $SuccessStoryCopyWith<$Res>? get data;

}
/// @nodoc
class __$SuccessStoryDetailsResponseModelCopyWithImpl<$Res>
    implements _$SuccessStoryDetailsResponseModelCopyWith<$Res> {
  __$SuccessStoryDetailsResponseModelCopyWithImpl(this._self, this._then);

  final _SuccessStoryDetailsResponseModel _self;
  final $Res Function(_SuccessStoryDetailsResponseModel) _then;

/// Create a copy of SuccessStoryDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SuccessStoryDetailsResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SuccessStory?,
  ));
}

/// Create a copy of SuccessStoryDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuccessStoryCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SuccessStoryCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
