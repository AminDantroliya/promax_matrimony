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


class ProfileCard1 extends ConsumerWidget {
  final MemberListModel memberModel;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCard1({
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
    final matchPctText = (matchPct != null && matchPct.isNotEmpty) ? "$matchPct% ${'match'.tr.toUpperCase()}" : "";

    final isOnline = memberModel.isOnline == "1" ||
        memberModel.isOnline == 1 ||
        memberModel.isOnline == true ||
        memberModel.isOnlineText?.toString().toLowerCase().contains('online') == true;

    return GestureDetector(
      onTap: isProtected
          ? () => PhotoRequestBottomSheet.show(context, memberId)
          : () => ProfileCardActionHandler.viewProfile(context, memberModel),
      child: Container(
        height: 480,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              getImageWidget(
                url: photoUrl,
                boxFit: BoxFit.cover,
                isMyPhoto: false,
                isProtected: isProtected,
                targetGender: memberModel.gender,
              ),

              // Protected Photo Blur & Lock Overlay
              if (isProtected)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => PhotoRequestBottomSheet.show(context, memberId),
                    child: const ProtectedImageOverlay(
                      blur: 16,
                      lockSize: 50,
                      borderRadius: 28,
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
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Top Bar (Online Badge & Options Menu)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isOnline)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              'online_now'.tr,
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    GestureDetector(
                      onTap: () => ProfileCardActionHandler.showOptionsMenu(context, ref, memberModel),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.figmaMore,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Details & Actions
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppFont.font(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (subTitle.isNotEmpty) ...[
                                const Gap(4),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.figmaLocation,
                                      colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                                      width: 14,
                                      height: 14,
                                    ),
                                    const Gap(4),
                                    Expanded(
                                      child: Text(
                                        subTitle,
                                        style: AppFont.font(
                                          fontSize: 13,
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
                        if (matchPctText.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: FigmaColors.primaryGradient(context),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              matchPctText,
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

                    ProfileCardActionButtons(
                      memberModel: memberModel,
                      style: ProfileCardActionStyle.glass,
                      onActionComplete: onActionComplete,
                    ),
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

