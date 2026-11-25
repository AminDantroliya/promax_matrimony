// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_story_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuccessStoryListResponseModel _$SuccessStoryListResponseModelFromJson(
  Map<String, dynamic> json,
) => _SuccessStoryListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SuccessStoryData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SuccessStoryListResponseModelToJson(
  _SuccessStoryListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_SuccessStoryData _$SuccessStoryDataFromJson(Map<String, dynamic> json) =>
    _SuccessStoryData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultList: (json['resultList'] as List<dynamic>?)
          ?.map((e) => SuccessStory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuccessStoryDataToJson(_SuccessStoryData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_SuccessStory _$SuccessStoryFromJson(Map<String, dynamic> json) =>
    _SuccessStory(
      id: (json['id'] as num?)?.toInt(),
      bridename: json['bridename'] as String?,
      brideid: json['brideid'] as String?,
      groomname: json['groomname'] as String?,
      groomid: json['groomid'] as String?,
      weddingphoto: json['wedding_photo'] as String?,
      storyType: json['story_type'] as String?,
      videoType: json['video_type'] as String?,
      weddingVideoFile: json['wedding_video_file'] as String?,
      weddingVideoThumbnail: json['wedding_video_thumbnail'] as String?,
      videoLink: json['video_link'] as String?,
      marriagedate: json['marriagedate'] as String?,
      successmessage: json['successmessage'] as String?,
      slug: json['slug'] as String?,
      seoTitle: json['seo_title'] as String?,
      seoKeywords: json['seo_keywords'] as String?,
      seoDescription: json['seo_description'] as String?,
      status: json['status'] as String?,
      langCode: json['lang_code'] as String?,
      langId: json['lang_id'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isDeleted: json['is_deleted'],
      brideProfileImage: json['bride_profile_image'] as String?,
      groomProfileImage: json['groom_profile_image'] as String?,
    );

Map<String, dynamic> _$SuccessStoryToJson(_SuccessStory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bridename': instance.bridename,
      'brideid': instance.brideid,
      'groomname': instance.groomname,
      'groomid': instance.groomid,
      'wedding_photo': instance.weddingphoto,
      'story_type': instance.storyType,
      'video_type': instance.videoType,
      'wedding_video_file': instance.weddingVideoFile,
      'wedding_video_thumbnail': instance.weddingVideoThumbnail,
      'video_link': instance.videoLink,
      'marriagedate': instance.marriagedate,
      'successmessage': instance.successmessage,
      'slug': instance.slug,
      'seo_title': instance.seoTitle,
      'seo_keywords': instance.seoKeywords,
      'seo_description': instance.seoDescription,
      'status': instance.status,
      'lang_code': instance.langCode,
      'lang_id': instance.langId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_deleted': instance.isDeleted,
      'bride_profile_image': instance.brideProfileImage,
      'groom_profile_image': instance.groomProfileImage,
    };

_SuccessStoryDetailsResponseModel _$SuccessStoryDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => _SuccessStoryDetailsResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SuccessStory.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SuccessStoryDetailsResponseModelToJson(
  _SuccessStoryDetailsResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
