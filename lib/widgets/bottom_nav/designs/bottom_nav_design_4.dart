import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

/// Design 4: Elevated Center Floating FAB Bar (with raised action button overflowing top)
class BottomNavDesign4 extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool enableChat;

  const BottomNavDesign4({
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

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Base bar container
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF161722) : Colors.white,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 18,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 68,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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

                          // Spacer for center elevated FAB
                          const Expanded(child: SizedBox()),

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
          ),
        ),

        // Elevated FAB (Matches - Tab 3) only when 5 tabs (enableChat)
        if (enableChat)
          Positioned(
            top: -20,
            child: _buildElevatedFab(context, config, theme, isDarkMode),
          ),
      ],
    );
  }

  Widget _buildElevatedFab(
    BuildContext context,
    dynamic config,
    ThemeData theme,
    bool isDarkMode,
  ) {
    final isMatchesSelected = currentIndex == 3;
    final primaryColor = theme.primaryColor;

    return GestureDetector(
      onTap: () => onTabSelected(3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isMatchesSelected
                    ? [config.gradientStart, config.gradientEnd]
                    : [
                        isDarkMode
                            ? const Color(0xFF2C2E46)
                            : const Color(0xFFEEE7F1),
                        isDarkMode
                            ? const Color(0xFF202235)
                            : const Color(0xFFE2D8E7),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: isMatchesSelected
                      ? primaryColor.withValues(alpha: 0.45)
                      : Colors.black.withValues(alpha: 0.12),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: isDarkMode ? const Color(0xFF161722) : Colors.white,
                width: 4,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.favorite_rounded,
                color: isMatchesSelected
                    ? Colors.white
                    : (isDarkMode
                        ? const Color(0xFF8E90A6)
                        : const Color(0xFF9E8DB0)),
                size: 26,
              ),
            ),
          ),
          const Gap(2),
          Text(
            'matches'.tr,
            style: AppFont.font(
              fontSize: 10,
              fontWeight:
                  isMatchesSelected ? FontWeight.w700 : FontWeight.w600,
              color: isMatchesSelected
                  ? primaryColor
                  : (isDarkMode
                      ? const Color(0xFF8E90A6)
                      : const Color(0xFF9E8DB0)),
            ),
          ),
        ],
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
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: 21,
                height: 21,
                colorFilter: ColorFilter.mode(
                  isSelected ? primaryColor : inactiveColor,
                  BlendMode.srcIn,
                ),
              )
            else if (iconData != null)
              Icon(
                iconData,
                size: 21,
                color: isSelected ? primaryColor : inactiveColor,
              ),
            const Gap(4),
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
