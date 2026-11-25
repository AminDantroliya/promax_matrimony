// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_interest_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiInterestSettingsResponse {

 int? get code; String? get status; String? get message;
/// Create a copy of AiInterestSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiInterestSettingsResponseCopyWith<AiInterestSettingsResponse> get copyWith => _$AiInterestSettingsResponseCopyWithImpl<AiInterestSettingsResponse>(this as AiInterestSettingsResponse, _$identity);

  /// Serializes this AiInterestSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AiInterestSettingsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiInterestSettingsResponse&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AiInterestSettingsResponse;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message);
}

@override
String toString() {
  final _this = this as AiInterestSettingsResponse;
  return 'AiInterestSettingsResponse(code: ${_this.code}, status: ${_this.status}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $AiInterestSettingsResponseCopyWith<$Res>  {
  factory $AiInterestSettingsResponseCopyWith(AiInterestSettingsResponse value, $Res Function(AiInterestSettingsResponse) _then) = _$AiInterestSettingsResponseCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message
});




}
/// @nodoc
class _$AiInterestSettingsResponseCopyWithImpl<$Res>
    implements $AiInterestSettingsResponseCopyWith<$Res> {
  _$AiInterestSettingsResponseCopyWithImpl(this._self, this._then);

  final AiInterestSettingsResponse _self;
  final $Res Function(AiInterestSettingsResponse) _then;

/// Create a copy of AiInterestSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,}) {
  return _then(AiInterestSettingsResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiInterestSettingsResponse].
extension AiInterestSettingsResponsePatterns on AiInterestSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiInterestSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiInterestSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiInterestSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiInterestSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiInterestSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiInterestSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiInterestSettingsResponse() when $default != null:
return $default(_that.code,_that.status,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AiInterestSettingsResponse():
return $default(_that.code,_that.status,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AiInterestSettingsResponse() when $default != null:
return $default(_that.code,_that.status,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiInterestSettingsResponse implements AiInterestSettingsResponse {
  const _AiInterestSettingsResponse({this.code, this.status, this.message});
  factory _AiInterestSettingsResponse.fromJson(Map<String, dynamic> json) => _$AiInterestSettingsResponseFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;

/// Create a copy of AiInterestSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiInterestSettingsResponseCopyWith<_AiInterestSettingsResponse> get copyWith => __$AiInterestSettingsResponseCopyWithImpl<_AiInterestSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiInterestSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiInterestSettingsResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message);
}

@override
String toString() {
    return 'AiInterestSettingsResponse(code: $code, status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AiInterestSettingsResponseCopyWith<$Res> implements $AiInterestSettingsResponseCopyWith<$Res> {
  factory _$AiInterestSettingsResponseCopyWith(_AiInterestSettingsResponse value, $Res Function(_AiInterestSettingsResponse) _then) = __$AiInterestSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message
});




}
/// @nodoc
class __$AiInterestSettingsResponseCopyWithImpl<$Res>
    implements _$AiInterestSettingsResponseCopyWith<$Res> {
  __$AiInterestSettingsResponseCopyWithImpl(this._self, this._then);

  final _AiInterestSettingsResponse _self;
  final $Res Function(_AiInterestSettingsResponse) _then;

/// Create a copy of AiInterestSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,}) {
  return _then(_AiInterestSettingsResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AiInterestListResponse {

 int? get code; String? get status; String? get message; AiInterestListData? get data;
/// Create a copy of AiInterestListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiInterestListResponseCopyWith<AiInterestListResponse> get copyWith => _$AiInterestListResponseCopyWithImpl<AiInterestListResponse>(this as AiInterestListResponse, _$identity);

  /// Serializes this AiInterestListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AiInterestListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiInterestListResponse&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AiInterestListResponse;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as AiInterestListResponse;
  return 'AiInterestListResponse(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $AiInterestListResponseCopyWith<$Res>  {
  factory $AiInterestListResponseCopyWith(AiInterestListResponse value, $Res Function(AiInterestListResponse) _then) = _$AiInterestListResponseCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, AiInterestListData? data
});


$AiInterestListDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$AiInterestListResponseCopyWithImpl<$Res>
    implements $AiInterestListResponseCopyWith<$Res> {
  _$AiInterestListResponseCopyWithImpl(this._self, this._then);

  final AiInterestListResponse _self;
  final $Res Function(AiInterestListResponse) _then;

/// Create a copy of AiInterestListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(AiInterestListResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AiInterestListData?,
  ));
}
/// Create a copy of AiInterestListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiInterestListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AiInterestListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiInterestListResponse].
extension AiInterestListResponsePatterns on AiInterestListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiInterestListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiInterestListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiInterestListResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiInterestListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiInterestListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiInterestListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  AiInterestListData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiInterestListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  AiInterestListData? data)  $default,) {final _that = this;
switch (_that) {
case _AiInterestListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  AiInterestListData? data)?  $default,) {final _that = this;
switch (_that) {
case _AiInterestListResponse() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiInterestListResponse implements AiInterestListResponse {
  const _AiInterestListResponse({this.code, this.status, this.message, this.data});
  factory _AiInterestListResponse.fromJson(Map<String, dynamic> json) => _$AiInterestListResponseFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  AiInterestListData? data;

/// Create a copy of AiInterestListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiInterestListResponseCopyWith<_AiInterestListResponse> get copyWith => __$AiInterestListResponseCopyWithImpl<_AiInterestListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiInterestListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiInterestListResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'AiInterestListResponse(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AiInterestListResponseCopyWith<$Res> implements $AiInterestListResponseCopyWith<$Res> {
  factory _$AiInterestListResponseCopyWith(_AiInterestListResponse value, $Res Function(_AiInterestListResponse) _then) = __$AiInterestListResponseCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, AiInterestListData? data
});


@override $AiInterestListDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$AiInterestListResponseCopyWithImpl<$Res>
    implements _$AiInterestListResponseCopyWith<$Res> {
  __$AiInterestListResponseCopyWithImpl(this._self, this._then);

  final _AiInterestListResponse _self;
  final $Res Function(_AiInterestListResponse) _then;

/// Create a copy of AiInterestListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_AiInterestListResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AiInterestListData?,
  ));
}

