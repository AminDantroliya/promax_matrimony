// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CmsResponseModel _$CmsResponseModelFromJson(Map<String, dynamic> json) =>
    _CmsResponseModel(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CmsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CmsResponseModelToJson(_CmsResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

_CmsData _$CmsDataFromJson(Map<String, dynamic> json) => _CmsData(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String?,
  pageTitle: json['page_title'] as String?,
  pageSubTitle: json['page_sub_title'] as String?,
  pageContent: json['page_content'] as String?,
  pageUrl: json['page_url'] as String?,
  aboutUsImage: json['about_us_image'] as String?,
  aboutUsSubTitle: json['about_us_sub_title'] as String?,
  aboutUsDesc: json['about_us_desc'] as String?,
  aboutUsBrowSec1: json['about_us_brow_sec1'] as String?,
  aboutUsBrowSec2: json['about_us_brow_sec2'] as String?,
  aboutUsBrowSec3: json['about_us_brow_sec3'] as String?,
);

Map<String, dynamic> _$CmsDataToJson(_CmsData instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'page_title': instance.pageTitle,
  'page_sub_title': instance.pageSubTitle,
  'page_content': instance.pageContent,
  'page_url': instance.pageUrl,
  'about_us_image': instance.aboutUsImage,
  'about_us_sub_title': instance.aboutUsSubTitle,
  'about_us_desc': instance.aboutUsDesc,
  'about_us_brow_sec1': instance.aboutUsBrowSec1,
  'about_us_brow_sec2': instance.aboutUsBrowSec2,
  'about_us_brow_sec3': instance.aboutUsBrowSec3,
};
