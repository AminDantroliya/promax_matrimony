import '../core/config/env_config.dart';

String baseUrl = EnvConfig.baseUrl;

const bool isSecureUrl = true;

//-------------------- api endpoints--------------------

// Token, App Config & Site Settings API (Admin Dynamic Theme & Configuration)
const String getTokenApi = "common-request/get-token";
const String getAppConfigApi =
    getTokenApi; // Backend returns dynamic theme, layout variants & feature flags here
const String getDropdownDataApi = "common-request/get-common-dropdown-list";
const String getSingleDropdownDataApi = "common-request/get-dropdown-value";
const String getDependentDropdownDataApi =
    "common-request/get-dependency-dropdown";
const String getSiteSettingApi = "common-request/get-site-data";
const String contactUsApi = "contact-us";
const String getCmsDataApi = "cms/page";

// Login
const String loginApi = "check-login";
const String firebaseLoginApi = "firebase-login";
const String forgotPasswordApi = "forgot-password";
const String generateOtpApi = "send-otp";
const String checkMobileApi = "check-mobile";
const String resendOtpApi = "resend-otp";
const String verifyOtpApi = "verify-otp";
const String logoutApi = "logout";

// Dynamic Form Fields (POST with type: register | edit_profile | advance_search | quick_search | ai_match_search)
const String getDynamicFormFieldsApi = "common-request/dynamic/fields";
const String getDynamicRegisterFormApi = getDynamicFormFieldsApi;
const String registerApi = "register";
const String registerNextApi = "register/register-next"; // legacy
const String registerNextStepApi = "register/next-step";
const String registerResendOtpApi = "register/resend-otp";
const String registerVerifyOtpApi = "register/verify-otp";
const String generateAboutMeApi = "register/generate-about-me";
const String registerUploadPhotoApi = "register/upload-photo";
const String registerUploadIdProofApi = "register/upload-id-proof";
const String generateAadhaarOtpApi = "register/generate-aadhar-otp";
const String verifyAadhaarOtpApi = "register/verify-aadhar-otp";
const String verifyPanApi = "register/verify-pan-card";
const String verifyVoterIdApi = "register/voter-id-card";


// Dashboard
const String getNotificationListApi = "notification/list";
const String saveDeviceTokenApi = "save-device-token";

// Notification
const String getDashboardDataApi = "dashboard";

// Success Story
const String getSuccessStoryListApi = "success-story";
const String getSuccessStoryDetailsApi = "success-story/details";
const String addSuccessStoryApi = "success-story/add-story";

// Change Password
const String changePasswordApi = "privacy-settings/change-password";
const String changePhotoPrivacyApi = "privacy-setting/photo-visibility";
const String changeContactPrivacyApi = "privacy-setting/contact-setting";
const String getPrivacySettingsApi = "privacy-settings";
const String updatePrivacySettingsApi = "privacy-settings/update";
const String updateAlertsApi = "privacy-settings/update-alerts";
const String updateInterestMessageApi =
    "privacy-settings/update-interest-message";

// My Profile
const String getMyProfileApi = "my-profile";
const String updateLatLongApi = "my-profile/update-lat-long";
const String editMyProfileApi = "my-profile/edit";
const String requestDeleteMyProfileApi = "my-profile/delete-request";
const String uploadMyPhotoApi = "upload-photos";
const String deleteMyPhotosApi = "delete-photos";
const String deleteMyPhotoApi = "delete-photos";
const String uploadMyIdProofApi = "upload-id-proof";
const String deleteMyIdProofApi = "delete-id-proof";
const String uploadMyHoroscopeApi = "upload-horoscope";
const String deleteHoroscopeApi = "delete-horoscope";
const String removeHoroscopeApi = "my-profile/remove-horoscope";
const String removeIdProofApi = "my-profile/remove-id-proof";
const String removePhotoApi = "my-profile/remove-photo";
const String verifyEmailApi = "my-profile/verify-email";
const String verifyMobileGenerateOtpApi = "mobile-verification/generate";
const String verifyMobileResendOtpApi = "mobile-verification/resend";
const String verifyMobileVerifyOtpApi = "mobile-verification/verify";
const String verifyMobileVerifyFirebaseApi = "mobile-verification/verify-number";
const String generateAadhaarOtpProfileApi = "my-profile/generate-aadhar-otp";
const String verifyAadhaarOtpProfileApi = "my-profile/verify-aadhar-otp";
const String verifyPanProfileApi = "my-profile/verify-pan-card";
const String verifyVoterIdProfileApi = "my-profile/voter-id-card";

