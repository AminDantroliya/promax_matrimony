import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import '../../../success_stories/data/models/success_story_models.dart';
import 'package:pro_matrimony/features/plan/data/models/plan_models.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

@freezed
abstract class DashboardResponseModel with _$DashboardResponseModel {
  const factory DashboardResponseModel({
    int? code,
    String? status,
    String? message,
    DashboardData? data,
  }) = _DashboardResponseModel;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseModelFromJson(json);
}

@freezed
abstract class DashboardData with _$DashboardData {
  const factory DashboardData({
    @JsonKey(name: 'profile_image') String? profileImage,
    @JsonKey(name: 'user_type') dynamic userType,
    @JsonKey(name: 'profile_title') String? profileTitle,
    @JsonKey(name: 'sub_title') String? subTitle,
    @JsonKey(name: 'profile_percentage') dynamic profilePercentage,
    @JsonKey(name: 'unreadChatCount') int? unreadChatCount,
    @JsonKey(name: 'unread_notification_count') int? unreadNotificationCount,
    @JsonKey(name: 'mobile_verify_status') String? mobileVerifyStatus,
    @JsonKey(name: 'email_verify_status') String? emailVerifyStatus,
    @JsonKey(name: 'call_count') int? callCount,
    int? suggestedMatchCount,
    int? fixMeetingsCount,
    int? todayNoMeeting,
    @JsonKey(name: 'matches_count') int? matchesCount,
    int? voiceCallCount,
    @JsonKey(name: 'chat_count') int? chatCount,
    @JsonKey(name: 'photos_count') int? photosCount,
    @JsonKey(name: 'interest_count') dynamic interestCount,
    dynamic shortlistCount,
    dynamic blockedCount,
    dynamic photoRequestCount,
    dynamic viewedProfileCount,
    dynamic viewedContactCount,
    List<AnnouncementBanner>? annocementBannerArr,
    List<MemberListModel>? todayMatches,
    List<MemberListModel>? recentlyJoinedMember,
    List<MemberListModel>? recommendedMatches,
    List<MemberListModel>? whoViewMyProfile,
    @JsonKey(name: 'interest_list') List<MemberListModel>? receivedInterest,
    List<MemberListModel>? recentlyLoginMember,
    List<MemberListModel>? recommedMatchesMember,
    List<MemberListModel>? premiumMatchesMember,
    List<MemberListModel>? nearByMatchesMember,
    @JsonKey(name: 'featuredMember') List<MemberListModel>? featuredMember,
    @JsonKey(name: 'successStories') List<SuccessStory>? successStories,
    @JsonKey(name: 'plan_status') String? planStatus,
    @JsonKey(name: 'current_plan') CurrentPlan? currentPlan,
    @JsonKey(name: 'auto_interest_enabled') int? autoInterestEnabled,
    @JsonKey(name: 'daily_interest_limit') int? dailyInterestLimit,
    @JsonKey(name: 'min_match_percentage') int? minMatchPercentage,
    @JsonKey(name: 'site_setting') Map<String, dynamic>? siteSetting,
    @JsonKey(name: 'latitude') String? latitude,
    @JsonKey(name: 'longitude') String? longitude,
    @JsonKey(name: 'android_device_id') String? androidDeviceId,
    @JsonKey(name: 'ios_device_id') String? iosDeviceId,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}

@freezed
abstract class AnnouncementBanner with _$AnnouncementBanner {
  const factory AnnouncementBanner({
    int? id,
    String? image,
    @JsonKey(name: 'lang_code') String? langCode,
    @JsonKey(name: 'lang_id') dynamic langId,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_deleted') dynamic isDeleted,
  }) = _AnnouncementBanner;

  factory AnnouncementBanner.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementBannerFromJson(json);
}
