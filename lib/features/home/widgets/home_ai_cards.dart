import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';

import '../../../utils/utils.dart';
import '../../matches/dynamic/screens/dynamic_ai_match_filter_screen.dart';

class HomeAICards extends ConsumerWidget {
  final bool isDark;

  const HomeAICards({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildAICard(
          context: context,
          title: 'ai_for_you_title'.tr,
          subtitle: 'ai_for_you_subtitle'.tr,
          buttonText: 'match_with_ai_btn'.tr,
          svgIcon: AppAssets.icDashboardAiForYou,
          iconColor: Theme.of(context).primaryColor,
          iconBgColor: Theme.of(context).primaryColor.withValues(alpha: isDark ? 0.2 : 0.12),
          buttonBgColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DynamicAiMatchFilterScreen()),
            );
          },
          isDark: isDark,
        ),
        const Gap(12),
        _buildAICard(
          context: context,
          title: 'ai_compatibility_title'.tr,
          subtitle: 'ai_compatibility_subtitle'.tr,
          buttonText: 'check_now_btn'.tr,
          svgIcon: AppAssets.icDashboardAiCompatibility,
          iconColor: Theme.of(context).colorScheme.secondary,
          iconBgColor: Theme.of(context)
              .colorScheme
              .secondary
              .withValues(alpha: isDark ? 0.2 : 0.12),
          buttonBgColor: Theme.of(context).colorScheme.secondary,
          onTap: () async {
            final allowed = await checkAiInterestPermission(context, ref);
            if (allowed && context.mounted) {
              context.push('/auto-send-interest');
            }
          },
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildAICard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String buttonText,
    required String svgIcon,
    required Color iconColor,
    required Color iconBgColor,
    required Color buttonBgColor,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B1C2A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : const Color(0xFFF1F3F9),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                    ),
                  ),
                  const Gap(3),
                  Text(
                    subtitle,
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? const Color(0xFF8E90A6)
                          : const Color(0xFF7A7A8C),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: buttonBgColor,
                borderRadius: AppTheme.getButtonBorderRadius(context),
              ),
              child: Text(
                buttonText,
                style: AppFont.font(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
