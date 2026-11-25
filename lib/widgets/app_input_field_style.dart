import 'package:flutter/material.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/config/app_config.dart';
import 'package:pro_matrimony/config/flavors/flavor_config.dart';

/// Centralized style resolver for input fields across the application.
///
/// Supports 4 dynamic design styles controlled by the Admin Panel:
/// - **`card`** (Default): Modern squircle floating card with subtle elevation shadow,
///   micro-label inside at the top, and thin border highlighting on focus.
/// - **`outlined`**: Clean Material 3 style with crisp 1.5px border, surface background,
///   zero box shadow, and dynamic corner radius.
/// - **`filled`**: Flat tinted capsule (iOS / Minimalist style), borderless when idle,
///   soft tinted background fill, and focus border.
/// - **`underlined`**: Minimalist luxury editorial style with transparent background,
///   zero corner radius, and bottom border line only.
class AppInputFieldStyle {
  AppInputFieldStyle._();

  /// Resolves the active input field design: 'card' | 'outlined' | 'filled' | 'underlined'.
  static String resolveDesign(AppConfig? config, {String? designOverride}) {
    if (designOverride != null && designOverride.isNotEmpty) {
      return designOverride.toLowerCase().trim();
    }
    if (config != null && config.textFieldDesign.isNotEmpty) {
      return config.textFieldDesign.toLowerCase().trim();
    }
    try {
      return FlavorConfig.instance.themeDefaults.textFieldDesign;
    } catch (_) {
      return 'card';
    }
  }

  /// Returns the dynamic corner radius based on [config.textFieldRadius] and [design].
  ///
  /// Text fields preserve their previous standard radius of 20.0 (squircle card design)
  /// and are decoupled from button styling or button border radius.
  /// Underlined design always has 0 radius for a flush bottom rule.
  static BorderRadius getBorderRadius(
    AppConfig? config, {
    String? designOverride,
    double? customRadius,
  }) {
    final design = resolveDesign(config, designOverride: designOverride);
    if (design == 'underlined') {
      return BorderRadius.zero;
    }
    final radius = customRadius ?? config?.textFieldRadius ?? 20.0;
    return BorderRadius.circular(radius);
  }

  /// Builds a dynamic [BoxDecoration] for input containers across all forms.
  static BoxDecoration buildContainerDecoration({
    required BuildContext context,
    AppConfig? config,
    bool isFocused = false,
    bool hasError = false,
    bool suppressUnderline = false,
    Color? customFillColor,
    Color? customBorderColor,
    Color? focusBorderColor,
    double? customRadius,
    String? designOverride,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final design = resolveDesign(config, designOverride: designOverride);
    final borderRadius = getBorderRadius(
      config,
      designOverride: design,
      customRadius: customRadius,
    );
    final effectiveFocusColor =
        focusBorderColor ?? config?.primaryColor ?? theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;

    switch (design) {
      case 'outlined':
        final borderColor = hasError
            ? errorColor
            : (isFocused
                  ? effectiveFocusColor
                  : (customBorderColor ??
                        (isDark
                            ? const Color(0xFF374151)
                            : const Color(0xFFCBD5E1))));
        final fillColor =
            customFillColor ??
            (isDark
                ? const Color(0xFF16182F).withValues(alpha: 0.6)
                : theme.colorScheme.surface);

        return BoxDecoration(
          color: fillColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: borderColor,
            width: (isFocused || hasError) ? 1.8 : 1.2,
          ),
        );

      case 'filled':
        final borderColor = hasError
            ? errorColor
            : (isFocused
                  ? effectiveFocusColor
                  : (customBorderColor ?? Colors.transparent));
        final fillColor =
            customFillColor ??
            (isDark ? const Color(0xFF1E2235) : const Color(0xFFF3F4F6));

        return BoxDecoration(
          color: fillColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: borderColor,
            width: (isFocused || hasError) ? 1.5 : 1.0,
          ),
        );

      case 'underlined':
        if (suppressUnderline) {
          return BoxDecoration(
            color: customFillColor ?? Colors.transparent,
            borderRadius: BorderRadius.zero,
          );
        }

        final borderColor = hasError
            ? errorColor
            : (isFocused
                  ? effectiveFocusColor
                  : (customBorderColor ??
                        (isDark
                            ? const Color(0xFF374151)
                            : const Color(0xFFCBD5E1))));
        final fillColor = customFillColor ?? Colors.transparent;

        return BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.zero,
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: (isFocused || hasError) ? 2.0 : 1.2,
            ),
          ),
        );

      case 'card':
      default:
        final borderColor = hasError
            ? errorColor
            : (isFocused
                  ? effectiveFocusColor
                  : (customBorderColor ??
                        (isDark
                            ? const Color(0xFF2E3150)
                            : const Color(0xFFE5E7EB))));
        final fillColor =
            customFillColor ??
            (isDark ? const Color(0xFF1E2038) : Colors.white);

        return BoxDecoration(
          color: fillColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: borderColor,
            width: (isFocused || hasError) ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );
    }
  }

  /// Returns appropriate container padding according to active design.
  static EdgeInsets getContainerPadding(
    AppConfig? config, {
    String? designOverride,
    EdgeInsets? defaultPadding,
    bool isGroupOrSlider = false,
  }) {
    final design = resolveDesign(config, designOverride: designOverride);
    if (design == 'underlined') {
      return isGroupOrSlider
          ? const EdgeInsets.fromLTRB(4, 12, 4, 12)
          : const EdgeInsets.symmetric(horizontal: 4, vertical: 10);
    }
    return defaultPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }

  /// Micro-label style matching Figma / Design System.
  static TextStyle getLabelStyle({
    required BuildContext context,
    AppConfig? config,
    bool hasError = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppFont.font(
      context: context,
      fontSize: 11.5,
      fontWeight: FontWeight.w700,
      color: hasError
          ? theme.colorScheme.error
          : (isDark ? const Color(0xFF8A90A6) : const Color(0xFF8A90A6)),
      letterSpacing: 0.2,
    );
  }
}
