// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentState {

 bool get isLoading; MembershipPlan? get selectedPlan; List<CouponData> get coupons; Set<int> get selectedAddonIds; List<AddOnPlan> get addOnPlans; int get selectedCouponIndex; String get appliedCouponCode; double get baseAmount; double get discountAmount; double get addonAmount; double get couponAmount; double get taxAmount; double get finalAmount; String get taxApplicable; String get taxName; int get serviceTax; OfflinePayment? get offlinePayment; PaymentMethods? get paymentMethods;
/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStateCopyWith<PaymentState> get copyWith => _$PaymentStateCopyWithImpl<PaymentState>(this as PaymentState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaymentState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentState&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.selectedPlan, _this.selectedPlan) || other.selectedPlan == _this.selectedPlan)&&const DeepCollectionEquality().equals(other.coupons, _this.coupons)&&const DeepCollectionEquality().equals(other.selectedAddonIds, _this.selectedAddonIds)&&const DeepCollectionEquality().equals(other.addOnPlans, _this.addOnPlans)&&(identical(other.selectedCouponIndex, _this.selectedCouponIndex) || other.selectedCouponIndex == _this.selectedCouponIndex)&&(identical(other.appliedCouponCode, _this.appliedCouponCode) || other.appliedCouponCode == _this.appliedCouponCode)&&(identical(other.baseAmount, _this.baseAmount) || other.baseAmount == _this.baseAmount)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.addonAmount, _this.addonAmount) || other.addonAmount == _this.addonAmount)&&(identical(other.couponAmount, _this.couponAmount) || other.couponAmount == _this.couponAmount)&&(identical(other.taxAmount, _this.taxAmount) || other.taxAmount == _this.taxAmount)&&(identical(other.finalAmount, _this.finalAmount) || other.finalAmount == _this.finalAmount)&&(identical(other.taxApplicable, _this.taxApplicable) || other.taxApplicable == _this.taxApplicable)&&(identical(other.taxName, _this.taxName) || other.taxName == _this.taxName)&&(identical(other.serviceTax, _this.serviceTax) || other.serviceTax == _this.serviceTax)&&(identical(other.offlinePayment, _this.offlinePayment) || other.offlinePayment == _this.offlinePayment)&&(identical(other.paymentMethods, _this.paymentMethods) || other.paymentMethods == _this.paymentMethods));
}


@override
int get hashCode {
  final _this = this as PaymentState;
  return Object.hash(runtimeType,_this.isLoading,_this.selectedPlan,const DeepCollectionEquality().hash(_this.coupons),const DeepCollectionEquality().hash(_this.selectedAddonIds),const DeepCollectionEquality().hash(_this.addOnPlans),_this.selectedCouponIndex,_this.appliedCouponCode,_this.baseAmount,_this.discountAmount,_this.addonAmount,_this.couponAmount,_this.taxAmount,_this.finalAmount,_this.taxApplicable,_this.taxName,_this.serviceTax,_this.offlinePayment,_this.paymentMethods);
}

@override
String toString() {
  final _this = this as PaymentState;
  return 'PaymentState(isLoading: ${_this.isLoading}, selectedPlan: ${_this.selectedPlan}, coupons: ${_this.coupons}, selectedAddonIds: ${_this.selectedAddonIds}, addOnPlans: ${_this.addOnPlans}, selectedCouponIndex: ${_this.selectedCouponIndex}, appliedCouponCode: ${_this.appliedCouponCode}, baseAmount: ${_this.baseAmount}, discountAmount: ${_this.discountAmount}, addonAmount: ${_this.addonAmount}, couponAmount: ${_this.couponAmount}, taxAmount: ${_this.taxAmount}, finalAmount: ${_this.finalAmount}, taxApplicable: ${_this.taxApplicable}, taxName: ${_this.taxName}, serviceTax: ${_this.serviceTax}, offlinePayment: ${_this.offlinePayment}, paymentMethods: ${_this.paymentMethods})';
}


}

