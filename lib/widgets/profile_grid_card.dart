import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';

class ProfileGridCard extends ConsumerWidget {
  final MemberListModel member;
  final VoidCallback? onTap;
  final VoidCallback? onShortlist;

  const ProfileGridCard({
    super.key,
    required this.member,
    this.onTap,
    this.onShortlist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = member.profileImage ?? member.photo1 ?? "";

    final isPhotoProtected = checkIsPhotoProtected(member);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Rounded corners matching Figma
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Card photo
          InkWell(
            onTap: isPhotoProtected
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
              isProtected: isPhotoProtected,
            ),
          ),
          if (isPhotoProtected)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => PhotoRequestBottomSheet.show(
                  context,
                  member.memberId.toString(),
                ),
                child: const ProtectedImageOverlay(
                  blur: 10,
                  lockSize: 35,
                  borderRadius: 20,
                ),
              ),
            ),

          // Top gradient overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.25),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.35),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Top-Right: Crown badge for Premium (below Shortlist button)
          if (checkIsPaid(member) && ref.watch(featureProvider('showPremiumBadge')))
            Positioned(
              top: 48,
              right: 10,
              child: Container(
                width: 32,
                height: 32,
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
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ),

          // Top-Right: Heart icon (Shortlist toggle)
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: onShortlist,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.3,
                  ), // Translucent overlay in Figma
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    checkIsShortlisted(member)
                        ? AppAssets.figmaShortlistSelected
                        : AppAssets.figmaShortlist,
                    colorFilter: ColorFilter.mode(
                      checkIsShortlisted(member)
                          ? const Color(0xFFFABE2C)
                          : Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ),
          ),

          // Bottom glassmorphic info block
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 14,
                  sigmaY: 14,
                ), // Figma backdrop blur 14
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.12,
                    ), // Figma 12% fill opacity
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.15,
                      ), // Figma 15% outline opacity
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          member.profileTitle ?? '',
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        member.subTitle ?? '',
                        style: AppFont.font(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
