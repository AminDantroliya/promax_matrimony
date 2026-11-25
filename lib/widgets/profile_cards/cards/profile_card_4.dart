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

class ProfileCard4 extends ConsumerWidget {
  final MemberListModel memberModel;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCard4({
    super.key,
    required this.memberModel,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final isProtected = checkIsPhotoProtected(memberModel);
    final memberId = (memberModel.id ?? memberModel.memberId).toString();

    final title = memberModel.profileTitle?.toString().trim().isNotEmpty == true
        ? memberModel.profileTitle.toString()
        : memberModel.fullname?.toString().trim().isNotEmpty == true
            ? memberModel.fullname.toString()
            : 'N/A';

    final subTitle = memberModel.subTitle?.toString().trim().isNotEmpty == true
        ? memberModel.subTitle.toString()
        : [
            memberModel.cityName,
            memberModel.religion,
          ].where((e) => e != null && e.toString().trim().isNotEmpty).join(' · ');

    final photoUrl = (memberModel.profileImage?.toString().trim().isNotEmpty == true)
        ? memberModel.profileImage.toString()
        : (memberModel.photo1?.toString().trim().isNotEmpty == true)
            ? memberModel.photo1.toString()
            : "";

    final matchPct = memberModel.matchPercent?.toString().replaceAll('%', '').trim();
    final matchPctText = (matchPct != null && matchPct.isNotEmpty) ? "$matchPct% ${'match'.tr.toUpperCase()}" : "92% ${'match'.tr.toUpperCase()}";

    final isPaid = memberModel.planName != null &&
        memberModel.planName.toString().trim().isNotEmpty &&
        memberModel.planStatus != "Not Paid" &&
        memberModel.planStatus != "Expired";
    final showPremium = isPaid && ref.watch(featureProvider('showPremiumBadge'));

    final isShortlisted = memberModel.isShortlisted == "1" ||
        memberModel.isShortlisted == 1 ||
        memberModel.isShortlisted == true ||
        memberModel.isShortlisted == "Yes";

    final isInterestSent = memberModel.interestState == "sent" ||
        memberModel.interestStatus == "sent";

    return GestureDetector(
      onTap: isProtected
          ? () => PhotoRequestBottomSheet.show(context, memberId)
          : () => ProfileCardActionHandler.viewProfile(context, memberModel),
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo Background
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
                    onTap: () => PhotoRequestBottomSheet.show(context, memberId),
                    child: const ProtectedImageOverlay(
                      blur: 16,
                      lockSize: 40,
                      borderRadius: 24,
                    ),
                  ),
                ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Top Bar (Badge & Heart Action)
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            showPremium ? AppAssets.figmaPremium : AppAssets.figmaVerified,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            width: 11,
                            height: 11,
                          ),
                          const Gap(4),
                          Text(
                            (showPremium ? 'premium'.tr : 'verified'.tr).toUpperCase(),
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ProfileCardActionHandler.sendInterest(
                        context: context,
                        ref: ref,
                        memberModel: memberModel,
                        onUpdated: onActionComplete,
                      ),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: isInterestSent ? const Color(0xFF22C55E) : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            isInterestSent
                                ? Icons.check_rounded
                                : (isShortlisted
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded),
                            color: isInterestSent ? Colors.white : primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Info Section
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Match % Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppAssets.icHeart,
                            colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                            width: 12,
                            height: 12,
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
                    const Gap(6),
                    // Title
                    Text(
                      title,
                      style: AppFont.font(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subTitle.isNotEmpty) ...[
                      const Gap(2),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.figmaLocation,
                            colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                            width: 12,
                            height: 12,
                          ),
                          const Gap(3),
                          Expanded(
                            child: Text(
                              subTitle,
                              style: AppFont.font(
                                fontSize: 11.5,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
