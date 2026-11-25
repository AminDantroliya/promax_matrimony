// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_search_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedSearchState {

 List<SavedSearchFilter> get resultList; int get page; int get totalCount; bool get isLoadingMore; SavedSearchListResponseModel? get response;
/// Create a copy of SavedSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedSearchStateCopyWith<SavedSearchState> get copyWith => _$SavedSearchStateCopyWithImpl<SavedSearchState>(this as SavedSearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SavedSearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedSearchState&&const DeepCollectionEquality().equals(other.resultList, _this.resultList)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.response, _this.response) || other.response == _this.response));
}


@override
int get hashCode {
  final _this = this as SavedSearchState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.resultList),_this.page,_this.totalCount,_this.isLoadingMore,_this.response);
}

@override
String toString() {
  final _this = this as SavedSearchState;
  return 'SavedSearchState(resultList: ${_this.resultList}, page: ${_this.page}, totalCount: ${_this.totalCount}, isLoadingMore: ${_this.isLoadingMore}, response: ${_this.response})';
}


}

/// @nodoc
abstract mixin class $SavedSearchStateCopyWith<$Res>  {
  factory $SavedSearchStateCopyWith(SavedSearchState value, $Res Function(SavedSearchState) _then) = _$SavedSearchStateCopyWithImpl;
@useResult
$Res call({
 List<SavedSearchFilter> resultList, int page, int totalCount, bool isLoadingMore, SavedSearchListResponseModel? response
});


$SavedSearchListResponseModelCopyWith<$Res>? get response;

}
/// @nodoc
class _$SavedSearchStateCopyWithImpl<$Res>
    implements $SavedSearchStateCopyWith<$Res> {
  _$SavedSearchStateCopyWithImpl(this._self, this._then);

  final SavedSearchState _self;
  final $Res Function(SavedSearchState) _then;

/// Create a copy of SavedSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,}) {
  return _then(SavedSearchState(
resultList: null == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<SavedSearchFilter>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as SavedSearchListResponseModel?,
  ));
}
/// Create a copy of SavedSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedSearchListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $SavedSearchListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedSearchState].
extension SavedSearchStatePatterns on SavedSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedSearchState value)  $default,){
final _that = this;
switch (_that) {
case _SavedSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SavedSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SavedSearchFilter> resultList,  int page,  int totalCount,  bool isLoadingMore,  SavedSearchListResponseModel? response)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedSearchState() when $default != null:
return $default(_that.resultList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SavedSearchFilter> resultList,  int page,  int totalCount,  bool isLoadingMore,  SavedSearchListResponseModel? response)  $default,) {final _that = this;
switch (_that) {
case _SavedSearchState():
return $default(_that.resultList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SavedSearchFilter> resultList,  int page,  int totalCount,  bool isLoadingMore,  SavedSearchListResponseModel? response)?  $default,) {final _that = this;
switch (_that) {
case _SavedSearchState() when $default != null:
return $default(_that.resultList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response);case _:
  return null;

}
}

}

/// @nodoc


class _SavedSearchState implements SavedSearchState {
  const _SavedSearchState({ List<SavedSearchFilter> resultList = const [], this.page = 1, this.totalCount = 0, this.isLoadingMore = false, this.response = null}): _resultList = resultList;
  

 final  List<SavedSearchFilter> _resultList;
@override@JsonKey() List<SavedSearchFilter> get resultList {
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultList);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  SavedSearchListResponseModel? response;

/// Create a copy of SavedSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedSearchStateCopyWith<_SavedSearchState> get copyWith => __$SavedSearchStateCopyWithImpl<_SavedSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedSearchState&&const DeepCollectionEquality().equals(other.resultList, _resultList)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_resultList),page,totalCount,isLoadingMore,response);
}

@override
String toString() {
    return 'SavedSearchState(resultList: $resultList, page: $page, totalCount: $totalCount, isLoadingMore: $isLoadingMore, response: $response)';
}


}

/// @nodoc
abstract mixin class _$SavedSearchStateCopyWith<$Res> implements $SavedSearchStateCopyWith<$Res> {
  factory _$SavedSearchStateCopyWith(_SavedSearchState value, $Res Function(_SavedSearchState) _then) = __$SavedSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<SavedSearchFilter> resultList, int page, int totalCount, bool isLoadingMore, SavedSearchListResponseModel? response
});


@override $SavedSearchListResponseModelCopyWith<$Res>? get response;

}
/// @nodoc
class __$SavedSearchStateCopyWithImpl<$Res>
    implements _$SavedSearchStateCopyWith<$Res> {
  __$SavedSearchStateCopyWithImpl(this._self, this._then);

  final _SavedSearchState _self;
  final $Res Function(_SavedSearchState) _then;

/// Create a copy of SavedSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,}) {
  return _then(_SavedSearchState(
resultList: null == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<SavedSearchFilter>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as SavedSearchListResponseModel?,
  ));
}

/// Create a copy of SavedSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedSearchListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $SavedSearchListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}

// dart format on
