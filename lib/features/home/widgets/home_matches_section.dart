import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../../../features/common/data/models/member_models.dart';
import '../../../features/common/data/repositories/action_repository.dart';
import '../../../widgets/photo_protected_widget.dart';
import '../../../widgets/photo_request_bottom_sheet.dart';
import '../../../utils/utils.dart';
import '../data/models/dashboard_models.dart';
import '../providers/dashboard_notifier.dart';

class HomeMatchesSection extends ConsumerStatefulWidget {
  final DashboardData data;

  const HomeMatchesSection({super.key, required this.data});

  @override
  ConsumerState<HomeMatchesSection> createState() => _HomeMatchesSectionState();
}

class _HomeMatchesSectionState extends ConsumerState<HomeMatchesSection> {
  int _selectedTab = 0; // 0 = Recently Login, 1 = Recently Joined

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFigmaToggles(context),
        const Gap(24),
        _buildFigmaGrid(context, widget.data),
      ],
    );
  }

  Widget _buildFigmaToggles(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2038) : const Color(0xFFF1F3F9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == 0
                      ? (isDark ? const Color(0xFF2C2E4A) : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: _selectedTab == 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: _selectedTab == 0
                          ? Theme.of(context).primaryColor
                          : const Color(0xFF8A90A6),
                    ),
                    const Gap(6),
                    Text(
                      'recently_login'.tr,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: _selectedTab == 0
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: _selectedTab == 0
                            ? Theme.of(context).primaryColor
                            : const Color(0xFF8A90A6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == 1
                      ? (isDark ? const Color(0xFF2C2E4A) : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: _selectedTab == 1
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_outlined,
                      size: 15,
                      color: _selectedTab == 1
                          ? Theme.of(context).primaryColor
                          : const Color(0xFF8A90A6),
                    ),
                    const Gap(6),
                    Text(
                      'recently_joined'.tr,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: _selectedTab == 1
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: _selectedTab == 1
                            ? Theme.of(context).primaryColor
                            : const Color(0xFF8A90A6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFigmaGrid(BuildContext context, DashboardData data) {
    final list = _selectedTab == 0
        ? (data.recentlyLoginMember ?? [])
        : (data.recentlyJoinedMember ?? []);

    if (list.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('no_matches_found'.tr),
      );
    }

    final bool showViewAll = list.length > 4;
    final int displayCount = showViewAll ? 4 : list.length;

    return SizedBox(
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
          return _buildNearbyScrollItem(context, member);
        },
      ),
    );
  }

  Widget _buildViewAllCard(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_selectedTab == 0) {
          context.push('/recently-login-matches');
        } else {
          context.push('/recently-joined-matches');
        }
      },
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

  Widget _buildNearbyScrollItem(BuildContext context, MemberListModel member) {
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
              // Bottom Info
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
