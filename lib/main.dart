// ─────────────────────────────────────────────────────────────────────────────
// Primary entry point for the application.
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:async';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_zpns/zego_zpns.dart';

import 'package:pro_matrimony/widgets/app_common_background.dart';

import 'config/flavors/flavor_config.dart';
import 'core/config/env_config.dart';
import 'core/force_update/force_update_guard.dart';
import 'core/maintenance/maintenance_guard.dart';
import 'core/routing/router_provider.dart';
import 'core/services/app_security_service.dart';
import 'core/storage/storage_provider.dart';
import 'features/home/providers/zego_notifier.dart';
import 'preference/session_keys.dart';
import 'services/app_notification_handler.dart';
import 'services/app_session_service.dart';
import 'services/notification_service.dart';
import 'services/zego_initialization_service.dart';
import 'services/firebase_chat_service.dart';
import 'services/registration_token_holder.dart';
import 'utils/app_debug.dart';
import 'utils/utils.dart';

/// Global navigator key used by Zego call invitation service.
GlobalKey<NavigatorState> get navigatorKey => ZegoInitializationService.navigatorKey;

/// Top-level background message handler for ZPNs offline call invitations
@pragma('vm:entry-point')
Future<void> _zpnsBackgroundMessageHandler(ZPNsMessage message) async {
  printLog("ZPNs offline call notification received: ${message.extras}");
}

/// Text scale factor applied app-wide to prevent system font size from
/// breaking layouts.
const double _kTextScaleFactor = 0.9;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RegistrationTokenHolder.clear();

  // Register ZPNs background message handler for offline call notifications when app is closed/killed.
  ZPNs.setBackgroundMessageHandler(_zpnsBackgroundMessageHandler);

  // Register ZPNs event handlers to diagnose push token registration and push arrivals
  ZPNsEventHandler.onRegistered = (ZPNsRegisterMessage registerMessage) {
    printLog(
      "ZPNS_STATUS: Registered push token! pushID: '${registerMessage.pushID}', errorCode: ${registerMessage.errorCode}, errorMessage: '${registerMessage.errorMessage}'",
    );
  };
  ZPNsEventHandler.onNotificationArrived = (ZPNsMessage message) {
    printLog("ZPNS_STATUS: Notification arrived: ${message.extras}");
  };
  ZPNsEventHandler.onNotificationClicked = (ZPNsMessage message) {
    printLog("ZPNS_STATUS: Notification clicked: ${message.extras}");
  };

  // Capture Flutter framework errors in release mode.
  FlutterError.onError = (FlutterErrorDetails details) {
    final exceptionStr = details.exceptionAsString();
    // Ignore known Flutter framework assertion caused by legacy Zego lifecycle adapter
    if (exceptionStr.contains('Invalid state transition from AppLifecycleState')) {
      return;
    }
    FlutterError.presentError(details);
    printLog('FlutterError: $exceptionStr');
  };

  try {
    // Initialize environment config first — other services depend on it.
    await EnvConfig.init();

    // AppSessionService initialises SharedPreferences internally; reuse the
    // same instance for the Riverpod override below to avoid double init.
    await AppSessionService.init();
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      NotificationService.initialize(),
      CountryCodes.init(),
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
    ]);

    await ZegoInitializationService.initialize(navigatorKey);

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        flavorConfigProvider.overrideWithValue(FlavorConfig.defaultFlavor()),
      ],
    );

    // Pre-initialize Zego Cloud immediately on app cold boot if user is logged in
    final matriId = AppSessionService.getValue(SessionDetail.kMatriId)?.toString() ?? "";
    if (matriId.isNotEmpty && matriId != "null" && matriId != "N/A") {
      printLog("MAIN_STARTUP: Pre-initializing Zego Cloud for $matriId");
      container.read(zegoProvider.notifier).initZegoCloud();
    }

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: Phoenix(child: const MyApp()),
      ),
    );
  } catch (error, stackTrace) {
    printLog('App initialization failed: $error\n$stackTrace');
    // Re-throw so the OS crash reporter catches it during development.
    rethrow;
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  /// Stored so we can cancel it in [dispose] and avoid memory leaks.
  StreamSubscription<String?>? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notificationSubscription = NotificationService.onNotifications.stream
        .listen((payloadStr) {
      if (mounted) {
        AppNotificationHandler.handleNotificationClick(
          ref.read(routerProvider),
          payloadStr,
          ref: ref,
        );
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FirebaseChatService.instance.setAppOpened(true);
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      FirebaseChatService.instance.setAppOpened(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    final lightTheme = ref.watch(lightThemeDataProvider);
    final darkTheme = ref.watch(darkThemeDataProvider);
    final locale = ref.watch(languageProvider);
    final isScreenshotProtectionEnabled =
        ref.watch(featureProvider('enableScreenshotProtection'));
    AppSecurityService.setScreenshotProtection(isScreenshotProtectionEnabled);

    return ToastificationWrapper(
      key: ValueKey(locale.toString()),
      child: MaterialApp.router(
        key: ValueKey(locale.toString()),
        routerConfig: goRouter,
        title: ref.watch(appConfigProvider).appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        locale: locale,
        builder: (BuildContext context, Widget? child) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return ValueListenableBuilder<ZegoUIKitRoomState>(
            valueListenable: ZegoUIKit().getRoomStateStream(),
            builder: (context, roomState, _) {
              final isCallActive = roomState.reason == ZegoRoomStateChangedReason.Logined;
              final overlayStyle = isCallActive
                  ? const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                      statusBarBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.black,
                      systemNavigationBarIconBrightness: Brightness.light,
                    )
                  : getThemeSystemUiOverlayStyle(isDark: isDark);

              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: overlayStyle,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(_kTextScaleFactor),
                  ),
                  child: Stack(
                    children: [
                      AppCommonBackground(
                        child: MaintenanceGuard(
                          child: ForceUpdateGuard(
                            child: child!,
                          ),
                        ),
                      ),
                      ZegoUIKitPrebuiltCallMiniOverlayPage(
                        contextQuery: () {
                          return goRouter
                              .configuration
                              .navigatorKey
                              .currentState!
                              .context;
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
