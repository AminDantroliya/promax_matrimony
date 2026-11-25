import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/providers/config_providers.dart';
import 'designs/bottom_nav_design_1.dart';
import 'designs/bottom_nav_design_2.dart';
import 'designs/bottom_nav_design_3.dart';
import 'designs/bottom_nav_design_4.dart';
import 'designs/bottom_nav_design_5.dart';

/// Central Bottom Navigation Bar dispatcher.
/// Dynamically switches between design styles according to AppConfig / FlavorConfig / Admin API:
/// - design_1: Curved top bar with elevated dual-ring center Matches button (Figma default)
/// - design_2: Modern Floating Island / Capsule Dock Bar
/// - design_3: Classic Clean Minimalist Modern (symmetrical with top indicator bar)
/// - design_4: Elevated Center Floating FAB Bar (sculpted curve)
/// - design_5: Modern Expanding Fluid Pill Bar
class BottomNavBarWidget extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final String? overrideDesign;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    this.overrideDesign,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final enableChat = ref.watch(featureProvider('enableChat'));
    final rawDesign = (overrideDesign ?? config.bottomBarDesign).trim();
    final match = RegExp(r'(\d+)').firstMatch(rawDesign);
    final styleId = match != null ? int.tryParse(match.group(1)!) : 1;

    switch (styleId) {
      case 2:
        return BottomNavDesign2(
          currentIndex: currentIndex,
          onTabSelected: onTabSelected,
          enableChat: enableChat,
        );
      case 3:
        return BottomNavDesign3(
          currentIndex: currentIndex,
          onTabSelected: onTabSelected,
          enableChat: enableChat,
        );
      case 4:
        return BottomNavDesign4(
          currentIndex: currentIndex,
          onTabSelected: onTabSelected,
          enableChat: enableChat,
        );
      case 5:
        return BottomNavDesign5(
          currentIndex: currentIndex,
          onTabSelected: onTabSelected,
          enableChat: enableChat,
        );
      case 1:
      default:
        return BottomNavDesign1(
          currentIndex: currentIndex,
          onTabSelected: onTabSelected,
          enableChat: enableChat,
        );
    }
  }
}
