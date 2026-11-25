import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../app_theme/app_theme.dart';

// ── TAB ITEM MODEL ───────────────────────────────────────────────────────────
class AppTabItem {
  final String label;
  final Widget? icon;
  final String? badgeText;
  final int? badgeCount;

  const AppTabItem({
    required this.label,
    this.icon,
    this.badgeText,
    this.badgeCount,
  });
}

// ── TAB BAR VARIANT ENUM ─────────────────────────────────────────────────────
enum TabBarVariant {
  /// Automatic layout:
  /// - tabs.length == 2 -> AppSegmentedTabBar (Segmented capsule track control)
  /// - tabs.length > 2  -> AppPillTabBar (Search screen floating pill tabs)
  auto,

  /// Independent floating pill tabs (Search screen style)
  pill,

  /// Segmented capsule track control
  segmented,
}

// ── UNIFIED APP TAB BAR (Single Smart Widget) ────────────────────────────────
/// Unified TabBar that automatically chooses between Segmented (for 2 tabs)
/// and Pill style (for >2 tabs, search screen style).
class AppTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget?>? icons;
  final List<String?>? badgeTexts;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final TabBarVariant variant;
  final bool? isScrollable;
  final double? height;
  final EdgeInsetsGeometry? outerPadding;
  final EdgeInsetsGeometry? itemPadding;
  final double gap;
  final TabController? controller;

  // Customization Options
  final LinearGradient? activeGradient;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? activeBadgeBgColor;
  final Color? activeBadgeTextColor;
  final Color? inactiveBadgeBgColor;
  final Color? inactiveBadgeTextColor;
  final Color? trackColor;
  final Color? activeCardColor;
  final Border? activeBorder;
  final Border? inactiveBorder;
  final Border? trackBorder;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? activeBoxShadow;
  final List<BoxShadow>? inactiveBoxShadow;
  final double fontSize;
  final FontWeight activeFontWeight;
  final FontWeight inactiveFontWeight;

  const AppTabBar({
    super.key,
    required this.tabs,
    this.icons,
    this.badgeTexts,
    required this.selectedIndex,
    required this.onTap,
    this.variant = TabBarVariant.auto,
    this.isScrollable,
    this.height,
    this.outerPadding,
    this.itemPadding,
    this.gap = 10.0,
    this.controller,
    this.activeGradient,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.activeBadgeBgColor,
    this.activeBadgeTextColor,
    this.inactiveBadgeBgColor,
    this.inactiveBadgeTextColor,
    this.trackColor,
    this.activeCardColor,
    this.activeBorder,
    this.inactiveBorder,
    this.trackBorder,
    this.borderRadius,
    this.activeBoxShadow,
    this.inactiveBoxShadow,
    this.fontSize = 13.5,
    this.activeFontWeight = FontWeight.w700,
    this.inactiveFontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    // ── DECISION LOGIC ───────────────────────────────────────────────────────
    // If variant is auto (default):
    // - tabs.length == 2 -> Segmented TabBar
    // - tabs.length > 2  -> Pill TabBar (search screen style)
    final bool useSegmented = variant == TabBarVariant.segmented ||
        (variant == TabBarVariant.auto && tabs.length == 2);

    if (useSegmented) {
      return AppSegmentedTabBar(
        tabs: tabs,
        icons: icons,
        badgeTexts: badgeTexts,
        selectedIndex: selectedIndex,
        onTap: onTap,
        height: height ?? 48.0,
        outerPadding: outerPadding ?? const EdgeInsets.fromLTRB(20, 4, 20, 8),
        controller: controller,
        trackColor: trackColor,
        activeCardColor: activeCardColor,
        activeGradient: activeGradient,
        activeTextColor: activeTextColor,
        inactiveTextColor: inactiveTextColor,
        activeIconColor: activeIconColor,
        inactiveIconColor: inactiveIconColor,
        activeBadgeBgColor: activeBadgeBgColor,
        activeBadgeTextColor: activeBadgeTextColor,
        inactiveBadgeBgColor: inactiveBadgeBgColor,
        inactiveBadgeTextColor: inactiveBadgeTextColor,
        trackBorder: trackBorder,
        trackRadius: borderRadius,
        activeBoxShadow: activeBoxShadow,
        fontSize: fontSize,
        activeFontWeight: activeFontWeight,
        inactiveFontWeight: inactiveFontWeight,
      );
    }

    return AppPillTabBar(
      tabs: tabs,
      icons: icons,
      badgeTexts: badgeTexts,
      selectedIndex: selectedIndex,
      onTap: onTap,
      isScrollable: isScrollable ?? (tabs.length > 2),
      height: height ?? 42.0,
      outerPadding: outerPadding ?? const EdgeInsets.fromLTRB(20, 4, 20, 10),
      itemPadding: itemPadding ?? (tabs.length > 2 ? const EdgeInsets.symmetric(horizontal: 16) : const EdgeInsets.symmetric(horizontal: 10)),
      gap: gap,
      controller: controller,
      activeGradient: activeGradient,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      activeTextColor: activeTextColor,
      inactiveTextColor: inactiveTextColor,
      activeIconColor: activeIconColor,
      inactiveIconColor: inactiveIconColor,
      activeBadgeBgColor: activeBadgeBgColor,
      activeBadgeTextColor: activeBadgeTextColor,
      inactiveBadgeBgColor: inactiveBadgeBgColor,
      inactiveBadgeTextColor: inactiveBadgeTextColor,
      activeBorder: activeBorder,
      inactiveBorder: inactiveBorder,
      borderRadius: borderRadius,
      activeBoxShadow: activeBoxShadow,
      inactiveBoxShadow: inactiveBoxShadow,
      fontSize: fontSize,
      activeFontWeight: activeFontWeight,
      inactiveFontWeight: inactiveFontWeight,
    );
  }
}

