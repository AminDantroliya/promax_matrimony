import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/data/repositories/home_repository.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';

/// Service to update latitude/longitude and device_id on the server.
/// - FCM token update is triggered from Dashboard load if missing.
/// - Location update is requested contextually from Near By Matches if missing.
class LatLongService {
  static final LatLongService _instance = LatLongService._internal();
  factory LatLongService() => _instance;
  LatLongService._internal();

  /// Main entry point triggered from the dashboard.
  /// Updates FCM token (device ID) if missing.
  Future<void> tryUpdateLatLong({
    required DashboardData dashboardData,
    required HomeRepository repository,
  }) async {
    final bool deviceIdMissing = Platform.isAndroid
        ? _isNullOrEmpty(dashboardData.androidDeviceId)
        : _isNullOrEmpty(dashboardData.iosDeviceId);

    if (!deviceIdMissing) {
      printLog('LatLongService: device_id is already present, skipping.');
      return;
    }

    final params = <String, dynamic>{};

    // --- Device ID (FCM Token) ---
    if (deviceIdMissing) {
      String? fcmToken = AppSessionService.getValue(SessionDetail.kFcmToken) as String?;

      if (fcmToken == null || fcmToken.isEmpty) {
        try {
          fcmToken = await FirebaseMessaging.instance.getToken();
          if (fcmToken != null && fcmToken.isNotEmpty) {
            await AppSessionService.setValue(SessionDetail.kFcmToken, fcmToken);
          }
        } catch (e) {
          printLog('LatLongService: error getting FCM token directly: $e');
        }
      }

      if (fcmToken == null || fcmToken.isEmpty) {
        try {
          final settings = await FirebaseMessaging.instance.getNotificationSettings();
          if (settings.authorizationStatus == AuthorizationStatus.denied ||
              settings.authorizationStatus == AuthorizationStatus.notDetermined) {
            printLog('LatLongService: notification permission rejected/notDetermined. Requesting permission.');
            final newSettings = await FirebaseMessaging.instance.requestPermission(
              alert: true,
              badge: true,
              sound: true,
            );
            if (newSettings.authorizationStatus == AuthorizationStatus.authorized ||
                newSettings.authorizationStatus == AuthorizationStatus.provisional) {
              fcmToken = await FirebaseMessaging.instance.getToken();
              if (fcmToken != null && fcmToken.isNotEmpty) {
                await AppSessionService.setValue(SessionDetail.kFcmToken, fcmToken);
              }
            }
          }
        } catch (e) {
          printLog('LatLongService: error checking/requesting notification permission: $e');
        }
      }

      if (fcmToken != null && fcmToken.isNotEmpty) {
        if (Platform.isAndroid) {
          params['android_device_id'] = fcmToken;
        } else {
          params['ios_device_id'] = fcmToken;
        }
      }
    }

    if (params.isEmpty) {
      printLog('LatLongService: FCM token not available, skipping API call.');
      return;
    }

    try {
      await repository.updateLatLong(params);
      printLog('LatLongService: successfully updated FCM token: $params');
    } catch (e) {
      printLog('LatLongService: FCM token API update failed: $e');
    }
  }



  /// Request location permission if not already granted and return the current position.
  Future<Position?> requestAndGetLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        printLog('LatLongService: location permission not granted ($permission).');
        return null;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        printLog('LatLongService: location services disabled.');
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return position;
    } catch (e) {
      printLog('LatLongService: error requesting and fetching location: $e');
      return null;
    }
  }

  bool _isNullOrEmpty(String? value) =>
      value == null || value.trim().isEmpty || value == 'null';
}
