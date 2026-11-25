// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropdown_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DropdownOptionModel {

 dynamic get id;@JsonKey(name: 'value') dynamic get val;
/// Create a copy of DropdownOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DropdownOptionModelCopyWith<DropdownOptionModel> get copyWith => _$DropdownOptionModelCopyWithImpl<DropdownOptionModel>(this as DropdownOptionModel, _$identity);

  /// Serializes this DropdownOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DropdownOptionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DropdownOptionModel&&const DeepCollectionEquality().equals(other.id, _this.id)&&const DeepCollectionEquality().equals(other.val, _this.val));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DropdownOptionModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.id),const DeepCollectionEquality().hash(_this.val));
}

@override
String toString() {
  final _this = this as DropdownOptionModel;
  return 'DropdownOptionModel(id: ${_this.id}, val: ${_this.val})';
}


}

/// @nodoc
abstract mixin class $DropdownOptionModelCopyWith<$Res>  {
  factory $DropdownOptionModelCopyWith(DropdownOptionModel value, $Res Function(DropdownOptionModel) _then) = _$DropdownOptionModelCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'value') dynamic val
});




}
/// @nodoc
class _$DropdownOptionModelCopyWithImpl<$Res>
    implements $DropdownOptionModelCopyWith<$Res> {
  _$DropdownOptionModelCopyWithImpl(this._self, this._then);

  final DropdownOptionModel _self;
  final $Res Function(DropdownOptionModel) _then;

/// Create a copy of DropdownOptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? val = freezed,}) {
  return _then(DropdownOptionModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,val: freezed == val ? _self.val : val // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [DropdownOptionModel].
extension DropdownOptionModelPatterns on DropdownOptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DropdownOptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DropdownOptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DropdownOptionModel value)  $default,){
final _that = this;
switch (_that) {
case _DropdownOptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DropdownOptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _DropdownOptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'value')  dynamic val)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DropdownOptionModel() when $default != null:
return $default(_that.id,_that.val);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'value')  dynamic val)  $default,) {final _that = this;
switch (_that) {
case _DropdownOptionModel():
return $default(_that.id,_that.val);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'value')  dynamic val)?  $default,) {final _that = this;
switch (_that) {
case _DropdownOptionModel() when $default != null:
return $default(_that.id,_that.val);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DropdownOptionModel implements DropdownOptionModel {
  const _DropdownOptionModel({this.id, @JsonKey(name: 'value') this.val});
  factory _DropdownOptionModel.fromJson(Map<String, dynamic> json) => _$DropdownOptionModelFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'value') final  dynamic val;

/// Create a copy of DropdownOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DropdownOptionModelCopyWith<_DropdownOptionModel> get copyWith => __$DropdownOptionModelCopyWithImpl<_DropdownOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DropdownOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DropdownOptionModel&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.val, val));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(val));
}

@override
String toString() {
    return 'DropdownOptionModel(id: $id, val: $val)';
}


}

/// @nodoc
abstract mixin class _$DropdownOptionModelCopyWith<$Res> implements $DropdownOptionModelCopyWith<$Res> {
  factory _$DropdownOptionModelCopyWith(_DropdownOptionModel value, $Res Function(_DropdownOptionModel) _then) = __$DropdownOptionModelCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'value') dynamic val
});




}
/// @nodoc
class __$DropdownOptionModelCopyWithImpl<$Res>
    implements _$DropdownOptionModelCopyWith<$Res> {
  __$DropdownOptionModelCopyWithImpl(this._self, this._then);

  final _DropdownOptionModel _self;
  final $Res Function(_DropdownOptionModel) _then;

/// Create a copy of DropdownOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? val = freezed,}) {
  return _then(_DropdownOptionModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,val: freezed == val ? _self.val : val // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$DropdownData {

@JsonKey(name: 'marital_status_list') List<DropdownOptionModel>? get maritalStatus;@JsonKey(name: 'manglik_list') List<DropdownOptionModel>? get manglik;@JsonKey(name: 'residence_master_list') List<DropdownOptionModel>? get residence;@JsonKey(name: 'employee_in_list') List<DropdownOptionModel>? get employeeIn;@JsonKey(name: 'id_proof_type_list') List<DropdownOptionModel>? get documentType;@JsonKey(name: 'income_list') List<DropdownOptionModel>? get income;@JsonKey(name: 'part_income_list') List<DropdownOptionModel>? get partIncome;@JsonKey(name: 'family_type_list') List<DropdownOptionModel>? get familyType;@JsonKey(name: 'family_status_list') List<DropdownOptionModel>? get familyStatus;@JsonKey(name: 'no_of_bro_sis_list') List<DropdownOptionModel>? get noOfBrothers;@JsonKey(name: 'no_of_married_sister_list') List<DropdownOptionModel>? get noMarriSister;@JsonKey(name: 'smoking_habit_list') List<DropdownOptionModel>? get smoke;@JsonKey(name: 'payment_method_list') List<DropdownOptionModel>? get paymentMethod;@JsonKey(name: 'registered_from_list') List<DropdownOptionModel>? get registeredFrom;@JsonKey(name: 'photo_setting_list') List<DropdownOptionModel>? get photoSetting;@JsonKey(name: 'country_code') List<DropdownOptionModel>? get countryCode;@JsonKey(name: 'age_rang_list') List<DropdownOptionModel>? get ageRang;@JsonKey(name: 'total_children_list') List<DropdownOptionModel>? get totalChildren;@JsonKey(name: 'status_children_list') List<DropdownOptionModel>? get statusChildren;@JsonKey(name: 'currency_master_list') List<DropdownOptionModel>? get currencyMaster;@JsonKey(name: 'no_of_married_brother_list') List<DropdownOptionModel>? get noMarriBrother;@JsonKey(name: 'star_list') List<DropdownOptionModel>? get starList;@JsonKey(name: 'moongsign_list') List<DropdownOptionModel>? get moonsignList;@JsonKey(name: 'weight_list') List<DropdownOptionModel>? get weightList;@JsonKey(name: 'height_list') List<DropdownOptionModel>? get heightList;@JsonKey(name: 'mother_tongue_list') List<DropdownOptionModel>? get mothertongueList;@JsonKey(name: 'religion_list') List<DropdownOptionModel>? get religionList;@JsonKey(name: 'education_list') List<DropdownOptionModel>? get educationMasterList;@JsonKey(name: 'occupation_list') List<DropdownOptionModel>? get occupationList;@JsonKey(name: 'country_list') List<DropdownOptionModel>? get countryList;@JsonKey(name: 'city_list') List<DropdownOptionModel>? get cityList;@JsonKey(name: 'designation_list') List<DropdownOptionModel>? get designation;@JsonKey(name: 'profileby_list') List<DropdownOptionModel>? get profileby;@JsonKey(name: 'eating_habit_list') List<DropdownOptionModel>? get diet;@JsonKey(name: 'drinking_habit_list') List<DropdownOptionModel>? get drink;@JsonKey(name: 'body_type_list') List<DropdownOptionModel>? get bodytype;@JsonKey(name: 'blood_group_list') List<DropdownOptionModel>? get bloodGroup;@JsonKey(name: 'complexion_list') List<DropdownOptionModel>? get skinTone;@JsonKey(name: 'horoscope_list') List<DropdownOptionModel>? get horoscope;@JsonKey(name: 'institute_list') List<DropdownOptionModel>? get instituteList;@JsonKey(name: 'city_master_list') List<DropdownOptionModel>? get cityMasterList;@JsonKey(name: 'report_types') List<DropdownOptionModel>? get reportTypes;
/// Create a copy of DropdownData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DropdownDataCopyWith<DropdownData> get copyWith => _$DropdownDataCopyWithImpl<DropdownData>(this as DropdownData, _$identity);

  /// Serializes this DropdownData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DropdownData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DropdownData&&const DeepCollectionEquality().equals(other.maritalStatus, _this.maritalStatus)&&const DeepCollectionEquality().equals(other.manglik, _this.manglik)&&const DeepCollectionEquality().equals(other.residence, _this.residence)&&const DeepCollectionEquality().equals(other.employeeIn, _this.employeeIn)&&const DeepCollectionEquality().equals(other.documentType, _this.documentType)&&const DeepCollectionEquality().equals(other.income, _this.income)&&const DeepCollectionEquality().equals(other.partIncome, _this.partIncome)&&const DeepCollectionEquality().equals(other.familyType, _this.familyType)&&const DeepCollectionEquality().equals(other.familyStatus, _this.familyStatus)&&const DeepCollectionEquality().equals(other.noOfBrothers, _this.noOfBrothers)&&const DeepCollectionEquality().equals(other.noMarriSister, _this.noMarriSister)&&const DeepCollectionEquality().equals(other.smoke, _this.smoke)&&const DeepCollectionEquality().equals(other.paymentMethod, _this.paymentMethod)&&const DeepCollectionEquality().equals(other.registeredFrom, _this.registeredFrom)&&const DeepCollectionEquality().equals(other.photoSetting, _this.photoSetting)&&const DeepCollectionEquality().equals(other.countryCode, _this.countryCode)&&const DeepCollectionEquality().equals(other.ageRang, _this.ageRang)&&const DeepCollectionEquality().equals(other.totalChildren, _this.totalChildren)&&const DeepCollectionEquality().equals(other.statusChildren, _this.statusChildren)&&const DeepCollectionEquality().equals(other.currencyMaster, _this.currencyMaster)&&const DeepCollectionEquality().equals(other.noMarriBrother, _this.noMarriBrother)&&const DeepCollectionEquality().equals(other.starList, _this.starList)&&const DeepCollectionEquality().equals(other.moonsignList, _this.moonsignList)&&const DeepCollectionEquality().equals(other.weightList, _this.weightList)&&const DeepCollectionEquality().equals(other.heightList, _this.heightList)&&const DeepCollectionEquality().equals(other.mothertongueList, _this.mothertongueList)&&const DeepCollectionEquality().equals(other.religionList, _this.religionList)&&const DeepCollectionEquality().equals(other.educationMasterList, _this.educationMasterList)&&const DeepCollectionEquality().equals(other.occupationList, _this.occupationList)&&const DeepCollectionEquality().equals(other.countryList, _this.countryList)&&const DeepCollectionEquality().equals(other.cityList, _this.cityList)&&const DeepCollectionEquality().equals(other.designation, _this.designation)&&const DeepCollectionEquality().equals(other.profileby, _this.profileby)&&const DeepCollectionEquality().equals(other.diet, _this.diet)&&const DeepCollectionEquality().equals(other.drink, _this.drink)&&const DeepCollectionEquality().equals(other.bodytype, _this.bodytype)&&const DeepCollectionEquality().equals(other.bloodGroup, _this.bloodGroup)&&const DeepCollectionEquality().equals(other.skinTone, _this.skinTone)&&const DeepCollectionEquality().equals(other.horoscope, _this.horoscope)&&const DeepCollectionEquality().equals(other.instituteList, _this.instituteList)&&const DeepCollectionEquality().equals(other.cityMasterList, _this.cityMasterList)&&const DeepCollectionEquality().equals(other.reportTypes, _this.reportTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DropdownData;
  return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_this.maritalStatus),const DeepCollectionEquality().hash(_this.manglik),const DeepCollectionEquality().hash(_this.residence),const DeepCollectionEquality().hash(_this.employeeIn),const DeepCollectionEquality().hash(_this.documentType),const DeepCollectionEquality().hash(_this.income),const DeepCollectionEquality().hash(_this.partIncome),const DeepCollectionEquality().hash(_this.familyType),const DeepCollectionEquality().hash(_this.familyStatus),const DeepCollectionEquality().hash(_this.noOfBrothers),const DeepCollectionEquality().hash(_this.noMarriSister),const DeepCollectionEquality().hash(_this.smoke),const DeepCollectionEquality().hash(_this.paymentMethod),const DeepCollectionEquality().hash(_this.registeredFrom),const DeepCollectionEquality().hash(_this.photoSetting),const DeepCollectionEquality().hash(_this.countryCode),const DeepCollectionEquality().hash(_this.ageRang),const DeepCollectionEquality().hash(_this.totalChildren),const DeepCollectionEquality().hash(_this.statusChildren),const DeepCollectionEquality().hash(_this.currencyMaster),const DeepCollectionEquality().hash(_this.noMarriBrother),const DeepCollectionEquality().hash(_this.starList),const DeepCollectionEquality().hash(_this.moonsignList),const DeepCollectionEquality().hash(_this.weightList),const DeepCollectionEquality().hash(_this.heightList),const DeepCollectionEquality().hash(_this.mothertongueList),const DeepCollectionEquality().hash(_this.religionList),const DeepCollectionEquality().hash(_this.educationMasterList),const DeepCollectionEquality().hash(_this.occupationList),const DeepCollectionEquality().hash(_this.countryList),const DeepCollectionEquality().hash(_this.cityList),const DeepCollectionEquality().hash(_this.designation),const DeepCollectionEquality().hash(_this.profileby),const DeepCollectionEquality().hash(_this.diet),const DeepCollectionEquality().hash(_this.drink),const DeepCollectionEquality().hash(_this.bodytype),const DeepCollectionEquality().hash(_this.bloodGroup),const DeepCollectionEquality().hash(_this.skinTone),const DeepCollectionEquality().hash(_this.horoscope),const DeepCollectionEquality().hash(_this.instituteList),const DeepCollectionEquality().hash(_this.cityMasterList),const DeepCollectionEquality().hash(_this.reportTypes)]);
}

