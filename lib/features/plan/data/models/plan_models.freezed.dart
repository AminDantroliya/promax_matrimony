// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanListResponseModel {

 int? get code; String? get status; String? get message; PlanListData? get data;
/// Create a copy of PlanListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanListResponseModelCopyWith<PlanListResponseModel> get copyWith => _$PlanListResponseModelCopyWithImpl<PlanListResponseModel>(this as PlanListResponseModel, _$identity);

  /// Serializes this PlanListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as PlanListResponseModel;
  return 'PlanListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $PlanListResponseModelCopyWith<$Res>  {
  factory $PlanListResponseModelCopyWith(PlanListResponseModel value, $Res Function(PlanListResponseModel) _then) = _$PlanListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, PlanListData? data
});


$PlanListDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$PlanListResponseModelCopyWithImpl<$Res>
    implements $PlanListResponseModelCopyWith<$Res> {
  _$PlanListResponseModelCopyWithImpl(this._self, this._then);

  final PlanListResponseModel _self;
  final $Res Function(PlanListResponseModel) _then;

/// Create a copy of PlanListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(PlanListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlanListData?,
  ));
}
/// Create a copy of PlanListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PlanListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanListResponseModel].
extension PlanListResponseModelPatterns on PlanListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  PlanListData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  PlanListData? data)  $default,) {final _that = this;
switch (_that) {
case _PlanListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  PlanListData? data)?  $default,) {final _that = this;
switch (_that) {
case _PlanListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanListResponseModel implements PlanListResponseModel {
  const _PlanListResponseModel({this.code, this.status, this.message, this.data});
  factory _PlanListResponseModel.fromJson(Map<String, dynamic> json) => _$PlanListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  PlanListData? data;

/// Create a copy of PlanListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanListResponseModelCopyWith<_PlanListResponseModel> get copyWith => __$PlanListResponseModelCopyWithImpl<_PlanListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'PlanListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PlanListResponseModelCopyWith<$Res> implements $PlanListResponseModelCopyWith<$Res> {
  factory _$PlanListResponseModelCopyWith(_PlanListResponseModel value, $Res Function(_PlanListResponseModel) _then) = __$PlanListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, PlanListData? data
});


@override $PlanListDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$PlanListResponseModelCopyWithImpl<$Res>
    implements _$PlanListResponseModelCopyWith<$Res> {
  __$PlanListResponseModelCopyWithImpl(this._self, this._then);

  final _PlanListResponseModel _self;
  final $Res Function(_PlanListResponseModel) _then;

/// Create a copy of PlanListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_PlanListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlanListData?,
  ));
}

/// Create a copy of PlanListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PlanListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$PlanListData {

@JsonKey(name: 'membership_plans') List<MembershipPlan>? get membershipPlanArr;@JsonKey(name: 'offline_payment') OfflinePayment? get offlinePayment;@JsonKey(name: 'coupon_data_list') List<CouponData>? get couponDataListArr;@JsonKey(name: 'add_on_plans') List<AddOnPlan>? get addOnPlanArr;@JsonKey(name: 'payment_methods') PaymentMethods? get paymentMethods;
/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanListDataCopyWith<PlanListData> get copyWith => _$PlanListDataCopyWithImpl<PlanListData>(this as PlanListData, _$identity);

  /// Serializes this PlanListData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanListData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanListData&&const DeepCollectionEquality().equals(other.membershipPlanArr, _this.membershipPlanArr)&&(identical(other.offlinePayment, _this.offlinePayment) || other.offlinePayment == _this.offlinePayment)&&const DeepCollectionEquality().equals(other.couponDataListArr, _this.couponDataListArr)&&const DeepCollectionEquality().equals(other.addOnPlanArr, _this.addOnPlanArr)&&(identical(other.paymentMethods, _this.paymentMethods) || other.paymentMethods == _this.paymentMethods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanListData;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.membershipPlanArr),_this.offlinePayment,const DeepCollectionEquality().hash(_this.couponDataListArr),const DeepCollectionEquality().hash(_this.addOnPlanArr),_this.paymentMethods);
}

@override
String toString() {
  final _this = this as PlanListData;
  return 'PlanListData(membershipPlanArr: ${_this.membershipPlanArr}, offlinePayment: ${_this.offlinePayment}, couponDataListArr: ${_this.couponDataListArr}, addOnPlanArr: ${_this.addOnPlanArr}, paymentMethods: ${_this.paymentMethods})';
}


}

/// @nodoc
abstract mixin class $PlanListDataCopyWith<$Res>  {
  factory $PlanListDataCopyWith(PlanListData value, $Res Function(PlanListData) _then) = _$PlanListDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'membership_plans') List<MembershipPlan>? membershipPlanArr,@JsonKey(name: 'offline_payment') OfflinePayment? offlinePayment,@JsonKey(name: 'coupon_data_list') List<CouponData>? couponDataListArr,@JsonKey(name: 'add_on_plans') List<AddOnPlan>? addOnPlanArr,@JsonKey(name: 'payment_methods') PaymentMethods? paymentMethods
});


$OfflinePaymentCopyWith<$Res>? get offlinePayment;$PaymentMethodsCopyWith<$Res>? get paymentMethods;

}
/// @nodoc
class _$PlanListDataCopyWithImpl<$Res>
    implements $PlanListDataCopyWith<$Res> {
  _$PlanListDataCopyWithImpl(this._self, this._then);

  final PlanListData _self;
  final $Res Function(PlanListData) _then;

/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? membershipPlanArr = freezed,Object? offlinePayment = freezed,Object? couponDataListArr = freezed,Object? addOnPlanArr = freezed,Object? paymentMethods = freezed,}) {
  return _then(PlanListData(
membershipPlanArr: freezed == membershipPlanArr ? _self.membershipPlanArr : membershipPlanArr // ignore: cast_nullable_to_non_nullable
as List<MembershipPlan>?,offlinePayment: freezed == offlinePayment ? _self.offlinePayment : offlinePayment // ignore: cast_nullable_to_non_nullable
as OfflinePayment?,couponDataListArr: freezed == couponDataListArr ? _self.couponDataListArr : couponDataListArr // ignore: cast_nullable_to_non_nullable
as List<CouponData>?,addOnPlanArr: freezed == addOnPlanArr ? _self.addOnPlanArr : addOnPlanArr // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>?,paymentMethods: freezed == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as PaymentMethods?,
  ));
}
/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OfflinePaymentCopyWith<$Res>? get offlinePayment {
    if (_self.offlinePayment == null) {
    return null;
  }

  return $OfflinePaymentCopyWith<$Res>(_self.offlinePayment!, (value) {
    return _then(_self.copyWith(offlinePayment: value));
  });
}/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodsCopyWith<$Res>? get paymentMethods {
    if (_self.paymentMethods == null) {
    return null;
  }

  return $PaymentMethodsCopyWith<$Res>(_self.paymentMethods!, (value) {
    return _then(_self.copyWith(paymentMethods: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanListData].
extension PlanListDataPatterns on PlanListData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanListData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanListData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanListData value)  $default,){
final _that = this;
switch (_that) {
case _PlanListData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanListData value)?  $default,){
final _that = this;
switch (_that) {
case _PlanListData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'membership_plans')  List<MembershipPlan>? membershipPlanArr, @JsonKey(name: 'offline_payment')  OfflinePayment? offlinePayment, @JsonKey(name: 'coupon_data_list')  List<CouponData>? couponDataListArr, @JsonKey(name: 'add_on_plans')  List<AddOnPlan>? addOnPlanArr, @JsonKey(name: 'payment_methods')  PaymentMethods? paymentMethods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanListData() when $default != null:
return $default(_that.membershipPlanArr,_that.offlinePayment,_that.couponDataListArr,_that.addOnPlanArr,_that.paymentMethods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'membership_plans')  List<MembershipPlan>? membershipPlanArr, @JsonKey(name: 'offline_payment')  OfflinePayment? offlinePayment, @JsonKey(name: 'coupon_data_list')  List<CouponData>? couponDataListArr, @JsonKey(name: 'add_on_plans')  List<AddOnPlan>? addOnPlanArr, @JsonKey(name: 'payment_methods')  PaymentMethods? paymentMethods)  $default,) {final _that = this;
switch (_that) {
case _PlanListData():
return $default(_that.membershipPlanArr,_that.offlinePayment,_that.couponDataListArr,_that.addOnPlanArr,_that.paymentMethods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'membership_plans')  List<MembershipPlan>? membershipPlanArr, @JsonKey(name: 'offline_payment')  OfflinePayment? offlinePayment, @JsonKey(name: 'coupon_data_list')  List<CouponData>? couponDataListArr, @JsonKey(name: 'add_on_plans')  List<AddOnPlan>? addOnPlanArr, @JsonKey(name: 'payment_methods')  PaymentMethods? paymentMethods)?  $default,) {final _that = this;
switch (_that) {
case _PlanListData() when $default != null:
return $default(_that.membershipPlanArr,_that.offlinePayment,_that.couponDataListArr,_that.addOnPlanArr,_that.paymentMethods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanListData implements PlanListData {
  const _PlanListData({@JsonKey(name: 'membership_plans')  List<MembershipPlan>? membershipPlanArr, @JsonKey(name: 'offline_payment') this.offlinePayment, @JsonKey(name: 'coupon_data_list')  List<CouponData>? couponDataListArr, @JsonKey(name: 'add_on_plans')  List<AddOnPlan>? addOnPlanArr, @JsonKey(name: 'payment_methods') this.paymentMethods}): _membershipPlanArr = membershipPlanArr,_couponDataListArr = couponDataListArr,_addOnPlanArr = addOnPlanArr;
  factory _PlanListData.fromJson(Map<String, dynamic> json) => _$PlanListDataFromJson(json);

 final  List<MembershipPlan>? _membershipPlanArr;
@override@JsonKey(name: 'membership_plans') List<MembershipPlan>? get membershipPlanArr {
  final value = _membershipPlanArr;
  if (value == null) return null;
  if (_membershipPlanArr is EqualUnmodifiableListView) return _membershipPlanArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'offline_payment') final  OfflinePayment? offlinePayment;
 final  List<CouponData>? _couponDataListArr;
@override@JsonKey(name: 'coupon_data_list') List<CouponData>? get couponDataListArr {
  final value = _couponDataListArr;
  if (value == null) return null;
  if (_couponDataListArr is EqualUnmodifiableListView) return _couponDataListArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<AddOnPlan>? _addOnPlanArr;
@override@JsonKey(name: 'add_on_plans') List<AddOnPlan>? get addOnPlanArr {
  final value = _addOnPlanArr;
  if (value == null) return null;
  if (_addOnPlanArr is EqualUnmodifiableListView) return _addOnPlanArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'payment_methods') final  PaymentMethods? paymentMethods;

/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanListDataCopyWith<_PlanListData> get copyWith => __$PlanListDataCopyWithImpl<_PlanListData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanListDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanListData&&const DeepCollectionEquality().equals(other.membershipPlanArr, _membershipPlanArr)&&(identical(other.offlinePayment, offlinePayment) || other.offlinePayment == offlinePayment)&&const DeepCollectionEquality().equals(other.couponDataListArr, _couponDataListArr)&&const DeepCollectionEquality().equals(other.addOnPlanArr, _addOnPlanArr)&&(identical(other.paymentMethods, paymentMethods) || other.paymentMethods == paymentMethods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_membershipPlanArr),offlinePayment,const DeepCollectionEquality().hash(_couponDataListArr),const DeepCollectionEquality().hash(_addOnPlanArr),paymentMethods);
}

@override
String toString() {
    return 'PlanListData(membershipPlanArr: $membershipPlanArr, offlinePayment: $offlinePayment, couponDataListArr: $couponDataListArr, addOnPlanArr: $addOnPlanArr, paymentMethods: $paymentMethods)';
}


}

/// @nodoc
abstract mixin class _$PlanListDataCopyWith<$Res> implements $PlanListDataCopyWith<$Res> {
  factory _$PlanListDataCopyWith(_PlanListData value, $Res Function(_PlanListData) _then) = __$PlanListDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'membership_plans') List<MembershipPlan>? membershipPlanArr,@JsonKey(name: 'offline_payment') OfflinePayment? offlinePayment,@JsonKey(name: 'coupon_data_list') List<CouponData>? couponDataListArr,@JsonKey(name: 'add_on_plans') List<AddOnPlan>? addOnPlanArr,@JsonKey(name: 'payment_methods') PaymentMethods? paymentMethods
});


@override $OfflinePaymentCopyWith<$Res>? get offlinePayment;@override $PaymentMethodsCopyWith<$Res>? get paymentMethods;

}
/// @nodoc
class __$PlanListDataCopyWithImpl<$Res>
    implements _$PlanListDataCopyWith<$Res> {
  __$PlanListDataCopyWithImpl(this._self, this._then);

  final _PlanListData _self;
  final $Res Function(_PlanListData) _then;

/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? membershipPlanArr = freezed,Object? offlinePayment = freezed,Object? couponDataListArr = freezed,Object? addOnPlanArr = freezed,Object? paymentMethods = freezed,}) {
  return _then(_PlanListData(
membershipPlanArr: freezed == membershipPlanArr ? _self._membershipPlanArr : membershipPlanArr // ignore: cast_nullable_to_non_nullable
as List<MembershipPlan>?,offlinePayment: freezed == offlinePayment ? _self.offlinePayment : offlinePayment // ignore: cast_nullable_to_non_nullable
as OfflinePayment?,couponDataListArr: freezed == couponDataListArr ? _self._couponDataListArr : couponDataListArr // ignore: cast_nullable_to_non_nullable
as List<CouponData>?,addOnPlanArr: freezed == addOnPlanArr ? _self._addOnPlanArr : addOnPlanArr // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>?,paymentMethods: freezed == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as PaymentMethods?,
  ));
}

/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OfflinePaymentCopyWith<$Res>? get offlinePayment {
    if (_self.offlinePayment == null) {
    return null;
  }

  return $OfflinePaymentCopyWith<$Res>(_self.offlinePayment!, (value) {
    return _then(_self.copyWith(offlinePayment: value));
  });
}/// Create a copy of PlanListData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodsCopyWith<$Res>? get paymentMethods {
    if (_self.paymentMethods == null) {
    return null;
  }

  return $PaymentMethodsCopyWith<$Res>(_self.paymentMethods!, (value) {
    return _then(_self.copyWith(paymentMethods: value));
  });
}
}


/// @nodoc
mixin _$MembershipPlan {

 int? get id;@JsonKey(name: 'plan_name') String? get planName;@JsonKey(name: 'in_app_product_id') dynamic get inAppProductId;@JsonKey(name: 'in_app_price') int? get inAppPrice;@JsonKey(name: 'plan_type') String? get planType;@JsonKey(name: 'plan_amount') dynamic get planAmount;@JsonKey(name: 'plan_currency') String? get planCurrency;@JsonKey(name: 'plan_currency_code') String? get planCurrencyCode; String? get chat;@JsonKey(name: 'plan_validity') String? get planValidity;@JsonKey(name: 'plan_interest') String? get planInterest;@JsonKey(name: 'plan_view_contact') String? get planViewContact;@JsonKey(name: 'plan_videocall_minute') String? get planVideocallMinute;@JsonKey(name: 'plan_audiocall_minute') String? get planAudiocallMinute;@JsonKey(name: 'plan_discount') dynamic get planDiscount; String? get status; String? get icon;@JsonKey(name: 'plan_description') String? get planDescription;@JsonKey(name: 'ai_interest') dynamic get aiInterest;@JsonKey(name: 'currency_code') String? get currencyCode;@JsonKey(name: 'validity_days') int? get validityDays;@JsonKey(name: 'interests_limit') int? get interestsLimit;@JsonKey(name: 'contact_views_limit') int? get contactViewsLimit;@JsonKey(name: 'video_minutes_limit') int? get videoMinutesLimit;@JsonKey(name: 'audio_minutes_limit') int? get audioMinutesLimit;@JsonKey(name: 'view_profile_limit') dynamic get viewProfileLimit;@JsonKey(name: 'plan_view_profile') dynamic get planViewProfile;@JsonKey(name: 'can_chat') dynamic get canChat;@JsonKey(name: 'photo_privacy') dynamic get photoPrivacy;@JsonKey(name: 'contact_privacy') dynamic get contactPrivacy;@JsonKey(name: 'is_personalized') dynamic get isPersonalized;@JsonKey(name: 'in_app_purchase_android_id') String? get inAppPurchaseAndroidId;@JsonKey(name: 'in_app_purchase_android_amount') String? get inAppPurchaseAndroidAmount;@JsonKey(name: 'in_app_purchase_ios_id') String? get inAppPurchaseIosId;@JsonKey(name: 'in_app_purchase_ios_amount') String? get inAppPurchaseIosAmount;
/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<MembershipPlan> get copyWith => _$MembershipPlanCopyWithImpl<MembershipPlan>(this as MembershipPlan, _$identity);

  /// Serializes this MembershipPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MembershipPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipPlan&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&const DeepCollectionEquality().equals(other.inAppProductId, _this.inAppProductId)&&(identical(other.inAppPrice, _this.inAppPrice) || other.inAppPrice == _this.inAppPrice)&&(identical(other.planType, _this.planType) || other.planType == _this.planType)&&const DeepCollectionEquality().equals(other.planAmount, _this.planAmount)&&(identical(other.planCurrency, _this.planCurrency) || other.planCurrency == _this.planCurrency)&&(identical(other.planCurrencyCode, _this.planCurrencyCode) || other.planCurrencyCode == _this.planCurrencyCode)&&(identical(other.chat, _this.chat) || other.chat == _this.chat)&&(identical(other.planValidity, _this.planValidity) || other.planValidity == _this.planValidity)&&(identical(other.planInterest, _this.planInterest) || other.planInterest == _this.planInterest)&&(identical(other.planViewContact, _this.planViewContact) || other.planViewContact == _this.planViewContact)&&(identical(other.planVideocallMinute, _this.planVideocallMinute) || other.planVideocallMinute == _this.planVideocallMinute)&&(identical(other.planAudiocallMinute, _this.planAudiocallMinute) || other.planAudiocallMinute == _this.planAudiocallMinute)&&const DeepCollectionEquality().equals(other.planDiscount, _this.planDiscount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.planDescription, _this.planDescription) || other.planDescription == _this.planDescription)&&const DeepCollectionEquality().equals(other.aiInterest, _this.aiInterest)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.validityDays, _this.validityDays) || other.validityDays == _this.validityDays)&&(identical(other.interestsLimit, _this.interestsLimit) || other.interestsLimit == _this.interestsLimit)&&(identical(other.contactViewsLimit, _this.contactViewsLimit) || other.contactViewsLimit == _this.contactViewsLimit)&&(identical(other.videoMinutesLimit, _this.videoMinutesLimit) || other.videoMinutesLimit == _this.videoMinutesLimit)&&(identical(other.audioMinutesLimit, _this.audioMinutesLimit) || other.audioMinutesLimit == _this.audioMinutesLimit)&&const DeepCollectionEquality().equals(other.viewProfileLimit, _this.viewProfileLimit)&&const DeepCollectionEquality().equals(other.planViewProfile, _this.planViewProfile)&&const DeepCollectionEquality().equals(other.canChat, _this.canChat)&&const DeepCollectionEquality().equals(other.photoPrivacy, _this.photoPrivacy)&&const DeepCollectionEquality().equals(other.contactPrivacy, _this.contactPrivacy)&&const DeepCollectionEquality().equals(other.isPersonalized, _this.isPersonalized)&&(identical(other.inAppPurchaseAndroidId, _this.inAppPurchaseAndroidId) || other.inAppPurchaseAndroidId == _this.inAppPurchaseAndroidId)&&(identical(other.inAppPurchaseAndroidAmount, _this.inAppPurchaseAndroidAmount) || other.inAppPurchaseAndroidAmount == _this.inAppPurchaseAndroidAmount)&&(identical(other.inAppPurchaseIosId, _this.inAppPurchaseIosId) || other.inAppPurchaseIosId == _this.inAppPurchaseIosId)&&(identical(other.inAppPurchaseIosAmount, _this.inAppPurchaseIosAmount) || other.inAppPurchaseIosAmount == _this.inAppPurchaseIosAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MembershipPlan;
  return Object.hashAll([runtimeType,_this.id,_this.planName,const DeepCollectionEquality().hash(_this.inAppProductId),_this.inAppPrice,_this.planType,const DeepCollectionEquality().hash(_this.planAmount),_this.planCurrency,_this.planCurrencyCode,_this.chat,_this.planValidity,_this.planInterest,_this.planViewContact,_this.planVideocallMinute,_this.planAudiocallMinute,const DeepCollectionEquality().hash(_this.planDiscount),_this.status,_this.icon,_this.planDescription,const DeepCollectionEquality().hash(_this.aiInterest),_this.currencyCode,_this.validityDays,_this.interestsLimit,_this.contactViewsLimit,_this.videoMinutesLimit,_this.audioMinutesLimit,const DeepCollectionEquality().hash(_this.viewProfileLimit),const DeepCollectionEquality().hash(_this.planViewProfile),const DeepCollectionEquality().hash(_this.canChat),const DeepCollectionEquality().hash(_this.photoPrivacy),const DeepCollectionEquality().hash(_this.contactPrivacy),const DeepCollectionEquality().hash(_this.isPersonalized),_this.inAppPurchaseAndroidId,_this.inAppPurchaseAndroidAmount,_this.inAppPurchaseIosId,_this.inAppPurchaseIosAmount]);
}

@override
String toString() {
  final _this = this as MembershipPlan;
  return 'MembershipPlan(id: ${_this.id}, planName: ${_this.planName}, inAppProductId: ${_this.inAppProductId}, inAppPrice: ${_this.inAppPrice}, planType: ${_this.planType}, planAmount: ${_this.planAmount}, planCurrency: ${_this.planCurrency}, planCurrencyCode: ${_this.planCurrencyCode}, chat: ${_this.chat}, planValidity: ${_this.planValidity}, planInterest: ${_this.planInterest}, planViewContact: ${_this.planViewContact}, planVideocallMinute: ${_this.planVideocallMinute}, planAudiocallMinute: ${_this.planAudiocallMinute}, planDiscount: ${_this.planDiscount}, status: ${_this.status}, icon: ${_this.icon}, planDescription: ${_this.planDescription}, aiInterest: ${_this.aiInterest}, currencyCode: ${_this.currencyCode}, validityDays: ${_this.validityDays}, interestsLimit: ${_this.interestsLimit}, contactViewsLimit: ${_this.contactViewsLimit}, videoMinutesLimit: ${_this.videoMinutesLimit}, audioMinutesLimit: ${_this.audioMinutesLimit}, viewProfileLimit: ${_this.viewProfileLimit}, planViewProfile: ${_this.planViewProfile}, canChat: ${_this.canChat}, photoPrivacy: ${_this.photoPrivacy}, contactPrivacy: ${_this.contactPrivacy}, isPersonalized: ${_this.isPersonalized}, inAppPurchaseAndroidId: ${_this.inAppPurchaseAndroidId}, inAppPurchaseAndroidAmount: ${_this.inAppPurchaseAndroidAmount}, inAppPurchaseIosId: ${_this.inAppPurchaseIosId}, inAppPurchaseIosAmount: ${_this.inAppPurchaseIosAmount})';
}


}

