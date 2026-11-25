// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanListResponseModel _$PlanListResponseModelFromJson(
  Map<String, dynamic> json,
) => _PlanListResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PlanListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlanListResponseModelToJson(
  _PlanListResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_PlanListData _$PlanListDataFromJson(Map<String, dynamic> json) =>
    _PlanListData(
      membershipPlanArr: (json['membership_plans'] as List<dynamic>?)
          ?.map((e) => MembershipPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      offlinePayment: json['offline_payment'] == null
          ? null
          : OfflinePayment.fromJson(
              json['offline_payment'] as Map<String, dynamic>,
            ),
      couponDataListArr: (json['coupon_data_list'] as List<dynamic>?)
          ?.map((e) => CouponData.fromJson(e as Map<String, dynamic>))
          .toList(),
      addOnPlanArr: (json['add_on_plans'] as List<dynamic>?)
          ?.map((e) => AddOnPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: json['payment_methods'] == null
          ? null
          : PaymentMethods.fromJson(
              json['payment_methods'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PlanListDataToJson(_PlanListData instance) =>
    <String, dynamic>{
      'membership_plans': instance.membershipPlanArr,
      'offline_payment': instance.offlinePayment,
      'coupon_data_list': instance.couponDataListArr,
      'add_on_plans': instance.addOnPlanArr,
      'payment_methods': instance.paymentMethods,
    };

_MembershipPlan _$MembershipPlanFromJson(Map<String, dynamic> json) =>
    _MembershipPlan(
      id: (json['id'] as num?)?.toInt(),
      planName: json['plan_name'] as String?,
      inAppProductId: json['in_app_product_id'],
      inAppPrice: (json['in_app_price'] as num?)?.toInt(),
      planType: json['plan_type'] as String?,
      planAmount: json['plan_amount'],
      planCurrency: json['plan_currency'] as String?,
      planCurrencyCode: json['plan_currency_code'] as String?,
      chat: json['chat'] as String?,
      planValidity: json['plan_validity'] as String?,
      planInterest: json['plan_interest'] as String?,
      planViewContact: json['plan_view_contact'] as String?,
      planVideocallMinute: json['plan_videocall_minute'] as String?,
      planAudiocallMinute: json['plan_audiocall_minute'] as String?,
      planDiscount: json['plan_discount'],
      status: json['status'] as String?,
      icon: json['icon'] as String?,
      planDescription: json['plan_description'] as String?,
      aiInterest: json['ai_interest'],
      currencyCode: json['currency_code'] as String?,
      validityDays: (json['validity_days'] as num?)?.toInt(),
      interestsLimit: (json['interests_limit'] as num?)?.toInt(),
      contactViewsLimit: (json['contact_views_limit'] as num?)?.toInt(),
      videoMinutesLimit: (json['video_minutes_limit'] as num?)?.toInt(),
      audioMinutesLimit: (json['audio_minutes_limit'] as num?)?.toInt(),
      viewProfileLimit: json['view_profile_limit'],
      planViewProfile: json['plan_view_profile'],
      canChat: json['can_chat'],
      photoPrivacy: json['photo_privacy'],
      contactPrivacy: json['contact_privacy'],
      isPersonalized: json['is_personalized'],
      inAppPurchaseAndroidId: json['in_app_purchase_android_id'] as String?,
      inAppPurchaseAndroidAmount:
          json['in_app_purchase_android_amount'] as String?,
      inAppPurchaseIosId: json['in_app_purchase_ios_id'] as String?,
      inAppPurchaseIosAmount: json['in_app_purchase_ios_amount'] as String?,
    );

Map<String, dynamic> _$MembershipPlanToJson(_MembershipPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan_name': instance.planName,
      'in_app_product_id': instance.inAppProductId,
      'in_app_price': instance.inAppPrice,
      'plan_type': instance.planType,
      'plan_amount': instance.planAmount,
      'plan_currency': instance.planCurrency,
      'plan_currency_code': instance.planCurrencyCode,
      'chat': instance.chat,
      'plan_validity': instance.planValidity,
      'plan_interest': instance.planInterest,
      'plan_view_contact': instance.planViewContact,
      'plan_videocall_minute': instance.planVideocallMinute,
      'plan_audiocall_minute': instance.planAudiocallMinute,
      'plan_discount': instance.planDiscount,
      'status': instance.status,
      'icon': instance.icon,
      'plan_description': instance.planDescription,
      'ai_interest': instance.aiInterest,
      'currency_code': instance.currencyCode,
      'validity_days': instance.validityDays,
      'interests_limit': instance.interestsLimit,
      'contact_views_limit': instance.contactViewsLimit,
      'video_minutes_limit': instance.videoMinutesLimit,
      'audio_minutes_limit': instance.audioMinutesLimit,
      'view_profile_limit': instance.viewProfileLimit,
      'plan_view_profile': instance.planViewProfile,
      'can_chat': instance.canChat,
      'photo_privacy': instance.photoPrivacy,
      'contact_privacy': instance.contactPrivacy,
      'is_personalized': instance.isPersonalized,
      'in_app_purchase_android_id': instance.inAppPurchaseAndroidId,
      'in_app_purchase_android_amount': instance.inAppPurchaseAndroidAmount,
      'in_app_purchase_ios_id': instance.inAppPurchaseIosId,
      'in_app_purchase_ios_amount': instance.inAppPurchaseIosAmount,
    };

_OfflinePayment _$OfflinePaymentFromJson(Map<String, dynamic> json) =>
    _OfflinePayment(
      id: (json['id'] as num?)?.toInt(),
      accountHolderNumber: json['account_holder_number'] as String?,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      bankBranch: json['bank_branch'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      qrCode: json['qr_code'] as String?,
      paymentGatewayImg: json['payment_gateway_img'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OfflinePaymentToJson(_OfflinePayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_holder_number': instance.accountHolderNumber,
      'account_number': instance.accountNumber,
      'bank_name': instance.bankName,
      'bank_branch': instance.bankBranch,
      'ifsc_code': instance.ifscCode,
      'qr_code': instance.qrCode,
      'payment_gateway_img': instance.paymentGatewayImg,
      'status': instance.status,
    };

_PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    _PaymentMethods(
      inAppPayment: json['in_app_payment'] as String?,
      paymentName: json['payment_name'] as String?,
      clientId: json['client_id'] as String?,
      clientSecret: json['client_secret'] as String?,
      paymentMode: json['payment_mode'] as String?,
      paypal: json['paypal'] as String?,
    );

Map<String, dynamic> _$PaymentMethodsToJson(_PaymentMethods instance) =>
    <String, dynamic>{
      'in_app_payment': instance.inAppPayment,
      'payment_name': instance.paymentName,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'payment_mode': instance.paymentMode,
      'paypal': instance.paypal,
    };

_CouponData _$CouponDataFromJson(Map<String, dynamic> json) => _CouponData(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String?,
  planId: (json['plan_id'] as num?)?.toInt(),
  coupanCode: json['coupan_code'] as String?,
  discountAmount: (json['discount_amount'] as num?)?.toInt(),
  activeFrom: json['active_from'] as String?,
  expiredOn: json['expired_on'] as String?,
);

Map<String, dynamic> _$CouponDataToJson(_CouponData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'plan_id': instance.planId,
      'coupan_code': instance.coupanCode,
      'discount_amount': instance.discountAmount,
      'active_from': instance.activeFrom,
      'expired_on': instance.expiredOn,
    };

_AddOnPlan _$AddOnPlanFromJson(Map<String, dynamic> json) => _AddOnPlan(
  id: (json['id'] as num?)?.toInt(),
  packageTitle: json['package_title'] as String?,
  packageCategory: json['package_category'] as String?,
  packageCount: json['package_count'],
  packageAmount: json['package_amount'],
  currencyCode: json['currency_code'] as String?,
  packageCurrency: json['package_currency'] as String?,
  planCurrency: json['plan_currency'] as String?,
  inAppPurchaseAndroidId: json['in_app_purchase_android_id'] as String?,
  inAppPurchaseAndroidAmount: json['in_app_purchase_android_amount'] as String?,
  inAppPurchaseIosId: json['in_app_purchase_ios_id'] as String?,
  inAppPurchaseIosAmount: json['in_app_purchase_ios_amount'] as String?,
  inAppProductId: json['in_app_product_id'],
  description: json['description'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$AddOnPlanToJson(_AddOnPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package_title': instance.packageTitle,
      'package_category': instance.packageCategory,
      'package_count': instance.packageCount,
      'package_amount': instance.packageAmount,
      'currency_code': instance.currencyCode,
      'package_currency': instance.packageCurrency,
      'plan_currency': instance.planCurrency,
      'in_app_purchase_android_id': instance.inAppPurchaseAndroidId,
      'in_app_purchase_android_amount': instance.inAppPurchaseAndroidAmount,
      'in_app_purchase_ios_id': instance.inAppPurchaseIosId,
      'in_app_purchase_ios_amount': instance.inAppPurchaseIosAmount,
      'in_app_product_id': instance.inAppProductId,
      'description': instance.description,
      'status': instance.status,
    };

_CurrentPlanResponseModel _$CurrentPlanResponseModelFromJson(
  Map<String, dynamic> json,
) => _CurrentPlanResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CurrentPlanData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CurrentPlanResponseModelToJson(
  _CurrentPlanResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_CurrentPlanData _$CurrentPlanDataFromJson(Map<String, dynamic> json) =>
    _CurrentPlanData(
      currentPlanArr: json['current_plan'] == null
          ? null
          : CurrentPlan.fromJson(json['current_plan'] as Map<String, dynamic>),
      addOnPlanArr: (json['add_on_plan'] as List<dynamic>?)
          ?.map((e) => AddOnPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrentPlanDataToJson(_CurrentPlanData instance) =>
    <String, dynamic>{
      'current_plan': instance.currentPlanArr,
      'add_on_plan': instance.addOnPlanArr,
    };

_CurrentPlan _$CurrentPlanFromJson(Map<String, dynamic> json) => _CurrentPlan(
  id: json['id'],
  memberId: json['member_id'],
  name: json['name'] as String?,
  email: json['email'] as String?,
  planName: json['plan_name'] as String?,
  planActivated: json['plan_activated'] as String?,
  planExpired: json['plan_expired'] as String?,
  grandTotal: json['grand_total'],
  planTotalDuration: json['plan_total_duration'] as String?,
  planCurrency: json['plan_currency'] as String?,
  discountAmount: json['discount_amount'],
  planTotalInterest: json['plan_total_interest'] as String?,
  interestUsed: json['interest_used'],
  planViewContact: json['plan_view_contact'] as String?,
  viewContactsUsed: json['view_contacts_used'],
  planVideoCallRemaining: json['plan_video_call_remaining'] as String?,
  planAudioCallRemaining: json['plan_audio_call_remaining'] as String?,
  chat: json['chat'] as String?,
  status: json['status'] as String?,
  planActivateDate: json['plan_activate_date'] as String?,
  planExpiryDate: json['plan_expiry_date'] as String?,
  totalValidityDays: json['total_validity_days'],
  planValidityDays: json['plan_validity_days'],
  currencyCode: json['currency_code'] as String?,
  interestsTotal: json['interests_total'],
  interestsUsed: json['interests_used'],
  contactViewsTotal: json['contact_views_total'],
  contactViewsUsed: json['contact_views_used'],
  videoMinutesTotal: json['video_minutes_total'],
  videoMinutesUsed: json['video_minutes_used'],
  audioMinutesTotal: json['audio_minutes_total'],
  audioMinutesUsed: json['audio_minutes_used'],
  canChat: json['can_chat'],
  paymentMode: json['payment_mode'] as String?,
  downloadInvoice: json['download_invoice'] as String?,
  planViewProfile: json['plan_view_profile'],
  addonViewProfile: json['addon_view_profile'],
  viewProfileTotal: json['view_profile_total'],
  viewProfileUsed: json['view_profile_used'],
  planDescription: json['plan_description'] as String?,
  aiInterest: json['ai_interest'],
  autoRenewing: json['auto_renewing'],
);

Map<String, dynamic> _$CurrentPlanToJson(_CurrentPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'name': instance.name,
      'email': instance.email,
      'plan_name': instance.planName,
      'plan_activated': instance.planActivated,
      'plan_expired': instance.planExpired,
      'grand_total': instance.grandTotal,
      'plan_total_duration': instance.planTotalDuration,
      'plan_currency': instance.planCurrency,
      'discount_amount': instance.discountAmount,
      'plan_total_interest': instance.planTotalInterest,
      'interest_used': instance.interestUsed,
      'plan_view_contact': instance.planViewContact,
      'view_contacts_used': instance.viewContactsUsed,
      'plan_video_call_remaining': instance.planVideoCallRemaining,
      'plan_audio_call_remaining': instance.planAudioCallRemaining,
      'chat': instance.chat,
      'status': instance.status,
      'plan_activate_date': instance.planActivateDate,
      'plan_expiry_date': instance.planExpiryDate,
      'total_validity_days': instance.totalValidityDays,
      'plan_validity_days': instance.planValidityDays,
      'currency_code': instance.currencyCode,
      'interests_total': instance.interestsTotal,
      'interests_used': instance.interestsUsed,
      'contact_views_total': instance.contactViewsTotal,
      'contact_views_used': instance.contactViewsUsed,
      'video_minutes_total': instance.videoMinutesTotal,
      'video_minutes_used': instance.videoMinutesUsed,
      'audio_minutes_total': instance.audioMinutesTotal,
      'audio_minutes_used': instance.audioMinutesUsed,
      'can_chat': instance.canChat,
      'payment_mode': instance.paymentMode,
      'download_invoice': instance.downloadInvoice,
      'plan_view_profile': instance.planViewProfile,
      'addon_view_profile': instance.addonViewProfile,
      'view_profile_total': instance.viewProfileTotal,
      'view_profile_used': instance.viewProfileUsed,
      'plan_description': instance.planDescription,
      'ai_interest': instance.aiInterest,
      'auto_renewing': instance.autoRenewing,
    };

_CheckoutResponseModel _$CheckoutResponseModelFromJson(
  Map<String, dynamic> json,
) => _CheckoutResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CheckoutData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CheckoutResponseModelToJson(
  _CheckoutResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_CheckoutData _$CheckoutDataFromJson(Map<String, dynamic> json) =>
    _CheckoutData(
      plan: json['resultList'] == null
          ? null
          : MembershipPlan.fromJson(json['resultList'] as Map<String, dynamic>),
      addOnPackages: (json['add_on_packages'] as List<dynamic>?)
          ?.map((e) => AddOnPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckoutDataToJson(_CheckoutData instance) =>
    <String, dynamic>{
      'resultList': instance.plan,
      'add_on_packages': instance.addOnPackages,
    };

_PlanHistoryResponseModel _$PlanHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => _PlanHistoryResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PlanHistoryData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlanHistoryResponseModelToJson(
  _PlanHistoryResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_PlanHistoryData _$PlanHistoryDataFromJson(Map<String, dynamic> json) =>
    _PlanHistoryData(
      resultCount: (json['resultCount'] as num?)?.toInt(),
      resultList: (json['resultList'] as List<dynamic>?)
          ?.map((e) => CurrentPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanHistoryDataToJson(_PlanHistoryData instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'resultList': instance.resultList,
    };

_CalculatePlanResponseModel _$CalculatePlanResponseModelFromJson(
  Map<String, dynamic> json,
) => _CalculatePlanResponseModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CalculatePlanData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CalculatePlanResponseModelToJson(
  _CalculatePlanResponseModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_CalculatePlanData _$CalculatePlanDataFromJson(Map<String, dynamic> json) =>
    _CalculatePlanData(
      success: json['success'] as bool?,
      currency: json['currency'] as String?,
      planAmount: json['plan_amount'],
      planDiscount: json['plan_discount'],
      addonTotal: json['addon_total'],
      couponDiscount: json['coupon_discount'],
      taxAmount: json['tax_amount'],
      grandTotal: json['grand_total'],
      couponApplied: json['coupon_applied'] as bool?,
      couponCode: json['coupon_code'] as String?,
      taxName: json['tax_name'] as String?,
      taxApplicable: json['tax_applicable'] as String?,
      taxPercentage: json['tax_percentage'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CalculatePlanDataToJson(_CalculatePlanData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currency': instance.currency,
      'plan_amount': instance.planAmount,
      'plan_discount': instance.planDiscount,
      'addon_total': instance.addonTotal,
      'coupon_discount': instance.couponDiscount,
      'tax_amount': instance.taxAmount,
      'grand_total': instance.grandTotal,
      'coupon_applied': instance.couponApplied,
      'coupon_code': instance.couponCode,
      'tax_name': instance.taxName,
      'tax_applicable': instance.taxApplicable,
      'tax_percentage': instance.taxPercentage,
      'message': instance.message,
    };