/// @nodoc
abstract mixin class $PaymentStateCopyWith<$Res>  {
  factory $PaymentStateCopyWith(PaymentState value, $Res Function(PaymentState) _then) = _$PaymentStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, MembershipPlan? selectedPlan, List<CouponData> coupons, Set<int> selectedAddonIds, List<AddOnPlan> addOnPlans, int selectedCouponIndex, String appliedCouponCode, double baseAmount, double discountAmount, double addonAmount, double couponAmount, double taxAmount, double finalAmount, String taxApplicable, String taxName, int serviceTax, OfflinePayment? offlinePayment, PaymentMethods? paymentMethods
});


$MembershipPlanCopyWith<$Res>? get selectedPlan;$OfflinePaymentCopyWith<$Res>? get offlinePayment;$PaymentMethodsCopyWith<$Res>? get paymentMethods;

}
/// @nodoc
class _$PaymentStateCopyWithImpl<$Res>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._self, this._then);

  final PaymentState _self;
  final $Res Function(PaymentState) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? selectedPlan = freezed,Object? coupons = null,Object? selectedAddonIds = null,Object? addOnPlans = null,Object? selectedCouponIndex = null,Object? appliedCouponCode = null,Object? baseAmount = null,Object? discountAmount = null,Object? addonAmount = null,Object? couponAmount = null,Object? taxAmount = null,Object? finalAmount = null,Object? taxApplicable = null,Object? taxName = null,Object? serviceTax = null,Object? offlinePayment = freezed,Object? paymentMethods = freezed,}) {
  return _then(PaymentState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedPlan: freezed == selectedPlan ? _self.selectedPlan : selectedPlan // ignore: cast_nullable_to_non_nullable
as MembershipPlan?,coupons: null == coupons ? _self.coupons : coupons // ignore: cast_nullable_to_non_nullable
as List<CouponData>,selectedAddonIds: null == selectedAddonIds ? _self.selectedAddonIds : selectedAddonIds // ignore: cast_nullable_to_non_nullable
as Set<int>,addOnPlans: null == addOnPlans ? _self.addOnPlans : addOnPlans // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>,selectedCouponIndex: null == selectedCouponIndex ? _self.selectedCouponIndex : selectedCouponIndex // ignore: cast_nullable_to_non_nullable
as int,appliedCouponCode: null == appliedCouponCode ? _self.appliedCouponCode : appliedCouponCode // ignore: cast_nullable_to_non_nullable
as String,baseAmount: null == baseAmount ? _self.baseAmount : baseAmount // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,addonAmount: null == addonAmount ? _self.addonAmount : addonAmount // ignore: cast_nullable_to_non_nullable
as double,couponAmount: null == couponAmount ? _self.couponAmount : couponAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,finalAmount: null == finalAmount ? _self.finalAmount : finalAmount // ignore: cast_nullable_to_non_nullable
as double,taxApplicable: null == taxApplicable ? _self.taxApplicable : taxApplicable // ignore: cast_nullable_to_non_nullable
as String,taxName: null == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String,serviceTax: null == serviceTax ? _self.serviceTax : serviceTax // ignore: cast_nullable_to_non_nullable
as int,offlinePayment: freezed == offlinePayment ? _self.offlinePayment : offlinePayment // ignore: cast_nullable_to_non_nullable
as OfflinePayment?,paymentMethods: freezed == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as PaymentMethods?,
  ));
}
/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<$Res>? get selectedPlan {
    if (_self.selectedPlan == null) {
    return null;
  }

  return $MembershipPlanCopyWith<$Res>(_self.selectedPlan!, (value) {
    return _then(_self.copyWith(selectedPlan: value));
  });
}/// Create a copy of PaymentState
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
}/// Create a copy of PaymentState
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


