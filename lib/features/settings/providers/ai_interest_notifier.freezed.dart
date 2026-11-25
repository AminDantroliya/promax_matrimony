// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_interest_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiInterestState {

 bool get autoSendEnabled; int get dailyLimit; int get minMatchPercentage; bool get isSaving; bool get isLoadingList; List<AiInterestMatch>? get todayMatches; String? get error;
/// Create a copy of AiInterestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiInterestStateCopyWith<AiInterestState> get copyWith => _$AiInterestStateCopyWithImpl<AiInterestState>(this as AiInterestState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AiInterestState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiInterestState&&(identical(other.autoSendEnabled, _this.autoSendEnabled) || other.autoSendEnabled == _this.autoSendEnabled)&&(identical(other.dailyLimit, _this.dailyLimit) || other.dailyLimit == _this.dailyLimit)&&(identical(other.minMatchPercentage, _this.minMatchPercentage) || other.minMatchPercentage == _this.minMatchPercentage)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isLoadingList, _this.isLoadingList) || other.isLoadingList == _this.isLoadingList)&&const DeepCollectionEquality().equals(other.todayMatches, _this.todayMatches)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as AiInterestState;
  return Object.hash(runtimeType,_this.autoSendEnabled,_this.dailyLimit,_this.minMatchPercentage,_this.isSaving,_this.isLoadingList,const DeepCollectionEquality().hash(_this.todayMatches),_this.error);
}

