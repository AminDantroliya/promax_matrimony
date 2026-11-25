// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
//
// FlavorConfig: compile-time fallback values.
// Only holds values the backend CANNOT provide:
//   • Base API URL (needed BEFORE the /app-config call can be made)
//   • Store URLs (compile-time, per-client)
//   • Fallback colors & feature flags (used only when API is unreachable)
//
// Every widget reads AppConfig, never FlavorConfig directly.

import 'package:flutter/material.dart';
import '../../core/config/env_config.dart';

// ---------------------------------------------------------------------------
// FlavorThemeDefaults — fallback branding values (Layer 2)
// ---------------------------------------------------------------------------

class FlavorThemeDefaults {
  final String appName;
  final Color primaryColor;
  final Color accentColor;
  final Color gradientStart;
  final Color gradientEnd;
  final Color scaffoldBgColor;
  final String fontFamily;
  final double borderRadius;
  final String buttonStyle;
  final String profileCardStyle;
  final String otherProfileDesign;
  final String myProfileDesign;
  final String dashboardDesign;
  final String bottomBarDesign;
  final String privacySettingsDesign;
  final String textFieldDesign;
  final double textFieldRadius;

  // Optional dynamic theme color overrides
  final Color? progressColor;
  final Color? progressGradientStart;
  final Color? progressGradientEnd;
  final Color? premiumBadgeColor;
  final Color? premiumBadgeTextColor;
  final Color? moreMenuBgColor;
  final Color? moreOptionCardBgColor;

  // Regional & Contact Fallbacks
  final String defaultCountryCode;
  final String defaultCountryIso;
  final String defaultCountryFlag;
  final String defaultLanguageCode;
  final int maxPhotosAllowed;
  final String? supportWhatsapp;
  final String? supportPhone;
  final String? supportEmail;
  final String? websiteUrl;

  const FlavorThemeDefaults({
    required this.appName,
    required this.primaryColor,
    required this.accentColor,
    required this.gradientStart,
    required this.gradientEnd,
    required this.scaffoldBgColor,
    required this.fontFamily,
    required this.borderRadius,
    required this.buttonStyle,
    required this.profileCardStyle,
    required this.otherProfileDesign,
    required this.myProfileDesign,
    required this.dashboardDesign,
    this.bottomBarDesign = 'design_1',
    this.privacySettingsDesign = 'design_1',
    this.textFieldDesign = 'card',
    this.textFieldRadius = 20.0,
    this.progressColor,
    this.progressGradientStart,
    this.progressGradientEnd,
    this.premiumBadgeColor,
    this.premiumBadgeTextColor,
    this.moreMenuBgColor,
    this.moreOptionCardBgColor,
    this.defaultCountryCode = '+91',
    this.defaultCountryIso = 'IN',
    this.defaultCountryFlag = '🇮🇳',
    this.defaultLanguageCode = 'en',
    this.maxPhotosAllowed = 4,
    this.supportWhatsapp,
    this.supportPhone,
    this.supportEmail,
    this.websiteUrl,
  });
}

// ---------------------------------------------------------------------------
// FlavorConfig — set ONCE at startup in main_*.dart, never changes at runtime
// ---------------------------------------------------------------------------

class FlavorConfig {
  /// Internal flavor identifier: 'default' | 'clientA' | 'clientB' …
  final String flavorName;

  /// The ONLY truly compile-time value: Dio base URL.
  /// Set before any API calls (including /app-config).
  final String baseUrl;

  /// Play Store URL for this client's app — used by ForceUpdateScreen
  final String playStoreUrl;

  /// App Store URL for this client's app — used by ForceUpdateScreen
  final String appStoreUrl;

  /// Branding fallbacks — overridden at runtime by RemoteConfig
  final FlavorThemeDefaults themeDefaults;

  /// Feature flag fallbacks — overridden at runtime by RemoteConfig.
  /// Keys must match the feature keys used throughout the app.
  final Map<String, bool> featureDefaults;

  const FlavorConfig({
    required this.flavorName,
    required this.baseUrl,
    required this.playStoreUrl,
    required this.appStoreUrl,
    required this.themeDefaults,
    required this.featureDefaults,
  });

  // ── Singleton accessed via FlavorConfig.instance ─────────────────────────

  static late FlavorConfig instance;

  // ── Named constructors for each flavor ───────────────────────────────────

  /// Default / "Pro Max Matrimony" flavor
  factory FlavorConfig.defaultFlavor() => FlavorConfig(
    flavorName: 'default',
    baseUrl: EnvConfig.baseUrl,
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.pro.matrimony',
    appStoreUrl:
        'https://apps.apple.com/us/app/pro-matrimony/id6443700372',
    themeDefaults: const FlavorThemeDefaults(
      appName: 'Pro Max Matrimony',
      primaryColor: Color(0xFFEA5575),
      accentColor: Color(0xFF5E2D83),
      gradientStart: Color(0xFFE8798F),
      gradientEnd: Color(0xFFEA5575),
      scaffoldBgColor: Color(0xFFFEF7F3),
      fontFamily: 'PlusJakartaSans',
      borderRadius: 20.0,
      buttonStyle: 'rounded',
      profileCardStyle: 'design_1',
      otherProfileDesign: 'design_1',
      myProfileDesign: 'design_1',
      dashboardDesign: 'design_3',
      bottomBarDesign: 'design_1',
      privacySettingsDesign: 'design_1',
      textFieldDesign: 'card',
      textFieldRadius: 20.0,
      defaultCountryCode: '+91',
      defaultCountryIso: 'IN',
      defaultCountryFlag: '🇮🇳',
      defaultLanguageCode: 'en',
      maxPhotosAllowed: 4,
    ),
    featureDefaults: const {
      'enableChat': true,
      'enableVideoCall': true,
      'enableVoiceCall': true,
      'showPremiumBadge': true,
      'enableNotifications': true,
      'enableMeeting': true,
      'enableSuccessStories': true,
      'enableAdminMatches': true,
      'enableAdvancedSearch': true,
      // Dynamic white-label flags
      'enableMembershipPlans': true,
      'enableIdentityVerification': true,
      'enableSelfieVerification': true,
      'enableAiMatchmaking': true,
      'enable_ai_matchmaking': true,
      'enableAiAutoInterest': true,
      'showAiHeroBanner': true,
      'enableAiBioGenerator': true,
      'enablePhotoPrivacy': true,
      'enablePhotoRequest': true,
      'enableScreenshotProtection': false,
      'enableWatermarkPhotos': true,
      'enableHoroscope': true,
      'enableBiodataDownload': true,
      'enableOtpLogin': true,
      'enablePasswordLogin': true,
      'enableShortlist': true,
      'enableBlockProfile': true,
      'enableReportProfile': true,
      'enableContactView': true,
      'enableInterestReminders': true,
      'enableDarkMode': true,
      'enableMultiLanguage': true,
    },
  );
}