@override
String toString() {
  final _this = this as DropdownData;
  return 'DropdownData(maritalStatus: ${_this.maritalStatus}, manglik: ${_this.manglik}, residence: ${_this.residence}, employeeIn: ${_this.employeeIn}, documentType: ${_this.documentType}, income: ${_this.income}, partIncome: ${_this.partIncome}, familyType: ${_this.familyType}, familyStatus: ${_this.familyStatus}, noOfBrothers: ${_this.noOfBrothers}, noMarriSister: ${_this.noMarriSister}, smoke: ${_this.smoke}, paymentMethod: ${_this.paymentMethod}, registeredFrom: ${_this.registeredFrom}, photoSetting: ${_this.photoSetting}, countryCode: ${_this.countryCode}, ageRang: ${_this.ageRang}, totalChildren: ${_this.totalChildren}, statusChildren: ${_this.statusChildren}, currencyMaster: ${_this.currencyMaster}, noMarriBrother: ${_this.noMarriBrother}, starList: ${_this.starList}, moonsignList: ${_this.moonsignList}, weightList: ${_this.weightList}, heightList: ${_this.heightList}, mothertongueList: ${_this.mothertongueList}, religionList: ${_this.religionList}, educationMasterList: ${_this.educationMasterList}, occupationList: ${_this.occupationList}, countryList: ${_this.countryList}, cityList: ${_this.cityList}, designation: ${_this.designation}, profileby: ${_this.profileby}, diet: ${_this.diet}, drink: ${_this.drink}, bodytype: ${_this.bodytype}, bloodGroup: ${_this.bloodGroup}, skinTone: ${_this.skinTone}, horoscope: ${_this.horoscope}, instituteList: ${_this.instituteList}, cityMasterList: ${_this.cityMasterList}, reportTypes: ${_this.reportTypes})';
}


}

