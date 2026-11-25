import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_models.freezed.dart';
part 'plan_models.g.dart';

@freezed
abstract class PlanListResponseModel with _$PlanListResponseModel {
  const factory PlanListResponseModel({
    int? code,
    String? status,
    String? message,
    PlanListData? data,
  }) = _PlanListResponseModel;

  factory PlanListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlanListResponseModelFromJson(processPlanListResponseModelJson(json));
}

@freezed
abstract class PlanListData with _$PlanListData {
  const factory PlanListData({
    @JsonKey(name: 'membership_plans') List<MembershipPlan>? membershipPlanArr,
    @JsonKey(name: 'offline_payment') OfflinePayment? offlinePayment,
    @JsonKey(name: 'coupon_data_list') List<CouponData>? couponDataListArr,
    @JsonKey(name: 'add_on_plans') List<AddOnPlan>? addOnPlanArr,
    @JsonKey(name: 'payment_methods') PaymentMethods? paymentMethods,
  }) = _PlanListData;

  factory PlanListData.fromJson(Map<String, dynamic> json) =>
      _$PlanListDataFromJson(json);
}

@freezed
abstract class MembershipPlan with _$MembershipPlan {
  const factory MembershipPlan({
    int? id,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'in_app_product_id') dynamic inAppProductId,
    @JsonKey(name: 'in_app_price') int? inAppPrice,
    @JsonKey(name: 'plan_type') String? planType,
    @JsonKey(name: 'plan_amount') dynamic planAmount,
    @JsonKey(name: 'plan_currency') String? planCurrency,
    @JsonKey(name: 'plan_currency_code') String? planCurrencyCode,
    String? chat,
    @JsonKey(name: 'plan_validity') String? planValidity,
    @JsonKey(name: 'plan_interest') String? planInterest,
    @JsonKey(name: 'plan_view_contact') String? planViewContact,
    @JsonKey(name: 'plan_videocall_minute') String? planVideocallMinute,
    @JsonKey(name: 'plan_audiocall_minute') String? planAudiocallMinute,
    @JsonKey(name: 'plan_discount') dynamic planDiscount,
    String? status,
    String? icon,

    // New API Fields
    @JsonKey(name: 'plan_description') String? planDescription,
    @JsonKey(name: 'ai_interest') dynamic aiInterest,
    @JsonKey(name: 'currency_code') String? currencyCode,
    @JsonKey(name: 'validity_days') int? validityDays,
    @JsonKey(name: 'interests_limit') int? interestsLimit,
    @JsonKey(name: 'contact_views_limit') int? contactViewsLimit,
    @JsonKey(name: 'video_minutes_limit') int? videoMinutesLimit,
    @JsonKey(name: 'audio_minutes_limit') int? audioMinutesLimit,
    @JsonKey(name: 'view_profile_limit') dynamic viewProfileLimit,
    @JsonKey(name: 'plan_view_profile') dynamic planViewProfile,
    @JsonKey(name: 'can_chat') dynamic canChat,
    @JsonKey(name: 'photo_privacy') dynamic photoPrivacy,
    @JsonKey(name: 'contact_privacy') dynamic contactPrivacy,
    @JsonKey(name: 'is_personalized') dynamic isPersonalized,
    @JsonKey(name: 'in_app_purchase_android_id') String? inAppPurchaseAndroidId,
    @JsonKey(name: 'in_app_purchase_android_amount') String? inAppPurchaseAndroidAmount,
    @JsonKey(name: 'in_app_purchase_ios_id') String? inAppPurchaseIosId,
    @JsonKey(name: 'in_app_purchase_ios_amount') String? inAppPurchaseIosAmount,
  }) = _MembershipPlan;

  factory MembershipPlan.fromJson(Map<String, dynamic> json) =>
      _$MembershipPlanFromJson(json);
}

@freezed
abstract class OfflinePayment with _$OfflinePayment {
  const factory OfflinePayment({
    int? id,
    @JsonKey(name: 'account_holder_number') String? accountHolderNumber,
    @JsonKey(name: 'account_number') String? accountNumber,
    @JsonKey(name: 'bank_name') String? bankName,
    @JsonKey(name: 'bank_branch') String? bankBranch,
    @JsonKey(name: 'ifsc_code') String? ifscCode,
    @JsonKey(name: 'qr_code') String? qrCode,
    @JsonKey(name: 'payment_gateway_img') String? paymentGatewayImg,
    String? status,
  }) = _OfflinePayment;

  factory OfflinePayment.fromJson(Map<String, dynamic> json) =>
      _$OfflinePaymentFromJson(json);
}

@freezed
abstract class PaymentMethods with _$PaymentMethods {
  const factory PaymentMethods({
    @JsonKey(name: 'in_app_payment') String? inAppPayment,
    @JsonKey(name: 'payment_name') String? paymentName,
    @JsonKey(name: 'client_id') String? clientId,
    @JsonKey(name: 'client_secret') String? clientSecret,
    @JsonKey(name: 'payment_mode') String? paymentMode,
    String? paypal,
  }) = _PaymentMethods;

