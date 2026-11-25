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
import '../profile_card_action_buttons.dart';


class ProfileCard2 extends ConsumerWidget {
  final MemberListModel memberModel;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCard2({
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

    final matchPctRaw = memberModel.matchPercent
        ?.toString()
        .replaceAll('%', '')
        .trim();
    final matchPct = int.tryParse(matchPctRaw ?? '85') ?? 85;

    final isPaid =
        memberModel.planName != null &&
        memberModel.planName.toString().trim().isNotEmpty &&
        memberModel.planStatus != "Not Paid" &&
        memberModel.planStatus != "Expired";

    return GestureDetector(
      onTap: isProtected
          ? () => PhotoRequestBottomSheet.show(context, memberId)
          : () => ProfileCardActionHandler.viewProfile(context, memberModel),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Photo Section with Actions Overlaid
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                      child: getImageWidget(
                        url: photoUrl,
                        boxFit: BoxFit.cover,
                        isMyPhoto: false,
                        isProtected: isProtected,
                        targetGender: memberModel.gender,
                      ),
                    ),
                  ),

                  if (isProtected)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () =>
                            PhotoRequestBottomSheet.show(context, memberId),
                        child: const ProtectedImageOverlay(
                          blur: 16,
                          lockSize: 50,
                          borderRadius: 28,
                        ),
                      ),
                    ),

                  // Gradient overlay at bottom of photo
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // Premium Badge Top-Left & Menu Top-Right
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isPaid && ref.watch(featureProvider('showPremiumBadge')))
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.figmaPremium,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF22C55E),
                                    BlendMode.srcIn,
                                  ),
                                  width: 14,
                                  height: 14,
                                ),
                                const Gap(4),
                                Text(
                                  'premium'.tr.toUpperCase(),
                                  style: AppFont.font(
                                    color: const Color(0xFF22C55E),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        GestureDetector(
                          onTap: () => ProfileCardActionHandler.showOptionsMenu(
                            context,
                            ref,
                            memberModel,
                          ),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.figmaMore,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
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
                  ),

                  // 5 Action Buttons Row Overlaid at Photo Bottom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: ProfileCardActionButtons(
                      memberModel: memberModel,
                      style: ProfileCardActionStyle.light,
                      onActionComplete: onActionComplete,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom White Info Panel
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFont.font(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF16182F),
                    ),
                  ),
                  if (subTitle.isNotEmpty) ...[
                    const Gap(4),
                    Text(
                      subTitle,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8F96AC),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const Gap(14),

                  // Progress Bar & Percentage
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: (matchPct / 100).clamp(0.0, 1.0),
                            minHeight: 6,
                            backgroundColor: primaryColor.withValues(
                              alpha: 0.12,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Text(
                        '$matchPct% ${'match'.tr}',
                        style: AppFont.font(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
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

