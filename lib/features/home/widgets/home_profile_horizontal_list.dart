import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';

import '../../../features/common/data/models/member_models.dart';
import '../../../features/common/data/repositories/action_repository.dart';
import '../../../utils/utils.dart';
import '../providers/dashboard_notifier.dart';

class HomeProfileHorizontalList extends ConsumerWidget {
  final String titlePrefix;
  final String titleSuffix;
  final List<MemberListModel> list;
  final VoidCallback onViewAll;

  const HomeProfileHorizontalList({
    super.key,
    required this.titlePrefix,
    required this.titleSuffix,
    required this.list,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (list.isEmpty) return const SizedBox.shrink();

    final showViewAll = list.length > 4;
    final displayCount = showViewAll ? 4 : list.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: titlePrefix,
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: titleSuffix,
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showViewAll)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onViewAll,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Text(
                      'view_all'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Gap(10),
        SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: displayCount + (showViewAll ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == displayCount) {
                return _buildViewAllCard(context);
              }
              final member = list[index];
              return _buildNearbyScrollItem(context, ref, member);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllCard(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onViewAll,
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'view_all_lbl'.tr,
              style: AppFont.font(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyScrollItem(
    BuildContext context,
    WidgetRef ref,
    MemberListModel member,
  ) {
    final name = (member.profileTitle ?? member.fullname ?? "").toString();

    return GestureDetector(
      onTap: () => context.push('/profile-other/${member.memberId}'),
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background Image
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: getImageWidget(
                  url: member.profileImage ?? "",
                  boxFit: BoxFit.cover,
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
                      blur: 10,
                      lockSize: 30,
                      borderRadius: 16,
                    ),
                  ),
                ),
              // Bottom Gradient Overlay for text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.25),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
              // Top Right circular heart icon
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () async {
                    showLoading(context);
                    try {
                      final isShortlisted = checkIsShortlisted(member);
                      final success = await ref
                          .read(actionRepositoryProvider)
                          .toggleShortlist(
                            memberId: member.memberId.toString(),
                            isCurrentlyShortlisted: isShortlisted,
                          );
                      hideLoading();
                      if (success) {
                        showToast(
                          isShortlisted
                              ? 'removed_from_shortlist'.tr
                              : 'shortlisted_successfully'.tr,
                        );
                        ref
                            .read(dashboardProvider.notifier)
                            .updateMemberShortlist(
                              member.memberId.toString(),
                              !isShortlisted,
                            );
                      } else {
                        showToast('failed_to_update_shortlist'.tr);
                      }
                    } catch (e) {
                      hideLoading();
                      showToast('something_went_wrong'.tr);
                    }
                  },
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
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
                        width: 14,
                        height: 14,
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom Info (Name, Age in PlayfairDisplay serif & City, Height in Inter)
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      member.subTitle?.toString() ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.85),
                          letterSpacing: 0.1,
                        ),
                      ),
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
