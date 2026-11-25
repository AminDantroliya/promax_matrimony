// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matches_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchesListResponseModel {

 int? get code; String? get status; String? get message; MatchesData? get data;
/// Create a copy of MatchesListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchesListResponseModelCopyWith<MatchesListResponseModel> get copyWith => _$MatchesListResponseModelCopyWithImpl<MatchesListResponseModel>(this as MatchesListResponseModel, _$identity);

  /// Serializes this MatchesListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MatchesListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchesListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchesListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as MatchesListResponseModel;
  return 'MatchesListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $MatchesListResponseModelCopyWith<$Res>  {
  factory $MatchesListResponseModelCopyWith(MatchesListResponseModel value, $Res Function(MatchesListResponseModel) _then) = _$MatchesListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, MatchesData? data
});


$MatchesDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$MatchesListResponseModelCopyWithImpl<$Res>
    implements $MatchesListResponseModelCopyWith<$Res> {
  _$MatchesListResponseModelCopyWithImpl(this._self, this._then);

  final MatchesListResponseModel _self;
  final $Res Function(MatchesListResponseModel) _then;

/// Create a copy of MatchesListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(MatchesListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MatchesData?,
  ));
}
/// Create a copy of MatchesListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchesDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MatchesDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchesListResponseModel].
extension MatchesListResponseModelPatterns on MatchesListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchesListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchesListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchesListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _MatchesListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchesListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _MatchesListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  MatchesData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchesListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  MatchesData? data)  $default,) {final _that = this;
switch (_that) {
case _MatchesListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  MatchesData? data)?  $default,) {final _that = this;
switch (_that) {
case _MatchesListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchesListResponseModel implements MatchesListResponseModel {
  const _MatchesListResponseModel({this.code, this.status, this.message, this.data});
  factory _MatchesListResponseModel.fromJson(Map<String, dynamic> json) => _$MatchesListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  MatchesData? data;

/// Create a copy of MatchesListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchesListResponseModelCopyWith<_MatchesListResponseModel> get copyWith => __$MatchesListResponseModelCopyWithImpl<_MatchesListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchesListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchesListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'MatchesListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MatchesListResponseModelCopyWith<$Res> implements $MatchesListResponseModelCopyWith<$Res> {
  factory _$MatchesListResponseModelCopyWith(_MatchesListResponseModel value, $Res Function(_MatchesListResponseModel) _then) = __$MatchesListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, MatchesData? data
});


@override $MatchesDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$MatchesListResponseModelCopyWithImpl<$Res>
    implements _$MatchesListResponseModelCopyWith<$Res> {
  __$MatchesListResponseModelCopyWithImpl(this._self, this._then);

  final _MatchesListResponseModel _self;
  final $Res Function(_MatchesListResponseModel) _then;

/// Create a copy of MatchesListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_MatchesListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MatchesData?,
  ));
}

/// Create a copy of MatchesListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchesDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MatchesDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$MatchesData {

@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount) int? get resultCount;@JsonKey(name: 'resultList', readValue: _readMatchesResultList) List<MemberListModel>? get resultList;
/// Create a copy of MatchesData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchesDataCopyWith<MatchesData> get copyWith => _$MatchesDataCopyWithImpl<MatchesData>(this as MatchesData, _$identity);

  /// Serializes this MatchesData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MatchesData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchesData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchesData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as MatchesData;
  return 'MatchesData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $MatchesDataCopyWith<$Res>  {
  factory $MatchesDataCopyWith(MatchesData value, $Res Function(MatchesData) _then) = _$MatchesDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount) int? resultCount,@JsonKey(name: 'resultList', readValue: _readMatchesResultList) List<MemberListModel>? resultList
});




}
/// @nodoc
class _$MatchesDataCopyWithImpl<$Res>
    implements $MatchesDataCopyWith<$Res> {
  _$MatchesDataCopyWithImpl(this._self, this._then);

  final MatchesData _self;
  final $Res Function(MatchesData) _then;

/// Create a copy of MatchesData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(MatchesData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchesData].
extension MatchesDataPatterns on MatchesData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchesData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchesData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchesData value)  $default,){
final _that = this;
switch (_that) {
case _MatchesData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchesData value)?  $default,){
final _that = this;
switch (_that) {
case _MatchesData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount)  int? resultCount, @JsonKey(name: 'resultList', readValue: _readMatchesResultList)  List<MemberListModel>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchesData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount)  int? resultCount, @JsonKey(name: 'resultList', readValue: _readMatchesResultList)  List<MemberListModel>? resultList)  $default,) {final _that = this;
switch (_that) {
case _MatchesData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount)  int? resultCount, @JsonKey(name: 'resultList', readValue: _readMatchesResultList)  List<MemberListModel>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _MatchesData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchesData implements MatchesData {
  const _MatchesData({@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount) this.resultCount, @JsonKey(name: 'resultList', readValue: _readMatchesResultList)  List<MemberListModel>? resultList}): _resultList = resultList;
  factory _MatchesData.fromJson(Map<String, dynamic> json) => _$MatchesDataFromJson(json);

@override@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount) final  int? resultCount;
 final  List<MemberListModel>? _resultList;
@override@JsonKey(name: 'resultList', readValue: _readMatchesResultList) List<MemberListModel>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MatchesData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchesDataCopyWith<_MatchesData> get copyWith => __$MatchesDataCopyWithImpl<_MatchesData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchesDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchesData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'MatchesData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$MatchesDataCopyWith<$Res> implements $MatchesDataCopyWith<$Res> {
  factory _$MatchesDataCopyWith(_MatchesData value, $Res Function(_MatchesData) _then) = __$MatchesDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultCount', readValue: _readMatchesResultCount) int? resultCount,@JsonKey(name: 'resultList', readValue: _readMatchesResultList) List<MemberListModel>? resultList
});




}
/// @nodoc
class __$MatchesDataCopyWithImpl<$Res>
    implements _$MatchesDataCopyWith<$Res> {
  __$MatchesDataCopyWithImpl(this._self, this._then);

  final _MatchesData _self;
  final $Res Function(_MatchesData) _then;

/// Create a copy of MatchesData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_MatchesData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,
  ));
}


}

// dart format on
