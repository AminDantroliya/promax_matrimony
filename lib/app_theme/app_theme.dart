import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_font.dart';
export 'app_font.dart';

import '../config/app_config.dart';
import '../widgets/app_common_background.dart';

// ---------------------------------------------------------------------------
// ThemeConfig — lightweight equatable value to optimize rebuilds
// ---------------------------------------------------------------------------
class ThemeConfig {
  final Color primaryColor;
  final Color accentColor;
  final Color scaffoldBgColor;
  final String fontFamily;
  final double borderRadius;
  final String buttonStyle;
  final double buttonRadius;
  final double textFieldRadius;

  const ThemeConfig({
    required this.primaryColor,
    required this.accentColor,
    required this.scaffoldBgColor,
    required this.fontFamily,
    required this.borderRadius,
    this.buttonStyle = 'rounded',
    this.buttonRadius = 14.0,
    this.textFieldRadius = 20.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeConfig &&
          runtimeType == other.runtimeType &&
          primaryColor == other.primaryColor &&
          accentColor == other.accentColor &&
          scaffoldBgColor == other.scaffoldBgColor &&
          fontFamily == other.fontFamily &&
          borderRadius == other.borderRadius &&
          buttonStyle == other.buttonStyle &&
          buttonRadius == other.buttonRadius &&
          textFieldRadius == other.textFieldRadius;

  @override
  int get hashCode =>
      primaryColor.hashCode ^
      accentColor.hashCode ^
      scaffoldBgColor.hashCode ^
      fontFamily.hashCode ^
      borderRadius.hashCode ^
      buttonStyle.hashCode ^
      buttonRadius.hashCode ^
      textFieldRadius.hashCode;
}

// System UI Overlays
void setLightThemeSystemUI() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

void setDarkThemeSystemUI() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF0C0D16),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

SystemUiOverlayStyle getThemeSystemUiOverlayStyle({required bool isDark}) {
  return isDark
      ? const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFF0C0D16),
          systemNavigationBarIconBrightness: Brightness.light,
        )
      : const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        );
}

const appAcceptedColor = Color(0xFF00903A);
const appPendingColor = Color(0xFFEF9B09);
const appRejectColor = Color(0xfffb3c3c);
const appPrimaryColor = Color(0xFFD64D70);

/// Builds a ThemeData from the ThemeConfig.
/// All colours, fonts, and border radii come from config — never hardcoded.
ThemeData getAppTheme(ThemeConfig config, Brightness brightness) {
  final bool isDark = brightness == Brightness.dark;
  final primaryColor = config.primaryColor;
  final accentColor = config.accentColor;
  final radius = config.borderRadius;

  final normalizedFont = AppFont.normalize(config.fontFamily);
  final textTheme = _buildTextTheme(normalizedFont, isDark);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: isDark ? const Color(0xFF0C0D16) : config.scaffoldBgColor,
    canvasColor: isDark ? const Color(0xFF0C0D16) : config.scaffoldBgColor,
    fontFamily: normalizedFont,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: AppCommonPageTransitionsBuilder(
          platformBuilder: ZoomPageTransitionsBuilder(),
        ),
        TargetPlatform.iOS: AppCommonPageTransitionsBuilder(
          platformBuilder: CupertinoPageTransitionsBuilder(),
        ),
        TargetPlatform.macOS: AppCommonPageTransitionsBuilder(
          platformBuilder: CupertinoPageTransitionsBuilder(),
        ),
      },
    ),
    dividerColor: isDark
        ? Colors.white.withValues(alpha: 0.05)
        : const Color(0xFFE8E8F0),

    colorScheme: isDark
        ? ColorScheme.dark(
            primary: primaryColor,
            onPrimary: Colors.white,
            secondary: accentColor,
            onSecondary: Colors.black,
            surface: const Color(0xFF161722),
            onSurface: Colors.white,
            secondaryContainer: Colors.white.withValues(alpha: 0.10),
            onSecondaryContainer: Colors.white70,
            error: appRejectColor,
          )
        : ColorScheme.light(
            primary: primaryColor,
            onPrimary: Colors.white,
            secondary: accentColor,
            onSecondary: Colors.white,
            surface: Colors.white,
            onSurface: const Color(0xFF1A1A2E), // TextPrimary in light mode
            secondaryContainer: const Color(
              0xFFEEF0FB,
            ), // PrimaryTint in light mode
            onSecondaryContainer: primaryColor,
            error: appRejectColor,
          ),

    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? const Color(0xFF161722) : Colors.white,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
      ),
      titleTextStyle: AppFont.font(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
      ),
    ),

    cardTheme: CardThemeData(
      color: isDark ? const Color(0xFF161722) : Colors.white,
      elevation: isDark ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    dividerTheme: DividerThemeData(
      color: isDark ? Colors.white10 : const Color(0xFFE8E8F0),
      thickness: 1,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.buttonRadius),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.buttonRadius),
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.buttonRadius),
        ),
      ),
    ),

    textTheme: textTheme,
  );
}

