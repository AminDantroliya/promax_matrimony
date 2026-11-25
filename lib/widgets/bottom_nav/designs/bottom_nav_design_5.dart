import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

/// Design 5: Modern Expanding Fluid Pill Bar (active tab expands with label and pill background)
class BottomNavDesign5 extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool enableChat;

  const BottomNavDesign5({
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: enableChat
                  ? [
                      // Tab 0: Home
                      _buildExpandingItem(
                        index: 0,
                        svgPath: AppAssets.figmaBottomHome,
                        label: 'home'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Tab 1: Search
                      _buildExpandingItem(
                        index: 1,
                        svgPath: AppAssets.figmaBottomSearch,
                        label: 'search'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Tab 3: Matches
                      _buildExpandingItem(
                        index: 3,
                        iconData: Icons.favorite_rounded,
                        label: 'matches'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Tab 2: Chat
                      _buildExpandingItem(
                        index: 2,
                        svgPath: AppAssets.figmaBottomChat,
                        label: 'chat'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),

                      // Tab 4: More
                      _buildExpandingItem(
                        index: 4,
                        svgPath: AppAssets.figmaBottomMore,
                        label: 'more'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                    ]
                  : [
                      // Balanced Symmetrical 4-Tab Layout: Home, Matches, Search, More
                      _buildExpandingItem(
                        index: 0,
                        svgPath: AppAssets.figmaBottomHome,
                        label: 'home'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                      _buildExpandingItem(
                        index: 3,
                        iconData: Icons.favorite_rounded,
                        label: 'matches'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                      _buildExpandingItem(
                        index: 1,
                        svgPath: AppAssets.figmaBottomSearch,
                        label: 'search'.tr,
                        theme: theme,
                        isDarkMode: isDarkMode,
                      ),
                      _buildExpandingItem(
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

  Widget _buildExpandingItem({
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
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode
                  ? primaryColor.withValues(alpha: 0.22)
                  : primaryColor.withValues(alpha: 0.12))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            if (isSelected) ...[
              const Gap(8),
              Text(
                label,
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
