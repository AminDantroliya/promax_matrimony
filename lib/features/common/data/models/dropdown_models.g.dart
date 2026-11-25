// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DropdownOptionModel _$DropdownOptionModelFromJson(Map<String, dynamic> json) =>
    _DropdownOptionModel(id: json['id'], val: json['value']);

Map<String, dynamic> _$DropdownOptionModelToJson(
  _DropdownOptionModel instance,
) => <String, dynamic>{'id': instance.id, 'value': instance.val};

_DropdownData _$DropdownDataFromJson(Map<String, dynamic> json) =>
    _DropdownData(
      maritalStatus: (json['marital_status_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      manglik: (json['manglik_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      residence: (json['residence_master_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeeIn: (json['employee_in_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      documentType: (json['id_proof_type_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      income: (json['income_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      partIncome: (json['part_income_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyType: (json['family_type_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyStatus: (json['family_status_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      noOfBrothers: (json['no_of_bro_sis_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      noMarriSister: (json['no_of_married_sister_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      smoke: (json['smoking_habit_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: (json['payment_method_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      registeredFrom: (json['registered_from_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoSetting: (json['photo_setting_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      countryCode: (json['country_code'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ageRang: (json['age_rang_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalChildren: (json['total_children_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusChildren: (json['status_children_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currencyMaster: (json['currency_master_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      noMarriBrother: (json['no_of_married_brother_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      starList: (json['star_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      moonsignList: (json['moongsign_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weightList: (json['weight_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      heightList: (json['height_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mothertongueList: (json['mother_tongue_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      religionList: (json['religion_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationMasterList: (json['education_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      occupationList: (json['occupation_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      countryList: (json['country_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cityList: (json['city_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      designation: (json['designation_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      profileby: (json['profileby_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      diet: (json['eating_habit_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      drink: (json['drinking_habit_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bodytype: (json['body_type_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bloodGroup: (json['blood_group_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skinTone: (json['complexion_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      horoscope: (json['horoscope_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      instituteList: (json['institute_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cityMasterList: (json['city_master_list'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reportTypes: (json['report_types'] as List<dynamic>?)
          ?.map((e) => DropdownOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DropdownDataToJson(_DropdownData instance) =>
    <String, dynamic>{
      'marital_status_list': instance.maritalStatus,
      'manglik_list': instance.manglik,
      'residence_master_list': instance.residence,
      'employee_in_list': instance.employeeIn,
      'id_proof_type_list': instance.documentType,
      'income_list': instance.income,
      'part_income_list': instance.partIncome,
      'family_type_list': instance.familyType,
      'family_status_list': instance.familyStatus,
      'no_of_bro_sis_list': instance.noOfBrothers,
      'no_of_married_sister_list': instance.noMarriSister,
      'smoking_habit_list': instance.smoke,
      'payment_method_list': instance.paymentMethod,
      'registered_from_list': instance.registeredFrom,
      'photo_setting_list': instance.photoSetting,
      'country_code': instance.countryCode,
      'age_rang_list': instance.ageRang,
      'total_children_list': instance.totalChildren,
      'status_children_list': instance.statusChildren,
      'currency_master_list': instance.currencyMaster,
      'no_of_married_brother_list': instance.noMarriBrother,
      'star_list': instance.starList,
      'moongsign_list': instance.moonsignList,
      'weight_list': instance.weightList,
      'height_list': instance.heightList,
      'mother_tongue_list': instance.mothertongueList,
      'religion_list': instance.religionList,
      'education_list': instance.educationMasterList,
      'occupation_list': instance.occupationList,
      'country_list': instance.countryList,
      'city_list': instance.cityList,
      'designation_list': instance.designation,
      'profileby_list': instance.profileby,
      'eating_habit_list': instance.diet,
      'drinking_habit_list': instance.drink,
      'body_type_list': instance.bodytype,
      'blood_group_list': instance.bloodGroup,
      'complexion_list': instance.skinTone,
      'horoscope_list': instance.horoscope,
      'institute_list': instance.instituteList,
      'city_master_list': instance.cityMasterList,
      'report_types': instance.reportTypes,
    };

_DropdownResponseModel _$DropdownResponseModelFromJson(
  Map<String, dynamic> json,
) => _DropdownResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DropdownData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DropdownResponseModelToJson(
  _DropdownResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
