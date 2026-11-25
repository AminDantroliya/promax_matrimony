import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../data/models/dashboard_models.dart';
import '../utils/home_helpers.dart';

class HomePlanCard extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const HomePlanCard({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool enableVideoCall = ref.watch(featureProvider('enableVideoCall'));
    final bool isAiEnabled = ref.watch(featureProvider('enableAiMatchmaking'));
    final hasActivePlan =
        data.planStatus?.toLowerCase() == "paid" && data.currentPlan != null;

    if (hasActivePlan) {
      final currentPlan = data.currentPlan!;
      final expiryText = HomeHelpers.getFormattedPlanDate(
        currentPlan.planExpiryDate ?? "",
      );

      int parseInt(dynamic val) => int.tryParse(val?.toString() ?? "0") ?? 0;
      final contactsLeft =
          parseInt(currentPlan.contactViewsTotal) -
          parseInt(currentPlan.contactViewsUsed);
      final interestsLeft =
          parseInt(currentPlan.interestsTotal) -
          parseInt(currentPlan.interestsUsed);
      final videoMinsLeft =
          parseInt(currentPlan.videoMinutesTotal) -
          parseInt(currentPlan.videoMinutesUsed);

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF435368), Color(0xFF6B7D93)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF435368).withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.workspace_premium,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentPlan.planName ?? "Premium Plus",
                                style: AppFont.font(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'active_subscription_lbl'.tr,
                                style: AppFont.font(
                                  fontSize: 11,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'active_lbl'.tr,
                          style: AppFont.font(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlanMetricItem(
                        contactsLeft.toString(),
                        'contacts_left_lbl'.tr,
                      ),
                      _buildPlanMetricDivider(),
                      _buildPlanMetricItem(
                        interestsLeft.toString(),
                        'interests_left_lbl'.tr,
                      ),
                      if (enableVideoCall) ...[
                        _buildPlanMetricDivider(),
                        _buildPlanMetricItem(
                          videoMinsLeft.toString(),
                          'video_mins_left_lbl'.tr,
                        ),
                      ],
                    ],
                  ),
                  const Gap(16),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expiryText.isNotEmpty
                            ? "${'expires_on_lbl'.tr}: $expiryText"
                            : "",
                        style: AppFont.font(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/current-plan'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppTheme.getButtonBorderRadius(context),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'current_plan_lbl'.tr,
                                style: AppFont.font(
                                  color: const Color(0xFF435368),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(4),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Color(0xFF435368),
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      final secondaryColor = Theme.of(context).colorScheme.secondary;
      final primaryColor = Theme.of(context).primaryColor;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [secondaryColor, primaryColor],
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryColor.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.workspace_premium,
                          color: Color(0xFFFABE2C),
                          size: 24,
                        ),
                      ),
                      const Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'upgrade_to_premium'.tr,
                            style: AppFont.font(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'unlock_unlimited_matches'.tr,
                            style: AppFont.font(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildPlanFeatureItem('unlimited_chats_lbl'.tr),
                            const Gap(8),
                            _buildPlanFeatureItem('priority_match_lbl'.tr),
                          ],
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          children: [
                            _buildPlanFeatureItem('see_contacts_lbl'.tr),
                            const Gap(8),
                            _buildPlanFeatureItem(
                              isAiEnabled
                                  ? 'ai_suggestions_lbl'.tr
                                  : 'send_interest'.tr,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      GestureDetector(
                        onTap: () => context.push('/plans'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppTheme.getButtonBorderRadius(context),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'upgrade_lbl'.tr,
                                style: AppFont.font(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildPlanMetricItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppFont.font(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const Gap(2),
        Text(
          label,
          style: AppFont.font(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanMetricDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  Widget _buildPlanFeatureItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF34C759), size: 14),
          const Gap(6),
          Expanded(
            child: Text(
              text,
              style: AppFont.font(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
