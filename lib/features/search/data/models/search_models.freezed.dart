// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchResultListResponseModel {

 int? get code; String? get status; String? get message; SearchResultData? get data;
/// Create a copy of SearchResultListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultListResponseModelCopyWith<SearchResultListResponseModel> get copyWith => _$SearchResultListResponseModelCopyWithImpl<SearchResultListResponseModel>(this as SearchResultListResponseModel, _$identity);

  /// Serializes this SearchResultListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SearchResultListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SearchResultListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as SearchResultListResponseModel;
  return 'SearchResultListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SearchResultListResponseModelCopyWith<$Res>  {
  factory $SearchResultListResponseModelCopyWith(SearchResultListResponseModel value, $Res Function(SearchResultListResponseModel) _then) = _$SearchResultListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, SearchResultData? data
});


$SearchResultDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SearchResultListResponseModelCopyWithImpl<$Res>
    implements $SearchResultListResponseModelCopyWith<$Res> {
  _$SearchResultListResponseModelCopyWithImpl(this._self, this._then);

  final SearchResultListResponseModel _self;
  final $Res Function(SearchResultListResponseModel) _then;

/// Create a copy of SearchResultListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(SearchResultListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SearchResultData?,
  ));
}
/// Create a copy of SearchResultListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchResultDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SearchResultDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchResultListResponseModel].
extension SearchResultListResponseModelPatterns on SearchResultListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SearchResultData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SearchResultData? data)  $default,) {final _that = this;
switch (_that) {
case _SearchResultListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  SearchResultData? data)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResultListResponseModel implements SearchResultListResponseModel {
  const _SearchResultListResponseModel({this.code, this.status, this.message, this.data});
  factory _SearchResultListResponseModel.fromJson(Map<String, dynamic> json) => _$SearchResultListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  SearchResultData? data;

/// Create a copy of SearchResultListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultListResponseModelCopyWith<_SearchResultListResponseModel> get copyWith => __$SearchResultListResponseModelCopyWithImpl<_SearchResultListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'SearchResultListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SearchResultListResponseModelCopyWith<$Res> implements $SearchResultListResponseModelCopyWith<$Res> {
  factory _$SearchResultListResponseModelCopyWith(_SearchResultListResponseModel value, $Res Function(_SearchResultListResponseModel) _then) = __$SearchResultListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, SearchResultData? data
});


@override $SearchResultDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SearchResultListResponseModelCopyWithImpl<$Res>
    implements _$SearchResultListResponseModelCopyWith<$Res> {
  __$SearchResultListResponseModelCopyWithImpl(this._self, this._then);

  final _SearchResultListResponseModel _self;
  final $Res Function(_SearchResultListResponseModel) _then;

/// Create a copy of SearchResultListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SearchResultListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SearchResultData?,
  ));
}

/// Create a copy of SearchResultListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchResultDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SearchResultDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SearchResultData {

@JsonKey(name: 'resultCount', readValue: _readSearchResultCount) int? get resultCount;@JsonKey(name: 'resultList', readValue: _readSearchResultList) List<MemberListModel>? get resultList;
/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultDataCopyWith<SearchResultData> get copyWith => _$SearchResultDataCopyWithImpl<SearchResultData>(this as SearchResultData, _$identity);

  /// Serializes this SearchResultData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SearchResultData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SearchResultData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as SearchResultData;
  return 'SearchResultData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $SearchResultDataCopyWith<$Res>  {
  factory $SearchResultDataCopyWith(SearchResultData value, $Res Function(SearchResultData) _then) = _$SearchResultDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultCount', readValue: _readSearchResultCount) int? resultCount,@JsonKey(name: 'resultList', readValue: _readSearchResultList) List<MemberListModel>? resultList
});




}
/// @nodoc
class _$SearchResultDataCopyWithImpl<$Res>
    implements $SearchResultDataCopyWith<$Res> {
  _$SearchResultDataCopyWithImpl(this._self, this._then);

  final SearchResultData _self;
  final $Res Function(SearchResultData) _then;

/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(SearchResultData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResultData].
extension SearchResultDataPatterns on SearchResultData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultData value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultData value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount', readValue: _readSearchResultCount)  int? resultCount, @JsonKey(name: 'resultList', readValue: _readSearchResultList)  List<MemberListModel>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount', readValue: _readSearchResultCount)  int? resultCount, @JsonKey(name: 'resultList', readValue: _readSearchResultList)  List<MemberListModel>? resultList)  $default,) {final _that = this;
switch (_that) {
case _SearchResultData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultCount', readValue: _readSearchResultCount)  int? resultCount, @JsonKey(name: 'resultList', readValue: _readSearchResultList)  List<MemberListModel>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResultData implements SearchResultData {
  const _SearchResultData({@JsonKey(name: 'resultCount', readValue: _readSearchResultCount) this.resultCount, @JsonKey(name: 'resultList', readValue: _readSearchResultList)  List<MemberListModel>? resultList}): _resultList = resultList;
  factory _SearchResultData.fromJson(Map<String, dynamic> json) => _$SearchResultDataFromJson(json);

@override@JsonKey(name: 'resultCount', readValue: _readSearchResultCount) final  int? resultCount;
 final  List<MemberListModel>? _resultList;
@override@JsonKey(name: 'resultList', readValue: _readSearchResultList) List<MemberListModel>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultDataCopyWith<_SearchResultData> get copyWith => __$SearchResultDataCopyWithImpl<_SearchResultData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'SearchResultData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$SearchResultDataCopyWith<$Res> implements $SearchResultDataCopyWith<$Res> {
  factory _$SearchResultDataCopyWith(_SearchResultData value, $Res Function(_SearchResultData) _then) = __$SearchResultDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultCount', readValue: _readSearchResultCount) int? resultCount,@JsonKey(name: 'resultList', readValue: _readSearchResultList) List<MemberListModel>? resultList
});




}
/// @nodoc
class __$SearchResultDataCopyWithImpl<$Res>
    implements _$SearchResultDataCopyWith<$Res> {
  __$SearchResultDataCopyWithImpl(this._self, this._then);

  final _SearchResultData _self;
  final $Res Function(_SearchResultData) _then;

/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_SearchResultData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,
  ));
}


}


/// @nodoc
mixin _$SavedSearchListResponseModel {

 int? get code; String? get status; String? get message; SavedSearchData? get data;
/// Create a copy of SavedSearchListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedSearchListResponseModelCopyWith<SavedSearchListResponseModel> get copyWith => _$SavedSearchListResponseModelCopyWithImpl<SavedSearchListResponseModel>(this as SavedSearchListResponseModel, _$identity);

  /// Serializes this SavedSearchListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedSearchListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedSearchListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedSearchListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as SavedSearchListResponseModel;
  return 'SavedSearchListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SavedSearchListResponseModelCopyWith<$Res>  {
  factory $SavedSearchListResponseModelCopyWith(SavedSearchListResponseModel value, $Res Function(SavedSearchListResponseModel) _then) = _$SavedSearchListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, SavedSearchData? data
});


$SavedSearchDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SavedSearchListResponseModelCopyWithImpl<$Res>
    implements $SavedSearchListResponseModelCopyWith<$Res> {
  _$SavedSearchListResponseModelCopyWithImpl(this._self, this._then);

  final SavedSearchListResponseModel _self;
  final $Res Function(SavedSearchListResponseModel) _then;

/// Create a copy of SavedSearchListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(SavedSearchListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SavedSearchData?,
  ));
}
/// Create a copy of SavedSearchListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedSearchDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SavedSearchDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedSearchListResponseModel].
extension SavedSearchListResponseModelPatterns on SavedSearchListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedSearchListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedSearchListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedSearchListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SavedSearchListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedSearchListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SavedSearchListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SavedSearchData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedSearchListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  SavedSearchData? data)  $default,) {final _that = this;
switch (_that) {
case _SavedSearchListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  SavedSearchData? data)?  $default,) {final _that = this;
switch (_that) {
case _SavedSearchListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedSearchListResponseModel implements SavedSearchListResponseModel {
  const _SavedSearchListResponseModel({this.code, this.status, this.message, this.data});
  factory _SavedSearchListResponseModel.fromJson(Map<String, dynamic> json) => _$SavedSearchListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  SavedSearchData? data;

/// Create a copy of SavedSearchListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedSearchListResponseModelCopyWith<_SavedSearchListResponseModel> get copyWith => __$SavedSearchListResponseModelCopyWithImpl<_SavedSearchListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedSearchListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedSearchListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'SavedSearchListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SavedSearchListResponseModelCopyWith<$Res> implements $SavedSearchListResponseModelCopyWith<$Res> {
  factory _$SavedSearchListResponseModelCopyWith(_SavedSearchListResponseModel value, $Res Function(_SavedSearchListResponseModel) _then) = __$SavedSearchListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, SavedSearchData? data
});


@override $SavedSearchDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SavedSearchListResponseModelCopyWithImpl<$Res>
    implements _$SavedSearchListResponseModelCopyWith<$Res> {
  __$SavedSearchListResponseModelCopyWithImpl(this._self, this._then);

  final _SavedSearchListResponseModel _self;
  final $Res Function(_SavedSearchListResponseModel) _then;

/// Create a copy of SavedSearchListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SavedSearchListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SavedSearchData?,
  ));
}

/// Create a copy of SavedSearchListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedSearchDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SavedSearchDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SavedSearchData {

@JsonKey(name: 'resultCount') int? get resultCount;@JsonKey(name: 'resultList') List<SavedSearchFilter>? get resultList;
/// Create a copy of SavedSearchData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedSearchDataCopyWith<SavedSearchData> get copyWith => _$SavedSearchDataCopyWithImpl<SavedSearchData>(this as SavedSearchData, _$identity);

  /// Serializes this SavedSearchData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedSearchData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedSearchData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedSearchData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as SavedSearchData;
  return 'SavedSearchData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $SavedSearchDataCopyWith<$Res>  {
  factory $SavedSearchDataCopyWith(SavedSearchData value, $Res Function(SavedSearchData) _then) = _$SavedSearchDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<SavedSearchFilter>? resultList
});




}
/// @nodoc
class _$SavedSearchDataCopyWithImpl<$Res>
    implements $SavedSearchDataCopyWith<$Res> {
  _$SavedSearchDataCopyWithImpl(this._self, this._then);

  final SavedSearchData _self;
  final $Res Function(SavedSearchData) _then;

/// Create a copy of SavedSearchData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(SavedSearchData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<SavedSearchFilter>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedSearchData].
extension SavedSearchDataPatterns on SavedSearchData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedSearchData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedSearchData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedSearchData value)  $default,){
final _that = this;
switch (_that) {
case _SavedSearchData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedSearchData value)?  $default,){
final _that = this;
switch (_that) {
case _SavedSearchData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<SavedSearchFilter>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedSearchData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<SavedSearchFilter>? resultList)  $default,) {final _that = this;
switch (_that) {
case _SavedSearchData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultCount')  int? resultCount, @JsonKey(name: 'resultList')  List<SavedSearchFilter>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _SavedSearchData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedSearchData implements SavedSearchData {
  const _SavedSearchData({@JsonKey(name: 'resultCount') this.resultCount, @JsonKey(name: 'resultList')  List<SavedSearchFilter>? resultList}): _resultList = resultList;
  factory _SavedSearchData.fromJson(Map<String, dynamic> json) => _$SavedSearchDataFromJson(json);

@override@JsonKey(name: 'resultCount') final  int? resultCount;
 final  List<SavedSearchFilter>? _resultList;
@override@JsonKey(name: 'resultList') List<SavedSearchFilter>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SavedSearchData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedSearchDataCopyWith<_SavedSearchData> get copyWith => __$SavedSearchDataCopyWithImpl<_SavedSearchData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedSearchDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedSearchData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'SavedSearchData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$SavedSearchDataCopyWith<$Res> implements $SavedSearchDataCopyWith<$Res> {
  factory _$SavedSearchDataCopyWith(_SavedSearchData value, $Res Function(_SavedSearchData) _then) = __$SavedSearchDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultCount') int? resultCount,@JsonKey(name: 'resultList') List<SavedSearchFilter>? resultList
});




}
/// @nodoc
class __$SavedSearchDataCopyWithImpl<$Res>
    implements _$SavedSearchDataCopyWith<$Res> {
  __$SavedSearchDataCopyWithImpl(this._self, this._then);

  final _SavedSearchData _self;
  final $Res Function(_SavedSearchData) _then;

/// Create a copy of SavedSearchData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_SavedSearchData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<SavedSearchFilter>?,
  ));
}


}


