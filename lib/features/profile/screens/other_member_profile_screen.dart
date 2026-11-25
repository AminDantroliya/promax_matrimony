import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/features/profile/providers/other_profile_notifier.dart';
import 'package:pro_matrimony/features/profile/widgets/other_profile_common_widgets.dart';
import 'package:pro_matrimony/utils/app_routes.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/features/matches/providers/ai_match_notifier.dart';
import 'package:pro_matrimony/features/matches/providers/matches_notifier.dart';
import 'package:pro_matrimony/features/search/providers/search_notifier.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';

import 'designs/other_profile_design_1.dart';
import 'designs/other_profile_design_2.dart';
import 'designs/other_profile_design_3.dart';
import 'designs/other_profile_design_4.dart';
import 'designs/other_profile_design_5.dart';

class OtherMemberProfileScreen extends ConsumerStatefulWidget {
  final String memberId;
  final String? profileDesign;

  const OtherMemberProfileScreen({
    super.key,
    required this.memberId,
    this.profileDesign,
  });

  @override
  ConsumerState<OtherMemberProfileScreen> createState() =>
      _OtherMemberProfileScreenState();
}

class _OtherMemberProfileScreenState
    extends ConsumerState<OtherMemberProfileScreen> {
  bool _isUnblocking = false;
  bool _hasShownViewNotAllowed = false;

  void _checkViewProfileAllowed(OtherMemberProfileResponseModel profile) {
    final viewAllowed =
        profile.viewProfileAllowed?.toString() ??
        profile.data?.viewProfileAllowed?.toString() ??
        "Yes";
    final isNo =
        viewAllowed.toLowerCase() == "no" ||
        viewAllowed == "0" ||
        viewAllowed == "false";

    if (isNo && !_hasShownViewNotAllowed) {
      _hasShownViewNotAllowed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(otherProfileProvider(widget.memberId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: profileAsync.when(
        data: (profile) {
          final data = profile.data;
          final viewAllowed =
              profile.viewProfileAllowed?.toString() ??
              data?.viewProfileAllowed?.toString() ??
              "Yes";

          final isViewAllowedNo =
              viewAllowed.toLowerCase() == "no" ||
              viewAllowed == "0" ||
              viewAllowed == "false";

          if (isViewAllowedNo) {
            _checkViewProfileAllowed(profile);
            final msg =
                (profile.message != null &&
                    profile.message.toString().isNotEmpty)
                ? profile.message.toString()
                : 'view_profile_not_allowed'.tr;
            return _buildViewProfileNotAllowedContent(msg, data, profile: profile);
          }

          final isNotFound =
              profile.userNotFoundStatus == true ||
              profile.userNotFoundStatus == 'true' ||
              profile.userNotFoundStatus == 1 ||
              profile.userNotFoundStatus == '1' ||
              (profile.status?.toLowerCase() == 'error' && data == null);

          final isPersonalized = data?.userType?.toString() == "1";
          final isBlocked = data?.isBlock?.toString() == "1";

          if (isNotFound || isPersonalized || data == null) {
            final String notFoundTitle = isPersonalized
                ? 'this_profile_unavailable'.tr
                : (profile.userNotFoundTitle != null && profile.userNotFoundTitle!.isNotEmpty
                    ? profile.userNotFoundTitle!
                    : 'this_profile_unavailable'.tr);

            final String notFoundMessage = isPersonalized
                ? 'personalized_unavailable_desc'.tr
                : (profile.message != null && profile.message.toString().isNotEmpty
                    ? profile.message.toString()
                    : (profile.userNotFoundMessage != null && profile.userNotFoundMessage!.isNotEmpty
                        ? profile.userNotFoundMessage!
                        : 'failed_to_load_profile'.tr));

            return _buildUserNotFoundContent(
              title: notFoundTitle,
              message: notFoundMessage,
              data: data,
              profile: profile,
              onRetry: () => ref.refresh(otherProfileProvider(widget.memberId)),
            );
          }

          if (isBlocked) {
            final displayName =
                (data.fullname != null && data.fullname.toString().isNotEmpty)
                ? data.fullname.toString()
                : (data.matriId?.toString() ?? "");
            return _buildUserBlockedContent(displayName, data, profile: profile);
          }

          final config = ref.watch(appConfigProvider);
          final rawDesign = (widget.profileDesign ?? config.otherProfileDesign).trim();
          final match = RegExp(r'(\d+)').firstMatch(rawDesign);
          final designId = match != null ? int.tryParse(match.group(1)!) : 1;

          switch (designId) {
            case 2:
              return OtherProfileDesign2(
                data: data,
                memberId: widget.memberId,
                profileResponse: profile,
              );
            case 3:
              return OtherProfileDesign3(
                data: data,
                memberId: widget.memberId,
                profileResponse: profile,
              );
            case 4:
              return OtherProfileDesign4(
                data: data,
                memberId: widget.memberId,
                profileResponse: profile,
              );
            case 5:
              return OtherProfileDesign5(
                data: data,
                memberId: widget.memberId,
                profileResponse: profile,
              );
            case 1:
            default:
              return OtherProfileDesign1(
                data: data,
                memberId: widget.memberId,
                profileResponse: profile,
              );
          }
        },
        loading: () => const Center(child: AppLoadingWidget()),
        error: (e, s) => _buildUserNotFoundContent(
          title: 'failed_to_load_profile'.tr,
          message: e.toString(),
          data: null,
          onRetry: () => ref.refresh(otherProfileProvider(widget.memberId)),
        ),
      ),
    );
  }

  bool _isPhotoProtected(
    ProfileData? data,
    OtherMemberProfileResponseModel? profile,
  ) {
    if (checkIsPhotoProtected(data) || checkIsPhotoProtected(profile)) {
      return true;
    }
    try {
      final dashboard = ref.read(dashboardProvider).value;
      if (dashboard != null) {
        final allMembers = [
          ...?dashboard.recentlyJoinedMember,
          ...?dashboard.recentlyLoginMember,
          ...?dashboard.todayMatches,
          ...?dashboard.recommendedMatches,
          ...?dashboard.whoViewMyProfile,
          ...?dashboard.receivedInterest,
          ...?dashboard.recommedMatchesMember,
          ...?dashboard.premiumMatchesMember,
          ...?dashboard.nearByMatchesMember,
          ...?dashboard.featuredMember,
        ];
        for (final m in allMembers) {
          if ((m.memberId ?? m.id).toString() == widget.memberId) {
            if (checkIsPhotoProtected(m)) return true;
          }
        }
      }
    } catch (_) {}

    try {
      final searchState = ref.read(searchResultProvider);
      final match = searchState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == widget.memberId,
      );
      if (checkIsPhotoProtected(match)) return true;
    } catch (_) {}

    try {
      final aiState = ref.read(aiMatchProvider);
      final match = aiState.items.firstWhere(
        (e) => (e.id ?? e.memberId).toString() == widget.memberId,
      );
      if (checkIsPhotoProtected(match)) return true;
    } catch (_) {}

    for (final url in kMatchesUrls) {
      try {
        final matchesState = ref.read(matchesProvider(url));
        final match = matchesState.items.firstWhere(
          (e) => (e.id ?? e.memberId).toString() == widget.memberId,
        );
        if (checkIsPhotoProtected(match)) return true;
      } catch (_) {}
    }

    return false;
  }

  Widget _buildUserAvatar(
    ProfileData? data,
    bool isDark, {
    OtherMemberProfileResponseModel? profile,
  }) {
    final isProtected = _isPhotoProtected(data, profile);
    final images = OtherProfileHelper.getImageList(data);
    final String profilePic = (images.isNotEmpty)
        ? images[0]
        : (data?.profileImage?.toString() ?? "");

    final hasPhoto = profilePic.isNotEmpty;

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75),
        child: Stack(
          fit: StackFit.expand,
          children: [
            hasPhoto
                ? getImageWidget(
                    url: profilePic,
                    boxFit: BoxFit.cover,
                    imageWidth: 150,
                    imageHeight: 150,
                    isProtected: isProtected,
                    targetGender: data?.gender?.toString(),
                  )
                : Center(
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                    ),
                  ),
            if (isProtected)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    if (data != null) {
                      context.push(
                        '/send-photo-request',
                        extra: OtherProfileHelper.getPhotoExtraParams(
                          images,
                          data,
                          widget.memberId,
                        ),
                      );
                    } else {
                      PhotoRequestBottomSheet.show(context, widget.memberId);
                    }
                  },
                  child: const ProtectedImageOverlay(
                    blur: 15,
                    lockSize: 45,
                    borderRadius: 75,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserBlockedContent(
    String displayName,
    ProfileData? data, {
    OtherMemberProfileResponseModel? profile,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home');
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildUserAvatar(data, isDark, profile: profile),
                    const Gap(24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'blocked_caps'.tr,
                        style: const TextStyle(
                          color: Color(0xFFE53935),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Gap(24),
                    Text(
                      'you_blocked_name'.trParams({'name': displayName}),
                      textAlign: TextAlign.center,
                      style: AppFont.font(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'blocked_desc'.tr,
                      textAlign: TextAlign.center,
                      style: AppFont.font(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                    ),
                    const Gap(36),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isUnblocking
                            ? null
                            : () async {
                                setState(() {
                                  _isUnblocking = true;
                                });
                                final success = await ref
                                    .read(
                                      otherProfileProvider(widget.memberId).notifier,
                                    )
                                    .toggleBlock();
                                if (mounted) {
                                  setState(() {
                                    _isUnblocking = false;
                                  });
                                  if (success) {
                                    showToast('user_unblocked_success'.tr);
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          elevation: 4,
                          shadowColor:
                              Theme.of(context).primaryColor.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppTheme.getButtonBorderRadius(context),
                          ),
                        ),
                        child: _isUnblocking
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock_open_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const Gap(8),
                                  Text(
                                    'unblock_name'.trParams({'name': displayName}),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserNotFoundContent({
    String? title,
    String? message,
    ProfileData? data,
    OtherMemberProfileResponseModel? profile,
    VoidCallback? onRetry,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final displayTitle = (title != null && title.isNotEmpty)
        ? title
        : 'this_profile_unavailable'.tr;

    final displayMessage = (message != null && message.isNotEmpty)
        ? message
        : 'personalized_unavailable_desc'.tr;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home');
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildUserAvatar(data, isDark, profile: profile),
                    const Gap(24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'unavailable_caps'.tr,
                        style: const TextStyle(
                          color: Color(0xFFE53935),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Gap(24),
                    Text(
                      displayTitle,
                      textAlign: TextAlign.center,
                      style: AppFont.font(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      displayMessage,
                      textAlign: TextAlign.center,
                      style: AppFont.font(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                        height: 1.5,
                      ),
                    ),
                    const Gap(36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (onRetry != null) ...[
                          OutlinedButton.icon(
                            onPressed: onRetry,
                            icon: const Icon(Icons.refresh_rounded),
                            label: Text('retry'.tr),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                          const Gap(12),
                        ],
                        GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/home');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            decoration: BoxDecoration(
                              gradient: ref.watch(appConfigProvider).primaryGradient,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'go_back'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildViewProfileNotAllowedContent(
    String message,
    ProfileData? data, {
    OtherMemberProfileResponseModel? profile,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final displayTitle = 'view_profile_not_allowed'.tr;
    final isGenericMsg =
        message.isEmpty ||
        message.toLowerCase().contains("data retrieved") ||
        message.toLowerCase().contains("success");
    final displayMessage = isGenericMsg
        ? 'upgrade_membership_to_view_profile'.tr
        : message;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/home');
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildUserAvatar(data, isDark, profile: profile),
                      const Gap(24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'membership_required'.tr,
                          style: const TextStyle(
                            color: Color(0xFFE65100),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        displayTitle,
                        textAlign: TextAlign.center,
                        style: AppFont.font(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        displayMessage,
                        textAlign: TextAlign.center,
                        style: AppFont.font(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.65,
                          ),
                          height: 1.5,
                        ),
                      ),
                      const Gap(36),
                      GestureDetector(
                        onTap: () => AppRoutes.openPlans(context),
                        child: Container(
                          width: 240,
                          height: 54,
                          decoration: BoxDecoration(
                            gradient:
                                ref.watch(appConfigProvider).primaryGradient,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    theme.primaryColor.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'upgrade_membership_plan'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
