import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized dynamic font manager for the application.
///
/// Automatically uses the font configured in backend Admin Panel (`font_family`),
/// loaded dynamically via [GoogleFonts.getFont] with graceful offline fallback.
class AppFont {
  AppFont._();

  static String _activeFont = 'Plus Jakarta Sans';

  /// Returns the current active dynamic font family name.
  static String get activeFont => _activeFont;

  /// Updates the active dynamic font family.
  /// Called automatically whenever [AppConfig] or [ThemeData] initializes or refreshes.
  static void setFont(String? font) {
    if (font != null && font.trim().isNotEmpty) {
      _activeFont = normalize(font);
    }
  }

  /// Normalizes font names sent from backend:
  /// Examples:
  /// - 'PlusJakartaSans'   -> 'Plus Jakarta Sans'
  /// - 'plus_jakarta_sans' -> 'Plus Jakarta Sans'
  /// - 'poppins'           -> 'Poppins'
  /// - 'outfit'            -> 'Outfit'
  /// - 'dmsans' / 'dm_sans'-> 'DM Sans'
  /// - 'nunitosans'        -> 'Nunito Sans'
  /// - 'playfairdisplay'   -> 'Playfair Display'
  /// - 'opensans'          -> 'Open Sans'
  static String normalize(String font) {
    String trimmed = font.trim();
    if (trimmed.isEmpty) return 'Plus Jakarta Sans';

    // Replace underscores and hyphens with spaces
    String cleaned = trimmed.replaceAll(RegExp(r'[-_]'), ' ');

    final lower = cleaned.replaceAll(' ', '').toLowerCase();
    if (lower == 'plusjakartasans') return 'Plus Jakarta Sans';
    if (lower == 'dmsans') return 'DM Sans';
    if (lower == 'ptsans') return 'PT Sans';
    if (lower == 'ptserif') return 'PT Serif';
    if (lower == 'nunitosans') return 'Nunito Sans';
    if (lower == 'playfairdisplay') return 'Playfair Display';
    if (lower == 'opensans') return 'Open Sans';
    if (lower == 'sourcesans3' || lower == 'sourcesanspro') return 'Source Sans 3';
    if (lower == 'worksans') return 'Work Sans';
    if (lower == 'firasans') return 'Fira Sans';
    if (lower == 'notosans') return 'Noto Sans';

    // If CamelCase without space: e.g. "PlusJakartaSans", "OpenSans"
    if (!cleaned.contains(' ') && RegExp(r'[a-z][A-Z]').hasMatch(cleaned)) {
      cleaned = cleaned.replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (m) => '${m[1]} ${m[2]}',
      );
    }

    // Capitalize each word properly: e.g. "poppins" -> "Poppins", "dm sans" -> "DM Sans"
    final words = cleaned.split(RegExp(r'\s+'));
    final capitalized = words.map((w) {
      if (w.isEmpty) return '';
      final wLower = w.toLowerCase();
      if (wLower == 'dm') return 'DM';
      if (wLower == 'pt') return 'PT';
      return w[0].toUpperCase() + w.substring(1).toLowerCase();
    }).join(' ');

    return capitalized.isNotEmpty ? capitalized : 'Plus Jakarta Sans';
  }

  /// Resolves the effective font family.
  /// If [context] is provided, attempts to read from [Theme.of(context).textTheme].
  /// Otherwise falls back to the globally active [_activeFont].
  static String resolveFontName([BuildContext? context]) {
    if (context != null) {
      try {
        final family = Theme.of(context).textTheme.bodyMedium?.fontFamily ??
            Theme.of(context).textTheme.titleMedium?.fontFamily ??
            Theme.of(context).textTheme.bodyLarge?.fontFamily;
        if (family != null && family.isNotEmpty) {
          return normalize(family);
        }
      } catch (_) {}
    }
    return _activeFont;
  }

  /// Generates a dynamic [TextStyle] using the backend's active font family.
  ///
  /// Can be called with or without [context]:
  /// ```dart
  /// // Without context:
  /// AppFont.font(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)
  ///
  /// // With context:
  /// AppFont.font(context: context, fontSize: 16, fontWeight: FontWeight.bold)
  /// ```
  static TextStyle font({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? fontOverride,
  }) {
    final family = fontOverride != null
        ? normalize(fontOverride)
        : resolveFontName(context);

    try {
      return GoogleFonts.getFont(
        family,
        textStyle: textStyle,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );
    } catch (_) {
      return TextStyle(
        fontFamily: family,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      ).merge(textStyle);
    }
  }

  /// Dynamic display font (headings, titles, banners).
  /// Dynamically adopts the backend font unless a custom override is given.
  static TextStyle displayFont({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? fontOverride,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    fontOverride: fontOverride,
  );

  // ---------------------------------------------------------------------------
  // Compatibility aliases so any legacy or direct font calls automatically
  // adapt to the 100% dynamic backend font.
  // ---------------------------------------------------------------------------
  static TextStyle plusJakartaSans({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  static TextStyle inter({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  static TextStyle fraunces({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  static TextStyle playfairDisplay({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  static TextStyle poppins({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  static TextStyle lexend({
    BuildContext? context,
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) => font(
    context: context,
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  /// Convenience method for bold headings.
  static TextStyle bold({
    BuildContext? context,
    double fontSize = 16,
    Color? color,
    double? height,
    double? letterSpacing,
  }) => font(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  /// Convenience method for semi-bold text.
  static TextStyle semiBold({
    BuildContext? context,
    double fontSize = 14,
    Color? color,
    double? height,
    double? letterSpacing,
  }) => font(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  /// Convenience method for medium text.
  static TextStyle medium({
    BuildContext? context,
    double fontSize = 14,
    Color? color,
    double? height,
    double? letterSpacing,
  }) => font(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  /// Convenience method for regular body text.
  static TextStyle regular({
    BuildContext? context,
    double fontSize = 14,
    Color? color,
    double? height,
    double? letterSpacing,
  }) => font(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}