/// @nodoc
abstract mixin class $MembershipPlanCopyWith<$Res>  {
  factory $MembershipPlanCopyWith(MembershipPlan value, $Res Function(MembershipPlan) _then) = _$MembershipPlanCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'plan_name') String? planName,@JsonKey(name: 'in_app_product_id') dynamic inAppProductId,@JsonKey(name: 'in_app_price') int? inAppPrice,@JsonKey(name: 'plan_type') String? planType,@JsonKey(name: 'plan_amount') dynamic planAmount,@JsonKey(name: 'plan_currency') String? planCurrency,@JsonKey(name: 'plan_currency_code') String? planCurrencyCode, String? chat,@JsonKey(name: 'plan_validity') String? planValidity,@JsonKey(name: 'plan_interest') String? planInterest,@JsonKey(name: 'plan_view_contact') String? planViewContact,@JsonKey(name: 'plan_videocall_minute') String? planVideocallMinute,@JsonKey(name: 'plan_audiocall_minute') String? planAudiocallMinute,@JsonKey(name: 'plan_discount') dynamic planDiscount, String? status, String? icon,@JsonKey(name: 'plan_description') String? planDescription,@JsonKey(name: 'ai_interest') dynamic aiInterest,@JsonKey(name: 'currency_code') String? currencyCode,@JsonKey(name: 'validity_days') int? validityDays,@JsonKey(name: 'interests_limit') int? interestsLimit,@JsonKey(name: 'contact_views_limit') int? contactViewsLimit,@JsonKey(name: 'video_minutes_limit') int? videoMinutesLimit,@JsonKey(name: 'audio_minutes_limit') int? audioMinutesLimit,@JsonKey(name: 'view_profile_limit') dynamic viewProfileLimit,@JsonKey(name: 'plan_view_profile') dynamic planViewProfile,@JsonKey(name: 'can_chat') dynamic canChat,@JsonKey(name: 'photo_privacy') dynamic photoPrivacy,@JsonKey(name: 'contact_privacy') dynamic contactPrivacy,@JsonKey(name: 'is_personalized') dynamic isPersonalized,@JsonKey(name: 'in_app_purchase_android_id') String? inAppPurchaseAndroidId,@JsonKey(name: 'in_app_purchase_android_amount') String? inAppPurchaseAndroidAmount,@JsonKey(name: 'in_app_purchase_ios_id') String? inAppPurchaseIosId,@JsonKey(name: 'in_app_purchase_ios_amount') String? inAppPurchaseIosAmount
});




}
/// @nodoc
class _$MembershipPlanCopyWithImpl<$Res>
    implements $MembershipPlanCopyWith<$Res> {
  _$MembershipPlanCopyWithImpl(this._self, this._then);

  final MembershipPlan _self;
  final $Res Function(MembershipPlan) _then;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? planName = freezed,Object? inAppProductId = freezed,Object? inAppPrice = freezed,Object? planType = freezed,Object? planAmount = freezed,Object? planCurrency = freezed,Object? planCurrencyCode = freezed,Object? chat = freezed,Object? planValidity = freezed,Object? planInterest = freezed,Object? planViewContact = freezed,Object? planVideocallMinute = freezed,Object? planAudiocallMinute = freezed,Object? planDiscount = freezed,Object? status = freezed,Object? icon = freezed,Object? planDescription = freezed,Object? aiInterest = freezed,Object? currencyCode = freezed,Object? validityDays = freezed,Object? interestsLimit = freezed,Object? contactViewsLimit = freezed,Object? videoMinutesLimit = freezed,Object? audioMinutesLimit = freezed,Object? viewProfileLimit = freezed,Object? planViewProfile = freezed,Object? canChat = freezed,Object? photoPrivacy = freezed,Object? contactPrivacy = freezed,Object? isPersonalized = freezed,Object? inAppPurchaseAndroidId = freezed,Object? inAppPurchaseAndroidAmount = freezed,Object? inAppPurchaseIosId = freezed,Object? inAppPurchaseIosAmount = freezed,}) {
  return _then(MembershipPlan(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,inAppProductId: freezed == inAppProductId ? _self.inAppProductId : inAppProductId // ignore: cast_nullable_to_non_nullable
as dynamic,inAppPrice: freezed == inAppPrice ? _self.inAppPrice : inAppPrice // ignore: cast_nullable_to_non_nullable
as int?,planType: freezed == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
as String?,planAmount: freezed == planAmount ? _self.planAmount : planAmount // ignore: cast_nullable_to_non_nullable
as dynamic,planCurrency: freezed == planCurrency ? _self.planCurrency : planCurrency // ignore: cast_nullable_to_non_nullable
as String?,planCurrencyCode: freezed == planCurrencyCode ? _self.planCurrencyCode : planCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,chat: freezed == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as String?,planValidity: freezed == planValidity ? _self.planValidity : planValidity // ignore: cast_nullable_to_non_nullable
as String?,planInterest: freezed == planInterest ? _self.planInterest : planInterest // ignore: cast_nullable_to_non_nullable
as String?,planViewContact: freezed == planViewContact ? _self.planViewContact : planViewContact // ignore: cast_nullable_to_non_nullable
as String?,planVideocallMinute: freezed == planVideocallMinute ? _self.planVideocallMinute : planVideocallMinute // ignore: cast_nullable_to_non_nullable
as String?,planAudiocallMinute: freezed == planAudiocallMinute ? _self.planAudiocallMinute : planAudiocallMinute // ignore: cast_nullable_to_non_nullable
as String?,planDiscount: freezed == planDiscount ? _self.planDiscount : planDiscount // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,planDescription: freezed == planDescription ? _self.planDescription : planDescription // ignore: cast_nullable_to_non_nullable
as String?,aiInterest: freezed == aiInterest ? _self.aiInterest : aiInterest // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,validityDays: freezed == validityDays ? _self.validityDays : validityDays // ignore: cast_nullable_to_non_nullable
as int?,interestsLimit: freezed == interestsLimit ? _self.interestsLimit : interestsLimit // ignore: cast_nullable_to_non_nullable
as int?,contactViewsLimit: freezed == contactViewsLimit ? _self.contactViewsLimit : contactViewsLimit // ignore: cast_nullable_to_non_nullable
as int?,videoMinutesLimit: freezed == videoMinutesLimit ? _self.videoMinutesLimit : videoMinutesLimit // ignore: cast_nullable_to_non_nullable
as int?,audioMinutesLimit: freezed == audioMinutesLimit ? _self.audioMinutesLimit : audioMinutesLimit // ignore: cast_nullable_to_non_nullable
as int?,viewProfileLimit: freezed == viewProfileLimit ? _self.viewProfileLimit : viewProfileLimit // ignore: cast_nullable_to_non_nullable
as dynamic,planViewProfile: freezed == planViewProfile ? _self.planViewProfile : planViewProfile // ignore: cast_nullable_to_non_nullable
as dynamic,canChat: freezed == canChat ? _self.canChat : canChat // ignore: cast_nullable_to_non_nullable
as dynamic,photoPrivacy: freezed == photoPrivacy ? _self.photoPrivacy : photoPrivacy // ignore: cast_nullable_to_non_nullable
as dynamic,contactPrivacy: freezed == contactPrivacy ? _self.contactPrivacy : contactPrivacy // ignore: cast_nullable_to_non_nullable
as dynamic,isPersonalized: freezed == isPersonalized ? _self.isPersonalized : isPersonalized // ignore: cast_nullable_to_non_nullable
as dynamic,inAppPurchaseAndroidId: freezed == inAppPurchaseAndroidId ? _self.inAppPurchaseAndroidId : inAppPurchaseAndroidId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseAndroidAmount: freezed == inAppPurchaseAndroidAmount ? _self.inAppPurchaseAndroidAmount : inAppPurchaseAndroidAmount // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosId: freezed == inAppPurchaseIosId ? _self.inAppPurchaseIosId : inAppPurchaseIosId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosAmount: freezed == inAppPurchaseIosAmount ? _self.inAppPurchaseIosAmount : inAppPurchaseIosAmount // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MembershipPlan].
extension MembershipPlanPatterns on MembershipPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipPlan value)  $default,){
final _that = this;
switch (_that) {
case _MembershipPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipPlan value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'plan_name')  String? planName, @JsonKey(name: 'in_app_product_id')  dynamic inAppProductId, @JsonKey(name: 'in_app_price')  int? inAppPrice, @JsonKey(name: 'plan_type')  String? planType, @JsonKey(name: 'plan_amount')  dynamic planAmount, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'plan_currency_code')  String? planCurrencyCode,  String? chat, @JsonKey(name: 'plan_validity')  String? planValidity, @JsonKey(name: 'plan_interest')  String? planInterest, @JsonKey(name: 'plan_view_contact')  String? planViewContact, @JsonKey(name: 'plan_videocall_minute')  String? planVideocallMinute, @JsonKey(name: 'plan_audiocall_minute')  String? planAudiocallMinute, @JsonKey(name: 'plan_discount')  dynamic planDiscount,  String? status,  String? icon, @JsonKey(name: 'plan_description')  String? planDescription, @JsonKey(name: 'ai_interest')  dynamic aiInterest, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'validity_days')  int? validityDays, @JsonKey(name: 'interests_limit')  int? interestsLimit, @JsonKey(name: 'contact_views_limit')  int? contactViewsLimit, @JsonKey(name: 'video_minutes_limit')  int? videoMinutesLimit, @JsonKey(name: 'audio_minutes_limit')  int? audioMinutesLimit, @JsonKey(name: 'view_profile_limit')  dynamic viewProfileLimit, @JsonKey(name: 'plan_view_profile')  dynamic planViewProfile, @JsonKey(name: 'can_chat')  dynamic canChat, @JsonKey(name: 'photo_privacy')  dynamic photoPrivacy, @JsonKey(name: 'contact_privacy')  dynamic contactPrivacy, @JsonKey(name: 'is_personalized')  dynamic isPersonalized, @JsonKey(name: 'in_app_purchase_android_id')  String? inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount')  String? inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id')  String? inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount')  String? inAppPurchaseIosAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
return $default(_that.id,_that.planName,_that.inAppProductId,_that.inAppPrice,_that.planType,_that.planAmount,_that.planCurrency,_that.planCurrencyCode,_that.chat,_that.planValidity,_that.planInterest,_that.planViewContact,_that.planVideocallMinute,_that.planAudiocallMinute,_that.planDiscount,_that.status,_that.icon,_that.planDescription,_that.aiInterest,_that.currencyCode,_that.validityDays,_that.interestsLimit,_that.contactViewsLimit,_that.videoMinutesLimit,_that.audioMinutesLimit,_that.viewProfileLimit,_that.planViewProfile,_that.canChat,_that.photoPrivacy,_that.contactPrivacy,_that.isPersonalized,_that.inAppPurchaseAndroidId,_that.inAppPurchaseAndroidAmount,_that.inAppPurchaseIosId,_that.inAppPurchaseIosAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'plan_name')  String? planName, @JsonKey(name: 'in_app_product_id')  dynamic inAppProductId, @JsonKey(name: 'in_app_price')  int? inAppPrice, @JsonKey(name: 'plan_type')  String? planType, @JsonKey(name: 'plan_amount')  dynamic planAmount, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'plan_currency_code')  String? planCurrencyCode,  String? chat, @JsonKey(name: 'plan_validity')  String? planValidity, @JsonKey(name: 'plan_interest')  String? planInterest, @JsonKey(name: 'plan_view_contact')  String? planViewContact, @JsonKey(name: 'plan_videocall_minute')  String? planVideocallMinute, @JsonKey(name: 'plan_audiocall_minute')  String? planAudiocallMinute, @JsonKey(name: 'plan_discount')  dynamic planDiscount,  String? status,  String? icon, @JsonKey(name: 'plan_description')  String? planDescription, @JsonKey(name: 'ai_interest')  dynamic aiInterest, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'validity_days')  int? validityDays, @JsonKey(name: 'interests_limit')  int? interestsLimit, @JsonKey(name: 'contact_views_limit')  int? contactViewsLimit, @JsonKey(name: 'video_minutes_limit')  int? videoMinutesLimit, @JsonKey(name: 'audio_minutes_limit')  int? audioMinutesLimit, @JsonKey(name: 'view_profile_limit')  dynamic viewProfileLimit, @JsonKey(name: 'plan_view_profile')  dynamic planViewProfile, @JsonKey(name: 'can_chat')  dynamic canChat, @JsonKey(name: 'photo_privacy')  dynamic photoPrivacy, @JsonKey(name: 'contact_privacy')  dynamic contactPrivacy, @JsonKey(name: 'is_personalized')  dynamic isPersonalized, @JsonKey(name: 'in_app_purchase_android_id')  String? inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount')  String? inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id')  String? inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount')  String? inAppPurchaseIosAmount)  $default,) {final _that = this;
switch (_that) {
case _MembershipPlan():
return $default(_that.id,_that.planName,_that.inAppProductId,_that.inAppPrice,_that.planType,_that.planAmount,_that.planCurrency,_that.planCurrencyCode,_that.chat,_that.planValidity,_that.planInterest,_that.planViewContact,_that.planVideocallMinute,_that.planAudiocallMinute,_that.planDiscount,_that.status,_that.icon,_that.planDescription,_that.aiInterest,_that.currencyCode,_that.validityDays,_that.interestsLimit,_that.contactViewsLimit,_that.videoMinutesLimit,_that.audioMinutesLimit,_that.viewProfileLimit,_that.planViewProfile,_that.canChat,_that.photoPrivacy,_that.contactPrivacy,_that.isPersonalized,_that.inAppPurchaseAndroidId,_that.inAppPurchaseAndroidAmount,_that.inAppPurchaseIosId,_that.inAppPurchaseIosAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'plan_name')  String? planName, @JsonKey(name: 'in_app_product_id')  dynamic inAppProductId, @JsonKey(name: 'in_app_price')  int? inAppPrice, @JsonKey(name: 'plan_type')  String? planType, @JsonKey(name: 'plan_amount')  dynamic planAmount, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'plan_currency_code')  String? planCurrencyCode,  String? chat, @JsonKey(name: 'plan_validity')  String? planValidity, @JsonKey(name: 'plan_interest')  String? planInterest, @JsonKey(name: 'plan_view_contact')  String? planViewContact, @JsonKey(name: 'plan_videocall_minute')  String? planVideocallMinute, @JsonKey(name: 'plan_audiocall_minute')  String? planAudiocallMinute, @JsonKey(name: 'plan_discount')  dynamic planDiscount,  String? status,  String? icon, @JsonKey(name: 'plan_description')  String? planDescription, @JsonKey(name: 'ai_interest')  dynamic aiInterest, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'validity_days')  int? validityDays, @JsonKey(name: 'interests_limit')  int? interestsLimit, @JsonKey(name: 'contact_views_limit')  int? contactViewsLimit, @JsonKey(name: 'video_minutes_limit')  int? videoMinutesLimit, @JsonKey(name: 'audio_minutes_limit')  int? audioMinutesLimit, @JsonKey(name: 'view_profile_limit')  dynamic viewProfileLimit, @JsonKey(name: 'plan_view_profile')  dynamic planViewProfile, @JsonKey(name: 'can_chat')  dynamic canChat, @JsonKey(name: 'photo_privacy')  dynamic photoPrivacy, @JsonKey(name: 'contact_privacy')  dynamic contactPrivacy, @JsonKey(name: 'is_personalized')  dynamic isPersonalized, @JsonKey(name: 'in_app_purchase_android_id')  String? inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount')  String? inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id')  String? inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount')  String? inAppPurchaseIosAmount)?  $default,) {final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
return $default(_that.id,_that.planName,_that.inAppProductId,_that.inAppPrice,_that.planType,_that.planAmount,_that.planCurrency,_that.planCurrencyCode,_that.chat,_that.planValidity,_that.planInterest,_that.planViewContact,_that.planVideocallMinute,_that.planAudiocallMinute,_that.planDiscount,_that.status,_that.icon,_that.planDescription,_that.aiInterest,_that.currencyCode,_that.validityDays,_that.interestsLimit,_that.contactViewsLimit,_that.videoMinutesLimit,_that.audioMinutesLimit,_that.viewProfileLimit,_that.planViewProfile,_that.canChat,_that.photoPrivacy,_that.contactPrivacy,_that.isPersonalized,_that.inAppPurchaseAndroidId,_that.inAppPurchaseAndroidAmount,_that.inAppPurchaseIosId,_that.inAppPurchaseIosAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MembershipPlan implements MembershipPlan {
  const _MembershipPlan({this.id, @JsonKey(name: 'plan_name') this.planName, @JsonKey(name: 'in_app_product_id') this.inAppProductId, @JsonKey(name: 'in_app_price') this.inAppPrice, @JsonKey(name: 'plan_type') this.planType, @JsonKey(name: 'plan_amount') this.planAmount, @JsonKey(name: 'plan_currency') this.planCurrency, @JsonKey(name: 'plan_currency_code') this.planCurrencyCode, this.chat, @JsonKey(name: 'plan_validity') this.planValidity, @JsonKey(name: 'plan_interest') this.planInterest, @JsonKey(name: 'plan_view_contact') this.planViewContact, @JsonKey(name: 'plan_videocall_minute') this.planVideocallMinute, @JsonKey(name: 'plan_audiocall_minute') this.planAudiocallMinute, @JsonKey(name: 'plan_discount') this.planDiscount, this.status, this.icon, @JsonKey(name: 'plan_description') this.planDescription, @JsonKey(name: 'ai_interest') this.aiInterest, @JsonKey(name: 'currency_code') this.currencyCode, @JsonKey(name: 'validity_days') this.validityDays, @JsonKey(name: 'interests_limit') this.interestsLimit, @JsonKey(name: 'contact_views_limit') this.contactViewsLimit, @JsonKey(name: 'video_minutes_limit') this.videoMinutesLimit, @JsonKey(name: 'audio_minutes_limit') this.audioMinutesLimit, @JsonKey(name: 'view_profile_limit') this.viewProfileLimit, @JsonKey(name: 'plan_view_profile') this.planViewProfile, @JsonKey(name: 'can_chat') this.canChat, @JsonKey(name: 'photo_privacy') this.photoPrivacy, @JsonKey(name: 'contact_privacy') this.contactPrivacy, @JsonKey(name: 'is_personalized') this.isPersonalized, @JsonKey(name: 'in_app_purchase_android_id') this.inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount') this.inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id') this.inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount') this.inAppPurchaseIosAmount});
  factory _MembershipPlan.fromJson(Map<String, dynamic> json) => _$MembershipPlanFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'plan_name') final  String? planName;
@override@JsonKey(name: 'in_app_product_id') final  dynamic inAppProductId;
@override@JsonKey(name: 'in_app_price') final  int? inAppPrice;
@override@JsonKey(name: 'plan_type') final  String? planType;
@override@JsonKey(name: 'plan_amount') final  dynamic planAmount;
@override@JsonKey(name: 'plan_currency') final  String? planCurrency;
@override@JsonKey(name: 'plan_currency_code') final  String? planCurrencyCode;
@override final  String? chat;
@override@JsonKey(name: 'plan_validity') final  String? planValidity;
@override@JsonKey(name: 'plan_interest') final  String? planInterest;
@override@JsonKey(name: 'plan_view_contact') final  String? planViewContact;
@override@JsonKey(name: 'plan_videocall_minute') final  String? planVideocallMinute;
@override@JsonKey(name: 'plan_audiocall_minute') final  String? planAudiocallMinute;
@override@JsonKey(name: 'plan_discount') final  dynamic planDiscount;
@override final  String? status;
@override final  String? icon;
@override@JsonKey(name: 'plan_description') final  String? planDescription;
@override@JsonKey(name: 'ai_interest') final  dynamic aiInterest;
@override@JsonKey(name: 'currency_code') final  String? currencyCode;
@override@JsonKey(name: 'validity_days') final  int? validityDays;
@override@JsonKey(name: 'interests_limit') final  int? interestsLimit;
@override@JsonKey(name: 'contact_views_limit') final  int? contactViewsLimit;
@override@JsonKey(name: 'video_minutes_limit') final  int? videoMinutesLimit;
@override@JsonKey(name: 'audio_minutes_limit') final  int? audioMinutesLimit;
@override@JsonKey(name: 'view_profile_limit') final  dynamic viewProfileLimit;
@override@JsonKey(name: 'plan_view_profile') final  dynamic planViewProfile;
@override@JsonKey(name: 'can_chat') final  dynamic canChat;
@override@JsonKey(name: 'photo_privacy') final  dynamic photoPrivacy;
@override@JsonKey(name: 'contact_privacy') final  dynamic contactPrivacy;
@override@JsonKey(name: 'is_personalized') final  dynamic isPersonalized;
@override@JsonKey(name: 'in_app_purchase_android_id') final  String? inAppPurchaseAndroidId;
@override@JsonKey(name: 'in_app_purchase_android_amount') final  String? inAppPurchaseAndroidAmount;
@override@JsonKey(name: 'in_app_purchase_ios_id') final  String? inAppPurchaseIosId;
@override@JsonKey(name: 'in_app_purchase_ios_amount') final  String? inAppPurchaseIosAmount;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipPlanCopyWith<_MembershipPlan> get copyWith => __$MembershipPlanCopyWithImpl<_MembershipPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MembershipPlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.planName, planName) || other.planName == planName)&&const DeepCollectionEquality().equals(other.inAppProductId, inAppProductId)&&(identical(other.inAppPrice, inAppPrice) || other.inAppPrice == inAppPrice)&&(identical(other.planType, planType) || other.planType == planType)&&const DeepCollectionEquality().equals(other.planAmount, planAmount)&&(identical(other.planCurrency, planCurrency) || other.planCurrency == planCurrency)&&(identical(other.planCurrencyCode, planCurrencyCode) || other.planCurrencyCode == planCurrencyCode)&&(identical(other.chat, chat) || other.chat == chat)&&(identical(other.planValidity, planValidity) || other.planValidity == planValidity)&&(identical(other.planInterest, planInterest) || other.planInterest == planInterest)&&(identical(other.planViewContact, planViewContact) || other.planViewContact == planViewContact)&&(identical(other.planVideocallMinute, planVideocallMinute) || other.planVideocallMinute == planVideocallMinute)&&(identical(other.planAudiocallMinute, planAudiocallMinute) || other.planAudiocallMinute == planAudiocallMinute)&&const DeepCollectionEquality().equals(other.planDiscount, planDiscount)&&(identical(other.status, status) || other.status == status)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.planDescription, planDescription) || other.planDescription == planDescription)&&const DeepCollectionEquality().equals(other.aiInterest, aiInterest)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.validityDays, validityDays) || other.validityDays == validityDays)&&(identical(other.interestsLimit, interestsLimit) || other.interestsLimit == interestsLimit)&&(identical(other.contactViewsLimit, contactViewsLimit) || other.contactViewsLimit == contactViewsLimit)&&(identical(other.videoMinutesLimit, videoMinutesLimit) || other.videoMinutesLimit == videoMinutesLimit)&&(identical(other.audioMinutesLimit, audioMinutesLimit) || other.audioMinutesLimit == audioMinutesLimit)&&const DeepCollectionEquality().equals(other.viewProfileLimit, viewProfileLimit)&&const DeepCollectionEquality().equals(other.planViewProfile, planViewProfile)&&const DeepCollectionEquality().equals(other.canChat, canChat)&&const DeepCollectionEquality().equals(other.photoPrivacy, photoPrivacy)&&const DeepCollectionEquality().equals(other.contactPrivacy, contactPrivacy)&&const DeepCollectionEquality().equals(other.isPersonalized, isPersonalized)&&(identical(other.inAppPurchaseAndroidId, inAppPurchaseAndroidId) || other.inAppPurchaseAndroidId == inAppPurchaseAndroidId)&&(identical(other.inAppPurchaseAndroidAmount, inAppPurchaseAndroidAmount) || other.inAppPurchaseAndroidAmount == inAppPurchaseAndroidAmount)&&(identical(other.inAppPurchaseIosId, inAppPurchaseIosId) || other.inAppPurchaseIosId == inAppPurchaseIosId)&&(identical(other.inAppPurchaseIosAmount, inAppPurchaseIosAmount) || other.inAppPurchaseIosAmount == inAppPurchaseIosAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,planName,const DeepCollectionEquality().hash(inAppProductId),inAppPrice,planType,const DeepCollectionEquality().hash(planAmount),planCurrency,planCurrencyCode,chat,planValidity,planInterest,planViewContact,planVideocallMinute,planAudiocallMinute,const DeepCollectionEquality().hash(planDiscount),status,icon,planDescription,const DeepCollectionEquality().hash(aiInterest),currencyCode,validityDays,interestsLimit,contactViewsLimit,videoMinutesLimit,audioMinutesLimit,const DeepCollectionEquality().hash(viewProfileLimit),const DeepCollectionEquality().hash(planViewProfile),const DeepCollectionEquality().hash(canChat),const DeepCollectionEquality().hash(photoPrivacy),const DeepCollectionEquality().hash(contactPrivacy),const DeepCollectionEquality().hash(isPersonalized),inAppPurchaseAndroidId,inAppPurchaseAndroidAmount,inAppPurchaseIosId,inAppPurchaseIosAmount]);
}

