// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CmsResponseModel {

 int? get code; String? get status; String? get message; CmsData? get data;
/// Create a copy of CmsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsResponseModelCopyWith<CmsResponseModel> get copyWith => _$CmsResponseModelCopyWithImpl<CmsResponseModel>(this as CmsResponseModel, _$identity);

  /// Serializes this CmsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CmsResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CmsResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as CmsResponseModel;
  return 'CmsResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $CmsResponseModelCopyWith<$Res>  {
  factory $CmsResponseModelCopyWith(CmsResponseModel value, $Res Function(CmsResponseModel) _then) = _$CmsResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, CmsData? data
});


$CmsDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CmsResponseModelCopyWithImpl<$Res>
    implements $CmsResponseModelCopyWith<$Res> {
  _$CmsResponseModelCopyWithImpl(this._self, this._then);

  final CmsResponseModel _self;
  final $Res Function(CmsResponseModel) _then;

/// Create a copy of CmsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(CmsResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CmsData?,
  ));
}
/// Create a copy of CmsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CmsDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CmsResponseModel].
extension CmsResponseModelPatterns on CmsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CmsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CmsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CmsData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CmsData? data)  $default,) {final _that = this;
switch (_that) {
case _CmsResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  CmsData? data)?  $default,) {final _that = this;
switch (_that) {
case _CmsResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CmsResponseModel implements CmsResponseModel {
  const _CmsResponseModel({this.code, this.status, this.message, this.data});
  factory _CmsResponseModel.fromJson(Map<String, dynamic> json) => _$CmsResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  CmsData? data;

/// Create a copy of CmsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsResponseModelCopyWith<_CmsResponseModel> get copyWith => __$CmsResponseModelCopyWithImpl<_CmsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CmsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'CmsResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CmsResponseModelCopyWith<$Res> implements $CmsResponseModelCopyWith<$Res> {
  factory _$CmsResponseModelCopyWith(_CmsResponseModel value, $Res Function(_CmsResponseModel) _then) = __$CmsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, CmsData? data
});


@override $CmsDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CmsResponseModelCopyWithImpl<$Res>
    implements _$CmsResponseModelCopyWith<$Res> {
  __$CmsResponseModelCopyWithImpl(this._self, this._then);

  final _CmsResponseModel _self;
  final $Res Function(_CmsResponseModel) _then;

/// Create a copy of CmsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CmsResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CmsData?,
  ));
}

/// Create a copy of CmsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CmsDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CmsData {

 int? get id; String? get status;@JsonKey(name: 'page_title') String? get pageTitle;@JsonKey(name: 'page_sub_title') String? get pageSubTitle;@JsonKey(name: 'page_content') String? get pageContent;@JsonKey(name: 'page_url') String? get pageUrl;@JsonKey(name: 'about_us_image') String? get aboutUsImage;@JsonKey(name: 'about_us_sub_title') String? get aboutUsSubTitle;@JsonKey(name: 'about_us_desc') String? get aboutUsDesc;@JsonKey(name: 'about_us_brow_sec1') String? get aboutUsBrowSec1;@JsonKey(name: 'about_us_brow_sec2') String? get aboutUsBrowSec2;@JsonKey(name: 'about_us_brow_sec3') String? get aboutUsBrowSec3;
