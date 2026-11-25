// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectionState {

 List<MemberListModel> get items; int get page; bool get isLoading; bool get isLoadingMore; int get totalCount; int get sentCount; int get receivedCount; int get acceptedCount; int get pendingReceivedCount; String get statusFilter; Object? get error;
/// Create a copy of ConnectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionStateCopyWith<ConnectionState> get copyWith => _$ConnectionStateCopyWithImpl<ConnectionState>(this as ConnectionState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConnectionState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionState&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.sentCount, _this.sentCount) || other.sentCount == _this.sentCount)&&(identical(other.receivedCount, _this.receivedCount) || other.receivedCount == _this.receivedCount)&&(identical(other.acceptedCount, _this.acceptedCount) || other.acceptedCount == _this.acceptedCount)&&(identical(other.pendingReceivedCount, _this.pendingReceivedCount) || other.pendingReceivedCount == _this.pendingReceivedCount)&&(identical(other.statusFilter, _this.statusFilter) || other.statusFilter == _this.statusFilter)&&const DeepCollectionEquality().equals(other.error, _this.error));
}


@override
int get hashCode {
  final _this = this as ConnectionState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.page,_this.isLoading,_this.isLoadingMore,_this.totalCount,_this.sentCount,_this.receivedCount,_this.acceptedCount,_this.pendingReceivedCount,_this.statusFilter,const DeepCollectionEquality().hash(_this.error));
}

