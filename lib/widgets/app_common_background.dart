import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/utils/app_assets.dart';
import 'package:zego_uikit/zego_uikit.dart';

/// AppAuthBackground is used specifically for Splash, Intro, and Login screens.
/// It dynamically renders a luxury dark background derived from the active theme's colors
/// with soft ambient glow orbs and the subtle stardust background overlay.
class AppAuthBackground extends ConsumerWidget {
  final Widget child;
  final bool isLight;

  const AppAuthBackground({
    super.key,
    required this.child,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final gradStart = config.gradientStart;
    final gradEnd = config.gradientEnd;

    if (isLight) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF7F8FA),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Subtle ambient background shapes for soft visual depth (matching splash screen minimal)
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEDF2F7).withValues(alpha: 0.65),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -60,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE2E8F0).withValues(alpha: 0.40),
                ),
              ),
            ),
            // Soft primary tint ambient center glow
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              height: 380,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        gradStart.withValues(alpha: 0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Content
            child,
          ],
        ),
      );
    }

    final hslStart = HSLColor.fromColor(gradStart);
    final hslEnd = HSLColor.fromColor(gradEnd);

    // Deep luxury dark background derived dynamically from the theme's colors
    final darkBgTop = hslStart.withLightness(0.09).withSaturation(0.65).toColor();
    final darkBgBottom = hslEnd.withLightness(0.04).withSaturation(0.75).toColor();

    bool isCallActive = false;
    try {
      final roomState = ZegoUIKit().getRoomStateStream().value;
      isCallActive = roomState.reason == ZegoRoomStateChangedReason.Logined;
    } catch (_) {}

    if (isCallActive) {
      return Container(
        color: darkBgBottom,
        child: child,
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [darkBgTop, darkBgBottom],
        ),
      ),
      child: Stack(
        children: [
          // ── Ambient Glow Orb 1 (Top / Center glow from primary theme color) ──
          Positioned(
            top: -120,
            left: -60,
            right: -60,
            height: 480,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      gradStart.withValues(alpha: 0.25),
                      gradStart.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Ambient Glow Orb 2 (Bottom glow from secondary theme color) ──
          Positioned(
            bottom: -100,
            left: -40,
            right: -40,
            height: 420,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      gradEnd.withValues(alpha: 0.20),
                      gradEnd.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Fullscreen SVG Background Overlay (Subtle star & stardust texture) ──
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.15,
                child: SvgPicture.asset(
                  AppAssets.splashBg,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    darkBgTop,
                    BlendMode.srcATop,
                  ),
                ),
              ),
            ),
          ),

          // ── Page Content ─────────────────────────────────────────────
          child,
        ],
      ),
    );
  }
}

/// AppCommonBackground is the unified dynamic background widget for Register and all other app screens.
/// It dynamically reads Theme.of(context).scaffoldBackgroundColor (or AppConfig scaffoldBgColor),
/// allowing developers or admin remote-config to change the app theme background dynamically.
class AppCommonBackground extends ConsumerWidget {
  final Widget child;
  final Color? backgroundColor;

  const AppCommonBackground({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCallActive = false;
    try {
      final roomState = ZegoUIKit().getRoomStateStream().value;
      isCallActive = roomState.reason == ZegoRoomStateChangedReason.Logined;
    } catch (_) {}

    final config = ref.watch(appConfigProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isCallActive) {
      return Container(
        color: isDark ? const Color(0xFF0C0D16) : config.scaffoldBgColor,
        child: child,
      );
    }

    final bgColor = backgroundColor ??
        (isDark
            ? (theme.scaffoldBackgroundColor != Colors.transparent
                ? theme.scaffoldBackgroundColor
                : const Color(0xFF0C0D16))
            : (theme.scaffoldBackgroundColor != Colors.transparent
                ? theme.scaffoldBackgroundColor
                : config.scaffoldBgColor));

    return Container(
      color: bgColor,
      child: child,
    );
  }
}

/// PageTransitionsBuilder wrapping pages with AppCommonBackground
class AppCommonPageTransitionsBuilder extends PageTransitionsBuilder {
  final PageTransitionsBuilder platformBuilder;

  const AppCommonPageTransitionsBuilder({required this.platformBuilder});

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final childType = child.runtimeType.toString();
    final routeName = route.settings.name ?? "";
    if (childType.contains("Zego") ||
        childType.contains("Calling") ||
        routeName.contains("zego")) {
      return platformBuilder.buildTransitions(
        route,
        context,
        animation,
        secondaryAnimation,
        child,
      );
    }

    return platformBuilder.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      AppCommonBackground(child: child),
    );
  }
}