/// Adds pattern-matching-related methods to [PaymentState].
extension PaymentStatePatterns on PaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentState value)  $default,){
final _that = this;
switch (_that) {
case _PaymentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentState value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  MembershipPlan? selectedPlan,  List<CouponData> coupons,  Set<int> selectedAddonIds,  List<AddOnPlan> addOnPlans,  int selectedCouponIndex,  String appliedCouponCode,  double baseAmount,  double discountAmount,  double addonAmount,  double couponAmount,  double taxAmount,  double finalAmount,  String taxApplicable,  String taxName,  int serviceTax,  OfflinePayment? offlinePayment,  PaymentMethods? paymentMethods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
return $default(_that.isLoading,_that.selectedPlan,_that.coupons,_that.selectedAddonIds,_that.addOnPlans,_that.selectedCouponIndex,_that.appliedCouponCode,_that.baseAmount,_that.discountAmount,_that.addonAmount,_that.couponAmount,_that.taxAmount,_that.finalAmount,_that.taxApplicable,_that.taxName,_that.serviceTax,_that.offlinePayment,_that.paymentMethods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  MembershipPlan? selectedPlan,  List<CouponData> coupons,  Set<int> selectedAddonIds,  List<AddOnPlan> addOnPlans,  int selectedCouponIndex,  String appliedCouponCode,  double baseAmount,  double discountAmount,  double addonAmount,  double couponAmount,  double taxAmount,  double finalAmount,  String taxApplicable,  String taxName,  int serviceTax,  OfflinePayment? offlinePayment,  PaymentMethods? paymentMethods)  $default,) {final _that = this;
switch (_that) {
case _PaymentState():
return $default(_that.isLoading,_that.selectedPlan,_that.coupons,_that.selectedAddonIds,_that.addOnPlans,_that.selectedCouponIndex,_that.appliedCouponCode,_that.baseAmount,_that.discountAmount,_that.addonAmount,_that.couponAmount,_that.taxAmount,_that.finalAmount,_that.taxApplicable,_that.taxName,_that.serviceTax,_that.offlinePayment,_that.paymentMethods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  MembershipPlan? selectedPlan,  List<CouponData> coupons,  Set<int> selectedAddonIds,  List<AddOnPlan> addOnPlans,  int selectedCouponIndex,  String appliedCouponCode,  double baseAmount,  double discountAmount,  double addonAmount,  double couponAmount,  double taxAmount,  double finalAmount,  String taxApplicable,  String taxName,  int serviceTax,  OfflinePayment? offlinePayment,  PaymentMethods? paymentMethods)?  $default,) {final _that = this;
switch (_that) {
case _PaymentState() when $default != null:
return $default(_that.isLoading,_that.selectedPlan,_that.coupons,_that.selectedAddonIds,_that.addOnPlans,_that.selectedCouponIndex,_that.appliedCouponCode,_that.baseAmount,_that.discountAmount,_that.addonAmount,_that.couponAmount,_that.taxAmount,_that.finalAmount,_that.taxApplicable,_that.taxName,_that.serviceTax,_that.offlinePayment,_that.paymentMethods);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentState implements PaymentState {
  const _PaymentState({this.isLoading = false, this.selectedPlan,  List<CouponData> coupons = const [],  Set<int> selectedAddonIds = const {},  List<AddOnPlan> addOnPlans = const [], this.selectedCouponIndex = -1, this.appliedCouponCode = "", this.baseAmount = 0.0, this.discountAmount = 0.0, this.addonAmount = 0.0, this.couponAmount = 0.0, this.taxAmount = 0.0, this.finalAmount = 0.0, this.taxApplicable = "No", this.taxName = "Tax", this.serviceTax = 0, this.offlinePayment, this.paymentMethods}): _coupons = coupons,_selectedAddonIds = selectedAddonIds,_addOnPlans = addOnPlans;
  

@override@JsonKey() final  bool isLoading;
@override final  MembershipPlan? selectedPlan;
 final  List<CouponData> _coupons;
@override@JsonKey() List<CouponData> get coupons {
  if (_coupons is EqualUnmodifiableListView) return _coupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coupons);
}

 final  Set<int> _selectedAddonIds;
@override@JsonKey() Set<int> get selectedAddonIds {
  if (_selectedAddonIds is EqualUnmodifiableSetView) return _selectedAddonIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedAddonIds);
}

 final  List<AddOnPlan> _addOnPlans;
@override@JsonKey() List<AddOnPlan> get addOnPlans {
  if (_addOnPlans is EqualUnmodifiableListView) return _addOnPlans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addOnPlans);
}

@override@JsonKey() final  int selectedCouponIndex;
@override@JsonKey() final  String appliedCouponCode;
@override@JsonKey() final  double baseAmount;
@override@JsonKey() final  double discountAmount;
@override@JsonKey() final  double addonAmount;
@override@JsonKey() final  double couponAmount;
@override@JsonKey() final  double taxAmount;
@override@JsonKey() final  double finalAmount;
@override@JsonKey() final  String taxApplicable;
@override@JsonKey() final  String taxName;
@override@JsonKey() final  int serviceTax;
@override final  OfflinePayment? offlinePayment;
@override final  PaymentMethods? paymentMethods;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStateCopyWith<_PaymentState> get copyWith => __$PaymentStateCopyWithImpl<_PaymentState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedPlan, selectedPlan) || other.selectedPlan == selectedPlan)&&const DeepCollectionEquality().equals(other.coupons, _coupons)&&const DeepCollectionEquality().equals(other.selectedAddonIds, _selectedAddonIds)&&const DeepCollectionEquality().equals(other.addOnPlans, _addOnPlans)&&(identical(other.selectedCouponIndex, selectedCouponIndex) || other.selectedCouponIndex == selectedCouponIndex)&&(identical(other.appliedCouponCode, appliedCouponCode) || other.appliedCouponCode == appliedCouponCode)&&(identical(other.baseAmount, baseAmount) || other.baseAmount == baseAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.addonAmount, addonAmount) || other.addonAmount == addonAmount)&&(identical(other.couponAmount, couponAmount) || other.couponAmount == couponAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.finalAmount, finalAmount) || other.finalAmount == finalAmount)&&(identical(other.taxApplicable, taxApplicable) || other.taxApplicable == taxApplicable)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.serviceTax, serviceTax) || other.serviceTax == serviceTax)&&(identical(other.offlinePayment, offlinePayment) || other.offlinePayment == offlinePayment)&&(identical(other.paymentMethods, paymentMethods) || other.paymentMethods == paymentMethods));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isLoading,selectedPlan,const DeepCollectionEquality().hash(_coupons),const DeepCollectionEquality().hash(_selectedAddonIds),const DeepCollectionEquality().hash(_addOnPlans),selectedCouponIndex,appliedCouponCode,baseAmount,discountAmount,addonAmount,couponAmount,taxAmount,finalAmount,taxApplicable,taxName,serviceTax,offlinePayment,paymentMethods);
}

