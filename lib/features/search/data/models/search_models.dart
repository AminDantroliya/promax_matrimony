import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';

part 'search_models.freezed.dart';
part 'search_models.g.dart';

Map<String, dynamic> _preprocessSearchResultJson(Map<String, dynamic> json) {
  if (json['data'] is List) {
    final list = json['data'] as List;
    return {
      ...json,
      'data': {
        'resultCount': list.length,
        'resultList': list,
      },
    };
  }
  return json;
}

Object? _readSearchResultCount(Map json, String key) {
  final val = json['resultCount'] ??
      json['result_count'] ??
      json['totalCount'] ??
      json['total_count'] ??
      json['total'];
  if (val == null) return null;
  if (val is int) return val;
  if (val is num) return val.toInt();
  return int.tryParse(val.toString());
}

Object? _readSearchResultList(Map json, String key) {
  return json['resultList'] ?? json['resultArr'] ?? json['results'] ?? json['data'];
}

@freezed
abstract class SearchResultListResponseModel
    with _$SearchResultListResponseModel {
  const factory SearchResultListResponseModel({
    int? code,
    String? status,
    String? message,
    SearchResultData? data,
  }) = _SearchResultListResponseModel;

  factory SearchResultListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultListResponseModelFromJson(_preprocessSearchResultJson(json));
}

@freezed
abstract class SearchResultData with _$SearchResultData {
  const factory SearchResultData({
    @JsonKey(name: 'resultCount', readValue: _readSearchResultCount) int? resultCount,
    @JsonKey(name: 'resultList', readValue: _readSearchResultList) List<MemberListModel>? resultList,
  }) = _SearchResultData;

  factory SearchResultData.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDataFromJson(json);
}

@freezed
abstract class SavedSearchListResponseModel
    with _$SavedSearchListResponseModel {
  const factory SavedSearchListResponseModel({
    int? code,
    String? status,
    String? message,
    SavedSearchData? data,
  }) = _SavedSearchListResponseModel;

  factory SavedSearchListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedSearchListResponseModelFromJson(json);
}

@freezed
abstract class SavedSearchData with _$SavedSearchData {
  const factory SavedSearchData({
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'resultList') List<SavedSearchFilter>? resultList,
  }) = _SavedSearchData;

  factory SavedSearchData.fromJson(Map<String, dynamic> json) =>
      _$SavedSearchDataFromJson(json);
}

@freezed
abstract class SavedSearchFilter with _$SavedSearchFilter {
  const factory SavedSearchFilter({
    dynamic id,
    @JsonKey(name: 'member_id') dynamic memberId,
    @JsonKey(name: 'search_page_name') dynamic searchPageName,
    @JsonKey(name: 'search_name') dynamic searchName,
    @JsonKey(name: 'from_age') dynamic fromAge,
    @JsonKey(name: 'to_age') dynamic toAge,
    @JsonKey(name: 'from_height') dynamic fromHeight,
    @JsonKey(name: 'to_height') dynamic toHeight,
    @JsonKey(name: 'marital_status') dynamic maritalStatus,
    dynamic religion,
    dynamic caste,
    @JsonKey(name: 'mother_tongue') dynamic motherTongue,
    dynamic country,
    dynamic state,
    dynamic city,
    @JsonKey(name: 'education_level') dynamic educationLevel,
    @JsonKey(name: 'with_photo') dynamic withPhoto,
    dynamic occupation,
    dynamic income,
    dynamic manglik,
    dynamic keyword,
    @JsonKey(name: 'id_search') dynamic idSearch,
    @JsonKey(name: 'employee_in') dynamic employeeIn,
    @JsonKey(name: 'created_at') dynamic createdAt,
    @JsonKey(name: 'updated_at') dynamic updatedAt,
    @JsonKey(name: 'is_deleted') dynamic isDeleted,
    @JsonKey(name: 'display_values') List<Map<String, dynamic>>? displayValues,
    @JsonKey(name: 'from_age_str') dynamic fromAgeStr,
    @JsonKey(name: 'to_age_str') dynamic toAgeStr,
    @JsonKey(name: 'from_height_str') dynamic fromHeightStr,
    @JsonKey(name: 'to_height_str') dynamic toHeightStr,
    @JsonKey(name: 'religion_str') dynamic religionStr,
    @JsonKey(name: 'caste_str') dynamic casteStr,
    @JsonKey(name: 'mothertongue_str') dynamic mothertongueStr,
    @JsonKey(name: 'country_str') dynamic countryStr,
    @JsonKey(name: 'state_str') dynamic stateStr,
    @JsonKey(name: 'city_str') dynamic cityStr,
    @JsonKey(name: 'education_str') dynamic educationStr,
    @JsonKey(name: 'occupation_str') dynamic occupationStr,
    @JsonKey(name: 'employee_str') dynamic employeeStr,
    @JsonKey(name: 'income_str') dynamic incomeStr,
  }) = _SavedSearchFilter;

  factory SavedSearchFilter.fromJson(Map<String, dynamic> json) =>
      _$SavedSearchFilterFromJson(json);
}
