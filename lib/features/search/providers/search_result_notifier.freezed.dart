// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResultState {

 List<MemberListModel> get memberList; int get page; int get totalCount; bool get isLoadingMore; SearchResultListResponseModel? get response; Map<String, dynamic> get params;
/// Create a copy of SearchResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultStateCopyWith<SearchResultState> get copyWith => _$SearchResultStateCopyWithImpl<SearchResultState>(this as SearchResultState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchResultState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultState&&const DeepCollectionEquality().equals(other.memberList, _this.memberList)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.response, _this.response) || other.response == _this.response)&&const DeepCollectionEquality().equals(other.params, _this.params));
}


@override
int get hashCode {
  final _this = this as SearchResultState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.memberList),_this.page,_this.totalCount,_this.isLoadingMore,_this.response,const DeepCollectionEquality().hash(_this.params));
}

@override
String toString() {
  final _this = this as SearchResultState;
  return 'SearchResultState(memberList: ${_this.memberList}, page: ${_this.page}, totalCount: ${_this.totalCount}, isLoadingMore: ${_this.isLoadingMore}, response: ${_this.response}, params: ${_this.params})';
}


}

/// @nodoc
abstract mixin class $SearchResultStateCopyWith<$Res>  {
  factory $SearchResultStateCopyWith(SearchResultState value, $Res Function(SearchResultState) _then) = _$SearchResultStateCopyWithImpl;
@useResult
$Res call({
 List<MemberListModel> memberList, int page, int totalCount, bool isLoadingMore, SearchResultListResponseModel? response, Map<String, dynamic> params
});


$SearchResultListResponseModelCopyWith<$Res>? get response;

}
/// @nodoc
class _$SearchResultStateCopyWithImpl<$Res>
    implements $SearchResultStateCopyWith<$Res> {
  _$SearchResultStateCopyWithImpl(this._self, this._then);

  final SearchResultState _self;
  final $Res Function(SearchResultState) _then;

/// Create a copy of SearchResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,Object? params = null,}) {
  return _then(SearchResultState(
memberList: null == memberList ? _self.memberList : memberList // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as SearchResultListResponseModel?,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of SearchResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchResultListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $SearchResultListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchResultState].
extension SearchResultStatePatterns on SearchResultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultState value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MemberListModel> memberList,  int page,  int totalCount,  bool isLoadingMore,  SearchResultListResponseModel? response,  Map<String, dynamic> params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultState() when $default != null:
return $default(_that.memberList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MemberListModel> memberList,  int page,  int totalCount,  bool isLoadingMore,  SearchResultListResponseModel? response,  Map<String, dynamic> params)  $default,) {final _that = this;
switch (_that) {
case _SearchResultState():
return $default(_that.memberList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MemberListModel> memberList,  int page,  int totalCount,  bool isLoadingMore,  SearchResultListResponseModel? response,  Map<String, dynamic> params)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultState() when $default != null:
return $default(_that.memberList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response,_that.params);case _:
  return null;

}
}

}

/// @nodoc


class _SearchResultState implements SearchResultState {
  const _SearchResultState({ List<MemberListModel> memberList = const [], this.page = 1, this.totalCount = 0, this.isLoadingMore = false, this.response = null,  Map<String, dynamic> params = const {}}): _memberList = memberList,_params = params;
  

 final  List<MemberListModel> _memberList;
@override@JsonKey() List<MemberListModel> get memberList {
  if (_memberList is EqualUnmodifiableListView) return _memberList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberList);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  SearchResultListResponseModel? response;
 final  Map<String, dynamic> _params;
@override@JsonKey() Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}


/// Create a copy of SearchResultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultStateCopyWith<_SearchResultState> get copyWith => __$SearchResultStateCopyWithImpl<_SearchResultState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultState&&const DeepCollectionEquality().equals(other.memberList, _memberList)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.response, response) || other.response == response)&&const DeepCollectionEquality().equals(other.params, _params));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_memberList),page,totalCount,isLoadingMore,response,const DeepCollectionEquality().hash(_params));
}

@override
String toString() {
    return 'SearchResultState(memberList: $memberList, page: $page, totalCount: $totalCount, isLoadingMore: $isLoadingMore, response: $response, params: $params)';
}


}

/// @nodoc
abstract mixin class _$SearchResultStateCopyWith<$Res> implements $SearchResultStateCopyWith<$Res> {
  factory _$SearchResultStateCopyWith(_SearchResultState value, $Res Function(_SearchResultState) _then) = __$SearchResultStateCopyWithImpl;
@override @useResult
$Res call({
 List<MemberListModel> memberList, int page, int totalCount, bool isLoadingMore, SearchResultListResponseModel? response, Map<String, dynamic> params
});


@override $SearchResultListResponseModelCopyWith<$Res>? get response;

}
/// @nodoc
class __$SearchResultStateCopyWithImpl<$Res>
    implements _$SearchResultStateCopyWith<$Res> {
  __$SearchResultStateCopyWithImpl(this._self, this._then);

  final _SearchResultState _self;
  final $Res Function(_SearchResultState) _then;

/// Create a copy of SearchResultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,Object? params = null,}) {
  return _then(_SearchResultState(
memberList: null == memberList ? _self._memberList : memberList // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as SearchResultListResponseModel?,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of SearchResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchResultListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $SearchResultListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}

// dart format on
