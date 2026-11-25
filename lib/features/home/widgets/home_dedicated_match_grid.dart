import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/features/common/data/repositories/action_repository.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';

class HomeDedicatedMatchGrid extends ConsumerWidget {
  final String titlePrefix;
  final String titleSuffix;
  final List<MemberListModel> list;
  final VoidCallback onSeeAll;

  const HomeDedicatedMatchGrid({
    super.key,
    required this.titlePrefix,
    required this.titleSuffix,
    required this.list,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (list.isEmpty) return const SizedBox.shrink();

    final showViewAll = list.length > 4;
    final displayCount = list.length > 10 ? 10 : list.length;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: titlePrefix,
                  style: AppFont.font(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                  ),
                  children: [
                    if (titleSuffix.isNotEmpty)
                      TextSpan(
                        text: titleSuffix,
                        style: AppFont.font(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (list.length > 2)
                GestureDetector(
                  onTap: onSeeAll,
                  child: Row(
                    children: [
                      Text(
                        'see_all'.tr,
                        style: AppFont.font(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Gap(4),
                      SvgPicture.asset(
                        AppAssets.figmaNavigationForward,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                        height: 12,
                        width: 12,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        const Gap(12),

        // Single Row Horizontal Scroll of Category 2 Profile Cards
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: displayCount + (showViewAll ? 1 : 0),
            separatorBuilder: (context, index) => const Gap(12),
            itemBuilder: (context, index) {
              if (index == displayCount) {
                return _buildViewAllCard(context);
              }
              final member = list[index];
              return SizedBox(
                width: 155,
                child: _buildCategory2ProfileCard(context, ref, member),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllCard(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onSeeAll,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryColor.withValues(alpha: 0.08),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: primaryColor,
                size: 22,
              ),
            ),
            const Gap(10),
            Text(
              'view_all_lbl'.tr,
              style: AppFont.font(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory2ProfileCard(
    BuildContext context,
    WidgetRef ref,
    MemberListModel member,
  ) {
    final photoUrl =
        member.photo1?.toString() ?? member.profileImage?.toString();
    final nameStr =
        member.fullname?.toString() ?? member.profileTitle?.toString() ?? '';
    final ageStr = _parseAge(member.birthdate);
    final cityStr =
        member.cityName?.toString() ?? member.stateName?.toString() ?? '';
    final matchPct = member.matchPercent != null
        ? int.tryParse(member.matchPercent.toString())
        : null;

    final targetId = member.memberId ?? member.id;
    final isShortlisted = checkIsShortlisted(member);

    return GestureDetector(
      onTap: () {
        if (targetId != null) {
          context.push('/profile-other/$targetId');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Photo Image
              Positioned.fill(
                child: (photoUrl != null && photoUrl.isNotEmpty)
                    ? Image.network(
                        photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) =>
                            Image.asset(AppAssets.placeholderFemale),
                      )
                    : Image.asset(AppAssets.placeholderFemale),
              ),

              if (checkIsPhotoProtected(member))
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => PhotoRequestBottomSheet.show(
                      context,
                      (member.memberId ?? member.id).toString(),
                    ),
                    child: const ProtectedImageOverlay(
                      blur: 10,
                      lockSize: 30,
                      borderRadius: 20,
                    ),
                  ),
                ),

              // Bottom Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Match % Chip Top Left
              if (matchPct != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.icProfileCardMatch,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: 10,
                          width: 10,
                        ),
                        const Gap(3),
                        Text(
                          '$matchPct%',
                          style: AppFont.font(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Shortlist Button Top Right
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () async {
                    if (targetId == null) return;
                    showLoading(context);
                    try {
                      final success = await ref
                          .read(actionRepositoryProvider)
                          .toggleShortlist(
                            memberId: targetId.toString(),
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
                              targetId.toString(),
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
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      isShortlisted
                          ? AppAssets.figmaShortlistSelected
                          : AppAssets.figmaShortlist,
                      colorFilter: ColorFilter.mode(
                        isShortlisted
                            ? const Color(0xFFFABE2C)
                            : Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                      height: 13,
                      width: 13,
                    ),
                  ),
                ),
              ),

              // Member Details Bottom
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ageStr.isNotEmpty ? '$nameStr, $ageStr' : nameStr,
                            style: AppFont.font(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(4),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Color(0xFF22C55E),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                      ],
                    ),
                    const Gap(2),
                    Text(
                      cityStr.isNotEmpty
                          ? '$cityStr · ${member.isOnline == "1" ? 'online_lbl'.tr : 'recently_active'.tr}'
                          : (member.isOnline == "1"
                                ? 'online_lbl'.tr
                                : 'recently_active'.tr),
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  String _parseAge(dynamic val) {
    if (val == null) return '';
    final s = val.toString().trim();
    if (s.isEmpty) return '';
    // If it's already just a number e.g. "25"
    if (RegExp(r'^\d+$').hasMatch(s)) return s;
    // If it's a date string e.g. "1997-08-11"
    try {
      final dt = DateTime.parse(s);
      final now = DateTime.now();
      int age = now.year - dt.year;
      if (now.month < dt.month || (now.month == dt.month && now.day < dt.day)) {
        age--;
      }
      return age > 0 ? '$age' : '';
    } catch (_) {
      // Fallback: take first part before space or hyphen
      return s.split('-').first.split(' ').first;
    }
  }
}
