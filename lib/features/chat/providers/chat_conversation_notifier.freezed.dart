// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_conversation_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatConversationState {

 List<ChatMessage> get messageList; int get page; int get totalCount; bool get isLoadingMore; ChatConversationListResponseModel? get response; ChatConversationData? get data;
/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatConversationStateCopyWith<ChatConversationState> get copyWith => _$ChatConversationStateCopyWithImpl<ChatConversationState>(this as ChatConversationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatConversationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatConversationState&&const DeepCollectionEquality().equals(other.messageList, _this.messageList)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.response, _this.response) || other.response == _this.response)&&(identical(other.data, _this.data) || other.data == _this.data));
}


@override
int get hashCode {
  final _this = this as ChatConversationState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.messageList),_this.page,_this.totalCount,_this.isLoadingMore,_this.response,_this.data);
}

@override
String toString() {
  final _this = this as ChatConversationState;
  return 'ChatConversationState(messageList: ${_this.messageList}, page: ${_this.page}, totalCount: ${_this.totalCount}, isLoadingMore: ${_this.isLoadingMore}, response: ${_this.response}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ChatConversationStateCopyWith<$Res>  {
  factory $ChatConversationStateCopyWith(ChatConversationState value, $Res Function(ChatConversationState) _then) = _$ChatConversationStateCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> messageList, int page, int totalCount, bool isLoadingMore, ChatConversationListResponseModel? response, ChatConversationData? data
});


$ChatConversationListResponseModelCopyWith<$Res>? get response;$ChatConversationDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ChatConversationStateCopyWithImpl<$Res>
    implements $ChatConversationStateCopyWith<$Res> {
  _$ChatConversationStateCopyWithImpl(this._self, this._then);

  final ChatConversationState _self;
  final $Res Function(ChatConversationState) _then;

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,Object? data = freezed,}) {
  return _then(ChatConversationState(
messageList: null == messageList ? _self.messageList : messageList // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ChatConversationListResponseModel?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatConversationData?,
  ));
}
/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConversationListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ChatConversationListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}/// Create a copy of ChatConversationState
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


/// Adds pattern-matching-related methods to [ChatConversationState].
extension ChatConversationStatePatterns on ChatConversationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatConversationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatConversationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatConversationState value)  $default,){
final _that = this;
switch (_that) {
case _ChatConversationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatConversationState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatConversationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessage> messageList,  int page,  int totalCount,  bool isLoadingMore,  ChatConversationListResponseModel? response,  ChatConversationData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatConversationState() when $default != null:
return $default(_that.messageList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessage> messageList,  int page,  int totalCount,  bool isLoadingMore,  ChatConversationListResponseModel? response,  ChatConversationData? data)  $default,) {final _that = this;
switch (_that) {
case _ChatConversationState():
return $default(_that.messageList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessage> messageList,  int page,  int totalCount,  bool isLoadingMore,  ChatConversationListResponseModel? response,  ChatConversationData? data)?  $default,) {final _that = this;
switch (_that) {
case _ChatConversationState() when $default != null:
return $default(_that.messageList,_that.page,_that.totalCount,_that.isLoadingMore,_that.response,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _ChatConversationState implements ChatConversationState {
  const _ChatConversationState({ List<ChatMessage> messageList = const [], this.page = 1, this.totalCount = 0, this.isLoadingMore = false, this.response = null, this.data = null}): _messageList = messageList;
  

 final  List<ChatMessage> _messageList;
@override@JsonKey() List<ChatMessage> get messageList {
  if (_messageList is EqualUnmodifiableListView) return _messageList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messageList);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  ChatConversationListResponseModel? response;
@override@JsonKey() final  ChatConversationData? data;

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatConversationStateCopyWith<_ChatConversationState> get copyWith => __$ChatConversationStateCopyWithImpl<_ChatConversationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatConversationState&&const DeepCollectionEquality().equals(other.messageList, _messageList)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.response, response) || other.response == response)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messageList),page,totalCount,isLoadingMore,response,data);
}

@override
String toString() {
    return 'ChatConversationState(messageList: $messageList, page: $page, totalCount: $totalCount, isLoadingMore: $isLoadingMore, response: $response, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ChatConversationStateCopyWith<$Res> implements $ChatConversationStateCopyWith<$Res> {
  factory _$ChatConversationStateCopyWith(_ChatConversationState value, $Res Function(_ChatConversationState) _then) = __$ChatConversationStateCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messageList, int page, int totalCount, bool isLoadingMore, ChatConversationListResponseModel? response, ChatConversationData? data
});


@override $ChatConversationListResponseModelCopyWith<$Res>? get response;@override $ChatConversationDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ChatConversationStateCopyWithImpl<$Res>
    implements _$ChatConversationStateCopyWith<$Res> {
  __$ChatConversationStateCopyWithImpl(this._self, this._then);

  final _ChatConversationState _self;
  final $Res Function(_ChatConversationState) _then;

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageList = null,Object? page = null,Object? totalCount = null,Object? isLoadingMore = null,Object? response = freezed,Object? data = freezed,}) {
  return _then(_ChatConversationState(
messageList: null == messageList ? _self._messageList : messageList // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ChatConversationListResponseModel?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatConversationData?,
  ));
}

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConversationListResponseModelCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ChatConversationListResponseModelCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}/// Create a copy of ChatConversationState
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

// dart format on