@override
String toString() {
    return 'PaymentState(isLoading: $isLoading, selectedPlan: $selectedPlan, coupons: $coupons, selectedAddonIds: $selectedAddonIds, addOnPlans: $addOnPlans, selectedCouponIndex: $selectedCouponIndex, appliedCouponCode: $appliedCouponCode, baseAmount: $baseAmount, discountAmount: $discountAmount, addonAmount: $addonAmount, couponAmount: $couponAmount, taxAmount: $taxAmount, finalAmount: $finalAmount, taxApplicable: $taxApplicable, taxName: $taxName, serviceTax: $serviceTax, offlinePayment: $offlinePayment, paymentMethods: $paymentMethods)';
}


}

/// @nodoc
abstract mixin class _$PaymentStateCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$PaymentStateCopyWith(_PaymentState value, $Res Function(_PaymentState) _then) = __$PaymentStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, MembershipPlan? selectedPlan, List<CouponData> coupons, Set<int> selectedAddonIds, List<AddOnPlan> addOnPlans, int selectedCouponIndex, String appliedCouponCode, double baseAmount, double discountAmount, double addonAmount, double couponAmount, double taxAmount, double finalAmount, String taxApplicable, String taxName, int serviceTax, OfflinePayment? offlinePayment, PaymentMethods? paymentMethods
});