/// Create a copy of CmsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsDataCopyWith<CmsData> get copyWith => _$CmsDataCopyWithImpl<CmsData>(this as CmsData, _$identity);

  /// Serializes this CmsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CmsData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsData&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.pageTitle, _this.pageTitle) || other.pageTitle == _this.pageTitle)&&(identical(other.pageSubTitle, _this.pageSubTitle) || other.pageSubTitle == _this.pageSubTitle)&&(identical(other.pageContent, _this.pageContent) || other.pageContent == _this.pageContent)&&(identical(other.pageUrl, _this.pageUrl) || other.pageUrl == _this.pageUrl)&&(identical(other.aboutUsImage, _this.aboutUsImage) || other.aboutUsImage == _this.aboutUsImage)&&(identical(other.aboutUsSubTitle, _this.aboutUsSubTitle) || other.aboutUsSubTitle == _this.aboutUsSubTitle)&&(identical(other.aboutUsDesc, _this.aboutUsDesc) || other.aboutUsDesc == _this.aboutUsDesc)&&(identical(other.aboutUsBrowSec1, _this.aboutUsBrowSec1) || other.aboutUsBrowSec1 == _this.aboutUsBrowSec1)&&(identical(other.aboutUsBrowSec2, _this.aboutUsBrowSec2) || other.aboutUsBrowSec2 == _this.aboutUsBrowSec2)&&(identical(other.aboutUsBrowSec3, _this.aboutUsBrowSec3) || other.aboutUsBrowSec3 == _this.aboutUsBrowSec3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CmsData;
  return Object.hash(runtimeType,_this.id,_this.status,_this.pageTitle,_this.pageSubTitle,_this.pageContent,_this.pageUrl,_this.aboutUsImage,_this.aboutUsSubTitle,_this.aboutUsDesc,_this.aboutUsBrowSec1,_this.aboutUsBrowSec2,_this.aboutUsBrowSec3);
}

@override
String toString() {
  final _this = this as CmsData;
  return 'CmsData(id: ${_this.id}, status: ${_this.status}, pageTitle: ${_this.pageTitle}, pageSubTitle: ${_this.pageSubTitle}, pageContent: ${_this.pageContent}, pageUrl: ${_this.pageUrl}, aboutUsImage: ${_this.aboutUsImage}, aboutUsSubTitle: ${_this.aboutUsSubTitle}, aboutUsDesc: ${_this.aboutUsDesc}, aboutUsBrowSec1: ${_this.aboutUsBrowSec1}, aboutUsBrowSec2: ${_this.aboutUsBrowSec2}, aboutUsBrowSec3: ${_this.aboutUsBrowSec3})';
}


}