  factory PaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsFromJson(json);
}

@freezed
abstract class CouponData with _$CouponData {
  const factory CouponData({
    int? id,
    String? status,
    @JsonKey(name: 'plan_id') int? planId,
    @JsonKey(name: 'coupan_code') String? coupanCode,
    @JsonKey(name: 'discount_amount') int? discountAmount,
    @JsonKey(name: 'active_from') String? activeFrom,
    @JsonKey(name: 'expired_on') String? expiredOn,
  }) = _CouponData;

  factory CouponData.fromJson(Map<String, dynamic> json) =>
      _$CouponDataFromJson(json);
}

@freezed
abstract class AddOnPlan with _$AddOnPlan {
  const factory AddOnPlan({
    int? id,
    @JsonKey(name: 'package_title') String? packageTitle,
    @JsonKey(name: 'package_category') String? packageCategory,
    @JsonKey(name: 'package_count') dynamic packageCount,
    @JsonKey(name: 'package_amount') dynamic packageAmount,
    @JsonKey(name: 'currency_code') String? currencyCode,
    @JsonKey(name: 'package_currency') String? packageCurrency,
    @JsonKey(name: 'plan_currency') String? planCurrency,
    @JsonKey(name: 'in_app_purchase_android_id') String? inAppPurchaseAndroidId,
    @JsonKey(name: 'in_app_purchase_android_amount') String? inAppPurchaseAndroidAmount,
    @JsonKey(name: 'in_app_purchase_ios_id') String? inAppPurchaseIosId,
    @JsonKey(name: 'in_app_purchase_ios_amount') String? inAppPurchaseIosAmount,
    @JsonKey(name: 'in_app_product_id') dynamic inAppProductId,
    String? description,
    String? status,
  }) = _AddOnPlan;

  factory AddOnPlan.fromJson(Map<String, dynamic> json) =>
      _$AddOnPlanFromJson(json);
}

@freezed
abstract class CurrentPlanResponseModel with _$CurrentPlanResponseModel {
  const factory CurrentPlanResponseModel({
    int? code,
    String? status,
    String? message,
    CurrentPlanData? data,
  }) = _CurrentPlanResponseModel;

  factory CurrentPlanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentPlanResponseModelFromJson(json);
}

@freezed
abstract class CurrentPlanData with _$CurrentPlanData {
  const factory CurrentPlanData({
    @JsonKey(name: 'current_plan') CurrentPlan? currentPlanArr,
    @JsonKey(name: 'add_on_plan') List<AddOnPlan>? addOnPlanArr,
  }) = _CurrentPlanData;

  factory CurrentPlanData.fromJson(Map<String, dynamic> json) =>
      _$CurrentPlanDataFromJson(json);
}

@freezed
abstract class CurrentPlan with _$CurrentPlan {
  const factory CurrentPlan({
    dynamic id,
    @JsonKey(name: 'member_id') dynamic memberId,
    String? name,
    String? email,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'plan_activated') String? planActivated,
    @JsonKey(name: 'plan_expired') String? planExpired,
    @JsonKey(name: 'grand_total') dynamic grandTotal,
    @JsonKey(name: 'plan_total_duration') String? planTotalDuration,
    @JsonKey(name: 'plan_currency') String? planCurrency,
    @JsonKey(name: 'discount_amount') dynamic discountAmount,
    @JsonKey(name: 'plan_total_interest') String? planTotalInterest,
    @JsonKey(name: 'interest_used') dynamic interestUsed,
    @JsonKey(name: 'plan_view_contact') String? planViewContact,
    @JsonKey(name: 'view_contacts_used') dynamic viewContactsUsed,
    @JsonKey(name: 'plan_video_call_remaining') String? planVideoCallRemaining,
    @JsonKey(name: 'plan_audio_call_remaining') String? planAudioCallRemaining,
    String? chat,
    String? status,

    // New API Fields
    @JsonKey(name: 'plan_activate_date') String? planActivateDate,
    @JsonKey(name: 'plan_expiry_date') String? planExpiryDate,
    @JsonKey(name: 'total_validity_days') dynamic totalValidityDays,
    @JsonKey(name: 'plan_validity_days') dynamic planValidityDays,
    @JsonKey(name: 'currency_code') String? currencyCode,
    @JsonKey(name: 'interests_total') dynamic interestsTotal,
    @JsonKey(name: 'interests_used') dynamic interestsUsed,
    @JsonKey(name: 'contact_views_total') dynamic contactViewsTotal,
    @JsonKey(name: 'contact_views_used') dynamic contactViewsUsed,
    @JsonKey(name: 'video_minutes_total') dynamic videoMinutesTotal,
    @JsonKey(name: 'video_minutes_used') dynamic videoMinutesUsed,
    @JsonKey(name: 'audio_minutes_total') dynamic audioMinutesTotal,
    @JsonKey(name: 'audio_minutes_used') dynamic audioMinutesUsed,
    @JsonKey(name: 'can_chat') dynamic canChat,
    @JsonKey(name: 'payment_mode') String? paymentMode,
    @JsonKey(name: 'download_invoice') String? downloadInvoice,
    @JsonKey(name: 'plan_view_profile') dynamic planViewProfile,
    @JsonKey(name: 'addon_view_profile') dynamic addonViewProfile,
    @JsonKey(name: 'view_profile_total') dynamic viewProfileTotal,
    @JsonKey(name: 'view_profile_used') dynamic viewProfileUsed,
    @JsonKey(name: 'plan_description') String? planDescription,
    @JsonKey(name: 'ai_interest') dynamic aiInterest,
    @JsonKey(name: 'auto_renewing') dynamic autoRenewing,
  }) = _CurrentPlan;

  factory CurrentPlan.fromJson(Map<String, dynamic> json) =>
      _$CurrentPlanFromJson(json);
}

