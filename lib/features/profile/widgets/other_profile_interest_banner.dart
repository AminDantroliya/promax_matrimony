import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/features/profile/providers/other_profile_notifier.dart';
import 'package:pro_matrimony/features/profile/widgets/other_profile_common_widgets.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/membership_upgrade_bottom_sheet.dart';

class OtherProfileInterestBanner extends ConsumerWidget {
  final String memberId;
  final ProfileData data;
  final EdgeInsetsGeometry? margin;

  const OtherProfileInterestBanner({
    super.key,
    required this.memberId,
    required this.data,
    this.margin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Reactively observe updated profile data from notifier
    final currentData =
        ref.watch(otherProfileProvider(memberId)).value?.data ?? data;

    final rawStatus = currentData.interestStatus?.toString().trim() ?? '';
    final statusLower = rawStatus.toLowerCase();
    final rawState = currentData.interestState?.toString().trim() ?? '';
    final stateLower = rawState.toLowerCase();

    final isAccepted =
        statusLower == 'accepted' ||
        statusLower == 'approved' ||
        statusLower == '1' ||
        checkIsInterestAccepted(currentData);
    final isRejected =
        statusLower == 'rejected' ||
        statusLower == 'declined' ||
        checkIsInterestRejected(currentData);
    final isPending = statusLower == 'pending';
    final isReceived = stateLower == 'received';
    final isSent =
        stateLower == 'sent' || (checkIsInterest(currentData) && !isReceived);

    if (!isAccepted && !isRejected && !isPending && !isReceived && !isSent) {
      return const SizedBox.shrink();
    }

    final effectiveMargin =
        margin ?? const EdgeInsets.fromLTRB(20, 8, 20, 16);

    final displayTitle = OtherProfileHelper.getDisplayTitle(currentData);
    final memberName =
        displayTitle.isNotEmpty ? displayTitle : 'this_member'.tr;

    // 1. RECEIVED Interest Request (Pending)
    if (isReceived &&
        (isPending || statusLower.isEmpty || statusLower == 'none')) {

      return Container(
        margin: effectiveMargin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF7342EB).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7342EB).withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7342EB).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFF7342EB),
                    size: 20,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'received_interest_request'.tr,
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        '$memberName ${"received_interest_desc".tr}',
                        style: AppFont.font(
                          fontSize: 12,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(14),
            Row(
              children: [
                // Reject Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final response = await withLoading(
                        context,
                        () => ref
                            .read(otherProfileProvider(memberId).notifier)
                            .rejectInterest(),
                      );
                      if (!context.mounted) return;
                      if (response['status'] == 'success') {
                        showToast('interest_rejected'.tr);
                      } else {
                        showToast(response['message'] ?? 'action_failed'.tr);
                      }
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: Color(0xFFEF4444),
                    ),
                    label: Text(
                      'reject_lbl'.tr,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      side: BorderSide(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color(
                        0xFFEF4444,
                      ).withValues(alpha: 0.05),
                    ),
                  ),
                ),
                const Gap(12),
                // Accept Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final response = await withLoading(
                        context,
                        () => ref
                            .read(otherProfileProvider(memberId).notifier)
                            .acceptInterest(),
                      );
                      if (!context.mounted) return;
                      if (response['status'] == 'success') {
                        showToast('interest_accepted'.tr);
                      } else {
                        showToast(response['message'] ?? 'action_failed'.tr);
                      }
                    },
                    icon: const Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      'accept_lbl'.tr,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: const Color(0xFF10B981),
                      elevation: 2,
                      shadowColor: const Color(
                        0xFF10B981,
                      ).withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.getButtonBorderRadius(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // 2. SENT Interest Request (Pending)
    if (isSent && isPending) {
      final canSendRaw = currentData.canSendReminder;
      final bool canSendReminder =
          canSendRaw == true ||
          canSendRaw?.toString() == '1' ||
          canSendRaw?.toString().toLowerCase() == 'true';
      final int pendingCount = currentData.pendingReminderCount ?? 0;

      final bool showReminder = canSendReminder && pendingCount > 0;

      return Container(
        margin: effectiveMargin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF2C8EDC).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2C8EDC).withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C8EDC).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Color(0xFF2C8EDC),
                    size: 18,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'interest_request_sent'.tr,
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        '${"sent_interest_desc".tr} $memberName. ${"awaiting_response".tr}',
                        style: AppFont.font(
                          fontSize: 12,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showReminder) ...[
                  // Delete Icon Only Button
                  InkWell(
                    onTap: () => _confirmDeleteInterest(context, ref),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              const Color(0xFFEF4444).withValues(alpha: 0.2),
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFEF4444),
                        size: 18,
                      ),
                    ),
                  ),
                  const Gap(10),
                  // Send Reminder (count) Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final response = await withLoading(
                          context,
                          () => ref
                              .read(otherProfileProvider(memberId).notifier)
                              .sendReminder(),
                        );
                        if (!context.mounted) return;
                        if (response['status'] == 'success') {
                          showToast('reminder_sent_success'.tr);
                        } else {
                          final msg =
                              (response['message'] ?? '').toString();
                          final lowerMsg = msg.toLowerCase();
                          if (lowerMsg.contains('paid member') ||
                              lowerMsg.contains('upgrade') ||
                              lowerMsg.contains('membership') ||
                              lowerMsg.contains('plan')) {
                            MembershipUpgradeBottomSheet.show(context, msg);
                          } else {
                            showToast(
                              msg.isNotEmpty ? msg : 'action_failed'.tr,
                            );
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: Text(
                        "${'btn_send_reminder'.tr} ($pendingCount)",
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: const Color(0xFF2C8EDC),
                        elevation: 2,
                        shadowColor: const Color(
                          0xFF2C8EDC,
                        ).withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppTheme.getButtonBorderRadius(context),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  // Delete Interest Button (full width style)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmDeleteInterest(context, ref),
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFEF4444),
                        size: 18,
                      ),
                      label: Text(
                        'btn_delete_interest'.tr,
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFEF4444),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        side: BorderSide(
                          color:
                              const Color(0xFFEF4444).withValues(alpha: 0.3),
                        ),
                        backgroundColor: const Color(
                          0xFFEF4444,
                        ).withValues(alpha: 0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppTheme.getButtonBorderRadius(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      );
    }

    // 3. ACCEPTED Interest
    if (isAccepted) {
      final acceptedDesc = isReceived
          ? 'you_accepted_interest_msg'.tr.replaceAll('{name}', memberName)
          : 'member_accepted_interest_msg'.tr.replaceAll('{name}', memberName);

      return Container(
        margin: effectiveMargin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF064E3B).withValues(alpha: 0.4)
              : const Color(0xFFECFDF5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'interest_accepted_title'.tr,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF065F46),
                    ),
                  ),
                  const Gap(2),
                  Text(
                    acceptedDesc,
                    style: AppFont.font(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFFA7F3D0)
                          : const Color(0xFF047857),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // 4. REJECTED Interest
    if (isRejected) {
      final rejectedDesc = isReceived
          ? 'you_rejected_interest_msg'.tr.replaceAll('{name}', memberName)
          : 'member_rejected_interest_msg'.tr.replaceAll('{name}', memberName);

      return Container(
        margin: effectiveMargin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF450A0A).withValues(alpha: 0.4)
              : const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'interest_rejected'.tr,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF991B1B),
                    ),
                  ),
                  const Gap(2),
                  Text(
                    rejectedDesc,
                    style: AppFont.font(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFFFCA5A5)
                          : const Color(0xFFB91C1C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Future<void> _confirmDeleteInterest(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('btn_delete_interest'.tr),
        content: Text('delete_interest_confirm_msg'.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('btn_cancel'.tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'delete'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final response = await withLoading(
        context,
        () => ref
            .read(otherProfileProvider(memberId).notifier)
            .deleteInterest(),
      );
      if (!context.mounted) return;
      if (response['status'] == 'success') {
        showToast('interest_removed_msg'.tr);
      } else {
        showToast(response['message'] ?? 'action_failed'.tr);
      }
    }
  }
}