/// @nodoc
mixin _$SavedSearchFilter {

 dynamic get id;@JsonKey(name: 'member_id') dynamic get memberId;@JsonKey(name: 'search_page_name') dynamic get searchPageName;@JsonKey(name: 'search_name') dynamic get searchName;@JsonKey(name: 'from_age') dynamic get fromAge;@JsonKey(name: 'to_age') dynamic get toAge;@JsonKey(name: 'from_height') dynamic get fromHeight;@JsonKey(name: 'to_height') dynamic get toHeight;@JsonKey(name: 'marital_status') dynamic get maritalStatus; dynamic get religion; dynamic get caste;@JsonKey(name: 'mother_tongue') dynamic get motherTongue; dynamic get country; dynamic get state; dynamic get city;@JsonKey(name: 'education_level') dynamic get educationLevel;@JsonKey(name: 'with_photo') dynamic get withPhoto; dynamic get occupation; dynamic get income; dynamic get manglik; dynamic get keyword;@JsonKey(name: 'id_search') dynamic get idSearch;@JsonKey(name: 'employee_in') dynamic get employeeIn;@JsonKey(name: 'created_at') dynamic get createdAt;@JsonKey(name: 'updated_at') dynamic get updatedAt;@JsonKey(name: 'is_deleted') dynamic get isDeleted;@JsonKey(name: 'display_values') List<Map<String, dynamic>>? get displayValues;@JsonKey(name: 'from_age_str') dynamic get fromAgeStr;@JsonKey(name: 'to_age_str') dynamic get toAgeStr;@JsonKey(name: 'from_height_str') dynamic get fromHeightStr;@JsonKey(name: 'to_height_str') dynamic get toHeightStr;@JsonKey(name: 'religion_str') dynamic get religionStr;@JsonKey(name: 'caste_str') dynamic get casteStr;@JsonKey(name: 'mothertongue_str') dynamic get mothertongueStr;@JsonKey(name: 'country_str') dynamic get countryStr;@JsonKey(name: 'state_str') dynamic get stateStr;@JsonKey(name: 'city_str') dynamic get cityStr;@JsonKey(name: 'education_str') dynamic get educationStr;@JsonKey(name: 'occupation_str') dynamic get occupationStr;@JsonKey(name: 'employee_str') dynamic get employeeStr;@JsonKey(name: 'income_str') dynamic get incomeStr;
/// Create a copy of SavedSearchFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedSearchFilterCopyWith<SavedSearchFilter> get copyWith => _$SavedSearchFilterCopyWithImpl<SavedSearchFilter>(this as SavedSearchFilter, _$identity);

  /// Serializes this SavedSearchFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedSearchFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedSearchFilter&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.memberId, _this.memberId)&&const DeepCollectionEquality().equals(other.searchPageName, _this.searchPageName)&&const DeepCollectionEquality().equals(other.searchName, _this.searchName)&&const DeepCollectionEquality().equals(other.fromAge, _this.fromAge)&&const DeepCollectionEquality().equals(other.toAge, _this.toAge)&&const DeepCollectionEquality().equals(other.fromHeight, _this.fromHeight)&&const DeepCollectionEquality().equals(other.toHeight, _this.toHeight)&&const DeepCollectionEquality().equals(other.maritalStatus, _this.maritalStatus)&&const DeepCollectionEquality().equals(other.religion, _this.religion)&&const DeepCollectionEquality().equals(other.caste, _this.caste)&&const DeepCollectionEquality().equals(other.motherTongue, _this.motherTongue)&&const DeepCollectionEquality().equals(other.country, _this.country)&&const DeepCollectionEquality().equals(other.state, _this.state)&&const DeepCollectionEquality().equals(other.city, _this.city)&&const DeepCollectionEquality().equals(other.educationLevel, _this.educationLevel)&&const DeepCollectionEquality().equals(other.withPhoto, _this.withPhoto)&&const DeepCollectionEquality().equals(other.occupation, _this.occupation)&&const DeepCollectionEquality().equals(other.income, _this.income)&&const DeepCollectionEquality().equals(other.manglik, _this.manglik)&&const DeepCollectionEquality().equals(other.keyword, _this.keyword)&&const DeepCollectionEquality().equals(other.idSearch, _this.idSearch)&&const DeepCollectionEquality().equals(other.employeeIn, _this.employeeIn)&&const DeepCollectionEquality().equals(other.createdAt, _this.createdAt)&&const DeepCollectionEquality().equals(other.updatedAt, _this.updatedAt)&&const DeepCollectionEquality().equals(other.isDeleted, _this.isDeleted)&&const DeepCollectionEquality().equals(other.displayValues, _this.displayValues)&&const DeepCollectionEquality().equals(other.fromAgeStr, _this.fromAgeStr)&&const DeepCollectionEquality().equals(other.toAgeStr, _this.toAgeStr)&&const DeepCollectionEquality().equals(other.fromHeightStr, _this.fromHeightStr)&&const DeepCollectionEquality().equals(other.toHeightStr, _this.toHeightStr)&&const DeepCollectionEquality().equals(other.religionStr, _this.religionStr)&&const DeepCollectionEquality().equals(other.casteStr, _this.casteStr)&&const DeepCollectionEquality().equals(other.mothertongueStr, _this.mothertongueStr)&&const DeepCollectionEquality().equals(other.countryStr, _this.countryStr)&&const DeepCollectionEquality().equals(other.stateStr, _this.stateStr)&&const DeepCollectionEquality().equals(other.cityStr, _this.cityStr)&&const DeepCollectionEquality().equals(other.educationStr, _this.educationStr)&&const DeepCollectionEquality().equals(other.occupationStr, _this.occupationStr)&&const DeepCollectionEquality().equals(other.employeeStr, _this.employeeStr)&&const DeepCollectionEquality().equals(other.incomeStr, _this.incomeStr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedSearchFilter;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.memberId),const DeepCollectionEquality().hash(_this.searchPageName),const DeepCollectionEquality().hash(_this.searchName),const DeepCollectionEquality().hash(_this.fromAge),const DeepCollectionEquality().hash(_this.toAge),const DeepCollectionEquality().hash(_this.fromHeight),const DeepCollectionEquality().hash(_this.toHeight),const DeepCollectionEquality().hash(_this.maritalStatus),const DeepCollectionEquality().hash(_this.religion),const DeepCollectionEquality().hash(_this.caste),const DeepCollectionEquality().hash(_this.motherTongue),const DeepCollectionEquality().hash(_this.country),const DeepCollectionEquality().hash(_this.state),const DeepCollectionEquality().hash(_this.city),const DeepCollectionEquality().hash(_this.educationLevel),const DeepCollectionEquality().hash(_this.withPhoto),const DeepCollectionEquality().hash(_this.occupation),const DeepCollectionEquality().hash(_this.income),const DeepCollectionEquality().hash(_this.manglik),const DeepCollectionEquality().hash(_this.keyword),const DeepCollectionEquality().hash(_this.idSearch),const DeepCollectionEquality().hash(_this.employeeIn),const DeepCollectionEquality().hash(_this.createdAt),const DeepCollectionEquality().hash(_this.updatedAt),const DeepCollectionEquality().hash(_this.isDeleted),const DeepCollectionEquality().hash(_this.displayValues),const DeepCollectionEquality().hash(_this.fromAgeStr),const DeepCollectionEquality().hash(_this.toAgeStr),const DeepCollectionEquality().hash(_this.fromHeightStr),const DeepCollectionEquality().hash(_this.toHeightStr),const DeepCollectionEquality().hash(_this.religionStr),const DeepCollectionEquality().hash(_this.casteStr),const DeepCollectionEquality().hash(_this.mothertongueStr),const DeepCollectionEquality().hash(_this.countryStr),const DeepCollectionEquality().hash(_this.stateStr),const DeepCollectionEquality().hash(_this.cityStr),const DeepCollectionEquality().hash(_this.educationStr),const DeepCollectionEquality().hash(_this.occupationStr),const DeepCollectionEquality().hash(_this.employeeStr),const DeepCollectionEquality().hash(_this.incomeStr)]);
}

@override
String toString() {
  final _this = this as SavedSearchFilter;
  return 'SavedSearchFilter(id: ${_this.id}, memberId: ${_this.memberId}, searchPageName: ${_this.searchPageName}, searchName: ${_this.searchName}, fromAge: ${_this.fromAge}, toAge: ${_this.toAge}, fromHeight: ${_this.fromHeight}, toHeight: ${_this.toHeight}, maritalStatus: ${_this.maritalStatus}, religion: ${_this.religion}, caste: ${_this.caste}, motherTongue: ${_this.motherTongue}, country: ${_this.country}, state: ${_this.state}, city: ${_this.city}, educationLevel: ${_this.educationLevel}, withPhoto: ${_this.withPhoto}, occupation: ${_this.occupation}, income: ${_this.income}, manglik: ${_this.manglik}, keyword: ${_this.keyword}, idSearch: ${_this.idSearch}, employeeIn: ${_this.employeeIn}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, isDeleted: ${_this.isDeleted}, displayValues: ${_this.displayValues}, fromAgeStr: ${_this.fromAgeStr}, toAgeStr: ${_this.toAgeStr}, fromHeightStr: ${_this.fromHeightStr}, toHeightStr: ${_this.toHeightStr}, religionStr: ${_this.religionStr}, casteStr: ${_this.casteStr}, mothertongueStr: ${_this.mothertongueStr}, countryStr: ${_this.countryStr}, stateStr: ${_this.stateStr}, cityStr: ${_this.cityStr}, educationStr: ${_this.educationStr}, occupationStr: ${_this.occupationStr}, employeeStr: ${_this.employeeStr}, incomeStr: ${_this.incomeStr})';
}


}

