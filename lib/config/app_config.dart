// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
//
// AppConfig: the SINGLE merged configuration object that EVERY widget,
// router, and service reads.
//
// Merge priority:
//   LAYER 1 (highest): Remote API JSON — backend "common-request/get-token" response
//   LAYER 2 (lowest) : FlavorConfig    — compile-time defaults

import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import '../app_theme/app_font.dart';
import 'flavors/flavor_config.dart';

// ---------------------------------------------------------------------------
// ForceUpdateConfig
// ---------------------------------------------------------------------------

class ForceUpdateConfig {
  /// If true: hard block, no dismiss. If false: soft prompt with "Later".
  final bool isForceUpdate;

  /// Minimum app version required, e.g. '2.1.0'
  final String minVersion;

  /// Current latest version available, e.g. '2.3.0'
  final String currentVersion;

  /// Play Store URL — used on Android
  final String updateUrlAndroid;

  /// App Store URL — used on iOS
  final String updateUrlIos;

  /// Localisation KEY for dialog title — never a raw string
  final String titleKey;

  /// Localisation KEY for dialog message — never a raw string
  final String messageKey;

  const ForceUpdateConfig({
    required this.isForceUpdate,
    required this.minVersion,
    required this.currentVersion,
    required this.updateUrlAndroid,
    required this.updateUrlIos,
    required this.titleKey,
    required this.messageKey,
  });

  factory ForceUpdateConfig.fromJson(Map<String, dynamic> json) {
    return ForceUpdateConfig(
      isForceUpdate: () {
        final v = json['is_force_update'];
        if (v is bool) return v;
        if (v is num) return v != 0;
        if (v != null) return v.toString().toLowerCase() == 'true' || v.toString() == '1';
        return false;
      }(),
      minVersion: json['min_version']?.toString() ?? '0.0.0',
      currentVersion: json['current_version']?.toString() ?? '0.0.0',
      updateUrlAndroid: json['update_url_android']?.toString() ?? '',
      updateUrlIos: json['update_url_ios']?.toString() ?? '',
      titleKey: json['title_key']?.toString() ?? 'force_update_message',
      messageKey: json['message_key']?.toString() ?? 'force_update_sub_message',
    );
  }

  Map<String, dynamic> toJson() => {
        'is_force_update': isForceUpdate,
        'min_version': minVersion,
        'current_version': currentVersion,
        'update_url_android': updateUrlAndroid,
        'update_url_ios': updateUrlIos,
        'title_key': titleKey,
        'message_key': messageKey,
      };
}

// ---------------------------------------------------------------------------
// Hex colour & helper parsers
// ---------------------------------------------------------------------------

Color _hexColor(dynamic hex, Color fallback) {
  if (hex == null || hex.toString().isEmpty) return fallback;
  try {
    final str = hex.toString().replaceAll('#', '');
    final buffer = StringBuffer();
    if (str.length == 6) buffer.write('FF');
    buffer.write(str);
    final val = int.tryParse(buffer.toString(), radix: 16);
    return val != null ? Color(val) : fallback;
  } catch (_) {
    return fallback;
  }
}

