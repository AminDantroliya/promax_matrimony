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

class ProfileCard3 extends ConsumerWidget {
  final MemberListModel memberModel;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCard3({
    super.key,
    required this.memberModel,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final matchPctText = (matchPct != null && matchPct.isNotEmpty) ? "$matchPct% ${'match'.tr.toUpperCase()}" : "80% ${'match'.tr.toUpperCase()}";

    final isOnline = memberModel.isOnline == "1" ||
        memberModel.isOnline == 1 ||
        memberModel.isOnline == true ||
        memberModel.isOnlineText?.toString().toLowerCase().contains('online') == true;

    // Attribute chips
    final religionText = memberModel.religion?.toString().trim() ?? '';
    final educationText = memberModel.educationDetails?.toString().trim() ?? '';

    return GestureDetector(
      onTap: isProtected
          ? () => PhotoRequestBottomSheet.show(context, memberId)
          : () => ProfileCardActionHandler.viewProfile(context, memberModel),
      child: Container(
        height: 520,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
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
                      lockSize: 50,
                      borderRadius: 32,
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
                        Colors.black.withValues(alpha: 0.4),
                        Colors.black.withValues(alpha: 0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.35, 0.65, 1.0],
                    ),
                  ),
                ),
              ),

              // Top Bar
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: isOnline ? const Color(0xFF22C55E) : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ProfileCardActionHandler.showOptionsMenu(context, ref, memberModel),
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
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Details
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title & Age
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
                    const Gap(12),

                    // Attribute Chips Row (MBA, Hindu, Match %)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (educationText.isNotEmpty && int.tryParse(educationText) == null)
                          _buildDarkChip(svgPath: AppAssets.figmaEducation, label: educationText),
                        if (religionText.isNotEmpty && int.tryParse(religionText) == null)
                          _buildDarkChip(svgPath: AppAssets.figmaReligion, label: religionText),
                        // Gradient Match Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            gradient: FigmaColors.primaryGradient(context),
                            borderRadius: BorderRadius.circular(20),
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

                    const Gap(18),

                    // Circular Action Buttons
                    ProfileCardActionButtons(
                      memberModel: memberModel,
                      style: ProfileCardActionStyle.circle,
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

  Widget _buildDarkChip({String? svgPath, IconData? icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          svgPath != null
              ? SvgPicture.asset(
                  svgPath,
                  colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                  width: 13,
                  height: 13,
                )
              : Icon(icon, color: Colors.white70, size: 13),
          const Gap(4),
          Text(
            label,
            style: AppFont.font(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

