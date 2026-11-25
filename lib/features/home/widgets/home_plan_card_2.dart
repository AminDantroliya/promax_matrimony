import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/utils/utils.dart';

class HomePlanCard2 extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const HomePlanCard2({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool enableVideoCall = ref.watch(featureProvider('enableVideoCall'));
    final primaryColor = Theme.of(context).primaryColor;
    final currentPlan = data.currentPlan;
    final planName = currentPlan?.planName ?? '';

    int contactsTotal = 0;
    if (currentPlan?.contactViewsTotal != null) {
      contactsTotal = int.tryParse(currentPlan!.contactViewsTotal.toString()) ?? 0;
    } else {
      contactsTotal = int.tryParse(currentPlan?.planViewContact?.toString() ?? '0') ?? 0;
    }

    int interestsTotal = 0;
    if (currentPlan?.interestsTotal != null) {
      interestsTotal = int.tryParse(currentPlan!.interestsTotal.toString()) ?? 0;
    } else {
      interestsTotal = int.tryParse(currentPlan?.planTotalInterest?.toString() ?? '0') ?? 0;
    }

    int videoTotal = 0;
    if (currentPlan?.videoMinutesTotal != null) {
      videoTotal = int.tryParse(currentPlan!.videoMinutesTotal.toString()) ?? 0;
    } else {
      final parts = (currentPlan?.planVideoCallRemaining ?? "0").split('/');
      videoTotal = int.tryParse(parts.last.trim()) ?? 0;
    }

    final rawExpiryDate =
        currentPlan?.planExpiryDate ?? currentPlan?.planExpired ?? '';
    final expiryDate = _formatExpiryDate(rawExpiryDate);

    return GestureDetector(
      onTap: () {
        if (currentPlan != null) {
          context.push('/current-plan');
        } else {
          context.push('/plans');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: SvgPicture.asset(
                AppAssets.icPremium,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        planName.isNotEmpty ? planName : 'membership'.tr,
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF16182F),
                        ),
                      ),
                      if (currentPlan != null) ...[
                        const Gap(6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '● ${'active_lbl'.tr.toUpperCase()}',
                            style: AppFont.font(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF22C55E),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(2),
                  Text(
                    () {
                      final List<String> metrics = [
                        '$contactsTotal ${'contacts_lbl'.tr}',
                        '$interestsTotal ${'interests_lbl'.tr}',
                        if (enableVideoCall) '$videoTotal ${'min_lbl'.tr}',
                      ];
                      if (expiryDate.isNotEmpty) {
                        metrics.add('${'till_lbl'.tr} $expiryDate');
                      }
                      return metrics.join(' · ');
                    }(),
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8A90A6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaNavigationForward,
                  colorFilter: ColorFilter.mode(
                    primaryColor,
                    BlendMode.srcIn,
                  ),
                  height: 14,
                  width: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatExpiryDate(String dateStr) {
    if (dateStr.trim().isEmpty) return '';
    try {
      final dt = DateTime.parse(dateStr.trim());
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return "${dt.day} ${months[dt.month - 1]}";
    } catch (_) {
      return dateStr;
    }
  }
}
