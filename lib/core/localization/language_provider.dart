import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../services/app_session_service.dart';
import '../../preference/session_keys.dart';
import '../../locales/en_us.dart';
import '../../locales/hi_in.dart';
import '../../locales/gu_in.dart';
import '../../locales/ar_ar.dart';
import '../../locales/ta_in.dart';

part 'language_provider.g.dart';

class AppLanguage {
  final String name;
  final String code;
  final String country;
  final String subtitle;

  const AppLanguage({
    required this.name,
    required this.code,
    required this.country,
    required this.subtitle,
  });
}

@riverpod
class Language extends _$Language {
  @override
  Locale build() {
    final languageCode =
        AppSessionService.getValue(SessionDetail.kLanguageCode) ?? 'en';
    final countryCode =
        AppSessionService.getValue(SessionDetail.kCountryCode) ?? 'US';
    final locale = Locale(languageCode, countryCode);

    LocalizationLookup.update(locale);
    return locale;
  }

  final List<AppLanguage> languages = const [
    AppLanguage(name: 'English', code: 'en', country: 'US', subtitle: ''),
    AppLanguage(name: 'Hindi', code: 'hi', country: 'IN', subtitle: 'हिन्दी'),
    AppLanguage(
      name: 'Gujarati',
      code: 'gu',
      country: 'IN',
      subtitle: 'ગુજરાતી',
    ),
    //AppLanguage(name: 'Tamil', code: 'ta', country: 'IN', subtitle: 'தமிழ்'),
  ];

  void changeLanguage(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    state = locale;

    AppSessionService.setValue(SessionDetail.kLanguageCode, languageCode);
    AppSessionService.setValue(SessionDetail.kCountryCode, countryCode);
    AppSessionService.setValue('languageCode', languageCode);
    AppSessionService.setValue('countryCode', countryCode);

    LocalizationLookup.update(locale);
  }

  String get selectedLanguageName {
    switch (state.languageCode) {
      case 'hi':
        return 'Hindi';
      case 'gu':
        return 'Gujarati';
      case 'ar':
        return 'Arabic';
      // case 'ta':
      //   return 'Tamil';
      default:
        return 'English';
    }
  }

  String translate(String key) {
    return LocalizationLookup.translate(key);
  }
}

/// Static helper for String.tr extension to avoid context-dependence in thousands of lines
class LocalizationLookup {
  static Map<String, String> _currentMap = enUS;

  static void update(Locale locale) {
    final localeKey = "${locale.languageCode}_${locale.countryCode}";
    final lang = locale.languageCode.toLowerCase();

    _currentMap =
        _allTranslations[localeKey] ??
        (lang == 'hi'
            ? hiIN
            : lang == 'gu'
            ? guIN
            : lang == 'ar'
            ? arAR
            : lang == 'ta'
            ? taIN
            : enUS);
  }

  static String translate(String key) {
    final res = _currentMap[key] ?? enUS[key];
    if (res != null) return res;

    // Normalised lowercase or snake_case lookup for English titles (e.g. "Basic Details" -> "basic_details")
    final cleanKey = key.trim().toLowerCase();
    final snake = cleanKey.replaceAll(RegExp(r'\s+'), '_');
    final snakeRes = _currentMap[snake] ??
        enUS[snake] ??
        _currentMap['${snake}_lbl'] ??
        enUS['${snake}_lbl'] ??
        _currentMap['${snake}_title'] ??
        enUS['${snake}_title'];
    if (snakeRes != null) return snakeRes;

    // Fallback for snake_case keys (e.g. 'go_back' -> 'Go Back', 'btn_proceed' -> 'Proceed')
    if (key.contains('_')) {
      String cleanKey = key;
      if (cleanKey.startsWith('btn_')) {
        cleanKey = cleanKey.substring(4);
      }
      final words = cleanKey.split('_');
      return words
          .where((w) => w.isNotEmpty)
          .map((w) => w[0].toUpperCase() + w.substring(1))
          .join(' ');
    }

    return key;
  }
}

final _allTranslations = {
  'en_US': enUS,
  'hi_IN': hiIN,
  'gu_IN': guIN,
  'ar_AR': arAR,
  //'ta_IN': taIN,
};

extension Trans on String {
  String get tr => LocalizationLookup.translate(this);

  String trParams([Map<String, String> params = const {}]) {
    String trans = tr;
    if (params.isEmpty) return trans;

    params.forEach((key, value) {
      trans = trans.replaceAll('{$key}', value).replaceAll('@$key', value);
    });
    return trans;
  }
}

extension GetxDummy on String {
  String get getx => this;
}