/// @nodoc
abstract mixin class $SavedSearchFilterCopyWith<$Res>  {
  factory $SavedSearchFilterCopyWith(SavedSearchFilter value, $Res Function(SavedSearchFilter) _then) = _$SavedSearchFilterCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'member_id') dynamic memberId,@JsonKey(name: 'search_page_name') dynamic searchPageName,@JsonKey(name: 'search_name') dynamic searchName,@JsonKey(name: 'from_age') dynamic fromAge,@JsonKey(name: 'to_age') dynamic toAge,@JsonKey(name: 'from_height') dynamic fromHeight,@JsonKey(name: 'to_height') dynamic toHeight,@JsonKey(name: 'marital_status') dynamic maritalStatus, dynamic religion, dynamic caste,@JsonKey(name: 'mother_tongue') dynamic motherTongue, dynamic country, dynamic state, dynamic city,@JsonKey(name: 'education_level') dynamic educationLevel,@JsonKey(name: 'with_photo') dynamic withPhoto, dynamic occupation, dynamic income, dynamic manglik, dynamic keyword,@JsonKey(name: 'id_search') dynamic idSearch,@JsonKey(name: 'employee_in') dynamic employeeIn,@JsonKey(name: 'created_at') dynamic createdAt,@JsonKey(name: 'updated_at') dynamic updatedAt,@JsonKey(name: 'is_deleted') dynamic isDeleted,@JsonKey(name: 'display_values') List<Map<String, dynamic>>? displayValues,@JsonKey(name: 'from_age_str') dynamic fromAgeStr,@JsonKey(name: 'to_age_str') dynamic toAgeStr,@JsonKey(name: 'from_height_str') dynamic fromHeightStr,@JsonKey(name: 'to_height_str') dynamic toHeightStr,@JsonKey(name: 'religion_str') dynamic religionStr,@JsonKey(name: 'caste_str') dynamic casteStr,@JsonKey(name: 'mothertongue_str') dynamic mothertongueStr,@JsonKey(name: 'country_str') dynamic countryStr,@JsonKey(name: 'state_str') dynamic stateStr,@JsonKey(name: 'city_str') dynamic cityStr,@JsonKey(name: 'education_str') dynamic educationStr,@JsonKey(name: 'occupation_str') dynamic occupationStr,@JsonKey(name: 'employee_str') dynamic employeeStr,@JsonKey(name: 'income_str') dynamic incomeStr
});




}
/// @nodoc
class _$SavedSearchFilterCopyWithImpl<$Res>
    implements $SavedSearchFilterCopyWith<$Res> {
  _$SavedSearchFilterCopyWithImpl(this._self, this._then);

  final SavedSearchFilter _self;
  final $Res Function(SavedSearchFilter) _then;

/// Create a copy of SavedSearchFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? memberId = freezed,Object? searchPageName = freezed,Object? searchName = freezed,Object? fromAge = freezed,Object? toAge = freezed,Object? fromHeight = freezed,Object? toHeight = freezed,Object? maritalStatus = freezed,Object? religion = freezed,Object? caste = freezed,Object? motherTongue = freezed,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? educationLevel = freezed,Object? withPhoto = freezed,Object? occupation = freezed,Object? income = freezed,Object? manglik = freezed,Object? keyword = freezed,Object? idSearch = freezed,Object? employeeIn = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = freezed,Object? displayValues = freezed,Object? fromAgeStr = freezed,Object? toAgeStr = freezed,Object? fromHeightStr = freezed,Object? toHeightStr = freezed,Object? religionStr = freezed,Object? casteStr = freezed,Object? mothertongueStr = freezed,Object? countryStr = freezed,Object? stateStr = freezed,Object? cityStr = freezed,Object? educationStr = freezed,Object? occupationStr = freezed,Object? employeeStr = freezed,Object? incomeStr = freezed,}) {
  return _then(SavedSearchFilter(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,searchPageName: freezed == searchPageName ? _self.searchPageName : searchPageName // ignore: cast_nullable_to_non_nullable
as dynamic,searchName: freezed == searchName ? _self.searchName : searchName // ignore: cast_nullable_to_non_nullable
as dynamic,fromAge: freezed == fromAge ? _self.fromAge : fromAge // ignore: cast_nullable_to_non_nullable
as dynamic,toAge: freezed == toAge ? _self.toAge : toAge // ignore: cast_nullable_to_non_nullable
as dynamic,fromHeight: freezed == fromHeight ? _self.fromHeight : fromHeight // ignore: cast_nullable_to_non_nullable
as dynamic,toHeight: freezed == toHeight ? _self.toHeight : toHeight // ignore: cast_nullable_to_non_nullable
as dynamic,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as dynamic,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as dynamic,caste: freezed == caste ? _self.caste : caste // ignore: cast_nullable_to_non_nullable
as dynamic,motherTongue: freezed == motherTongue ? _self.motherTongue : motherTongue // ignore: cast_nullable_to_non_nullable
as dynamic,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as dynamic,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as dynamic,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as dynamic,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as dynamic,withPhoto: freezed == withPhoto ? _self.withPhoto : withPhoto // ignore: cast_nullable_to_non_nullable
as dynamic,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as dynamic,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as dynamic,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as dynamic,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as dynamic,idSearch: freezed == idSearch ? _self.idSearch : idSearch // ignore: cast_nullable_to_non_nullable
as dynamic,employeeIn: freezed == employeeIn ? _self.employeeIn : employeeIn // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as dynamic,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as dynamic,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as dynamic,displayValues: freezed == displayValues ? _self.displayValues : displayValues // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,fromAgeStr: freezed == fromAgeStr ? _self.fromAgeStr : fromAgeStr // ignore: cast_nullable_to_non_nullable
as dynamic,toAgeStr: freezed == toAgeStr ? _self.toAgeStr : toAgeStr // ignore: cast_nullable_to_non_nullable
as dynamic,fromHeightStr: freezed == fromHeightStr ? _self.fromHeightStr : fromHeightStr // ignore: cast_nullable_to_non_nullable
as dynamic,toHeightStr: freezed == toHeightStr ? _self.toHeightStr : toHeightStr // ignore: cast_nullable_to_non_nullable
as dynamic,religionStr: freezed == religionStr ? _self.religionStr : religionStr // ignore: cast_nullable_to_non_nullable
as dynamic,casteStr: freezed == casteStr ? _self.casteStr : casteStr // ignore: cast_nullable_to_non_nullable
as dynamic,mothertongueStr: freezed == mothertongueStr ? _self.mothertongueStr : mothertongueStr // ignore: cast_nullable_to_non_nullable
as dynamic,countryStr: freezed == countryStr ? _self.countryStr : countryStr // ignore: cast_nullable_to_non_nullable
as dynamic,stateStr: freezed == stateStr ? _self.stateStr : stateStr // ignore: cast_nullable_to_non_nullable
as dynamic,cityStr: freezed == cityStr ? _self.cityStr : cityStr // ignore: cast_nullable_to_non_nullable
as dynamic,educationStr: freezed == educationStr ? _self.educationStr : educationStr // ignore: cast_nullable_to_non_nullable
as dynamic,occupationStr: freezed == occupationStr ? _self.occupationStr : occupationStr // ignore: cast_nullable_to_non_nullable
as dynamic,employeeStr: freezed == employeeStr ? _self.employeeStr : employeeStr // ignore: cast_nullable_to_non_nullable
as dynamic,incomeStr: freezed == incomeStr ? _self.incomeStr : incomeStr // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedSearchFilter].
extension SavedSearchFilterPatterns on SavedSearchFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedSearchFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedSearchFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedSearchFilter value)  $default,){
final _that = this;
switch (_that) {
case _SavedSearchFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedSearchFilter value)?  $default,){
final _that = this;
switch (_that) {
case _SavedSearchFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'member_id')  dynamic memberId, @JsonKey(name: 'search_page_name')  dynamic searchPageName, @JsonKey(name: 'search_name')  dynamic searchName, @JsonKey(name: 'from_age')  dynamic fromAge, @JsonKey(name: 'to_age')  dynamic toAge, @JsonKey(name: 'from_height')  dynamic fromHeight, @JsonKey(name: 'to_height')  dynamic toHeight, @JsonKey(name: 'marital_status')  dynamic maritalStatus,  dynamic religion,  dynamic caste, @JsonKey(name: 'mother_tongue')  dynamic motherTongue,  dynamic country,  dynamic state,  dynamic city, @JsonKey(name: 'education_level')  dynamic educationLevel, @JsonKey(name: 'with_photo')  dynamic withPhoto,  dynamic occupation,  dynamic income,  dynamic manglik,  dynamic keyword, @JsonKey(name: 'id_search')  dynamic idSearch, @JsonKey(name: 'employee_in')  dynamic employeeIn, @JsonKey(name: 'created_at')  dynamic createdAt, @JsonKey(name: 'updated_at')  dynamic updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted, @JsonKey(name: 'display_values')  List<Map<String, dynamic>>? displayValues, @JsonKey(name: 'from_age_str')  dynamic fromAgeStr, @JsonKey(name: 'to_age_str')  dynamic toAgeStr, @JsonKey(name: 'from_height_str')  dynamic fromHeightStr, @JsonKey(name: 'to_height_str')  dynamic toHeightStr, @JsonKey(name: 'religion_str')  dynamic religionStr, @JsonKey(name: 'caste_str')  dynamic casteStr, @JsonKey(name: 'mothertongue_str')  dynamic mothertongueStr, @JsonKey(name: 'country_str')  dynamic countryStr, @JsonKey(name: 'state_str')  dynamic stateStr, @JsonKey(name: 'city_str')  dynamic cityStr, @JsonKey(name: 'education_str')  dynamic educationStr, @JsonKey(name: 'occupation_str')  dynamic occupationStr, @JsonKey(name: 'employee_str')  dynamic employeeStr, @JsonKey(name: 'income_str')  dynamic incomeStr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedSearchFilter() when $default != null:
return $default(_that.id,_that.memberId,_that.searchPageName,_that.searchName,_that.fromAge,_that.toAge,_that.fromHeight,_that.toHeight,_that.maritalStatus,_that.religion,_that.caste,_that.motherTongue,_that.country,_that.state,_that.city,_that.educationLevel,_that.withPhoto,_that.occupation,_that.income,_that.manglik,_that.keyword,_that.idSearch,_that.employeeIn,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.displayValues,_that.fromAgeStr,_that.toAgeStr,_that.fromHeightStr,_that.toHeightStr,_that.religionStr,_that.casteStr,_that.mothertongueStr,_that.countryStr,_that.stateStr,_that.cityStr,_that.educationStr,_that.occupationStr,_that.employeeStr,_that.incomeStr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'member_id')  dynamic memberId, @JsonKey(name: 'search_page_name')  dynamic searchPageName, @JsonKey(name: 'search_name')  dynamic searchName, @JsonKey(name: 'from_age')  dynamic fromAge, @JsonKey(name: 'to_age')  dynamic toAge, @JsonKey(name: 'from_height')  dynamic fromHeight, @JsonKey(name: 'to_height')  dynamic toHeight, @JsonKey(name: 'marital_status')  dynamic maritalStatus,  dynamic religion,  dynamic caste, @JsonKey(name: 'mother_tongue')  dynamic motherTongue,  dynamic country,  dynamic state,  dynamic city, @JsonKey(name: 'education_level')  dynamic educationLevel, @JsonKey(name: 'with_photo')  dynamic withPhoto,  dynamic occupation,  dynamic income,  dynamic manglik,  dynamic keyword, @JsonKey(name: 'id_search')  dynamic idSearch, @JsonKey(name: 'employee_in')  dynamic employeeIn, @JsonKey(name: 'created_at')  dynamic createdAt, @JsonKey(name: 'updated_at')  dynamic updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted, @JsonKey(name: 'display_values')  List<Map<String, dynamic>>? displayValues, @JsonKey(name: 'from_age_str')  dynamic fromAgeStr, @JsonKey(name: 'to_age_str')  dynamic toAgeStr, @JsonKey(name: 'from_height_str')  dynamic fromHeightStr, @JsonKey(name: 'to_height_str')  dynamic toHeightStr, @JsonKey(name: 'religion_str')  dynamic religionStr, @JsonKey(name: 'caste_str')  dynamic casteStr, @JsonKey(name: 'mothertongue_str')  dynamic mothertongueStr, @JsonKey(name: 'country_str')  dynamic countryStr, @JsonKey(name: 'state_str')  dynamic stateStr, @JsonKey(name: 'city_str')  dynamic cityStr, @JsonKey(name: 'education_str')  dynamic educationStr, @JsonKey(name: 'occupation_str')  dynamic occupationStr, @JsonKey(name: 'employee_str')  dynamic employeeStr, @JsonKey(name: 'income_str')  dynamic incomeStr)  $default,) {final _that = this;
switch (_that) {
case _SavedSearchFilter():
return $default(_that.id,_that.memberId,_that.searchPageName,_that.searchName,_that.fromAge,_that.toAge,_that.fromHeight,_that.toHeight,_that.maritalStatus,_that.religion,_that.caste,_that.motherTongue,_that.country,_that.state,_that.city,_that.educationLevel,_that.withPhoto,_that.occupation,_that.income,_that.manglik,_that.keyword,_that.idSearch,_that.employeeIn,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.displayValues,_that.fromAgeStr,_that.toAgeStr,_that.fromHeightStr,_that.toHeightStr,_that.religionStr,_that.casteStr,_that.mothertongueStr,_that.countryStr,_that.stateStr,_that.cityStr,_that.educationStr,_that.occupationStr,_that.employeeStr,_that.incomeStr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'member_id')  dynamic memberId, @JsonKey(name: 'search_page_name')  dynamic searchPageName, @JsonKey(name: 'search_name')  dynamic searchName, @JsonKey(name: 'from_age')  dynamic fromAge, @JsonKey(name: 'to_age')  dynamic toAge, @JsonKey(name: 'from_height')  dynamic fromHeight, @JsonKey(name: 'to_height')  dynamic toHeight, @JsonKey(name: 'marital_status')  dynamic maritalStatus,  dynamic religion,  dynamic caste, @JsonKey(name: 'mother_tongue')  dynamic motherTongue,  dynamic country,  dynamic state,  dynamic city, @JsonKey(name: 'education_level')  dynamic educationLevel, @JsonKey(name: 'with_photo')  dynamic withPhoto,  dynamic occupation,  dynamic income,  dynamic manglik,  dynamic keyword, @JsonKey(name: 'id_search')  dynamic idSearch, @JsonKey(name: 'employee_in')  dynamic employeeIn, @JsonKey(name: 'created_at')  dynamic createdAt, @JsonKey(name: 'updated_at')  dynamic updatedAt, @JsonKey(name: 'is_deleted')  dynamic isDeleted, @JsonKey(name: 'display_values')  List<Map<String, dynamic>>? displayValues, @JsonKey(name: 'from_age_str')  dynamic fromAgeStr, @JsonKey(name: 'to_age_str')  dynamic toAgeStr, @JsonKey(name: 'from_height_str')  dynamic fromHeightStr, @JsonKey(name: 'to_height_str')  dynamic toHeightStr, @JsonKey(name: 'religion_str')  dynamic religionStr, @JsonKey(name: 'caste_str')  dynamic casteStr, @JsonKey(name: 'mothertongue_str')  dynamic mothertongueStr, @JsonKey(name: 'country_str')  dynamic countryStr, @JsonKey(name: 'state_str')  dynamic stateStr, @JsonKey(name: 'city_str')  dynamic cityStr, @JsonKey(name: 'education_str')  dynamic educationStr, @JsonKey(name: 'occupation_str')  dynamic occupationStr, @JsonKey(name: 'employee_str')  dynamic employeeStr, @JsonKey(name: 'income_str')  dynamic incomeStr)?  $default,) {final _that = this;
switch (_that) {
case _SavedSearchFilter() when $default != null:
return $default(_that.id,_that.memberId,_that.searchPageName,_that.searchName,_that.fromAge,_that.toAge,_that.fromHeight,_that.toHeight,_that.maritalStatus,_that.religion,_that.caste,_that.motherTongue,_that.country,_that.state,_that.city,_that.educationLevel,_that.withPhoto,_that.occupation,_that.income,_that.manglik,_that.keyword,_that.idSearch,_that.employeeIn,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.displayValues,_that.fromAgeStr,_that.toAgeStr,_that.fromHeightStr,_that.toHeightStr,_that.religionStr,_that.casteStr,_that.mothertongueStr,_that.countryStr,_that.stateStr,_that.cityStr,_that.educationStr,_that.occupationStr,_that.employeeStr,_that.incomeStr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedSearchFilter implements SavedSearchFilter {
  const _SavedSearchFilter({this.id, @JsonKey(name: 'member_id') this.memberId, @JsonKey(name: 'search_page_name') this.searchPageName, @JsonKey(name: 'search_name') this.searchName, @JsonKey(name: 'from_age') this.fromAge, @JsonKey(name: 'to_age') this.toAge, @JsonKey(name: 'from_height') this.fromHeight, @JsonKey(name: 'to_height') this.toHeight, @JsonKey(name: 'marital_status') this.maritalStatus, this.religion, this.caste, @JsonKey(name: 'mother_tongue') this.motherTongue, this.country, this.state, this.city, @JsonKey(name: 'education_level') this.educationLevel, @JsonKey(name: 'with_photo') this.withPhoto, this.occupation, this.income, this.manglik, this.keyword, @JsonKey(name: 'id_search') this.idSearch, @JsonKey(name: 'employee_in') this.employeeIn, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'is_deleted') this.isDeleted, @JsonKey(name: 'display_values')  List<Map<String, dynamic>>? displayValues, @JsonKey(name: 'from_age_str') this.fromAgeStr, @JsonKey(name: 'to_age_str') this.toAgeStr, @JsonKey(name: 'from_height_str') this.fromHeightStr, @JsonKey(name: 'to_height_str') this.toHeightStr, @JsonKey(name: 'religion_str') this.religionStr, @JsonKey(name: 'caste_str') this.casteStr, @JsonKey(name: 'mothertongue_str') this.mothertongueStr, @JsonKey(name: 'country_str') this.countryStr, @JsonKey(name: 'state_str') this.stateStr, @JsonKey(name: 'city_str') this.cityStr, @JsonKey(name: 'education_str') this.educationStr, @JsonKey(name: 'occupation_str') this.occupationStr, @JsonKey(name: 'employee_str') this.employeeStr, @JsonKey(name: 'income_str') this.incomeStr}): _displayValues = displayValues;
  factory _SavedSearchFilter.fromJson(Map<String, dynamic> json) => _$SavedSearchFilterFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'member_id') final  dynamic memberId;
@override@JsonKey(name: 'search_page_name') final  dynamic searchPageName;
@override@JsonKey(name: 'search_name') final  dynamic searchName;
@override@JsonKey(name: 'from_age') final  dynamic fromAge;
@override@JsonKey(name: 'to_age') final  dynamic toAge;
@override@JsonKey(name: 'from_height') final  dynamic fromHeight;
@override@JsonKey(name: 'to_height') final  dynamic toHeight;
@override@JsonKey(name: 'marital_status') final  dynamic maritalStatus;
@override final  dynamic religion;
@override final  dynamic caste;
@override@JsonKey(name: 'mother_tongue') final  dynamic motherTongue;
@override final  dynamic country;
@override final  dynamic state;
@override final  dynamic city;
@override@JsonKey(name: 'education_level') final  dynamic educationLevel;
@override@JsonKey(name: 'with_photo') final  dynamic withPhoto;
@override final  dynamic occupation;
@override final  dynamic income;
@override final  dynamic manglik;
@override final  dynamic keyword;
@override@JsonKey(name: 'id_search') final  dynamic idSearch;
@override@JsonKey(name: 'employee_in') final  dynamic employeeIn;
@override@JsonKey(name: 'created_at') final  dynamic createdAt;
@override@JsonKey(name: 'updated_at') final  dynamic updatedAt;
@override@JsonKey(name: 'is_deleted') final  dynamic isDeleted;
 final  List<Map<String, dynamic>>? _displayValues;
@override@JsonKey(name: 'display_values') List<Map<String, dynamic>>? get displayValues {
  final value = _displayValues;
  if (value == null) return null;
  if (_displayValues is EqualUnmodifiableListView) return _displayValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'from_age_str') final  dynamic fromAgeStr;
@override@JsonKey(name: 'to_age_str') final  dynamic toAgeStr;
@override@JsonKey(name: 'from_height_str') final  dynamic fromHeightStr;
@override@JsonKey(name: 'to_height_str') final  dynamic toHeightStr;
@override@JsonKey(name: 'religion_str') final  dynamic religionStr;
@override@JsonKey(name: 'caste_str') final  dynamic casteStr;
@override@JsonKey(name: 'mothertongue_str') final  dynamic mothertongueStr;
@override@JsonKey(name: 'country_str') final  dynamic countryStr;
@override@JsonKey(name: 'state_str') final  dynamic stateStr;
@override@JsonKey(name: 'city_str') final  dynamic cityStr;
@override@JsonKey(name: 'education_str') final  dynamic educationStr;
@override@JsonKey(name: 'occupation_str') final  dynamic occupationStr;
@override@JsonKey(name: 'employee_str') final  dynamic employeeStr;
@override@JsonKey(name: 'income_str') final  dynamic incomeStr;

/// Create a copy of SavedSearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedSearchFilterCopyWith<_SavedSearchFilter> get copyWith => __$SavedSearchFilterCopyWithImpl<_SavedSearchFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedSearchFilterToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedSearchFilter&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.memberId, memberId)&&const DeepCollectionEquality().equals(other.searchPageName, searchPageName)&&const DeepCollectionEquality().equals(other.searchName, searchName)&&const DeepCollectionEquality().equals(other.fromAge, fromAge)&&const DeepCollectionEquality().equals(other.toAge, toAge)&&const DeepCollectionEquality().equals(other.fromHeight, fromHeight)&&const DeepCollectionEquality().equals(other.toHeight, toHeight)&&const DeepCollectionEquality().equals(other.maritalStatus, maritalStatus)&&const DeepCollectionEquality().equals(other.religion, religion)&&const DeepCollectionEquality().equals(other.caste, caste)&&const DeepCollectionEquality().equals(other.motherTongue, motherTongue)&&const DeepCollectionEquality().equals(other.country, country)&&const DeepCollectionEquality().equals(other.state, state)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.educationLevel, educationLevel)&&const DeepCollectionEquality().equals(other.withPhoto, withPhoto)&&const DeepCollectionEquality().equals(other.occupation, occupation)&&const DeepCollectionEquality().equals(other.income, income)&&const DeepCollectionEquality().equals(other.manglik, manglik)&&const DeepCollectionEquality().equals(other.keyword, keyword)&&const DeepCollectionEquality().equals(other.idSearch, idSearch)&&const DeepCollectionEquality().equals(other.employeeIn, employeeIn)&&const DeepCollectionEquality().equals(other.createdAt, createdAt)&&const DeepCollectionEquality().equals(other.updatedAt, updatedAt)&&const DeepCollectionEquality().equals(other.isDeleted, isDeleted)&&const DeepCollectionEquality().equals(other.displayValues, _displayValues)&&const DeepCollectionEquality().equals(other.fromAgeStr, fromAgeStr)&&const DeepCollectionEquality().equals(other.toAgeStr, toAgeStr)&&const DeepCollectionEquality().equals(other.fromHeightStr, fromHeightStr)&&const DeepCollectionEquality().equals(other.toHeightStr, toHeightStr)&&const DeepCollectionEquality().equals(other.religionStr, religionStr)&&const DeepCollectionEquality().equals(other.casteStr, casteStr)&&const DeepCollectionEquality().equals(other.mothertongueStr, mothertongueStr)&&const DeepCollectionEquality().equals(other.countryStr, countryStr)&&const DeepCollectionEquality().equals(other.stateStr, stateStr)&&const DeepCollectionEquality().equals(other.cityStr, cityStr)&&const DeepCollectionEquality().equals(other.educationStr, educationStr)&&const DeepCollectionEquality().equals(other.occupationStr, occupationStr)&&const DeepCollectionEquality().equals(other.employeeStr, employeeStr)&&const DeepCollectionEquality().equals(other.incomeStr, incomeStr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(memberId),const DeepCollectionEquality().hash(searchPageName),const DeepCollectionEquality().hash(searchName),const DeepCollectionEquality().hash(fromAge),const DeepCollectionEquality().hash(toAge),const DeepCollectionEquality().hash(fromHeight),const DeepCollectionEquality().hash(toHeight),const DeepCollectionEquality().hash(maritalStatus),const DeepCollectionEquality().hash(religion),const DeepCollectionEquality().hash(caste),const DeepCollectionEquality().hash(motherTongue),const DeepCollectionEquality().hash(country),const DeepCollectionEquality().hash(state),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(educationLevel),const DeepCollectionEquality().hash(withPhoto),const DeepCollectionEquality().hash(occupation),const DeepCollectionEquality().hash(income),const DeepCollectionEquality().hash(manglik),const DeepCollectionEquality().hash(keyword),const DeepCollectionEquality().hash(idSearch),const DeepCollectionEquality().hash(employeeIn),const DeepCollectionEquality().hash(createdAt),const DeepCollectionEquality().hash(updatedAt),const DeepCollectionEquality().hash(isDeleted),const DeepCollectionEquality().hash(_displayValues),const DeepCollectionEquality().hash(fromAgeStr),const DeepCollectionEquality().hash(toAgeStr),const DeepCollectionEquality().hash(fromHeightStr),const DeepCollectionEquality().hash(toHeightStr),const DeepCollectionEquality().hash(religionStr),const DeepCollectionEquality().hash(casteStr),const DeepCollectionEquality().hash(mothertongueStr),const DeepCollectionEquality().hash(countryStr),const DeepCollectionEquality().hash(stateStr),const DeepCollectionEquality().hash(cityStr),const DeepCollectionEquality().hash(educationStr),const DeepCollectionEquality().hash(occupationStr),const DeepCollectionEquality().hash(employeeStr),const DeepCollectionEquality().hash(incomeStr)]);
}

@override
String toString() {
    return 'SavedSearchFilter(id: $id, memberId: $memberId, searchPageName: $searchPageName, searchName: $searchName, fromAge: $fromAge, toAge: $toAge, fromHeight: $fromHeight, toHeight: $toHeight, maritalStatus: $maritalStatus, religion: $religion, caste: $caste, motherTongue: $motherTongue, country: $country, state: $state, city: $city, educationLevel: $educationLevel, withPhoto: $withPhoto, occupation: $occupation, income: $income, manglik: $manglik, keyword: $keyword, idSearch: $idSearch, employeeIn: $employeeIn, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, displayValues: $displayValues, fromAgeStr: $fromAgeStr, toAgeStr: $toAgeStr, fromHeightStr: $fromHeightStr, toHeightStr: $toHeightStr, religionStr: $religionStr, casteStr: $casteStr, mothertongueStr: $mothertongueStr, countryStr: $countryStr, stateStr: $stateStr, cityStr: $cityStr, educationStr: $educationStr, occupationStr: $occupationStr, employeeStr: $employeeStr, incomeStr: $incomeStr)';
}


}