// ── 1. APP PILL TAB BAR (Floating Pill Tabs) ─────────────────────────────────
class AppPillTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget?>? icons;
  final List<String?>? badgeTexts;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isScrollable;
  final double height;
  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry itemPadding;
  final double gap;
  final TabController? controller;

  final LinearGradient? activeGradient;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? activeBadgeBgColor;
  final Color? activeBadgeTextColor;
  final Color? inactiveBadgeBgColor;
  final Color? inactiveBadgeTextColor;
  final Border? activeBorder;
  final Border? inactiveBorder;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? activeBoxShadow;
  final List<BoxShadow>? inactiveBoxShadow;
  final double fontSize;
  final FontWeight activeFontWeight;
  final FontWeight inactiveFontWeight;

  const AppPillTabBar({
    super.key,
    required this.tabs,
    this.icons,
    this.badgeTexts,
    required this.selectedIndex,
    required this.onTap,
    this.isScrollable = false,
    this.height = 42.0,
    this.outerPadding = const EdgeInsets.fromLTRB(20, 4, 20, 10),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 14),
    this.gap = 10.0,
    this.controller,
    this.activeGradient,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.activeBadgeBgColor,
    this.activeBadgeTextColor,
    this.inactiveBadgeBgColor,
    this.inactiveBadgeTextColor,
    this.activeBorder,
    this.inactiveBorder,
    this.borderRadius,
    this.activeBoxShadow,
    this.inactiveBoxShadow,
    this.fontSize = 13.5,
    this.activeFontWeight = FontWeight.w700,
    this.inactiveFontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final defaultGradient = FigmaColors.primaryGradient(context);

    final effectiveRadius = borderRadius ?? BorderRadius.circular(height / 2);

    Widget buildPillItem(int index) {
      final isSelected = selectedIndex == index;
      final label = tabs[index];
      final icon = (icons != null && index < icons!.length) ? icons![index] : null;
      final badge = (badgeTexts != null && index < badgeTexts!.length) ? badgeTexts![index] : null;

      final currentGradient = isSelected
          ? (activeGradient ?? (activeColor == null ? defaultGradient : null))
          : null;

      final currentBgColor = isSelected
          ? (activeGradient == null ? (activeColor ?? primaryColor) : null)
          : (inactiveColor ?? (isDark ? Theme.of(context).colorScheme.surface : Colors.white));

      final currentTextColor = isSelected
          ? (activeTextColor ?? Colors.white)
          : (inactiveTextColor ?? (isDark ? const Color(0xFFA0A3BD) : const Color(0xFF5A5C72)));

      final currentIconColor = isSelected
          ? (activeIconColor ?? currentTextColor)
          : (inactiveIconColor ?? (isDark ? const Color(0xFFA0A3BD) : const Color(0xFF6E7085)));

      final currentBorder = isSelected
          ? activeBorder
          : (inactiveBorder ??
              Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFEFE8E1),
                width: 1.2,
              ));

      final currentShadow = isSelected
          ? (activeBoxShadow ??
              [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.22),
                  blurRadius: 14,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ])
          : (inactiveBoxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]);

      return GestureDetector(
        onTap: () {
          onTap(index);
          controller?.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          height: height,
          padding: itemPadding,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            gradient: currentGradient,
            color: currentBgColor,
            border: currentBorder,
            boxShadow: currentShadow,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    color: currentIconColor,
                    size: 17,
                  ),
                  child: icon,
                ),
                const Gap(6),
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: AppFont.font(
                      fontSize: fontSize,
                      fontWeight: isSelected ? activeFontWeight : inactiveFontWeight,
                      color: currentTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (badge != null && badge.isNotEmpty) ...[
                const Gap(7),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (activeBadgeBgColor ?? Colors.white.withValues(alpha: 0.25))
                        : (inactiveBadgeBgColor ??
                            (isDark
                                ? primaryColor.withValues(alpha: 0.2)
                                : primaryColor.withValues(alpha: 0.1))),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge,
                    style: AppFont.font(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: isSelected
                          ? (activeBadgeTextColor ?? Colors.white)
                          : (inactiveBadgeTextColor ?? primaryColor),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: outerPadding,
        child: Row(
          children: [
            for (int i = 0; i < tabs.length; i++) ...[
              if (i > 0) SizedBox(width: gap),
              buildPillItem(i),
            ],
          ],
        ),
      );
    }

    return Padding(
      padding: outerPadding,
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            if (i > 0) SizedBox(width: gap),
            Expanded(
              child: buildPillItem(i),
            ),
          ],
        ],
      ),
    );
  }
}