/// Create a copy of AiInterestListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiInterestListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AiInterestListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AiInterestListData {

 int? get resultCount;@JsonKey(name: 'resultList') List<AiInterestMatch>? get resultList;
/// Create a copy of AiInterestListData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiInterestListDataCopyWith<AiInterestListData> get copyWith => _$AiInterestListDataCopyWithImpl<AiInterestListData>(this as AiInterestListData, _$identity);

  /// Serializes this AiInterestListData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AiInterestListData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiInterestListData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AiInterestListData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as AiInterestListData;
  return 'AiInterestListData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $AiInterestListDataCopyWith<$Res>  {
  factory $AiInterestListDataCopyWith(AiInterestListData value, $Res Function(AiInterestListData) _then) = _$AiInterestListDataCopyWithImpl;
@useResult
$Res call({
 int? resultCount,@JsonKey(name: 'resultList') List<AiInterestMatch>? resultList
});




}
/// @nodoc
class _$AiInterestListDataCopyWithImpl<$Res>
    implements $AiInterestListDataCopyWith<$Res> {
  _$AiInterestListDataCopyWithImpl(this._self, this._then);

  final AiInterestListData _self;
  final $Res Function(AiInterestListData) _then;

/// Create a copy of AiInterestListData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(AiInterestListData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<AiInterestMatch>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiInterestListData].
extension AiInterestListDataPatterns on AiInterestListData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiInterestListData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiInterestListData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiInterestListData value)  $default,){
final _that = this;
switch (_that) {
case _AiInterestListData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiInterestListData value)?  $default,){
final _that = this;
switch (_that) {
case _AiInterestListData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? resultCount, @JsonKey(name: 'resultList')  List<AiInterestMatch>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiInterestListData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? resultCount, @JsonKey(name: 'resultList')  List<AiInterestMatch>? resultList)  $default,) {final _that = this;
switch (_that) {
case _AiInterestListData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? resultCount, @JsonKey(name: 'resultList')  List<AiInterestMatch>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _AiInterestListData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiInterestListData implements AiInterestListData {
  const _AiInterestListData({this.resultCount, @JsonKey(name: 'resultList')  List<AiInterestMatch>? resultList}): _resultList = resultList;
  factory _AiInterestListData.fromJson(Map<String, dynamic> json) => _$AiInterestListDataFromJson(json);

@override final  int? resultCount;
 final  List<AiInterestMatch>? _resultList;
@override@JsonKey(name: 'resultList') List<AiInterestMatch>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AiInterestListData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiInterestListDataCopyWith<_AiInterestListData> get copyWith => __$AiInterestListDataCopyWithImpl<_AiInterestListData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiInterestListDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiInterestListData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'AiInterestListData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$AiInterestListDataCopyWith<$Res> implements $AiInterestListDataCopyWith<$Res> {
  factory _$AiInterestListDataCopyWith(_AiInterestListData value, $Res Function(_AiInterestListData) _then) = __$AiInterestListDataCopyWithImpl;
@override @useResult
$Res call({
 int? resultCount,@JsonKey(name: 'resultList') List<AiInterestMatch>? resultList
});




}
/// @nodoc
class __$AiInterestListDataCopyWithImpl<$Res>
    implements _$AiInterestListDataCopyWith<$Res> {
  __$AiInterestListDataCopyWithImpl(this._self, this._then);

  final _AiInterestListData _self;
  final $Res Function(_AiInterestListData) _then;

/// Create a copy of AiInterestListData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_AiInterestListData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<AiInterestMatch>?,
  ));
}


}


