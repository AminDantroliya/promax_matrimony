import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/membership_upgrade_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit/zego_uikit.dart';

import '../../../preference/session_keys.dart';
import '../../../services/app_session_service.dart';
import '../../../utils/application_data.dart';
import '../../../utils/api_urls.dart';

class CallHistoryListItem extends ConsumerWidget {
  final MemberListModel member;
  final int index;
  final bool isVideo;

  const CallHistoryListItem({
    super.key,
    required this.member,
    required this.index,
    required this.isVideo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final userId =
        AppSessionService.getValue(SessionDetail.kUserId)?.toString() ?? "";
    final userMatriId =
        AppSessionService.getValue(SessionDetail.kMatriId)?.toString() ?? "";

    // Determine direction based on sender / receiver data
    final bool isOutgoing =
        (userId.isNotEmpty && userId == member.senderMemberId?.toString()) ||
        (userMatriId.isNotEmpty &&
            userMatriId == member.senderMatriId?.toString());

    bool isZeroCallMinute(dynamic activeCallMinute) {
      if (activeCallMinute == null) return true;
      if (activeCallMinute is num) return activeCallMinute == 0;
      final str = activeCallMinute.toString().trim();
      if (str.isEmpty || str == "0" || str == "0.0") return true;
      final val = num.tryParse(str);
      return val == null || val == 0;
    }

    final bool isMissed = isZeroCallMinute(member.activeCallMinute);

    // Call status color and label
    Color subtitleColor;
    String subtitleSvg;
    String statusText;

    if (isMissed) {
      subtitleColor = const Color(0xFFE53935); // Missed Call Red
      subtitleSvg = AppAssets.figmaMissedCall;
      statusText = 'missed_call'.tr;
    } else if (isVideo) {
      subtitleColor = primaryColor;
      subtitleSvg = AppAssets.figmaVideoCallOutline;
      statusText = 'video'.tr;
    } else {
      subtitleColor = primaryColor;
      subtitleSvg = AppAssets.figmaVoiceCallOutline;
      statusText = 'voice'.tr;
    }

    // Determine target member object dynamically from sender / receiver details
    final targetJson = isOutgoing ? member.receiver : member.sender;

    String? getValidString(dynamic val) {
      if (val == null) return null;
      final s = val.toString().trim();
      if (s.isEmpty || s == "null") return null;
      return s;
    }

    final Map? targetMap = targetJson is Map ? targetJson : null;

    final String otherMemberId = () {
      if (targetMap != null) {
        final id = targetMap['id'] ?? targetMap['member_id'];
        if (id != null && id.toString().isNotEmpty && id.toString() != "null") {
          return id.toString();
        }
      }
      final fallbackId = isOutgoing
          ? (member.receiverMemberId ?? member.memberId)
          : (member.senderMemberId ?? member.memberId);
      return fallbackId?.toString() ?? member.memberId?.toString() ?? "";
    }();

    final String otherMatriId = getValidString(targetMap?['matri_id']) ??
        getValidString(targetMap?['profile_title']) ??
        getValidString(member.matriId) ??
        getValidString(member.receiverMatriId) ??
        getValidString(member.senderMatriId) ??
        'not_available'.tr;

    // Prioritize profile_title (e.g. "PROMATRI96")
    final String otherTitle = getValidString(targetMap?['profile_title']) ??
        getValidString(member.profileTitle) ??
        getValidString(targetMap?['matri_id']) ??
        getValidString(member.matriId) ??
        getValidString(targetMap?['fullname']) ??
        getValidString(member.fullname) ??
        otherMatriId;

    // Resolve Image URL:
    // 1. Check member.profileImage (full URL provided by backend)
    // 2. Check targetMap['profile_image']
    // 3. Fallback to targetMap['photo1'] or member.photo1
    String otherImage = "";
    final rawProfileImage = getValidString(member.profileImage) ??
        getValidString(targetMap?['profile_image']);

    if (rawProfileImage != null &&
        (rawProfileImage.startsWith("http://") ||
            rawProfileImage.startsWith("https://"))) {
      otherImage = rawProfileImage;
    } else {
      final photoName = getValidString(targetMap?['photo1']) ??
          getValidString(member.photo1) ??
          getValidString(rawProfileImage);

      if (photoName != null && photoName.isNotEmpty) {
        if (photoName.startsWith("http://") ||
            photoName.startsWith("https://")) {
          otherImage = photoName;
        } else {
          final apiOrigin =
              baseUrl.replaceAll("api/", "").replaceAll("/api", "");
          final cleanOrigin =
              apiOrigin.endsWith("/") ? apiOrigin : "$apiOrigin/";
          otherImage =
              "${cleanOrigin}public/storage/assets/memberPhotos/$photoName";
        }
      }
    }

    final photoStatus = (targetMap?['photo1_status'] ?? member.photo1Status)
        ?.toString()
        .toUpperCase();
    final bool otherPhotoApproved = photoStatus == null ||
        photoStatus.isEmpty ||
        photoStatus != "UNAPPROVED";

    final minuteVal =
        int.tryParse(member.activeCallMinute?.toString() ?? "0") ?? 0;
    final durationStr = (!isMissed && minuteVal > 0)
        ? " · $minuteVal ${minuteVal == 1 ? 'min_short'.tr : 'mins_short'.tr}"
        : "";

    final displayDate = _formatShortCallDate(member.sentDate?.toString());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: isMissed
            ? (isDark ? const Color(0xFF1D1420) : const Color(0xFFFFFBFB))
            : (isDark ? const Color(0xFF161722) : Colors.white),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isMissed
              ? (isDark ? const Color(0xFF3B1E2B) : const Color(0xFFFFECEF))
              : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFF3F3F7)),
          width: isMissed ? 1.2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Left Avatar (Squircle 52x52) with overlapping SVG badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.12)
                          : const Color(0xFFEEF0F6),
                      width: 1,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _handleTap(context, otherMemberId),
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: getImageWidget(
                            url: otherPhotoApproved ? otherImage : "",
                            boxFit: BoxFit.cover,
                            imageWidth: 52,
                            imageHeight: 52,
                          ),
                        ),
                        if (checkIsPhotoProtected(member) &&
                            otherPhotoApproved &&
                            otherImage.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: protectedCallHistoryWidget(),
                          ),
                      ],
                    ),
                  ),
                ),
                // Circular status SVG badge
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: isMissed
                          ? const Color(0xFFE53935)
                          : const Color(0xFF22C55E),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF161722) : Colors.white,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: SvgPicture.asset(
                        isMissed
                            ? AppAssets.figmaMissedCall
                            : AppAssets.figmaIncomingCall,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(14),

            // Center Details (Title and Call metadata)
            Expanded(
              child: InkWell(
                onTap: () => _handleTap(context, otherMemberId),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      otherTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isMissed
                            ? (isDark ? const Color(0xFFFF6B81) : primaryColor)
                            : (isDark ? Colors.white : const Color(0xFF1E202C)),
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          subtitleSvg,
                          colorFilter: ColorFilter.mode(
                            subtitleColor,
                            BlendMode.srcIn,
                          ),
                          width: 14,
                          height: 14,
                        ),
                        const Gap(5),
                        Expanded(
                          child: Text(
                            "$statusText$durationStr · $displayDate",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFont.font(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                              color: const Color(0xFF8E90A6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),

            // Right Action Button (Blue for Video, Pink for Voice)
            _buildCallButton(context, ref, otherMatriId, isDark, primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton(
    BuildContext context,
    WidgetRef ref,
    String receiverMatriId,
    bool isDark,
    Color primaryColor,
  ) {
    final hasActiveSession = ApplicationData.isMemberPaid == true;

    // In Figma design:
    // Video button: Soft blue container + Blue Videocam SVG
    // Voice button: Soft pink container + Pink Phone SVG
    final Color buttonBgColor = isVideo
        ? (isDark ? const Color(0xFF17243B) : const Color(0xFFEBF3FD))
        : (isDark ? const Color(0xFF2B1925) : const Color(0xFFFFEEF2));

    final Color buttonIconColor = isVideo
        ? const Color(0xFF2F80ED)
        : primaryColor;

    return InkWell(
      onTap: () {
        if (!hasActiveSession) {
          _showMembershipPopup(context);
        }
      },
      child: AbsorbPointer(
        absorbing: !hasActiveSession,
        child: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: buttonBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: ZegoSendCallInvitationButton(
              isVideoCall: isVideo,
              resourceID: "zegouikit_call",
              onWillPressed: () async {
                return await initiateAppCall(
                  context,
                  ref,
                  targetModel: member,
                  isVideo: isVideo,
                  sendCallInvitation: false,
                );
              },
              icon: ButtonIcon(
                icon: SvgPicture.asset(
                  isVideo ? AppAssets.figmaVideoCall : AppAssets.figmaVoiceCall,
                  colorFilter: ColorFilter.mode(
                    buttonIconColor,
                    BlendMode.srcIn,
                  ),
                  width: isVideo ? 20 : 17,
                  height: isVideo ? 20 : 17,
                ),
              ),
              iconSize: const Size(20, 20),
              buttonSize: const Size(44, 44),
              invitees: [
                ZegoUIKitUser(id: receiverMatriId, name: receiverMatriId),
              ],
              onPressed: (code, message, p2) {
                ApplicationData.otherMatriId = receiverMatriId;
                ApplicationData.callType = isVideo ? "videoCall" : "voiceCall";
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showMembershipPopup(BuildContext context) {
    MembershipUpgradeBottomSheet.show(
      context,
      'upgrade_your_membership_message'.tr,
    );
  }

  void _handleTap(BuildContext context, [String? otherMemberId]) {
    final targetId = (otherMemberId != null &&
            otherMemberId.isNotEmpty &&
            otherMemberId != "null")
        ? otherMemberId
        : member.memberId?.toString();

    if (checkIsPhotoProtected(member) &&
        member.photo1Status == "APPROVED" &&
        member.profileImage != null &&
        member.profileImage != "") {
      PhotoRequestBottomSheet.show(
        context,
        targetId ?? member.memberId.toString(),
      );
    } else if (targetId != null && targetId.isNotEmpty) {
      context.push('/profile-other/$targetId');
    }
  }

  String _formatShortCallDate(String? serverDate) {
    if (serverDate == null ||
        serverDate.isEmpty ||
        serverDate == "0000-00-00 00:00:00" ||
        serverDate == "null") {
      return "N/A";
    }

    try {
      final parsed = DateTime.tryParse(serverDate) ??
          DateFormat("yyyy-MM-dd HH:mm:ss").parse(serverDate);
      final now = DateTime.now();

      final isToday = parsed.year == now.year &&
          parsed.month == now.month &&
          parsed.day == now.day;

      final timeStr = DateFormat('hh:mm a').format(parsed);

      if (isToday) {
        return timeStr;
      }

      if (parsed.year == now.year) {
        return "${DateFormat('dd MMM').format(parsed)}, $timeStr";
      } else {
        return "${DateFormat('dd/MM/yy').format(parsed)}, $timeStr";
      }
    } catch (_) {
      return "N/A";
    }
  }
}