@override
String toString() {
  final _this = this as AiInterestState;
  return 'AiInterestState(autoSendEnabled: ${_this.autoSendEnabled}, dailyLimit: ${_this.dailyLimit}, minMatchPercentage: ${_this.minMatchPercentage}, isSaving: ${_this.isSaving}, isLoadingList: ${_this.isLoadingList}, todayMatches: ${_this.todayMatches}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $AiInterestStateCopyWith<$Res>  {
  factory $AiInterestStateCopyWith(AiInterestState value, $Res Function(AiInterestState) _then) = _$AiInterestStateCopyWithImpl;
@useResult
$Res call({
 bool autoSendEnabled, int dailyLimit, int minMatchPercentage, bool isSaving, bool isLoadingList, List<AiInterestMatch>? todayMatches, String? error
});




}
/// @nodoc
class _$AiInterestStateCopyWithImpl<$Res>
    implements $AiInterestStateCopyWith<$Res> {
  _$AiInterestStateCopyWithImpl(this._self, this._then);

  final AiInterestState _self;
  final $Res Function(AiInterestState) _then;

/// Create a copy of AiInterestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoSendEnabled = null,Object? dailyLimit = null,Object? minMatchPercentage = null,Object? isSaving = null,Object? isLoadingList = null,Object? todayMatches = freezed,Object? error = freezed,}) {
  return _then(AiInterestState(
autoSendEnabled: null == autoSendEnabled ? _self.autoSendEnabled : autoSendEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailyLimit: null == dailyLimit ? _self.dailyLimit : dailyLimit // ignore: cast_nullable_to_non_nullable
as int,minMatchPercentage: null == minMatchPercentage ? _self.minMatchPercentage : minMatchPercentage // ignore: cast_nullable_to_non_nullable
as int,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isLoadingList: null == isLoadingList ? _self.isLoadingList : isLoadingList // ignore: cast_nullable_to_non_nullable
as bool,todayMatches: freezed == todayMatches ? _self.todayMatches : todayMatches // ignore: cast_nullable_to_non_nullable
as List<AiInterestMatch>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiInterestState].
extension AiInterestStatePatterns on AiInterestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiInterestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiInterestState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiInterestState value)  $default,){
final _that = this;
switch (_that) {
case _AiInterestState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiInterestState value)?  $default,){
final _that = this;
switch (_that) {
case _AiInterestState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool autoSendEnabled,  int dailyLimit,  int minMatchPercentage,  bool isSaving,  bool isLoadingList,  List<AiInterestMatch>? todayMatches,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiInterestState() when $default != null:
return $default(_that.autoSendEnabled,_that.dailyLimit,_that.minMatchPercentage,_that.isSaving,_that.isLoadingList,_that.todayMatches,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool autoSendEnabled,  int dailyLimit,  int minMatchPercentage,  bool isSaving,  bool isLoadingList,  List<AiInterestMatch>? todayMatches,  String? error)  $default,) {final _that = this;
switch (_that) {
case _AiInterestState():
return $default(_that.autoSendEnabled,_that.dailyLimit,_that.minMatchPercentage,_that.isSaving,_that.isLoadingList,_that.todayMatches,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool autoSendEnabled,  int dailyLimit,  int minMatchPercentage,  bool isSaving,  bool isLoadingList,  List<AiInterestMatch>? todayMatches,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _AiInterestState() when $default != null:
return $default(_that.autoSendEnabled,_that.dailyLimit,_that.minMatchPercentage,_that.isSaving,_that.isLoadingList,_that.todayMatches,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _AiInterestState implements AiInterestState {
  const _AiInterestState({this.autoSendEnabled = true, this.dailyLimit = 5, this.minMatchPercentage = 60, this.isSaving = false, this.isLoadingList = false,  List<AiInterestMatch>? todayMatches, this.error}): _todayMatches = todayMatches;
  

@override@JsonKey() final  bool autoSendEnabled;
@override@JsonKey() final  int dailyLimit;
@override@JsonKey() final  int minMatchPercentage;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isLoadingList;
 final  List<AiInterestMatch>? _todayMatches;
@override List<AiInterestMatch>? get todayMatches {
  final value = _todayMatches;
  if (value == null) return null;
  if (_todayMatches is EqualUnmodifiableListView) return _todayMatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? error;

/// Create a copy of AiInterestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiInterestStateCopyWith<_AiInterestState> get copyWith => __$AiInterestStateCopyWithImpl<_AiInterestState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiInterestState&&(identical(other.autoSendEnabled, autoSendEnabled) || other.autoSendEnabled == autoSendEnabled)&&(identical(other.dailyLimit, dailyLimit) || other.dailyLimit == dailyLimit)&&(identical(other.minMatchPercentage, minMatchPercentage) || other.minMatchPercentage == minMatchPercentage)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isLoadingList, isLoadingList) || other.isLoadingList == isLoadingList)&&const DeepCollectionEquality().equals(other.todayMatches, _todayMatches)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,autoSendEnabled,dailyLimit,minMatchPercentage,isSaving,isLoadingList,const DeepCollectionEquality().hash(_todayMatches),error);
}

@override
String toString() {
    return 'AiInterestState(autoSendEnabled: $autoSendEnabled, dailyLimit: $dailyLimit, minMatchPercentage: $minMatchPercentage, isSaving: $isSaving, isLoadingList: $isLoadingList, todayMatches: $todayMatches, error: $error)';
}


}

/// @nodoc
abstract mixin class _$AiInterestStateCopyWith<$Res> implements $AiInterestStateCopyWith<$Res> {
  factory _$AiInterestStateCopyWith(_AiInterestState value, $Res Function(_AiInterestState) _then) = __$AiInterestStateCopyWithImpl;
@override @useResult
$Res call({
 bool autoSendEnabled, int dailyLimit, int minMatchPercentage, bool isSaving, bool isLoadingList, List<AiInterestMatch>? todayMatches, String? error
});




}
/// @nodoc
class __$AiInterestStateCopyWithImpl<$Res>
    implements _$AiInterestStateCopyWith<$Res> {
  __$AiInterestStateCopyWithImpl(this._self, this._then);

  final _AiInterestState _self;
  final $Res Function(_AiInterestState) _then;

/// Create a copy of AiInterestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoSendEnabled = null,Object? dailyLimit = null,Object? minMatchPercentage = null,Object? isSaving = null,Object? isLoadingList = null,Object? todayMatches = freezed,Object? error = freezed,}) {
  return _then(_AiInterestState(
autoSendEnabled: null == autoSendEnabled ? _self.autoSendEnabled : autoSendEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailyLimit: null == dailyLimit ? _self.dailyLimit : dailyLimit // ignore: cast_nullable_to_non_nullable
as int,minMatchPercentage: null == minMatchPercentage ? _self.minMatchPercentage : minMatchPercentage // ignore: cast_nullable_to_non_nullable
as int,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isLoadingList: null == isLoadingList ? _self.isLoadingList : isLoadingList // ignore: cast_nullable_to_non_nullable
as bool,todayMatches: freezed == todayMatches ? _self._todayMatches : todayMatches // ignore: cast_nullable_to_non_nullable
as List<AiInterestMatch>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