@freezed
abstract class CheckoutResponseModel with _$CheckoutResponseModel {
  const factory CheckoutResponseModel({
    int? code,
    String? status,
    String? message,
    CheckoutData? data,
  }) = _CheckoutResponseModel;

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseModelFromJson(json);
}

@freezed
abstract class CheckoutData with _$CheckoutData {
  const factory CheckoutData({
    @JsonKey(name: 'resultList') MembershipPlan? plan,
    @JsonKey(name: 'add_on_packages') List<AddOnPlan>? addOnPackages,
  }) = _CheckoutData;

  factory CheckoutData.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDataFromJson(json);
}

@freezed
abstract class PlanHistoryResponseModel with _$PlanHistoryResponseModel {
  const factory PlanHistoryResponseModel({
    int? code,
    String? status,
    String? message,
    PlanHistoryData? data,
  }) = _PlanHistoryResponseModel;

  factory PlanHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlanHistoryResponseModelFromJson(json);
}

@freezed
abstract class PlanHistoryData with _$PlanHistoryData {
  const factory PlanHistoryData({
    int? resultCount,
    List<CurrentPlan>? resultList,
  }) = _PlanHistoryData;

  factory PlanHistoryData.fromJson(Map<String, dynamic> json) =>
      _$PlanHistoryDataFromJson(json);
}

@freezed
abstract class CalculatePlanResponseModel with _$CalculatePlanResponseModel {
  const factory CalculatePlanResponseModel({
    int? code,
    String? status,
    String? message,
    CalculatePlanData? data,
  }) = _CalculatePlanResponseModel;

  factory CalculatePlanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CalculatePlanResponseModelFromJson(json);
}

@freezed
abstract class CalculatePlanData with _$CalculatePlanData {
  const factory CalculatePlanData({
    bool? success,
    String? currency,
    @JsonKey(name: 'plan_amount') dynamic planAmount,
    @JsonKey(name: 'plan_discount') dynamic planDiscount,
    @JsonKey(name: 'addon_total') dynamic addonTotal,
    @JsonKey(name: 'coupon_discount') dynamic couponDiscount,
    @JsonKey(name: 'tax_amount') dynamic taxAmount,
    @JsonKey(name: 'grand_total') dynamic grandTotal,
    @JsonKey(name: 'coupon_applied') bool? couponApplied,
    @JsonKey(name: 'coupon_code') String? couponCode,
    @JsonKey(name: 'tax_name') String? taxName,
    @JsonKey(name: 'tax_applicable') String? taxApplicable,
    @JsonKey(name: 'tax_percentage') dynamic taxPercentage,
    String? message,
  }) = _CalculatePlanData;

  factory CalculatePlanData.fromJson(Map<String, dynamic> json) =>
      _$CalculatePlanDataFromJson(json);
}

Map<String, dynamic> processPlanListResponseModelJson(Map<String, dynamic> json) {
  final Map<String, dynamic> processedJson = Map<String, dynamic>.from(json);

  if (json['data'] is List) {
    processedJson['data'] = {
      'membership_plans': json['data'],
    };
  } else if (json['data'] is Map) {
    final dataMap = Map<String, dynamic>.from(json['data'] as Map);
    if (!dataMap.containsKey('membership_plans')) {
      if (dataMap.containsKey('membershipPlanArr')) {
        dataMap['membership_plans'] = dataMap['membershipPlanArr'];
      } else if (dataMap.containsKey('membership_plan')) {
        dataMap['membership_plans'] = dataMap['membership_plan'];
      } else if (dataMap.containsKey('plans')) {
        dataMap['membership_plans'] = dataMap['plans'];
      } else if (dataMap.containsKey('resultList')) {
        dataMap['membership_plans'] = dataMap['resultList'];
      }
    }
    processedJson['data'] = dataMap;
  }

  return processedJson;
}