ThemeMode _parseThemeMode(String? raw) {
  switch (raw?.toLowerCase()) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

/// Normalizes any design variant (e.g. "dashboard_3", "card_1", "design2", "3")
/// into the unified standard "design_X" pattern dynamically.
String _normalizeDesign(dynamic raw, String fallback) {
  if (raw == null || raw.toString().trim().isEmpty) return fallback;
  final str = raw.toString().trim().toLowerCase();
  if (int.tryParse(str) != null) {
    return 'design_$str';
  }
  final match = RegExp(r'^(?:design|dashboard|card)[-_]?(\d+)$', caseSensitive: false).firstMatch(str);
  if (match != null) {
    return 'design_${match.group(1)}';
  }
  return str;
}

/// Normalizes input field design variant into standard 'card' | 'outlined' | 'filled' | 'underlined'.
String _normalizeTextFieldDesign(dynamic raw, String fallback) {
  if (raw == null || raw.toString().trim().isEmpty) return fallback;
  final str = raw.toString().trim().toLowerCase();
  if (str.contains('outline') || str == 'design_2' || str == 'design2' || str == 'border') {
    return 'outlined';
  }
  if (str.contains('fill') || str == 'design_3' || str == 'design3' || str == 'capsule') {
    return 'filled';
  }
  if (str.contains('underline') || str.contains('bottom') || str == 'design_4' || str == 'design4' || str == 'line') {
    return 'underlined';
  }
  if (str.contains('card') || str.contains('float') || str == 'design_1' || str == 'design1') {
    return 'card';
  }
  return str;
}

bool? _extractBool(dynamic val) => AppConfig.extractBool(val);

class AppConfig {
  static bool? extractBool(dynamic val) {
    if (val == null) return null;
    if (val is bool) return val;
    if (val is num) return val != 0;
    final s = val.toString().toLowerCase().trim();
    if (s == 'true' || s == '1' || s == 'yes') return true;
    if (s == 'false' || s == '0' || s == 'no') return false;
    return null;
  }

  // ── Branding ──────────────────────────────────────────────────────────────
  final String appName;

  /// null = use local asset logo; non-null = load from network
  final String? logoUrl;
  final Color primaryColor;
  final Color accentColor;
  final Color gradientStart;
  final Color gradientEnd;
  final Color scaffoldBgColor;
  final Color? progressColor;
  final Color? progressGradientStart;
  final Color? progressGradientEnd;
  final Color? premiumBadgeColor;
  final Color? premiumBadgeTextColor;
  final Color? moreMenuBgColor;
  final Color? moreOptionCardBgColor;
  final String fontFamily;
  final ThemeMode themeMode;

  // ── Design system ─────────────────────────────────────────────────────────
  final double borderRadius;

  /// 'filled' | 'outlined' | 'rounded' | 'gradient'
  final String buttonStyle;

  /// Named semantic colour overrides from backend
  final Map<String, dynamic> customColorMap;

  // ── Design / layout variants ──────────────────────────────────────────────
  /// 'card_1' | 'card_2' | 'card_3' | 'card_4' (or 'classic' | 'modern' | 'minimal')
  final String profileCardStyle;

  /// 'design_1' | 'design_2' | 'design_3' | 'design_4' | 'design_5' (or 'design1' | 'design2' ...)
  final String otherProfileDesign;

  /// 'design_1' | 'design_2' (or 'design1' | 'design2' ...)
  final String myProfileDesign;

  /// 'dashboard_1' | 'dashboard_2' | 'dashboard_3' (or 'luxury' | 'modern' | 'default')
  final String dashboardDesign;

  /// 'design_1' | 'design_2' | 'design_3' | 'design_4' | 'design_5'
  final String bottomBarDesign;

  /// 'design_1' | 'design_2' (or 'design1' | 'design2' ...)
  final String privacySettingsDesign;

  /// 'card' | 'outlined' | 'filled' | 'underlined'
  final String textFieldDesign;

  /// Dedicated corner radius for input/text fields. Defaults to 20.0 (previous app design).
  /// Decoupled from [borderRadius] / [buttonRadius] so button styling never alters text field rounding.
  final double textFieldRadius;

  /// Whether Matches screen uses swipable dating cards or grid/list layout
  final bool isMatchSwipableProfile;

  // ── Localization & Regional Defaults ──────────────────────────────────────
  final String defaultCountryCode;
  final String defaultCountryIso;
  final String defaultCountryFlag;
  final String defaultLanguageCode;

  // ── Upload & Media Rules ──────────────────────────────────────────────────
  final int maxPhotosAllowed;

  // ── Support & Help ────────────────────────────────────────────────────────
  final String? supportWhatsapp;
  final String? supportPhone;
  final String? supportEmail;
  final String? websiteUrl;

  // ── Feature flags ─────────────────────────────────────────────────────────
  final Map<String, bool> features;

  // ── Force update & Maintenance ────────────────────────────────────────────
  final ForceUpdateConfig? forceUpdate;
  final bool isMaintenanceMode;
  final String maintenanceMsgKey;

  // ── Store URLs (from flavor compile-time) ─────────────────────────────────
  final String playStoreUrl;
  final String appStoreUrl;

  const AppConfig({
    required this.appName,
    this.logoUrl,
    required this.primaryColor,
    required this.accentColor,
    required this.gradientStart,
    required this.gradientEnd,
    required this.scaffoldBgColor,
    this.progressColor,
    this.progressGradientStart,
    this.progressGradientEnd,
    this.premiumBadgeColor,
    this.premiumBadgeTextColor,
    this.moreMenuBgColor,
    this.moreOptionCardBgColor,
    required this.fontFamily,
    required this.themeMode,
    required this.borderRadius,
    required this.buttonStyle,
    required this.customColorMap,
    required this.profileCardStyle,
    required this.otherProfileDesign,
    required this.myProfileDesign,
    required this.dashboardDesign,
    this.bottomBarDesign = 'design_1',
    this.privacySettingsDesign = 'design_1',
    this.textFieldDesign = 'card',
    this.textFieldRadius = 20.0,
    this.isMatchSwipableProfile = true,
    this.defaultCountryCode = '+91',
    this.defaultCountryIso = 'IN',
    this.defaultCountryFlag = '🇮🇳',
    this.defaultLanguageCode = 'en',
    this.maxPhotosAllowed = 4,
    this.supportWhatsapp,
    this.supportPhone,
    this.supportEmail,
    this.websiteUrl,
    required this.features,
    this.forceUpdate,
    required this.isMaintenanceMode,
    required this.maintenanceMsgKey,
    required this.playStoreUrl,
    required this.appStoreUrl,
  });

  // ── Theme / Gradient Helpers ──────────────────────────────────────────────
  LinearGradient get primaryGradient => LinearGradient(
        colors: [gradientStart, gradientEnd],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  /// Resolves a dynamic 2-color gradient combination for the profile progress indicator.
  /// Fully dynamic — never uses static colors. Adapts to any primary color & luminance.
  /// Guarantees that the progress bar fill is always vibrant and richly colored,
  /// so it never washes out to white (ensuring crystal-clear contrast against
  /// the white/translucent remaining track).
  List<Color> getProgressGradient({
    Color? cardPrimary,
    Color? cardSecondary,
  }) {
    final primary = cardPrimary ?? primaryColor;
    final secondary = cardSecondary ?? accentColor;

    final double cardLum =
        (primary.computeLuminance() + secondary.computeLuminance()) / 2;
    final bool isCardDark = cardLum < 0.5;

    // Helper: prevents progress colors from washing out to white or blending into card
    Color sanitizeProgressColor(Color color, {bool isEnd = false}) {
      final HSLColor hsl = HSLColor.fromColor(color);
      final double lum = color.computeLuminance();

      if (isCardDark) {
        // If color is washed out / too close to white, it will clash with the white remaining track
        if (hsl.lightness > 0.74 || lum > 0.60 || hsl.saturation < 0.25) {
          return hsl
              .withLightness(isEnd ? 0.56 : 0.62)
              .withSaturation(
                (hsl.saturation < 0.30 ? 0.90 : hsl.saturation).clamp(0.85, 1.0),
              )
              .toColor();
        }

        // If color blends into the card background (too close in luminance)
        if ((lum - cardLum).abs() < 0.18) {
          final HSLColor cardHsl = HSLColor.fromColor(primary);
          final double hueDiff = (hsl.hue - cardHsl.hue).abs();
          final bool isSameHue = hueDiff < 35 || hueDiff > 325;

          if (isSameHue) {
            // Shift to high-contrast harmonious accent instead of washing out to white
            final double targetHue = (cardHsl.hue >= 240 && cardHsl.hue <= 360)
                ? (isEnd ? 32.0 : 48.0) // Purple/Pink -> Golden Amber
                : (cardHsl.hue >= 70 && cardHsl.hue <= 170)
                    ? (isEnd ? 150.0 : 175.0) // Green -> Mint Cyan
                    : (isEnd ? 25.0 : 50.0); // Amber/Warm -> Radiant Gold
            return HSLColor.fromAHSL(
              1.0,
              targetHue,
              0.95,
              isEnd ? 0.55 : 0.63,
            ).toColor();
          } else {
            return hsl
                .withSaturation(0.95)
                .withLightness((hsl.lightness + 0.25).clamp(0.52, 0.65))
                .toColor();
          }
        }
      } else {
        // Light card: ensure deep, rich colors with sufficient contrast
        if ((lum - cardLum).abs() < 0.20 || hsl.lightness > 0.60) {
          return hsl
              .withSaturation(0.90)
              .withLightness((hsl.lightness - 0.35).clamp(0.20, 0.45))
              .toColor();
        }
      }

      return color;
    }

    if (progressGradientStart != null && progressGradientEnd != null) {
      Color effectiveStart = sanitizeProgressColor(progressGradientStart!);
      Color effectiveEnd = sanitizeProgressColor(progressGradientEnd!, isEnd: true);
      return [effectiveStart, effectiveEnd];
    }
    if (progressGradientStart != null) {
      final start = sanitizeProgressColor(progressGradientStart!);
      final HSLColor hsl = HSLColor.fromColor(start);
      final end = hsl
          .withHue((hsl.hue + 20) % 360)
          .withLightness((hsl.lightness - 0.08).clamp(0.45, 0.62))
          .toColor();
      return [start, end];
    }
    if (progressGradientEnd != null) {
      final end = sanitizeProgressColor(progressGradientEnd!, isEnd: true);
      final HSLColor hsl = HSLColor.fromColor(end);
      final start = hsl
          .withHue((hsl.hue - 20 + 360) % 360)
          .withLightness((hsl.lightness + 0.08).clamp(0.55, 0.68))
          .toColor();
      return [start, end];
    }
    if (progressColor != null) {
      final base = sanitizeProgressColor(progressColor!);
      final HSLColor hsl = HSLColor.fromColor(base);
      final companion = hsl
          .withHue((hsl.hue + 20) % 360)
          .withLightness((hsl.lightness - 0.08).clamp(0.45, 0.62))
          .toColor();
      return [base, companion];
    }

    // Default dynamic mathematical derivation from primary/secondary:
    final HSLColor primaryHsl = HSLColor.fromColor(primary);
    if (isCardDark) {
      // Dark card: generate luminous, high-contrast, saturated colors that NEVER wash out to white
      double targetStartHue;
      double targetEndHue;
      if (primaryHsl.hue >= 240 && primaryHsl.hue <= 360) {
        // Purple / Pink / Rose cards -> Radiant Golden Amber gradient
        targetStartHue = 48.0;
        targetEndHue = 32.0;
      } else if (primaryHsl.hue >= 70 && primaryHsl.hue <= 170) {
        // Emerald / Forest Green cards -> Electric Mint Cyan to Spring Green
        targetStartHue = 175.0;
        targetEndHue = 150.0;
      } else if (primaryHsl.hue >= 170 && primaryHsl.hue < 240) {
        // Blue / Navy cards -> Radiant Cyan to Amber Gold
        targetStartHue = 180.0;
        targetEndHue = 45.0;
      } else {
        // Amber / Orange / Warm cards -> Vivid Gold to Warm Tangerine
        targetStartHue = 50.0;
        targetEndHue = 25.0;
      }

      final Color startColor =
          HSLColor.fromAHSL(1.0, targetStartHue, 0.95, 0.63).toColor();
      final Color endColor =
          HSLColor.fromAHSL(1.0, targetEndHue, 0.90, 0.55).toColor();
      return [startColor, endColor];
    } else {
      // Light card: generate deeper rich tones for contrast
      final Color startColor = primaryHsl
          .withHue((primaryHsl.hue + 25) % 360)
          .withSaturation(0.90)
          .withLightness(0.40)
          .toColor();
      return [startColor, primary];
    }
  }

  BoxShadow get primaryShadow => BoxShadow(
        color: primaryColor.withValues(alpha: 0.4),
        blurRadius: 16,
        offset: const Offset(0, 6),
      );

  // ── Button Style Getters ──────────────────────────────────────────────────
  /// Returns the button border radius based on backend `button_style`:
  /// - 'square' / 'sharp' -> 4.0
  /// - 'rounded' / 'round' -> 14.0
  /// - 'pill' / 'capsule' -> 50.0
  double get buttonRadius {
    final s = buttonStyle.trim().toLowerCase();
    if (s == 'square' || s == 'sharp' || s == 'rectangle') return 4.0;
    if (s == 'rounded' || s == 'round') return 14.0;
    if (s == 'pill' || s == 'capsule') return 50.0;
    return 14.0;
  }

  BorderRadius get buttonBorderRadius => BorderRadius.circular(buttonRadius);

  bool get isButtonSquare {
    final s = buttonStyle.trim().toLowerCase();
    return s == 'square' || s == 'sharp' || s == 'rectangle';
  }

  bool get isButtonRounded {
    final s = buttonStyle.trim().toLowerCase();
    return s == 'rounded' || s == 'round';
  }

  bool get isButtonPill {
    final s = buttonStyle.trim().toLowerCase();
    return s == 'pill' || s == 'capsule';
  }

  // ── Backward Compatibility Getters ────────────────────────────────────────
  String get buttonDesign => buttonStyle;
  Color get secondaryColor => accentColor;
  Color get lightPanelBg => scaffoldBgColor;
  String get dashboardCategory => dashboardDesign;
  String get profileCardDesign => profileCardStyle;
  String get otherProfileStyle => otherProfileDesign;
  String get otherUserProfileDesign => otherProfileDesign;
  String get myProfileStyle => myProfileDesign;
  bool get isDarkThemeSupported => features['enableDarkMode'] ?? true;
  bool get isMultiLanguageSupported => features['enableMultiLanguage'] ?? true;
  bool get isHoroscopeSupported => features['enableHoroscope'] ?? true;
  bool get isAiMatchmakingSupported =>
      features['enableAiMatchmaking'] ??
      features['enable_ai_matchmaking'] ??
      true;
  bool get isSwipableMatch => isMatchSwipableProfile;
  String get bottomMenuDesign => bottomBarDesign;
  bool get enableVoiceCall => feature('enableVoiceCall');
  bool get enableVideoCall => feature('enableVideoCall');
  bool get enableChat => feature('enableChat');

  // ── Feature helper ────────────────────────────────────────────────────────
  bool feature(String key) {
    if (key == 'enableAiAutoInterest' || key == 'enable_ai_auto_interest') {
      if (features.containsKey('enableAiAutoInterest')) {
        return (features['enableAiAutoInterest'] ?? false) && isAiMatchmakingSupported;
      }
      return isAiMatchmakingSupported;
    }
    if (features.containsKey(key)) return features[key] ?? false;
    if (key == 'enableAiMatchmaking' || key == 'enable_ai_matchmaking') {
      return isAiMatchmakingSupported;
    }
    return false;
  }

  static const _kDefaultMsgKey = 'maintenance_message';

  // ── Factory: merges Remote API JSON over FlavorConfig ─────────────────────
  factory AppConfig.merged({
    required FlavorConfig flavor,
    Map<String, dynamic>? remoteJson,
  }) {
    final defaults = flavor.themeDefaults;
    final r = remoteJson ?? {};

    // Merged Feature Flags (supporting both snake_case and camelCase)
    final mergedFeatures = <String, bool>{
      ...flavor.featureDefaults,
    };

    dynamic findRaw(String key) {
      if (r[key] != null) return r[key];
      if (r['features'] is Map && (r['features'] as Map)[key] != null) {
        return (r['features'] as Map)[key];
      }
      if (r['feature_controls'] is Map && (r['feature_controls'] as Map)[key] != null) {
        return (r['feature_controls'] as Map)[key];
      }
      if (r['settings'] is Map && (r['settings'] as Map)[key] != null) {
        return (r['settings'] as Map)[key];
      }
      return null;
    }

    void mapFlag(String camelKey, String snakeKey, [List<String>? altKeys]) {
      dynamic raw = findRaw(snakeKey) ?? findRaw(camelKey);
      if (raw == null && altKeys != null) {
        for (final k in altKeys) {
          final found = findRaw(k);
          if (found != null) {
            raw = found;
            break;
          }
        }
      }
      final val = _extractBool(raw);
      if (val != null) {
        mergedFeatures[camelKey] = val;
        mergedFeatures[snakeKey] = val;
      } else {
        if (mergedFeatures.containsKey(camelKey) && !mergedFeatures.containsKey(snakeKey)) {
          mergedFeatures[snakeKey] = mergedFeatures[camelKey]!;
        } else if (mergedFeatures.containsKey(snakeKey) && !mergedFeatures.containsKey(camelKey)) {
          mergedFeatures[camelKey] = mergedFeatures[snakeKey]!;
        }
      }
    }

    // Standard flags
    mapFlag('enableChat', 'enable_chat', [
      'chat',
      'is_chat',
      'chat_enabled',
    ]);
    mapFlag('enableVideoCall', 'enable_video_call', [
      'video_call',
      'videoCall',
      'is_video_call',
      'isVideoCall',
      'video_calling',
      'enable_video_calling',
      'video_call_enabled',
      'enable_videocall',
      'videocall',
    ]);
    mapFlag('enableVoiceCall', 'enable_voice_call', [
      'voice_call',
      'voiceCall',
      'is_voice_call',
      'isVoiceCall',
      'voice_calling',
      'enable_voice_calling',
      'voice_call_enabled',
      'call',
      'enable_call',
      'enable_voicecall',
      'voicecall',
    ]);
    mapFlag('showPremiumBadge', 'show_premium_badge', [
      'premium_badge',
      'premiumBadge',
      'is_premium_badge',
      'enable_premium_badge',
      'enablePremiumBadge',
      'premium_badge_enabled',
      'premium_badges',
    ]);
    mapFlag('enableNotifications', 'enable_notifications', [
      'notifications',
      'notification',
      'enable_notification',
    ]);
    mapFlag('enableMeeting', 'enable_meeting', [
      'meeting',
      'is_meeting',
    ]);
    mapFlag('enableSuccessStories', 'enable_success_stories', [
      'success_stories',
      'success_story',
      'successStories',
      'is_success_stories',
    ]);
    mapFlag('enableAdminMatches', 'enable_admin_matches', [
      'admin_matches',
      'admin_match',
      'adminMatches',
      'is_admin_matches',
    ]);
    mapFlag('enableAdvancedSearch', 'enable_advanced_search', [
      'advanced_search',
      'advance_search',
      'advancedSearch',
    ]);

    // Monetization & Membership
    mapFlag('enableMembershipPlans', 'enable_membership_plans', [
      'membership_plans',
      'membershipPlans',
      'membership',
    ]);

    // Verification & Trust
    mapFlag('enableIdentityVerification', 'enable_identity_verification', [
      'identity_verification',
      'identityVerification',
      'id_verification',
    ]);
    mapFlag('enableSelfieVerification', 'enable_selfie_verification', [
      'selfie_verification',
      'selfieVerification',
      'is_selfie_verification',
      'enable_selfie',
      'selfie',
    ]);

    // AI Capabilities
    mapFlag('enableAiMatchmaking', 'enable_ai_matchmaking', [
      'ai_matchmaking',
      'aiMatchmaking',
      'is_ai_matchmaking',
      'ai_match',
      'enable_ai',
      'ai_features',
      'ai_enabled',
    ]);
    mapFlag('enableAiAutoInterest', 'enable_ai_auto_interest', [
      'ai_auto_interest',
      'auto_interest',
      'enable_auto_interest',
      'ai_auto_send_interest',
      'enable_auto_send_interest',
      'enable_ai_interest',
    ]);
    mapFlag('showAiHeroBanner', 'show_ai_hero_banner', [
      'ai_hero_banner',
      'aiHeroBanner',
      'enable_ai_hero_banner',
      'showAiHeroBanner',
      'hero_banner',
    ]);
    mapFlag('enableAiBioGenerator', 'enable_ai_bio_generator', [
      'ai_bio_generator',
      'aiBioGenerator',
      'is_ai_bio_generator',
      'ai_bio',
      'enable_ai_bio',
      'bio_generator',
    ]);

    // Privacy & Security
    mapFlag('enablePhotoPrivacy', 'enable_photo_privacy', [
      'photo_privacy',
      'photoPrivacy',
    ]);
    mapFlag('enablePhotoRequest', 'enable_photo_request', [
      'photo_request',
      'photoRequest',
    ]);
    mapFlag('enableScreenshotProtection', 'enable_screenshot_protection', [
      'screenshot_protection',
      'screenshotProtection',
      'is_screenshot_protection',
      'screen_protection',
    ]);
    mapFlag('enableWatermarkPhotos', 'enable_watermark_photos', [
      'watermark_photos',
      'watermark_photo',
      'watermark',
      'is_watermark',
      'is_watermark_photos',
      'photo_watermark',
    ]);

    // Cultural & Compatibility
    mapFlag('enableHoroscope', 'enable_horoscope', [
      'horoscope',
      'is_horoscope',
      'horoscope_supported',
      'enable_horoscope_tab',
    ]);
    mapFlag('enableBiodataDownload', 'enable_biodata_download', [
      'biodata_download',
      'biodataDownload',
      'is_biodata_download',
      'biodata',
      'download_biodata',
    ]);

    // Auth & Access
    mapFlag('enableOtpLogin', 'enable_otp_login', [
      'otp_login',
      'otpLogin',
      'is_otp_login',
      'otp',
      'enable_otp',
      'phone_login',
    ]);
    mapFlag('enablePasswordLogin', 'enable_password_login', [
      'password_login',
      'passwordLogin',
      'is_password_login',
      'password',
      'enable_password',
      'email_login',
    ]);

    // Interactions
    mapFlag('enableShortlist', 'enable_shortlist', [
      'shortlist',
      'is_shortlist',
    ]);
    mapFlag('enableBlockProfile', 'enable_block_profile', [
      'block_profile',
      'blockProfile',
    ]);
    mapFlag('enableReportProfile', 'enable_report_profile', [
      'report_profile',
      'reportProfile',
    ]);
    mapFlag('enableContactView', 'enable_contact_view', [
      'contact_view',
      'contactView',
    ]);
    mapFlag('enableInterestReminders', 'enable_interest_reminders', [
      'interest_reminders',
      'interestReminders',
      'interest_reminder',
      'reminder',
      'reminders',
      'enable_reminder',
    ]);

    // Settings
    mapFlag('enableDarkMode', 'enable_dark_mode', [
      'dark_mode',
      'darkMode',
      'is_dark_mode',
      'dark_theme',
      'darkTheme',
    ]);
    mapFlag('enableMultiLanguage', 'enable_multi_language', [
      'multi_language',
      'multiLanguage',
      'is_multi_language',
      'multiple_language',
      'language_switcher',
    ]);

    final rawPrimary = r['primary_color'] ?? r['primaryColor'];
    final rawSecondary = r['secondary_color'] ?? r['accent_color'] ?? r['secondaryColor'];
    final rawGradStart = r['gradient_start'] ?? r['gradientStart'];
    final rawGradEnd = r['gradient_end'] ?? r['gradientEnd'];
    final rawScaffoldBg = r['scaffold_bg_color'] ?? r['light_panel_bg'] ?? r['scaffoldBgColor'];
    final rawProgress = r['progress_color'] ??
        r['progressColor'] ??
        r['progress_bar_color'] ??
        r['progressBarColor'] ??
        r['dashboard_progress_color'] ??
        r['dashboardProgressColor'] ??
        r['profile_completion_color'] ??
        r['profileCompletionColor'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['progress_color'] ??
                r['custom_color_map']['progressColor'] ??
                r['custom_color_map']['progress_bar_color'] ??
                r['custom_color_map']['progressBarColor'])
            : null);
    final rawProgressStart = r['progress_gradient_start'] ??
        r['progressGradientStart'] ??
        r['progress_color_start'] ??
        r['progressColorStart'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['progress_gradient_start'] ??
                r['custom_color_map']['progressGradientStart'] ??
                r['custom_color_map']['progress_color_start'] ??
                r['custom_color_map']['progressColorStart'])
            : null);
    final rawProgressEnd = r['progress_gradient_end'] ??
        r['progressGradientEnd'] ??
        r['progress_color_end'] ??
        r['progressColorEnd'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['progress_gradient_end'] ??
                r['custom_color_map']['progressGradientEnd'] ??
                r['custom_color_map']['progress_color_end'] ??
                r['custom_color_map']['progressColorEnd'])
            : null);
    final rawPremiumBadge = r['premium_badge_color'] ??
        r['premiumBadgeColor'] ??
        r['premium_badge_bg'] ??
        r['premiumBadgeBg'] ??
        r['premium_badge_bg_color'] ??
        r['premiumBadgeBgColor'] ??
        r['badge_color'] ??
        r['badgeColor'] ??
        r['premium_color'] ??
        r['premiumColor'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['premium_badge_color'] ??
                r['custom_color_map']['premiumBadgeColor'] ??
                r['custom_color_map']['premium_badge_bg'] ??
                r['custom_color_map']['premium_color'])
            : null);
    final rawPremiumBadgeText = r['premium_badge_text_color'] ??
        r['premiumBadgeTextColor'] ??
        r['premium_badge_text'] ??
        r['premiumBadgeText'] ??
        r['badge_text_color'] ??
        r['badgeTextColor'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['premium_badge_text_color'] ??
                r['custom_color_map']['premiumBadgeTextColor'] ??
                r['custom_color_map']['premium_badge_text'])
            : null);
    final rawMoreMenuBg = r['more_menu_bg_color'] ??
        r['moreMenuBgColor'] ??
        r['more_menu_bg'] ??
        r['moreMenuBg'] ??
        r['more_option_bg_color'] ??
        r['moreOptionBgColor'] ??
        r['more_options_bg_color'] ??
        r['moreOptionsBgColor'] ??
        r['more_menu_background'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['more_menu_bg_color'] ??
                r['custom_color_map']['moreMenuBgColor'] ??
                r['custom_color_map']['more_menu_bg'] ??
                r['custom_color_map']['more_option_bg_color'])
            : null);
    final rawMoreOptionCardBg = r['more_option_card_bg'] ??
        r['moreOptionCardBg'] ??
        r['more_card_bg'] ??
        r['moreCardBg'] ??
        r['more_option_card_bg_color'] ??
        r['moreOptionCardBgColor'] ??
        r['more_card_bg_color'] ??
        r['moreCardBgColor'] ??
        (r['custom_color_map'] is Map
            ? (r['custom_color_map']['more_option_card_bg'] ??
                r['custom_color_map']['moreOptionCardBg'] ??
                r['custom_color_map']['more_card_bg'])
            : null);
    final rawRadius = r['border_radius'] ?? r['borderRadius'];
    final rawCardStyle = r['profile_card_style'] ?? r['profile_card_design'] ?? r['profileCardStyle'];
    final rawOtherProfile = r['other_profile_design'] ??
        r['other_profile_style'] ??
        r['other_user_profile_design'] ??
        r['other_member_profile_design'] ??
        r['otherProfileDesign'] ??
        r['otherProfileStyle'];
    final rawMyProfile = r['my_profile_design'] ??
        r['my_profile_style'] ??
        r['myProfileDesign'] ??
        r['myProfileStyle'];
    final rawDashboard = r['dashboard_design'] ?? r['dashboard_category'] ?? r['dashboardDesign'];
    final rawBottomBar = r['bottom_bar_design'] ??
        r['bottom_menu_style'] ??
        r['bottom_menu_design'] ??
        r['bottom_navigation_design'] ??
        r['bottomBarDesign'] ??
        r['bottomMenuDesign'];
    final rawPrivacySettings = r['privacy_settings_design'] ??
        r['privacy_setting_design'] ??
        r['privacySettingsDesign'] ??
        r['privacySettingDesign'];
    final rawTextField = r['text_field_design'] ??
        r['textFieldDesign'] ??
        r['input_field_design'] ??
        r['inputFieldDesign'] ??
        r['text_field_style'] ??
        r['input_design'] ??
        r['textFieldStyle'];
    final rawTextFieldRadius = r['text_field_border_radius'] ??
        r['text_field_radius'] ??
        r['textFieldRadius'] ??
        r['input_border_radius'] ??
        r['input_radius'] ??
        r['inputBorderRadius'];

    final resolvedPrimary = _hexColor(rawPrimary, defaults.primaryColor);
    final resolvedSecondary = _hexColor(rawSecondary, defaults.accentColor);
    final fallbackGradStart = rawPrimary != null ? resolvedPrimary : defaults.gradientStart;
    final fallbackGradEnd = rawSecondary != null
        ? resolvedSecondary
        : (rawPrimary != null ? resolvedPrimary : defaults.gradientEnd);

    final resolvedFont =
        (r['font_family'] ?? r['fontFamily'])?.toString() ?? defaults.fontFamily;
    AppFont.setFont(resolvedFont);

    return AppConfig(
      appName: (r['app_name'] ?? r['appName'])?.toString() ?? defaults.appName,
      logoUrl: (r['logo_url'] ?? r['logoUrl'])?.toString(),
      primaryColor: resolvedPrimary,
      accentColor: resolvedSecondary,
      gradientStart: _hexColor(rawGradStart, fallbackGradStart),
      gradientEnd: _hexColor(rawGradEnd, fallbackGradEnd),
      scaffoldBgColor: _hexColor(rawScaffoldBg, defaults.scaffoldBgColor),
      progressColor: rawProgress != null ? _hexColor(rawProgress, defaults.progressColor ?? defaults.accentColor) : defaults.progressColor,
      progressGradientStart: rawProgressStart != null ? _hexColor(rawProgressStart, defaults.progressGradientStart ?? defaults.primaryColor) : defaults.progressGradientStart,
      progressGradientEnd: rawProgressEnd != null ? _hexColor(rawProgressEnd, defaults.progressGradientEnd ?? defaults.accentColor) : defaults.progressGradientEnd,
      premiumBadgeColor: rawPremiumBadge != null ? _hexColor(rawPremiumBadge, defaults.premiumBadgeColor ?? defaults.accentColor) : defaults.premiumBadgeColor,
      premiumBadgeTextColor: rawPremiumBadgeText != null ? _hexColor(rawPremiumBadgeText, Colors.white) : defaults.premiumBadgeTextColor,
      moreMenuBgColor: rawMoreMenuBg != null ? _hexColor(rawMoreMenuBg, defaults.moreMenuBgColor ?? defaults.scaffoldBgColor) : defaults.moreMenuBgColor,
      moreOptionCardBgColor: rawMoreOptionCardBg != null ? _hexColor(rawMoreOptionCardBg, Colors.white) : defaults.moreOptionCardBgColor,
      fontFamily: resolvedFont,
      themeMode: _parseThemeMode((r['theme_mode'] ?? r['themeMode'])?.toString()),

      borderRadius: double.tryParse(rawRadius?.toString() ?? '') ?? defaults.borderRadius,
      buttonStyle: (r['button_style'] ?? r['button_design'] ?? r['buttonDesign'] ?? r['buttonStyle'] ?? r['btn_style'] ?? r['btnStyle'])?.toString() ?? defaults.buttonStyle,
      customColorMap: r['custom_color_map'] is Map
          ? Map<String, dynamic>.from(r['custom_color_map'] as Map)
          : <String, dynamic>{},

      profileCardStyle: _normalizeDesign(rawCardStyle, defaults.profileCardStyle),
      otherProfileDesign: _normalizeDesign(rawOtherProfile, defaults.otherProfileDesign),
      myProfileDesign: _normalizeDesign(rawMyProfile, defaults.myProfileDesign),
      dashboardDesign: _normalizeDesign(rawDashboard, defaults.dashboardDesign),
      bottomBarDesign: _normalizeDesign(rawBottomBar, defaults.bottomBarDesign),
      privacySettingsDesign: _normalizeDesign(rawPrivacySettings, defaults.privacySettingsDesign),
      textFieldDesign: _normalizeTextFieldDesign(rawTextField, defaults.textFieldDesign),
      textFieldRadius: double.tryParse(rawTextFieldRadius?.toString() ?? '') ?? defaults.textFieldRadius,
      isMatchSwipableProfile: () {
        final raw = r['is_match_swipable_profile'] ??
            r['isMatchSwipableProfile'] ??
            r['is_swipable_match'] ??
            r['isSwipableMatch'];
        if (raw is bool) return raw;
        if (raw is num) return raw == 1;
        if (raw != null) {
          final str = raw.toString().toLowerCase().trim();
          return str == 'true' || str == '1';
        }
        return true;
      }(),

      defaultCountryIso: (r['default_country_iso'] ?? r['defaultCountryIso'] ?? r['country_iso'])?.toString() ?? defaults.defaultCountryIso,
      defaultCountryFlag: () {
        final explicit = (r['default_country_flag'] ?? r['defaultCountryFlag'] ?? r['country_flag'])?.toString();
        if (explicit != null && explicit.trim().isNotEmpty) return explicit.trim();
        final iso = (r['default_country_iso'] ?? r['defaultCountryIso'] ?? r['country_iso'])?.toString();
        if (iso != null && iso.trim().isNotEmpty) {
          try {
            final match = countries.firstWhere((c) => c.code.toUpperCase() == iso.trim().toUpperCase());
            return match.flag;
          } catch (_) {}
        }
        return defaults.defaultCountryFlag;
      }(),
      defaultCountryCode: () {
        final explicit = (r['default_country_code'] ?? r['defaultCountryCode'] ?? r['country_code'])?.toString();
        if (explicit != null && explicit.trim().isNotEmpty) return explicit.trim();
        final iso = (r['default_country_iso'] ?? r['defaultCountryIso'] ?? r['country_iso'])?.toString();
        if (iso != null && iso.trim().isNotEmpty) {
          try {
            final match = countries.firstWhere((c) => c.code.toUpperCase() == iso.trim().toUpperCase());
            return "+${match.dialCode}";
          } catch (_) {}
        }
        return defaults.defaultCountryCode;
      }(),
      defaultLanguageCode: (r['default_language_code'] ?? r['defaultLanguageCode'])?.toString() ?? defaults.defaultLanguageCode,
      maxPhotosAllowed: () {
        final raw = r['max_photos_allowed'] ?? r['maxPhotosAllowed'] ?? r['max_photos'] ?? r['max_photo'];
        if (raw is num) return raw.toInt();
        return int.tryParse(raw?.toString() ?? '') ?? defaults.maxPhotosAllowed;
      }(),
      supportWhatsapp: (r['support_whatsapp'] ?? r['whatsapp_support'] ?? r['supportWhatsapp'])?.toString() ?? defaults.supportWhatsapp,
      supportPhone: (r['support_phone'] ?? r['support_mobile'] ?? r['supportPhone'])?.toString() ?? defaults.supportPhone,
      supportEmail: (r['support_email'] ?? r['supportEmail'])?.toString() ?? defaults.supportEmail,
      websiteUrl: (r['website_url'] ?? r['websiteUrl'])?.toString() ?? defaults.websiteUrl,

      features: mergedFeatures,

      forceUpdate: r['force_update'] is Map
          ? ForceUpdateConfig.fromJson(Map<String, dynamic>.from(r['force_update'] as Map))
          : null,
      isMaintenanceMode: () {
        final val = r['is_maintenance_mode'] ?? r['app_under_maintenance'];
        if (val is bool) return val;
        if (val != null) {
          final s = val.toString().toLowerCase().trim();
          return s == 'true' || s == '1' || s == 'yes';
        }
        return false;
      }(),
      maintenanceMsgKey: r['maintenance_msg_key']?.toString() ?? _kDefaultMsgKey,

      playStoreUrl: flavor.playStoreUrl,
      appStoreUrl: flavor.appStoreUrl,
    );
  }

  /// Convenience: AppConfig with pure flavor defaults
  factory AppConfig.fromFlavor(FlavorConfig flavor) =>
      AppConfig.merged(flavor: flavor, remoteJson: null);
}

