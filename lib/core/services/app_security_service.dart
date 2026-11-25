import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service to enable or disable screenshot and screen recording protection.
/// When enabled on Android, WindowManager.LayoutParams.FLAG_SECURE is applied,
/// preventing screenshots, screen recordings, and hiding content in the recent apps switcher.
class AppSecurityService {
  static const MethodChannel _channel =
      MethodChannel('com.pro.matrimony/security');

  static bool? _lastState;

  /// Apply or clear screenshot protection based on the admin feature flag.
  static Future<void> setScreenshotProtection(bool enabled) async {
    if (_lastState == enabled) return;
    _lastState = enabled;

    try {
      await _channel.invokeMethod('setScreenshotProtection', {'enabled': enabled});
      debugPrint('[AppSecurityService] Screenshot protection set to: $enabled');
    } catch (e) {
      debugPrint('[AppSecurityService] Error toggling screenshot protection: $e');
    }
  }
}
