import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../common/data/models/member_models.dart';

part 'activity_models.freezed.dart';
part 'activity_models.g.dart';

@freezed
abstract class ActivityProfileListResponseModel
    with _$ActivityProfileListResponseModel {
  const factory ActivityProfileListResponseModel({
    int? code,
    String? status,
    String? message,
    ActivityData? data,
  }) = _ActivityProfileListResponseModel;

  factory ActivityProfileListResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ActivityProfileListResponseModelFromJson(json);
}

Object? _readResultList(Map json, String key) {
  return json['resultArr'] ?? json['resultList'];
}

@freezed
abstract class ActivityData with _$ActivityData {
  const factory ActivityData({
    int? resultCount,
    @JsonKey(name: 'resultArr', readValue: _readResultList) List<MemberListModel>? resultArr,
    int? sentCount,
    int? receivedCount,
    int? acceptedCount,
    int? pendingReceivedCount,
    int? incomingCount,
    int? outgoingCount,
    int? missedCount,
  }) = _ActivityData;

  factory ActivityData.fromJson(Map<String, dynamic> json) =>
      _$ActivityDataFromJson(json);
}