@override
String toString() {
  final _this = this as ConnectionState;
  return 'ConnectionState(items: ${_this.items}, page: ${_this.page}, isLoading: ${_this.isLoading}, isLoadingMore: ${_this.isLoadingMore}, totalCount: ${_this.totalCount}, sentCount: ${_this.sentCount}, receivedCount: ${_this.receivedCount}, acceptedCount: ${_this.acceptedCount}, pendingReceivedCount: ${_this.pendingReceivedCount}, statusFilter: ${_this.statusFilter}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ConnectionStateCopyWith<$Res>  {
  factory $ConnectionStateCopyWith(ConnectionState value, $Res Function(ConnectionState) _then) = _$ConnectionStateCopyWithImpl;
@useResult
$Res call({
 List<MemberListModel> items, int page, bool isLoading, bool isLoadingMore, int totalCount, int sentCount, int receivedCount, int acceptedCount, int pendingReceivedCount, String statusFilter, Object? error
});




}
/// @nodoc
class _$ConnectionStateCopyWithImpl<$Res>
    implements $ConnectionStateCopyWith<$Res> {
  _$ConnectionStateCopyWithImpl(this._self, this._then);

  final ConnectionState _self;
  final $Res Function(ConnectionState) _then;

/// Create a copy of ConnectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? isLoading = null,Object? isLoadingMore = null,Object? totalCount = null,Object? sentCount = null,Object? receivedCount = null,Object? acceptedCount = null,Object? pendingReceivedCount = null,Object? statusFilter = null,Object? error = freezed,}) {
  return _then(ConnectionState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,receivedCount: null == receivedCount ? _self.receivedCount : receivedCount // ignore: cast_nullable_to_non_nullable
as int,acceptedCount: null == acceptedCount ? _self.acceptedCount : acceptedCount // ignore: cast_nullable_to_non_nullable
as int,pendingReceivedCount: null == pendingReceivedCount ? _self.pendingReceivedCount : pendingReceivedCount // ignore: cast_nullable_to_non_nullable
as int,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectionState].
extension ConnectionStatePatterns on ConnectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionState value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionState value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MemberListModel> items,  int page,  bool isLoading,  bool isLoadingMore,  int totalCount,  int sentCount,  int receivedCount,  int acceptedCount,  int pendingReceivedCount,  String statusFilter,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionState() when $default != null:
return $default(_that.items,_that.page,_that.isLoading,_that.isLoadingMore,_that.totalCount,_that.sentCount,_that.receivedCount,_that.acceptedCount,_that.pendingReceivedCount,_that.statusFilter,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MemberListModel> items,  int page,  bool isLoading,  bool isLoadingMore,  int totalCount,  int sentCount,  int receivedCount,  int acceptedCount,  int pendingReceivedCount,  String statusFilter,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _ConnectionState():
return $default(_that.items,_that.page,_that.isLoading,_that.isLoadingMore,_that.totalCount,_that.sentCount,_that.receivedCount,_that.acceptedCount,_that.pendingReceivedCount,_that.statusFilter,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MemberListModel> items,  int page,  bool isLoading,  bool isLoadingMore,  int totalCount,  int sentCount,  int receivedCount,  int acceptedCount,  int pendingReceivedCount,  String statusFilter,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionState() when $default != null:
return $default(_that.items,_that.page,_that.isLoading,_that.isLoadingMore,_that.totalCount,_that.sentCount,_that.receivedCount,_that.acceptedCount,_that.pendingReceivedCount,_that.statusFilter,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectionState implements ConnectionState {
  const _ConnectionState({ List<MemberListModel> items = const [], this.page = 1, this.isLoading = false, this.isLoadingMore = false, this.totalCount = 0, this.sentCount = 0, this.receivedCount = 0, this.acceptedCount = 0, this.pendingReceivedCount = 0, this.statusFilter = 'All', this.error}): _items = items;
  

 final  List<MemberListModel> _items;
@override@JsonKey() List<MemberListModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int sentCount;
@override@JsonKey() final  int receivedCount;
@override@JsonKey() final  int acceptedCount;
@override@JsonKey() final  int pendingReceivedCount;
@override@JsonKey() final  String statusFilter;
@override final  Object? error;

/// Create a copy of ConnectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionStateCopyWith<_ConnectionState> get copyWith => __$ConnectionStateCopyWithImpl<_ConnectionState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionState&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.receivedCount, receivedCount) || other.receivedCount == receivedCount)&&(identical(other.acceptedCount, acceptedCount) || other.acceptedCount == acceptedCount)&&(identical(other.pendingReceivedCount, pendingReceivedCount) || other.pendingReceivedCount == pendingReceivedCount)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,isLoading,isLoadingMore,totalCount,sentCount,receivedCount,acceptedCount,pendingReceivedCount,statusFilter,const DeepCollectionEquality().hash(error));
}

@override
String toString() {
    return 'ConnectionState(items: $items, page: $page, isLoading: $isLoading, isLoadingMore: $isLoadingMore, totalCount: $totalCount, sentCount: $sentCount, receivedCount: $receivedCount, acceptedCount: $acceptedCount, pendingReceivedCount: $pendingReceivedCount, statusFilter: $statusFilter, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ConnectionStateCopyWith<$Res> implements $ConnectionStateCopyWith<$Res> {
  factory _$ConnectionStateCopyWith(_ConnectionState value, $Res Function(_ConnectionState) _then) = __$ConnectionStateCopyWithImpl;
@override @useResult
$Res call({
 List<MemberListModel> items, int page, bool isLoading, bool isLoadingMore, int totalCount, int sentCount, int receivedCount, int acceptedCount, int pendingReceivedCount, String statusFilter, Object? error
});




}
/// @nodoc
class __$ConnectionStateCopyWithImpl<$Res>
    implements _$ConnectionStateCopyWith<$Res> {
  __$ConnectionStateCopyWithImpl(this._self, this._then);

  final _ConnectionState _self;
  final $Res Function(_ConnectionState) _then;

/// Create a copy of ConnectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? isLoading = null,Object? isLoadingMore = null,Object? totalCount = null,Object? sentCount = null,Object? receivedCount = null,Object? acceptedCount = null,Object? pendingReceivedCount = null,Object? statusFilter = null,Object? error = freezed,}) {
  return _then(_ConnectionState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,receivedCount: null == receivedCount ? _self.receivedCount : receivedCount // ignore: cast_nullable_to_non_nullable
as int,acceptedCount: null == acceptedCount ? _self.acceptedCount : acceptedCount // ignore: cast_nullable_to_non_nullable
as int,pendingReceivedCount: null == pendingReceivedCount ? _self.pendingReceivedCount : pendingReceivedCount // ignore: cast_nullable_to_non_nullable
as int,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
