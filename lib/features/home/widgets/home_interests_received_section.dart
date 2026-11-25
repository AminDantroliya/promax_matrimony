import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../../../features/common/data/models/member_models.dart';
import '../../../features/connection/providers/connection_notifier.dart';
import '../../../utils/utils.dart';
import '../data/models/dashboard_models.dart';
import '../providers/dashboard_notifier.dart';
import '../utils/home_helpers.dart';

class HomeInterestsReceivedSection extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const HomeInterestsReceivedSection({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = data.receivedInterest ?? [];
    if (list.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${'interests_received_title'.tr} ',
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: '',
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/connections'),
                child: Text(
                  'see_all_lbl'.tr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        SizedBox(
          height: 162,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: list.length > 5 ? 5 : list.length,
            itemBuilder: (context, index) {
              final member = list[index];
              return _buildInterestReceivedCard(context, ref, member, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInterestReceivedCard(
    BuildContext context,
    WidgetRef ref,
    MemberListModel member,
    bool isDark,
  ) {
    final name = (member.profileTitle ?? member.fullname ?? "").toString();
    final timeText = HomeHelpers.getTimeAgo(member.sentDate);
    final matchPct = member.matchPercent ?? 75;
    final status = member.receiverResponse?.toString() ?? "Pending";
    final isPending = status.toLowerCase() == "pending";

    return GestureDetector(
      onTap: () {
        final memberId = member.memberId ?? member.id;
        if (memberId != null) {
          context.push('/profile-other/$memberId');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
          bottom: 10,
        ),
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
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: getImageWidget(
                          url: member.profileImage ?? member.photo1 ?? "",
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (member.isOnline == "online")
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF34C759),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF1B1C2A)
                                  : Colors.white,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: AppFont.font(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1A1A2E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (member.mobileVerifyStatus == 'Yes' ||
                              member.idProofStatus == 'APPROVED') ...[
                            const Gap(4),
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF34C759),
                              size: 14,
                            ),
                          ],
                        ],
                      ),
                      const Gap(2),
                      Text(
                        member.subTitle?.toString() ?? "",
                        style: AppFont.font(
                          fontSize: 10,
                          color: isDark
                              ? const Color(0xFF8E90A6)
                              : const Color(0xFF7A7A8C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          if ((member.educationDetails ?? "")
                              .toString()
                              .trim()
                              .isNotEmpty) ...[
                            _buildInterestTag(
                              member.educationDetails.toString().trim(),
                              Icons.school_outlined,
                              isDark,
                            ),
                            const Gap(6),
                          ],
                          if (HomeHelpers.getReligion(member).isNotEmpty)
                            _buildInterestTag(
                              HomeHelpers.getReligion(member),
                              Icons.star_outline,
                              isDark,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2C2415)
                        : const Color(0xFFFFF7E6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: isDark
                            ? const Color(0xFFFFB020)
                            : const Color(0xFFD97706),
                        size: 10,
                      ),
                      const Gap(3),
                      Text(
                        timeText,
                        style: AppFont.font(
                          color: isDark
                              ? const Color(0xFFFFB020)
                              : const Color(0xFFD97706),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(8),
            Divider(
              height: 1,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFF1F3F9),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6A21E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.favorite, color: Colors.white, size: 12),
                      const Gap(4),
                      Text(
                        "$matchPct%",
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isPending)
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _handleInterestAction(
                          context,
                          ref,
                          member.id!.toString(),
                          "reject",
                        ),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF3F1D24)
                                : const Color(0xFFFFF0F2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.deleteProfileCancel,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFFF2D55),
                                BlendMode.srcIn,
                              ),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      GestureDetector(
                        onTap: () => _handleInterestAction(
                          context,
                          ref,
                          member.id!.toString(),
                          "accept",
                        ),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            gradient: FigmaColors.primaryGradient(context),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.string(
                                '''<svg viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="4" y="4" width="16" height="16" rx="4" />
                                <path d="M8 12l3 3L16 9" />
                              </svg>''',
                                width: 16,
                                height: 16,
                              ),
                              const Gap(6),
                              Text(
                                'accept_lbl'.tr,
                                style: AppFont.font(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  _buildInterestStatusPill(status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestStatusPill(String status) {
    Color mainColor = const Color(0xFFFABE2C);
    IconData icon = Icons.access_time_filled;

    final lower = status.toLowerCase();
    String displayText = status.toUpperCase();

    if (lower == "accepted" || lower == "accept") {
      mainColor = const Color(0xFF22C55E);
      icon = Icons.check_circle_rounded;
      displayText = 'accepted_lbl'.tr;
    } else if (lower == "rejected" ||
        lower == "reject" ||
        lower == "declined") {
      mainColor = const Color(0xFFEF4444);
      icon = Icons.cancel_rounded;
      displayText = 'rejected_lbl'.tr;
    } else if (lower == "pending") {
      displayText = 'pending_lbl'.tr;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: mainColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: mainColor, size: 11),
          const Gap(4),
          Text(
            displayText,
            style: AppFont.font(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestTag(String label, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF7A7A8C),
            size: 10,
          ),
          const Gap(4),
          Flexible(
            child: Text(
              label,
              style: AppFont.font(
                color: isDark
                    ? const Color(0xFF8E90A6)
                    : const Color(0xFF7A7A8C),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _handleInterestAction(
    BuildContext context,
    WidgetRef ref,
    String connectionId,
    String action,
  ) async {
    showLoading(context);
    final success = await ref
        .read(connectionProvider("received").notifier)
        .performAction(connectionId, action);
    hideLoading();
    if (success) {
      ref
          .read(dashboardProvider.notifier)
          .updateMemberInterestStatus(
            connectionId,
            action.toLowerCase() == "accept" ? "accepted" : "rejected",
          );
      showToast(
        'request_action_success'.trParams({
          'action': action.toLowerCase() == 'accept'
              ? 'accepted_lbl'.tr
              : 'declined'.tr,
        }),
      );
      ref.read(dashboardProvider.notifier).refresh();
    } else {
      showToast('action_failed'.tr);
    }
  }
}
