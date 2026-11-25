// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
//
// config_providers.dart — Riverpod providers for the white-label config layer.
//
// Provider hierarchy:
//   flavorConfigProvider  (compile-time, set once in main_*.dart)
//       ↓
//   remoteConfigProvider  (async, fetched from /app-config on startup)
//       ↓
//   appConfigProvider     (merged result — what every widget reads)
//       ↓
//   forceUpdateProvider   (derived — ForceUpdateScreen reads this)
//   featureProvider       (family — feature-flag helper)
//   appVersionProvider    (package_info_plus — used by ForceUpdateGuard)

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/network/dio_provider.dart';
import '../../features/home/providers/dashboard_notifier.dart';
import '../../utils/api_urls.dart';
import '../app_config.dart';
import '../flavors/flavor_config.dart';

// ---------------------------------------------------------------------------
// 1. Flavor config — injected once at startup via ProviderScope overrides
// ---------------------------------------------------------------------------

/// Set in main_*.dart via:
///   ProviderScope(overrides: [flavorConfigProvider.overrideWithValue(FlavorConfig.defaultFlavor())])
///
/// Never read directly from widgets — use appConfigProvider instead.
final flavorConfigProvider = Provider<FlavorConfig>((ref) {
  throw UnimplementedError(
    'flavorConfigProvider must be overridden in main_*.dart via ProviderScope.',
  );
});

// ---------------------------------------------------------------------------
// 2. Remote config — fetched from backend, refreshable
// ---------------------------------------------------------------------------

/// Remote config JSON map fetched from backend getTokenApi ("common-request/get-token") endpoint.
/// Returns null on network error or timeout to fall back to flavor defaults.
final remoteConfigProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  try {
    final dio = ref.watch(dioProvider);
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version;
    final params = {
      "app_version": appVersion,
      "device_type": Platform.isAndroid ? "android" : "ios",
    };
    final response = await dio.post(getTokenApi, data: params);
    if (response.statusCode == 200 && response.data != null) {
      if (response.data is Map) {
        final rawMap = Map<String, dynamic>.from(response.data as Map);
        if (rawMap['status'] == 'error') {
          return null;
        }
        if (rawMap['data'] is Map) {
          return Map<String, dynamic>.from(rawMap['data'] as Map);
        }
        return rawMap;
      }
    }
  } catch (_) {
    // If request fails or times out, return null to fall back to flavor defaults
  }
  return null;
});

// ---------------------------------------------------------------------------
// 3. Merged AppConfig — the SINGLE object every widget reads
// ---------------------------------------------------------------------------

/// Combines flavor (compile-time) + remote (backend) into one AppConfig.
/// If remoteConfigProvider is still loading, uses flavor defaults.
/// Rebuilds automatically when remoteConfigProvider refreshes.
final appConfigProvider = Provider<AppConfig>((ref) {
  final flavor = ref.watch(flavorConfigProvider);
  final remoteAsync = ref.watch(remoteConfigProvider);
  final remoteJson = remoteAsync.asData?.value; // null while loading or on error
  return AppConfig.merged(flavor: flavor, remoteJson: remoteJson);
});

// ---------------------------------------------------------------------------
// 4. Force update — derived from appConfig
// ---------------------------------------------------------------------------

/// Null means no force-update check is required.
/// Non-null triggers ForceUpdateGuard logic.
final forceUpdateProvider = Provider<ForceUpdateConfig?>((ref) {
  return ref.watch(appConfigProvider).forceUpdate;
});

// ---------------------------------------------------------------------------
// 5. Feature flag helper — family provider
// ---------------------------------------------------------------------------

/// Usage in widgets:
///   final canChat = ref.watch(featureProvider('enableChat'));
///
/// Falls back to false for unknown keys.
final featureProvider = Provider.family<bool, String>((ref, featureKey) {
  final baseValue = ref.watch(appConfigProvider).feature(featureKey);
  if (!baseValue) return false;

  final dashboardData = ref.watch(dashboardProvider).value;
  if (dashboardData != null) {
    final siteSetting = dashboardData.siteSetting;
    if (siteSetting != null) {
      if (featureKey == 'enableVideoCall' || featureKey == 'enable_video_call') {
        final raw = siteSetting['video_call'] ??
            siteSetting['videoCall'] ??
            siteSetting['enable_video_call'] ??
            siteSetting['enable_videocall'];
        final parsed = AppConfig.extractBool(raw);
        if (parsed != null) return parsed && baseValue;
      }
      if (featureKey == 'enableVoiceCall' || featureKey == 'enable_voice_call') {
        final raw = siteSetting['voice_call'] ??
            siteSetting['voiceCall'] ??
            siteSetting['enable_voice_call'] ??
            siteSetting['enable_voicecall'];
        final parsed = AppConfig.extractBool(raw);
        if (parsed != null) return parsed && baseValue;
      }
      if (featureKey == 'enableAiMatchmaking' ||
          featureKey == 'enable_ai_matchmaking' ||
          featureKey == 'enableAiAutoInterest' ||
          featureKey == 'enable_ai_auto_interest') {
        final raw = siteSetting['enable_ai'] ??
            siteSetting['ai_enabled'] ??
            siteSetting['auto_interest'] ??
            siteSetting['enable_auto_interest'];
        final parsed = AppConfig.extractBool(raw);
        if (parsed != null) return parsed && baseValue;
      }
    }
    if (featureKey == 'enableAiAutoInterest' ||
        featureKey == 'enable_ai_auto_interest') {
      if (dashboardData.autoInterestEnabled != null &&
          dashboardData.autoInterestEnabled == 0) {
        return false;
      }
    }
  }
  return baseValue;
});

// ---------------------------------------------------------------------------
// 6. App version — from package_info_plus (used by ForceUpdateGuard)
// ---------------------------------------------------------------------------

final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  return info.version; // e.g. '2.1.0'
});

// ---------------------------------------------------------------------------
// 7. Design Variant Helpers
// ---------------------------------------------------------------------------

/// Variant for other user's profile screen: 'design_1' | 'design_2' | 'design_3' | 'design_4' | 'design_5'
final otherProfileDesignProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).otherProfileDesign;
});

/// Variant for current user's profile screen: 'design_1' | 'design_2'
final myProfileDesignProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).myProfileDesign;
});

/// Variant for dashboard screen: 'design_1' | 'design_2' | 'design_3'
final dashboardDesignProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).dashboardDesign;
});

/// Variant for profile cards in lists/grids: 'design_1' ... 'design_6'
final profileCardStyleProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).profileCardStyle;
});

/// Variant for privacy settings screen: 'design_1' | 'design_2'
final privacySettingsDesignProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).privacySettingsDesign;
});

/// Maximum number of photos a user is allowed to upload
final maxPhotosAllowedProvider = Provider<int>((ref) {
  return ref.watch(appConfigProvider).maxPhotosAllowed;
});

/// Default regional country dial code (e.g. '+91')
final defaultCountryCodeProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).defaultCountryCode;
});

/// Default regional country ISO code (e.g. 'IN', 'US')
final defaultCountryIsoProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).defaultCountryIso;
});

/// Default regional country flag emoji (e.g. '🇮🇳', '🇺🇸')
final defaultCountryFlagProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).defaultCountryFlag;
});

/// Variant for bottom navigation bar: 'design_1' ... 'design_5'
final bottomBarDesignProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).bottomBarDesign;
});

/// Variant for input fields across the app: 'card' | 'outlined' | 'filled' | 'underlined'
final textFieldDesignProvider = Provider<String>((ref) {
  return ref.watch(appConfigProvider).textFieldDesign;
});


