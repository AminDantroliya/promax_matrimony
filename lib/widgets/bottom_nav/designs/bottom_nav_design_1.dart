import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

class BottomNavDesign1 extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool enableChat;

  const BottomNavDesign1({
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

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF161722) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 75,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: enableChat
                  ? [
                      // Tab 0: Home
                      _buildCustomNavItem(
                        index: 0,
                        svgPath: AppAssets.figmaBottomHome,
                        label: 'home'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Tab 1: Search
                      _buildCustomNavItem(
                        index: 1,
                        svgPath: AppAssets.figmaBottomSearch,
                        label: 'search'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Center Action Button: Matches (Tab 3)
                      _buildCenterButton(context, config, theme, isDarkMode),

                      // Tab 2: Chat
                      _buildCustomNavItem(
                        index: 2,
                        svgPath: AppAssets.figmaBottomChat,
                        label: 'chat'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Tab 4: More / Menu
                      _buildCustomNavItem(
                        index: 4,
                        svgPath: AppAssets.figmaBottomMore,
                        label: 'more'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ]
                  : [
                      // Balanced Symmetrical 4-Tab Layout: Home, Matches, Search, More
                      _buildCustomNavItem(
                        index: 0,
                        svgPath: AppAssets.figmaBottomHome,
                        label: 'home'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                      _buildCustomNavItem(
                        index: 3,
                        iconData: Icons.favorite_rounded,
                        label: 'matches'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                      _buildCustomNavItem(
                        index: 1,
                        svgPath: AppAssets.figmaBottomSearch,
                        label: 'search'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                      _buildCustomNavItem(
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
      ),
    );
  }

  Widget _buildCenterButton(
    BuildContext context,
    dynamic config,
    ThemeData theme,
    bool isDarkMode,
  ) {
    final isMatchesSelected = currentIndex == 3;
    final primaryColor = theme.primaryColor;
    final inactiveColor =
        isDarkMode ? const Color(0xFF8E90A6) : const Color(0xFF9E8DB0);

    return GestureDetector(
      onTap: () => onTabSelected(3),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isMatchesSelected
              ? (isDarkMode
                  ? primaryColor.withValues(alpha: 0.25)
                  : primaryColor.withValues(alpha: 0.15))
              : (isDarkMode
                  ? inactiveColor.withValues(alpha: 0.12)
                  : inactiveColor.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: (isMatchesSelected ? primaryColor : inactiveColor)
                  .withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
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
                    ? const Color(0xFF28293D)
                    : const Color(0xFFB8A5C0)),
            border: Border.all(
              color: isDarkMode
                  ? const Color(0xFF161722)
                  : const Color(0xFFFAF3EF),
              width: 3.5,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomNavItem({
    required int index,
    String? svgPath,
    IconData? iconData,
    required String label,
    required ThemeData theme,
    required bool isDarkMode,
  }) {
    final isSelected = currentIndex == index;

    final activeBg = isDarkMode
        ? theme.primaryColor.withValues(alpha: 0.20)
        : theme.primaryColor.withValues(alpha: 0.12);
    final activeContentColor = theme.primaryColor;
    final inactiveContentColor =
        isDarkMode ? const Color(0xFF8E90A6) : const Color(0xFF9E8DB0);

    return InkWell(
      onTap: () => onTabSelected(index),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  isSelected ? activeContentColor : inactiveContentColor,
                  BlendMode.srcIn,
                ),
              )
            else if (iconData != null)
              Icon(
                iconData,
                size: 22,
                color: isSelected ? activeContentColor : inactiveContentColor,
              ),
            const Gap(4),
            Text(
              label,
              style: AppFont.font(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? activeContentColor : inactiveContentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