/// @nodoc
abstract mixin class $DropdownDataCopyWith<$Res>  {
  factory $DropdownDataCopyWith(DropdownData value, $Res Function(DropdownData) _then) = _$DropdownDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'marital_status_list') List<DropdownOptionModel>? maritalStatus,@JsonKey(name: 'manglik_list') List<DropdownOptionModel>? manglik,@JsonKey(name: 'residence_master_list') List<DropdownOptionModel>? residence,@JsonKey(name: 'employee_in_list') List<DropdownOptionModel>? employeeIn,@JsonKey(name: 'id_proof_type_list') List<DropdownOptionModel>? documentType,@JsonKey(name: 'income_list') List<DropdownOptionModel>? income,@JsonKey(name: 'part_income_list') List<DropdownOptionModel>? partIncome,@JsonKey(name: 'family_type_list') List<DropdownOptionModel>? familyType,@JsonKey(name: 'family_status_list') List<DropdownOptionModel>? familyStatus,@JsonKey(name: 'no_of_bro_sis_list') List<DropdownOptionModel>? noOfBrothers,@JsonKey(name: 'no_of_married_sister_list') List<DropdownOptionModel>? noMarriSister,@JsonKey(name: 'smoking_habit_list') List<DropdownOptionModel>? smoke,@JsonKey(name: 'payment_method_list') List<DropdownOptionModel>? paymentMethod,@JsonKey(name: 'registered_from_list') List<DropdownOptionModel>? registeredFrom,@JsonKey(name: 'photo_setting_list') List<DropdownOptionModel>? photoSetting,@JsonKey(name: 'country_code') List<DropdownOptionModel>? countryCode,@JsonKey(name: 'age_rang_list') List<DropdownOptionModel>? ageRang,@JsonKey(name: 'total_children_list') List<DropdownOptionModel>? totalChildren,@JsonKey(name: 'status_children_list') List<DropdownOptionModel>? statusChildren,@JsonKey(name: 'currency_master_list') List<DropdownOptionModel>? currencyMaster,@JsonKey(name: 'no_of_married_brother_list') List<DropdownOptionModel>? noMarriBrother,@JsonKey(name: 'star_list') List<DropdownOptionModel>? starList,@JsonKey(name: 'moongsign_list') List<DropdownOptionModel>? moonsignList,@JsonKey(name: 'weight_list') List<DropdownOptionModel>? weightList,@JsonKey(name: 'height_list') List<DropdownOptionModel>? heightList,@JsonKey(name: 'mother_tongue_list') List<DropdownOptionModel>? mothertongueList,@JsonKey(name: 'religion_list') List<DropdownOptionModel>? religionList,@JsonKey(name: 'education_list') List<DropdownOptionModel>? educationMasterList,@JsonKey(name: 'occupation_list') List<DropdownOptionModel>? occupationList,@JsonKey(name: 'country_list') List<DropdownOptionModel>? countryList,@JsonKey(name: 'city_list') List<DropdownOptionModel>? cityList,@JsonKey(name: 'designation_list') List<DropdownOptionModel>? designation,@JsonKey(name: 'profileby_list') List<DropdownOptionModel>? profileby,@JsonKey(name: 'eating_habit_list') List<DropdownOptionModel>? diet,@JsonKey(name: 'drinking_habit_list') List<DropdownOptionModel>? drink,@JsonKey(name: 'body_type_list') List<DropdownOptionModel>? bodytype,@JsonKey(name: 'blood_group_list') List<DropdownOptionModel>? bloodGroup,@JsonKey(name: 'complexion_list') List<DropdownOptionModel>? skinTone,@JsonKey(name: 'horoscope_list') List<DropdownOptionModel>? horoscope,@JsonKey(name: 'institute_list') List<DropdownOptionModel>? instituteList,@JsonKey(name: 'city_master_list') List<DropdownOptionModel>? cityMasterList,@JsonKey(name: 'report_types') List<DropdownOptionModel>? reportTypes
});




}
/// @nodoc
class _$DropdownDataCopyWithImpl<$Res>
    implements $DropdownDataCopyWith<$Res> {
  _$DropdownDataCopyWithImpl(this._self, this._then);

  final DropdownData _self;
  final $Res Function(DropdownData) _then;

/// Create a copy of DropdownData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maritalStatus = freezed,Object? manglik = freezed,Object? residence = freezed,Object? employeeIn = freezed,Object? documentType = freezed,Object? income = freezed,Object? partIncome = freezed,Object? familyType = freezed,Object? familyStatus = freezed,Object? noOfBrothers = freezed,Object? noMarriSister = freezed,Object? smoke = freezed,Object? paymentMethod = freezed,Object? registeredFrom = freezed,Object? photoSetting = freezed,Object? countryCode = freezed,Object? ageRang = freezed,Object? totalChildren = freezed,Object? statusChildren = freezed,Object? currencyMaster = freezed,Object? noMarriBrother = freezed,Object? starList = freezed,Object? moonsignList = freezed,Object? weightList = freezed,Object? heightList = freezed,Object? mothertongueList = freezed,Object? religionList = freezed,Object? educationMasterList = freezed,Object? occupationList = freezed,Object? countryList = freezed,Object? cityList = freezed,Object? designation = freezed,Object? profileby = freezed,Object? diet = freezed,Object? drink = freezed,Object? bodytype = freezed,Object? bloodGroup = freezed,Object? skinTone = freezed,Object? horoscope = freezed,Object? instituteList = freezed,Object? cityMasterList = freezed,Object? reportTypes = freezed,}) {
  return _then(DropdownData(
maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,residence: freezed == residence ? _self.residence : residence // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,employeeIn: freezed == employeeIn ? _self.employeeIn : employeeIn // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,partIncome: freezed == partIncome ? _self.partIncome : partIncome // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,familyType: freezed == familyType ? _self.familyType : familyType // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,familyStatus: freezed == familyStatus ? _self.familyStatus : familyStatus // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,noOfBrothers: freezed == noOfBrothers ? _self.noOfBrothers : noOfBrothers // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,noMarriSister: freezed == noMarriSister ? _self.noMarriSister : noMarriSister // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,smoke: freezed == smoke ? _self.smoke : smoke // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,registeredFrom: freezed == registeredFrom ? _self.registeredFrom : registeredFrom // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,photoSetting: freezed == photoSetting ? _self.photoSetting : photoSetting // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,ageRang: freezed == ageRang ? _self.ageRang : ageRang // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,totalChildren: freezed == totalChildren ? _self.totalChildren : totalChildren // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,statusChildren: freezed == statusChildren ? _self.statusChildren : statusChildren // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,currencyMaster: freezed == currencyMaster ? _self.currencyMaster : currencyMaster // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,noMarriBrother: freezed == noMarriBrother ? _self.noMarriBrother : noMarriBrother // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,starList: freezed == starList ? _self.starList : starList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,moonsignList: freezed == moonsignList ? _self.moonsignList : moonsignList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,weightList: freezed == weightList ? _self.weightList : weightList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,heightList: freezed == heightList ? _self.heightList : heightList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,mothertongueList: freezed == mothertongueList ? _self.mothertongueList : mothertongueList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,religionList: freezed == religionList ? _self.religionList : religionList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,educationMasterList: freezed == educationMasterList ? _self.educationMasterList : educationMasterList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,occupationList: freezed == occupationList ? _self.occupationList : occupationList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,countryList: freezed == countryList ? _self.countryList : countryList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,cityList: freezed == cityList ? _self.cityList : cityList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,profileby: freezed == profileby ? _self.profileby : profileby // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,drink: freezed == drink ? _self.drink : drink // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,bodytype: freezed == bodytype ? _self.bodytype : bodytype // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,bloodGroup: freezed == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,skinTone: freezed == skinTone ? _self.skinTone : skinTone // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,horoscope: freezed == horoscope ? _self.horoscope : horoscope // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,instituteList: freezed == instituteList ? _self.instituteList : instituteList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,cityMasterList: freezed == cityMasterList ? _self.cityMasterList : cityMasterList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,reportTypes: freezed == reportTypes ? _self.reportTypes : reportTypes // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DropdownData].
extension DropdownDataPatterns on DropdownData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DropdownData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DropdownData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DropdownData value)  $default,){
final _that = this;
switch (_that) {
case _DropdownData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DropdownData value)?  $default,){
final _that = this;
switch (_that) {
case _DropdownData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'marital_status_list')  List<DropdownOptionModel>? maritalStatus, @JsonKey(name: 'manglik_list')  List<DropdownOptionModel>? manglik, @JsonKey(name: 'residence_master_list')  List<DropdownOptionModel>? residence, @JsonKey(name: 'employee_in_list')  List<DropdownOptionModel>? employeeIn, @JsonKey(name: 'id_proof_type_list')  List<DropdownOptionModel>? documentType, @JsonKey(name: 'income_list')  List<DropdownOptionModel>? income, @JsonKey(name: 'part_income_list')  List<DropdownOptionModel>? partIncome, @JsonKey(name: 'family_type_list')  List<DropdownOptionModel>? familyType, @JsonKey(name: 'family_status_list')  List<DropdownOptionModel>? familyStatus, @JsonKey(name: 'no_of_bro_sis_list')  List<DropdownOptionModel>? noOfBrothers, @JsonKey(name: 'no_of_married_sister_list')  List<DropdownOptionModel>? noMarriSister, @JsonKey(name: 'smoking_habit_list')  List<DropdownOptionModel>? smoke, @JsonKey(name: 'payment_method_list')  List<DropdownOptionModel>? paymentMethod, @JsonKey(name: 'registered_from_list')  List<DropdownOptionModel>? registeredFrom, @JsonKey(name: 'photo_setting_list')  List<DropdownOptionModel>? photoSetting, @JsonKey(name: 'country_code')  List<DropdownOptionModel>? countryCode, @JsonKey(name: 'age_rang_list')  List<DropdownOptionModel>? ageRang, @JsonKey(name: 'total_children_list')  List<DropdownOptionModel>? totalChildren, @JsonKey(name: 'status_children_list')  List<DropdownOptionModel>? statusChildren, @JsonKey(name: 'currency_master_list')  List<DropdownOptionModel>? currencyMaster, @JsonKey(name: 'no_of_married_brother_list')  List<DropdownOptionModel>? noMarriBrother, @JsonKey(name: 'star_list')  List<DropdownOptionModel>? starList, @JsonKey(name: 'moongsign_list')  List<DropdownOptionModel>? moonsignList, @JsonKey(name: 'weight_list')  List<DropdownOptionModel>? weightList, @JsonKey(name: 'height_list')  List<DropdownOptionModel>? heightList, @JsonKey(name: 'mother_tongue_list')  List<DropdownOptionModel>? mothertongueList, @JsonKey(name: 'religion_list')  List<DropdownOptionModel>? religionList, @JsonKey(name: 'education_list')  List<DropdownOptionModel>? educationMasterList, @JsonKey(name: 'occupation_list')  List<DropdownOptionModel>? occupationList, @JsonKey(name: 'country_list')  List<DropdownOptionModel>? countryList, @JsonKey(name: 'city_list')  List<DropdownOptionModel>? cityList, @JsonKey(name: 'designation_list')  List<DropdownOptionModel>? designation, @JsonKey(name: 'profileby_list')  List<DropdownOptionModel>? profileby, @JsonKey(name: 'eating_habit_list')  List<DropdownOptionModel>? diet, @JsonKey(name: 'drinking_habit_list')  List<DropdownOptionModel>? drink, @JsonKey(name: 'body_type_list')  List<DropdownOptionModel>? bodytype, @JsonKey(name: 'blood_group_list')  List<DropdownOptionModel>? bloodGroup, @JsonKey(name: 'complexion_list')  List<DropdownOptionModel>? skinTone, @JsonKey(name: 'horoscope_list')  List<DropdownOptionModel>? horoscope, @JsonKey(name: 'institute_list')  List<DropdownOptionModel>? instituteList, @JsonKey(name: 'city_master_list')  List<DropdownOptionModel>? cityMasterList, @JsonKey(name: 'report_types')  List<DropdownOptionModel>? reportTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DropdownData() when $default != null:
return $default(_that.maritalStatus,_that.manglik,_that.residence,_that.employeeIn,_that.documentType,_that.income,_that.partIncome,_that.familyType,_that.familyStatus,_that.noOfBrothers,_that.noMarriSister,_that.smoke,_that.paymentMethod,_that.registeredFrom,_that.photoSetting,_that.countryCode,_that.ageRang,_that.totalChildren,_that.statusChildren,_that.currencyMaster,_that.noMarriBrother,_that.starList,_that.moonsignList,_that.weightList,_that.heightList,_that.mothertongueList,_that.religionList,_that.educationMasterList,_that.occupationList,_that.countryList,_that.cityList,_that.designation,_that.profileby,_that.diet,_that.drink,_that.bodytype,_that.bloodGroup,_that.skinTone,_that.horoscope,_that.instituteList,_that.cityMasterList,_that.reportTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'marital_status_list')  List<DropdownOptionModel>? maritalStatus, @JsonKey(name: 'manglik_list')  List<DropdownOptionModel>? manglik, @JsonKey(name: 'residence_master_list')  List<DropdownOptionModel>? residence, @JsonKey(name: 'employee_in_list')  List<DropdownOptionModel>? employeeIn, @JsonKey(name: 'id_proof_type_list')  List<DropdownOptionModel>? documentType, @JsonKey(name: 'income_list')  List<DropdownOptionModel>? income, @JsonKey(name: 'part_income_list')  List<DropdownOptionModel>? partIncome, @JsonKey(name: 'family_type_list')  List<DropdownOptionModel>? familyType, @JsonKey(name: 'family_status_list')  List<DropdownOptionModel>? familyStatus, @JsonKey(name: 'no_of_bro_sis_list')  List<DropdownOptionModel>? noOfBrothers, @JsonKey(name: 'no_of_married_sister_list')  List<DropdownOptionModel>? noMarriSister, @JsonKey(name: 'smoking_habit_list')  List<DropdownOptionModel>? smoke, @JsonKey(name: 'payment_method_list')  List<DropdownOptionModel>? paymentMethod, @JsonKey(name: 'registered_from_list')  List<DropdownOptionModel>? registeredFrom, @JsonKey(name: 'photo_setting_list')  List<DropdownOptionModel>? photoSetting, @JsonKey(name: 'country_code')  List<DropdownOptionModel>? countryCode, @JsonKey(name: 'age_rang_list')  List<DropdownOptionModel>? ageRang, @JsonKey(name: 'total_children_list')  List<DropdownOptionModel>? totalChildren, @JsonKey(name: 'status_children_list')  List<DropdownOptionModel>? statusChildren, @JsonKey(name: 'currency_master_list')  List<DropdownOptionModel>? currencyMaster, @JsonKey(name: 'no_of_married_brother_list')  List<DropdownOptionModel>? noMarriBrother, @JsonKey(name: 'star_list')  List<DropdownOptionModel>? starList, @JsonKey(name: 'moongsign_list')  List<DropdownOptionModel>? moonsignList, @JsonKey(name: 'weight_list')  List<DropdownOptionModel>? weightList, @JsonKey(name: 'height_list')  List<DropdownOptionModel>? heightList, @JsonKey(name: 'mother_tongue_list')  List<DropdownOptionModel>? mothertongueList, @JsonKey(name: 'religion_list')  List<DropdownOptionModel>? religionList, @JsonKey(name: 'education_list')  List<DropdownOptionModel>? educationMasterList, @JsonKey(name: 'occupation_list')  List<DropdownOptionModel>? occupationList, @JsonKey(name: 'country_list')  List<DropdownOptionModel>? countryList, @JsonKey(name: 'city_list')  List<DropdownOptionModel>? cityList, @JsonKey(name: 'designation_list')  List<DropdownOptionModel>? designation, @JsonKey(name: 'profileby_list')  List<DropdownOptionModel>? profileby, @JsonKey(name: 'eating_habit_list')  List<DropdownOptionModel>? diet, @JsonKey(name: 'drinking_habit_list')  List<DropdownOptionModel>? drink, @JsonKey(name: 'body_type_list')  List<DropdownOptionModel>? bodytype, @JsonKey(name: 'blood_group_list')  List<DropdownOptionModel>? bloodGroup, @JsonKey(name: 'complexion_list')  List<DropdownOptionModel>? skinTone, @JsonKey(name: 'horoscope_list')  List<DropdownOptionModel>? horoscope, @JsonKey(name: 'institute_list')  List<DropdownOptionModel>? instituteList, @JsonKey(name: 'city_master_list')  List<DropdownOptionModel>? cityMasterList, @JsonKey(name: 'report_types')  List<DropdownOptionModel>? reportTypes)  $default,) {final _that = this;
switch (_that) {
case _DropdownData():
return $default(_that.maritalStatus,_that.manglik,_that.residence,_that.employeeIn,_that.documentType,_that.income,_that.partIncome,_that.familyType,_that.familyStatus,_that.noOfBrothers,_that.noMarriSister,_that.smoke,_that.paymentMethod,_that.registeredFrom,_that.photoSetting,_that.countryCode,_that.ageRang,_that.totalChildren,_that.statusChildren,_that.currencyMaster,_that.noMarriBrother,_that.starList,_that.moonsignList,_that.weightList,_that.heightList,_that.mothertongueList,_that.religionList,_that.educationMasterList,_that.occupationList,_that.countryList,_that.cityList,_that.designation,_that.profileby,_that.diet,_that.drink,_that.bodytype,_that.bloodGroup,_that.skinTone,_that.horoscope,_that.instituteList,_that.cityMasterList,_that.reportTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'marital_status_list')  List<DropdownOptionModel>? maritalStatus, @JsonKey(name: 'manglik_list')  List<DropdownOptionModel>? manglik, @JsonKey(name: 'residence_master_list')  List<DropdownOptionModel>? residence, @JsonKey(name: 'employee_in_list')  List<DropdownOptionModel>? employeeIn, @JsonKey(name: 'id_proof_type_list')  List<DropdownOptionModel>? documentType, @JsonKey(name: 'income_list')  List<DropdownOptionModel>? income, @JsonKey(name: 'part_income_list')  List<DropdownOptionModel>? partIncome, @JsonKey(name: 'family_type_list')  List<DropdownOptionModel>? familyType, @JsonKey(name: 'family_status_list')  List<DropdownOptionModel>? familyStatus, @JsonKey(name: 'no_of_bro_sis_list')  List<DropdownOptionModel>? noOfBrothers, @JsonKey(name: 'no_of_married_sister_list')  List<DropdownOptionModel>? noMarriSister, @JsonKey(name: 'smoking_habit_list')  List<DropdownOptionModel>? smoke, @JsonKey(name: 'payment_method_list')  List<DropdownOptionModel>? paymentMethod, @JsonKey(name: 'registered_from_list')  List<DropdownOptionModel>? registeredFrom, @JsonKey(name: 'photo_setting_list')  List<DropdownOptionModel>? photoSetting, @JsonKey(name: 'country_code')  List<DropdownOptionModel>? countryCode, @JsonKey(name: 'age_rang_list')  List<DropdownOptionModel>? ageRang, @JsonKey(name: 'total_children_list')  List<DropdownOptionModel>? totalChildren, @JsonKey(name: 'status_children_list')  List<DropdownOptionModel>? statusChildren, @JsonKey(name: 'currency_master_list')  List<DropdownOptionModel>? currencyMaster, @JsonKey(name: 'no_of_married_brother_list')  List<DropdownOptionModel>? noMarriBrother, @JsonKey(name: 'star_list')  List<DropdownOptionModel>? starList, @JsonKey(name: 'moongsign_list')  List<DropdownOptionModel>? moonsignList, @JsonKey(name: 'weight_list')  List<DropdownOptionModel>? weightList, @JsonKey(name: 'height_list')  List<DropdownOptionModel>? heightList, @JsonKey(name: 'mother_tongue_list')  List<DropdownOptionModel>? mothertongueList, @JsonKey(name: 'religion_list')  List<DropdownOptionModel>? religionList, @JsonKey(name: 'education_list')  List<DropdownOptionModel>? educationMasterList, @JsonKey(name: 'occupation_list')  List<DropdownOptionModel>? occupationList, @JsonKey(name: 'country_list')  List<DropdownOptionModel>? countryList, @JsonKey(name: 'city_list')  List<DropdownOptionModel>? cityList, @JsonKey(name: 'designation_list')  List<DropdownOptionModel>? designation, @JsonKey(name: 'profileby_list')  List<DropdownOptionModel>? profileby, @JsonKey(name: 'eating_habit_list')  List<DropdownOptionModel>? diet, @JsonKey(name: 'drinking_habit_list')  List<DropdownOptionModel>? drink, @JsonKey(name: 'body_type_list')  List<DropdownOptionModel>? bodytype, @JsonKey(name: 'blood_group_list')  List<DropdownOptionModel>? bloodGroup, @JsonKey(name: 'complexion_list')  List<DropdownOptionModel>? skinTone, @JsonKey(name: 'horoscope_list')  List<DropdownOptionModel>? horoscope, @JsonKey(name: 'institute_list')  List<DropdownOptionModel>? instituteList, @JsonKey(name: 'city_master_list')  List<DropdownOptionModel>? cityMasterList, @JsonKey(name: 'report_types')  List<DropdownOptionModel>? reportTypes)?  $default,) {final _that = this;
switch (_that) {
case _DropdownData() when $default != null:
return $default(_that.maritalStatus,_that.manglik,_that.residence,_that.employeeIn,_that.documentType,_that.income,_that.partIncome,_that.familyType,_that.familyStatus,_that.noOfBrothers,_that.noMarriSister,_that.smoke,_that.paymentMethod,_that.registeredFrom,_that.photoSetting,_that.countryCode,_that.ageRang,_that.totalChildren,_that.statusChildren,_that.currencyMaster,_that.noMarriBrother,_that.starList,_that.moonsignList,_that.weightList,_that.heightList,_that.mothertongueList,_that.religionList,_that.educationMasterList,_that.occupationList,_that.countryList,_that.cityList,_that.designation,_that.profileby,_that.diet,_that.drink,_that.bodytype,_that.bloodGroup,_that.skinTone,_that.horoscope,_that.instituteList,_that.cityMasterList,_that.reportTypes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DropdownData implements DropdownData {
  const _DropdownData({@JsonKey(name: 'marital_status_list')  List<DropdownOptionModel>? maritalStatus, @JsonKey(name: 'manglik_list')  List<DropdownOptionModel>? manglik, @JsonKey(name: 'residence_master_list')  List<DropdownOptionModel>? residence, @JsonKey(name: 'employee_in_list')  List<DropdownOptionModel>? employeeIn, @JsonKey(name: 'id_proof_type_list')  List<DropdownOptionModel>? documentType, @JsonKey(name: 'income_list')  List<DropdownOptionModel>? income, @JsonKey(name: 'part_income_list')  List<DropdownOptionModel>? partIncome, @JsonKey(name: 'family_type_list')  List<DropdownOptionModel>? familyType, @JsonKey(name: 'family_status_list')  List<DropdownOptionModel>? familyStatus, @JsonKey(name: 'no_of_bro_sis_list')  List<DropdownOptionModel>? noOfBrothers, @JsonKey(name: 'no_of_married_sister_list')  List<DropdownOptionModel>? noMarriSister, @JsonKey(name: 'smoking_habit_list')  List<DropdownOptionModel>? smoke, @JsonKey(name: 'payment_method_list')  List<DropdownOptionModel>? paymentMethod, @JsonKey(name: 'registered_from_list')  List<DropdownOptionModel>? registeredFrom, @JsonKey(name: 'photo_setting_list')  List<DropdownOptionModel>? photoSetting, @JsonKey(name: 'country_code')  List<DropdownOptionModel>? countryCode, @JsonKey(name: 'age_rang_list')  List<DropdownOptionModel>? ageRang, @JsonKey(name: 'total_children_list')  List<DropdownOptionModel>? totalChildren, @JsonKey(name: 'status_children_list')  List<DropdownOptionModel>? statusChildren, @JsonKey(name: 'currency_master_list')  List<DropdownOptionModel>? currencyMaster, @JsonKey(name: 'no_of_married_brother_list')  List<DropdownOptionModel>? noMarriBrother, @JsonKey(name: 'star_list')  List<DropdownOptionModel>? starList, @JsonKey(name: 'moongsign_list')  List<DropdownOptionModel>? moonsignList, @JsonKey(name: 'weight_list')  List<DropdownOptionModel>? weightList, @JsonKey(name: 'height_list')  List<DropdownOptionModel>? heightList, @JsonKey(name: 'mother_tongue_list')  List<DropdownOptionModel>? mothertongueList, @JsonKey(name: 'religion_list')  List<DropdownOptionModel>? religionList, @JsonKey(name: 'education_list')  List<DropdownOptionModel>? educationMasterList, @JsonKey(name: 'occupation_list')  List<DropdownOptionModel>? occupationList, @JsonKey(name: 'country_list')  List<DropdownOptionModel>? countryList, @JsonKey(name: 'city_list')  List<DropdownOptionModel>? cityList, @JsonKey(name: 'designation_list')  List<DropdownOptionModel>? designation, @JsonKey(name: 'profileby_list')  List<DropdownOptionModel>? profileby, @JsonKey(name: 'eating_habit_list')  List<DropdownOptionModel>? diet, @JsonKey(name: 'drinking_habit_list')  List<DropdownOptionModel>? drink, @JsonKey(name: 'body_type_list')  List<DropdownOptionModel>? bodytype, @JsonKey(name: 'blood_group_list')  List<DropdownOptionModel>? bloodGroup, @JsonKey(name: 'complexion_list')  List<DropdownOptionModel>? skinTone, @JsonKey(name: 'horoscope_list')  List<DropdownOptionModel>? horoscope, @JsonKey(name: 'institute_list')  List<DropdownOptionModel>? instituteList, @JsonKey(name: 'city_master_list')  List<DropdownOptionModel>? cityMasterList, @JsonKey(name: 'report_types')  List<DropdownOptionModel>? reportTypes}): _maritalStatus = maritalStatus,_manglik = manglik,_residence = residence,_employeeIn = employeeIn,_documentType = documentType,_income = income,_partIncome = partIncome,_familyType = familyType,_familyStatus = familyStatus,_noOfBrothers = noOfBrothers,_noMarriSister = noMarriSister,_smoke = smoke,_paymentMethod = paymentMethod,_registeredFrom = registeredFrom,_photoSetting = photoSetting,_countryCode = countryCode,_ageRang = ageRang,_totalChildren = totalChildren,_statusChildren = statusChildren,_currencyMaster = currencyMaster,_noMarriBrother = noMarriBrother,_starList = starList,_moonsignList = moonsignList,_weightList = weightList,_heightList = heightList,_mothertongueList = mothertongueList,_religionList = religionList,_educationMasterList = educationMasterList,_occupationList = occupationList,_countryList = countryList,_cityList = cityList,_designation = designation,_profileby = profileby,_diet = diet,_drink = drink,_bodytype = bodytype,_bloodGroup = bloodGroup,_skinTone = skinTone,_horoscope = horoscope,_instituteList = instituteList,_cityMasterList = cityMasterList,_reportTypes = reportTypes;
  factory _DropdownData.fromJson(Map<String, dynamic> json) => _$DropdownDataFromJson(json);

 final  List<DropdownOptionModel>? _maritalStatus;
@override@JsonKey(name: 'marital_status_list') List<DropdownOptionModel>? get maritalStatus {
  final value = _maritalStatus;
  if (value == null) return null;
  if (_maritalStatus is EqualUnmodifiableListView) return _maritalStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _manglik;
@override@JsonKey(name: 'manglik_list') List<DropdownOptionModel>? get manglik {
  final value = _manglik;
  if (value == null) return null;
  if (_manglik is EqualUnmodifiableListView) return _manglik;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _residence;
@override@JsonKey(name: 'residence_master_list') List<DropdownOptionModel>? get residence {
  final value = _residence;
  if (value == null) return null;
  if (_residence is EqualUnmodifiableListView) return _residence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _employeeIn;
@override@JsonKey(name: 'employee_in_list') List<DropdownOptionModel>? get employeeIn {
  final value = _employeeIn;
  if (value == null) return null;
  if (_employeeIn is EqualUnmodifiableListView) return _employeeIn;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _documentType;
@override@JsonKey(name: 'id_proof_type_list') List<DropdownOptionModel>? get documentType {
  final value = _documentType;
  if (value == null) return null;
  if (_documentType is EqualUnmodifiableListView) return _documentType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _income;
@override@JsonKey(name: 'income_list') List<DropdownOptionModel>? get income {
  final value = _income;
  if (value == null) return null;
  if (_income is EqualUnmodifiableListView) return _income;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _partIncome;
@override@JsonKey(name: 'part_income_list') List<DropdownOptionModel>? get partIncome {
  final value = _partIncome;
  if (value == null) return null;
  if (_partIncome is EqualUnmodifiableListView) return _partIncome;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _familyType;
@override@JsonKey(name: 'family_type_list') List<DropdownOptionModel>? get familyType {
  final value = _familyType;
  if (value == null) return null;
  if (_familyType is EqualUnmodifiableListView) return _familyType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _familyStatus;
@override@JsonKey(name: 'family_status_list') List<DropdownOptionModel>? get familyStatus {
  final value = _familyStatus;
  if (value == null) return null;
  if (_familyStatus is EqualUnmodifiableListView) return _familyStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _noOfBrothers;
@override@JsonKey(name: 'no_of_bro_sis_list') List<DropdownOptionModel>? get noOfBrothers {
  final value = _noOfBrothers;
  if (value == null) return null;
  if (_noOfBrothers is EqualUnmodifiableListView) return _noOfBrothers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _noMarriSister;
@override@JsonKey(name: 'no_of_married_sister_list') List<DropdownOptionModel>? get noMarriSister {
  final value = _noMarriSister;
  if (value == null) return null;
  if (_noMarriSister is EqualUnmodifiableListView) return _noMarriSister;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _smoke;
@override@JsonKey(name: 'smoking_habit_list') List<DropdownOptionModel>? get smoke {
  final value = _smoke;
  if (value == null) return null;
  if (_smoke is EqualUnmodifiableListView) return _smoke;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _paymentMethod;
@override@JsonKey(name: 'payment_method_list') List<DropdownOptionModel>? get paymentMethod {
  final value = _paymentMethod;
  if (value == null) return null;
  if (_paymentMethod is EqualUnmodifiableListView) return _paymentMethod;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _registeredFrom;
@override@JsonKey(name: 'registered_from_list') List<DropdownOptionModel>? get registeredFrom {
  final value = _registeredFrom;
  if (value == null) return null;
  if (_registeredFrom is EqualUnmodifiableListView) return _registeredFrom;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _photoSetting;
@override@JsonKey(name: 'photo_setting_list') List<DropdownOptionModel>? get photoSetting {
  final value = _photoSetting;
  if (value == null) return null;
  if (_photoSetting is EqualUnmodifiableListView) return _photoSetting;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _countryCode;
@override@JsonKey(name: 'country_code') List<DropdownOptionModel>? get countryCode {
  final value = _countryCode;
  if (value == null) return null;
  if (_countryCode is EqualUnmodifiableListView) return _countryCode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _ageRang;
@override@JsonKey(name: 'age_rang_list') List<DropdownOptionModel>? get ageRang {
  final value = _ageRang;
  if (value == null) return null;
  if (_ageRang is EqualUnmodifiableListView) return _ageRang;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _totalChildren;
@override@JsonKey(name: 'total_children_list') List<DropdownOptionModel>? get totalChildren {
  final value = _totalChildren;
  if (value == null) return null;
  if (_totalChildren is EqualUnmodifiableListView) return _totalChildren;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _statusChildren;
@override@JsonKey(name: 'status_children_list') List<DropdownOptionModel>? get statusChildren {
  final value = _statusChildren;
  if (value == null) return null;
  if (_statusChildren is EqualUnmodifiableListView) return _statusChildren;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _currencyMaster;
@override@JsonKey(name: 'currency_master_list') List<DropdownOptionModel>? get currencyMaster {
  final value = _currencyMaster;
  if (value == null) return null;
  if (_currencyMaster is EqualUnmodifiableListView) return _currencyMaster;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _noMarriBrother;
@override@JsonKey(name: 'no_of_married_brother_list') List<DropdownOptionModel>? get noMarriBrother {
  final value = _noMarriBrother;
  if (value == null) return null;
  if (_noMarriBrother is EqualUnmodifiableListView) return _noMarriBrother;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _starList;
@override@JsonKey(name: 'star_list') List<DropdownOptionModel>? get starList {
  final value = _starList;
  if (value == null) return null;
  if (_starList is EqualUnmodifiableListView) return _starList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _moonsignList;
@override@JsonKey(name: 'moongsign_list') List<DropdownOptionModel>? get moonsignList {
  final value = _moonsignList;
  if (value == null) return null;
  if (_moonsignList is EqualUnmodifiableListView) return _moonsignList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _weightList;
@override@JsonKey(name: 'weight_list') List<DropdownOptionModel>? get weightList {
  final value = _weightList;
  if (value == null) return null;
  if (_weightList is EqualUnmodifiableListView) return _weightList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _heightList;
@override@JsonKey(name: 'height_list') List<DropdownOptionModel>? get heightList {
  final value = _heightList;
  if (value == null) return null;
  if (_heightList is EqualUnmodifiableListView) return _heightList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _mothertongueList;
@override@JsonKey(name: 'mother_tongue_list') List<DropdownOptionModel>? get mothertongueList {
  final value = _mothertongueList;
  if (value == null) return null;
  if (_mothertongueList is EqualUnmodifiableListView) return _mothertongueList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _religionList;
@override@JsonKey(name: 'religion_list') List<DropdownOptionModel>? get religionList {
  final value = _religionList;
  if (value == null) return null;
  if (_religionList is EqualUnmodifiableListView) return _religionList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _educationMasterList;
@override@JsonKey(name: 'education_list') List<DropdownOptionModel>? get educationMasterList {
  final value = _educationMasterList;
  if (value == null) return null;
  if (_educationMasterList is EqualUnmodifiableListView) return _educationMasterList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _occupationList;
@override@JsonKey(name: 'occupation_list') List<DropdownOptionModel>? get occupationList {
  final value = _occupationList;
  if (value == null) return null;
  if (_occupationList is EqualUnmodifiableListView) return _occupationList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _countryList;
@override@JsonKey(name: 'country_list') List<DropdownOptionModel>? get countryList {
  final value = _countryList;
  if (value == null) return null;
  if (_countryList is EqualUnmodifiableListView) return _countryList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _cityList;
@override@JsonKey(name: 'city_list') List<DropdownOptionModel>? get cityList {
  final value = _cityList;
  if (value == null) return null;
  if (_cityList is EqualUnmodifiableListView) return _cityList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _designation;
@override@JsonKey(name: 'designation_list') List<DropdownOptionModel>? get designation {
  final value = _designation;
  if (value == null) return null;
  if (_designation is EqualUnmodifiableListView) return _designation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _profileby;
@override@JsonKey(name: 'profileby_list') List<DropdownOptionModel>? get profileby {
  final value = _profileby;
  if (value == null) return null;
  if (_profileby is EqualUnmodifiableListView) return _profileby;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _diet;
@override@JsonKey(name: 'eating_habit_list') List<DropdownOptionModel>? get diet {
  final value = _diet;
  if (value == null) return null;
  if (_diet is EqualUnmodifiableListView) return _diet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _drink;
@override@JsonKey(name: 'drinking_habit_list') List<DropdownOptionModel>? get drink {
  final value = _drink;
  if (value == null) return null;
  if (_drink is EqualUnmodifiableListView) return _drink;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _bodytype;
@override@JsonKey(name: 'body_type_list') List<DropdownOptionModel>? get bodytype {
  final value = _bodytype;
  if (value == null) return null;
  if (_bodytype is EqualUnmodifiableListView) return _bodytype;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _bloodGroup;
@override@JsonKey(name: 'blood_group_list') List<DropdownOptionModel>? get bloodGroup {
  final value = _bloodGroup;
  if (value == null) return null;
  if (_bloodGroup is EqualUnmodifiableListView) return _bloodGroup;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _skinTone;
@override@JsonKey(name: 'complexion_list') List<DropdownOptionModel>? get skinTone {
  final value = _skinTone;
  if (value == null) return null;
  if (_skinTone is EqualUnmodifiableListView) return _skinTone;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _horoscope;
@override@JsonKey(name: 'horoscope_list') List<DropdownOptionModel>? get horoscope {
  final value = _horoscope;
  if (value == null) return null;
  if (_horoscope is EqualUnmodifiableListView) return _horoscope;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _instituteList;
@override@JsonKey(name: 'institute_list') List<DropdownOptionModel>? get instituteList {
  final value = _instituteList;
  if (value == null) return null;
  if (_instituteList is EqualUnmodifiableListView) return _instituteList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _cityMasterList;
@override@JsonKey(name: 'city_master_list') List<DropdownOptionModel>? get cityMasterList {
  final value = _cityMasterList;
  if (value == null) return null;
  if (_cityMasterList is EqualUnmodifiableListView) return _cityMasterList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DropdownOptionModel>? _reportTypes;
@override@JsonKey(name: 'report_types') List<DropdownOptionModel>? get reportTypes {
  final value = _reportTypes;
  if (value == null) return null;
  if (_reportTypes is EqualUnmodifiableListView) return _reportTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of DropdownData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DropdownDataCopyWith<_DropdownData> get copyWith => __$DropdownDataCopyWithImpl<_DropdownData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DropdownDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DropdownData&&const DeepCollectionEquality().equals(other.maritalStatus, _maritalStatus)&&const DeepCollectionEquality().equals(other.manglik, _manglik)&&const DeepCollectionEquality().equals(other.residence, _residence)&&const DeepCollectionEquality().equals(other.employeeIn, _employeeIn)&&const DeepCollectionEquality().equals(other.documentType, _documentType)&&const DeepCollectionEquality().equals(other.income, _income)&&const DeepCollectionEquality().equals(other.partIncome, _partIncome)&&const DeepCollectionEquality().equals(other.familyType, _familyType)&&const DeepCollectionEquality().equals(other.familyStatus, _familyStatus)&&const DeepCollectionEquality().equals(other.noOfBrothers, _noOfBrothers)&&const DeepCollectionEquality().equals(other.noMarriSister, _noMarriSister)&&const DeepCollectionEquality().equals(other.smoke, _smoke)&&const DeepCollectionEquality().equals(other.paymentMethod, _paymentMethod)&&const DeepCollectionEquality().equals(other.registeredFrom, _registeredFrom)&&const DeepCollectionEquality().equals(other.photoSetting, _photoSetting)&&const DeepCollectionEquality().equals(other.countryCode, _countryCode)&&const DeepCollectionEquality().equals(other.ageRang, _ageRang)&&const DeepCollectionEquality().equals(other.totalChildren, _totalChildren)&&const DeepCollectionEquality().equals(other.statusChildren, _statusChildren)&&const DeepCollectionEquality().equals(other.currencyMaster, _currencyMaster)&&const DeepCollectionEquality().equals(other.noMarriBrother, _noMarriBrother)&&const DeepCollectionEquality().equals(other.starList, _starList)&&const DeepCollectionEquality().equals(other.moonsignList, _moonsignList)&&const DeepCollectionEquality().equals(other.weightList, _weightList)&&const DeepCollectionEquality().equals(other.heightList, _heightList)&&const DeepCollectionEquality().equals(other.mothertongueList, _mothertongueList)&&const DeepCollectionEquality().equals(other.religionList, _religionList)&&const DeepCollectionEquality().equals(other.educationMasterList, _educationMasterList)&&const DeepCollectionEquality().equals(other.occupationList, _occupationList)&&const DeepCollectionEquality().equals(other.countryList, _countryList)&&const DeepCollectionEquality().equals(other.cityList, _cityList)&&const DeepCollectionEquality().equals(other.designation, _designation)&&const DeepCollectionEquality().equals(other.profileby, _profileby)&&const DeepCollectionEquality().equals(other.diet, _diet)&&const DeepCollectionEquality().equals(other.drink, _drink)&&const DeepCollectionEquality().equals(other.bodytype, _bodytype)&&const DeepCollectionEquality().equals(other.bloodGroup, _bloodGroup)&&const DeepCollectionEquality().equals(other.skinTone, _skinTone)&&const DeepCollectionEquality().equals(other.horoscope, _horoscope)&&const DeepCollectionEquality().equals(other.instituteList, _instituteList)&&const DeepCollectionEquality().equals(other.cityMasterList, _cityMasterList)&&const DeepCollectionEquality().equals(other.reportTypes, _reportTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_maritalStatus),const DeepCollectionEquality().hash(_manglik),const DeepCollectionEquality().hash(_residence),const DeepCollectionEquality().hash(_employeeIn),const DeepCollectionEquality().hash(_documentType),const DeepCollectionEquality().hash(_income),const DeepCollectionEquality().hash(_partIncome),const DeepCollectionEquality().hash(_familyType),const DeepCollectionEquality().hash(_familyStatus),const DeepCollectionEquality().hash(_noOfBrothers),const DeepCollectionEquality().hash(_noMarriSister),const DeepCollectionEquality().hash(_smoke),const DeepCollectionEquality().hash(_paymentMethod),const DeepCollectionEquality().hash(_registeredFrom),const DeepCollectionEquality().hash(_photoSetting),const DeepCollectionEquality().hash(_countryCode),const DeepCollectionEquality().hash(_ageRang),const DeepCollectionEquality().hash(_totalChildren),const DeepCollectionEquality().hash(_statusChildren),const DeepCollectionEquality().hash(_currencyMaster),const DeepCollectionEquality().hash(_noMarriBrother),const DeepCollectionEquality().hash(_starList),const DeepCollectionEquality().hash(_moonsignList),const DeepCollectionEquality().hash(_weightList),const DeepCollectionEquality().hash(_heightList),const DeepCollectionEquality().hash(_mothertongueList),const DeepCollectionEquality().hash(_religionList),const DeepCollectionEquality().hash(_educationMasterList),const DeepCollectionEquality().hash(_occupationList),const DeepCollectionEquality().hash(_countryList),const DeepCollectionEquality().hash(_cityList),const DeepCollectionEquality().hash(_designation),const DeepCollectionEquality().hash(_profileby),const DeepCollectionEquality().hash(_diet),const DeepCollectionEquality().hash(_drink),const DeepCollectionEquality().hash(_bodytype),const DeepCollectionEquality().hash(_bloodGroup),const DeepCollectionEquality().hash(_skinTone),const DeepCollectionEquality().hash(_horoscope),const DeepCollectionEquality().hash(_instituteList),const DeepCollectionEquality().hash(_cityMasterList),const DeepCollectionEquality().hash(_reportTypes)]);
}

@override
String toString() {
    return 'DropdownData(maritalStatus: $maritalStatus, manglik: $manglik, residence: $residence, employeeIn: $employeeIn, documentType: $documentType, income: $income, partIncome: $partIncome, familyType: $familyType, familyStatus: $familyStatus, noOfBrothers: $noOfBrothers, noMarriSister: $noMarriSister, smoke: $smoke, paymentMethod: $paymentMethod, registeredFrom: $registeredFrom, photoSetting: $photoSetting, countryCode: $countryCode, ageRang: $ageRang, totalChildren: $totalChildren, statusChildren: $statusChildren, currencyMaster: $currencyMaster, noMarriBrother: $noMarriBrother, starList: $starList, moonsignList: $moonsignList, weightList: $weightList, heightList: $heightList, mothertongueList: $mothertongueList, religionList: $religionList, educationMasterList: $educationMasterList, occupationList: $occupationList, countryList: $countryList, cityList: $cityList, designation: $designation, profileby: $profileby, diet: $diet, drink: $drink, bodytype: $bodytype, bloodGroup: $bloodGroup, skinTone: $skinTone, horoscope: $horoscope, instituteList: $instituteList, cityMasterList: $cityMasterList, reportTypes: $reportTypes)';
}


}

/// @nodoc
abstract mixin class _$DropdownDataCopyWith<$Res> implements $DropdownDataCopyWith<$Res> {
  factory _$DropdownDataCopyWith(_DropdownData value, $Res Function(_DropdownData) _then) = __$DropdownDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'marital_status_list') List<DropdownOptionModel>? maritalStatus,@JsonKey(name: 'manglik_list') List<DropdownOptionModel>? manglik,@JsonKey(name: 'residence_master_list') List<DropdownOptionModel>? residence,@JsonKey(name: 'employee_in_list') List<DropdownOptionModel>? employeeIn,@JsonKey(name: 'id_proof_type_list') List<DropdownOptionModel>? documentType,@JsonKey(name: 'income_list') List<DropdownOptionModel>? income,@JsonKey(name: 'part_income_list') List<DropdownOptionModel>? partIncome,@JsonKey(name: 'family_type_list') List<DropdownOptionModel>? familyType,@JsonKey(name: 'family_status_list') List<DropdownOptionModel>? familyStatus,@JsonKey(name: 'no_of_bro_sis_list') List<DropdownOptionModel>? noOfBrothers,@JsonKey(name: 'no_of_married_sister_list') List<DropdownOptionModel>? noMarriSister,@JsonKey(name: 'smoking_habit_list') List<DropdownOptionModel>? smoke,@JsonKey(name: 'payment_method_list') List<DropdownOptionModel>? paymentMethod,@JsonKey(name: 'registered_from_list') List<DropdownOptionModel>? registeredFrom,@JsonKey(name: 'photo_setting_list') List<DropdownOptionModel>? photoSetting,@JsonKey(name: 'country_code') List<DropdownOptionModel>? countryCode,@JsonKey(name: 'age_rang_list') List<DropdownOptionModel>? ageRang,@JsonKey(name: 'total_children_list') List<DropdownOptionModel>? totalChildren,@JsonKey(name: 'status_children_list') List<DropdownOptionModel>? statusChildren,@JsonKey(name: 'currency_master_list') List<DropdownOptionModel>? currencyMaster,@JsonKey(name: 'no_of_married_brother_list') List<DropdownOptionModel>? noMarriBrother,@JsonKey(name: 'star_list') List<DropdownOptionModel>? starList,@JsonKey(name: 'moongsign_list') List<DropdownOptionModel>? moonsignList,@JsonKey(name: 'weight_list') List<DropdownOptionModel>? weightList,@JsonKey(name: 'height_list') List<DropdownOptionModel>? heightList,@JsonKey(name: 'mother_tongue_list') List<DropdownOptionModel>? mothertongueList,@JsonKey(name: 'religion_list') List<DropdownOptionModel>? religionList,@JsonKey(name: 'education_list') List<DropdownOptionModel>? educationMasterList,@JsonKey(name: 'occupation_list') List<DropdownOptionModel>? occupationList,@JsonKey(name: 'country_list') List<DropdownOptionModel>? countryList,@JsonKey(name: 'city_list') List<DropdownOptionModel>? cityList,@JsonKey(name: 'designation_list') List<DropdownOptionModel>? designation,@JsonKey(name: 'profileby_list') List<DropdownOptionModel>? profileby,@JsonKey(name: 'eating_habit_list') List<DropdownOptionModel>? diet,@JsonKey(name: 'drinking_habit_list') List<DropdownOptionModel>? drink,@JsonKey(name: 'body_type_list') List<DropdownOptionModel>? bodytype,@JsonKey(name: 'blood_group_list') List<DropdownOptionModel>? bloodGroup,@JsonKey(name: 'complexion_list') List<DropdownOptionModel>? skinTone,@JsonKey(name: 'horoscope_list') List<DropdownOptionModel>? horoscope,@JsonKey(name: 'institute_list') List<DropdownOptionModel>? instituteList,@JsonKey(name: 'city_master_list') List<DropdownOptionModel>? cityMasterList,@JsonKey(name: 'report_types') List<DropdownOptionModel>? reportTypes
});




}
/// @nodoc
class __$DropdownDataCopyWithImpl<$Res>
    implements _$DropdownDataCopyWith<$Res> {
  __$DropdownDataCopyWithImpl(this._self, this._then);

  final _DropdownData _self;
  final $Res Function(_DropdownData) _then;

/// Create a copy of DropdownData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maritalStatus = freezed,Object? manglik = freezed,Object? residence = freezed,Object? employeeIn = freezed,Object? documentType = freezed,Object? income = freezed,Object? partIncome = freezed,Object? familyType = freezed,Object? familyStatus = freezed,Object? noOfBrothers = freezed,Object? noMarriSister = freezed,Object? smoke = freezed,Object? paymentMethod = freezed,Object? registeredFrom = freezed,Object? photoSetting = freezed,Object? countryCode = freezed,Object? ageRang = freezed,Object? totalChildren = freezed,Object? statusChildren = freezed,Object? currencyMaster = freezed,Object? noMarriBrother = freezed,Object? starList = freezed,Object? moonsignList = freezed,Object? weightList = freezed,Object? heightList = freezed,Object? mothertongueList = freezed,Object? religionList = freezed,Object? educationMasterList = freezed,Object? occupationList = freezed,Object? countryList = freezed,Object? cityList = freezed,Object? designation = freezed,Object? profileby = freezed,Object? diet = freezed,Object? drink = freezed,Object? bodytype = freezed,Object? bloodGroup = freezed,Object? skinTone = freezed,Object? horoscope = freezed,Object? instituteList = freezed,Object? cityMasterList = freezed,Object? reportTypes = freezed,}) {
  return _then(_DropdownData(
maritalStatus: freezed == maritalStatus ? _self._maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,manglik: freezed == manglik ? _self._manglik : manglik // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,residence: freezed == residence ? _self._residence : residence // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,employeeIn: freezed == employeeIn ? _self._employeeIn : employeeIn // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,documentType: freezed == documentType ? _self._documentType : documentType // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,income: freezed == income ? _self._income : income // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,partIncome: freezed == partIncome ? _self._partIncome : partIncome // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,familyType: freezed == familyType ? _self._familyType : familyType // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,familyStatus: freezed == familyStatus ? _self._familyStatus : familyStatus // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,noOfBrothers: freezed == noOfBrothers ? _self._noOfBrothers : noOfBrothers // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,noMarriSister: freezed == noMarriSister ? _self._noMarriSister : noMarriSister // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,smoke: freezed == smoke ? _self._smoke : smoke // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,paymentMethod: freezed == paymentMethod ? _self._paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,registeredFrom: freezed == registeredFrom ? _self._registeredFrom : registeredFrom // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,photoSetting: freezed == photoSetting ? _self._photoSetting : photoSetting // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,countryCode: freezed == countryCode ? _self._countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,ageRang: freezed == ageRang ? _self._ageRang : ageRang // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,totalChildren: freezed == totalChildren ? _self._totalChildren : totalChildren // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,statusChildren: freezed == statusChildren ? _self._statusChildren : statusChildren // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,currencyMaster: freezed == currencyMaster ? _self._currencyMaster : currencyMaster // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,noMarriBrother: freezed == noMarriBrother ? _self._noMarriBrother : noMarriBrother // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,starList: freezed == starList ? _self._starList : starList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,moonsignList: freezed == moonsignList ? _self._moonsignList : moonsignList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,weightList: freezed == weightList ? _self._weightList : weightList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,heightList: freezed == heightList ? _self._heightList : heightList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,mothertongueList: freezed == mothertongueList ? _self._mothertongueList : mothertongueList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,religionList: freezed == religionList ? _self._religionList : religionList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,educationMasterList: freezed == educationMasterList ? _self._educationMasterList : educationMasterList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,occupationList: freezed == occupationList ? _self._occupationList : occupationList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,countryList: freezed == countryList ? _self._countryList : countryList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,cityList: freezed == cityList ? _self._cityList : cityList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,designation: freezed == designation ? _self._designation : designation // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,profileby: freezed == profileby ? _self._profileby : profileby // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,diet: freezed == diet ? _self._diet : diet // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,drink: freezed == drink ? _self._drink : drink // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,bodytype: freezed == bodytype ? _self._bodytype : bodytype // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,bloodGroup: freezed == bloodGroup ? _self._bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,skinTone: freezed == skinTone ? _self._skinTone : skinTone // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,horoscope: freezed == horoscope ? _self._horoscope : horoscope // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,instituteList: freezed == instituteList ? _self._instituteList : instituteList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,cityMasterList: freezed == cityMasterList ? _self._cityMasterList : cityMasterList // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,reportTypes: freezed == reportTypes ? _self._reportTypes : reportTypes // ignore: cast_nullable_to_non_nullable
as List<DropdownOptionModel>?,
  ));
}


}


/// @nodoc
mixin _$DropdownResponseModel {

 int? get code; String? get status; String? get message; DropdownData? get data;
/// Create a copy of DropdownResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DropdownResponseModelCopyWith<DropdownResponseModel> get copyWith => _$DropdownResponseModelCopyWithImpl<DropdownResponseModel>(this as DropdownResponseModel, _$identity);

  /// Serializes this DropdownResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DropdownResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DropdownResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DropdownResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as DropdownResponseModel;
  return 'DropdownResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $DropdownResponseModelCopyWith<$Res>  {
  factory $DropdownResponseModelCopyWith(DropdownResponseModel value, $Res Function(DropdownResponseModel) _then) = _$DropdownResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, DropdownData? data
});


$DropdownDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$DropdownResponseModelCopyWithImpl<$Res>
    implements $DropdownResponseModelCopyWith<$Res> {
  _$DropdownResponseModelCopyWithImpl(this._self, this._then);

  final DropdownResponseModel _self;
  final $Res Function(DropdownResponseModel) _then;

/// Create a copy of DropdownResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(DropdownResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DropdownData?,
  ));
}
/// Create a copy of DropdownResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DropdownDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DropdownDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [DropdownResponseModel].
extension DropdownResponseModelPatterns on DropdownResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DropdownResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DropdownResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DropdownResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _DropdownResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DropdownResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _DropdownResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  DropdownData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DropdownResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  DropdownData? data)  $default,) {final _that = this;
switch (_that) {
case _DropdownResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  DropdownData? data)?  $default,) {final _that = this;
switch (_that) {
case _DropdownResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DropdownResponseModel implements DropdownResponseModel {
  const _DropdownResponseModel({this.code, this.status, this.message, this.data});
  factory _DropdownResponseModel.fromJson(Map<String, dynamic> json) => _$DropdownResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  DropdownData? data;

/// Create a copy of DropdownResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DropdownResponseModelCopyWith<_DropdownResponseModel> get copyWith => __$DropdownResponseModelCopyWithImpl<_DropdownResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DropdownResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DropdownResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'DropdownResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$DropdownResponseModelCopyWith<$Res> implements $DropdownResponseModelCopyWith<$Res> {
  factory _$DropdownResponseModelCopyWith(_DropdownResponseModel value, $Res Function(_DropdownResponseModel) _then) = __$DropdownResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, DropdownData? data
});


@override $DropdownDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$DropdownResponseModelCopyWithImpl<$Res>
    implements _$DropdownResponseModelCopyWith<$Res> {
  __$DropdownResponseModelCopyWithImpl(this._self, this._then);

  final _DropdownResponseModel _self;
  final $Res Function(_DropdownResponseModel) _then;

/// Create a copy of DropdownResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_DropdownResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DropdownData?,
  ));
}

/// Create a copy of DropdownResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DropdownDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DropdownDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
