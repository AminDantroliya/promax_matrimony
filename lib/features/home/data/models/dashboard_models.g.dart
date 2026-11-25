// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardResponseModel _$DashboardResponseModelFromJson(
  Map<String, dynamic> json,
) => _DashboardResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DashboardData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DashboardResponseModelToJson(
  _DashboardResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    _DashboardData(
      profileImage: json['profile_image'] as String?,
      userType: json['user_type'],
      profileTitle: json['profile_title'] as String?,
      subTitle: json['sub_title'] as String?,
      profilePercentage: json['profile_percentage'],
      unreadChatCount: (json['unreadChatCount'] as num?)?.toInt(),
      unreadNotificationCount: (json['unread_notification_count'] as num?)
          ?.toInt(),
      mobileVerifyStatus: json['mobile_verify_status'] as String?,
      emailVerifyStatus: json['email_verify_status'] as String?,
      callCount: (json['call_count'] as num?)?.toInt(),
      suggestedMatchCount: (json['suggestedMatchCount'] as num?)?.toInt(),
      fixMeetingsCount: (json['fixMeetingsCount'] as num?)?.toInt(),
      todayNoMeeting: (json['todayNoMeeting'] as num?)?.toInt(),
      matchesCount: (json['matches_count'] as num?)?.toInt(),
      voiceCallCount: (json['voiceCallCount'] as num?)?.toInt(),
      chatCount: (json['chat_count'] as num?)?.toInt(),
      photosCount: (json['photos_count'] as num?)?.toInt(),
      interestCount: json['interest_count'],
      shortlistCount: json['shortlistCount'],
      blockedCount: json['blockedCount'],
      photoRequestCount: json['photoRequestCount'],
      viewedProfileCount: json['viewedProfileCount'],
      viewedContactCount: json['viewedContactCount'],
      annocementBannerArr: (json['annocementBannerArr'] as List<dynamic>?)
          ?.map((e) => AnnouncementBanner.fromJson(e as Map<String, dynamic>))
          .toList(),
      todayMatches: (json['todayMatches'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentlyJoinedMember: (json['recentlyJoinedMember'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedMatches: (json['recommendedMatches'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      whoViewMyProfile: (json['whoViewMyProfile'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      receivedInterest: (json['interest_list'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentlyLoginMember: (json['recentlyLoginMember'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommedMatchesMember: (json['recommedMatchesMember'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      premiumMatchesMember: (json['premiumMatchesMember'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nearByMatchesMember: (json['nearByMatchesMember'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredMember: (json['featuredMember'] as List<dynamic>?)
          ?.map((e) => MemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      successStories: (json['successStories'] as List<dynamic>?)
          ?.map((e) => SuccessStory.fromJson(e as Map<String, dynamic>))
          .toList(),
      planStatus: json['plan_status'] as String?,
      currentPlan: json['current_plan'] == null
          ? null
          : CurrentPlan.fromJson(json['current_plan'] as Map<String, dynamic>),
      autoInterestEnabled: (json['auto_interest_enabled'] as num?)?.toInt(),
      dailyInterestLimit: (json['daily_interest_limit'] as num?)?.toInt(),
      minMatchPercentage: (json['min_match_percentage'] as num?)?.toInt(),
      siteSetting: json['site_setting'] as Map<String, dynamic>?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      androidDeviceId: json['android_device_id'] as String?,
      iosDeviceId: json['ios_device_id'] as String?,
    );

Map<String, dynamic> _$DashboardDataToJson(_DashboardData instance) =>
    <String, dynamic>{
      'profile_image': instance.profileImage,
      'user_type': instance.userType,
      'profile_title': instance.profileTitle,
      'sub_title': instance.subTitle,
      'profile_percentage': instance.profilePercentage,
      'unreadChatCount': instance.unreadChatCount,
      'unread_notification_count': instance.unreadNotificationCount,
      'mobile_verify_status': instance.mobileVerifyStatus,
      'email_verify_status': instance.emailVerifyStatus,
      'call_count': instance.callCount,
      'suggestedMatchCount': instance.suggestedMatchCount,
      'fixMeetingsCount': instance.fixMeetingsCount,
      'todayNoMeeting': instance.todayNoMeeting,
      'matches_count': instance.matchesCount,
      'voiceCallCount': instance.voiceCallCount,
      'chat_count': instance.chatCount,
      'photos_count': instance.photosCount,
      'interest_count': instance.interestCount,
      'shortlistCount': instance.shortlistCount,
      'blockedCount': instance.blockedCount,
      'photoRequestCount': instance.photoRequestCount,
      'viewedProfileCount': instance.viewedProfileCount,
      'viewedContactCount': instance.viewedContactCount,
      'annocementBannerArr': instance.annocementBannerArr,
      'todayMatches': instance.todayMatches,
      'recentlyJoinedMember': instance.recentlyJoinedMember,
      'recommendedMatches': instance.recommendedMatches,
      'whoViewMyProfile': instance.whoViewMyProfile,
      'interest_list': instance.receivedInterest,
      'recentlyLoginMember': instance.recentlyLoginMember,
      'recommedMatchesMember': instance.recommedMatchesMember,
      'premiumMatchesMember': instance.premiumMatchesMember,
      'nearByMatchesMember': instance.nearByMatchesMember,
      'featuredMember': instance.featuredMember,
      'successStories': instance.successStories,
      'plan_status': instance.planStatus,
      'current_plan': instance.currentPlan,
      'auto_interest_enabled': instance.autoInterestEnabled,
      'daily_interest_limit': instance.dailyInterestLimit,
      'min_match_percentage': instance.minMatchPercentage,
      'site_setting': instance.siteSetting,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'android_device_id': instance.androidDeviceId,
      'ios_device_id': instance.iosDeviceId,
    };

_AnnouncementBanner _$AnnouncementBannerFromJson(Map<String, dynamic> json) =>
    _AnnouncementBanner(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
      langCode: json['lang_code'] as String?,
      langId: json['lang_id'],
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isDeleted: json['is_deleted'],
    );

Map<String, dynamic> _$AnnouncementBannerToJson(_AnnouncementBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'lang_code': instance.langCode,
      'lang_id': instance.langId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_deleted': instance.isDeleted,
    };