@override $MembershipPlanCopyWith<$Res>? get selectedPlan;@override $OfflinePaymentCopyWith<$Res>? get offlinePayment;@override $PaymentMethodsCopyWith<$Res>? get paymentMethods;

}
/// @nodoc
class __$PaymentStateCopyWithImpl<$Res>
    implements _$PaymentStateCopyWith<$Res> {
  __$PaymentStateCopyWithImpl(this._self, this._then);

  final _PaymentState _self;
  final $Res Function(_PaymentState) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? selectedPlan = freezed,Object? coupons = null,Object? selectedAddonIds = null,Object? addOnPlans = null,Object? selectedCouponIndex = null,Object? appliedCouponCode = null,Object? baseAmount = null,Object? discountAmount = null,Object? addonAmount = null,Object? couponAmount = null,Object? taxAmount = null,Object? finalAmount = null,Object? taxApplicable = null,Object? taxName = null,Object? serviceTax = null,Object? offlinePayment = freezed,Object? paymentMethods = freezed,}) {
  return _then(_PaymentState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedPlan: freezed == selectedPlan ? _self.selectedPlan : selectedPlan // ignore: cast_nullable_to_non_nullable
as MembershipPlan?,coupons: null == coupons ? _self._coupons : coupons // ignore: cast_nullable_to_non_nullable
as List<CouponData>,selectedAddonIds: null == selectedAddonIds ? _self._selectedAddonIds : selectedAddonIds // ignore: cast_nullable_to_non_nullable
as Set<int>,addOnPlans: null == addOnPlans ? _self._addOnPlans : addOnPlans // ignore: cast_nullable_to_non_nullable
as List<AddOnPlan>,selectedCouponIndex: null == selectedCouponIndex ? _self.selectedCouponIndex : selectedCouponIndex // ignore: cast_nullable_to_non_nullable
as int,appliedCouponCode: null == appliedCouponCode ? _self.appliedCouponCode : appliedCouponCode // ignore: cast_nullable_to_non_nullable
as String,baseAmount: null == baseAmount ? _self.baseAmount : baseAmount // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,addonAmount: null == addonAmount ? _self.addonAmount : addonAmount // ignore: cast_nullable_to_non_nullable
as double,couponAmount: null == couponAmount ? _self.couponAmount : couponAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,finalAmount: null == finalAmount ? _self.finalAmount : finalAmount // ignore: cast_nullable_to_non_nullable
as double,taxApplicable: null == taxApplicable ? _self.taxApplicable : taxApplicable // ignore: cast_nullable_to_non_nullable
as String,taxName: null == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String,serviceTax: null == serviceTax ? _self.serviceTax : serviceTax // ignore: cast_nullable_to_non_nullable
as int,offlinePayment: freezed == offlinePayment ? _self.offlinePayment : offlinePayment // ignore: cast_nullable_to_non_nullable
as OfflinePayment?,paymentMethods: freezed == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as PaymentMethods?,
  ));
}

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<$Res>? get selectedPlan {
    if (_self.selectedPlan == null) {
    return null;
  }

  return $MembershipPlanCopyWith<$Res>(_self.selectedPlan!, (value) {
    return _then(_self.copyWith(selectedPlan: value));
  });
}/// Create a copy of PaymentState
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
}/// Create a copy of PaymentState
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

// dart format on
