import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';

enum AppEnvironment { dev, prod }

class EnvConfig {
  static late AppEnvironment _environment;

  static AppEnvironment get environment => _environment;

  static Future<void> init() async {
    const envDefined = String.fromEnvironment('APP_ENV');
    final String env = envDefined.isNotEmpty
        ? envDefined
        : (kReleaseMode ? 'prod' : 'dev');

    if (kDebugMode)
      debugPrint('EnvConfig: APP_ENV=$env (Release mode: $kReleaseMode)');

    String fileName;
    switch (env) {
      case 'prod':
        _environment = AppEnvironment.prod;
        fileName = '.env.prod';
        break;
      default:
        _environment = AppEnvironment.dev;
        fileName = '.env.dev';
    }

    try {
      await dotenv.load(fileName: fileName);
    } catch (_) {
      // Fallback to default .env if specific file is not found
      await dotenv.load(fileName: '.env');
    }
  }

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://promax.narjisinfotech.com/api/';
  static bool get enableLogging =>
      dotenv.env['ENABLE_LOGGING']?.toLowerCase() == 'true';
  static String get envName => dotenv.env['ENV_NAME'] ?? 'DEV';

  // PayPal Configuration
  static String get paypalClientId =>
      dotenv.env['PAYPAL_CLIENT_ID'] ??
      'ASHjdoxF_ippHw9zRzGSq_7aDPXBuA0Psu4jsVj9-vhIVvICAIcCwdGrHV4eTW1diwYHz1cxOvVLVzRy';
  static String get paypalClientSecret =>
      dotenv.env['PAYPAL_CLIENT_SECRET'] ??
      'EK3sMZuDusiOZ1ynHvGZm2zSOquE4Pe6Vs1P8TkhUM2Q28lV-rFUI-UBlNwumba66h1bIlju2SXicVnF';
  static String get paypalMode => dotenv.env['PAYPAL_MODE'] ?? 'sandbox';
  static String get paypalBaseUrl =>
      dotenv.env['PAYPAL_BASE_URL'] ?? 'https://api-m.sandbox.paypal.com';

  // Zego Cloud Configuration (Dynamic from backend dashboard API, with .env and default fallbacks)
  static int get zegoAppId {
    // 1. Dynamic value from backend dashboard API (site_setting -> zegocloud_appid)
    final sessionVal = AppSessionService.getValue(
      SessionDetail.kZegoAppId,
    )?.toString().trim();
    if (sessionVal != null && sessionVal.isNotEmpty && sessionVal != 'null') {
      final parsed = int.tryParse(sessionVal);
      if (parsed != null && parsed > 0) {
        return parsed;
      }
    }

    // 2. Default key from .env file
    final envVal = dotenv.env['ZEGO_APP_ID']?.trim();
    if (envVal != null && envVal.isNotEmpty) {
      final parsed = int.tryParse(envVal);
      if (parsed != null && parsed > 0) {
        return parsed;
      }
    }

    // 3. Fallback default
    return 123456789;
  }

  static String get zegoAppSign {
    // 1. Dynamic value from backend dashboard API (site_setting -> zegocloud_appsign_key)
    final sessionVal = AppSessionService.getValue(
      SessionDetail.kZegoAppSign,
    )?.toString().trim();
    if (sessionVal != null && sessionVal.isNotEmpty && sessionVal != 'null') {
      return sessionVal;
    }

    // 2. Default key from .env file
    final envVal = dotenv.env['ZEGO_APP_SIGN']?.trim();
    if (envVal != null && envVal.isNotEmpty) {
      return envVal;
    }

    // 3. Fallback default
    return '';
  }

  // PhonePe Configuration
  static String get phonePeMerchantId => dotenv.env['MERCHANT_ID'] ?? 'TEST';
  static String get phonePeClientId =>
      dotenv.env['PHONEPE_CLIENT_ID'] ?? 'TEST_12345678910';
  static String get phonePeClientSecret =>
      dotenv.env['PHONEPE_CLIENT_SECRET'] ?? 'TEST';
  static String get phonePeBaseUrl =>
      dotenv.env['PHONEPE_BASE_URL'] ?? 'https://api.phonepe.com/';
}