@override
String toString() {
    return 'MembershipPlan(id: $id, planName: $planName, inAppProductId: $inAppProductId, inAppPrice: $inAppPrice, planType: $planType, planAmount: $planAmount, planCurrency: $planCurrency, planCurrencyCode: $planCurrencyCode, chat: $chat, planValidity: $planValidity, planInterest: $planInterest, planViewContact: $planViewContact, planVideocallMinute: $planVideocallMinute, planAudiocallMinute: $planAudiocallMinute, planDiscount: $planDiscount, status: $status, icon: $icon, planDescription: $planDescription, aiInterest: $aiInterest, currencyCode: $currencyCode, validityDays: $validityDays, interestsLimit: $interestsLimit, contactViewsLimit: $contactViewsLimit, videoMinutesLimit: $videoMinutesLimit, audioMinutesLimit: $audioMinutesLimit, viewProfileLimit: $viewProfileLimit, planViewProfile: $planViewProfile, canChat: $canChat, photoPrivacy: $photoPrivacy, contactPrivacy: $contactPrivacy, isPersonalized: $isPersonalized, inAppPurchaseAndroidId: $inAppPurchaseAndroidId, inAppPurchaseAndroidAmount: $inAppPurchaseAndroidAmount, inAppPurchaseIosId: $inAppPurchaseIosId, inAppPurchaseIosAmount: $inAppPurchaseIosAmount)';
}


}

/// @nodoc
abstract mixin class _$MembershipPlanCopyWith<$Res> implements $MembershipPlanCopyWith<$Res> {
  factory _$MembershipPlanCopyWith(_MembershipPlan value, $Res Function(_MembershipPlan) _then) = __$MembershipPlanCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'plan_name') String? planName,@JsonKey(name: 'in_app_product_id') dynamic inAppProductId,@JsonKey(name: 'in_app_price') int? inAppPrice,@JsonKey(name: 'plan_type') String? planType,@JsonKey(name: 'plan_amount') dynamic planAmount,@JsonKey(name: 'plan_currency') String? planCurrency,@JsonKey(name: 'plan_currency_code') String? planCurrencyCode, String? chat,@JsonKey(name: 'plan_validity') String? planValidity,@JsonKey(name: 'plan_interest') String? planInterest,@JsonKey(name: 'plan_view_contact') String? planViewContact,@JsonKey(name: 'plan_videocall_minute') String? planVideocallMinute,@JsonKey(name: 'plan_audiocall_minute') String? planAudiocallMinute,@JsonKey(name: 'plan_discount') dynamic planDiscount, String? status, String? icon,@JsonKey(name: 'plan_description') String? planDescription,@JsonKey(name: 'ai_interest') dynamic aiInterest,@JsonKey(name: 'currency_code') String? currencyCode,@JsonKey(name: 'validity_days') int? validityDays,@JsonKey(name: 'interests_limit') int? interestsLimit,@JsonKey(name: 'contact_views_limit') int? contactViewsLimit,@JsonKey(name: 'video_minutes_limit') int? videoMinutesLimit,@JsonKey(name: 'audio_minutes_limit') int? audioMinutesLimit,@JsonKey(name: 'view_profile_limit') dynamic viewProfileLimit,@JsonKey(name: 'plan_view_profile') dynamic planViewProfile,@JsonKey(name: 'can_chat') dynamic canChat,@JsonKey(name: 'photo_privacy') dynamic photoPrivacy,@JsonKey(name: 'contact_privacy') dynamic contactPrivacy,@JsonKey(name: 'is_personalized') dynamic isPersonalized,@JsonKey(name: 'in_app_purchase_android_id') String? inAppPurchaseAndroidId,@JsonKey(name: 'in_app_purchase_android_amount') String? inAppPurchaseAndroidAmount,@JsonKey(name: 'in_app_purchase_ios_id') String? inAppPurchaseIosId,@JsonKey(name: 'in_app_purchase_ios_amount') String? inAppPurchaseIosAmount
});




}
/// @nodoc
class __$MembershipPlanCopyWithImpl<$Res>
    implements _$MembershipPlanCopyWith<$Res> {
  __$MembershipPlanCopyWithImpl(this._self, this._then);

  final _MembershipPlan _self;
  final $Res Function(_MembershipPlan) _then;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? planName = freezed,Object? inAppProductId = freezed,Object? inAppPrice = freezed,Object? planType = freezed,Object? planAmount = freezed,Object? planCurrency = freezed,Object? planCurrencyCode = freezed,Object? chat = freezed,Object? planValidity = freezed,Object? planInterest = freezed,Object? planViewContact = freezed,Object? planVideocallMinute = freezed,Object? planAudiocallMinute = freezed,Object? planDiscount = freezed,Object? status = freezed,Object? icon = freezed,Object? planDescription = freezed,Object? aiInterest = freezed,Object? currencyCode = freezed,Object? validityDays = freezed,Object? interestsLimit = freezed,Object? contactViewsLimit = freezed,Object? videoMinutesLimit = freezed,Object? audioMinutesLimit = freezed,Object? viewProfileLimit = freezed,Object? planViewProfile = freezed,Object? canChat = freezed,Object? photoPrivacy = freezed,Object? contactPrivacy = freezed,Object? isPersonalized = freezed,Object? inAppPurchaseAndroidId = freezed,Object? inAppPurchaseAndroidAmount = freezed,Object? inAppPurchaseIosId = freezed,Object? inAppPurchaseIosAmount = freezed,}) {
  return _then(_MembershipPlan(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,inAppProductId: freezed == inAppProductId ? _self.inAppProductId : inAppProductId // ignore: cast_nullable_to_non_nullable
as dynamic,inAppPrice: freezed == inAppPrice ? _self.inAppPrice : inAppPrice // ignore: cast_nullable_to_non_nullable
as int?,planType: freezed == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
as String?,planAmount: freezed == planAmount ? _self.planAmount : planAmount // ignore: cast_nullable_to_non_nullable
as dynamic,planCurrency: freezed == planCurrency ? _self.planCurrency : planCurrency // ignore: cast_nullable_to_non_nullable
as String?,planCurrencyCode: freezed == planCurrencyCode ? _self.planCurrencyCode : planCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,chat: freezed == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as String?,planValidity: freezed == planValidity ? _self.planValidity : planValidity // ignore: cast_nullable_to_non_nullable
as String?,planInterest: freezed == planInterest ? _self.planInterest : planInterest // ignore: cast_nullable_to_non_nullable
as String?,planViewContact: freezed == planViewContact ? _self.planViewContact : planViewContact // ignore: cast_nullable_to_non_nullable
as String?,planVideocallMinute: freezed == planVideocallMinute ? _self.planVideocallMinute : planVideocallMinute // ignore: cast_nullable_to_non_nullable
as String?,planAudiocallMinute: freezed == planAudiocallMinute ? _self.planAudiocallMinute : planAudiocallMinute // ignore: cast_nullable_to_non_nullable
as String?,planDiscount: freezed == planDiscount ? _self.planDiscount : planDiscount // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,planDescription: freezed == planDescription ? _self.planDescription : planDescription // ignore: cast_nullable_to_non_nullable
as String?,aiInterest: freezed == aiInterest ? _self.aiInterest : aiInterest // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,validityDays: freezed == validityDays ? _self.validityDays : validityDays // ignore: cast_nullable_to_non_nullable
as int?,interestsLimit: freezed == interestsLimit ? _self.interestsLimit : interestsLimit // ignore: cast_nullable_to_non_nullable
as int?,contactViewsLimit: freezed == contactViewsLimit ? _self.contactViewsLimit : contactViewsLimit // ignore: cast_nullable_to_non_nullable
as int?,videoMinutesLimit: freezed == videoMinutesLimit ? _self.videoMinutesLimit : videoMinutesLimit // ignore: cast_nullable_to_non_nullable
as int?,audioMinutesLimit: freezed == audioMinutesLimit ? _self.audioMinutesLimit : audioMinutesLimit // ignore: cast_nullable_to_non_nullable
as int?,viewProfileLimit: freezed == viewProfileLimit ? _self.viewProfileLimit : viewProfileLimit // ignore: cast_nullable_to_non_nullable
as dynamic,planViewProfile: freezed == planViewProfile ? _self.planViewProfile : planViewProfile // ignore: cast_nullable_to_non_nullable
as dynamic,canChat: freezed == canChat ? _self.canChat : canChat // ignore: cast_nullable_to_non_nullable
as dynamic,photoPrivacy: freezed == photoPrivacy ? _self.photoPrivacy : photoPrivacy // ignore: cast_nullable_to_non_nullable
as dynamic,contactPrivacy: freezed == contactPrivacy ? _self.contactPrivacy : contactPrivacy // ignore: cast_nullable_to_non_nullable
as dynamic,isPersonalized: freezed == isPersonalized ? _self.isPersonalized : isPersonalized // ignore: cast_nullable_to_non_nullable
as dynamic,inAppPurchaseAndroidId: freezed == inAppPurchaseAndroidId ? _self.inAppPurchaseAndroidId : inAppPurchaseAndroidId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseAndroidAmount: freezed == inAppPurchaseAndroidAmount ? _self.inAppPurchaseAndroidAmount : inAppPurchaseAndroidAmount // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosId: freezed == inAppPurchaseIosId ? _self.inAppPurchaseIosId : inAppPurchaseIosId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosAmount: freezed == inAppPurchaseIosAmount ? _self.inAppPurchaseIosAmount : inAppPurchaseIosAmount // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OfflinePayment {

 int? get id;@JsonKey(name: 'account_holder_number') String? get accountHolderNumber;@JsonKey(name: 'account_number') String? get accountNumber;@JsonKey(name: 'bank_name') String? get bankName;@JsonKey(name: 'bank_branch') String? get bankBranch;@JsonKey(name: 'ifsc_code') String? get ifscCode;@JsonKey(name: 'qr_code') String? get qrCode;@JsonKey(name: 'payment_gateway_img') String? get paymentGatewayImg; String? get status;
/// Create a copy of OfflinePayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflinePaymentCopyWith<OfflinePayment> get copyWith => _$OfflinePaymentCopyWithImpl<OfflinePayment>(this as OfflinePayment, _$identity);

  /// Serializes this OfflinePayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OfflinePayment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflinePayment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.accountHolderNumber, _this.accountHolderNumber) || other.accountHolderNumber == _this.accountHolderNumber)&&(identical(other.accountNumber, _this.accountNumber) || other.accountNumber == _this.accountNumber)&&(identical(other.bankName, _this.bankName) || other.bankName == _this.bankName)&&(identical(other.bankBranch, _this.bankBranch) || other.bankBranch == _this.bankBranch)&&(identical(other.ifscCode, _this.ifscCode) || other.ifscCode == _this.ifscCode)&&(identical(other.qrCode, _this.qrCode) || other.qrCode == _this.qrCode)&&(identical(other.paymentGatewayImg, _this.paymentGatewayImg) || other.paymentGatewayImg == _this.paymentGatewayImg)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OfflinePayment;
  return Object.hash(runtimeType,_this.id,_this.accountHolderNumber,_this.accountNumber,_this.bankName,_this.bankBranch,_this.ifscCode,_this.qrCode,_this.paymentGatewayImg,_this.status);
}

@override
String toString() {
  final _this = this as OfflinePayment;
  return 'OfflinePayment(id: ${_this.id}, accountHolderNumber: ${_this.accountHolderNumber}, accountNumber: ${_this.accountNumber}, bankName: ${_this.bankName}, bankBranch: ${_this.bankBranch}, ifscCode: ${_this.ifscCode}, qrCode: ${_this.qrCode}, paymentGatewayImg: ${_this.paymentGatewayImg}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $OfflinePaymentCopyWith<$Res>  {
  factory $OfflinePaymentCopyWith(OfflinePayment value, $Res Function(OfflinePayment) _then) = _$OfflinePaymentCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'account_holder_number') String? accountHolderNumber,@JsonKey(name: 'account_number') String? accountNumber,@JsonKey(name: 'bank_name') String? bankName,@JsonKey(name: 'bank_branch') String? bankBranch,@JsonKey(name: 'ifsc_code') String? ifscCode,@JsonKey(name: 'qr_code') String? qrCode,@JsonKey(name: 'payment_gateway_img') String? paymentGatewayImg, String? status
});




}
/// @nodoc
class _$OfflinePaymentCopyWithImpl<$Res>
    implements $OfflinePaymentCopyWith<$Res> {
  _$OfflinePaymentCopyWithImpl(this._self, this._then);

  final OfflinePayment _self;
  final $Res Function(OfflinePayment) _then;

/// Create a copy of OfflinePayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? accountHolderNumber = freezed,Object? accountNumber = freezed,Object? bankName = freezed,Object? bankBranch = freezed,Object? ifscCode = freezed,Object? qrCode = freezed,Object? paymentGatewayImg = freezed,Object? status = freezed,}) {
  return _then(OfflinePayment(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,accountHolderNumber: freezed == accountHolderNumber ? _self.accountHolderNumber : accountHolderNumber // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,bankBranch: freezed == bankBranch ? _self.bankBranch : bankBranch // ignore: cast_nullable_to_non_nullable
as String?,ifscCode: freezed == ifscCode ? _self.ifscCode : ifscCode // ignore: cast_nullable_to_non_nullable
as String?,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String?,paymentGatewayImg: freezed == paymentGatewayImg ? _self.paymentGatewayImg : paymentGatewayImg // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OfflinePayment].
extension OfflinePaymentPatterns on OfflinePayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfflinePayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfflinePayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfflinePayment value)  $default,){
final _that = this;
switch (_that) {
case _OfflinePayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfflinePayment value)?  $default,){
final _that = this;
switch (_that) {
case _OfflinePayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'account_holder_number')  String? accountHolderNumber, @JsonKey(name: 'account_number')  String? accountNumber, @JsonKey(name: 'bank_name')  String? bankName, @JsonKey(name: 'bank_branch')  String? bankBranch, @JsonKey(name: 'ifsc_code')  String? ifscCode, @JsonKey(name: 'qr_code')  String? qrCode, @JsonKey(name: 'payment_gateway_img')  String? paymentGatewayImg,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfflinePayment() when $default != null:
return $default(_that.id,_that.accountHolderNumber,_that.accountNumber,_that.bankName,_that.bankBranch,_that.ifscCode,_that.qrCode,_that.paymentGatewayImg,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'account_holder_number')  String? accountHolderNumber, @JsonKey(name: 'account_number')  String? accountNumber, @JsonKey(name: 'bank_name')  String? bankName, @JsonKey(name: 'bank_branch')  String? bankBranch, @JsonKey(name: 'ifsc_code')  String? ifscCode, @JsonKey(name: 'qr_code')  String? qrCode, @JsonKey(name: 'payment_gateway_img')  String? paymentGatewayImg,  String? status)  $default,) {final _that = this;
switch (_that) {
case _OfflinePayment():
return $default(_that.id,_that.accountHolderNumber,_that.accountNumber,_that.bankName,_that.bankBranch,_that.ifscCode,_that.qrCode,_that.paymentGatewayImg,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'account_holder_number')  String? accountHolderNumber, @JsonKey(name: 'account_number')  String? accountNumber, @JsonKey(name: 'bank_name')  String? bankName, @JsonKey(name: 'bank_branch')  String? bankBranch, @JsonKey(name: 'ifsc_code')  String? ifscCode, @JsonKey(name: 'qr_code')  String? qrCode, @JsonKey(name: 'payment_gateway_img')  String? paymentGatewayImg,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _OfflinePayment() when $default != null:
return $default(_that.id,_that.accountHolderNumber,_that.accountNumber,_that.bankName,_that.bankBranch,_that.ifscCode,_that.qrCode,_that.paymentGatewayImg,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfflinePayment implements OfflinePayment {
  const _OfflinePayment({this.id, @JsonKey(name: 'account_holder_number') this.accountHolderNumber, @JsonKey(name: 'account_number') this.accountNumber, @JsonKey(name: 'bank_name') this.bankName, @JsonKey(name: 'bank_branch') this.bankBranch, @JsonKey(name: 'ifsc_code') this.ifscCode, @JsonKey(name: 'qr_code') this.qrCode, @JsonKey(name: 'payment_gateway_img') this.paymentGatewayImg, this.status});
  factory _OfflinePayment.fromJson(Map<String, dynamic> json) => _$OfflinePaymentFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'account_holder_number') final  String? accountHolderNumber;
@override@JsonKey(name: 'account_number') final  String? accountNumber;
@override@JsonKey(name: 'bank_name') final  String? bankName;
@override@JsonKey(name: 'bank_branch') final  String? bankBranch;
@override@JsonKey(name: 'ifsc_code') final  String? ifscCode;
@override@JsonKey(name: 'qr_code') final  String? qrCode;
@override@JsonKey(name: 'payment_gateway_img') final  String? paymentGatewayImg;
@override final  String? status;

/// Create a copy of OfflinePayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflinePaymentCopyWith<_OfflinePayment> get copyWith => __$OfflinePaymentCopyWithImpl<_OfflinePayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflinePaymentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflinePayment&&(identical(other.id, id) || other.id == id)&&(identical(other.accountHolderNumber, accountHolderNumber) || other.accountHolderNumber == accountHolderNumber)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.bankBranch, bankBranch) || other.bankBranch == bankBranch)&&(identical(other.ifscCode, ifscCode) || other.ifscCode == ifscCode)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.paymentGatewayImg, paymentGatewayImg) || other.paymentGatewayImg == paymentGatewayImg)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,accountHolderNumber,accountNumber,bankName,bankBranch,ifscCode,qrCode,paymentGatewayImg,status);
}

@override
String toString() {
    return 'OfflinePayment(id: $id, accountHolderNumber: $accountHolderNumber, accountNumber: $accountNumber, bankName: $bankName, bankBranch: $bankBranch, ifscCode: $ifscCode, qrCode: $qrCode, paymentGatewayImg: $paymentGatewayImg, status: $status)';
}


}

/// @nodoc
abstract mixin class _$OfflinePaymentCopyWith<$Res> implements $OfflinePaymentCopyWith<$Res> {
  factory _$OfflinePaymentCopyWith(_OfflinePayment value, $Res Function(_OfflinePayment) _then) = __$OfflinePaymentCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'account_holder_number') String? accountHolderNumber,@JsonKey(name: 'account_number') String? accountNumber,@JsonKey(name: 'bank_name') String? bankName,@JsonKey(name: 'bank_branch') String? bankBranch,@JsonKey(name: 'ifsc_code') String? ifscCode,@JsonKey(name: 'qr_code') String? qrCode,@JsonKey(name: 'payment_gateway_img') String? paymentGatewayImg, String? status
});




}
/// @nodoc
class __$OfflinePaymentCopyWithImpl<$Res>
    implements _$OfflinePaymentCopyWith<$Res> {
  __$OfflinePaymentCopyWithImpl(this._self, this._then);

  final _OfflinePayment _self;
  final $Res Function(_OfflinePayment) _then;

/// Create a copy of OfflinePayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? accountHolderNumber = freezed,Object? accountNumber = freezed,Object? bankName = freezed,Object? bankBranch = freezed,Object? ifscCode = freezed,Object? qrCode = freezed,Object? paymentGatewayImg = freezed,Object? status = freezed,}) {
  return _then(_OfflinePayment(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,accountHolderNumber: freezed == accountHolderNumber ? _self.accountHolderNumber : accountHolderNumber // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,bankBranch: freezed == bankBranch ? _self.bankBranch : bankBranch // ignore: cast_nullable_to_non_nullable
as String?,ifscCode: freezed == ifscCode ? _self.ifscCode : ifscCode // ignore: cast_nullable_to_non_nullable
as String?,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String?,paymentGatewayImg: freezed == paymentGatewayImg ? _self.paymentGatewayImg : paymentGatewayImg // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaymentMethods {

@JsonKey(name: 'in_app_payment') String? get inAppPayment;@JsonKey(name: 'payment_name') String? get paymentName;@JsonKey(name: 'client_id') String? get clientId;@JsonKey(name: 'client_secret') String? get clientSecret;@JsonKey(name: 'payment_mode') String? get paymentMode; String? get paypal;
/// Create a copy of PaymentMethods
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodsCopyWith<PaymentMethods> get copyWith => _$PaymentMethodsCopyWithImpl<PaymentMethods>(this as PaymentMethods, _$identity);

  /// Serializes this PaymentMethods to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaymentMethods;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethods&&(identical(other.inAppPayment, _this.inAppPayment) || other.inAppPayment == _this.inAppPayment)&&(identical(other.paymentName, _this.paymentName) || other.paymentName == _this.paymentName)&&(identical(other.clientId, _this.clientId) || other.clientId == _this.clientId)&&(identical(other.clientSecret, _this.clientSecret) || other.clientSecret == _this.clientSecret)&&(identical(other.paymentMode, _this.paymentMode) || other.paymentMode == _this.paymentMode)&&(identical(other.paypal, _this.paypal) || other.paypal == _this.paypal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaymentMethods;
  return Object.hash(runtimeType,_this.inAppPayment,_this.paymentName,_this.clientId,_this.clientSecret,_this.paymentMode,_this.paypal);
}

@override
String toString() {
  final _this = this as PaymentMethods;
  return 'PaymentMethods(inAppPayment: ${_this.inAppPayment}, paymentName: ${_this.paymentName}, clientId: ${_this.clientId}, clientSecret: ${_this.clientSecret}, paymentMode: ${_this.paymentMode}, paypal: ${_this.paypal})';
}


}

/// @nodoc
abstract mixin class $PaymentMethodsCopyWith<$Res>  {
  factory $PaymentMethodsCopyWith(PaymentMethods value, $Res Function(PaymentMethods) _then) = _$PaymentMethodsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'in_app_payment') String? inAppPayment,@JsonKey(name: 'payment_name') String? paymentName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_secret') String? clientSecret,@JsonKey(name: 'payment_mode') String? paymentMode, String? paypal
});




}
/// @nodoc
class _$PaymentMethodsCopyWithImpl<$Res>
    implements $PaymentMethodsCopyWith<$Res> {
  _$PaymentMethodsCopyWithImpl(this._self, this._then);

  final PaymentMethods _self;
  final $Res Function(PaymentMethods) _then;

/// Create a copy of PaymentMethods
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inAppPayment = freezed,Object? paymentName = freezed,Object? clientId = freezed,Object? clientSecret = freezed,Object? paymentMode = freezed,Object? paypal = freezed,}) {
  return _then(PaymentMethods(
inAppPayment: freezed == inAppPayment ? _self.inAppPayment : inAppPayment // ignore: cast_nullable_to_non_nullable
as String?,paymentName: freezed == paymentName ? _self.paymentName : paymentName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,paymentMode: freezed == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String?,paypal: freezed == paypal ? _self.paypal : paypal // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethods].
extension PaymentMethodsPatterns on PaymentMethods {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethods value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethods() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethods value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethods():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethods value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethods() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'in_app_payment')  String? inAppPayment, @JsonKey(name: 'payment_name')  String? paymentName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_secret')  String? clientSecret, @JsonKey(name: 'payment_mode')  String? paymentMode,  String? paypal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethods() when $default != null:
return $default(_that.inAppPayment,_that.paymentName,_that.clientId,_that.clientSecret,_that.paymentMode,_that.paypal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'in_app_payment')  String? inAppPayment, @JsonKey(name: 'payment_name')  String? paymentName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_secret')  String? clientSecret, @JsonKey(name: 'payment_mode')  String? paymentMode,  String? paypal)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethods():
return $default(_that.inAppPayment,_that.paymentName,_that.clientId,_that.clientSecret,_that.paymentMode,_that.paypal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'in_app_payment')  String? inAppPayment, @JsonKey(name: 'payment_name')  String? paymentName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_secret')  String? clientSecret, @JsonKey(name: 'payment_mode')  String? paymentMode,  String? paypal)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethods() when $default != null:
return $default(_that.inAppPayment,_that.paymentName,_that.clientId,_that.clientSecret,_that.paymentMode,_that.paypal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethods implements PaymentMethods {
  const _PaymentMethods({@JsonKey(name: 'in_app_payment') this.inAppPayment, @JsonKey(name: 'payment_name') this.paymentName, @JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'client_secret') this.clientSecret, @JsonKey(name: 'payment_mode') this.paymentMode, this.paypal});
  factory _PaymentMethods.fromJson(Map<String, dynamic> json) => _$PaymentMethodsFromJson(json);

@override@JsonKey(name: 'in_app_payment') final  String? inAppPayment;
@override@JsonKey(name: 'payment_name') final  String? paymentName;
@override@JsonKey(name: 'client_id') final  String? clientId;
@override@JsonKey(name: 'client_secret') final  String? clientSecret;
@override@JsonKey(name: 'payment_mode') final  String? paymentMode;
@override final  String? paypal;

/// Create a copy of PaymentMethods
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodsCopyWith<_PaymentMethods> get copyWith => __$PaymentMethodsCopyWithImpl<_PaymentMethods>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethods&&(identical(other.inAppPayment, inAppPayment) || other.inAppPayment == inAppPayment)&&(identical(other.paymentName, paymentName) || other.paymentName == paymentName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.paypal, paypal) || other.paypal == paypal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,inAppPayment,paymentName,clientId,clientSecret,paymentMode,paypal);
}

@override
String toString() {
    return 'PaymentMethods(inAppPayment: $inAppPayment, paymentName: $paymentName, clientId: $clientId, clientSecret: $clientSecret, paymentMode: $paymentMode, paypal: $paypal)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodsCopyWith<$Res> implements $PaymentMethodsCopyWith<$Res> {
  factory _$PaymentMethodsCopyWith(_PaymentMethods value, $Res Function(_PaymentMethods) _then) = __$PaymentMethodsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'in_app_payment') String? inAppPayment,@JsonKey(name: 'payment_name') String? paymentName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_secret') String? clientSecret,@JsonKey(name: 'payment_mode') String? paymentMode, String? paypal
});




}
/// @nodoc
class __$PaymentMethodsCopyWithImpl<$Res>
    implements _$PaymentMethodsCopyWith<$Res> {
  __$PaymentMethodsCopyWithImpl(this._self, this._then);

  final _PaymentMethods _self;
  final $Res Function(_PaymentMethods) _then;

/// Create a copy of PaymentMethods
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inAppPayment = freezed,Object? paymentName = freezed,Object? clientId = freezed,Object? clientSecret = freezed,Object? paymentMode = freezed,Object? paypal = freezed,}) {
  return _then(_PaymentMethods(
inAppPayment: freezed == inAppPayment ? _self.inAppPayment : inAppPayment // ignore: cast_nullable_to_non_nullable
as String?,paymentName: freezed == paymentName ? _self.paymentName : paymentName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,paymentMode: freezed == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String?,paypal: freezed == paypal ? _self.paypal : paypal // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CouponData {

 int? get id; String? get status;@JsonKey(name: 'plan_id') int? get planId;@JsonKey(name: 'coupan_code') String? get coupanCode;@JsonKey(name: 'discount_amount') int? get discountAmount;@JsonKey(name: 'active_from') String? get activeFrom;@JsonKey(name: 'expired_on') String? get expiredOn;
/// Create a copy of CouponData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponDataCopyWith<CouponData> get copyWith => _$CouponDataCopyWithImpl<CouponData>(this as CouponData, _$identity);

  /// Serializes this CouponData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CouponData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponData&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.coupanCode, _this.coupanCode) || other.coupanCode == _this.coupanCode)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.activeFrom, _this.activeFrom) || other.activeFrom == _this.activeFrom)&&(identical(other.expiredOn, _this.expiredOn) || other.expiredOn == _this.expiredOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CouponData;
  return Object.hash(runtimeType,_this.id,_this.status,_this.planId,_this.coupanCode,_this.discountAmount,_this.activeFrom,_this.expiredOn);
}

@override
String toString() {
  final _this = this as CouponData;
  return 'CouponData(id: ${_this.id}, status: ${_this.status}, planId: ${_this.planId}, coupanCode: ${_this.coupanCode}, discountAmount: ${_this.discountAmount}, activeFrom: ${_this.activeFrom}, expiredOn: ${_this.expiredOn})';
}


}

/// @nodoc
abstract mixin class $CouponDataCopyWith<$Res>  {
  factory $CouponDataCopyWith(CouponData value, $Res Function(CouponData) _then) = _$CouponDataCopyWithImpl;
@useResult
$Res call({
 int? id, String? status,@JsonKey(name: 'plan_id') int? planId,@JsonKey(name: 'coupan_code') String? coupanCode,@JsonKey(name: 'discount_amount') int? discountAmount,@JsonKey(name: 'active_from') String? activeFrom,@JsonKey(name: 'expired_on') String? expiredOn
});




}
/// @nodoc
class _$CouponDataCopyWithImpl<$Res>
    implements $CouponDataCopyWith<$Res> {
  _$CouponDataCopyWithImpl(this._self, this._then);

  final CouponData _self;
  final $Res Function(CouponData) _then;

/// Create a copy of CouponData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? status = freezed,Object? planId = freezed,Object? coupanCode = freezed,Object? discountAmount = freezed,Object? activeFrom = freezed,Object? expiredOn = freezed,}) {
  return _then(CouponData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,coupanCode: freezed == coupanCode ? _self.coupanCode : coupanCode // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,activeFrom: freezed == activeFrom ? _self.activeFrom : activeFrom // ignore: cast_nullable_to_non_nullable
as String?,expiredOn: freezed == expiredOn ? _self.expiredOn : expiredOn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CouponData].
extension CouponDataPatterns on CouponData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponData value)  $default,){
final _that = this;
switch (_that) {
case _CouponData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponData value)?  $default,){
final _that = this;
switch (_that) {
case _CouponData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? status, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'coupan_code')  String? coupanCode, @JsonKey(name: 'discount_amount')  int? discountAmount, @JsonKey(name: 'active_from')  String? activeFrom, @JsonKey(name: 'expired_on')  String? expiredOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponData() when $default != null:
return $default(_that.id,_that.status,_that.planId,_that.coupanCode,_that.discountAmount,_that.activeFrom,_that.expiredOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? status, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'coupan_code')  String? coupanCode, @JsonKey(name: 'discount_amount')  int? discountAmount, @JsonKey(name: 'active_from')  String? activeFrom, @JsonKey(name: 'expired_on')  String? expiredOn)  $default,) {final _that = this;
switch (_that) {
case _CouponData():
return $default(_that.id,_that.status,_that.planId,_that.coupanCode,_that.discountAmount,_that.activeFrom,_that.expiredOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? status, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'coupan_code')  String? coupanCode, @JsonKey(name: 'discount_amount')  int? discountAmount, @JsonKey(name: 'active_from')  String? activeFrom, @JsonKey(name: 'expired_on')  String? expiredOn)?  $default,) {final _that = this;
switch (_that) {
case _CouponData() when $default != null:
return $default(_that.id,_that.status,_that.planId,_that.coupanCode,_that.discountAmount,_that.activeFrom,_that.expiredOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CouponData implements CouponData {
  const _CouponData({this.id, this.status, @JsonKey(name: 'plan_id') this.planId, @JsonKey(name: 'coupan_code') this.coupanCode, @JsonKey(name: 'discount_amount') this.discountAmount, @JsonKey(name: 'active_from') this.activeFrom, @JsonKey(name: 'expired_on') this.expiredOn});
  factory _CouponData.fromJson(Map<String, dynamic> json) => _$CouponDataFromJson(json);

@override final  int? id;
@override final  String? status;
@override@JsonKey(name: 'plan_id') final  int? planId;
@override@JsonKey(name: 'coupan_code') final  String? coupanCode;
@override@JsonKey(name: 'discount_amount') final  int? discountAmount;
@override@JsonKey(name: 'active_from') final  String? activeFrom;
@override@JsonKey(name: 'expired_on') final  String? expiredOn;

/// Create a copy of CouponData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponDataCopyWith<_CouponData> get copyWith => __$CouponDataCopyWithImpl<_CouponData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponData&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.coupanCode, coupanCode) || other.coupanCode == coupanCode)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.activeFrom, activeFrom) || other.activeFrom == activeFrom)&&(identical(other.expiredOn, expiredOn) || other.expiredOn == expiredOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,planId,coupanCode,discountAmount,activeFrom,expiredOn);
}

@override
String toString() {
    return 'CouponData(id: $id, status: $status, planId: $planId, coupanCode: $coupanCode, discountAmount: $discountAmount, activeFrom: $activeFrom, expiredOn: $expiredOn)';
}


}

/// @nodoc
abstract mixin class _$CouponDataCopyWith<$Res> implements $CouponDataCopyWith<$Res> {
  factory _$CouponDataCopyWith(_CouponData value, $Res Function(_CouponData) _then) = __$CouponDataCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? status,@JsonKey(name: 'plan_id') int? planId,@JsonKey(name: 'coupan_code') String? coupanCode,@JsonKey(name: 'discount_amount') int? discountAmount,@JsonKey(name: 'active_from') String? activeFrom,@JsonKey(name: 'expired_on') String? expiredOn
});




}
/// @nodoc
class __$CouponDataCopyWithImpl<$Res>
    implements _$CouponDataCopyWith<$Res> {
  __$CouponDataCopyWithImpl(this._self, this._then);

  final _CouponData _self;
  final $Res Function(_CouponData) _then;

/// Create a copy of CouponData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? status = freezed,Object? planId = freezed,Object? coupanCode = freezed,Object? discountAmount = freezed,Object? activeFrom = freezed,Object? expiredOn = freezed,}) {
  return _then(_CouponData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,coupanCode: freezed == coupanCode ? _self.coupanCode : coupanCode // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,activeFrom: freezed == activeFrom ? _self.activeFrom : activeFrom // ignore: cast_nullable_to_non_nullable
as String?,expiredOn: freezed == expiredOn ? _self.expiredOn : expiredOn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AddOnPlan {

 int? get id;@JsonKey(name: 'package_title') String? get packageTitle;@JsonKey(name: 'package_category') String? get packageCategory;@JsonKey(name: 'package_count') dynamic get packageCount;@JsonKey(name: 'package_amount') dynamic get packageAmount;@JsonKey(name: 'currency_code') String? get currencyCode;@JsonKey(name: 'package_currency') String? get packageCurrency;@JsonKey(name: 'plan_currency') String? get planCurrency;@JsonKey(name: 'in_app_purchase_android_id') String? get inAppPurchaseAndroidId;@JsonKey(name: 'in_app_purchase_android_amount') String? get inAppPurchaseAndroidAmount;@JsonKey(name: 'in_app_purchase_ios_id') String? get inAppPurchaseIosId;@JsonKey(name: 'in_app_purchase_ios_amount') String? get inAppPurchaseIosAmount;@JsonKey(name: 'in_app_product_id') dynamic get inAppProductId; String? get description; String? get status;
/// Create a copy of AddOnPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddOnPlanCopyWith<AddOnPlan> get copyWith => _$AddOnPlanCopyWithImpl<AddOnPlan>(this as AddOnPlan, _$identity);

  /// Serializes this AddOnPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddOnPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddOnPlan&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.packageTitle, _this.packageTitle) || other.packageTitle == _this.packageTitle)&&(identical(other.packageCategory, _this.packageCategory) || other.packageCategory == _this.packageCategory)&&const DeepCollectionEquality().equals(other.packageCount, _this.packageCount)&&const DeepCollectionEquality().equals(other.packageAmount, _this.packageAmount)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.packageCurrency, _this.packageCurrency) || other.packageCurrency == _this.packageCurrency)&&(identical(other.planCurrency, _this.planCurrency) || other.planCurrency == _this.planCurrency)&&(identical(other.inAppPurchaseAndroidId, _this.inAppPurchaseAndroidId) || other.inAppPurchaseAndroidId == _this.inAppPurchaseAndroidId)&&(identical(other.inAppPurchaseAndroidAmount, _this.inAppPurchaseAndroidAmount) || other.inAppPurchaseAndroidAmount == _this.inAppPurchaseAndroidAmount)&&(identical(other.inAppPurchaseIosId, _this.inAppPurchaseIosId) || other.inAppPurchaseIosId == _this.inAppPurchaseIosId)&&(identical(other.inAppPurchaseIosAmount, _this.inAppPurchaseIosAmount) || other.inAppPurchaseIosAmount == _this.inAppPurchaseIosAmount)&&const DeepCollectionEquality().equals(other.inAppProductId, _this.inAppProductId)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddOnPlan;
  return Object.hash(runtimeType,_this.id,_this.packageTitle,_this.packageCategory,const DeepCollectionEquality().hash(_this.packageCount),const DeepCollectionEquality().hash(_this.packageAmount),_this.currencyCode,_this.packageCurrency,_this.planCurrency,_this.inAppPurchaseAndroidId,_this.inAppPurchaseAndroidAmount,_this.inAppPurchaseIosId,_this.inAppPurchaseIosAmount,const DeepCollectionEquality().hash(_this.inAppProductId),_this.description,_this.status);
}

@override
String toString() {
  final _this = this as AddOnPlan;
  return 'AddOnPlan(id: ${_this.id}, packageTitle: ${_this.packageTitle}, packageCategory: ${_this.packageCategory}, packageCount: ${_this.packageCount}, packageAmount: ${_this.packageAmount}, currencyCode: ${_this.currencyCode}, packageCurrency: ${_this.packageCurrency}, planCurrency: ${_this.planCurrency}, inAppPurchaseAndroidId: ${_this.inAppPurchaseAndroidId}, inAppPurchaseAndroidAmount: ${_this.inAppPurchaseAndroidAmount}, inAppPurchaseIosId: ${_this.inAppPurchaseIosId}, inAppPurchaseIosAmount: ${_this.inAppPurchaseIosAmount}, inAppProductId: ${_this.inAppProductId}, description: ${_this.description}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $AddOnPlanCopyWith<$Res>  {
  factory $AddOnPlanCopyWith(AddOnPlan value, $Res Function(AddOnPlan) _then) = _$AddOnPlanCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'package_title') String? packageTitle,@JsonKey(name: 'package_category') String? packageCategory,@JsonKey(name: 'package_count') dynamic packageCount,@JsonKey(name: 'package_amount') dynamic packageAmount,@JsonKey(name: 'currency_code') String? currencyCode,@JsonKey(name: 'package_currency') String? packageCurrency,@JsonKey(name: 'plan_currency') String? planCurrency,@JsonKey(name: 'in_app_purchase_android_id') String? inAppPurchaseAndroidId,@JsonKey(name: 'in_app_purchase_android_amount') String? inAppPurchaseAndroidAmount,@JsonKey(name: 'in_app_purchase_ios_id') String? inAppPurchaseIosId,@JsonKey(name: 'in_app_purchase_ios_amount') String? inAppPurchaseIosAmount,@JsonKey(name: 'in_app_product_id') dynamic inAppProductId, String? description, String? status
});




}
/// @nodoc
class _$AddOnPlanCopyWithImpl<$Res>
    implements $AddOnPlanCopyWith<$Res> {
  _$AddOnPlanCopyWithImpl(this._self, this._then);

  final AddOnPlan _self;
  final $Res Function(AddOnPlan) _then;

/// Create a copy of AddOnPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? packageTitle = freezed,Object? packageCategory = freezed,Object? packageCount = freezed,Object? packageAmount = freezed,Object? currencyCode = freezed,Object? packageCurrency = freezed,Object? planCurrency = freezed,Object? inAppPurchaseAndroidId = freezed,Object? inAppPurchaseAndroidAmount = freezed,Object? inAppPurchaseIosId = freezed,Object? inAppPurchaseIosAmount = freezed,Object? inAppProductId = freezed,Object? description = freezed,Object? status = freezed,}) {
  return _then(AddOnPlan(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,packageTitle: freezed == packageTitle ? _self.packageTitle : packageTitle // ignore: cast_nullable_to_non_nullable
as String?,packageCategory: freezed == packageCategory ? _self.packageCategory : packageCategory // ignore: cast_nullable_to_non_nullable
as String?,packageCount: freezed == packageCount ? _self.packageCount : packageCount // ignore: cast_nullable_to_non_nullable
as dynamic,packageAmount: freezed == packageAmount ? _self.packageAmount : packageAmount // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,packageCurrency: freezed == packageCurrency ? _self.packageCurrency : packageCurrency // ignore: cast_nullable_to_non_nullable
as String?,planCurrency: freezed == planCurrency ? _self.planCurrency : planCurrency // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseAndroidId: freezed == inAppPurchaseAndroidId ? _self.inAppPurchaseAndroidId : inAppPurchaseAndroidId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseAndroidAmount: freezed == inAppPurchaseAndroidAmount ? _self.inAppPurchaseAndroidAmount : inAppPurchaseAndroidAmount // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosId: freezed == inAppPurchaseIosId ? _self.inAppPurchaseIosId : inAppPurchaseIosId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosAmount: freezed == inAppPurchaseIosAmount ? _self.inAppPurchaseIosAmount : inAppPurchaseIosAmount // ignore: cast_nullable_to_non_nullable
as String?,inAppProductId: freezed == inAppProductId ? _self.inAppProductId : inAppProductId // ignore: cast_nullable_to_non_nullable
as dynamic,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddOnPlan].
extension AddOnPlanPatterns on AddOnPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddOnPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddOnPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddOnPlan value)  $default,){
final _that = this;
switch (_that) {
case _AddOnPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddOnPlan value)?  $default,){
final _that = this;
switch (_that) {
case _AddOnPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'package_title')  String? packageTitle, @JsonKey(name: 'package_category')  String? packageCategory, @JsonKey(name: 'package_count')  dynamic packageCount, @JsonKey(name: 'package_amount')  dynamic packageAmount, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'package_currency')  String? packageCurrency, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'in_app_purchase_android_id')  String? inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount')  String? inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id')  String? inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount')  String? inAppPurchaseIosAmount, @JsonKey(name: 'in_app_product_id')  dynamic inAppProductId,  String? description,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddOnPlan() when $default != null:
return $default(_that.id,_that.packageTitle,_that.packageCategory,_that.packageCount,_that.packageAmount,_that.currencyCode,_that.packageCurrency,_that.planCurrency,_that.inAppPurchaseAndroidId,_that.inAppPurchaseAndroidAmount,_that.inAppPurchaseIosId,_that.inAppPurchaseIosAmount,_that.inAppProductId,_that.description,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'package_title')  String? packageTitle, @JsonKey(name: 'package_category')  String? packageCategory, @JsonKey(name: 'package_count')  dynamic packageCount, @JsonKey(name: 'package_amount')  dynamic packageAmount, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'package_currency')  String? packageCurrency, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'in_app_purchase_android_id')  String? inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount')  String? inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id')  String? inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount')  String? inAppPurchaseIosAmount, @JsonKey(name: 'in_app_product_id')  dynamic inAppProductId,  String? description,  String? status)  $default,) {final _that = this;
switch (_that) {
case _AddOnPlan():
return $default(_that.id,_that.packageTitle,_that.packageCategory,_that.packageCount,_that.packageAmount,_that.currencyCode,_that.packageCurrency,_that.planCurrency,_that.inAppPurchaseAndroidId,_that.inAppPurchaseAndroidAmount,_that.inAppPurchaseIosId,_that.inAppPurchaseIosAmount,_that.inAppProductId,_that.description,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'package_title')  String? packageTitle, @JsonKey(name: 'package_category')  String? packageCategory, @JsonKey(name: 'package_count')  dynamic packageCount, @JsonKey(name: 'package_amount')  dynamic packageAmount, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'package_currency')  String? packageCurrency, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'in_app_purchase_android_id')  String? inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount')  String? inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id')  String? inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount')  String? inAppPurchaseIosAmount, @JsonKey(name: 'in_app_product_id')  dynamic inAppProductId,  String? description,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _AddOnPlan() when $default != null:
return $default(_that.id,_that.packageTitle,_that.packageCategory,_that.packageCount,_that.packageAmount,_that.currencyCode,_that.packageCurrency,_that.planCurrency,_that.inAppPurchaseAndroidId,_that.inAppPurchaseAndroidAmount,_that.inAppPurchaseIosId,_that.inAppPurchaseIosAmount,_that.inAppProductId,_that.description,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddOnPlan implements AddOnPlan {
  const _AddOnPlan({this.id, @JsonKey(name: 'package_title') this.packageTitle, @JsonKey(name: 'package_category') this.packageCategory, @JsonKey(name: 'package_count') this.packageCount, @JsonKey(name: 'package_amount') this.packageAmount, @JsonKey(name: 'currency_code') this.currencyCode, @JsonKey(name: 'package_currency') this.packageCurrency, @JsonKey(name: 'plan_currency') this.planCurrency, @JsonKey(name: 'in_app_purchase_android_id') this.inAppPurchaseAndroidId, @JsonKey(name: 'in_app_purchase_android_amount') this.inAppPurchaseAndroidAmount, @JsonKey(name: 'in_app_purchase_ios_id') this.inAppPurchaseIosId, @JsonKey(name: 'in_app_purchase_ios_amount') this.inAppPurchaseIosAmount, @JsonKey(name: 'in_app_product_id') this.inAppProductId, this.description, this.status});
  factory _AddOnPlan.fromJson(Map<String, dynamic> json) => _$AddOnPlanFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'package_title') final  String? packageTitle;
@override@JsonKey(name: 'package_category') final  String? packageCategory;
@override@JsonKey(name: 'package_count') final  dynamic packageCount;
@override@JsonKey(name: 'package_amount') final  dynamic packageAmount;
@override@JsonKey(name: 'currency_code') final  String? currencyCode;
@override@JsonKey(name: 'package_currency') final  String? packageCurrency;
@override@JsonKey(name: 'plan_currency') final  String? planCurrency;
@override@JsonKey(name: 'in_app_purchase_android_id') final  String? inAppPurchaseAndroidId;
@override@JsonKey(name: 'in_app_purchase_android_amount') final  String? inAppPurchaseAndroidAmount;
@override@JsonKey(name: 'in_app_purchase_ios_id') final  String? inAppPurchaseIosId;
@override@JsonKey(name: 'in_app_purchase_ios_amount') final  String? inAppPurchaseIosAmount;
@override@JsonKey(name: 'in_app_product_id') final  dynamic inAppProductId;
@override final  String? description;
@override final  String? status;

/// Create a copy of AddOnPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddOnPlanCopyWith<_AddOnPlan> get copyWith => __$AddOnPlanCopyWithImpl<_AddOnPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddOnPlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddOnPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.packageTitle, packageTitle) || other.packageTitle == packageTitle)&&(identical(other.packageCategory, packageCategory) || other.packageCategory == packageCategory)&&const DeepCollectionEquality().equals(other.packageCount, packageCount)&&const DeepCollectionEquality().equals(other.packageAmount, packageAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.packageCurrency, packageCurrency) || other.packageCurrency == packageCurrency)&&(identical(other.planCurrency, planCurrency) || other.planCurrency == planCurrency)&&(identical(other.inAppPurchaseAndroidId, inAppPurchaseAndroidId) || other.inAppPurchaseAndroidId == inAppPurchaseAndroidId)&&(identical(other.inAppPurchaseAndroidAmount, inAppPurchaseAndroidAmount) || other.inAppPurchaseAndroidAmount == inAppPurchaseAndroidAmount)&&(identical(other.inAppPurchaseIosId, inAppPurchaseIosId) || other.inAppPurchaseIosId == inAppPurchaseIosId)&&(identical(other.inAppPurchaseIosAmount, inAppPurchaseIosAmount) || other.inAppPurchaseIosAmount == inAppPurchaseIosAmount)&&const DeepCollectionEquality().equals(other.inAppProductId, inAppProductId)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,packageTitle,packageCategory,const DeepCollectionEquality().hash(packageCount),const DeepCollectionEquality().hash(packageAmount),currencyCode,packageCurrency,planCurrency,inAppPurchaseAndroidId,inAppPurchaseAndroidAmount,inAppPurchaseIosId,inAppPurchaseIosAmount,const DeepCollectionEquality().hash(inAppProductId),description,status);
}