/// @nodoc
mixin _$AiInterestMatch {

 int? get id;@JsonKey(name: 'member_id') int? get memberId;@JsonKey(name: 'matched_member_id') int? get matchedMemberId; int? get score;@JsonKey(name: 'match_date') String? get matchDate;@JsonKey(name: 'queue_status') bool? get queueStatus;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'profile_title') String? get profileTitle;@JsonKey(name: 'sub_title') String? get subTitle;@JsonKey(name: 'profile_image') String? get profileImage;@JsonKey(name: 'is_photo_protected') bool? get isPhotoProtected;@JsonKey(name: 'is_shortlisted') bool? get isShortlisted;@JsonKey(name: 'is_interest') bool? get isInterest;@JsonKey(name: 'isBlocked') bool? get isBlocked;@JsonKey(name: 'is_online') String? get isOnline;@JsonKey(name: 'is_online_text') String? get isOnlineText;@JsonKey(name: 'matchPercent') dynamic get matchPercent;@JsonKey(name: 'matched_member') Map<String, dynamic>? get matchedMember;
/// Create a copy of AiInterestMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiInterestMatchCopyWith<AiInterestMatch> get copyWith => _$AiInterestMatchCopyWithImpl<AiInterestMatch>(this as AiInterestMatch, _$identity);

  /// Serializes this AiInterestMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AiInterestMatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiInterestMatch&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.memberId, _this.memberId) || other.memberId == _this.memberId)&&(identical(other.matchedMemberId, _this.matchedMemberId) || other.matchedMemberId == _this.matchedMemberId)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.matchDate, _this.matchDate) || other.matchDate == _this.matchDate)&&(identical(other.queueStatus, _this.queueStatus) || other.queueStatus == _this.queueStatus)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.profileTitle, _this.profileTitle) || other.profileTitle == _this.profileTitle)&&(identical(other.subTitle, _this.subTitle) || other.subTitle == _this.subTitle)&&(identical(other.profileImage, _this.profileImage) || other.profileImage == _this.profileImage)&&(identical(other.isPhotoProtected, _this.isPhotoProtected) || other.isPhotoProtected == _this.isPhotoProtected)&&(identical(other.isShortlisted, _this.isShortlisted) || other.isShortlisted == _this.isShortlisted)&&(identical(other.isInterest, _this.isInterest) || other.isInterest == _this.isInterest)&&(identical(other.isBlocked, _this.isBlocked) || other.isBlocked == _this.isBlocked)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.isOnlineText, _this.isOnlineText) || other.isOnlineText == _this.isOnlineText)&&const DeepCollectionEquality().equals(other.matchPercent, _this.matchPercent)&&const DeepCollectionEquality().equals(other.matchedMember, _this.matchedMember));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AiInterestMatch;
  return Object.hashAll([runtimeType,_this.id,_this.memberId,_this.matchedMemberId,_this.score,_this.matchDate,_this.queueStatus,_this.createdAt,_this.updatedAt,_this.profileTitle,_this.subTitle,_this.profileImage,_this.isPhotoProtected,_this.isShortlisted,_this.isInterest,_this.isBlocked,_this.isOnline,_this.isOnlineText,const DeepCollectionEquality().hash(_this.matchPercent),const DeepCollectionEquality().hash(_this.matchedMember)]);
}