// ── 2. APP SEGMENTED TAB BAR (Segmented Track Control) ───────────────────────
class AppSegmentedTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget?>? icons;
  final List<String?>? badgeTexts;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final double height;
  final EdgeInsetsGeometry outerPadding;
  final TabController? controller;

  final Color? trackColor;
  final Color? activeCardColor;
  final LinearGradient? activeGradient;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? activeBadgeBgColor;
  final Color? activeBadgeTextColor;
  final Color? inactiveBadgeBgColor;
  final Color? inactiveBadgeTextColor;
  final Border? trackBorder;
  final BorderRadius? trackRadius;
  final BorderRadius? cardRadius;
  final List<BoxShadow>? activeBoxShadow;
  final double fontSize;
  final FontWeight activeFontWeight;
  final FontWeight inactiveFontWeight;

  const AppSegmentedTabBar({
    super.key,
    required this.tabs,
    this.icons,
    this.badgeTexts,
    required this.selectedIndex,
    required this.onTap,
    this.height = 48.0,
    this.outerPadding = const EdgeInsets.fromLTRB(20, 4, 20, 8),
    this.controller,
    this.trackColor,
    this.activeCardColor,
    this.activeGradient,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.activeBadgeBgColor,
    this.activeBadgeTextColor,
    this.inactiveBadgeBgColor,
    this.inactiveBadgeTextColor,
    this.trackBorder,
    this.trackRadius,
    this.cardRadius,
    this.activeBoxShadow,
    this.fontSize = 13.5,
    this.activeFontWeight = FontWeight.w700,
    this.inactiveFontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final defaultGradient = FigmaColors.primaryGradient(context);

    final defaultTrackBg = trackColor ?? (isDark ? const Color(0xFF191A29) : Colors.white);
    final effectiveTrackRadius = trackRadius ?? BorderRadius.circular(height / 2);
    final effectiveCardRadius = cardRadius ?? BorderRadius.circular((height - 8) / 2);
    final effectiveTrackBorder = trackBorder ??
        Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFF0EBE6),
          width: 1.0,
        );

    return Padding(
      padding: outerPadding,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: defaultTrackBg,
          borderRadius: effectiveTrackRadius,
          border: effectiveTrackBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;
            final label = tabs[index];
            final icon = (icons != null && index < icons!.length) ? icons![index] : null;
            final badge = (badgeTexts != null && index < badgeTexts!.length) ? badgeTexts![index] : null;

            final currentGradient = isSelected
                ? (activeGradient ?? (activeCardColor == null ? defaultGradient : null))
                : null;

            final currentBgColor = isSelected
                ? (activeGradient == null ? (activeCardColor ?? primaryColor) : null)
                : Colors.transparent;

            final currentTextColor = isSelected
                ? (activeTextColor ?? Colors.white)
                : (inactiveTextColor ?? (isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B)));

            final currentIconColor = isSelected
                ? (activeIconColor ?? Colors.white)
                : (inactiveIconColor ?? (isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B)));

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  onTap(index);
                  controller?.animateTo(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: currentBgColor,
                    gradient: currentGradient,
                    borderRadius: effectiveCardRadius,
                    boxShadow: isSelected
                        ? (activeBoxShadow ??
                            [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ])
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        IconTheme(
                          data: IconThemeData(
                            color: currentIconColor,
                            size: 17,
                          ),
                          child: icon,
                        ),
                        const Gap(6),
                      ],
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          label,
                          style: AppFont.font(
                            fontSize: fontSize,
                            fontWeight: isSelected ? activeFontWeight : inactiveFontWeight,
                            color: currentTextColor,
                          ),
                        ),
                      ),
                      if (badge != null && badge.isNotEmpty) ...[
                        const Gap(6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (activeBadgeBgColor ?? Colors.white.withValues(alpha: 0.25))
                                : (inactiveBadgeBgColor ??
                                    (isDark
                                        ? primaryColor.withValues(alpha: 0.2)
                                        : primaryColor.withValues(alpha: 0.1))),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            badge,
                            style: AppFont.font(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? (activeBadgeTextColor ?? Colors.white)
                                  : (inactiveBadgeTextColor ?? primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ── BACKWARD COMPATIBILITY ALIAS ─────────────────────────────────────────────
typedef SearchTabBar = AppTabBar;
