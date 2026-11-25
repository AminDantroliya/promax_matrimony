import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';

import '../../../features/common/data/models/member_models.dart';

class PhotoRequestListItem extends ConsumerStatefulWidget {
  final MemberListModel member;
  final bool isReceived;
  final Function(String action)? onAction;

  const PhotoRequestListItem({
    super.key,
    required this.member,
    this.isReceived = false,
    this.onAction,
  });

  @override
  ConsumerState<PhotoRequestListItem> createState() =>
      _PhotoRequestListItemState();
}

class _PhotoRequestListItemState extends ConsumerState<PhotoRequestListItem> {
  int _calculateAge(String birthDateString) {
    try {
      final birthDate = DateTime.parse(birthDateString);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return 0;
    }
  }

  String _getShortDetails(MemberListModel member) {
    final parts = <String>[];

    // 1. City / Location
    if (member.cityName != null && member.cityName.toString().trim().isNotEmpty) {
      parts.add(member.cityName.toString().trim());
    }

    // 2. Age
    if (member.birthdate != null && member.birthdate.toString().trim().isNotEmpty) {
      final age = _calculateAge(member.birthdate.toString());
      if (age > 0) {
        parts.add("$age yrs");
      }
    } else if (member.subTitle != null) {
      final match = RegExp(
        r'(\d+)\s*(?:Years?|yrs?)',
        caseSensitive: false,
      ).firstMatch(member.subTitle.toString());
      if (match != null) {
        parts.add("${match.group(1)} yrs");
      }
    }

    // 3. Height
    if (member.subTitle != null) {
      final match = RegExp(
        r"(\d+ft\s*\d+in|\d+'\d+\x22|\d+'\d+|\d+\s*cm|\d+-\d+\s*ft)",
        caseSensitive: false,
      ).firstMatch(member.subTitle.toString());
      if (match != null) {
        String heightStr = match.group(1)!;
        if (!heightStr.contains('"') && heightStr.contains("'")) {
          heightStr = '$heightStr"';
        }
        parts.add(heightStr);
      }
    }

    // Fallback if parts is empty or incomplete
    if (parts.isEmpty && member.subTitle != null && member.subTitle.toString().trim().isNotEmpty) {
      return member.subTitle.toString().trim();
    }

    // If cityName was not in member.cityName, try to find city from subTitle
    if (parts.length < 2 && member.subTitle != null) {
      final rawParts = member.subTitle.toString().split(RegExp(r'[,•|]'));
      for (var rawPart in rawParts) {
        final part = rawPart.trim();
        final lower = part.toLowerCase();
        if (part.isEmpty ||
            lower.contains("year") ||
            lower.contains("yrs") ||
            part.contains(RegExp(r"(\d+ft|\d+'|\d+\s*cm)", caseSensitive: false)) ||
            lower.contains("hindu") ||
            lower.contains("muslim") ||
            lower.contains("jain") ||
            lower.contains("sikh") ||
            lower.contains("christian")) {
          continue;
        }
        if (!parts.contains(part)) {
          parts.insert(0, part);
          break;
        }
      }
    }

    return parts.join(' • ');
  }

  List<_TagItem> _getTagItems(MemberListModel member) {
    final tags = <_TagItem>[];

    // 1. Religion
    final religionStr = (member.religion ?? "").toString().trim();
    if (religionStr.isNotEmpty) {
      tags.add(_TagItem(religionStr, svgAsset: AppAssets.figmaReligion));
    }

    // 2. Occupation / Profession
    final occupationStr = (getFieldValue(member, 'occupation') ??
            getFieldValue(member, 'profession') ??
            "")
        .toString()
        .trim();
    if (occupationStr.isNotEmpty) {
      tags.add(_TagItem(occupationStr, svgAsset: AppAssets.figmaEdit));
    }

    // 3. Education
    final eduStr = (member.educationDetails ?? "").toString().trim();
    if (eduStr.isNotEmpty) {
      tags.add(_TagItem(eduStr, svgAsset: AppAssets.figmaEducation));
    }

    // Dynamic extraction from subTitle if model fields were missing
    if (member.subTitle != null && member.subTitle.toString().isNotEmpty) {
      final subParts = member.subTitle.toString().split(RegExp(r'[,•|]'));
      for (var rawPart in subParts) {
        final part = rawPart.trim();
        final lower = part.toLowerCase();
        if (part.isEmpty ||
            lower.contains("year") ||
            lower.contains("yrs") ||
            part.contains(RegExp(r"(\d+ft|\d+'|\d+\s*cm)", caseSensitive: false))) {
          continue;
        }

        // If religion tag isn't added yet
        if (tags.indexWhere((t) => t.svgAsset == AppAssets.figmaReligion) == -1 &&
            (lower.contains("hindu") ||
                lower.contains("islam") ||
                lower.contains("muslim") ||
                lower.contains("sikh") ||
                lower.contains("christian") ||
                lower.contains("jain") ||
                lower.endsWith("ism"))) {
          tags.add(_TagItem(part, svgAsset: AppAssets.figmaReligion));
          continue;
        }

        // If education tag isn't added yet
        if (tags.indexWhere((t) => t.svgAsset == AppAssets.figmaEducation) == -1 &&
            (lower.contains("btech") ||
                lower.contains("b.tech") ||
                lower.contains("mba") ||
                lower.contains("mbbs") ||
                lower.contains("degree") ||
                lower.contains("master") ||
                lower.contains("bachelor") ||
                lower.contains("doctor") ||
                lower.contains("eng"))) {
          tags.add(_TagItem(part, svgAsset: AppAssets.figmaEducation));
          continue;
        }

        // If profession tag isn't added yet
        if (tags.indexWhere((t) => t.svgAsset == AppAssets.figmaEdit) == -1 &&
            (lower.contains("designer") ||
                lower.contains("developer") ||
                lower.contains("manager") ||
                lower.contains("engineer") ||
                lower.contains("consultant") ||
                lower.contains("architect") ||
                lower.contains("officer") ||
                lower.contains("teacher"))) {
          tags.add(_TagItem(part, svgAsset: AppAssets.figmaEdit));
          continue;
        }
      }
    }

    return tags.take(3).toList();
  }

