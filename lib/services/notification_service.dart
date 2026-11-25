import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/application_data.dart';

import '../preference/session_keys.dart';
import '../utils/app_debug.dart';
import 'app_session_service.dart';

// Background message handler (must be a top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  printRemoteMessage(remoteMessage);
  printLog("Background notification received: ${remoteMessage.data}");
  ApplicationData().setIsFromBackgroundNotification = true;
  NotificationService.handleNotification(remoteMessage);
}

void printRemoteMessage(RemoteMessage remoteMessage) {
  printLog('========= FCM REMOTE MESSAGE =========');
  printLog('messageId      : ${remoteMessage.messageId}');
  printLog('from           : ${remoteMessage.from}');
  printLog('sentTime       : ${remoteMessage.sentTime}');
  printLog('ttl            : ${remoteMessage.ttl}');
  printLog('collapseKey    : ${remoteMessage.collapseKey}');

  if (remoteMessage.notification != null) {
    printLog('--- NOTIFICATION PAYLOAD ---');
    printLog('title : ${remoteMessage.notification?.title}');
    printLog('body  : ${remoteMessage.notification?.body}');
  }

  printLog('--- DATA PAYLOAD ---');
  printLog(jsonEncode(remoteMessage.data));
  printLog('====================================');
}
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // payload can be null
  final payload = notificationResponse.payload;
  if (payload != null && payload.isNotEmpty) {
    NotificationService.initialNotificationPayload ??= payload;
    NotificationService.onNotifications.add(payload);
  }
}

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static final onForegroundNotification = PublishSubject<String?>();
  static String? initialNotificationPayload;

  // Initialize the service
  static Future initialize() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: iOS);

    // Request notification permissions
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      printLog('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      printLog('User granted provisional permission');
    } else {
      printLog('User declined or has not accepted permission');
    }

    // Get FCM token
    _fcm.getToken().then((token) {
      printLog('Firebase_Token : $token');
      AppSessionService.setValue(SessionDetail.kFcmToken, token);
    }).onError((error, stackTrace) {
      printLog('error_in_getToken : $error');
    });

    // Background message handler (must be top-level)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_firebaseMessagingForGroundHandler);

    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      ApplicationData().setIsFromBackgroundNotification = true;
      final payload = details.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        initialNotificationPayload = payload;
        onNotifications.add(payload);
      }
    }

    // Subscribe to bulk notification topics
    if (Platform.isAndroid) {
      _fcm.subscribeToTopic('BULK_NOTIFICATION_ANDROID').then((_) {
        printLog('Subscribed to BULK_NOTIFICATION_ANDROID');
      }).catchError((e) {
        printLog('Error subscribing to BULK_NOTIFICATION_ANDROID: $e');
      });
    } else if (Platform.isIOS) {
      _fcm.subscribeToTopic('BULK_NOTIFICATION_IOS').then((_) {
        printLog('Subscribed to BULK_NOTIFICATION_IOS');
      }).catchError((e) {
        printLog('Error subscribing to BULK_NOTIFICATION_IOS: $e');
      });
    }

    // background(when app in background) notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printLog('FCM onMessageOpenedApp clicked: ${message.data}');
      final payloadMap = extractPayloadMap(message);
      String rawData = jsonEncode(payloadMap);
      onNotifications.add(rawData);
    });

    // background(app is closed/terminated) notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        printLog('FCM getInitialMessage clicked: ${message.data}');
        ApplicationData().setIsFromBackgroundNotification = true;
        final payloadMap = extractPayloadMap(message);
        String rawData = jsonEncode(payloadMap);
        initialNotificationPayload ??= rawData;
        onNotifications.add(rawData);
      }
    });

    // ✅ Initialize local notifications properly
    await _notifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          onNotifications.add(payload);
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  /// Helper to safely extract combined payload map from both notification block and data block
  static Map<String, dynamic> extractPayloadMap(RemoteMessage message) {
    final Map<String, dynamic> payload = Map<String, dynamic>.from(message.data);
    if (message.notification != null) {
      final title = message.notification?.title;
      final body = message.notification?.body;
      if (title != null && title.isNotEmpty) {
        payload['title'] ??= title;
      }
      if (body != null && body.isNotEmpty) {
        payload['body'] ??= body;
        payload['message'] ??= body;
      }
    }
    return payload;
  }

  // Handle foreground messages
  static Future<void> _firebaseMessagingForGroundHandler(
      RemoteMessage remoteMessage) async {
    printLog("Foreground notification received: ${remoteMessage.data}");
    ApplicationData().setIsFromBackgroundNotification = false;

    final payloadMap = extractPayloadMap(remoteMessage);
    onForegroundNotification.add(jsonEncode(payloadMap));

    handleNotification(remoteMessage);
  }

  static void handleNotification(RemoteMessage remoteMessage) {
    if (AppSessionService.getValue(SessionDetail.kIsNotificationOn) ?? true) {
      final payloadMap = extractPayloadMap(remoteMessage);

      // Suppress FCM notification if payload belongs to a Zego Call (ZPNs / System Calling UI handles calls)
      if (payloadMap.containsKey("call_id") ||
          payloadMap.containsKey("zego") ||
          payloadMap.containsKey("call_type") ||
          (payloadMap["type"]?.toString().toLowerCase().contains("call") ?? false)) {
        printLog("Suppressing standard FCM notification as Zego ZPNs / System Calling UI manages call lifecycle.");
        return;
      }

      // Stop/Suppress pop-up notification if user is currently on the conversation screen for this chat
      if (ApplicationData.isConversationScreenIsOpen == true) {
        final activeConvId = ApplicationData.activeConversationId?.toString().trim();
        final activeRecId = ApplicationData.activeReceiverId?.toString().trim();

        final notifConvId = payloadMap["conversation_id"]?.toString().trim();
        final notifReceiverId = (payloadMap["receiver_id"] ??
                payloadMap["sender_id"] ??
                payloadMap["viewer_id"] ??
                payloadMap["member_id"] ??
                payloadMap["user_id"])
            ?.toString()
            .trim();

        final isSameConversation = (activeConvId != null &&
                activeConvId.isNotEmpty &&
                notifConvId != null &&
                notifConvId.isNotEmpty &&
                activeConvId == notifConvId) ||
            (activeRecId != null &&
                activeRecId.isNotEmpty &&
                ((notifReceiverId != null && activeRecId == notifReceiverId) ||
                    (notifConvId != null && activeRecId == notifConvId)));

        if (isSameConversation) {
          printLog("Suppressing notification for active open conversation (conversation_id: $notifConvId, receiver_id: $notifReceiverId)");
          return;
        }
      }

      // Stop/Suppress pop-up notification if user is currently on the manager / chat with admin screen
      if (ApplicationData.isManagerChatScreenOpen == true) {
        final notifType = (payloadMap["type"] ??
                payloadMap["noti_type"] ??
                payloadMap["notification_type"] ??
                payloadMap["action"])
            ?.toString()
            .toLowerCase()
            .trim() ??
            '';
        if (notifType == 'personalize_chat_from_admin' ||
            notifType == 'personalized_chat_from_admin') {
          printLog("Suppressing notification for active manager chat screen");
          return;
        }
      }

      showLocalNotification(remoteMessage: remoteMessage);
    }
  }

  @pragma('vm:entry-point')
  static Future showLocalNotification(
      {required RemoteMessage remoteMessage}) async {
    var random = Random();
    var n1 = random.nextInt(1000);

    final payloadMap = extractPayloadMap(remoteMessage);
    var notificationTitle = payloadMap["title"]?.toString() ?? "Notification";
    var notificationMessage = payloadMap["body"]?.toString() ?? payloadMap["message"]?.toString() ?? "";

    return _notifications.show(
        id: n1,
        title: notificationTitle,
        body: notificationMessage,
        payload: jsonEncode(payloadMap),
        notificationDetails: await notificationPlatformDetails(remoteMessage, payloadMap)
    );
  }

  @pragma('vm:entry-point')
  static Future<NotificationDetails> notificationPlatformDetails(
      RemoteMessage remoteMessage, [Map<String, dynamic>? preExtractedMap]) async {
    final payloadMap = preExtractedMap ?? extractPayloadMap(remoteMessage);
    var notificationTitle = payloadMap["title"]?.toString() ?? "Notification";
    var notificationMessage = payloadMap["body"]?.toString() ?? payloadMap["message"]?.toString() ?? "";

    var rawImage = payloadMap["viewer_image"]?.toString() ??
        payloadMap["photo_url"]?.toString() ??
        payloadMap["image"]?.toString() ??
        payloadMap["profile_image"]?.toString() ??
        payloadMap["user_image"]?.toString() ??
        "";

    String notificationImage = "";
    if (rawImage.isNotEmpty && rawImage != "null") {
      if (rawImage.startsWith("http://") || rawImage.startsWith("https://")) {
        notificationImage = rawImage;
      } else {
        final cleanBaseUrl = baseUrl.replaceAll("api/", "storage/assets/memberPhotos/");
        notificationImage = "$cleanBaseUrl$rawImage";
      }
    }

    Uint8List? imageBytes;
    if (notificationImage.isNotEmpty) {
      imageBytes = await fetchImageBytes(notificationImage);
    }

    if (imageBytes != null && imageBytes.isNotEmpty) {
      printLog("Notification image loaded successfully (${imageBytes.length} bytes)");

      return NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            visibility: NotificationVisibility.public,
            playSound: true,
            enableVibration: true,
            icon: "@drawable/ic_notification",
            largeIcon: ByteArrayAndroidBitmap(imageBytes),
            styleInformation: BigTextStyleInformation(
              notificationMessage,
              contentTitle: notificationTitle,
            ),
          ),
          iOS: const DarwinNotificationDetails());
    } else {
      printLog("Showing regular notification (no image or image unavailable)");
      return NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            visibility: NotificationVisibility.public,
            playSound: true,
            enableVibration: true,
            icon: "@drawable/ic_notification",
            largeIcon: const DrawableResourceAndroidBitmap(
                "@drawable/ic_notification"),
            styleInformation: BigTextStyleInformation(
              notificationMessage,
              contentTitle: notificationTitle,
            ),
          ),
          iOS: const DarwinNotificationDetails());
    }
  }

  static Future<Uint8List?> fetchImageBytes(String url) async {
    try {
      dio.Response response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.data != null) {
        final bytes = Uint8List.fromList(response.data);
        if (bytes.isNotEmpty) {
          return bytes;
        }
      }
    } catch (e) {
      printLog("Error fetching notification image bytes ($url): $e");
    }
    return null;
  }
}
