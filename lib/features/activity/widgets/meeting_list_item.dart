import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/activity/providers/meeting_notifier.dart';
import 'package:pro_matrimony/features/settings/data/repositories/settings_repository.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_text_field.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';

import '../../profile/screens/other_member_profile_screen.dart';

class MeetingListItem extends ConsumerWidget {
  final dynamic meeting;
  final int index;

  const MeetingListItem({
    super.key,
    required this.meeting,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final statusData = _getStatusData(meeting.member1Status?.toString() ?? "0");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [if (!isDark) BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(context),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: customTextBoldStyle(meeting.profileTitle ?? "Member", 15, TextAlign.start, Theme.of(context).colorScheme.onSurface)),
                        _buildStatusBadge(statusData),
                      ],
                    ),
                    const Gap(4),
                    customTextNormalStyle(meeting.subTitle ?? "", 13, TextAlign.start, Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                    const Gap(12),
                    _buildInfoGrid(context),
                  ],
                ),
              ),
            ],
          ),
          const Gap(15),
          _buildActions(context, ref),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => OtherMemberProfileScreen(memberId: meeting.member1Id.toString()),
          )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: getImageWidget(
              url: meeting.profileImage ?? "",
              imageWidth: 85,
              imageHeight: 110,
              boxFit: BoxFit.cover,
            ),
          ),
        ),
        if (meeting.isPhotoProtected == 1)
          Positioned.fill(child: protectedMidWidget()),
      ],
    );
  }

  Widget _buildStatusBadge(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (data['color'] as Color).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: customTextSemiBoldStyle(data['text'], 10, TextAlign.center, data['color']),
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return Column(
      children: [
        _infoRow(context, 'address'.tr, meeting.address ?? "N/A"),
        const Gap(6),
        _infoRow(context, 'meeting_time'.tr, getFormattedDate(meeting.dateTime ?? "N/A")),
      ],
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTextSemiBoldStyle("$label: ", 12, TextAlign.start, Theme.of(context).colorScheme.onSurface),
        Expanded(child: customTextNormalStyle(value, 12, TextAlign.start, Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
      ],
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    final m1Status = meeting.member1Status?.toString() ?? "0";
    final meetStatus = meeting.meetingStatus?.toString() ?? "0";

    bool showAccept = m1Status == "0" && meetStatus == "0";
    bool showReject = m1Status == "0";
    bool showComplete = m1Status == "1" && meetStatus == "0";

    if (!showAccept && !showReject && !showComplete) return const SizedBox();

    return Row(
      children: [
        if (showAccept) ...[
          Expanded(child: _actionBtn("Accept", Colors.green, () => _handleAction(ref, context, "1"))),
          const Gap(10),
        ],
        if (showReject) ...[
          Expanded(child: _actionBtn("Reject", Colors.red, () => _showRemarkPopup(context, ref, "2"))),
          const Gap(10),
        ],
        if (showComplete)
          Expanded(child: _actionBtn("Complete", appPrimaryColor, () => _showRemarkPopup(context, ref, "3"))),
      ],
    );
  }

  Widget _actionBtn(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: customTextSemiBoldStyle(label, 13, TextAlign.center, Colors.white),
      ),
    );
  }

  Map<String, dynamic> _getStatusData(String status) {
    switch (status) {
      case "1": return {'text': 'Accepted', 'color': appAcceptedColor};
      case "2": return {'text': 'Rejected', 'color': appRejectColor};
      default: return {'text': 'Pending', 'color': appPendingColor};
    }
  }

  void _handleAction(WidgetRef ref, BuildContext context, String response, {String? remark}) async {
    showLoading(context);
    try {
      final params = <String, dynamic>{
        "id": meeting.id.toString(),
        "match_id": meeting.id.toString(),
        "response": response,
        "update_status": response,
        "memberLabel": response == "3" ? "meeting_status" : "member1_status",
      };
      if (remark != null) {
        params["rejectBy"] = response == "3" ? "meeting_remark" : "member1_reject_remark";
        params[response == "3" ? "meeting_remark" : "member1_reject_remark"] = remark;
      }

      final result = await ref.read(settingsRepositoryProvider).performAction(meetingActionApi, params);
      hideLoading();

      if (result['status'] == "success") {
        ref.read(meetingProvider.notifier).fetchMeetings();
      } else {
        showToast(result['message'] ?? "action_failed".tr);
      }
    } catch (e) {
      hideLoading();
      showToast("something_went_wrong".tr);
    }
  }

  void _showRemarkPopup(BuildContext context, WidgetRef ref, String response) {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
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
                  // Drag handle
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
                  customTextBoldStyle(
                    response == "3" ? "Complete Meeting" : "Reject Meeting",
                    20,
                    TextAlign.start,
                    theme.colorScheme.onSurface,
                  ),
                  const Gap(20),
                  AppTextField(
                    labelText: "Remark",
                    controller: controller,
                    maxLine: 3,
                    validator: (v) => (v == null || v.isEmpty) ? "Remark is required" : null,
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : const Color(0xFFE2E8F0),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppTheme.getButtonBorderRadius(context),
                              ),
                              foregroundColor: theme.colorScheme.onSurface,
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppTheme.getButtonBorderRadius(context),
                              gradient: LinearGradient(
                                colors: response == "3"
                                    ? [Colors.green.shade400, Colors.green.shade700]
                                    : [Colors.red.shade400, Colors.red.shade700],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  _handleAction(ref, context, response, remark: controller.text.trim());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppTheme.getButtonBorderRadius(context),
                                ),
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                response == "3" ? "Complete" : "Reject",
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
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
