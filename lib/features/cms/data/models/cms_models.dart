import 'package:freezed_annotation/freezed_annotation.dart';

part 'cms_models.freezed.dart';
part 'cms_models.g.dart';

@freezed
abstract class CmsResponseModel with _$CmsResponseModel {
  const factory CmsResponseModel({
    int? code,
    String? status,
    String? message,
    CmsData? data,
  }) = _CmsResponseModel;

  factory CmsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CmsResponseModelFromJson(json);
}

@freezed
abstract class CmsData with _$CmsData {
  const factory CmsData({
    int? id,
    String? status,
    @JsonKey(name: 'page_title') String? pageTitle,
    @JsonKey(name: 'page_sub_title') String? pageSubTitle,
    @JsonKey(name: 'page_content') String? pageContent,
    @JsonKey(name: 'page_url') String? pageUrl,
    @JsonKey(name: 'about_us_image') String? aboutUsImage,
    @JsonKey(name: 'about_us_sub_title') String? aboutUsSubTitle,
    @JsonKey(name: 'about_us_desc') String? aboutUsDesc,
    @JsonKey(name: 'about_us_brow_sec1') String? aboutUsBrowSec1,
    @JsonKey(name: 'about_us_brow_sec2') String? aboutUsBrowSec2,
    @JsonKey(name: 'about_us_brow_sec3') String? aboutUsBrowSec3,
  }) = _CmsData;

  factory CmsData.fromJson(Map<String, dynamic> json) =>
      _$CmsDataFromJson(json);
}
