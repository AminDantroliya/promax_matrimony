import 'package:freezed_annotation/freezed_annotation.dart';

part 'dropdown_models.freezed.dart';
part 'dropdown_models.g.dart';

@freezed
abstract class DropdownOptionModel with _$DropdownOptionModel {
  const factory DropdownOptionModel({
    dynamic id,
    @JsonKey(name: 'value') dynamic val,
  }) = _DropdownOptionModel;

  factory DropdownOptionModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownOptionModelFromJson(json);
}

@freezed
abstract class DropdownData with _$DropdownData {
  const factory DropdownData({
    @JsonKey(name: 'marital_status_list') List<DropdownOptionModel>? maritalStatus,
    @JsonKey(name: 'manglik_list') List<DropdownOptionModel>? manglik,
    @JsonKey(name: 'residence_master_list') List<DropdownOptionModel>? residence,
    @JsonKey(name: 'employee_in_list') List<DropdownOptionModel>? employeeIn,
    @JsonKey(name: 'id_proof_type_list') List<DropdownOptionModel>? documentType,
    @JsonKey(name: 'income_list') List<DropdownOptionModel>? income,
    @JsonKey(name: 'part_income_list') List<DropdownOptionModel>? partIncome,
    @JsonKey(name: 'family_type_list') List<DropdownOptionModel>? familyType,
    @JsonKey(name: 'family_status_list') List<DropdownOptionModel>? familyStatus,
    @JsonKey(name: 'no_of_bro_sis_list') List<DropdownOptionModel>? noOfBrothers,
    @JsonKey(name: 'no_of_married_sister_list') List<DropdownOptionModel>? noMarriSister,
    @JsonKey(name: 'smoking_habit_list') List<DropdownOptionModel>? smoke,
    @JsonKey(name: 'payment_method_list') List<DropdownOptionModel>? paymentMethod,
    @JsonKey(name: 'registered_from_list') List<DropdownOptionModel>? registeredFrom,
    @JsonKey(name: 'photo_setting_list') List<DropdownOptionModel>? photoSetting,
    @JsonKey(name: 'country_code') List<DropdownOptionModel>? countryCode,
    @JsonKey(name: 'age_rang_list') List<DropdownOptionModel>? ageRang,
    @JsonKey(name: 'total_children_list') List<DropdownOptionModel>? totalChildren,
    @JsonKey(name: 'status_children_list') List<DropdownOptionModel>? statusChildren,
    @JsonKey(name: 'currency_master_list') List<DropdownOptionModel>? currencyMaster,
    @JsonKey(name: 'no_of_married_brother_list') List<DropdownOptionModel>? noMarriBrother,
    @JsonKey(name: 'star_list') List<DropdownOptionModel>? starList,
    @JsonKey(name: 'moongsign_list') List<DropdownOptionModel>? moonsignList,
    @JsonKey(name: 'weight_list') List<DropdownOptionModel>? weightList,
    @JsonKey(name: 'height_list') List<DropdownOptionModel>? heightList,
    @JsonKey(name: 'mother_tongue_list') List<DropdownOptionModel>? mothertongueList,
    @JsonKey(name: 'religion_list') List<DropdownOptionModel>? religionList,
    @JsonKey(name: 'education_list') List<DropdownOptionModel>? educationMasterList,
    @JsonKey(name: 'occupation_list') List<DropdownOptionModel>? occupationList,
    @JsonKey(name: 'country_list') List<DropdownOptionModel>? countryList,
    @JsonKey(name: 'city_list') List<DropdownOptionModel>? cityList,
    @JsonKey(name: 'designation_list') List<DropdownOptionModel>? designation,
    @JsonKey(name: 'profileby_list') List<DropdownOptionModel>? profileby,
    @JsonKey(name: 'eating_habit_list') List<DropdownOptionModel>? diet,
    @JsonKey(name: 'drinking_habit_list') List<DropdownOptionModel>? drink,
    @JsonKey(name: 'body_type_list') List<DropdownOptionModel>? bodytype,
    @JsonKey(name: 'blood_group_list') List<DropdownOptionModel>? bloodGroup,
    @JsonKey(name: 'complexion_list') List<DropdownOptionModel>? skinTone,
    @JsonKey(name: 'horoscope_list') List<DropdownOptionModel>? horoscope,
    @JsonKey(name: 'institute_list') List<DropdownOptionModel>? instituteList,
    @JsonKey(name: 'city_master_list') List<DropdownOptionModel>? cityMasterList,
    @JsonKey(name: 'report_types') List<DropdownOptionModel>? reportTypes,
  }) = _DropdownData;

  factory DropdownData.fromJson(Map<String, dynamic> json) => _$DropdownDataFromJson(json);
}

@freezed
abstract class DropdownResponseModel with _$DropdownResponseModel {
  const factory DropdownResponseModel({
    int? code,
    String? status,
    String? message,
    DropdownData? data,
  }) = _DropdownResponseModel;

  factory DropdownResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownResponseModelFromJson(json);
}
