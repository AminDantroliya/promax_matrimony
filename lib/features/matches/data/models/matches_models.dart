import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';

part 'matches_models.freezed.dart';
part 'matches_models.g.dart';

@freezed
abstract class MatchesListResponseModel with _$MatchesListResponseModel {
  const factory MatchesListResponseModel({
    int? code,
    String? status,
    String? message,
    MatchesData? data,
  }) = _MatchesListResponseModel;

  factory MatchesListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MatchesListResponseModelFromJson(_preprocessMatchesJson(json));
}

Map<String, dynamic> _preprocessMatchesJson(Map<String, dynamic> json) {
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

Object? _readMatchesResultCount(Map json, String key) {
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

Object? _readMatchesResultList(Map json, String key) {
  return json['resultList'] ?? json['resultArr'] ?? json['results'] ?? json['data'];
}

@freezed
abstract class MatchesData with _$MatchesData {
  const factory MatchesData({
    @JsonKey(name: 'resultCount', readValue: _readMatchesResultCount) int? resultCount,
    @JsonKey(name: 'resultList', readValue: _readMatchesResultList) List<MemberListModel>? resultList,
  }) = _MatchesData;

  factory MatchesData.fromJson(Map<String, dynamic> json) =>
      _$MatchesDataFromJson(json);
}