@override
String toString() {
    return 'AddOnPlan(id: $id, packageTitle: $packageTitle, packageCategory: $packageCategory, packageCount: $packageCount, packageAmount: $packageAmount, currencyCode: $currencyCode, packageCurrency: $packageCurrency, planCurrency: $planCurrency, inAppPurchaseAndroidId: $inAppPurchaseAndroidId, inAppPurchaseAndroidAmount: $inAppPurchaseAndroidAmount, inAppPurchaseIosId: $inAppPurchaseIosId, inAppPurchaseIosAmount: $inAppPurchaseIosAmount, inAppProductId: $inAppProductId, description: $description, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AddOnPlanCopyWith<$Res> implements $AddOnPlanCopyWith<$Res> {
  factory _$AddOnPlanCopyWith(_AddOnPlan value, $Res Function(_AddOnPlan) _then) = __$AddOnPlanCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'package_title') String? packageTitle,@JsonKey(name: 'package_category') String? packageCategory,@JsonKey(name: 'package_count') dynamic packageCount,@JsonKey(name: 'package_amount') dynamic packageAmount,@JsonKey(name: 'currency_code') String? currencyCode,@JsonKey(name: 'package_currency') String? packageCurrency,@JsonKey(name: 'plan_currency') String? planCurrency,@JsonKey(name: 'in_app_purchase_android_id') String? inAppPurchaseAndroidId,@JsonKey(name: 'in_app_purchase_android_amount') String? inAppPurchaseAndroidAmount,@JsonKey(name: 'in_app_purchase_ios_id') String? inAppPurchaseIosId,@JsonKey(name: 'in_app_purchase_ios_amount') String? inAppPurchaseIosAmount,@JsonKey(name: 'in_app_product_id') dynamic inAppProductId, String? description, String? status
});




}
/// @nodoc
class __$AddOnPlanCopyWithImpl<$Res>
    implements _$AddOnPlanCopyWith<$Res> {
  __$AddOnPlanCopyWithImpl(this._self, this._then);

  final _AddOnPlan _self;
  final $Res Function(_AddOnPlan) _then;

/// Create a copy of AddOnPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? packageTitle = freezed,Object? packageCategory = freezed,Object? packageCount = freezed,Object? packageAmount = freezed,Object? currencyCode = freezed,Object? packageCurrency = freezed,Object? planCurrency = freezed,Object? inAppPurchaseAndroidId = freezed,Object? inAppPurchaseAndroidAmount = freezed,Object? inAppPurchaseIosId = freezed,Object? inAppPurchaseIosAmount = freezed,Object? inAppProductId = freezed,Object? description = freezed,Object? status = freezed,}) {
  return _then(_AddOnPlan(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,packageTitle: freezed == packageTitle ? _self.packageTitle : packageTitle // ignore: cast_nullable_to_non_nullable
as String?,packageCategory: freezed == packageCategory ? _self.packageCategory : packageCategory // ignore: cast_nullable_to_non_nullable
as String?,packageCount: freezed == packageCount ? _self.packageCount : packageCount // ignore: cast_nullable_to_non_nullable
as dynamic,packageAmount: freezed == packageAmount ? _self.packageAmount : packageAmount // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,packageCurrency: freezed == packageCurrency ? _self.packageCurrency : packageCurrency // ignore: cast_nullable_to_non_nullable
as String?,planCurrency: freezed == planCurrency ? _self.planCurrency : planCurrency // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseAndroidId: freezed == inAppPurchaseAndroidId ? _self.inAppPurchaseAndroidId : inAppPurchaseAndroidId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseAndroidAmount: freezed == inAppPurchaseAndroidAmount ? _self.inAppPurchaseAndroidAmount : inAppPurchaseAndroidAmount // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosId: freezed == inAppPurchaseIosId ? _self.inAppPurchaseIosId : inAppPurchaseIosId // ignore: cast_nullable_to_non_nullable
as String?,inAppPurchaseIosAmount: freezed == inAppPurchaseIosAmount ? _self.inAppPurchaseIosAmount : inAppPurchaseIosAmount // ignore: cast_nullable_to_non_nullable
as String?,inAppProductId: freezed == inAppProductId ? _self.inAppProductId : inAppProductId // ignore: cast_nullable_to_non_nullable
as dynamic,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CurrentPlanResponseModel {

 int? get code; String? get status; String? get message; CurrentPlanData? get data;
/// Create a copy of CurrentPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentPlanResponseModelCopyWith<CurrentPlanResponseModel> get copyWith => _$CurrentPlanResponseModelCopyWithImpl<CurrentPlanResponseModel>(this as CurrentPlanResponseModel, _$identity);

  /// Serializes this CurrentPlanResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CurrentPlanResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentPlanResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CurrentPlanResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as CurrentPlanResponseModel;
  return 'CurrentPlanResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $CurrentPlanResponseModelCopyWith<$Res>  {
  factory $CurrentPlanResponseModelCopyWith(CurrentPlanResponseModel value, $Res Function(CurrentPlanResponseModel) _then) = _$CurrentPlanResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, CurrentPlanData? data
});


$CurrentPlanDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CurrentPlanResponseModelCopyWithImpl<$Res>
    implements $CurrentPlanResponseModelCopyWith<$Res> {
  _$CurrentPlanResponseModelCopyWithImpl(this._self, this._then);

  final CurrentPlanResponseModel _self;
  final $Res Function(CurrentPlanResponseModel) _then;

/// Create a copy of CurrentPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(CurrentPlanResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CurrentPlanData?,
  ));
}
/// Create a copy of CurrentPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CurrentPlanDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CurrentPlanResponseModel].
extension CurrentPlanResponseModelPatterns on CurrentPlanResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentPlanResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentPlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentPlanResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CurrentPlanResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentPlanResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentPlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CurrentPlanData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentPlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CurrentPlanData? data)  $default,) {final _that = this;
switch (_that) {
case _CurrentPlanResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  CurrentPlanData? data)?  $default,) {final _that = this;
switch (_that) {
case _CurrentPlanResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentPlanResponseModel implements CurrentPlanResponseModel {
  const _CurrentPlanResponseModel({this.code, this.status, this.message, this.data});
  factory _CurrentPlanResponseModel.fromJson(Map<String, dynamic> json) => _$CurrentPlanResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  CurrentPlanData? data;

/// Create a copy of CurrentPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentPlanResponseModelCopyWith<_CurrentPlanResponseModel> get copyWith => __$CurrentPlanResponseModelCopyWithImpl<_CurrentPlanResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentPlanResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentPlanResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'CurrentPlanResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CurrentPlanResponseModelCopyWith<$Res> implements $CurrentPlanResponseModelCopyWith<$Res> {
  factory _$CurrentPlanResponseModelCopyWith(_CurrentPlanResponseModel value, $Res Function(_CurrentPlanResponseModel) _then) = __$CurrentPlanResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, CurrentPlanData? data
});


@override $CurrentPlanDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CurrentPlanResponseModelCopyWithImpl<$Res>
    implements _$CurrentPlanResponseModelCopyWith<$Res> {
  __$CurrentPlanResponseModelCopyWithImpl(this._self, this._then);

  final _CurrentPlanResponseModel _self;
  final $Res Function(_CurrentPlanResponseModel) _then;

/// Create a copy of CurrentPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CurrentPlanResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CurrentPlanData?,
  ));
}

