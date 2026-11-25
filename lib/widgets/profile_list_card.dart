import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/widgets/profile_cards/profile_card_action_buttons.dart';

class ProfileListCard extends ConsumerWidget {
  final MemberListModel member;
  final VoidCallback? onTap;
  final VoidCallback? onShortlist;
  final VoidCallback? onAudioCall;
  final VoidCallback? onVideoCall;
  final VoidCallback? onChat;
  final VoidCallback? onInterest;
  final VoidCallback? onBlock;
  final VoidCallback? onReport;

  const ProfileListCard({
    super.key,
    required this.member,
    this.onTap,
    this.onShortlist,
    this.onAudioCall,
    this.onVideoCall,
    this.onChat,
    this.onInterest,
    this.onBlock,
    this.onReport,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = member.profileImage ?? member.photo1 ?? "";

    // Dynamic Tag extraction from subTitle
    final subTitleStr = member.subTitle?.toString() ?? '';
    final parts = subTitleStr
        .split(RegExp(r'[,·]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    String educationTag = "";
    String religionTag = "";

    for (var part in parts) {
      final lower = part.toLowerCase();
      if (lower.contains('hindu') ||
          lower.contains('muslim') ||
          lower.contains('sikh') ||
          lower.contains('christian') ||
          lower.contains('jain')) {
        religionTag = part;
      } else if (part.length <= 8 &&
          !lower.contains('year') &&
          !lower.contains('age')) {
        educationTag = part;
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height:
          520, // Tall, premium portrait card height to match Figma aspect ratio
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32), // High-fidelity squircle
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Card photo
            InkWell(
              onTap: checkIsPhotoProtected(member)
                  ? () => PhotoRequestBottomSheet.show(
                      context,
                      member.memberId.toString(),
                    )
                  : onTap,
              child: getImageWidget(
                url: photo,
                boxFit: BoxFit.cover,
                imageWidth: double.infinity,
                imageHeight: double.infinity,
                targetGender: member.gender,
                isProtected: checkIsPhotoProtected(member),
              ),
            ),
            if (checkIsPhotoProtected(member))
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => PhotoRequestBottomSheet.show(
                    context,
                    member.memberId.toString(),
                  ),
                  child: const ProtectedImageOverlay(
                    blur: 16,
                    lockSize: 50,
                    lockAlignment: Alignment(0, -0.10),
                    borderRadius: 32,
                  ),
                ),
              ),

            // Top gradient & Bottom gradient overlay for premium depth
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Top-Left: Premium Crown Badge if plan_status is "Paid" and showPremiumBadge is enabled
            if (checkIsPaid(member) && ref.watch(featureProvider('showPremiumBadge')))
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: FigmaColors.primaryGradient(context),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.figmaPremium,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),

            // Top-Right: Translucent More Options Circle Button
            Positioned(
              top: 16,
              right: 16,
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(cardColor: Theme.of(context).colorScheme.surface),
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.0,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  onSelected: (value) {
                    if (value == 'block') {
                      onBlock?.call();
                    } else if (value == 'report') {
                      onReport?.call();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'block',
                      child: customTextNormalStyle(
                        checkIsBlocked(member)
                            ? "unblock_lbl".tr
                            : "block_lbl".tr,
                        15,
                        TextAlign.start,
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    PopupMenuItem(
                      value: 'report',
                      child: customTextNormalStyle(
                        "report_lbl".tr,
                        15,
                        TextAlign.start,
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Profile Content Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        member.profileTitle ??
                            member.fullname ??
                            member.matriId ??
                            '',
                        style: AppFont.font(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(3),

                    // Subtitle
                    Text(
                      member.subTitle ?? '',
                      style: AppFont.font(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(16),

                    // Translucent Chips Row
                    Row(
                      children: [
                        // Education / Location Chip
                        if (educationTag.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.figmaLocation,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 14,
                                  height: 14,
                                ),
                                const Gap(4),
                                Text(
                                  educationTag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (educationTag.isNotEmpty && religionTag.isNotEmpty)
                          const Gap(8),

                        // Religion Chip
                        if (religionTag.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.figmaReligion,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 14,
                                  height: 14,
                                ),
                                const Gap(4),
                                Text(
                                  religionTag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Spacer(),

                        // 80% Match Pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: FigmaColors.primaryGradient(context),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'match_percent_suffix'.trParams({
                              'percent':
                              '${() {
                                final rawRatio = getFieldValue(member, 'matchPercent') ?? getFieldValue(member, 'match_percent') ?? getFieldValue(member, 'match_ratio') ?? getFieldValue(member, 'match_percentage');
                                if (rawRatio != null && rawRatio.toString().isNotEmpty) {
                                  final parsed = int.tryParse(rawRatio.toString());
                                  if (parsed != null && parsed > 0) return parsed;
                                }
                                return 0;
                              }()}',
                            }),
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),

                    // Bottom Action Bar
                    ProfileCardActionButtons(
                      memberModel: member,
                      style: ProfileCardActionStyle.list,
                      onShortlist: onShortlist,
                      onAudioCall: onAudioCall,
                      onVideoCall: onVideoCall,
                      onChat: onChat,
                      onInterest: onInterest,
                      onViewProfile: onTap,
                      onBlock: onBlock,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