final Map<String, TextTheme> _textThemeCache = {};

TextTheme _buildTextTheme(String fontFamily, bool isDark) {
  final cacheKey = '${fontFamily}_${isDark ? 'dark' : 'light'}';
  if (_textThemeCache.containsKey(cacheKey)) {
    return _textThemeCache[cacheKey]!;
  }

  final Color textPrimary = isDark ? Colors.white : const Color(0xFF1A1A2E);
  final Color textSecondary = isDark ? Colors.white70 : const Color(0xFF5A5A7A);

  String normalizedFont = AppFont.normalize(fontFamily);
  AppFont.setFont(normalizedFont);

  try {
    final base = TextTheme(
      displayLarge: AppFont.font(
        fontOverride: 'Playfair Display',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        color: const Color(0xFF5B4BE7),
      ),
      displayMedium: AppFont.font(
        fontOverride: 'Playfair Display',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        color: const Color(0xFF5B4BE7),
      ),
      titleLarge: AppFont.font(
        fontOverride: normalizedFont,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      titleMedium: AppFont.font(
        fontOverride: normalizedFont,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: AppFont.font(
        fontOverride: normalizedFont,
        fontSize: 16,
        color: textSecondary,
        height: 1.5,
      ),
      bodyMedium: AppFont.font(
        fontOverride: normalizedFont,
        fontSize: 14,
        color: textSecondary,
        height: 1.5,
      ),
      labelLarge: AppFont.font(
        fontOverride: normalizedFont,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
      ),
    );
    _textThemeCache[cacheKey] = base;
    return base;
  } catch (_) {
    // Fallback using local font assets
    final fallback = TextTheme(
      displayLarge: const TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        color: Color(0xFF5B4BE7),
      ),
      displayMedium: const TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        color: Color(0xFF5B4BE7),
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textSecondary,
        fontFamily: fontFamily,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
        fontFamily: fontFamily,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
        fontFamily: fontFamily,
      ),
    );
    _textThemeCache[cacheKey] = fallback;
    return fallback;
  }
}

/// Backward compatibility class name to keep refactoring clean.
class AppTheme {
  static ThemeData fromConfig(AppConfig config, Brightness brightness) =>
      getAppTheme(
        ThemeConfig(
          primaryColor: config.primaryColor,
          accentColor: config.accentColor,
          scaffoldBgColor: config.scaffoldBgColor,
          fontFamily: config.fontFamily,
          borderRadius: config.borderRadius,
          buttonStyle: config.buttonStyle,
          buttonRadius: config.buttonRadius,
        ),
        brightness,
      );

  static ThemeData fromThemeConfig(ThemeConfig config, Brightness brightness) =>
      getAppTheme(config, brightness);

  /// Dynamically extracts button border radius from ThemeData
  static double getButtonRadius(BuildContext context) {
    try {
      final theme = Theme.of(context);
      final shape = theme.elevatedButtonTheme.style?.shape?.resolve({});
      if (shape is RoundedRectangleBorder) {
        final r = shape.borderRadius.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);
        return r.topLeft.x;
      }
    } catch (_) {}
    return 14.0;
  }

  /// Dynamically extracts button BorderRadius from ThemeData
  static BorderRadius getButtonBorderRadius(BuildContext context) {
    return BorderRadius.circular(getButtonRadius(context));
  }
}

/// ---------------------------------------------------------------------
/// FIGMA DESIGN TOKENS
/// ---------------------------------------------------------------------

class AppColors {
  AppColors._();

  // Brand (Figma Spec)
  static const Color primary = Color(0xFFD64D70);
  static const Color primaryGradientStart = Color(0xFFE8798F);
  static const Color primaryGradientEnd = Color(0xFFD64D70);
  static const Color accent = Color(0xFFFFB38A);

