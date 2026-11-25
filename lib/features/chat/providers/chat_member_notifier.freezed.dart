// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_member_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMemberState {

 List<ChatMember> get memberList; int get page; int get totalCount; bool get isLoadingMore; ChatMemberListResponseModel? get response;
/// Create a copy of ChatMemberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMemberStateCopyWith<ChatMemberState> get copyWith => _$ChatMemberStateCopyWithImpl<ChatMemberState>(this as ChatMemberState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatMemberState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMemberState&&const DeepCollectionEquality().equals(other.memberList, _this.memberList)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.response, _this.response) || other.response == _this.response));
}


@override
int get hashCode {
  final _this = this as ChatMemberState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.memberList),_this.page,_this.totalCount,_this.isLoadingMore,_this.response);
}

@override
String toString() {
  final _this = this as ChatMemberState;
  return 'ChatMemberState(memberList: ${_this.memberList}, page: ${_this.page}, totalCount: ${_this.totalCount}, isLoadingMore: ${_this.isLoadingMore}, response: ${_this.response})';
}


}

/// @nodoc
abstract mixin class $ChatMemberStateCopyWith<$Res>  {
  factory $ChatMemberStateCopyWith(ChatMemberState value, $Res Function(ChatMemberState) _then) = _$ChatMemberStateCopyWithImpl;
@useResult
$Res call({
 List<ChatMember> memberList, int page, int totalCount, bool isLoadingMore, ChatMemberListResponseModel? response
});


$ChatMemberListResponseModelCopyWith<$Res>? get response;

}
/// @nodoc
class _$ChatMemberStateCopyWithImpl<$Res>
    implements $ChatMemberStateCopyWith<$Res> {
  _$ChatMemberStateCopyWithImpl(this._self, this._then);

  final ChatMemberState _self;
  final $Res Function(ChatMemberState) _then;

/// Create a copy of ChatMemberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,}) {
  return _then(ChatMemberState(
memberList: null == memberList ? _self.memberList : memberList // ignore: cast_nullable_to_non_nullable
as List<ChatMember>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ChatMemberListResponseModel?,
  ));
}
/// Create a copy of ChatMemberState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMemberListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ChatMemberListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMemberState].
extension ChatMemberStatePatterns on ChatMemberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMemberState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMemberState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMemberState value)  $default,){
final _that = this;
switch (_that) {
case _ChatMemberState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMemberState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMemberState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMember> memberList,  int page,  int totalCount,  bool isLoadingMore,  ChatMemberListResponseModel? response)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMemberState() when $default != null:
return $default(_that.memberList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMember> memberList,  int page,  int totalCount,  bool isLoadingMore,  ChatMemberListResponseModel? response)  $default,) {final _that = this;
switch (_that) {
case _ChatMemberState():
return $default(_that.memberList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMember> memberList,  int page,  int totalCount,  bool isLoadingMore,  ChatMemberListResponseModel? response)?  $default,) {final _that = this;
switch (_that) {
case _ChatMemberState() when $default != null:
return $default(_that.memberList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMemberState implements ChatMemberState {
  const _ChatMemberState({ List<ChatMember> memberList = const [], this.page = 1, this.totalCount = 0, this.isLoadingMore = false, this.response = null}): _memberList = memberList;
  

 final  List<ChatMember> _memberList;
@override@JsonKey() List<ChatMember> get memberList {
  if (_memberList is EqualUnmodifiableListView) return _memberList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberList);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  ChatMemberListResponseModel? response;

/// Create a copy of ChatMemberState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMemberStateCopyWith<_ChatMemberState> get copyWith => __$ChatMemberStateCopyWithImpl<_ChatMemberState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMemberState&&const DeepCollectionEquality().equals(other.memberList, _memberList)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_memberList),page,totalCount,isLoadingMore,response);
}

@override
String toString() {
    return 'ChatMemberState(memberList: $memberList, page: $page, totalCount: $totalCount, isLoadingMore: $isLoadingMore, response: $response)';
}


}

/// @nodoc
abstract mixin class _$ChatMemberStateCopyWith<$Res> implements $ChatMemberStateCopyWith<$Res> {
  factory _$ChatMemberStateCopyWith(_ChatMemberState value, $Res Function(_ChatMemberState) _then) = __$ChatMemberStateCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMember> memberList, int page, int totalCount, bool isLoadingMore, ChatMemberListResponseModel? response
});


@override $ChatMemberListResponseModelCopyWith<$Res>? get response;

}
/// @nodoc
class __$ChatMemberStateCopyWithImpl<$Res>
    implements _$ChatMemberStateCopyWith<$Res> {
  __$ChatMemberStateCopyWithImpl(this._self, this._then);

  final _ChatMemberState _self;
  final $Res Function(_ChatMemberState) _then;

/// Create a copy of ChatMemberState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,}) {
  return _then(_ChatMemberState(
memberList: null == memberList ? _self._memberList : memberList // ignore: cast_nullable_to_non_nullable
as List<ChatMember>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ChatMemberListResponseModel?,
  ));
}

/// Create a copy of ChatMemberState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMemberListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ChatMemberListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}

// dart format on
