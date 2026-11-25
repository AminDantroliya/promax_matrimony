// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatConversationState {

 PagingState<ChatMessage> get pagingState; ChatConversationData? get headerData; int get otherUserChatStatus;/// Locally overridable request/block status (updated optimistically after API calls)
 String? get localRequestStatus; int? get localRequestedBy; bool? get localIsChatBlocked;
/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatConversationStateCopyWith<ChatConversationState> get copyWith => _$ChatConversationStateCopyWithImpl<ChatConversationState>(this as ChatConversationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatConversationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatConversationState&&(identical(other.pagingState, _this.pagingState) || other.pagingState == _this.pagingState)&&(identical(other.headerData, _this.headerData) || other.headerData == _this.headerData)&&(identical(other.otherUserChatStatus, _this.otherUserChatStatus) || other.otherUserChatStatus == _this.otherUserChatStatus)&&(identical(other.localRequestStatus, _this.localRequestStatus) || other.localRequestStatus == _this.localRequestStatus)&&(identical(other.localRequestedBy, _this.localRequestedBy) || other.localRequestedBy == _this.localRequestedBy)&&(identical(other.localIsChatBlocked, _this.localIsChatBlocked) || other.localIsChatBlocked == _this.localIsChatBlocked));
}


@override
int get hashCode {
  final _this = this as ChatConversationState;
  return Object.hash(runtimeType,_this.pagingState,_this.headerData,_this.otherUserChatStatus,_this.localRequestStatus,_this.localRequestedBy,_this.localIsChatBlocked);
}

@override
String toString() {
  final _this = this as ChatConversationState;
  return 'ChatConversationState(pagingState: ${_this.pagingState}, headerData: ${_this.headerData}, otherUserChatStatus: ${_this.otherUserChatStatus}, localRequestStatus: ${_this.localRequestStatus}, localRequestedBy: ${_this.localRequestedBy}, localIsChatBlocked: ${_this.localIsChatBlocked})';
}


}