/// Create a copy of CurrentPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CurrentPlanDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CurrentPlanData {

@JsonKey(name: 'current_plan') CurrentPlan? get currentPlanArr;@JsonKey(name: 'add_on_plan') List<AddOnPlan>? get addOnPlanArr;
/// Create a copy of CurrentPlanData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentPlanDataCopyWith<CurrentPlanData> get copyWith => _$CurrentPlanDataCopyWithImpl<CurrentPlanData>(this as CurrentPlanData, _$identity);

  /// Serializes this CurrentPlanData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CurrentPlanData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentPlanData&&(identical(other.currentPlanArr, _this.currentPlanArr) || other.currentPlanArr == _this.currentPlanArr)&&const DeepCollectionEquality().equals(other.addOnPlanArr, _this.addOnPlanArr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CurrentPlanData;
  return Object.hash(runtimeType,_this.currentPlanArr,const DeepCollectionEquality().hash(_this.addOnPlanArr));
}

@override
String toString() {
  final _this = this as CurrentPlanData;
  return 'CurrentPlanData(currentPlanArr: ${_this.currentPlanArr}, addOnPlanArr: ${_this.addOnPlanArr})';
}


}

/// @nodoc
abstract mixin class $CurrentPlanDataCopyWith<$Res>  {
  factory $CurrentPlanDataCopyWith(CurrentPlanData value, $Res Function(CurrentPlanData) _then) = _$CurrentPlanDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'current_plan') CurrentPlan? currentPlanArr,@JsonKey(name: 'add_on_plan') List<AddOnPlan>? addOnPlanArr
});


$CurrentPlanCopyWith<$Res>? get currentPlanArr;

}
/// @nodoc
class _$CurrentPlanDataCopyWithImpl<$Res>
    implements $CurrentPlanDataCopyWith<$Res> {
  _$CurrentPlanDataCopyWithImpl(this._self, this._then);

  final CurrentPlanData _self;
  final $Res Function(CurrentPlanData) _then;

/// Create a copy of CurrentPlanData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPlanArr = freezed,Object? addOnPlanArr = freezed,}) {
  return _then(CurrentPlanData(
currentPlanArr: freezed == currentPlanArr ? _self.currentPlanArr : currentPlanArr // ignore: cast_nullable_to_non_nullable
as CurrentPlan?,addOnPlanArr: freezed == addOnPlanArr ? _self.addOnPlanArr : addOnPlanArr // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>?,
  ));
}
/// Create a copy of CurrentPlanData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanCopyWith<$Res>? get currentPlanArr {
    if (_self.currentPlanArr == null) {
    return null;
  }

  return $CurrentPlanCopyWith<$Res>(_self.currentPlanArr!, (value) {
    return _then(_self.copyWith(currentPlanArr: value));
  });
}
}


/// Adds pattern-matching-related methods to [CurrentPlanData].
extension CurrentPlanDataPatterns on CurrentPlanData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentPlanData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentPlanData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentPlanData value)  $default,){
final _that = this;
switch (_that) {
case _CurrentPlanData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentPlanData value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentPlanData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_plan')  CurrentPlan? currentPlanArr, @JsonKey(name: 'add_on_plan')  List<AddOnPlan>? addOnPlanArr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentPlanData() when $default != null:
return $default(_that.currentPlanArr,_that.addOnPlanArr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_plan')  CurrentPlan? currentPlanArr, @JsonKey(name: 'add_on_plan')  List<AddOnPlan>? addOnPlanArr)  $default,) {final _that = this;
switch (_that) {
case _CurrentPlanData():
return $default(_that.currentPlanArr,_that.addOnPlanArr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'current_plan')  CurrentPlan? currentPlanArr, @JsonKey(name: 'add_on_plan')  List<AddOnPlan>? addOnPlanArr)?  $default,) {final _that = this;
switch (_that) {
case _CurrentPlanData() when $default != null:
return $default(_that.currentPlanArr,_that.addOnPlanArr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentPlanData implements CurrentPlanData {
  const _CurrentPlanData({@JsonKey(name: 'current_plan') this.currentPlanArr, @JsonKey(name: 'add_on_plan')  List<AddOnPlan>? addOnPlanArr}): _addOnPlanArr = addOnPlanArr;
  factory _CurrentPlanData.fromJson(Map<String, dynamic> json) => _$CurrentPlanDataFromJson(json);

@override@JsonKey(name: 'current_plan') final  CurrentPlan? currentPlanArr;
 final  List<AddOnPlan>? _addOnPlanArr;
@override@JsonKey(name: 'add_on_plan') List<AddOnPlan>? get addOnPlanArr {
  final value = _addOnPlanArr;
  if (value == null) return null;
  if (_addOnPlanArr is EqualUnmodifiableListView) return _addOnPlanArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CurrentPlanData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentPlanDataCopyWith<_CurrentPlanData> get copyWith => __$CurrentPlanDataCopyWithImpl<_CurrentPlanData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentPlanDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentPlanData&&(identical(other.currentPlanArr, currentPlanArr) || other.currentPlanArr == currentPlanArr)&&const DeepCollectionEquality().equals(other.addOnPlanArr, _addOnPlanArr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,currentPlanArr,const DeepCollectionEquality().hash(_addOnPlanArr));
}

@override
String toString() {
    return 'CurrentPlanData(currentPlanArr: $currentPlanArr, addOnPlanArr: $addOnPlanArr)';
}


}

/// @nodoc
abstract mixin class _$CurrentPlanDataCopyWith<$Res> implements $CurrentPlanDataCopyWith<$Res> {
  factory _$CurrentPlanDataCopyWith(_CurrentPlanData value, $Res Function(_CurrentPlanData) _then) = __$CurrentPlanDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'current_plan') CurrentPlan? currentPlanArr,@JsonKey(name: 'add_on_plan') List<AddOnPlan>? addOnPlanArr
});


@override $CurrentPlanCopyWith<$Res>? get currentPlanArr;

}
/// @nodoc
class __$CurrentPlanDataCopyWithImpl<$Res>
    implements _$CurrentPlanDataCopyWith<$Res> {
  __$CurrentPlanDataCopyWithImpl(this._self, this._then);

  final _CurrentPlanData _self;
  final $Res Function(_CurrentPlanData) _then;

/// Create a copy of CurrentPlanData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPlanArr = freezed,Object? addOnPlanArr = freezed,}) {
  return _then(_CurrentPlanData(
currentPlanArr: freezed == currentPlanArr ? _self.currentPlanArr : currentPlanArr // ignore: cast_nullable_to_non_nullable
as CurrentPlan?,addOnPlanArr: freezed == addOnPlanArr ? _self._addOnPlanArr : addOnPlanArr // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>?,
  ));
}

/// Create a copy of CurrentPlanData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPlanCopyWith<$Res>? get currentPlanArr {
    if (_self.currentPlanArr == null) {
    return null;
  }

  return $CurrentPlanCopyWith<$Res>(_self.currentPlanArr!, (value) {
    return _then(_self.copyWith(currentPlanArr: value));
  });
}
}


/// @nodoc
mixin _$CurrentPlan {

 dynamic get id;@JsonKey(name: 'member_id') dynamic get memberId; String? get name; String? get email;@JsonKey(name: 'plan_name') String? get planName;@JsonKey(name: 'plan_activated') String? get planActivated;@JsonKey(name: 'plan_expired') String? get planExpired;@JsonKey(name: 'grand_total') dynamic get grandTotal;@JsonKey(name: 'plan_total_duration') String? get planTotalDuration;@JsonKey(name: 'plan_currency') String? get planCurrency;@JsonKey(name: 'discount_amount') dynamic get discountAmount;@JsonKey(name: 'plan_total_interest') String? get planTotalInterest;@JsonKey(name: 'interest_used') dynamic get interestUsed;@JsonKey(name: 'plan_view_contact') String? get planViewContact;@JsonKey(name: 'view_contacts_used') dynamic get viewContactsUsed;@JsonKey(name: 'plan_video_call_remaining') String? get planVideoCallRemaining;@JsonKey(name: 'plan_audio_call_remaining') String? get planAudioCallRemaining; String? get chat; String? get status;@JsonKey(name: 'plan_activate_date') String? get planActivateDate;@JsonKey(name: 'plan_expiry_date') String? get planExpiryDate;@JsonKey(name: 'total_validity_days') dynamic get totalValidityDays;@JsonKey(name: 'plan_validity_days') dynamic get planValidityDays;@JsonKey(name: 'currency_code') String? get currencyCode;@JsonKey(name: 'interests_total') dynamic get interestsTotal;@JsonKey(name: 'interests_used') dynamic get interestsUsed;@JsonKey(name: 'contact_views_total') dynamic get contactViewsTotal;@JsonKey(name: 'contact_views_used') dynamic get contactViewsUsed;@JsonKey(name: 'video_minutes_total') dynamic get videoMinutesTotal;@JsonKey(name: 'video_minutes_used') dynamic get videoMinutesUsed;@JsonKey(name: 'audio_minutes_total') dynamic get audioMinutesTotal;@JsonKey(name: 'audio_minutes_used') dynamic get audioMinutesUsed;@JsonKey(name: 'can_chat') dynamic get canChat;@JsonKey(name: 'payment_mode') String? get paymentMode;@JsonKey(name: 'download_invoice') String? get downloadInvoice;@JsonKey(name: 'plan_view_profile') dynamic get planViewProfile;@JsonKey(name: 'addon_view_profile') dynamic get addonViewProfile;@JsonKey(name: 'view_profile_total') dynamic get viewProfileTotal;@JsonKey(name: 'view_profile_used') dynamic get viewProfileUsed;@JsonKey(name: 'plan_description') String? get planDescription;@JsonKey(name: 'ai_interest') dynamic get aiInterest;@JsonKey(name: 'auto_renewing') dynamic get autoRenewing;
/// Create a copy of CurrentPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentPlanCopyWith<CurrentPlan> get copyWith => _$CurrentPlanCopyWithImpl<CurrentPlan>(this as CurrentPlan, _$identity);

  /// Serializes this CurrentPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CurrentPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentPlan&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.memberId, _this.memberId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&(identical(other.planActivated, _this.planActivated) || other.planActivated == _this.planActivated)&&(identical(other.planExpired, _this.planExpired) || other.planExpired == _this.planExpired)&&const DeepCollectionEquality().equals(other.grandTotal, _this.grandTotal)&&(identical(other.planTotalDuration, _this.planTotalDuration) || other.planTotalDuration == _this.planTotalDuration)&&(identical(other.planCurrency, _this.planCurrency) || other.planCurrency == _this.planCurrency)&&const DeepCollectionEquality().equals(other.discountAmount, _this.discountAmount)&&(identical(other.planTotalInterest, _this.planTotalInterest) || other.planTotalInterest == _this.planTotalInterest)&&const DeepCollectionEquality().equals(other.interestUsed, _this.interestUsed)&&(identical(other.planViewContact, _this.planViewContact) || other.planViewContact == _this.planViewContact)&&const DeepCollectionEquality().equals(other.viewContactsUsed, _this.viewContactsUsed)&&(identical(other.planVideoCallRemaining, _this.planVideoCallRemaining) || other.planVideoCallRemaining == _this.planVideoCallRemaining)&&(identical(other.planAudioCallRemaining, _this.planAudioCallRemaining) || other.planAudioCallRemaining == _this.planAudioCallRemaining)&&(identical(other.chat, _this.chat) || other.chat == _this.chat)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.planActivateDate, _this.planActivateDate) || other.planActivateDate == _this.planActivateDate)&&(identical(other.planExpiryDate, _this.planExpiryDate) || other.planExpiryDate == _this.planExpiryDate)&&const DeepCollectionEquality().equals(other.totalValidityDays, _this.totalValidityDays)&&const DeepCollectionEquality().equals(other.planValidityDays, _this.planValidityDays)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&const DeepCollectionEquality().equals(other.interestsTotal, _this.interestsTotal)&&const DeepCollectionEquality().equals(other.interestsUsed, _this.interestsUsed)&&const DeepCollectionEquality().equals(other.contactViewsTotal, _this.contactViewsTotal)&&const DeepCollectionEquality().equals(other.contactViewsUsed, _this.contactViewsUsed)&&const DeepCollectionEquality().equals(other.videoMinutesTotal, _this.videoMinutesTotal)&&const DeepCollectionEquality().equals(other.videoMinutesUsed, _this.videoMinutesUsed)&&const DeepCollectionEquality().equals(other.audioMinutesTotal, _this.audioMinutesTotal)&&const DeepCollectionEquality().equals(other.audioMinutesUsed, _this.audioMinutesUsed)&&const DeepCollectionEquality().equals(other.canChat, _this.canChat)&&(identical(other.paymentMode, _this.paymentMode) || other.paymentMode == _this.paymentMode)&&(identical(other.downloadInvoice, _this.downloadInvoice) || other.downloadInvoice == _this.downloadInvoice)&&const DeepCollectionEquality().equals(other.planViewProfile, _this.planViewProfile)&&const DeepCollectionEquality().equals(other.addonViewProfile, _this.addonViewProfile)&&const DeepCollectionEquality().equals(other.viewProfileTotal, _this.viewProfileTotal)&&const DeepCollectionEquality().equals(other.viewProfileUsed, _this.viewProfileUsed)&&(identical(other.planDescription, _this.planDescription) || other.planDescription == _this.planDescription)&&const DeepCollectionEquality().equals(other.aiInterest, _this.aiInterest)&&const DeepCollectionEquality().equals(other.autoRenewing, _this.autoRenewing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CurrentPlan;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.memberId),_this.name,_this.email,_this.planName,_this.planActivated,_this.planExpired,const DeepCollectionEquality().hash(_this.grandTotal),_this.planTotalDuration,_this.planCurrency,const DeepCollectionEquality().hash(_this.discountAmount),_this.planTotalInterest,const DeepCollectionEquality().hash(_this.interestUsed),_this.planViewContact,const DeepCollectionEquality().hash(_this.viewContactsUsed),_this.planVideoCallRemaining,_this.planAudioCallRemaining,_this.chat,_this.status,_this.planActivateDate,_this.planExpiryDate,const DeepCollectionEquality().hash(_this.totalValidityDays),const DeepCollectionEquality().hash(_this.planValidityDays),_this.currencyCode,const DeepCollectionEquality().hash(_this.interestsTotal),const DeepCollectionEquality().hash(_this.interestsUsed),const DeepCollectionEquality().hash(_this.contactViewsTotal),const DeepCollectionEquality().hash(_this.contactViewsUsed),const DeepCollectionEquality().hash(_this.videoMinutesTotal),const DeepCollectionEquality().hash(_this.videoMinutesUsed),const DeepCollectionEquality().hash(_this.audioMinutesTotal),const DeepCollectionEquality().hash(_this.audioMinutesUsed),const DeepCollectionEquality().hash(_this.canChat),_this.paymentMode,_this.downloadInvoice,const DeepCollectionEquality().hash(_this.planViewProfile),const DeepCollectionEquality().hash(_this.addonViewProfile),const DeepCollectionEquality().hash(_this.viewProfileTotal),const DeepCollectionEquality().hash(_this.viewProfileUsed),_this.planDescription,const DeepCollectionEquality().hash(_this.aiInterest),const DeepCollectionEquality().hash(_this.autoRenewing)]);
}

@override
String toString() {
  final _this = this as CurrentPlan;
  return 'CurrentPlan(id: ${_this.id}, memberId: ${_this.memberId}, name: ${_this.name}, email: ${_this.email}, planName: ${_this.planName}, planActivated: ${_this.planActivated}, planExpired: ${_this.planExpired}, grandTotal: ${_this.grandTotal}, planTotalDuration: ${_this.planTotalDuration}, planCurrency: ${_this.planCurrency}, discountAmount: ${_this.discountAmount}, planTotalInterest: ${_this.planTotalInterest}, interestUsed: ${_this.interestUsed}, planViewContact: ${_this.planViewContact}, viewContactsUsed: ${_this.viewContactsUsed}, planVideoCallRemaining: ${_this.planVideoCallRemaining}, planAudioCallRemaining: ${_this.planAudioCallRemaining}, chat: ${_this.chat}, status: ${_this.status}, planActivateDate: ${_this.planActivateDate}, planExpiryDate: ${_this.planExpiryDate}, totalValidityDays: ${_this.totalValidityDays}, planValidityDays: ${_this.planValidityDays}, currencyCode: ${_this.currencyCode}, interestsTotal: ${_this.interestsTotal}, interestsUsed: ${_this.interestsUsed}, contactViewsTotal: ${_this.contactViewsTotal}, contactViewsUsed: ${_this.contactViewsUsed}, videoMinutesTotal: ${_this.videoMinutesTotal}, videoMinutesUsed: ${_this.videoMinutesUsed}, audioMinutesTotal: ${_this.audioMinutesTotal}, audioMinutesUsed: ${_this.audioMinutesUsed}, canChat: ${_this.canChat}, paymentMode: ${_this.paymentMode}, downloadInvoice: ${_this.downloadInvoice}, planViewProfile: ${_this.planViewProfile}, addonViewProfile: ${_this.addonViewProfile}, viewProfileTotal: ${_this.viewProfileTotal}, viewProfileUsed: ${_this.viewProfileUsed}, planDescription: ${_this.planDescription}, aiInterest: ${_this.aiInterest}, autoRenewing: ${_this.autoRenewing})';
}


}

