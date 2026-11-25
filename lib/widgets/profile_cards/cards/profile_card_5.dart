import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../features/common/data/models/member_models.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/photo_protected_widget.dart';
import '../../../widgets/photo_request_bottom_sheet.dart';
import '../profile_card_action_handler.dart';

class ProfileCard5 extends ConsumerWidget {
  final MemberListModel memberModel;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCard5({
    super.key,
    required this.memberModel,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;
    final isProtected = checkIsPhotoProtected(memberModel);
    final memberId = (memberModel.id ?? memberModel.memberId).toString();

    final title = memberModel.profileTitle?.toString().trim().isNotEmpty == true
        ? memberModel.profileTitle.toString()
        : memberModel.fullname?.toString().trim().isNotEmpty == true
        ? memberModel.fullname.toString()
        : 'N/A';

    final subTitle = memberModel.subTitle?.toString().trim().isNotEmpty == true
        ? memberModel.subTitle.toString()
        : [memberModel.cityName, memberModel.religion]
              .where((e) => e != null && e.toString().trim().isNotEmpty)
              .join(' · ');

    final photoUrl =
        (memberModel.profileImage?.toString().trim().isNotEmpty == true)
        ? memberModel.profileImage.toString()
        : (memberModel.photo1?.toString().trim().isNotEmpty == true)
        ? memberModel.photo1.toString()
        : "";

    final matchPct = memberModel.matchPercent
        ?.toString()
        .replaceAll('%', '')
        .trim();
    final matchPctText = (matchPct != null && matchPct.isNotEmpty)
        ? "$matchPct% ${'match'.tr.toUpperCase()}"
        : "94% ${'match'.tr.toUpperCase()}";

    final isShortlisted =
        memberModel.isShortlisted == "1" ||
        memberModel.isShortlisted == 1 ||
        memberModel.isShortlisted == true ||
        memberModel.isShortlisted == "Yes";

    final isInterestSent =
        memberModel.interestState == "sent" ||
        memberModel.interestStatus == "sent";

    return GestureDetector(
      onTap: isProtected
          ? () => PhotoRequestBottomSheet.show(context, memberId)
          : () => ProfileCardActionHandler.viewProfile(context, memberModel),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Row(
            children: [
              // Left Side: Square Photo with "TOP PICK" Badge
              SizedBox(
                width: 140,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    getImageWidget(
                      url: photoUrl,
                      boxFit: BoxFit.cover,
                      isMyPhoto: false,
                      isProtected: isProtected,
                      targetGender: memberModel.gender,
                    ),
                    if (isProtected)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () =>
                              PhotoRequestBottomSheet.show(context, memberId),
                          child: const ProtectedImageOverlay(
                            blur: 16,
                            lockSize: 36,
                            borderRadius: 0,
                          ),
                        ),
                      ),
                    Positioned(
                      top: 12,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const Gap(4),
                            Text(
                              'top_pick'.tr.toUpperCase(),
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Side: Gradient Panel
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Match % & Star Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.icHeart,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 11,
                                  height: 11,
                                ),
                                const Gap(4),
                                Text(
                                  matchPctText,
                                  style: AppFont.font(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                ProfileCardActionHandler.toggleShortlist(
                                  context: context,
                                  ref: ref,
                                  memberModel: memberModel,
                                  onUpdated: onActionComplete,
                                ),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  isShortlisted
                                      ? AppAssets.figmaShortlistSelected
                                      : AppAssets.figmaShortlist,
                                  colorFilter: ColorFilter.mode(
                                    isShortlisted ? Colors.amber : Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),

                      // Title
                      Text(
                        title,
                        style: AppFont.font(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subTitle.isNotEmpty) ...[
                        const Gap(2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: SvgPicture.asset(
                                AppAssets.figmaLocation,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white70,
                                  BlendMode.srcIn,
                                ),
                                width: 12,
                                height: 12,
                              ),
                            ),
                            const Gap(4),
                            Expanded(
                              child: Text(
                                subTitle,
                                style: AppFont.font(
                                  fontSize: 11.5,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const Spacer(),

                      // Bottom Action Buttons: View Profile + Heart
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => ProfileCardActionHandler.viewProfile(
                                context,
                                memberModel,
                              ),
                              child: Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.22),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const Gap(6),
                                    Text(
                                      'view_profile'.tr,
                                      style: AppFont.font(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => ProfileCardActionHandler.sendInterest(
                              context: context,
                              ref: ref,
                              memberModel: memberModel,
                              onUpdated: onActionComplete,
                            ),
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                color: isInterestSent
                                    ? const Color(0xFF22C55E)
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  isInterestSent
                                      ? Icons.check_rounded
                                      : Icons.favorite_rounded,
                                  color: isInterestSent
                                      ? Colors.white
                                      : primaryColor,
                                  size: 18,
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
            ],
          ),
        ),
      ),
    );
  }
}