/// @nodoc
abstract mixin class _$SavedSearchFilterCopyWith<$Res> implements $SavedSearchFilterCopyWith<$Res> {
  factory _$SavedSearchFilterCopyWith(_SavedSearchFilter value, $Res Function(_SavedSearchFilter) _then) = __$SavedSearchFilterCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'member_id') dynamic memberId,@JsonKey(name: 'search_page_name') dynamic searchPageName,@JsonKey(name: 'search_name') dynamic searchName,@JsonKey(name: 'from_age') dynamic fromAge,@JsonKey(name: 'to_age') dynamic toAge,@JsonKey(name: 'from_height') dynamic fromHeight,@JsonKey(name: 'to_height') dynamic toHeight,@JsonKey(name: 'marital_status') dynamic maritalStatus, dynamic religion, dynamic caste,@JsonKey(name: 'mother_tongue') dynamic motherTongue, dynamic country, dynamic state, dynamic city,@JsonKey(name: 'education_level') dynamic educationLevel,@JsonKey(name: 'with_photo') dynamic withPhoto, dynamic occupation, dynamic income, dynamic manglik, dynamic keyword,@JsonKey(name: 'id_search') dynamic idSearch,@JsonKey(name: 'employee_in') dynamic employeeIn,@JsonKey(name: 'created_at') dynamic createdAt,@JsonKey(name: 'updated_at') dynamic updatedAt,@JsonKey(name: 'is_deleted') dynamic isDeleted,@JsonKey(name: 'display_values') List<Map<String, dynamic>>? displayValues,@JsonKey(name: 'from_age_str') dynamic fromAgeStr,@JsonKey(name: 'to_age_str') dynamic toAgeStr,@JsonKey(name: 'from_height_str') dynamic fromHeightStr,@JsonKey(name: 'to_height_str') dynamic toHeightStr,@JsonKey(name: 'religion_str') dynamic religionStr,@JsonKey(name: 'caste_str') dynamic casteStr,@JsonKey(name: 'mothertongue_str') dynamic mothertongueStr,@JsonKey(name: 'country_str') dynamic countryStr,@JsonKey(name: 'state_str') dynamic stateStr,@JsonKey(name: 'city_str') dynamic cityStr,@JsonKey(name: 'education_str') dynamic educationStr,@JsonKey(name: 'occupation_str') dynamic occupationStr,@JsonKey(name: 'employee_str') dynamic employeeStr,@JsonKey(name: 'income_str') dynamic incomeStr
});




}
/// @nodoc
class __$SavedSearchFilterCopyWithImpl<$Res>
    implements _$SavedSearchFilterCopyWith<$Res> {
  __$SavedSearchFilterCopyWithImpl(this._self, this._then);

  final _SavedSearchFilter _self;
  final $Res Function(_SavedSearchFilter) _then;

/// Create a copy of SavedSearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? memberId = freezed,Object? searchPageName = freezed,Object? searchName = freezed,Object? fromAge = freezed,Object? toAge = freezed,Object? fromHeight = freezed,Object? toHeight = freezed,Object? maritalStatus = freezed,Object? religion = freezed,Object? caste = freezed,Object? motherTongue = freezed,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? educationLevel = freezed,Object? withPhoto = freezed,Object? occupation = freezed,Object? income = freezed,Object? manglik = freezed,Object? keyword = freezed,Object? idSearch = freezed,Object? employeeIn = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = freezed,Object? displayValues = freezed,Object? fromAgeStr = freezed,Object? toAgeStr = freezed,Object? fromHeightStr = freezed,Object? toHeightStr = freezed,Object? religionStr = freezed,Object? casteStr = freezed,Object? mothertongueStr = freezed,Object? countryStr = freezed,Object? stateStr = freezed,Object? cityStr = freezed,Object? educationStr = freezed,Object? occupationStr = freezed,Object? employeeStr = freezed,Object? incomeStr = freezed,}) {
  return _then(_SavedSearchFilter(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,searchPageName: freezed == searchPageName ? _self.searchPageName : searchPageName // ignore: cast_nullable_to_non_nullable
as dynamic,searchName: freezed == searchName ? _self.searchName : searchName // ignore: cast_nullable_to_non_nullable
as dynamic,fromAge: freezed == fromAge ? _self.fromAge : fromAge // ignore: cast_nullable_to_non_nullable
as dynamic,toAge: freezed == toAge ? _self.toAge : toAge // ignore: cast_nullable_to_non_nullable
as dynamic,fromHeight: freezed == fromHeight ? _self.fromHeight : fromHeight // ignore: cast_nullable_to_non_nullable
as dynamic,toHeight: freezed == toHeight ? _self.toHeight : toHeight // ignore: cast_nullable_to_non_nullable
as dynamic,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as dynamic,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as dynamic,caste: freezed == caste ? _self.caste : caste // ignore: cast_nullable_to_non_nullable
as dynamic,motherTongue: freezed == motherTongue ? _self.motherTongue : motherTongue // ignore: cast_nullable_to_non_nullable
as dynamic,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as dynamic,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as dynamic,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as dynamic,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as dynamic,withPhoto: freezed == withPhoto ? _self.withPhoto : withPhoto // ignore: cast_nullable_to_non_nullable
as dynamic,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as dynamic,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as dynamic,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as dynamic,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as dynamic,idSearch: freezed == idSearch ? _self.idSearch : idSearch // ignore: cast_nullable_to_non_nullable
as dynamic,employeeIn: freezed == employeeIn ? _self.employeeIn : employeeIn // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as dynamic,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as dynamic,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as dynamic,displayValues: freezed == displayValues ? _self._displayValues : displayValues // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,fromAgeStr: freezed == fromAgeStr ? _self.fromAgeStr : fromAgeStr // ignore: cast_nullable_to_non_nullable
as dynamic,toAgeStr: freezed == toAgeStr ? _self.toAgeStr : toAgeStr // ignore: cast_nullable_to_non_nullable
as dynamic,fromHeightStr: freezed == fromHeightStr ? _self.fromHeightStr : fromHeightStr // ignore: cast_nullable_to_non_nullable
as dynamic,toHeightStr: freezed == toHeightStr ? _self.toHeightStr : toHeightStr // ignore: cast_nullable_to_non_nullable
as dynamic,religionStr: freezed == religionStr ? _self.religionStr : religionStr // ignore: cast_nullable_to_non_nullable
as dynamic,casteStr: freezed == casteStr ? _self.casteStr : casteStr // ignore: cast_nullable_to_non_nullable
as dynamic,mothertongueStr: freezed == mothertongueStr ? _self.mothertongueStr : mothertongueStr // ignore: cast_nullable_to_non_nullable
as dynamic,countryStr: freezed == countryStr ? _self.countryStr : countryStr // ignore: cast_nullable_to_non_nullable
as dynamic,stateStr: freezed == stateStr ? _self.stateStr : stateStr // ignore: cast_nullable_to_non_nullable
as dynamic,cityStr: freezed == cityStr ? _self.cityStr : cityStr // ignore: cast_nullable_to_non_nullable
as dynamic,educationStr: freezed == educationStr ? _self.educationStr : educationStr // ignore: cast_nullable_to_non_nullable
as dynamic,occupationStr: freezed == occupationStr ? _self.occupationStr : occupationStr // ignore: cast_nullable_to_non_nullable
as dynamic,employeeStr: freezed == employeeStr ? _self.employeeStr : employeeStr // ignore: cast_nullable_to_non_nullable
as dynamic,incomeStr: freezed == incomeStr ? _self.incomeStr : incomeStr // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
