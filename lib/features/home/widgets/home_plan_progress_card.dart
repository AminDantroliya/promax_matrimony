import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/utils/utils.dart';

class HomePlanProgressCard extends StatelessWidget {
  final DashboardData data;
  final bool isDark;

  const HomePlanProgressCard({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPlan = data.currentPlan;
    final planName = currentPlan?.planName ?? '';
    final rawExpiryDate =
        currentPlan?.planExpiryDate ?? currentPlan?.planExpired ?? '';
    final expiryDate = _formatExpiryDate(rawExpiryDate);

    int contactsTotal = 0;
    int contactsUsed = 0;
    if (currentPlan?.contactViewsTotal != null) {
      contactsTotal = int.tryParse(currentPlan!.contactViewsTotal.toString()) ?? 0;
      contactsUsed = int.tryParse(currentPlan.contactViewsUsed?.toString() ?? '0') ?? 0;
    } else {
      contactsTotal = int.tryParse(currentPlan?.planViewContact?.toString() ?? '0') ?? 0;
      contactsUsed = int.tryParse(currentPlan?.viewContactsUsed?.toString() ?? '0') ?? 0;
    }
    final contactsRatio =
        contactsTotal > 0 ? (contactsUsed / contactsTotal).clamp(0.0, 1.0) : 0.0;

    int interestsTotal = 0;
    int interestsUsed = 0;
    if (currentPlan?.interestsTotal != null) {
      interestsTotal = int.tryParse(currentPlan!.interestsTotal.toString()) ?? 0;
      interestsUsed = int.tryParse(currentPlan.interestsUsed?.toString() ?? '0') ?? 0;
    } else {
      interestsTotal = int.tryParse(currentPlan?.planTotalInterest?.toString() ?? '0') ?? 0;
      interestsUsed = int.tryParse(currentPlan?.interestUsed?.toString() ?? '0') ?? 0;
    }
    final interestsRatio =
        interestsTotal > 0 ? (interestsUsed / interestsTotal).clamp(0.0, 1.0) : 0.0;

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
        padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planName.isNotEmpty ? planName : 'membership'.tr,
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF16182F),
                        ),
                      ),
                      if (expiryDate.isNotEmpty)
                        Text(
                          '${'expires_lbl'.tr} $expiryDate',
                          style: AppFont.font(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8A90A6),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (currentPlan != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '● ${'active_lbl'.tr.toUpperCase()}',
                    style: AppFont.font(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF22C55E),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
            ],
          ),
          const Gap(16),

          // Contacts Progress Bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.icProfileCardCall,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                        height: 14,
                        width: 14,
                      ),
                      const Gap(6),
                      Text(
                        'contacts_lbl'.tr,
                        style: AppFont.font(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF16182F),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: '$contactsUsed',
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: '/$contactsTotal',
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF16182F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: contactsRatio,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFF1F5F9),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),

          const Gap(16),

          // Interests Progress Bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.icProfileCardMatch,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                        height: 14,
                        width: 14,
                      ),
                      const Gap(6),
                      Text(
                        'interests_lbl'.tr,
                        style: AppFont.font(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF16182F),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: '$interestsUsed',
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: '/$interestsTotal',
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF16182F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: interestsRatio,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFF1F5F9),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
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
      return "${dt.day} ${months[dt.month - 1]}, ${dt.year}";
    } catch (_) {
      return dateStr;
    }
  }
}
