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

class ProfileCard6 extends ConsumerWidget {
  final MemberListModel memberModel;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCard6({
    super.key,
    required this.memberModel,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final isDark = theme.brightness == Brightness.dark;
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
        : "92% ${'match'.tr.toUpperCase()}";

    final isOnline =
        memberModel.isOnline == "1" ||
        memberModel.isOnline == 1 ||
        memberModel.isOnline == true ||
        memberModel.isOnlineText?.toString().toLowerCase().contains('online') ==
            true;

    final isPaid =
        memberModel.planName != null &&
        memberModel.planName.toString().trim().isNotEmpty &&
        memberModel.planStatus != "Not Paid" &&
        memberModel.planStatus != "Expired";

    final isInterestSent =
        memberModel.interestState == "sent" ||
        memberModel.interestStatus == "sent";

    return GestureDetector(
      onTap: isProtected
          ? () => PhotoRequestBottomSheet.show(context, memberId)
          : () => ProfileCardActionHandler.viewProfile(context, memberModel),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Left Side Photo with ONLINE badge
            SizedBox(
              width: 100,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: getImageWidget(
                      url: photoUrl,
                      boxFit: BoxFit.cover,
                      isMyPhoto: false,
                      isProtected: isProtected,
                      targetGender: memberModel.gender,
                    ),
                  ),
                  if (isProtected)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () =>
                            PhotoRequestBottomSheet.show(context, memberId),
                        child: const ProtectedImageOverlay(
                          blur: 16,
                          lockSize: 34,
                          borderRadius: 16,
                        ),
                      ),
                    ),
                  if (isOnline)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'online'.tr.toUpperCase(),
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 9,
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

            const Gap(14),

            // Right Side White Info Panel
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppFont.font(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF16182F),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isPaid && ref.watch(featureProvider('showPremiumBadge')))
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            AppAssets.figmaPremium,
                            colorFilter: const ColorFilter.mode(
                              Colors.amber,
                              BlendMode.srcIn,
                            ),
                            width: 16,
                            height: 16,
                          ),
                        ),
                    ],
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
                              Color(0xFF8F96AC),
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
                              color: const Color(0xFF8F96AC),
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

                  // Bottom Match % & Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.icHeart,
                            colorFilter: ColorFilter.mode(
                              primaryColor,
                              BlendMode.srcIn,
                            ),
                            width: 13,
                            height: 13,
                          ),
                          const Gap(4),
                          Text(
                            matchPctText,
                            style: AppFont.font(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => ProfileCardActionHandler.openChat(
                              context,
                              ref,
                              memberModel,
                            ),
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.figmaChat,
                                  colorFilter: ColorFilter.mode(
                                    primaryColor,
                                    BlendMode.srcIn,
                                  ),
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          GestureDetector(
                            onTap: () => ProfileCardActionHandler.sendInterest(
                              context: context,
                              ref: ref,
                              memberModel: memberModel,
                              onUpdated: onActionComplete,
                            ),
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                color: isInterestSent
                                    ? const Color(0xFF22C55E)
                                    : primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  isInterestSent
                                      ? Icons.check_rounded
                                      : Icons.favorite_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