  // Text / neutrals
  static const Color textPrimary = Color(0xFF16182F);
  static const Color textSecondary = Color(0xFF8D94AB);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFFB0B6C8);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Backgrounds
  static const Color bgApp = Colors.transparent;
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgSubtle = Color(0xFFFEF7F3);
  static const Color bgDark = Color(0xFF0C0D16);
  static const Color bgScrim = Color(0xFF000C5C); // use at ~67% opacity

  // Borders / dividers
  static const Color borderLight = Color(0xFFE7EBF3);
  static const Color borderInput = Color(0xFFB0B6C8);
  static const Color borderFocus = Color(0xFFD64D70); // use at ~8% opacity
  static const Color avatarRing = Color(0xFFFFFFFF);

  // Semantic / status
  static const Color success = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF16A34A);
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color warning = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFF59E0B);
  static const Color warningText = Color(0xFFD97706);
  static const Color info = Color(0xFF2C8EDC);
}

class AppGradients {
  AppGradients._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
  );

  static LinearGradient primaryTint({double opacity = 0.08}) => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primaryGradientStart.withValues(alpha: opacity),
      AppColors.primaryGradientEnd.withValues(alpha: opacity),
    ],
  );

  static const LinearGradient amber = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
  );

  static const LinearGradient photoOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black],
    stops: [0.3, 1.0],
  );

  static const LinearGradient danger = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
  );
}

class AppTextStyles {
  AppTextStyles._();

  // Dynamic Display/Heading Font (Configured from Backend)
  static TextStyle f1Display({Color color = AppColors.textPrimary}) =>
      AppFont.displayFont(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle f2HeroHeading({Color color = AppColors.white}) =>
      AppFont.displayFont(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle f3SectionTitle({Color color = AppColors.textPrimary}) =>
      AppFont.displayFont(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle f4SmallSerif({Color color = AppColors.textPrimary}) =>
      AppFont.displayFont(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // Dynamic UI Font (Configured from Backend)
  static TextStyle s1Badge({Color color = AppColors.primary}) =>
      AppFont.font(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: 0.4,
      );

  static TextStyle s2Heading({Color color = AppColors.textPrimary}) =>
      AppFont.font(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle s2bNavTitle({Color color = AppColors.textPrimary}) =>
      AppFont.font(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle s3Subheading({Color color = AppColors.textPrimary}) =>
      AppFont.font(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle s4MenuLabel({Color color = AppColors.textPrimary}) =>
      AppFont.font(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle s5SecondaryBody({Color color = AppColors.textSecondary}) =>
      AppFont.font(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle s6Body({Color color = AppColors.textSecondary}) =>
      AppFont.font(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      );
}

class AppSpacing {
  AppSpacing._();

  static const double xs2 = 2;
  static const double xs = 4;
  static const double sm = 6;
  static const double smd = 8;
  static const double md = 10;
  static const double mdl = 12;
  static const double lg = 14;
  static const double lgx = 16;
  static const double xl = 18;
  static const double xl2 = 20;

  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(24, 21, 24, 19);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets compactCardPadding = EdgeInsets.all(14);
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 5,
  );
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  );
}

class AppRadius {
  AppRadius._();

  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 20;
  static const double xl2 = 24;
  static const double xl3 = 30;
  static const double pill = 999;

  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get mdRadius => BorderRadius.circular(md);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get pillRadius => BorderRadius.circular(pill);
}

class AppShadows {
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      color: const Color(0xFF111827).withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> cardElevated = [
    BoxShadow(
      color: const Color(0xFF111827).withValues(alpha: 0.10),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.28),
      blurRadius: 22,
      offset: const Offset(0, 10),
    ),
  ];
}

class AppIconSize {
  AppIconSize._();

  static const double xs = 12;
  static const double sm = 14;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
}

// ---------------------------------------------------------------------------
// LEGACY & FIGMA THEME HELPERS
// ---------------------------------------------------------------------------

const Color colorPrimary = Color(0xFF5B4BE7);
const Color colorPrimaryLight = Color(0xFF7B6EF0);
const Color appBackgroundColor = Color(0xFFF0F1F8);

final Color darkPrimary = Colors.white.withValues(alpha: 0.10);
final Color darkSecondary = Colors.white.withValues(alpha: 0.20);

const Color appBackgroundColorDark = Color(0xFF0C0D16);

const gradientPrimary = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF6B7FE8), Color(0xFF5B4BE7), Color(0xFF7B3FC4)],
  stops: [0.0, 0.4, 1.0],
);

const gradientProfilePercentage = LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0xFF00FFCC), Color(0xFF00E676)],
  stops: [0.0, 1.0],
);

const gradientLike = LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0xffB4B4B4), Color(0xff797979)],
  stops: [0.0, 1.0],
);

const gradientDot = LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0x332C8EDC), Color(0x332C8EDC)],
  stops: [0.0, 1.0],
);