/// @nodoc
abstract mixin class $CurrentPlanCopyWith<$Res>  {
  factory $CurrentPlanCopyWith(CurrentPlan value, $Res Function(CurrentPlan) _then) = _$CurrentPlanCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'member_id') dynamic memberId, String? name, String? email,@JsonKey(name: 'plan_name') String? planName,@JsonKey(name: 'plan_activated') String? planActivated,@JsonKey(name: 'plan_expired') String? planExpired,@JsonKey(name: 'grand_total') dynamic grandTotal,@JsonKey(name: 'plan_total_duration') String? planTotalDuration,@JsonKey(name: 'plan_currency') String? planCurrency,@JsonKey(name: 'discount_amount') dynamic discountAmount,@JsonKey(name: 'plan_total_interest') String? planTotalInterest,@JsonKey(name: 'interest_used') dynamic interestUsed,@JsonKey(name: 'plan_view_contact') String? planViewContact,@JsonKey(name: 'view_contacts_used') dynamic viewContactsUsed,@JsonKey(name: 'plan_video_call_remaining') String? planVideoCallRemaining,@JsonKey(name: 'plan_audio_call_remaining') String? planAudioCallRemaining, String? chat, String? status,@JsonKey(name: 'plan_activate_date') String? planActivateDate,@JsonKey(name: 'plan_expiry_date') String? planExpiryDate,@JsonKey(name: 'total_validity_days') dynamic totalValidityDays,@JsonKey(name: 'plan_validity_days') dynamic planValidityDays,@JsonKey(name: 'currency_code') String? currencyCode,@JsonKey(name: 'interests_total') dynamic interestsTotal,@JsonKey(name: 'interests_used') dynamic interestsUsed,@JsonKey(name: 'contact_views_total') dynamic contactViewsTotal,@JsonKey(name: 'contact_views_used') dynamic contactViewsUsed,@JsonKey(name: 'video_minutes_total') dynamic videoMinutesTotal,@JsonKey(name: 'video_minutes_used') dynamic videoMinutesUsed,@JsonKey(name: 'audio_minutes_total') dynamic audioMinutesTotal,@JsonKey(name: 'audio_minutes_used') dynamic audioMinutesUsed,@JsonKey(name: 'can_chat') dynamic canChat,@JsonKey(name: 'payment_mode') String? paymentMode,@JsonKey(name: 'download_invoice') String? downloadInvoice,@JsonKey(name: 'plan_view_profile') dynamic planViewProfile,@JsonKey(name: 'addon_view_profile') dynamic addonViewProfile,@JsonKey(name: 'view_profile_total') dynamic viewProfileTotal,@JsonKey(name: 'view_profile_used') dynamic viewProfileUsed,@JsonKey(name: 'plan_description') String? planDescription,@JsonKey(name: 'ai_interest') dynamic aiInterest,@JsonKey(name: 'auto_renewing') dynamic autoRenewing
});




}
/// @nodoc
class _$CurrentPlanCopyWithImpl<$Res>
    implements $CurrentPlanCopyWith<$Res> {
  _$CurrentPlanCopyWithImpl(this._self, this._then);

  final CurrentPlan _self;
  final $Res Function(CurrentPlan) _then;

/// Create a copy of CurrentPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? memberId = freezed,Object? name = freezed,Object? email = freezed,Object? planName = freezed,Object? planActivated = freezed,Object? planExpired = freezed,Object? grandTotal = freezed,Object? planTotalDuration = freezed,Object? planCurrency = freezed,Object? discountAmount = freezed,Object? planTotalInterest = freezed,Object? interestUsed = freezed,Object? planViewContact = freezed,Object? viewContactsUsed = freezed,Object? planVideoCallRemaining = freezed,Object? planAudioCallRemaining = freezed,Object? chat = freezed,Object? status = freezed,Object? planActivateDate = freezed,Object? planExpiryDate = freezed,Object? totalValidityDays = freezed,Object? planValidityDays = freezed,Object? currencyCode = freezed,Object? interestsTotal = freezed,Object? interestsUsed = freezed,Object? contactViewsTotal = freezed,Object? contactViewsUsed = freezed,Object? videoMinutesTotal = freezed,Object? videoMinutesUsed = freezed,Object? audioMinutesTotal = freezed,Object? audioMinutesUsed = freezed,Object? canChat = freezed,Object? paymentMode = freezed,Object? downloadInvoice = freezed,Object? planViewProfile = freezed,Object? addonViewProfile = freezed,Object? viewProfileTotal = freezed,Object? viewProfileUsed = freezed,Object? planDescription = freezed,Object? aiInterest = freezed,Object? autoRenewing = freezed,}) {
  return _then(CurrentPlan(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,planActivated: freezed == planActivated ? _self.planActivated : planActivated // ignore: cast_nullable_to_non_nullable
as String?,planExpired: freezed == planExpired ? _self.planExpired : planExpired // ignore: cast_nullable_to_non_nullable
as String?,grandTotal: freezed == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as dynamic,planTotalDuration: freezed == planTotalDuration ? _self.planTotalDuration : planTotalDuration // ignore: cast_nullable_to_non_nullable
as String?,planCurrency: freezed == planCurrency ? _self.planCurrency : planCurrency // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as dynamic,planTotalInterest: freezed == planTotalInterest ? _self.planTotalInterest : planTotalInterest // ignore: cast_nullable_to_non_nullable
as String?,interestUsed: freezed == interestUsed ? _self.interestUsed : interestUsed // ignore: cast_nullable_to_non_nullable
as dynamic,planViewContact: freezed == planViewContact ? _self.planViewContact : planViewContact // ignore: cast_nullable_to_non_nullable
as String?,viewContactsUsed: freezed == viewContactsUsed ? _self.viewContactsUsed : viewContactsUsed // ignore: cast_nullable_to_non_nullable
as dynamic,planVideoCallRemaining: freezed == planVideoCallRemaining ? _self.planVideoCallRemaining : planVideoCallRemaining // ignore: cast_nullable_to_non_nullable
as String?,planAudioCallRemaining: freezed == planAudioCallRemaining ? _self.planAudioCallRemaining : planAudioCallRemaining // ignore: cast_nullable_to_non_nullable
as String?,chat: freezed == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,planActivateDate: freezed == planActivateDate ? _self.planActivateDate : planActivateDate // ignore: cast_nullable_to_non_nullable
as String?,planExpiryDate: freezed == planExpiryDate ? _self.planExpiryDate : planExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,totalValidityDays: freezed == totalValidityDays ? _self.totalValidityDays : totalValidityDays // ignore: cast_nullable_to_non_nullable
as dynamic,planValidityDays: freezed == planValidityDays ? _self.planValidityDays : planValidityDays // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,interestsTotal: freezed == interestsTotal ? _self.interestsTotal : interestsTotal // ignore: cast_nullable_to_non_nullable
as dynamic,interestsUsed: freezed == interestsUsed ? _self.interestsUsed : interestsUsed // ignore: cast_nullable_to_non_nullable
as dynamic,contactViewsTotal: freezed == contactViewsTotal ? _self.contactViewsTotal : contactViewsTotal // ignore: cast_nullable_to_non_nullable
as dynamic,contactViewsUsed: freezed == contactViewsUsed ? _self.contactViewsUsed : contactViewsUsed // ignore: cast_nullable_to_non_nullable
as dynamic,videoMinutesTotal: freezed == videoMinutesTotal ? _self.videoMinutesTotal : videoMinutesTotal // ignore: cast_nullable_to_non_nullable
as dynamic,videoMinutesUsed: freezed == videoMinutesUsed ? _self.videoMinutesUsed : videoMinutesUsed // ignore: cast_nullable_to_non_nullable
as dynamic,audioMinutesTotal: freezed == audioMinutesTotal ? _self.audioMinutesTotal : audioMinutesTotal // ignore: cast_nullable_to_non_nullable
as dynamic,audioMinutesUsed: freezed == audioMinutesUsed ? _self.audioMinutesUsed : audioMinutesUsed // ignore: cast_nullable_to_non_nullable
as dynamic,canChat: freezed == canChat ? _self.canChat : canChat // ignore: cast_nullable_to_non_nullable
as dynamic,paymentMode: freezed == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String?,downloadInvoice: freezed == downloadInvoice ? _self.downloadInvoice : downloadInvoice // ignore: cast_nullable_to_non_nullable
as String?,planViewProfile: freezed == planViewProfile ? _self.planViewProfile : planViewProfile // ignore: cast_nullable_to_non_nullable
as dynamic,addonViewProfile: freezed == addonViewProfile ? _self.addonViewProfile : addonViewProfile // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileTotal: freezed == viewProfileTotal ? _self.viewProfileTotal : viewProfileTotal // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileUsed: freezed == viewProfileUsed ? _self.viewProfileUsed : viewProfileUsed // ignore: cast_nullable_to_non_nullable
as dynamic,planDescription: freezed == planDescription ? _self.planDescription : planDescription // ignore: cast_nullable_to_non_nullable
as String?,aiInterest: freezed == aiInterest ? _self.aiInterest : aiInterest // ignore: cast_nullable_to_non_nullable
as dynamic,autoRenewing: freezed == autoRenewing ? _self.autoRenewing : autoRenewing // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentPlan].
extension CurrentPlanPatterns on CurrentPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentPlan value)  $default,){
final _that = this;
switch (_that) {
case _CurrentPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentPlan value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'member_id')  dynamic memberId,  String? name,  String? email, @JsonKey(name: 'plan_name')  String? planName, @JsonKey(name: 'plan_activated')  String? planActivated, @JsonKey(name: 'plan_expired')  String? planExpired, @JsonKey(name: 'grand_total')  dynamic grandTotal, @JsonKey(name: 'plan_total_duration')  String? planTotalDuration, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'discount_amount')  dynamic discountAmount, @JsonKey(name: 'plan_total_interest')  String? planTotalInterest, @JsonKey(name: 'interest_used')  dynamic interestUsed, @JsonKey(name: 'plan_view_contact')  String? planViewContact, @JsonKey(name: 'view_contacts_used')  dynamic viewContactsUsed, @JsonKey(name: 'plan_video_call_remaining')  String? planVideoCallRemaining, @JsonKey(name: 'plan_audio_call_remaining')  String? planAudioCallRemaining,  String? chat,  String? status, @JsonKey(name: 'plan_activate_date')  String? planActivateDate, @JsonKey(name: 'plan_expiry_date')  String? planExpiryDate, @JsonKey(name: 'total_validity_days')  dynamic totalValidityDays, @JsonKey(name: 'plan_validity_days')  dynamic planValidityDays, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'interests_total')  dynamic interestsTotal, @JsonKey(name: 'interests_used')  dynamic interestsUsed, @JsonKey(name: 'contact_views_total')  dynamic contactViewsTotal, @JsonKey(name: 'contact_views_used')  dynamic contactViewsUsed, @JsonKey(name: 'video_minutes_total')  dynamic videoMinutesTotal, @JsonKey(name: 'video_minutes_used')  dynamic videoMinutesUsed, @JsonKey(name: 'audio_minutes_total')  dynamic audioMinutesTotal, @JsonKey(name: 'audio_minutes_used')  dynamic audioMinutesUsed, @JsonKey(name: 'can_chat')  dynamic canChat, @JsonKey(name: 'payment_mode')  String? paymentMode, @JsonKey(name: 'download_invoice')  String? downloadInvoice, @JsonKey(name: 'plan_view_profile')  dynamic planViewProfile, @JsonKey(name: 'addon_view_profile')  dynamic addonViewProfile, @JsonKey(name: 'view_profile_total')  dynamic viewProfileTotal, @JsonKey(name: 'view_profile_used')  dynamic viewProfileUsed, @JsonKey(name: 'plan_description')  String? planDescription, @JsonKey(name: 'ai_interest')  dynamic aiInterest, @JsonKey(name: 'auto_renewing')  dynamic autoRenewing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentPlan() when $default != null:
return $default(_that.id,_that.memberId,_that.name,_that.email,_that.planName,_that.planActivated,_that.planExpired,_that.grandTotal,_that.planTotalDuration,_that.planCurrency,_that.discountAmount,_that.planTotalInterest,_that.interestUsed,_that.planViewContact,_that.viewContactsUsed,_that.planVideoCallRemaining,_that.planAudioCallRemaining,_that.chat,_that.status,_that.planActivateDate,_that.planExpiryDate,_that.totalValidityDays,_that.planValidityDays,_that.currencyCode,_that.interestsTotal,_that.interestsUsed,_that.contactViewsTotal,_that.contactViewsUsed,_that.videoMinutesTotal,_that.videoMinutesUsed,_that.audioMinutesTotal,_that.audioMinutesUsed,_that.canChat,_that.paymentMode,_that.downloadInvoice,_that.planViewProfile,_that.addonViewProfile,_that.viewProfileTotal,_that.viewProfileUsed,_that.planDescription,_that.aiInterest,_that.autoRenewing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'member_id')  dynamic memberId,  String? name,  String? email, @JsonKey(name: 'plan_name')  String? planName, @JsonKey(name: 'plan_activated')  String? planActivated, @JsonKey(name: 'plan_expired')  String? planExpired, @JsonKey(name: 'grand_total')  dynamic grandTotal, @JsonKey(name: 'plan_total_duration')  String? planTotalDuration, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'discount_amount')  dynamic discountAmount, @JsonKey(name: 'plan_total_interest')  String? planTotalInterest, @JsonKey(name: 'interest_used')  dynamic interestUsed, @JsonKey(name: 'plan_view_contact')  String? planViewContact, @JsonKey(name: 'view_contacts_used')  dynamic viewContactsUsed, @JsonKey(name: 'plan_video_call_remaining')  String? planVideoCallRemaining, @JsonKey(name: 'plan_audio_call_remaining')  String? planAudioCallRemaining,  String? chat,  String? status, @JsonKey(name: 'plan_activate_date')  String? planActivateDate, @JsonKey(name: 'plan_expiry_date')  String? planExpiryDate, @JsonKey(name: 'total_validity_days')  dynamic totalValidityDays, @JsonKey(name: 'plan_validity_days')  dynamic planValidityDays, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'interests_total')  dynamic interestsTotal, @JsonKey(name: 'interests_used')  dynamic interestsUsed, @JsonKey(name: 'contact_views_total')  dynamic contactViewsTotal, @JsonKey(name: 'contact_views_used')  dynamic contactViewsUsed, @JsonKey(name: 'video_minutes_total')  dynamic videoMinutesTotal, @JsonKey(name: 'video_minutes_used')  dynamic videoMinutesUsed, @JsonKey(name: 'audio_minutes_total')  dynamic audioMinutesTotal, @JsonKey(name: 'audio_minutes_used')  dynamic audioMinutesUsed, @JsonKey(name: 'can_chat')  dynamic canChat, @JsonKey(name: 'payment_mode')  String? paymentMode, @JsonKey(name: 'download_invoice')  String? downloadInvoice, @JsonKey(name: 'plan_view_profile')  dynamic planViewProfile, @JsonKey(name: 'addon_view_profile')  dynamic addonViewProfile, @JsonKey(name: 'view_profile_total')  dynamic viewProfileTotal, @JsonKey(name: 'view_profile_used')  dynamic viewProfileUsed, @JsonKey(name: 'plan_description')  String? planDescription, @JsonKey(name: 'ai_interest')  dynamic aiInterest, @JsonKey(name: 'auto_renewing')  dynamic autoRenewing)  $default,) {final _that = this;
switch (_that) {
case _CurrentPlan():
return $default(_that.id,_that.memberId,_that.name,_that.email,_that.planName,_that.planActivated,_that.planExpired,_that.grandTotal,_that.planTotalDuration,_that.planCurrency,_that.discountAmount,_that.planTotalInterest,_that.interestUsed,_that.planViewContact,_that.viewContactsUsed,_that.planVideoCallRemaining,_that.planAudioCallRemaining,_that.chat,_that.status,_that.planActivateDate,_that.planExpiryDate,_that.totalValidityDays,_that.planValidityDays,_that.currencyCode,_that.interestsTotal,_that.interestsUsed,_that.contactViewsTotal,_that.contactViewsUsed,_that.videoMinutesTotal,_that.videoMinutesUsed,_that.audioMinutesTotal,_that.audioMinutesUsed,_that.canChat,_that.paymentMode,_that.downloadInvoice,_that.planViewProfile,_that.addonViewProfile,_that.viewProfileTotal,_that.viewProfileUsed,_that.planDescription,_that.aiInterest,_that.autoRenewing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'member_id')  dynamic memberId,  String? name,  String? email, @JsonKey(name: 'plan_name')  String? planName, @JsonKey(name: 'plan_activated')  String? planActivated, @JsonKey(name: 'plan_expired')  String? planExpired, @JsonKey(name: 'grand_total')  dynamic grandTotal, @JsonKey(name: 'plan_total_duration')  String? planTotalDuration, @JsonKey(name: 'plan_currency')  String? planCurrency, @JsonKey(name: 'discount_amount')  dynamic discountAmount, @JsonKey(name: 'plan_total_interest')  String? planTotalInterest, @JsonKey(name: 'interest_used')  dynamic interestUsed, @JsonKey(name: 'plan_view_contact')  String? planViewContact, @JsonKey(name: 'view_contacts_used')  dynamic viewContactsUsed, @JsonKey(name: 'plan_video_call_remaining')  String? planVideoCallRemaining, @JsonKey(name: 'plan_audio_call_remaining')  String? planAudioCallRemaining,  String? chat,  String? status, @JsonKey(name: 'plan_activate_date')  String? planActivateDate, @JsonKey(name: 'plan_expiry_date')  String? planExpiryDate, @JsonKey(name: 'total_validity_days')  dynamic totalValidityDays, @JsonKey(name: 'plan_validity_days')  dynamic planValidityDays, @JsonKey(name: 'currency_code')  String? currencyCode, @JsonKey(name: 'interests_total')  dynamic interestsTotal, @JsonKey(name: 'interests_used')  dynamic interestsUsed, @JsonKey(name: 'contact_views_total')  dynamic contactViewsTotal, @JsonKey(name: 'contact_views_used')  dynamic contactViewsUsed, @JsonKey(name: 'video_minutes_total')  dynamic videoMinutesTotal, @JsonKey(name: 'video_minutes_used')  dynamic videoMinutesUsed, @JsonKey(name: 'audio_minutes_total')  dynamic audioMinutesTotal, @JsonKey(name: 'audio_minutes_used')  dynamic audioMinutesUsed, @JsonKey(name: 'can_chat')  dynamic canChat, @JsonKey(name: 'payment_mode')  String? paymentMode, @JsonKey(name: 'download_invoice')  String? downloadInvoice, @JsonKey(name: 'plan_view_profile')  dynamic planViewProfile, @JsonKey(name: 'addon_view_profile')  dynamic addonViewProfile, @JsonKey(name: 'view_profile_total')  dynamic viewProfileTotal, @JsonKey(name: 'view_profile_used')  dynamic viewProfileUsed, @JsonKey(name: 'plan_description')  String? planDescription, @JsonKey(name: 'ai_interest')  dynamic aiInterest, @JsonKey(name: 'auto_renewing')  dynamic autoRenewing)?  $default,) {final _that = this;
switch (_that) {
case _CurrentPlan() when $default != null:
return $default(_that.id,_that.memberId,_that.name,_that.email,_that.planName,_that.planActivated,_that.planExpired,_that.grandTotal,_that.planTotalDuration,_that.planCurrency,_that.discountAmount,_that.planTotalInterest,_that.interestUsed,_that.planViewContact,_that.viewContactsUsed,_that.planVideoCallRemaining,_that.planAudioCallRemaining,_that.chat,_that.status,_that.planActivateDate,_that.planExpiryDate,_that.totalValidityDays,_that.planValidityDays,_that.currencyCode,_that.interestsTotal,_that.interestsUsed,_that.contactViewsTotal,_that.contactViewsUsed,_that.videoMinutesTotal,_that.videoMinutesUsed,_that.audioMinutesTotal,_that.audioMinutesUsed,_that.canChat,_that.paymentMode,_that.downloadInvoice,_that.planViewProfile,_that.addonViewProfile,_that.viewProfileTotal,_that.viewProfileUsed,_that.planDescription,_that.aiInterest,_that.autoRenewing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentPlan implements CurrentPlan {
  const _CurrentPlan({this.id, @JsonKey(name: 'member_id') this.memberId, this.name, this.email, @JsonKey(name: 'plan_name') this.planName, @JsonKey(name: 'plan_activated') this.planActivated, @JsonKey(name: 'plan_expired') this.planExpired, @JsonKey(name: 'grand_total') this.grandTotal, @JsonKey(name: 'plan_total_duration') this.planTotalDuration, @JsonKey(name: 'plan_currency') this.planCurrency, @JsonKey(name: 'discount_amount') this.discountAmount, @JsonKey(name: 'plan_total_interest') this.planTotalInterest, @JsonKey(name: 'interest_used') this.interestUsed, @JsonKey(name: 'plan_view_contact') this.planViewContact, @JsonKey(name: 'view_contacts_used') this.viewContactsUsed, @JsonKey(name: 'plan_video_call_remaining') this.planVideoCallRemaining, @JsonKey(name: 'plan_audio_call_remaining') this.planAudioCallRemaining, this.chat, this.status, @JsonKey(name: 'plan_activate_date') this.planActivateDate, @JsonKey(name: 'plan_expiry_date') this.planExpiryDate, @JsonKey(name: 'total_validity_days') this.totalValidityDays, @JsonKey(name: 'plan_validity_days') this.planValidityDays, @JsonKey(name: 'currency_code') this.currencyCode, @JsonKey(name: 'interests_total') this.interestsTotal, @JsonKey(name: 'interests_used') this.interestsUsed, @JsonKey(name: 'contact_views_total') this.contactViewsTotal, @JsonKey(name: 'contact_views_used') this.contactViewsUsed, @JsonKey(name: 'video_minutes_total') this.videoMinutesTotal, @JsonKey(name: 'video_minutes_used') this.videoMinutesUsed, @JsonKey(name: 'audio_minutes_total') this.audioMinutesTotal, @JsonKey(name: 'audio_minutes_used') this.audioMinutesUsed, @JsonKey(name: 'can_chat') this.canChat, @JsonKey(name: 'payment_mode') this.paymentMode, @JsonKey(name: 'download_invoice') this.downloadInvoice, @JsonKey(name: 'plan_view_profile') this.planViewProfile, @JsonKey(name: 'addon_view_profile') this.addonViewProfile, @JsonKey(name: 'view_profile_total') this.viewProfileTotal, @JsonKey(name: 'view_profile_used') this.viewProfileUsed, @JsonKey(name: 'plan_description') this.planDescription, @JsonKey(name: 'ai_interest') this.aiInterest, @JsonKey(name: 'auto_renewing') this.autoRenewing});
  factory _CurrentPlan.fromJson(Map<String, dynamic> json) => _$CurrentPlanFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'member_id') final  dynamic memberId;
@override final  String? name;
@override final  String? email;
@override@JsonKey(name: 'plan_name') final  String? planName;
@override@JsonKey(name: 'plan_activated') final  String? planActivated;
@override@JsonKey(name: 'plan_expired') final  String? planExpired;
@override@JsonKey(name: 'grand_total') final  dynamic grandTotal;
@override@JsonKey(name: 'plan_total_duration') final  String? planTotalDuration;
@override@JsonKey(name: 'plan_currency') final  String? planCurrency;
@override@JsonKey(name: 'discount_amount') final  dynamic discountAmount;
@override@JsonKey(name: 'plan_total_interest') final  String? planTotalInterest;
@override@JsonKey(name: 'interest_used') final  dynamic interestUsed;
@override@JsonKey(name: 'plan_view_contact') final  String? planViewContact;
@override@JsonKey(name: 'view_contacts_used') final  dynamic viewContactsUsed;
@override@JsonKey(name: 'plan_video_call_remaining') final  String? planVideoCallRemaining;
@override@JsonKey(name: 'plan_audio_call_remaining') final  String? planAudioCallRemaining;
@override final  String? chat;
@override final  String? status;
@override@JsonKey(name: 'plan_activate_date') final  String? planActivateDate;
@override@JsonKey(name: 'plan_expiry_date') final  String? planExpiryDate;
@override@JsonKey(name: 'total_validity_days') final  dynamic totalValidityDays;
@override@JsonKey(name: 'plan_validity_days') final  dynamic planValidityDays;
@override@JsonKey(name: 'currency_code') final  String? currencyCode;
@override@JsonKey(name: 'interests_total') final  dynamic interestsTotal;
@override@JsonKey(name: 'interests_used') final  dynamic interestsUsed;
@override@JsonKey(name: 'contact_views_total') final  dynamic contactViewsTotal;
@override@JsonKey(name: 'contact_views_used') final  dynamic contactViewsUsed;
@override@JsonKey(name: 'video_minutes_total') final  dynamic videoMinutesTotal;
@override@JsonKey(name: 'video_minutes_used') final  dynamic videoMinutesUsed;
@override@JsonKey(name: 'audio_minutes_total') final  dynamic audioMinutesTotal;
@override@JsonKey(name: 'audio_minutes_used') final  dynamic audioMinutesUsed;
@override@JsonKey(name: 'can_chat') final  dynamic canChat;
@override@JsonKey(name: 'payment_mode') final  String? paymentMode;
@override@JsonKey(name: 'download_invoice') final  String? downloadInvoice;
@override@JsonKey(name: 'plan_view_profile') final  dynamic planViewProfile;
@override@JsonKey(name: 'addon_view_profile') final  dynamic addonViewProfile;
@override@JsonKey(name: 'view_profile_total') final  dynamic viewProfileTotal;
@override@JsonKey(name: 'view_profile_used') final  dynamic viewProfileUsed;
@override@JsonKey(name: 'plan_description') final  String? planDescription;
@override@JsonKey(name: 'ai_interest') final  dynamic aiInterest;
@override@JsonKey(name: 'auto_renewing') final  dynamic autoRenewing;

/// Create a copy of CurrentPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentPlanCopyWith<_CurrentPlan> get copyWith => __$CurrentPlanCopyWithImpl<_CurrentPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentPlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentPlan&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.memberId, memberId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planActivated, planActivated) || other.planActivated == planActivated)&&(identical(other.planExpired, planExpired) || other.planExpired == planExpired)&&const DeepCollectionEquality().equals(other.grandTotal, grandTotal)&&(identical(other.planTotalDuration, planTotalDuration) || other.planTotalDuration == planTotalDuration)&&(identical(other.planCurrency, planCurrency) || other.planCurrency == planCurrency)&&const DeepCollectionEquality().equals(other.discountAmount, discountAmount)&&(identical(other.planTotalInterest, planTotalInterest) || other.planTotalInterest == planTotalInterest)&&const DeepCollectionEquality().equals(other.interestUsed, interestUsed)&&(identical(other.planViewContact, planViewContact) || other.planViewContact == planViewContact)&&const DeepCollectionEquality().equals(other.viewContactsUsed, viewContactsUsed)&&(identical(other.planVideoCallRemaining, planVideoCallRemaining) || other.planVideoCallRemaining == planVideoCallRemaining)&&(identical(other.planAudioCallRemaining, planAudioCallRemaining) || other.planAudioCallRemaining == planAudioCallRemaining)&&(identical(other.chat, chat) || other.chat == chat)&&(identical(other.status, status) || other.status == status)&&(identical(other.planActivateDate, planActivateDate) || other.planActivateDate == planActivateDate)&&(identical(other.planExpiryDate, planExpiryDate) || other.planExpiryDate == planExpiryDate)&&const DeepCollectionEquality().equals(other.totalValidityDays, totalValidityDays)&&const DeepCollectionEquality().equals(other.planValidityDays, planValidityDays)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&const DeepCollectionEquality().equals(other.interestsTotal, interestsTotal)&&const DeepCollectionEquality().equals(other.interestsUsed, interestsUsed)&&const DeepCollectionEquality().equals(other.contactViewsTotal, contactViewsTotal)&&const DeepCollectionEquality().equals(other.contactViewsUsed, contactViewsUsed)&&const DeepCollectionEquality().equals(other.videoMinutesTotal, videoMinutesTotal)&&const DeepCollectionEquality().equals(other.videoMinutesUsed, videoMinutesUsed)&&const DeepCollectionEquality().equals(other.audioMinutesTotal, audioMinutesTotal)&&const DeepCollectionEquality().equals(other.audioMinutesUsed, audioMinutesUsed)&&const DeepCollectionEquality().equals(other.canChat, canChat)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.downloadInvoice, downloadInvoice) || other.downloadInvoice == downloadInvoice)&&const DeepCollectionEquality().equals(other.planViewProfile, planViewProfile)&&const DeepCollectionEquality().equals(other.addonViewProfile, addonViewProfile)&&const DeepCollectionEquality().equals(other.viewProfileTotal, viewProfileTotal)&&const DeepCollectionEquality().equals(other.viewProfileUsed, viewProfileUsed)&&(identical(other.planDescription, planDescription) || other.planDescription == planDescription)&&const DeepCollectionEquality().equals(other.aiInterest, aiInterest)&&const DeepCollectionEquality().equals(other.autoRenewing, autoRenewing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(memberId),name,email,planName,planActivated,planExpired,const DeepCollectionEquality().hash(grandTotal),planTotalDuration,planCurrency,const DeepCollectionEquality().hash(discountAmount),planTotalInterest,const DeepCollectionEquality().hash(interestUsed),planViewContact,const DeepCollectionEquality().hash(viewContactsUsed),planVideoCallRemaining,planAudioCallRemaining,chat,status,planActivateDate,planExpiryDate,const DeepCollectionEquality().hash(totalValidityDays),const DeepCollectionEquality().hash(planValidityDays),currencyCode,const DeepCollectionEquality().hash(interestsTotal),const DeepCollectionEquality().hash(interestsUsed),const DeepCollectionEquality().hash(contactViewsTotal),const DeepCollectionEquality().hash(contactViewsUsed),const DeepCollectionEquality().hash(videoMinutesTotal),const DeepCollectionEquality().hash(videoMinutesUsed),const DeepCollectionEquality().hash(audioMinutesTotal),const DeepCollectionEquality().hash(audioMinutesUsed),const DeepCollectionEquality().hash(canChat),paymentMode,downloadInvoice,const DeepCollectionEquality().hash(planViewProfile),const DeepCollectionEquality().hash(addonViewProfile),const DeepCollectionEquality().hash(viewProfileTotal),const DeepCollectionEquality().hash(viewProfileUsed),planDescription,const DeepCollectionEquality().hash(aiInterest),const DeepCollectionEquality().hash(autoRenewing)]);
}

@override
String toString() {
    return 'CurrentPlan(id: $id, memberId: $memberId, name: $name, email: $email, planName: $planName, planActivated: $planActivated, planExpired: $planExpired, grandTotal: $grandTotal, planTotalDuration: $planTotalDuration, planCurrency: $planCurrency, discountAmount: $discountAmount, planTotalInterest: $planTotalInterest, interestUsed: $interestUsed, planViewContact: $planViewContact, viewContactsUsed: $viewContactsUsed, planVideoCallRemaining: $planVideoCallRemaining, planAudioCallRemaining: $planAudioCallRemaining, chat: $chat, status: $status, planActivateDate: $planActivateDate, planExpiryDate: $planExpiryDate, totalValidityDays: $totalValidityDays, planValidityDays: $planValidityDays, currencyCode: $currencyCode, interestsTotal: $interestsTotal, interestsUsed: $interestsUsed, contactViewsTotal: $contactViewsTotal, contactViewsUsed: $contactViewsUsed, videoMinutesTotal: $videoMinutesTotal, videoMinutesUsed: $videoMinutesUsed, audioMinutesTotal: $audioMinutesTotal, audioMinutesUsed: $audioMinutesUsed, canChat: $canChat, paymentMode: $paymentMode, downloadInvoice: $downloadInvoice, planViewProfile: $planViewProfile, addonViewProfile: $addonViewProfile, viewProfileTotal: $viewProfileTotal, viewProfileUsed: $viewProfileUsed, planDescription: $planDescription, aiInterest: $aiInterest, autoRenewing: $autoRenewing)';
}


}

/// @nodoc
abstract mixin class _$CurrentPlanCopyWith<$Res> implements $CurrentPlanCopyWith<$Res> {
  factory _$CurrentPlanCopyWith(_CurrentPlan value, $Res Function(_CurrentPlan) _then) = __$CurrentPlanCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'member_id') dynamic memberId, String? name, String? email,@JsonKey(name: 'plan_name') String? planName,@JsonKey(name: 'plan_activated') String? planActivated,@JsonKey(name: 'plan_expired') String? planExpired,@JsonKey(name: 'grand_total') dynamic grandTotal,@JsonKey(name: 'plan_total_duration') String? planTotalDuration,@JsonKey(name: 'plan_currency') String? planCurrency,@JsonKey(name: 'discount_amount') dynamic discountAmount,@JsonKey(name: 'plan_total_interest') String? planTotalInterest,@JsonKey(name: 'interest_used') dynamic interestUsed,@JsonKey(name: 'plan_view_contact') String? planViewContact,@JsonKey(name: 'view_contacts_used') dynamic viewContactsUsed,@JsonKey(name: 'plan_video_call_remaining') String? planVideoCallRemaining,@JsonKey(name: 'plan_audio_call_remaining') String? planAudioCallRemaining, String? chat, String? status,@JsonKey(name: 'plan_activate_date') String? planActivateDate,@JsonKey(name: 'plan_expiry_date') String? planExpiryDate,@JsonKey(name: 'total_validity_days') dynamic totalValidityDays,@JsonKey(name: 'plan_validity_days') dynamic planValidityDays,@JsonKey(name: 'currency_code') String? currencyCode,@JsonKey(name: 'interests_total') dynamic interestsTotal,@JsonKey(name: 'interests_used') dynamic interestsUsed,@JsonKey(name: 'contact_views_total') dynamic contactViewsTotal,@JsonKey(name: 'contact_views_used') dynamic contactViewsUsed,@JsonKey(name: 'video_minutes_total') dynamic videoMinutesTotal,@JsonKey(name: 'video_minutes_used') dynamic videoMinutesUsed,@JsonKey(name: 'audio_minutes_total') dynamic audioMinutesTotal,@JsonKey(name: 'audio_minutes_used') dynamic audioMinutesUsed,@JsonKey(name: 'can_chat') dynamic canChat,@JsonKey(name: 'payment_mode') String? paymentMode,@JsonKey(name: 'download_invoice') String? downloadInvoice,@JsonKey(name: 'plan_view_profile') dynamic planViewProfile,@JsonKey(name: 'addon_view_profile') dynamic addonViewProfile,@JsonKey(name: 'view_profile_total') dynamic viewProfileTotal,@JsonKey(name: 'view_profile_used') dynamic viewProfileUsed,@JsonKey(name: 'plan_description') String? planDescription,@JsonKey(name: 'ai_interest') dynamic aiInterest,@JsonKey(name: 'auto_renewing') dynamic autoRenewing
});




}
/// @nodoc
class __$CurrentPlanCopyWithImpl<$Res>
    implements _$CurrentPlanCopyWith<$Res> {
  __$CurrentPlanCopyWithImpl(this._self, this._then);

  final _CurrentPlan _self;
  final $Res Function(_CurrentPlan) _then;

/// Create a copy of CurrentPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? memberId = freezed,Object? name = freezed,Object? email = freezed,Object? planName = freezed,Object? planActivated = freezed,Object? planExpired = freezed,Object? grandTotal = freezed,Object? planTotalDuration = freezed,Object? planCurrency = freezed,Object? discountAmount = freezed,Object? planTotalInterest = freezed,Object? interestUsed = freezed,Object? planViewContact = freezed,Object? viewContactsUsed = freezed,Object? planVideoCallRemaining = freezed,Object? planAudioCallRemaining = freezed,Object? chat = freezed,Object? status = freezed,Object? planActivateDate = freezed,Object? planExpiryDate = freezed,Object? totalValidityDays = freezed,Object? planValidityDays = freezed,Object? currencyCode = freezed,Object? interestsTotal = freezed,Object? interestsUsed = freezed,Object? contactViewsTotal = freezed,Object? contactViewsUsed = freezed,Object? videoMinutesTotal = freezed,Object? videoMinutesUsed = freezed,Object? audioMinutesTotal = freezed,Object? audioMinutesUsed = freezed,Object? canChat = freezed,Object? paymentMode = freezed,Object? downloadInvoice = freezed,Object? planViewProfile = freezed,Object? addonViewProfile = freezed,Object? viewProfileTotal = freezed,Object? viewProfileUsed = freezed,Object? planDescription = freezed,Object? aiInterest = freezed,Object? autoRenewing = freezed,}) {
  return _then(_CurrentPlan(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as dynamic,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,planActivated: freezed == planActivated ? _self.planActivated : planActivated // ignore: cast_nullable_to_non_nullable
as String?,planExpired: freezed == planExpired ? _self.planExpired : planExpired // ignore: cast_nullable_to_non_nullable
as String?,grandTotal: freezed == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as dynamic,planTotalDuration: freezed == planTotalDuration ? _self.planTotalDuration : planTotalDuration // ignore: cast_nullable_to_non_nullable
as String?,planCurrency: freezed == planCurrency ? _self.planCurrency : planCurrency // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as dynamic,planTotalInterest: freezed == planTotalInterest ? _self.planTotalInterest : planTotalInterest // ignore: cast_nullable_to_non_nullable
as String?,interestUsed: freezed == interestUsed ? _self.interestUsed : interestUsed // ignore: cast_nullable_to_non_nullable
as dynamic,planViewContact: freezed == planViewContact ? _self.planViewContact : planViewContact // ignore: cast_nullable_to_non_nullable
as String?,viewContactsUsed: freezed == viewContactsUsed ? _self.viewContactsUsed : viewContactsUsed // ignore: cast_nullable_to_non_nullable
as dynamic,planVideoCallRemaining: freezed == planVideoCallRemaining ? _self.planVideoCallRemaining : planVideoCallRemaining // ignore: cast_nullable_to_non_nullable
as String?,planAudioCallRemaining: freezed == planAudioCallRemaining ? _self.planAudioCallRemaining : planAudioCallRemaining // ignore: cast_nullable_to_non_nullable
as String?,chat: freezed == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,planActivateDate: freezed == planActivateDate ? _self.planActivateDate : planActivateDate // ignore: cast_nullable_to_non_nullable
as String?,planExpiryDate: freezed == planExpiryDate ? _self.planExpiryDate : planExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,totalValidityDays: freezed == totalValidityDays ? _self.totalValidityDays : totalValidityDays // ignore: cast_nullable_to_non_nullable
as dynamic,planValidityDays: freezed == planValidityDays ? _self.planValidityDays : planValidityDays // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,interestsTotal: freezed == interestsTotal ? _self.interestsTotal : interestsTotal // ignore: cast_nullable_to_non_nullable
as dynamic,interestsUsed: freezed == interestsUsed ? _self.interestsUsed : interestsUsed // ignore: cast_nullable_to_non_nullable
as dynamic,contactViewsTotal: freezed == contactViewsTotal ? _self.contactViewsTotal : contactViewsTotal // ignore: cast_nullable_to_non_nullable
as dynamic,contactViewsUsed: freezed == contactViewsUsed ? _self.contactViewsUsed : contactViewsUsed // ignore: cast_nullable_to_non_nullable
as dynamic,videoMinutesTotal: freezed == videoMinutesTotal ? _self.videoMinutesTotal : videoMinutesTotal // ignore: cast_nullable_to_non_nullable
as dynamic,videoMinutesUsed: freezed == videoMinutesUsed ? _self.videoMinutesUsed : videoMinutesUsed // ignore: cast_nullable_to_non_nullable
as dynamic,audioMinutesTotal: freezed == audioMinutesTotal ? _self.audioMinutesTotal : audioMinutesTotal // ignore: cast_nullable_to_non_nullable
as dynamic,audioMinutesUsed: freezed == audioMinutesUsed ? _self.audioMinutesUsed : audioMinutesUsed // ignore: cast_nullable_to_non_nullable
as dynamic,canChat: freezed == canChat ? _self.canChat : canChat // ignore: cast_nullable_to_non_nullable
as dynamic,paymentMode: freezed == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String?,downloadInvoice: freezed == downloadInvoice ? _self.downloadInvoice : downloadInvoice // ignore: cast_nullable_to_non_nullable
as String?,planViewProfile: freezed == planViewProfile ? _self.planViewProfile : planViewProfile // ignore: cast_nullable_to_non_nullable
as dynamic,addonViewProfile: freezed == addonViewProfile ? _self.addonViewProfile : addonViewProfile // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileTotal: freezed == viewProfileTotal ? _self.viewProfileTotal : viewProfileTotal // ignore: cast_nullable_to_non_nullable
as dynamic,viewProfileUsed: freezed == viewProfileUsed ? _self.viewProfileUsed : viewProfileUsed // ignore: cast_nullable_to_non_nullable
as dynamic,planDescription: freezed == planDescription ? _self.planDescription : planDescription // ignore: cast_nullable_to_non_nullable
as String?,aiInterest: freezed == aiInterest ? _self.aiInterest : aiInterest // ignore: cast_nullable_to_non_nullable
as dynamic,autoRenewing: freezed == autoRenewing ? _self.autoRenewing : autoRenewing // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$CheckoutResponseModel {

 int? get code; String? get status; String? get message; CheckoutData? get data;
/// Create a copy of CheckoutResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutResponseModelCopyWith<CheckoutResponseModel> get copyWith => _$CheckoutResponseModelCopyWithImpl<CheckoutResponseModel>(this as CheckoutResponseModel, _$identity);

  /// Serializes this CheckoutResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CheckoutResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CheckoutResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as CheckoutResponseModel;
  return 'CheckoutResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $CheckoutResponseModelCopyWith<$Res>  {
  factory $CheckoutResponseModelCopyWith(CheckoutResponseModel value, $Res Function(CheckoutResponseModel) _then) = _$CheckoutResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, CheckoutData? data
});


$CheckoutDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CheckoutResponseModelCopyWithImpl<$Res>
    implements $CheckoutResponseModelCopyWith<$Res> {
  _$CheckoutResponseModelCopyWithImpl(this._self, this._then);

  final CheckoutResponseModel _self;
  final $Res Function(CheckoutResponseModel) _then;

/// Create a copy of CheckoutResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(CheckoutResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckoutData?,
  ));
}
/// Create a copy of CheckoutResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckoutDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutResponseModel].
extension CheckoutResponseModelPatterns on CheckoutResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CheckoutData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CheckoutData? data)  $default,) {final _that = this;
switch (_that) {
case _CheckoutResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  CheckoutData? data)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutResponseModel implements CheckoutResponseModel {
  const _CheckoutResponseModel({this.code, this.status, this.message, this.data});
  factory _CheckoutResponseModel.fromJson(Map<String, dynamic> json) => _$CheckoutResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  CheckoutData? data;

/// Create a copy of CheckoutResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutResponseModelCopyWith<_CheckoutResponseModel> get copyWith => __$CheckoutResponseModelCopyWithImpl<_CheckoutResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'CheckoutResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CheckoutResponseModelCopyWith<$Res> implements $CheckoutResponseModelCopyWith<$Res> {
  factory _$CheckoutResponseModelCopyWith(_CheckoutResponseModel value, $Res Function(_CheckoutResponseModel) _then) = __$CheckoutResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, CheckoutData? data
});