@override
String toString() {
  final _this = this as AiInterestMatch;
  return 'AiInterestMatch(id: ${_this.id}, memberId: ${_this.memberId}, matchedMemberId: ${_this.matchedMemberId}, score: ${_this.score}, matchDate: ${_this.matchDate}, queueStatus: ${_this.queueStatus}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, profileTitle: ${_this.profileTitle}, subTitle: ${_this.subTitle}, profileImage: ${_this.profileImage}, isPhotoProtected: ${_this.isPhotoProtected}, isShortlisted: ${_this.isShortlisted}, isInterest: ${_this.isInterest}, isBlocked: ${_this.isBlocked}, isOnline: ${_this.isOnline}, isOnlineText: ${_this.isOnlineText}, matchPercent: ${_this.matchPercent}, matchedMember: ${_this.matchedMember})';
}


}

/// @nodoc
abstract mixin class $AiInterestMatchCopyWith<$Res>  {
  factory $AiInterestMatchCopyWith(AiInterestMatch value, $Res Function(AiInterestMatch) _then) = _$AiInterestMatchCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'member_id') int? memberId,@JsonKey(name: 'matched_member_id') int? matchedMemberId, int? score,@JsonKey(name: 'match_date') String? matchDate,@JsonKey(name: 'queue_status') bool? queueStatus,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'is_photo_protected') bool? isPhotoProtected,@JsonKey(name: 'is_shortlisted') bool? isShortlisted,@JsonKey(name: 'is_interest') bool? isInterest,@JsonKey(name: 'isBlocked') bool? isBlocked,@JsonKey(name: 'is_online') String? isOnline,@JsonKey(name: 'is_online_text') String? isOnlineText,@JsonKey(name: 'matchPercent') dynamic matchPercent,@JsonKey(name: 'matched_member') Map<String, dynamic>? matchedMember
});




}
/// @nodoc
class _$AiInterestMatchCopyWithImpl<$Res>
    implements $AiInterestMatchCopyWith<$Res> {
  _$AiInterestMatchCopyWithImpl(this._self, this._then);

  final AiInterestMatch _self;
  final $Res Function(AiInterestMatch) _then;

/// Create a copy of AiInterestMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? memberId = freezed,Object? matchedMemberId = freezed,Object? score = freezed,Object? matchDate = freezed,Object? queueStatus = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtected = freezed,Object? isShortlisted = freezed,Object? isInterest = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? isOnlineText = freezed,Object? matchPercent = freezed,Object? matchedMember = freezed,}) {
  return _then(AiInterestMatch(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int?,matchedMemberId: freezed == matchedMemberId ? _self.matchedMemberId : matchedMemberId // ignore: cast_nullable_to_non_nullable
as int?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,matchDate: freezed == matchDate ? _self.matchDate : matchDate // ignore: cast_nullable_to_non_nullable
as String?,queueStatus: freezed == queueStatus ? _self.queueStatus : queueStatus // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as bool?,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as bool?,isInterest: freezed == isInterest ? _self.isInterest : isInterest // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as String?,isOnlineText: freezed == isOnlineText ? _self.isOnlineText : isOnlineText // ignore: cast_nullable_to_non_nullable
as String?,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,matchedMember: freezed == matchedMember ? _self.matchedMember : matchedMember // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiInterestMatch].
extension AiInterestMatchPatterns on AiInterestMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiInterestMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiInterestMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiInterestMatch value)  $default,){
final _that = this;
switch (_that) {
case _AiInterestMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiInterestMatch value)?  $default,){
final _that = this;
switch (_that) {
case _AiInterestMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'member_id')  int? memberId, @JsonKey(name: 'matched_member_id')  int? matchedMemberId,  int? score, @JsonKey(name: 'match_date')  String? matchDate, @JsonKey(name: 'queue_status')  bool? queueStatus, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtected, @JsonKey(name: 'is_shortlisted')  bool? isShortlisted, @JsonKey(name: 'is_interest')  bool? isInterest, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'is_online_text')  String? isOnlineText, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'matched_member')  Map<String, dynamic>? matchedMember)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiInterestMatch() when $default != null:
return $default(_that.id,_that.memberId,_that.matchedMemberId,_that.score,_that.matchDate,_that.queueStatus,_that.createdAt,_that.updatedAt,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtected,_that.isShortlisted,_that.isInterest,_that.isBlocked,_that.isOnline,_that.isOnlineText,_that.matchPercent,_that.matchedMember);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'member_id')  int? memberId, @JsonKey(name: 'matched_member_id')  int? matchedMemberId,  int? score, @JsonKey(name: 'match_date')  String? matchDate, @JsonKey(name: 'queue_status')  bool? queueStatus, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtected, @JsonKey(name: 'is_shortlisted')  bool? isShortlisted, @JsonKey(name: 'is_interest')  bool? isInterest, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'is_online_text')  String? isOnlineText, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'matched_member')  Map<String, dynamic>? matchedMember)  $default,) {final _that = this;
switch (_that) {
case _AiInterestMatch():
return $default(_that.id,_that.memberId,_that.matchedMemberId,_that.score,_that.matchDate,_that.queueStatus,_that.createdAt,_that.updatedAt,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtected,_that.isShortlisted,_that.isInterest,_that.isBlocked,_that.isOnline,_that.isOnlineText,_that.matchPercent,_that.matchedMember);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'member_id')  int? memberId, @JsonKey(name: 'matched_member_id')  int? matchedMemberId,  int? score, @JsonKey(name: 'match_date')  String? matchDate, @JsonKey(name: 'queue_status')  bool? queueStatus, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'profile_title')  String? profileTitle, @JsonKey(name: 'sub_title')  String? subTitle, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'is_photo_protected')  bool? isPhotoProtected, @JsonKey(name: 'is_shortlisted')  bool? isShortlisted, @JsonKey(name: 'is_interest')  bool? isInterest, @JsonKey(name: 'isBlocked')  bool? isBlocked, @JsonKey(name: 'is_online')  String? isOnline, @JsonKey(name: 'is_online_text')  String? isOnlineText, @JsonKey(name: 'matchPercent')  dynamic matchPercent, @JsonKey(name: 'matched_member')  Map<String, dynamic>? matchedMember)?  $default,) {final _that = this;
switch (_that) {
case _AiInterestMatch() when $default != null:
return $default(_that.id,_that.memberId,_that.matchedMemberId,_that.score,_that.matchDate,_that.queueStatus,_that.createdAt,_that.updatedAt,_that.profileTitle,_that.subTitle,_that.profileImage,_that.isPhotoProtected,_that.isShortlisted,_that.isInterest,_that.isBlocked,_that.isOnline,_that.isOnlineText,_that.matchPercent,_that.matchedMember);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiInterestMatch implements AiInterestMatch {
  const _AiInterestMatch({this.id, @JsonKey(name: 'member_id') this.memberId, @JsonKey(name: 'matched_member_id') this.matchedMemberId, this.score, @JsonKey(name: 'match_date') this.matchDate, @JsonKey(name: 'queue_status') this.queueStatus, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'profile_title') this.profileTitle, @JsonKey(name: 'sub_title') this.subTitle, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'is_photo_protected') this.isPhotoProtected, @JsonKey(name: 'is_shortlisted') this.isShortlisted, @JsonKey(name: 'is_interest') this.isInterest, @JsonKey(name: 'isBlocked') this.isBlocked, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'is_online_text') this.isOnlineText, @JsonKey(name: 'matchPercent') this.matchPercent, @JsonKey(name: 'matched_member')  Map<String, dynamic>? matchedMember}): _matchedMember = matchedMember;
  factory _AiInterestMatch.fromJson(Map<String, dynamic> json) => _$AiInterestMatchFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'member_id') final  int? memberId;