/// @nodoc
abstract mixin class $ChatConversationStateCopyWith<$Res>  {
  factory $ChatConversationStateCopyWith(ChatConversationState value, $Res Function(ChatConversationState) _then) = _$ChatConversationStateCopyWithImpl;
@useResult
$Res call({
 PagingState<ChatMessage> pagingState, ChatConversationData? headerData, int otherUserChatStatus, String? localRequestStatus, int? localRequestedBy, bool? localIsChatBlocked
});


$PagingStateCopyWith<ChatMessage, $Res> get pagingState;$ChatConversationDataCopyWith<$Res>? get headerData;

}
/// @nodoc
class _$ChatConversationStateCopyWithImpl<$Res>
    implements $ChatConversationStateCopyWith<$Res> {
  _$ChatConversationStateCopyWithImpl(this._self, this._then);

  final ChatConversationState _self;
  final $Res Function(ChatConversationState) _then;

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pagingState = null,Object? headerData = freezed,Object? otherUserChatStatus = null,Object? localRequestStatus = freezed,Object? localRequestedBy = freezed,Object? localIsChatBlocked = freezed,}) {
  return _then(ChatConversationState(
pagingState: null == pagingState ? _self.pagingState : pagingState // ignore: cast_nullable_to_non_nullable
as PagingState<ChatMessage>,headerData: freezed == headerData ? _self.headerData : headerData // ignore: cast_nullable_to_non_nullable
as ChatConversationData?,otherUserChatStatus: null == otherUserChatStatus ? _self.otherUserChatStatus : otherUserChatStatus // ignore: cast_nullable_to_non_nullable
as int,localRequestStatus: freezed == localRequestStatus ? _self.localRequestStatus : localRequestStatus // ignore: cast_nullable_to_non_nullable
as String?,localRequestedBy: freezed == localRequestedBy ? _self.localRequestedBy : localRequestedBy // ignore: cast_nullable_to_non_nullable
as int?,localIsChatBlocked: freezed == localIsChatBlocked ? _self.localIsChatBlocked : localIsChatBlocked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PagingStateCopyWith<ChatMessage, $Res> get pagingState {
  
  return $PagingStateCopyWith<ChatMessage, $Res>(_self.pagingState, (value) {
    return _then(_self.copyWith(pagingState: value));
  });
}/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConversationDataCopyWith<$Res>? get headerData {
    if (_self.headerData == null) {
    return null;
  }

  return $ChatConversationDataCopyWith<$Res>(_self.headerData!, (value) {
    return _then(_self.copyWith(headerData: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PagingState<ChatMessage> pagingState,  ChatConversationData? headerData,  int otherUserChatStatus,  String? localRequestStatus,  int? localRequestedBy,  bool? localIsChatBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatConversationState() when $default != null:
return $default(_that.pagingState,_that.headerData,_that.otherUserChatStatus,_that.localRequestStatus,_that.localRequestedBy,_that.localIsChatBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PagingState<ChatMessage> pagingState,  ChatConversationData? headerData,  int otherUserChatStatus,  String? localRequestStatus,  int? localRequestedBy,  bool? localIsChatBlocked)  $default,) {final _that = this;
switch (_that) {
case _ChatConversationState():
return $default(_that.pagingState,_that.headerData,_that.otherUserChatStatus,_that.localRequestStatus,_that.localRequestedBy,_that.localIsChatBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PagingState<ChatMessage> pagingState,  ChatConversationData? headerData,  int otherUserChatStatus,  String? localRequestStatus,  int? localRequestedBy,  bool? localIsChatBlocked)?  $default,) {final _that = this;
switch (_that) {
case _ChatConversationState() when $default != null:
return $default(_that.pagingState,_that.headerData,_that.otherUserChatStatus,_that.localRequestStatus,_that.localRequestedBy,_that.localIsChatBlocked);case _:
  return null;

}
}

}

/// @nodoc


class _ChatConversationState implements ChatConversationState {
  const _ChatConversationState({this.pagingState = const PagingState<ChatMessage>(), this.headerData, this.otherUserChatStatus = 0, this.localRequestStatus, this.localRequestedBy, this.localIsChatBlocked});
  

@override@JsonKey() final  PagingState<ChatMessage> pagingState;
@override final  ChatConversationData? headerData;
@override@JsonKey() final  int otherUserChatStatus;
/// Locally overridable request/block status (updated optimistically after API calls)
@override final  String? localRequestStatus;
@override final  int? localRequestedBy;
@override final  bool? localIsChatBlocked;

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatConversationStateCopyWith<_ChatConversationState> get copyWith => __$ChatConversationStateCopyWithImpl<_ChatConversationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatConversationState&&(identical(other.pagingState, pagingState) || other.pagingState == pagingState)&&(identical(other.headerData, headerData) || other.headerData == headerData)&&(identical(other.otherUserChatStatus, otherUserChatStatus) || other.otherUserChatStatus == otherUserChatStatus)&&(identical(other.localRequestStatus, localRequestStatus) || other.localRequestStatus == localRequestStatus)&&(identical(other.localRequestedBy, localRequestedBy) || other.localRequestedBy == localRequestedBy)&&(identical(other.localIsChatBlocked, localIsChatBlocked) || other.localIsChatBlocked == localIsChatBlocked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pagingState,headerData,otherUserChatStatus,localRequestStatus,localRequestedBy,localIsChatBlocked);
}

@override
String toString() {
    return 'ChatConversationState(pagingState: $pagingState, headerData: $headerData, otherUserChatStatus: $otherUserChatStatus, localRequestStatus: $localRequestStatus, localRequestedBy: $localRequestedBy, localIsChatBlocked: $localIsChatBlocked)';
}


}

/// @nodoc
abstract mixin class _$ChatConversationStateCopyWith<$Res> implements $ChatConversationStateCopyWith<$Res> {
  factory _$ChatConversationStateCopyWith(_ChatConversationState value, $Res Function(_ChatConversationState) _then) = __$ChatConversationStateCopyWithImpl;
@override @useResult
$Res call({
 PagingState<ChatMessage> pagingState, ChatConversationData? headerData, int otherUserChatStatus, String? localRequestStatus, int? localRequestedBy, bool? localIsChatBlocked
});


@override $PagingStateCopyWith<ChatMessage, $Res> get pagingState;@override $ChatConversationDataCopyWith<$Res>? get headerData;

}
/// @nodoc
class __$ChatConversationStateCopyWithImpl<$Res>
    implements _$ChatConversationStateCopyWith<$Res> {
  __$ChatConversationStateCopyWithImpl(this._self, this._then);

  final _ChatConversationState _self;
  final $Res Function(_ChatConversationState) _then;

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pagingState = null,Object? headerData = freezed,Object? otherUserChatStatus = null,Object? localRequestStatus = freezed,Object? localRequestedBy = freezed,Object? localIsChatBlocked = freezed,}) {
  return _then(_ChatConversationState(
pagingState: null == pagingState ? _self.pagingState : pagingState // ignore: cast_nullable_to_non_nullable
as PagingState<ChatMessage>,headerData: freezed == headerData ? _self.headerData : headerData // ignore: cast_nullable_to_non_nullable
as ChatConversationData?,otherUserChatStatus: null == otherUserChatStatus ? _self.otherUserChatStatus : otherUserChatStatus // ignore: cast_nullable_to_non_nullable
as int,localRequestStatus: freezed == localRequestStatus ? _self.localRequestStatus : localRequestStatus // ignore: cast_nullable_to_non_nullable
as String?,localRequestedBy: freezed == localRequestedBy ? _self.localRequestedBy : localRequestedBy // ignore: cast_nullable_to_non_nullable
as int?,localIsChatBlocked: freezed == localIsChatBlocked ? _self.localIsChatBlocked : localIsChatBlocked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PagingStateCopyWith<ChatMessage, $Res> get pagingState {
  
  return $PagingStateCopyWith<ChatMessage, $Res>(_self.pagingState, (value) {
    return _then(_self.copyWith(pagingState: value));
  });
}/// Create a copy of ChatConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConversationDataCopyWith<$Res>? get headerData {
    if (_self.headerData == null) {
    return null;
  }

  return $ChatConversationDataCopyWith<$Res>(_self.headerData!, (value) {
    return _then(_self.copyWith(headerData: value));
  });
}
}

// dart format on
