import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

/// Design 3: Classic Clean Minimalist Modern (Symmetrical tabs with top indicator line)
class BottomNavDesign3 extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool enableChat;

  const BottomNavDesign3({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.enableChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF161722) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? Colors.white.withValues(alpha: 0.08)
                : const Color(0xFFEEEBF2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: enableChat
                ? [
                    // Tab 0: Home
                    Expanded(
                      child: _buildItem(
                        index: 0,
                        svgPath: AppAssets.figmaBottomHome,
                        label: 'home'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),

                    // Tab 1: Search
                    Expanded(
                      child: _buildItem(
                        index: 1,
                        svgPath: AppAssets.figmaBottomSearch,
                        label: 'search'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),

                    // Tab 3: Matches (Center)
                    Expanded(
                      child: _buildItem(
                        index: 3,
                        iconData: Icons.favorite_rounded,
                        label: 'matches'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),

                    // Tab 2: Chat
                    Expanded(
                      child: _buildItem(
                        index: 2,
                        svgPath: AppAssets.figmaBottomChat,
                        label: 'chat'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),

                    // Tab 4: More
                    Expanded(
                      child: _buildItem(
                        index: 4,
                        svgPath: AppAssets.figmaBottomMore,
                        label: 'more'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ]
                : [
                    // Balanced Symmetrical 4-Tab Layout: Home, Matches, Search, More
                    Expanded(
                      child: _buildItem(
                        index: 0,
                        svgPath: AppAssets.figmaBottomHome,
                        label: 'home'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    Expanded(
                      child: _buildItem(
                        index: 3,
                        iconData: Icons.favorite_rounded,
                        label: 'matches'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    Expanded(
                      child: _buildItem(
                        index: 1,
                        svgPath: AppAssets.figmaBottomSearch,
                        label: 'search'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    Expanded(
                      child: _buildItem(
                        index: 4,
                        svgPath: AppAssets.figmaBottomMore,
                        label: 'more'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top indicator bar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: isSelected ? 32 : 0,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.transparent,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(3),
              ),
            ),
          ),
          const Spacer(),
          // Icon
          if (svgPath != null)
            SvgPicture.asset(
              svgPath,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isSelected ? primaryColor : inactiveColor,
                BlendMode.srcIn,
              ),
            )
          else if (iconData != null)
            Icon(
              iconData,
              size: 22,
              color: isSelected ? primaryColor : inactiveColor,
            ),
          const Gap(4),
          // Label
          Text(
            label,
            style: AppFont.font(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? primaryColor : inactiveColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