@override@JsonKey(name: 'matched_member_id') final  int? matchedMemberId;
@override final  int? score;
@override@JsonKey(name: 'match_date') final  String? matchDate;
@override@JsonKey(name: 'queue_status') final  bool? queueStatus;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'profile_title') final  String? profileTitle;
@override@JsonKey(name: 'sub_title') final  String? subTitle;
@override@JsonKey(name: 'profile_image') final  String? profileImage;
@override@JsonKey(name: 'is_photo_protected') final  bool? isPhotoProtected;
@override@JsonKey(name: 'is_shortlisted') final  bool? isShortlisted;
@override@JsonKey(name: 'is_interest') final  bool? isInterest;
@override@JsonKey(name: 'isBlocked') final  bool? isBlocked;
@override@JsonKey(name: 'is_online') final  String? isOnline;
@override@JsonKey(name: 'is_online_text') final  String? isOnlineText;
@override@JsonKey(name: 'matchPercent') final  dynamic matchPercent;
 final  Map<String, dynamic>? _matchedMember;
@override@JsonKey(name: 'matched_member') Map<String, dynamic>? get matchedMember {
  final value = _matchedMember;
  if (value == null) return null;
  if (_matchedMember is EqualUnmodifiableMapView) return _matchedMember;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AiInterestMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiInterestMatchCopyWith<_AiInterestMatch> get copyWith => __$AiInterestMatchCopyWithImpl<_AiInterestMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiInterestMatchToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiInterestMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.matchedMemberId, matchedMemberId) || other.matchedMemberId == matchedMemberId)&&(identical(other.score, score) || other.score == score)&&(identical(other.matchDate, matchDate) || other.matchDate == matchDate)&&(identical(other.queueStatus, queueStatus) || other.queueStatus == queueStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.profileTitle, profileTitle) || other.profileTitle == profileTitle)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isPhotoProtected, isPhotoProtected) || other.isPhotoProtected == isPhotoProtected)&&(identical(other.isShortlisted, isShortlisted) || other.isShortlisted == isShortlisted)&&(identical(other.isInterest, isInterest) || other.isInterest == isInterest)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isOnlineText, isOnlineText) || other.isOnlineText == isOnlineText)&&const DeepCollectionEquality().equals(other.matchPercent, matchPercent)&&const DeepCollectionEquality().equals(other.matchedMember, _matchedMember));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,memberId,matchedMemberId,score,matchDate,queueStatus,createdAt,updatedAt,profileTitle,subTitle,profileImage,isPhotoProtected,isShortlisted,isInterest,isBlocked,isOnline,isOnlineText,const DeepCollectionEquality().hash(matchPercent),const DeepCollectionEquality().hash(_matchedMember)]);
}