// Other Member Profile
const String getOtherMemberProfileApi = "user-profile";
const String viewContactDetailsApi = "view-contact";

// Activity
const String getRecentJoinedListApi = "matches/recenly-joined";
const String getRecentLoginListApi = "matches/recenly-login";
const String getFeaturedMemberListApi = "matches/featured-member";
const String getViewedProfileListApi = "viewed-profile";
const String getViewedContactListApi = "viewed-contact";

const String getShortlistedListApi = "shortlist";
const String shortlistActionApi = "shortlist/add-remove";

const String getBlockedListApi = "blocklist";
const String blockActionApi = "blocklist/add-remove";

const String getPhotoRequestListApi = "photo-request";
const String sendPhotoRequestApi = "photo-request/send";
const String photoRequestActionApi = "photo-request/accept-reject";
const String removePhotoRequestApi = "photo-request/remove";

const String getConnectionListApi = "express-interest";
const String sendConnectionApi = "express-interest/send";
const String connectionActionApi = "express-interest/accept-reject";
const String removeConnectionApi = "express-interest/remove";

// Membership Plan
const String getCurrentPlanApi = "membership-plan/current-plan";
const String getPlanListApi = "membership-plan";
const String getPlanCouponListApi = "coupon-code-list";
const String applyCouponCodeApi = "apply-coupon-code";
final String paymentProcess = "${baseUrl}payment-process/";
final String paymentSuccess = "${baseUrl}payment-responce/success";
final String paymentFailed = "${baseUrl}payment-responce/failed";
const String assignPlanApi = "payment-status";
const String getPlanHistoryApi = "membership-plan/plan-history";
const String getPlanCheckoutApi = "membership-plan/checkout";
const String calculatePlanPriceApi = "membership-plan/calculate";
const String assignPlanNewApi = "membership-plan/assign-plan";
const String getAddonPackageListApi = "membership-plan/add-on-package-list";

const String reportToAdminApi = "report-profile";

// Matches
const String getRecommendedMatchesApi = "matches/recommended";
const String getPremiumMatchesApi = "matches/premium";
const String getNearByMeMatchesApi = "matches/near-by-me";
const String getSuggestedMatchesApi = "matches/suggested";
const String getPremiumMemberMatchesApi = getPremiumMatchesApi;

const String getAdminMatchesApi = "receive-admin-matches";
const String adminMatchesActionsApi = "receive-admin-match/action-update";

// Personalization Matches
const String receiveAdminMatchesApi = "receive-admin-matches";
const String acceptRejectAdminMatchesApi =
    "receive-admin-matches/accept-reject";

// Personalization Meetings
const String getMyMeetingsApi = "my-meeting";
const String acceptRejectMeetingApi = "my-meeting/accept-reject";

// Personalization Manager Chat
const String getPersonalizeChatMessagesApi = "personalize-chat/get-messages";
const String sendPersonalizeChatMessageApi = "personalize-chat/send-message";

// Chat
const String getChatMemberListApi = "chat/list";
const String getChatConversationListApi = "chat/conversation-list";
const String sendChatMessageApi = "chat/send-message";
const String chatRequestApi = "chat/request";
const String chatBlockUnblockApi = "chat/block-unblock";

// Call
const String videoCallHistoryListApi = "call-history";
const String voiceCallHistoryListApi = "call-history";
const String updateCallHistoryApi = "call-history/add-call-minutes";

const String searchResultListApi = "search-result";
const String saveSearchApi = "saved-search/save";
const String getSavedSearchListApi = "saved-search/list";
const String deleteSavedSearchApi = "saved-search/delete";

// Meeting
const String getMyMeetingListApi = "my-meetings";
const String meetingActionApi = "my-meeting/action-update";

// AI Interest
const String aiInterestUpdateSettingsApi = "ai-interest/update-settings";
const String aiInterestListApi = "ai-interest/list";

// AI Matchmaking
const String aiMatchMakingListApi = "ai-match-making/list";
const String aiMatchMakingBestMatchesTodayApi =
    "ai-match-making/best-matches-today";


// Events
const String getEventListApi = "events";
const String getEventDetailsApi = "events"; // events/{id}
const String bookEventApi = "events/book";
const String getRegisteredEventsApi = "registered-events";