@override $CheckoutDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CheckoutResponseModelCopyWithImpl<$Res>
    implements _$CheckoutResponseModelCopyWith<$Res> {
  __$CheckoutResponseModelCopyWithImpl(this._self, this._then);

  final _CheckoutResponseModel _self;
  final $Res Function(_CheckoutResponseModel) _then;

/// Create a copy of CheckoutResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CheckoutResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckoutData?,
  ));
}

/// Create a copy of CheckoutResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckoutDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CheckoutData {

@JsonKey(name: 'resultList') MembershipPlan? get plan;@JsonKey(name: 'add_on_packages') List<AddOnPlan>? get addOnPackages;
/// Create a copy of CheckoutData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutDataCopyWith<CheckoutData> get copyWith => _$CheckoutDataCopyWithImpl<CheckoutData>(this as CheckoutData, _$identity);

  /// Serializes this CheckoutData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CheckoutData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutData&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&const DeepCollectionEquality().equals(other.addOnPackages, _this.addOnPackages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CheckoutData;
  return Object.hash(runtimeType,_this.plan,const DeepCollectionEquality().hash(_this.addOnPackages));
}

@override
String toString() {
  final _this = this as CheckoutData;
  return 'CheckoutData(plan: ${_this.plan}, addOnPackages: ${_this.addOnPackages})';
}


}

/// @nodoc
abstract mixin class $CheckoutDataCopyWith<$Res>  {
  factory $CheckoutDataCopyWith(CheckoutData value, $Res Function(CheckoutData) _then) = _$CheckoutDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'resultList') MembershipPlan? plan,@JsonKey(name: 'add_on_packages') List<AddOnPlan>? addOnPackages
});


$MembershipPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class _$CheckoutDataCopyWithImpl<$Res>
    implements $CheckoutDataCopyWith<$Res> {
  _$CheckoutDataCopyWithImpl(this._self, this._then);

  final CheckoutData _self;
  final $Res Function(CheckoutData) _then;

/// Create a copy of CheckoutData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = freezed,Object? addOnPackages = freezed,}) {
  return _then(CheckoutData(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as MembershipPlan?,addOnPackages: freezed == addOnPackages ? _self.addOnPackages : addOnPackages // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>?,
  ));
}
/// Create a copy of CheckoutData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $MembershipPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutData].
extension CheckoutDataPatterns on CheckoutData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutData value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutData value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultList')  MembershipPlan? plan, @JsonKey(name: 'add_on_packages')  List<AddOnPlan>? addOnPackages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutData() when $default != null:
return $default(_that.plan,_that.addOnPackages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'resultList')  MembershipPlan? plan, @JsonKey(name: 'add_on_packages')  List<AddOnPlan>? addOnPackages)  $default,) {final _that = this;
switch (_that) {
case _CheckoutData():
return $default(_that.plan,_that.addOnPackages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'resultList')  MembershipPlan? plan, @JsonKey(name: 'add_on_packages')  List<AddOnPlan>? addOnPackages)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutData() when $default != null:
return $default(_that.plan,_that.addOnPackages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutData implements CheckoutData {
  const _CheckoutData({@JsonKey(name: 'resultList') this.plan, @JsonKey(name: 'add_on_packages')  List<AddOnPlan>? addOnPackages}): _addOnPackages = addOnPackages;
  factory _CheckoutData.fromJson(Map<String, dynamic> json) => _$CheckoutDataFromJson(json);

@override@JsonKey(name: 'resultList') final  MembershipPlan? plan;
 final  List<AddOnPlan>? _addOnPackages;
@override@JsonKey(name: 'add_on_packages') List<AddOnPlan>? get addOnPackages {
  final value = _addOnPackages;
  if (value == null) return null;
  if (_addOnPackages is EqualUnmodifiableListView) return _addOnPackages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CheckoutData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutDataCopyWith<_CheckoutData> get copyWith => __$CheckoutDataCopyWithImpl<_CheckoutData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutData&&(identical(other.plan, plan) || other.plan == plan)&&const DeepCollectionEquality().equals(other.addOnPackages, _addOnPackages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,plan,const DeepCollectionEquality().hash(_addOnPackages));
}

@override
String toString() {
    return 'CheckoutData(plan: $plan, addOnPackages: $addOnPackages)';
}


}

/// @nodoc
abstract mixin class _$CheckoutDataCopyWith<$Res> implements $CheckoutDataCopyWith<$Res> {
  factory _$CheckoutDataCopyWith(_CheckoutData value, $Res Function(_CheckoutData) _then) = __$CheckoutDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'resultList') MembershipPlan? plan,@JsonKey(name: 'add_on_packages') List<AddOnPlan>? addOnPackages
});


@override $MembershipPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class __$CheckoutDataCopyWithImpl<$Res>
    implements _$CheckoutDataCopyWith<$Res> {
  __$CheckoutDataCopyWithImpl(this._self, this._then);

  final _CheckoutData _self;
  final $Res Function(_CheckoutData) _then;

/// Create a copy of CheckoutData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,Object? addOnPackages = freezed,}) {
  return _then(_CheckoutData(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as MembershipPlan?,addOnPackages: freezed == addOnPackages ? _self._addOnPackages : addOnPackages // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>?,
  ));
}

/// Create a copy of CheckoutData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $MembershipPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// @nodoc
mixin _$PlanHistoryResponseModel {

 int? get code; String? get status; String? get message; PlanHistoryData? get data;
/// Create a copy of PlanHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanHistoryResponseModelCopyWith<PlanHistoryResponseModel> get copyWith => _$PlanHistoryResponseModelCopyWithImpl<PlanHistoryResponseModel>(this as PlanHistoryResponseModel, _$identity);

  /// Serializes this PlanHistoryResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanHistoryResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanHistoryResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanHistoryResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as PlanHistoryResponseModel;
  return 'PlanHistoryResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $PlanHistoryResponseModelCopyWith<$Res>  {
  factory $PlanHistoryResponseModelCopyWith(PlanHistoryResponseModel value, $Res Function(PlanHistoryResponseModel) _then) = _$PlanHistoryResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, PlanHistoryData? data
});


$PlanHistoryDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$PlanHistoryResponseModelCopyWithImpl<$Res>
    implements $PlanHistoryResponseModelCopyWith<$Res> {
  _$PlanHistoryResponseModelCopyWithImpl(this._self, this._then);

  final PlanHistoryResponseModel _self;
  final $Res Function(PlanHistoryResponseModel) _then;

/// Create a copy of PlanHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(PlanHistoryResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlanHistoryData?,
  ));
}
/// Create a copy of PlanHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanHistoryDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PlanHistoryDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanHistoryResponseModel].
extension PlanHistoryResponseModelPatterns on PlanHistoryResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanHistoryResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanHistoryResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanHistoryResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanHistoryResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  PlanHistoryData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  PlanHistoryData? data)  $default,) {final _that = this;
switch (_that) {
case _PlanHistoryResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  PlanHistoryData? data)?  $default,) {final _that = this;
switch (_that) {
case _PlanHistoryResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanHistoryResponseModel implements PlanHistoryResponseModel {
  const _PlanHistoryResponseModel({this.code, this.status, this.message, this.data});
  factory _PlanHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$PlanHistoryResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  PlanHistoryData? data;

/// Create a copy of PlanHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanHistoryResponseModelCopyWith<_PlanHistoryResponseModel> get copyWith => __$PlanHistoryResponseModelCopyWithImpl<_PlanHistoryResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanHistoryResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanHistoryResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'PlanHistoryResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PlanHistoryResponseModelCopyWith<$Res> implements $PlanHistoryResponseModelCopyWith<$Res> {
  factory _$PlanHistoryResponseModelCopyWith(_PlanHistoryResponseModel value, $Res Function(_PlanHistoryResponseModel) _then) = __$PlanHistoryResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, PlanHistoryData? data
});


@override $PlanHistoryDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$PlanHistoryResponseModelCopyWithImpl<$Res>
    implements _$PlanHistoryResponseModelCopyWith<$Res> {
  __$PlanHistoryResponseModelCopyWithImpl(this._self, this._then);

  final _PlanHistoryResponseModel _self;
  final $Res Function(_PlanHistoryResponseModel) _then;

/// Create a copy of PlanHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_PlanHistoryResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlanHistoryData?,
  ));
}