/// @nodoc
abstract mixin class $CmsDataCopyWith<$Res>  {
  factory $CmsDataCopyWith(CmsData value, $Res Function(CmsData) _then) = _$CmsDataCopyWithImpl;
@useResult
$Res call({
 int? id, String? status,@JsonKey(name: 'page_title') String? pageTitle,@JsonKey(name: 'page_sub_title') String? pageSubTitle,@JsonKey(name: 'page_content') String? pageContent,@JsonKey(name: 'page_url') String? pageUrl,@JsonKey(name: 'about_us_image') String? aboutUsImage,@JsonKey(name: 'about_us_sub_title') String? aboutUsSubTitle,@JsonKey(name: 'about_us_desc') String? aboutUsDesc,@JsonKey(name: 'about_us_brow_sec1') String? aboutUsBrowSec1,@JsonKey(name: 'about_us_brow_sec2') String? aboutUsBrowSec2,@JsonKey(name: 'about_us_brow_sec3') String? aboutUsBrowSec3
});




}
/// @nodoc
class _$CmsDataCopyWithImpl<$Res>
    implements $CmsDataCopyWith<$Res> {
  _$CmsDataCopyWithImpl(this._self, this._then);

  final CmsData _self;
  final $Res Function(CmsData) _then;

/// Create a copy of CmsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? status = freezed,Object? pageTitle = freezed,Object? pageSubTitle = freezed,Object? pageContent = freezed,Object? pageUrl = freezed,Object? aboutUsImage = freezed,Object? aboutUsSubTitle = freezed,Object? aboutUsDesc = freezed,Object? aboutUsBrowSec1 = freezed,Object? aboutUsBrowSec2 = freezed,Object? aboutUsBrowSec3 = freezed,}) {
  return _then(CmsData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,pageTitle: freezed == pageTitle ? _self.pageTitle : pageTitle // ignore: cast_nullable_to_non_nullable
as String?,pageSubTitle: freezed == pageSubTitle ? _self.pageSubTitle : pageSubTitle // ignore: cast_nullable_to_non_nullable
as String?,pageContent: freezed == pageContent ? _self.pageContent : pageContent // ignore: cast_nullable_to_non_nullable
as String?,pageUrl: freezed == pageUrl ? _self.pageUrl : pageUrl // ignore: cast_nullable_to_non_nullable
as String?,aboutUsImage: freezed == aboutUsImage ? _self.aboutUsImage : aboutUsImage // ignore: cast_nullable_to_non_nullable
as String?,aboutUsSubTitle: freezed == aboutUsSubTitle ? _self.aboutUsSubTitle : aboutUsSubTitle // ignore: cast_nullable_to_non_nullable
as String?,aboutUsDesc: freezed == aboutUsDesc ? _self.aboutUsDesc : aboutUsDesc // ignore: cast_nullable_to_non_nullable
as String?,aboutUsBrowSec1: freezed == aboutUsBrowSec1 ? _self.aboutUsBrowSec1 : aboutUsBrowSec1 // ignore: cast_nullable_to_non_nullable
as String?,aboutUsBrowSec2: freezed == aboutUsBrowSec2 ? _self.aboutUsBrowSec2 : aboutUsBrowSec2 // ignore: cast_nullable_to_non_nullable
as String?,aboutUsBrowSec3: freezed == aboutUsBrowSec3 ? _self.aboutUsBrowSec3 : aboutUsBrowSec3 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CmsData].
extension CmsDataPatterns on CmsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsData value)  $default,){
final _that = this;
switch (_that) {
case _CmsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsData value)?  $default,){
final _that = this;
switch (_that) {
case _CmsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? status, @JsonKey(name: 'page_title')  String? pageTitle, @JsonKey(name: 'page_sub_title')  String? pageSubTitle, @JsonKey(name: 'page_content')  String? pageContent, @JsonKey(name: 'page_url')  String? pageUrl, @JsonKey(name: 'about_us_image')  String? aboutUsImage, @JsonKey(name: 'about_us_sub_title')  String? aboutUsSubTitle, @JsonKey(name: 'about_us_desc')  String? aboutUsDesc, @JsonKey(name: 'about_us_brow_sec1')  String? aboutUsBrowSec1, @JsonKey(name: 'about_us_brow_sec2')  String? aboutUsBrowSec2, @JsonKey(name: 'about_us_brow_sec3')  String? aboutUsBrowSec3)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsData() when $default != null:
return $default(_that.id,_that.status,_that.pageTitle,_that.pageSubTitle,_that.pageContent,_that.pageUrl,_that.aboutUsImage,_that.aboutUsSubTitle,_that.aboutUsDesc,_that.aboutUsBrowSec1,_that.aboutUsBrowSec2,_that.aboutUsBrowSec3);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? status, @JsonKey(name: 'page_title')  String? pageTitle, @JsonKey(name: 'page_sub_title')  String? pageSubTitle, @JsonKey(name: 'page_content')  String? pageContent, @JsonKey(name: 'page_url')  String? pageUrl, @JsonKey(name: 'about_us_image')  String? aboutUsImage, @JsonKey(name: 'about_us_sub_title')  String? aboutUsSubTitle, @JsonKey(name: 'about_us_desc')  String? aboutUsDesc, @JsonKey(name: 'about_us_brow_sec1')  String? aboutUsBrowSec1, @JsonKey(name: 'about_us_brow_sec2')  String? aboutUsBrowSec2, @JsonKey(name: 'about_us_brow_sec3')  String? aboutUsBrowSec3)  $default,) {final _that = this;
switch (_that) {
case _CmsData():
return $default(_that.id,_that.status,_that.pageTitle,_that.pageSubTitle,_that.pageContent,_that.pageUrl,_that.aboutUsImage,_that.aboutUsSubTitle,_that.aboutUsDesc,_that.aboutUsBrowSec1,_that.aboutUsBrowSec2,_that.aboutUsBrowSec3);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? status, @JsonKey(name: 'page_title')  String? pageTitle, @JsonKey(name: 'page_sub_title')  String? pageSubTitle, @JsonKey(name: 'page_content')  String? pageContent, @JsonKey(name: 'page_url')  String? pageUrl, @JsonKey(name: 'about_us_image')  String? aboutUsImage, @JsonKey(name: 'about_us_sub_title')  String? aboutUsSubTitle, @JsonKey(name: 'about_us_desc')  String? aboutUsDesc, @JsonKey(name: 'about_us_brow_sec1')  String? aboutUsBrowSec1, @JsonKey(name: 'about_us_brow_sec2')  String? aboutUsBrowSec2, @JsonKey(name: 'about_us_brow_sec3')  String? aboutUsBrowSec3)?  $default,) {final _that = this;
switch (_that) {
case _CmsData() when $default != null:
return $default(_that.id,_that.status,_that.pageTitle,_that.pageSubTitle,_that.pageContent,_that.pageUrl,_that.aboutUsImage,_that.aboutUsSubTitle,_that.aboutUsDesc,_that.aboutUsBrowSec1,_that.aboutUsBrowSec2,_that.aboutUsBrowSec3);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CmsData implements CmsData {
  const _CmsData({this.id, this.status, @JsonKey(name: 'page_title') this.pageTitle, @JsonKey(name: 'page_sub_title') this.pageSubTitle, @JsonKey(name: 'page_content') this.pageContent, @JsonKey(name: 'page_url') this.pageUrl, @JsonKey(name: 'about_us_image') this.aboutUsImage, @JsonKey(name: 'about_us_sub_title') this.aboutUsSubTitle, @JsonKey(name: 'about_us_desc') this.aboutUsDesc, @JsonKey(name: 'about_us_brow_sec1') this.aboutUsBrowSec1, @JsonKey(name: 'about_us_brow_sec2') this.aboutUsBrowSec2, @JsonKey(name: 'about_us_brow_sec3') this.aboutUsBrowSec3});
  factory _CmsData.fromJson(Map<String, dynamic> json) => _$CmsDataFromJson(json);

@override final  int? id;
@override final  String? status;
@override@JsonKey(name: 'page_title') final  String? pageTitle;
@override@JsonKey(name: 'page_sub_title') final  String? pageSubTitle;
@override@JsonKey(name: 'page_content') final  String? pageContent;
@override@JsonKey(name: 'page_url') final  String? pageUrl;
@override@JsonKey(name: 'about_us_image') final  String? aboutUsImage;
@override@JsonKey(name: 'about_us_sub_title') final  String? aboutUsSubTitle;
@override@JsonKey(name: 'about_us_desc') final  String? aboutUsDesc;
@override@JsonKey(name: 'about_us_brow_sec1') final  String? aboutUsBrowSec1;
@override@JsonKey(name: 'about_us_brow_sec2') final  String? aboutUsBrowSec2;
@override@JsonKey(name: 'about_us_brow_sec3') final  String? aboutUsBrowSec3;

/// Create a copy of CmsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsDataCopyWith<_CmsData> get copyWith => __$CmsDataCopyWithImpl<_CmsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CmsDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsData&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.pageTitle, pageTitle) || other.pageTitle == pageTitle)&&(identical(other.pageSubTitle, pageSubTitle) || other.pageSubTitle == pageSubTitle)&&(identical(other.pageContent, pageContent) || other.pageContent == pageContent)&&(identical(other.pageUrl, pageUrl) || other.pageUrl == pageUrl)&&(identical(other.aboutUsImage, aboutUsImage) || other.aboutUsImage == aboutUsImage)&&(identical(other.aboutUsSubTitle, aboutUsSubTitle) || other.aboutUsSubTitle == aboutUsSubTitle)&&(identical(other.aboutUsDesc, aboutUsDesc) || other.aboutUsDesc == aboutUsDesc)&&(identical(other.aboutUsBrowSec1, aboutUsBrowSec1) || other.aboutUsBrowSec1 == aboutUsBrowSec1)&&(identical(other.aboutUsBrowSec2, aboutUsBrowSec2) || other.aboutUsBrowSec2 == aboutUsBrowSec2)&&(identical(other.aboutUsBrowSec3, aboutUsBrowSec3) || other.aboutUsBrowSec3 == aboutUsBrowSec3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,pageTitle,pageSubTitle,pageContent,pageUrl,aboutUsImage,aboutUsSubTitle,aboutUsDesc,aboutUsBrowSec1,aboutUsBrowSec2,aboutUsBrowSec3);
}

@override
String toString() {
    return 'CmsData(id: $id, status: $status, pageTitle: $pageTitle, pageSubTitle: $pageSubTitle, pageContent: $pageContent, pageUrl: $pageUrl, aboutUsImage: $aboutUsImage, aboutUsSubTitle: $aboutUsSubTitle, aboutUsDesc: $aboutUsDesc, aboutUsBrowSec1: $aboutUsBrowSec1, aboutUsBrowSec2: $aboutUsBrowSec2, aboutUsBrowSec3: $aboutUsBrowSec3)';
}


}

/// @nodoc
abstract mixin class _$CmsDataCopyWith<$Res> implements $CmsDataCopyWith<$Res> {
  factory _$CmsDataCopyWith(_CmsData value, $Res Function(_CmsData) _then) = __$CmsDataCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? status,@JsonKey(name: 'page_title') String? pageTitle,@JsonKey(name: 'page_sub_title') String? pageSubTitle,@JsonKey(name: 'page_content') String? pageContent,@JsonKey(name: 'page_url') String? pageUrl,@JsonKey(name: 'about_us_image') String? aboutUsImage,@JsonKey(name: 'about_us_sub_title') String? aboutUsSubTitle,@JsonKey(name: 'about_us_desc') String? aboutUsDesc,@JsonKey(name: 'about_us_brow_sec1') String? aboutUsBrowSec1,@JsonKey(name: 'about_us_brow_sec2') String? aboutUsBrowSec2,@JsonKey(name: 'about_us_brow_sec3') String? aboutUsBrowSec3
});




}
/// @nodoc
class __$CmsDataCopyWithImpl<$Res>
    implements _$CmsDataCopyWith<$Res> {
  __$CmsDataCopyWithImpl(this._self, this._then);

  final _CmsData _self;
  final $Res Function(_CmsData) _then;

/// Create a copy of CmsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? status = freezed,Object? pageTitle = freezed,Object? pageSubTitle = freezed,Object? pageContent = freezed,Object? pageUrl = freezed,Object? aboutUsImage = freezed,Object? aboutUsSubTitle = freezed,Object? aboutUsDesc = freezed,Object? aboutUsBrowSec1 = freezed,Object? aboutUsBrowSec2 = freezed,Object? aboutUsBrowSec3 = freezed,}) {
  return _then(_CmsData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,pageTitle: freezed == pageTitle ? _self.pageTitle : pageTitle // ignore: cast_nullable_to_non_nullable
as String?,pageSubTitle: freezed == pageSubTitle ? _self.pageSubTitle : pageSubTitle // ignore: cast_nullable_to_non_nullable
as String?,pageContent: freezed == pageContent ? _self.pageContent : pageContent // ignore: cast_nullable_to_non_nullable
as String?,pageUrl: freezed == pageUrl ? _self.pageUrl : pageUrl // ignore: cast_nullable_to_non_nullable
as String?,aboutUsImage: freezed == aboutUsImage ? _self.aboutUsImage : aboutUsImage // ignore: cast_nullable_to_non_nullable
as String?,aboutUsSubTitle: freezed == aboutUsSubTitle ? _self.aboutUsSubTitle : aboutUsSubTitle // ignore: cast_nullable_to_non_nullable
as String?,aboutUsDesc: freezed == aboutUsDesc ? _self.aboutUsDesc : aboutUsDesc // ignore: cast_nullable_to_non_nullable
as String?,aboutUsBrowSec1: freezed == aboutUsBrowSec1 ? _self.aboutUsBrowSec1 : aboutUsBrowSec1 // ignore: cast_nullable_to_non_nullable
as String?,aboutUsBrowSec2: freezed == aboutUsBrowSec2 ? _self.aboutUsBrowSec2 : aboutUsBrowSec2 // ignore: cast_nullable_to_non_nullable
as String?,aboutUsBrowSec3: freezed == aboutUsBrowSec3 ? _self.aboutUsBrowSec3 : aboutUsBrowSec3 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