  String _getShortTimeAgo(dynamic dateString) {
    if (dateString == null || dateString.toString().isEmpty) return "3h";
    try {
      final date = DateTime.parse(dateString.toString());
      final diff = DateTime.now().difference(date);
      if (diff.inDays >= 7) {
        return "${(diff.inDays / 7).floor()}w";
      }
      if (diff.inDays > 0) {
        return "${diff.inDays}d";
      }
      if (diff.inHours > 0) {
        return "${diff.inHours}h";
      }
      return "${diff.inMinutes > 0 ? diff.inMinutes : 5}m";
    } catch (_) {
      return "3h";
    }
  }

  int _getMatchPercent(MemberListModel member) {
    final rawRatio = getFieldValue(member, 'matchPercent') ??
        getFieldValue(member, 'match_percent') ??
        getFieldValue(member, 'match_ratio') ??
        getFieldValue(member, 'match_percentage') ??
        member.matchPercent;
    if (rawRatio != null && rawRatio.toString().isNotEmpty) {
      final parsed = int.tryParse(rawRatio.toString().replaceAll('%', '').trim());
      if (parsed != null && parsed > 0) return parsed;
    }
    return 92;
  }

  String _getSpeechBubbleMessage(String id) {
    final val = int.tryParse(id) ?? 0;
    if (val % 2 == 0) {
      return 'photo_req_msg_1'.tr;
    }
    return 'photo_req_msg_2'.tr;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final status = widget.member.receiverResponse?.toString() ?? "Pending";
    final timeStr = _getShortTimeAgo(widget.member.sentDate);
    final matchPercent = _getMatchPercent(widget.member);
    final bubbleMsg = _getSpeechBubbleMessage(
      widget.member.memberId?.toString() ?? widget.member.id?.toString() ?? "0",
    );

    final targetMap = (widget.isReceived
        ? (widget.member.sender is Map ? widget.member.sender as Map : null)
        : (widget.member.receiver is Map ? widget.member.receiver as Map : null));
    final rawTitle = widget.member.profileTitle ??
        targetMap?['profile_title'] ??
        targetMap?['profileTitle'] ??
        widget.member.fullname ??
        targetMap?['fullname'] ??
        widget.member.matriId ??
        targetMap?['matri_id'];
    final displayName = (rawTitle != null && rawTitle.toString().trim().isNotEmpty)
        ? rawTitle.toString().trim()
        : 'user'.tr;

    final subtitleText = (widget.member.subTitle != null &&
            widget.member.subTitle.toString().trim().isNotEmpty)
        ? widget.member.subTitle.toString().trim()
        : _getShortDetails(widget.member);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xFFF7F2F2),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Top Info Row (Avatar + Details)
          InkWell(
            onTap: () {
              final memberId = widget.member.memberId ?? widget.member.id;
              if (memberId != null) {
                context.push('/profile-other/$memberId');
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: getImageWidget(
                        url: widget.member.profileImage ?? "",
                        imageHeight: 96,
                        imageWidth: 80,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    if (status.toLowerCase() != "accepted" &&
                        (!widget.isReceived ||
                            widget.member.isPhotoProtected == 1))
                      const Positioned.fill(
                        child: ProtectedImageOverlay(
                          height: 96,
                          borderRadius: 18,
                          blur: 8,
                          lockSize: 22,
                        ),
                      ),
                  ],
                ),
                const Gap(14),
                // Right Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Profile Title on Left, Time on Right
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              displayName,
                              style: AppFont.font(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1E162E),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(8),
                          if (!widget.isReceived) ...[
                            // Sent Tab Time: Red clock + time
                            if (timeStr.isNotEmpty) ...[
                              const Icon(
                                Icons.access_time_filled,
                                color: Color(0xFFEF4444),
                                size: 13,
                              ),
                              const Gap(4),
                              Text(
                                timeStr,
                                style: AppFont.font(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : const Color(0xFF6E7890),
                                ),
                              ),
                            ],
                          ] else ...[
                            // Received Tab Time: Amber pill (Figma Image 2)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF7E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: Color(0xFFD97706),
                                    size: 11,
                                  ),
                                  const Gap(3),
                                  Text(
                                    timeStr,
                                    style: AppFont.font(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFD97706),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const Gap(6),
                      // Row 2: Location, Age, Height (Using dynamic primaryColor)
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.figmaLocation,
                            colorFilter: ColorFilter.mode(
                              primaryColor,
                              BlendMode.srcIn,
                            ),
                            width: 13,
                            height: 13,
                          ),
                          const Gap(6),
                          Expanded(
                            child: Text(
                              subtitleText,
                              style: AppFont.font(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : const Color(0xFF6E7890),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      // Row 3: Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ..._getTagItems(widget.member).map(
                            (tag) => _buildChipTag(tag, isDark, primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Speech Bubble (Only on Received requests, matching Figma Image 2)
          if (widget.isReceived) ...[
            const Gap(12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFF8F9FC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.chat_bubble_rounded,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      bubbleMsg,
                      style: AppFont.font(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? Colors.grey.shade300
                            : const Color(0xFF4A4E69),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const Gap(14),

          // Bottom Action Row
          if (!widget.isReceived) ...[
            // Sent Tab Action Row (Figma Image 1)
            Row(
              children: [
                // Match % Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.figmaSendInterest,
                        colorFilter: ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                        width: 14,
                        height: 14,
                      ),
                      const Gap(6),
                      Text(
                        "$matchPercent%",
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Status Pill (PENDING, ACCEPTED, DECLINED)
                _buildSentStatusTag(status, isDark),
                const Gap(12),
                // Delete / Trash Button
                InkWell(
                  onTap: () => widget.onAction?.call("delete"),
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                          : const Color(0xFFEF4444).withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.icDelete,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFEF4444),
                          BlendMode.srcIn,
                        ),
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            // Received Tab Action Row (Figma Image 2)
            Row(
              children: [
                // Match % Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.figmaSendInterest,
                        colorFilter: ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                        width: 14,
                        height: 14,
                      ),
                      const Gap(6),
                      Text(
                        "$matchPercent%",
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (status.toLowerCase() == "pending") ...[
                  // Reject Button (Circle with X)
                  InkWell(
                    onTap: () => widget.onAction?.call("Rejected"),
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                            : const Color(0xFFEF4444).withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: Color(0xFFEF4444),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  // Accept Button (Pill with Double Check)
                  InkWell(
                    onTap: () => widget.onAction?.call("Accepted"),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: FigmaColors.primaryGradient(context),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.28),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppAssets.figmaVerified,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 15,
                            height: 15,
                          ),
                          const Gap(6),
                          Text(
                            'Accept',
                            style: AppFont.font(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  _buildSentStatusTag(status, isDark),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChipTag(_TagItem tag, bool isDark, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tag.svgAsset != null)
            SvgPicture.asset(
              tag.svgAsset!,
              colorFilter: ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
              width: 12,
              height: 12,
            ),
          const Gap(5),
          Flexible(
            child: Text(
              tag.label,
              style: AppFont.font(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentStatusTag(String status, bool isDark) {
    final lower = status.toLowerCase();

    Color bgColor;
    Color textColor;
    Widget iconWidget;
    String text;

    if (lower == "accepted" || lower == "accept") {
      bgColor = isDark
          ? const Color(0xFF10B981).withValues(alpha: 0.15)
          : const Color(0xFFE8F8F0);
      textColor = const Color(0xFF10B981);
      iconWidget = const Icon(
        Icons.check_circle_rounded,
        size: 13,
        color: Color(0xFF10B981),
      );
      text = "ACCEPTED";
    } else if (lower == "rejected" || lower == "reject" || lower == "declined") {
      bgColor = isDark
          ? const Color(0xFFEF4444).withValues(alpha: 0.15)
          : const Color(0xFFFEE2E2);
      textColor = const Color(0xFFDC2626);
      iconWidget = const Icon(
        Icons.close_rounded,
        size: 13,
        color: Color(0xFFDC2626),
      );
      text = "DECLINED";
    } else {
      bgColor = isDark
          ? const Color(0xFFF59E0B).withValues(alpha: 0.15)
          : const Color(0xFFFFF7E6);
      textColor = const Color(0xFFD97706);
      iconWidget = const Icon(
        Icons.access_time_filled,
        size: 13,
        color: Color(0xFFD97706),
      );
      text = "PENDING";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          const Gap(5),
          Text(
            text,
            style: AppFont.font(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagItem {
  final String label;
  final String? svgAsset;

  const _TagItem(this.label, {this.svgAsset});
}
