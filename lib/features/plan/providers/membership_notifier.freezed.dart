// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MembershipState {

 bool get isLoading; PlanListResponseModel? get planList; CurrentPlanResponseModel? get currentPlan; Object? get error;
/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipStateCopyWith<MembershipState> get copyWith => _$MembershipStateCopyWithImpl<MembershipState>(this as MembershipState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MembershipState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipState&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.planList, _this.planList) || other.planList == _this.planList)&&(identical(other.currentPlan, _this.currentPlan) || other.currentPlan == _this.currentPlan)&&const DeepCollectionEquality().equals(other.error, _this.error));
}


@override
int get hashCode {
  final _this = this as MembershipState;
  return Object.hash(runtimeType,_this.isLoading,_this.planList,_this.currentPlan,const DeepCollectionEquality().hash(_this.error));
}

@override
String toString() {
  final _this = this as MembershipState;
  return 'MembershipState(isLoading: ${_this.isLoading}, planList: ${_this.planList}, currentPlan: ${_this.currentPlan}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $MembershipStateCopyWith<$Res>  {
  factory $MembershipStateCopyWith(MembershipState value, $Res Function(MembershipState) _then) = _$MembershipStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, PlanListResponseModel? planList, CurrentPlanResponseModel? currentPlan, Object? error
});


$PlanListResponseModelCopyWith<$Res>? get planList;$CurrentPlanResponseModelCopyWith<$Res>? get currentPlan;

}
/// @nodoc
class _$MembershipStateCopyWithImpl<$Res>
    implements $MembershipStateCopyWith<$Res> {
  _$MembershipStateCopyWithImpl(this._self, this._then);

  final MembershipState _self;
  final $Res Function(MembershipState) _then;

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? planList = freezed,Object? currentPlan = freezed,Object? error = freezed,}) {
  return _then(MembershipState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,planList: freezed == planList ? _self.planList : planList // ignore: cast_nullable_to_non_nullable
as PlanListResponseModel?,currentPlan: freezed == currentPlan ? _self.currentPlan : currentPlan // ignore: cast_nullable_to_non_nullable
as CurrentPlanResponseModel?,error: freezed == error ? _self.error : error ,
  ));
}
/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanListResponseModelCopyWith<$Res>? get planList {
    if (_self.planList == null) {
    return null;
  }

  return $PlanListResponseModelCopyWith<$Res>(_self.planList!, (value) {
    return _then(_self.copyWith(planList: value));
  });
}/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanResponseModelCopyWith<$Res>? get currentPlan {
    if (_self.currentPlan == null) {
    return null;
  }

  return $CurrentPlanResponseModelCopyWith<$Res>(_self.currentPlan!, (value) {
    return _then(_self.copyWith(currentPlan: value));
  });
}
}


/// Adds pattern-matching-related methods to [MembershipState].
extension MembershipStatePatterns on MembershipState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipState value)  $default,){
final _that = this;
switch (_that) {
case _MembershipState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipState value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  PlanListResponseModel? planList,  CurrentPlanResponseModel? currentPlan,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
return $default(_that.isLoading,_that.planList,_that.currentPlan,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  PlanListResponseModel? planList,  CurrentPlanResponseModel? currentPlan,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _MembershipState():
return $default(_that.isLoading,_that.planList,_that.currentPlan,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  PlanListResponseModel? planList,  CurrentPlanResponseModel? currentPlan,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
return $default(_that.isLoading,_that.planList,_that.currentPlan,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _MembershipState implements MembershipState {
  const _MembershipState({this.isLoading = false, this.planList, this.currentPlan, this.error});
  

@override@JsonKey() final  bool isLoading;
@override final  PlanListResponseModel? planList;
@override final  CurrentPlanResponseModel? currentPlan;
@override final  Object? error;

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipStateCopyWith<_MembershipState> get copyWith => __$MembershipStateCopyWithImpl<_MembershipState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.planList, planList) || other.planList == planList)&&(identical(other.currentPlan, currentPlan) || other.currentPlan == currentPlan)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isLoading,planList,currentPlan,const DeepCollectionEquality().hash(error));
}

@override
String toString() {
    return 'MembershipState(isLoading: $isLoading, planList: $planList, currentPlan: $currentPlan, error: $error)';
}


}

/// @nodoc
abstract mixin class _$MembershipStateCopyWith<$Res> implements $MembershipStateCopyWith<$Res> {
  factory _$MembershipStateCopyWith(_MembershipState value, $Res Function(_MembershipState) _then) = __$MembershipStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, PlanListResponseModel? planList, CurrentPlanResponseModel? currentPlan, Object? error
});


@override $PlanListResponseModelCopyWith<$Res>? get planList;@override $CurrentPlanResponseModelCopyWith<$Res>? get currentPlan;

}
/// @nodoc
class __$MembershipStateCopyWithImpl<$Res>
    implements _$MembershipStateCopyWith<$Res> {
  __$MembershipStateCopyWithImpl(this._self, this._then);

  final _MembershipState _self;
  final $Res Function(_MembershipState) _then;

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? planList = freezed,Object? currentPlan = freezed,Object? error = freezed,}) {
  return _then(_MembershipState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,planList: freezed == planList ? _self.planList : planList // ignore: cast_nullable_to_non_nullable
as PlanListResponseModel?,currentPlan: freezed == currentPlan ? _self.currentPlan : currentPlan // ignore: cast_nullable_to_non_nullable
as CurrentPlanResponseModel?,error: freezed == error ? _self.error : error ,
  ));
}

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanListResponseModelCopyWith<$Res>? get planList {
    if (_self.planList == null) {
    return null;
  }

  return $PlanListResponseModelCopyWith<$Res>(_self.planList!, (value) {
    return _then(_self.copyWith(planList: value));
  });
}/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanResponseModelCopyWith<$Res>? get currentPlan {
    if (_self.currentPlan == null) {
    return null;
  }

  return $CurrentPlanResponseModelCopyWith<$Res>(_self.currentPlan!, (value) {
    return _then(_self.copyWith(currentPlan: value));
  });
}
}

// dart format on
