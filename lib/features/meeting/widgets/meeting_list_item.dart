import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:pro_matrimony/widgets/app_text_field.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';

import '../data/models/meeting_models.dart';

class MeetingListItem extends ConsumerWidget {
  final Meeting meeting;
  final Function(String status, String? remark)? onAction;

  const MeetingListItem({
    super.key,
    required this.meeting,
    this.onAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).scaffoldBackgroundColor == appBackgroundColorDark;
    
    final myProfile = ref.watch(myProfileProvider).value;
    final isPersonalized = myProfile?.userType?.toString() == "1";
    final isMember1 = myProfile?.id?.toString() == meeting.member1Id?.toString();
    
    final userStatus = isPersonalized
        ? (isMember1 ? meeting.member1Status.toString() : meeting.member2Status.toString())
        : meeting.member1Status.toString();
        
    final meetingStatus = meeting.meetingStatus.toString();
    
    String statusStr = "pending_lbl".tr;
    Color statusColor = appPendingColor;
    
    switch (userStatus) {
      case "1":
        statusStr = "accepted_lbl".tr;
        statusColor = appAcceptedColor;
        break;
      case "2":
        statusStr = "rejected_lbl".tr;
        statusColor = appRejectColor;
        break;
    }

    final isShowAcceptAction = userStatus == "0" && meetingStatus == "0";
    final isShowRejectAction = userStatus == "0";
    // Show Complete when BOTH members have accepted (status == 1)
    final bothAccepted =
        meeting.member1Status?.toString() == "1" &&
        meeting.member2Status?.toString() == "1";
    final isShowCompleteAction = bothAccepted && meetingStatus != "1";

    String otherName = "n_a".tr;
    String otherId = meeting.member1Id?.toString() ?? "";
    
    if (isPersonalized) {
      final other = isMember1 ? meeting.member2 : meeting.member1;
      if (other is Map) {
        otherName = (other['fullname'] ?? other['matri_id'] ?? other['profile_title'] ?? "n_a".tr).toString();
        otherId = (other['id'] ?? (isMember1 ? meeting.member2Id : meeting.member1Id))?.toString() ?? "";
      }
    } else {
      otherName = meeting.profileTitle ?? "n_a".tr;
      otherId = meeting.member1Id?.toString() ?? "";
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEFEFEF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context, otherId),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, otherName, otherId, statusStr, statusColor, isDark),
                const Gap(8),
                if (meeting.subTitle != null && meeting.subTitle.toString().isNotEmpty) ...[
                  Text(
                    meeting.subTitle.toString(),
                    style: AppFont.font(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(8),
                ],
                _buildMeetingDetails(context, isDark),
                const Gap(12),
                _buildActions(context, isShowAcceptAction, isShowRejectAction, isShowCompleteAction, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, String otherId) {
    return Stack(
      children: [
        InkWell(
          onTap: () => context.push('/profile-other/$otherId'),
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: getImageWidget(url: meeting.profileImage, boxFit: BoxFit.cover),
            ),
          ),
        ),
        if (checkIsPhotoProtected(meeting))
          Positioned.fill(child: protectedMidWidget()),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String otherName,
    String otherId,
    String statusStr,
    Color statusColor,
    bool isDark,
  ) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.push('/profile-other/$otherId'),
            child: Text(
              otherName,
              style: AppFont.font(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            statusStr,
            style: AppFont.font(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeetingDetails(BuildContext context, bool isDark) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: SvgPicture.asset(
                AppAssets.figmaLocation,
                width: 14,
                height: 14,
                colorFilter: ColorFilter.mode(
                  isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Gap(6),
            Expanded(
              child: Text(
                meeting.address ?? "n_a".tr,
                style: AppFont.font(
                  fontSize: 12,
                  color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B),
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Gap(6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.figmaCalendar,
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(
                isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B),
                BlendMode.srcIn,
              ),
            ),
            const Gap(6),
            Expanded(
              child: Text(
                getFormattedDate(meeting.dateTime ?? "n_a".tr),
                style: AppFont.font(
                  fontSize: 12,
                  color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF7C809B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions(
    BuildContext context,
    bool accept,
    bool reject,
    bool complete,
    bool isDark,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (reject) ...[
          _actionButton(
            text: "reject".tr,
            textColor: const Color(0xFFEF4444),
            bgColor: isDark ? const Color(0xFF2A1C24) : const Color(0xFFFEE2E2),
            onTap: () => _showRejectPopup(context),
          ),
          const Gap(10),
        ],
        if (accept)
          _actionButton(
            text: "accept".tr,
            textColor: Colors.white,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).primaryColor,
              ],
            ),
            onTap: () => onAction?.call("1", null),
          ),
        if (complete)
          _actionButton(
            text: "complete".tr,
            textColor: Colors.white,
            bgColor: appAcceptedColor,
            onTap: () => _showCompletePopup(context),
          ),
      ],
    );
  }

  Widget _actionButton({
    required String text,
    required Color textColor,
    Color? bgColor,
    Gradient? gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: AppFont.font(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showRejectPopup(BuildContext context) {
    _showRemarkPopup(context, "reject_meeting".tr, "2");
  }

  void _showCompletePopup(BuildContext context) {
    _showRemarkPopup(context, "complete_meeting".tr, "1");
  }

  void _showRemarkPopup(BuildContext context, String title, String status) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF161722) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Gap(24),
                  Text(
                    title,
                    style: AppFont.font(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(20),
                  AppTextField(
                    labelText: "remark".tr,
                    hint: "",
                    maxLine: 3,
                    controller: controller,
                    validator: (v) => isNullFromBlankString(v) ? "remark_required".tr : null,
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      Expanded(
                        child: AppSecondaryButton(
                          label: "btn_cancel".tr,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: AppPrimaryButton(
                          label: status == "2" ? "reject".tr : "complete".tr,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              onAction?.call(status, controller.text.trim());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