const gradientDotWhite = LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
  stops: [0.0, 1.0],
);

const gradientMessage = LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0xFF6B7FE8), Color(0xFF5B4BE7)],
  stops: [0.0, 1.0],
);

const gradientImage = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0x50B4B4B4), Color(0x50B4B4B4)],
  stops: [0.0, 1.0],
);

const gradientWhite = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0x10FFFFFF), Color(0xffFFFFFF), Color(0xffFFFFFF), Color(0xffFFFFFF)],
  stops: [0.1, 0.3, 0.6, 0.9],
);

const gradientImage2 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0x00000000), Color(0x90000000)],
  stops: [0.0, 1.0],
);

const gradientChatMessage = LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0XFFFFFFFF), Color(0XFFFFFFFF)],
  stops: [0.0, 1.0],
);

const gradientBackground = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xffFFFFFF), Color(0xFFF1F3FB)],
  stops: [0.0, 1.0],
);

const Color premiumBlue = Color(0xFF2C8EDC);
const Color premiumPurple = Color(0xFF7342EB);
const Color premiumYellowLight = Color(0xFFFBBF24);
const Color premiumYellowDark = Color(0xFFF59E0B);
const Color premiumDarkText = Color(0xFF16182F);
const Color premiumSubtitle = Color(0xFF8D94AB);
const Color premiumOriginalPrice = Color(0xFF9AA1B5);
const Color premiumShadowColor = Color(0xFF111827);
const Color premiumScreenBgLight = Color(0xFFF8F9FD);
const Color premiumScreenBgDark = Color(0xFF12121E);

const Color privacyBlue = Color(0xFF3B82F6);
const Color privacyBlueLight = Color(0xFFDBEAFE);
const Color privacyYellow = Color(0xFFF59E0B);
const Color privacyYellowLight = Color(0xFFFEF3C7);
const Color privacyRed = Color(0xFFEF4444);
const Color privacyRedLight = Color(0xFFFEE2E2);
const Color privacyPink = Color(0xFFEC4899);
const Color privacyPinkLight = Color(0xFFFCE7F3);
const Color privacyGrey = Color(0xFF6B7280);
const Color privacyGreyLight = Color(0xFFF3F4F6);

class FigmaColors {
  static Color primary(BuildContext context) => Theme.of(context).primaryColor;
  static Color secondary(BuildContext context) => Theme.of(context).colorScheme.secondary;
  static Color lightPanelBg(BuildContext context) => Theme.of(context).scaffoldBackgroundColor;

  static const Color lightPanelBgStatic = Color(0xFFFEF7F3);
  static const Color primaryGradientStart = Color(0xFFEA5575);
  static const Color primaryGradientEnd = Color(0xFFE8798F);

  static LinearGradient primaryGradient(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final secondary = Theme.of(context).colorScheme.secondary;
    return LinearGradient(
      colors: [primary, secondary],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  static LinearGradient get fallbackGradient => const LinearGradient(
        colors: [primaryGradientStart, primaryGradientEnd],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static BoxShadow buttonShadow(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return BoxShadow(
      color: primary.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    );
  }

  static const BoxShadow panelShadow = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 60,
    spreadRadius: 0,
    offset: Offset(0, -20),
  );
}

class FigmaTypography {
  static TextStyle buttonText({Color color = Colors.white}) {
    return AppFont.font(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      height: 1.0,
      letterSpacing: 0,
      color: color,
    );
  }
}

class FigmaPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final double height;
  final double width;
  final Gradient? customGradient;
  final double? customBorderRadius;

  const FigmaPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.height = 58.0,
    this.width = double.infinity,
    this.customGradient,
    this.customBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = customGradient ?? FigmaColors.primaryGradient(context);
    final shadow = FigmaColors.buttonShadow(context);
    final radius = customBorderRadius ?? AppTheme.getButtonRadius(context);
    final borderRadius = BorderRadius.circular(radius);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: [shadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                else ...[
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: FigmaTypography.buttonText(),
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(
                          radius <= 6 ? 4.0 : (radius <= 20 ? 8.0 : 20.0),
                        ),
                      ),
                      child: Center(child: trailingIcon),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FigmaPanelContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const FigmaPanelContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
  });

  @override
  Widget build(BuildContext context) {
    final panelBg = FigmaColors.lightPanelBg(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: panelBg != Colors.transparent ? panelBg : FigmaColors.lightPanelBgStatic,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        boxShadow: const [FigmaColors.panelShadow],
      ),
      padding: padding,
      child: child,
    );
  }
}
