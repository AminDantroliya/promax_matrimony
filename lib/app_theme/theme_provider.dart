// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/storage/storage_provider.dart';
import '../config/providers/config_providers.dart';
import 'app_theme.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    final config = ref.watch(appConfigProvider);
    if (!config.isDarkThemeSupported) {
      return ThemeMode.light;
    }

    final sessionService = ref.watch(sessionServiceProvider);
    final themeStr = sessionService.getValue<String>('themeMode');

    if (themeStr != null) {
      switch (themeStr) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        case 'system':
          return ThemeMode.system;
      }
    }

    return config.themeMode;
  }

  void setThemeMode(ThemeMode mode) async {
    final config = ref.read(appConfigProvider);
    if (!config.isDarkThemeSupported) {
      mode = ThemeMode.light;
    }
    state = mode;
    final sessionService = ref.read(sessionServiceProvider);
    await sessionService.setValue('themeMode', mode.name);

    if (mode == ThemeMode.dark) {
      setDarkThemeSystemUI();
    } else if (mode == ThemeMode.light) {
      setLightThemeSystemUI();
    } else {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        setDarkThemeSystemUI();
      } else {
        setLightThemeSystemUI();
      }
    }
  }

  void toggleTheme() {
    final config = ref.read(appConfigProvider);
    if (!config.isDarkThemeSupported) return;
    ThemeMode nextMode;
    switch (state) {
      case ThemeMode.light:
        nextMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        nextMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        nextMode = ThemeMode.light;
        break;
    }
    setThemeMode(nextMode);
  }
}

@riverpod
ThemeConfig themeConfig(Ref ref) {
  final config = ref.watch(appConfigProvider);

  return ThemeConfig(
    primaryColor: config.primaryColor,
    accentColor: config.accentColor,
    scaffoldBgColor: config.scaffoldBgColor,
    fontFamily: config.fontFamily,
    borderRadius: config.borderRadius,
    buttonStyle: config.buttonStyle,
    buttonRadius: config.buttonRadius,
    textFieldRadius: config.textFieldRadius,
  );
}

@riverpod
ThemeData lightThemeData(Ref ref) {
  final config = ref.watch(themeConfigProvider);
  return AppTheme.fromThemeConfig(config, Brightness.light);
}

@riverpod
ThemeData darkThemeData(Ref ref) {
  final config = ref.watch(themeConfigProvider);
  return AppTheme.fromThemeConfig(config, Brightness.dark);
}

@riverpod
ThemeData appThemeData(Ref ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.isDarkThemeSupported) {
    return ref.watch(lightThemeDataProvider);
  }
  final mode = ref.watch(themeProvider);

  if (mode == ThemeMode.dark) {
    return ref.watch(darkThemeDataProvider);
  } else if (mode == ThemeMode.light) {
    return ref.watch(lightThemeDataProvider);
  } else {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final themeConfig = ref.watch(themeConfigProvider);
    return AppTheme.fromThemeConfig(themeConfig, brightness);
  }
}

// Backward compatibility provider for legacy code that expects bool
@riverpod
bool isDarkMode(Ref ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.isDarkThemeSupported) {
    return false;
  }
  final mode = ref.watch(themeProvider);
  if (mode == ThemeMode.system) {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }
  return mode == ThemeMode.dark;
}
