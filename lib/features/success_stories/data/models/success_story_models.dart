import 'package:freezed_annotation/freezed_annotation.dart';

part 'success_story_models.freezed.dart';
part 'success_story_models.g.dart';

@freezed
abstract class SuccessStoryListResponseModel with _$SuccessStoryListResponseModel {
  const factory SuccessStoryListResponseModel({
    int? code,
    String? status,
    String? message,
    SuccessStoryData? data,
  }) = _SuccessStoryListResponseModel;

  factory SuccessStoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SuccessStoryListResponseModelFromJson(json);
}

@freezed
abstract class SuccessStoryData with _$SuccessStoryData {
  const factory SuccessStoryData({
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'resultList') List<SuccessStory>? resultList,
  }) = _SuccessStoryData;

  factory SuccessStoryData.fromJson(Map<String, dynamic> json) =>
      _$SuccessStoryDataFromJson(json);
}

@freezed
abstract class SuccessStory with _$SuccessStory {
  const factory SuccessStory({
    int? id,
    String? bridename,
    String? brideid,
    String? groomname,
    String? groomid,
    @JsonKey(name: 'wedding_photo') String? weddingphoto,
    @JsonKey(name: 'story_type') String? storyType,
    @JsonKey(name: 'video_type') String? videoType,
    @JsonKey(name: 'wedding_video_file') String? weddingVideoFile,
    @JsonKey(name: 'wedding_video_thumbnail') String? weddingVideoThumbnail,
    @JsonKey(name: 'video_link') String? videoLink,
    String? marriagedate,
    String? successmessage,
    String? slug,
    @JsonKey(name: 'seo_title') String? seoTitle,
    @JsonKey(name: 'seo_keywords') String? seoKeywords,
    @JsonKey(name: 'seo_description') String? seoDescription,
    String? status,
    @JsonKey(name: 'lang_code') String? langCode,
    @JsonKey(name: 'lang_id') dynamic langId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_deleted') dynamic isDeleted,
    @JsonKey(name: 'bride_profile_image') String? brideProfileImage,
    @JsonKey(name: 'groom_profile_image') String? groomProfileImage,
  }) = _SuccessStory;

  factory SuccessStory.fromJson(Map<String, dynamic> json) =>
      _$SuccessStoryFromJson(json);
}

@freezed
abstract class SuccessStoryDetailsResponseModel with _$SuccessStoryDetailsResponseModel {
  const factory SuccessStoryDetailsResponseModel({
    int? code,
    String? status,
    String? message,
    SuccessStory? data,
  }) = _SuccessStoryDetailsResponseModel;

  factory SuccessStoryDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SuccessStoryDetailsResponseModelFromJson(json);
}