/// Create a copy of PlanHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanHistoryDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PlanHistoryDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$PlanHistoryData {

 int? get resultCount; List<CurrentPlan>? get resultList;
/// Create a copy of PlanHistoryData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanHistoryDataCopyWith<PlanHistoryData> get copyWith => _$PlanHistoryDataCopyWithImpl<PlanHistoryData>(this as PlanHistoryData, _$identity);

  /// Serializes this PlanHistoryData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanHistoryData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanHistoryData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultList, _this.resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanHistoryData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultList));
}

@override
String toString() {
  final _this = this as PlanHistoryData;
  return 'PlanHistoryData(resultCount: ${_this.resultCount}, resultList: ${_this.resultList})';
}


}

/// @nodoc
abstract mixin class $PlanHistoryDataCopyWith<$Res>  {
  factory $PlanHistoryDataCopyWith(PlanHistoryData value, $Res Function(PlanHistoryData) _then) = _$PlanHistoryDataCopyWithImpl;
@useResult
$Res call({
 int? resultCount, List<CurrentPlan>? resultList
});




}
/// @nodoc
class _$PlanHistoryDataCopyWithImpl<$Res>
    implements $PlanHistoryDataCopyWith<$Res> {
  _$PlanHistoryDataCopyWithImpl(this._self, this._then);

  final PlanHistoryData _self;
  final $Res Function(PlanHistoryData) _then;

/// Create a copy of PlanHistoryData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(PlanHistoryData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self.resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<CurrentPlan>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanHistoryData].
extension PlanHistoryDataPatterns on PlanHistoryData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanHistoryData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanHistoryData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanHistoryData value)  $default,){
final _that = this;
switch (_that) {
case _PlanHistoryData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanHistoryData value)?  $default,){
final _that = this;
switch (_that) {
case _PlanHistoryData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? resultCount,  List<CurrentPlan>? resultList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanHistoryData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? resultCount,  List<CurrentPlan>? resultList)  $default,) {final _that = this;
switch (_that) {
case _PlanHistoryData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? resultCount,  List<CurrentPlan>? resultList)?  $default,) {final _that = this;
switch (_that) {
case _PlanHistoryData() when $default != null:
return $default(_that.resultCount,_that.resultList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanHistoryData implements PlanHistoryData {
  const _PlanHistoryData({this.resultCount,  List<CurrentPlan>? resultList}): _resultList = resultList;
  factory _PlanHistoryData.fromJson(Map<String, dynamic> json) => _$PlanHistoryDataFromJson(json);

@override final  int? resultCount;
 final  List<CurrentPlan>? _resultList;
@override List<CurrentPlan>? get resultList {
  final value = _resultList;
  if (value == null) return null;
  if (_resultList is EqualUnmodifiableListView) return _resultList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PlanHistoryData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanHistoryDataCopyWith<_PlanHistoryData> get copyWith => __$PlanHistoryDataCopyWithImpl<_PlanHistoryData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanHistoryDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanHistoryData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultList, _resultList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultList));
}

@override
String toString() {
    return 'PlanHistoryData(resultCount: $resultCount, resultList: $resultList)';
}


}

/// @nodoc
abstract mixin class _$PlanHistoryDataCopyWith<$Res> implements $PlanHistoryDataCopyWith<$Res> {
  factory _$PlanHistoryDataCopyWith(_PlanHistoryData value, $Res Function(_PlanHistoryData) _then) = __$PlanHistoryDataCopyWithImpl;
@override @useResult
$Res call({
 int? resultCount, List<CurrentPlan>? resultList
});




}
/// @nodoc
class __$PlanHistoryDataCopyWithImpl<$Res>
    implements _$PlanHistoryDataCopyWith<$Res> {
  __$PlanHistoryDataCopyWithImpl(this._self, this._then);

  final _PlanHistoryData _self;
  final $Res Function(_PlanHistoryData) _then;

/// Create a copy of PlanHistoryData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultList = freezed,}) {
  return _then(_PlanHistoryData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultList: freezed == resultList ? _self._resultList : resultList // ignore: cast_nullable_to_non_nullable
as List<CurrentPlan>?,
  ));
}


}


/// @nodoc
mixin _$CalculatePlanResponseModel {

 int? get code; String? get status; String? get message; CalculatePlanData? get data;
/// Create a copy of CalculatePlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatePlanResponseModelCopyWith<CalculatePlanResponseModel> get copyWith => _$CalculatePlanResponseModelCopyWithImpl<CalculatePlanResponseModel>(this as CalculatePlanResponseModel, _$identity);

  /// Serializes this CalculatePlanResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalculatePlanResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatePlanResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalculatePlanResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as CalculatePlanResponseModel;
  return 'CalculatePlanResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $CalculatePlanResponseModelCopyWith<$Res>  {
  factory $CalculatePlanResponseModelCopyWith(CalculatePlanResponseModel value, $Res Function(CalculatePlanResponseModel) _then) = _$CalculatePlanResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, CalculatePlanData? data
});


$CalculatePlanDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CalculatePlanResponseModelCopyWithImpl<$Res>
    implements $CalculatePlanResponseModelCopyWith<$Res> {
  _$CalculatePlanResponseModelCopyWithImpl(this._self, this._then);

  final CalculatePlanResponseModel _self;
  final $Res Function(CalculatePlanResponseModel) _then;

/// Create a copy of CalculatePlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(CalculatePlanResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CalculatePlanData?,
  ));
}
/// Create a copy of CalculatePlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalculatePlanDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CalculatePlanDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalculatePlanResponseModel].
extension CalculatePlanResponseModelPatterns on CalculatePlanResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculatePlanResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculatePlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculatePlanResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CalculatePlanResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculatePlanResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalculatePlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CalculatePlanData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatePlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  CalculatePlanData? data)  $default,) {final _that = this;
switch (_that) {
case _CalculatePlanResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  CalculatePlanData? data)?  $default,) {final _that = this;
switch (_that) {
case _CalculatePlanResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculatePlanResponseModel implements CalculatePlanResponseModel {
  const _CalculatePlanResponseModel({this.code, this.status, this.message, this.data});
  factory _CalculatePlanResponseModel.fromJson(Map<String, dynamic> json) => _$CalculatePlanResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  CalculatePlanData? data;

/// Create a copy of CalculatePlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatePlanResponseModelCopyWith<_CalculatePlanResponseModel> get copyWith => __$CalculatePlanResponseModelCopyWithImpl<_CalculatePlanResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculatePlanResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatePlanResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'CalculatePlanResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CalculatePlanResponseModelCopyWith<$Res> implements $CalculatePlanResponseModelCopyWith<$Res> {
  factory _$CalculatePlanResponseModelCopyWith(_CalculatePlanResponseModel value, $Res Function(_CalculatePlanResponseModel) _then) = __$CalculatePlanResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, CalculatePlanData? data
});


@override $CalculatePlanDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CalculatePlanResponseModelCopyWithImpl<$Res>
    implements _$CalculatePlanResponseModelCopyWith<$Res> {
  __$CalculatePlanResponseModelCopyWithImpl(this._self, this._then);

  final _CalculatePlanResponseModel _self;
  final $Res Function(_CalculatePlanResponseModel) _then;

/// Create a copy of CalculatePlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CalculatePlanResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CalculatePlanData?,
  ));
}

/// Create a copy of CalculatePlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalculatePlanDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CalculatePlanDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CalculatePlanData {

 bool? get success; String? get currency;@JsonKey(name: 'plan_amount') dynamic get planAmount;@JsonKey(name: 'plan_discount') dynamic get planDiscount;@JsonKey(name: 'addon_total') dynamic get addonTotal;@JsonKey(name: 'coupon_discount') dynamic get couponDiscount;@JsonKey(name: 'tax_amount') dynamic get taxAmount;@JsonKey(name: 'grand_total') dynamic get grandTotal;@JsonKey(name: 'coupon_applied') bool? get couponApplied;@JsonKey(name: 'coupon_code') String? get couponCode;@JsonKey(name: 'tax_name') String? get taxName;@JsonKey(name: 'tax_applicable') String? get taxApplicable;@JsonKey(name: 'tax_percentage') dynamic get taxPercentage; String? get message;
/// Create a copy of CalculatePlanData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatePlanDataCopyWith<CalculatePlanData> get copyWith => _$CalculatePlanDataCopyWithImpl<CalculatePlanData>(this as CalculatePlanData, _$identity);

  /// Serializes this CalculatePlanData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalculatePlanData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatePlanData&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&const DeepCollectionEquality().equals(other.planAmount, _this.planAmount)&&const DeepCollectionEquality().equals(other.planDiscount, _this.planDiscount)&&const DeepCollectionEquality().equals(other.addonTotal, _this.addonTotal)&&const DeepCollectionEquality().equals(other.couponDiscount, _this.couponDiscount)&&const DeepCollectionEquality().equals(other.taxAmount, _this.taxAmount)&&const DeepCollectionEquality().equals(other.grandTotal, _this.grandTotal)&&(identical(other.couponApplied, _this.couponApplied) || other.couponApplied == _this.couponApplied)&&(identical(other.couponCode, _this.couponCode) || other.couponCode == _this.couponCode)&&(identical(other.taxName, _this.taxName) || other.taxName == _this.taxName)&&(identical(other.taxApplicable, _this.taxApplicable) || other.taxApplicable == _this.taxApplicable)&&const DeepCollectionEquality().equals(other.taxPercentage, _this.taxPercentage)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalculatePlanData;
  return Object.hash(runtimeType,_this.success,_this.currency,const DeepCollectionEquality().hash(_this.planAmount),const DeepCollectionEquality().hash(_this.planDiscount),const DeepCollectionEquality().hash(_this.addonTotal),const DeepCollectionEquality().hash(_this.couponDiscount),const DeepCollectionEquality().hash(_this.taxAmount),const DeepCollectionEquality().hash(_this.grandTotal),_this.couponApplied,_this.couponCode,_this.taxName,_this.taxApplicable,const DeepCollectionEquality().hash(_this.taxPercentage),_this.message);
}

@override
String toString() {
  final _this = this as CalculatePlanData;
  return 'CalculatePlanData(success: ${_this.success}, currency: ${_this.currency}, planAmount: ${_this.planAmount}, planDiscount: ${_this.planDiscount}, addonTotal: ${_this.addonTotal}, couponDiscount: ${_this.couponDiscount}, taxAmount: ${_this.taxAmount}, grandTotal: ${_this.grandTotal}, couponApplied: ${_this.couponApplied}, couponCode: ${_this.couponCode}, taxName: ${_this.taxName}, taxApplicable: ${_this.taxApplicable}, taxPercentage: ${_this.taxPercentage}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $CalculatePlanDataCopyWith<$Res>  {
  factory $CalculatePlanDataCopyWith(CalculatePlanData value, $Res Function(CalculatePlanData) _then) = _$CalculatePlanDataCopyWithImpl;
@useResult
$Res call({
 bool? success, String? currency,@JsonKey(name: 'plan_amount') dynamic planAmount,@JsonKey(name: 'plan_discount') dynamic planDiscount,@JsonKey(name: 'addon_total') dynamic addonTotal,@JsonKey(name: 'coupon_discount') dynamic couponDiscount,@JsonKey(name: 'tax_amount') dynamic taxAmount,@JsonKey(name: 'grand_total') dynamic grandTotal,@JsonKey(name: 'coupon_applied') bool? couponApplied,@JsonKey(name: 'coupon_code') String? couponCode,@JsonKey(name: 'tax_name') String? taxName,@JsonKey(name: 'tax_applicable') String? taxApplicable,@JsonKey(name: 'tax_percentage') dynamic taxPercentage, String? message
});




}
/// @nodoc
class _$CalculatePlanDataCopyWithImpl<$Res>
    implements $CalculatePlanDataCopyWith<$Res> {
  _$CalculatePlanDataCopyWithImpl(this._self, this._then);

  final CalculatePlanData _self;
  final $Res Function(CalculatePlanData) _then;

/// Create a copy of CalculatePlanData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? currency = freezed,Object? planAmount = freezed,Object? planDiscount = freezed,Object? addonTotal = freezed,Object? couponDiscount = freezed,Object? taxAmount = freezed,Object? grandTotal = freezed,Object? couponApplied = freezed,Object? couponCode = freezed,Object? taxName = freezed,Object? taxApplicable = freezed,Object? taxPercentage = freezed,Object? message = freezed,}) {
  return _then(CalculatePlanData(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,planAmount: freezed == planAmount ? _self.planAmount : planAmount // ignore: cast_nullable_to_non_nullable
as dynamic,planDiscount: freezed == planDiscount ? _self.planDiscount : planDiscount // ignore: cast_nullable_to_non_nullable
as dynamic,addonTotal: freezed == addonTotal ? _self.addonTotal : addonTotal // ignore: cast_nullable_to_non_nullable
as dynamic,couponDiscount: freezed == couponDiscount ? _self.couponDiscount : couponDiscount // ignore: cast_nullable_to_non_nullable
as dynamic,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as dynamic,grandTotal: freezed == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as dynamic,couponApplied: freezed == couponApplied ? _self.couponApplied : couponApplied // ignore: cast_nullable_to_non_nullable
as bool?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,taxName: freezed == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String?,taxApplicable: freezed == taxApplicable ? _self.taxApplicable : taxApplicable // ignore: cast_nullable_to_non_nullable
as String?,taxPercentage: freezed == taxPercentage ? _self.taxPercentage : taxPercentage // ignore: cast_nullable_to_non_nullable
as dynamic,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculatePlanData].
extension CalculatePlanDataPatterns on CalculatePlanData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculatePlanData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculatePlanData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculatePlanData value)  $default,){
final _that = this;
switch (_that) {
case _CalculatePlanData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculatePlanData value)?  $default,){
final _that = this;
switch (_that) {
case _CalculatePlanData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? success,  String? currency, @JsonKey(name: 'plan_amount')  dynamic planAmount, @JsonKey(name: 'plan_discount')  dynamic planDiscount, @JsonKey(name: 'addon_total')  dynamic addonTotal, @JsonKey(name: 'coupon_discount')  dynamic couponDiscount, @JsonKey(name: 'tax_amount')  dynamic taxAmount, @JsonKey(name: 'grand_total')  dynamic grandTotal, @JsonKey(name: 'coupon_applied')  bool? couponApplied, @JsonKey(name: 'coupon_code')  String? couponCode, @JsonKey(name: 'tax_name')  String? taxName, @JsonKey(name: 'tax_applicable')  String? taxApplicable, @JsonKey(name: 'tax_percentage')  dynamic taxPercentage,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatePlanData() when $default != null:
return $default(_that.success,_that.currency,_that.planAmount,_that.planDiscount,_that.addonTotal,_that.couponDiscount,_that.taxAmount,_that.grandTotal,_that.couponApplied,_that.couponCode,_that.taxName,_that.taxApplicable,_that.taxPercentage,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? success,  String? currency, @JsonKey(name: 'plan_amount')  dynamic planAmount, @JsonKey(name: 'plan_discount')  dynamic planDiscount, @JsonKey(name: 'addon_total')  dynamic addonTotal, @JsonKey(name: 'coupon_discount')  dynamic couponDiscount, @JsonKey(name: 'tax_amount')  dynamic taxAmount, @JsonKey(name: 'grand_total')  dynamic grandTotal, @JsonKey(name: 'coupon_applied')  bool? couponApplied, @JsonKey(name: 'coupon_code')  String? couponCode, @JsonKey(name: 'tax_name')  String? taxName, @JsonKey(name: 'tax_applicable')  String? taxApplicable, @JsonKey(name: 'tax_percentage')  dynamic taxPercentage,  String? message)  $default,) {final _that = this;
switch (_that) {
case _CalculatePlanData():
return $default(_that.success,_that.currency,_that.planAmount,_that.planDiscount,_that.addonTotal,_that.couponDiscount,_that.taxAmount,_that.grandTotal,_that.couponApplied,_that.couponCode,_that.taxName,_that.taxApplicable,_that.taxPercentage,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? success,  String? currency, @JsonKey(name: 'plan_amount')  dynamic planAmount, @JsonKey(name: 'plan_discount')  dynamic planDiscount, @JsonKey(name: 'addon_total')  dynamic addonTotal, @JsonKey(name: 'coupon_discount')  dynamic couponDiscount, @JsonKey(name: 'tax_amount')  dynamic taxAmount, @JsonKey(name: 'grand_total')  dynamic grandTotal, @JsonKey(name: 'coupon_applied')  bool? couponApplied, @JsonKey(name: 'coupon_code')  String? couponCode, @JsonKey(name: 'tax_name')  String? taxName, @JsonKey(name: 'tax_applicable')  String? taxApplicable, @JsonKey(name: 'tax_percentage')  dynamic taxPercentage,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _CalculatePlanData() when $default != null:
return $default(_that.success,_that.currency,_that.planAmount,_that.planDiscount,_that.addonTotal,_that.couponDiscount,_that.taxAmount,_that.grandTotal,_that.couponApplied,_that.couponCode,_that.taxName,_that.taxApplicable,_that.taxPercentage,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculatePlanData implements CalculatePlanData {
  const _CalculatePlanData({this.success, this.currency, @JsonKey(name: 'plan_amount') this.planAmount, @JsonKey(name: 'plan_discount') this.planDiscount, @JsonKey(name: 'addon_total') this.addonTotal, @JsonKey(name: 'coupon_discount') this.couponDiscount, @JsonKey(name: 'tax_amount') this.taxAmount, @JsonKey(name: 'grand_total') this.grandTotal, @JsonKey(name: 'coupon_applied') this.couponApplied, @JsonKey(name: 'coupon_code') this.couponCode, @JsonKey(name: 'tax_name') this.taxName, @JsonKey(name: 'tax_applicable') this.taxApplicable, @JsonKey(name: 'tax_percentage') this.taxPercentage, this.message});
  factory _CalculatePlanData.fromJson(Map<String, dynamic> json) => _$CalculatePlanDataFromJson(json);

@override final  bool? success;
@override final  String? currency;
@override@JsonKey(name: 'plan_amount') final  dynamic planAmount;
@override@JsonKey(name: 'plan_discount') final  dynamic planDiscount;
@override@JsonKey(name: 'addon_total') final  dynamic addonTotal;
@override@JsonKey(name: 'coupon_discount') final  dynamic couponDiscount;
@override@JsonKey(name: 'tax_amount') final  dynamic taxAmount;
@override@JsonKey(name: 'grand_total') final  dynamic grandTotal;
@override@JsonKey(name: 'coupon_applied') final  bool? couponApplied;
@override@JsonKey(name: 'coupon_code') final  String? couponCode;
@override@JsonKey(name: 'tax_name') final  String? taxName;
@override@JsonKey(name: 'tax_applicable') final  String? taxApplicable;
@override@JsonKey(name: 'tax_percentage') final  dynamic taxPercentage;
@override final  String? message;

/// Create a copy of CalculatePlanData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatePlanDataCopyWith<_CalculatePlanData> get copyWith => __$CalculatePlanDataCopyWithImpl<_CalculatePlanData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculatePlanDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatePlanData&&(identical(other.success, success) || other.success == success)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.planAmount, planAmount)&&const DeepCollectionEquality().equals(other.planDiscount, planDiscount)&&const DeepCollectionEquality().equals(other.addonTotal, addonTotal)&&const DeepCollectionEquality().equals(other.couponDiscount, couponDiscount)&&const DeepCollectionEquality().equals(other.taxAmount, taxAmount)&&const DeepCollectionEquality().equals(other.grandTotal, grandTotal)&&(identical(other.couponApplied, couponApplied) || other.couponApplied == couponApplied)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxApplicable, taxApplicable) || other.taxApplicable == taxApplicable)&&const DeepCollectionEquality().equals(other.taxPercentage, taxPercentage)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,success,currency,const DeepCollectionEquality().hash(planAmount),const DeepCollectionEquality().hash(planDiscount),const DeepCollectionEquality().hash(addonTotal),const DeepCollectionEquality().hash(couponDiscount),const DeepCollectionEquality().hash(taxAmount),const DeepCollectionEquality().hash(grandTotal),couponApplied,couponCode,taxName,taxApplicable,const DeepCollectionEquality().hash(taxPercentage),message);
}

@override
String toString() {
    return 'CalculatePlanData(success: $success, currency: $currency, planAmount: $planAmount, planDiscount: $planDiscount, addonTotal: $addonTotal, couponDiscount: $couponDiscount, taxAmount: $taxAmount, grandTotal: $grandTotal, couponApplied: $couponApplied, couponCode: $couponCode, taxName: $taxName, taxApplicable: $taxApplicable, taxPercentage: $taxPercentage, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CalculatePlanDataCopyWith<$Res> implements $CalculatePlanDataCopyWith<$Res> {
  factory _$CalculatePlanDataCopyWith(_CalculatePlanData value, $Res Function(_CalculatePlanData) _then) = __$CalculatePlanDataCopyWithImpl;
@override @useResult
$Res call({
 bool? success, String? currency,@JsonKey(name: 'plan_amount') dynamic planAmount,@JsonKey(name: 'plan_discount') dynamic planDiscount,@JsonKey(name: 'addon_total') dynamic addonTotal,@JsonKey(name: 'coupon_discount') dynamic couponDiscount,@JsonKey(name: 'tax_amount') dynamic taxAmount,@JsonKey(name: 'grand_total') dynamic grandTotal,@JsonKey(name: 'coupon_applied') bool? couponApplied,@JsonKey(name: 'coupon_code') String? couponCode,@JsonKey(name: 'tax_name') String? taxName,@JsonKey(name: 'tax_applicable') String? taxApplicable,@JsonKey(name: 'tax_percentage') dynamic taxPercentage, String? message
});




}
/// @nodoc
class __$CalculatePlanDataCopyWithImpl<$Res>
    implements _$CalculatePlanDataCopyWith<$Res> {
  __$CalculatePlanDataCopyWithImpl(this._self, this._then);

  final _CalculatePlanData _self;
  final $Res Function(_CalculatePlanData) _then;

/// Create a copy of CalculatePlanData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? currency = freezed,Object? planAmount = freezed,Object? planDiscount = freezed,Object? addonTotal = freezed,Object? couponDiscount = freezed,Object? taxAmount = freezed,Object? grandTotal = freezed,Object? couponApplied = freezed,Object? couponCode = freezed,Object? taxName = freezed,Object? taxApplicable = freezed,Object? taxPercentage = freezed,Object? message = freezed,}) {
  return _then(_CalculatePlanData(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,planAmount: freezed == planAmount ? _self.planAmount : planAmount // ignore: cast_nullable_to_non_nullable
as dynamic,planDiscount: freezed == planDiscount ? _self.planDiscount : planDiscount // ignore: cast_nullable_to_non_nullable
as dynamic,addonTotal: freezed == addonTotal ? _self.addonTotal : addonTotal // ignore: cast_nullable_to_non_nullable
as dynamic,couponDiscount: freezed == couponDiscount ? _self.couponDiscount : couponDiscount // ignore: cast_nullable_to_non_nullable
as dynamic,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as dynamic,grandTotal: freezed == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as dynamic,couponApplied: freezed == couponApplied ? _self.couponApplied : couponApplied // ignore: cast_nullable_to_non_nullable
as bool?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,taxName: freezed == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String?,taxApplicable: freezed == taxApplicable ? _self.taxApplicable : taxApplicable // ignore: cast_nullable_to_non_nullable
as String?,taxPercentage: freezed == taxPercentage ? _self.taxPercentage : taxPercentage // ignore: cast_nullable_to_non_nullable
as dynamic,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
