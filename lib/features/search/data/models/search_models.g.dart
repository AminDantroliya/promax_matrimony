// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResultListResponseModel _$SearchResultListResponseModelFromJson(
  Map<String, dynamic> json,
) => _SearchResultListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SearchResultData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SearchResultListResponseModelToJson(
  _SearchResultListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_SearchResultData _$SearchResultDataFromJson(Map<String, dynamic> json) =>
    _SearchResultData(
      resultCount: (_readSearchResultCount(json, 'resultCount') as num?)
          ?.toInt(),
      resultList: (_readSearchResultList(json, 'resultList') as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultDataToJson(_SearchResultData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_SavedSearchListResponseModel _$SavedSearchListResponseModelFromJson(
  Map<String, dynamic> json,
) => _SavedSearchListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SavedSearchData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SavedSearchListResponseModelToJson(
  _SavedSearchListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_SavedSearchData _$SavedSearchDataFromJson(Map<String, dynamic> json) =>
    _SavedSearchData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultList: (json['resultList'] as List<dynamic>?)
          ?.map((e) => SavedSearchFilter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SavedSearchDataToJson(_SavedSearchData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_SavedSearchFilter _$SavedSearchFilterFromJson(Map<String, dynamic> json) =>
    _SavedSearchFilter(
      id: json['id'],
      memberId: json['member_id'],
      searchPageName: json['search_page_name'],
      searchName: json['search_name'],
      fromAge: json['from_age'],
      toAge: json['to_age'],
      fromHeight: json['from_height'],
      toHeight: json['to_height'],
      maritalStatus: json['marital_status'],
      religion: json['religion'],
      caste: json['caste'],
      motherTongue: json['mother_tongue'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      educationLevel: json['education_level'],
      withPhoto: json['with_photo'],
      occupation: json['occupation'],
      income: json['income'],
      manglik: json['manglik'],
      keyword: json['keyword'],
      idSearch: json['id_search'],
      employeeIn: json['employee_in'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isDeleted: json['is_deleted'],
      displayValues: (json['display_values'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      fromAgeStr: json['from_age_str'],
      toAgeStr: json['to_age_str'],
      fromHeightStr: json['from_height_str'],
      toHeightStr: json['to_height_str'],
      religionStr: json['religion_str'],
      casteStr: json['caste_str'],
      mothertongueStr: json['mothertongue_str'],
      countryStr: json['country_str'],
      stateStr: json['state_str'],
      cityStr: json['city_str'],
      educationStr: json['education_str'],
      occupationStr: json['occupation_str'],
      employeeStr: json['employee_str'],
      incomeStr: json['income_str'],
    );

Map<String, dynamic> _$SavedSearchFilterToJson(_SavedSearchFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'search_page_name': instance.searchPageName,
      'search_name': instance.searchName,
      'from_age': instance.fromAge,
      'to_age': instance.toAge,
      'from_height': instance.fromHeight,
      'to_height': instance.toHeight,
      'marital_status': instance.maritalStatus,
      'religion': instance.religion,
      'caste': instance.caste,
      'mother_tongue': instance.motherTongue,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'education_level': instance.educationLevel,
      'with_photo': instance.withPhoto,
      'occupation': instance.occupation,
      'income': instance.income,
      'manglik': instance.manglik,
      'keyword': instance.keyword,
      'id_search': instance.idSearch,
      'employee_in': instance.employeeIn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_deleted': instance.isDeleted,
      'display_values': instance.displayValues,
      'from_age_str': instance.fromAgeStr,
      'to_age_str': instance.toAgeStr,
      'from_height_str': instance.fromHeightStr,
      'to_height_str': instance.toHeightStr,
      'religion_str': instance.religionStr,
      'caste_str': instance.casteStr,
      'mothertongue_str': instance.mothertongueStr,
      'country_str': instance.countryStr,
      'state_str': instance.stateStr,
      'city_str': instance.cityStr,
      'education_str': instance.educationStr,
      'occupation_str': instance.occupationStr,
      'employee_str': instance.employeeStr,
      'income_str': instance.incomeStr,
    };
