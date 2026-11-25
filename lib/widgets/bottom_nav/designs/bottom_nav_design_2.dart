import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

/// Design 2: Modern Floating Island / Capsule Dock Bar
class BottomNavDesign2 extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool enableChat;

  const BottomNavDesign2({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.enableChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        height: 70,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF161722)
              : Colors.white.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withValues(alpha: 0.08)
                : const Color(0xFFF0EDF2),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: enableChat
                ? [
                    // Tab 0: Home
                    _buildNavItem(
                      index: 0,
                      svgPath: AppAssets.figmaBottomHome,
                      label: 'home'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),

                    // Tab 1: Search
                    _buildNavItem(
                      index: 1,
                      svgPath: AppAssets.figmaBottomSearch,
                      label: 'search'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),

                    // Center Matches Action (Tab 3)
                    _buildCenterIslandButton(config, theme, isDarkMode),

                    // Tab 2: Chat
                    _buildNavItem(
                      index: 2,
                      svgPath: AppAssets.figmaBottomChat,
                      label: 'chat'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),

                    // Tab 4: More
                    _buildNavItem(
                      index: 4,
                      svgPath: AppAssets.figmaBottomMore,
                      label: 'more'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),
                  ]
                : [
                    // Balanced Symmetrical 4-Tab Layout: Home, Matches, Search, More
                    _buildNavItem(
                      index: 0,
                      svgPath: AppAssets.figmaBottomHome,
                      label: 'home'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      index: 3,
                      iconData: Icons.favorite_rounded,
                      label: 'matches'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      index: 1,
                      svgPath: AppAssets.figmaBottomSearch,
                      label: 'search'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      index: 4,
                      svgPath: AppAssets.figmaBottomMore,
                      label: 'more'.tr,
                      theme: theme,
                      isDarkMode: isDarkMode,
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterIslandButton(
    dynamic config,
    ThemeData theme,
    bool isDarkMode,
  ) {
    final isMatchesSelected = currentIndex == 3;
    final primaryColor = theme.primaryColor;

    return GestureDetector(
      onTap: () => onTabSelected(3),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isMatchesSelected
              ? LinearGradient(
                  colors: [
                    config.gradientStart,
                    config.gradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isMatchesSelected
              ? null
              : (isDarkMode
                  ? const Color(0xFF24263B)
                  : const Color(0xFFF3EDF5)),
          boxShadow: [
            BoxShadow(
              color: isMatchesSelected
                  ? primaryColor.withValues(alpha: 0.40)
                  : Colors.transparent,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.favorite_rounded,
            color: isMatchesSelected
                ? Colors.white
                : (isDarkMode
                    ? const Color(0xFF8E90A6)
                    : const Color(0xFF9E8DB0)),
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    String? svgPath,
    IconData? iconData,
    required String label,
    required ThemeData theme,
    required bool isDarkMode,
  }) {
    final isSelected = currentIndex == index;
    final primaryColor = theme.primaryColor;
    final inactiveColor =
        isDarkMode ? const Color(0xFF8E90A6) : const Color(0xFF9E8DB0);

    return InkWell(
      onTap: () => onTabSelected(index),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode
                  ? primaryColor.withValues(alpha: 0.18)
                  : primaryColor.withValues(alpha: 0.10))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isSelected ? primaryColor : inactiveColor,
                  BlendMode.srcIn,
                ),
              )
            else if (iconData != null)
              Icon(
                iconData,
                size: 20,
                color: isSelected ? primaryColor : inactiveColor,
              ),
            const Gap(3),
            Text(
              label,
              style: AppFont.font(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? primaryColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