@override
String toString() {
    return 'AiInterestMatch(id: $id, memberId: $memberId, matchedMemberId: $matchedMemberId, score: $score, matchDate: $matchDate, queueStatus: $queueStatus, createdAt: $createdAt, updatedAt: $updatedAt, profileTitle: $profileTitle, subTitle: $subTitle, profileImage: $profileImage, isPhotoProtected: $isPhotoProtected, isShortlisted: $isShortlisted, isInterest: $isInterest, isBlocked: $isBlocked, isOnline: $isOnline, isOnlineText: $isOnlineText, matchPercent: $matchPercent, matchedMember: $matchedMember)';
}


}

/// @nodoc
abstract mixin class _$AiInterestMatchCopyWith<$Res> implements $AiInterestMatchCopyWith<$Res> {
  factory _$AiInterestMatchCopyWith(_AiInterestMatch value, $Res Function(_AiInterestMatch) _then) = __$AiInterestMatchCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'member_id') int? memberId,@JsonKey(name: 'matched_member_id') int? matchedMemberId, int? score,@JsonKey(name: 'match_date') String? matchDate,@JsonKey(name: 'queue_status') bool? queueStatus,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'profile_title') String? profileTitle,@JsonKey(name: 'sub_title') String? subTitle,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'is_photo_protected') bool? isPhotoProtected,@JsonKey(name: 'is_shortlisted') bool? isShortlisted,@JsonKey(name: 'is_interest') bool? isInterest,@JsonKey(name: 'isBlocked') bool? isBlocked,@JsonKey(name: 'is_online') String? isOnline,@JsonKey(name: 'is_online_text') String? isOnlineText,@JsonKey(name: 'matchPercent') dynamic matchPercent,@JsonKey(name: 'matched_member') Map<String, dynamic>? matchedMember
});




}
/// @nodoc
class __$AiInterestMatchCopyWithImpl<$Res>
    implements _$AiInterestMatchCopyWith<$Res> {
  __$AiInterestMatchCopyWithImpl(this._self, this._then);

  final _AiInterestMatch _self;
  final $Res Function(_AiInterestMatch) _then;

/// Create a copy of AiInterestMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? memberId = freezed,Object? matchedMemberId = freezed,Object? score = freezed,Object? matchDate = freezed,Object? queueStatus = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? profileTitle = freezed,Object? subTitle = freezed,Object? profileImage = freezed,Object? isPhotoProtected = freezed,Object? isShortlisted = freezed,Object? isInterest = freezed,Object? isBlocked = freezed,Object? isOnline = freezed,Object? isOnlineText = freezed,Object? matchPercent = freezed,Object? matchedMember = freezed,}) {
  return _then(_AiInterestMatch(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int?,matchedMemberId: freezed == matchedMemberId ? _self.matchedMemberId : matchedMemberId // ignore: cast_nullable_to_non_nullable
as int?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,matchDate: freezed == matchDate ? _self.matchDate : matchDate // ignore: cast_nullable_to_non_nullable
as String?,queueStatus: freezed == queueStatus ? _self.queueStatus : queueStatus // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,profileTitle: freezed == profileTitle ? _self.profileTitle : profileTitle // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,isPhotoProtected: freezed == isPhotoProtected ? _self.isPhotoProtected : isPhotoProtected // ignore: cast_nullable_to_non_nullable
as bool?,isShortlisted: freezed == isShortlisted ? _self.isShortlisted : isShortlisted // ignore: cast_nullable_to_non_nullable
as bool?,isInterest: freezed == isInterest ? _self.isInterest : isInterest // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as String?,isOnlineText: freezed == isOnlineText ? _self.isOnlineText : isOnlineText // ignore: cast_nullable_to_non_nullable
as String?,matchPercent: freezed == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as dynamic,matchedMember: freezed == matchedMember ? _self._matchedMember : matchedMember // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
