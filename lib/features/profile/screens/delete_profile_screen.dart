import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import '../../auth/data/repositories/auth_repository.dart';
import '../../auth/screens/intro_screen.dart';
import '../../profile/data/repositories/profile_repository.dart';
import '../../home/providers/dashboard_notifier.dart';

class DeleteProfileScreen extends ConsumerStatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  ConsumerState<DeleteProfileScreen> createState() =>
      _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends ConsumerState<DeleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonCtrl = TextEditingController();

  bool _understandPermanently = false;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _reasonCtrl.addListener(() {
      setState(() {
        _charCount = _reasonCtrl.text.length;
      });
    });
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  Future<void> _deleteProfile() async {
    if (_reasonCtrl.text.trim().length < 20) {
      showToast('reason_min_length_error'.tr);
      return;
    }
    if (!_understandPermanently) {
      showToast('confirm_condition_to_proceed'.tr);
      return;
    }

    hideKeyboard(context);
    showLoading(context);

    try {
      final params = {"reason": _reasonCtrl.text.trim()};
      await ref.read(profileRepositoryProvider).requestDeleteProfile(params);

      // Perform logout
      await ref.read(authRepositoryProvider).logout();

      // Refresh firebase token
      await _refreshFirebaseToken();

      // Clear session and navigate to intro
      await AppSessionService.clear();
      hideLoading();

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const IntroScreen()),
          (_) => false,
        );
      }
    } catch (e) {
      hideLoading();
      showToast('something_went_wrong'.tr);
      printLog('DELETE_PROFILE_ERROR: $e');
    }
  }

  Future<void> _refreshFirebaseToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        AppSessionService.setValue(SessionDetail.kFcmToken, token);
        printLog('Firebase token refreshed: $token');
      }
    } catch (e) {
      printLog('Firebase token refresh error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canSubmit = _understandPermanently && _charCount >= 20;

    // Retrieve counts dynamically from the dashboard provider
    final dashboardState = ref.watch(dashboardProvider);
    final dashboardData = dashboardState.value;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0C0D16)
          : const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar Header
            AppAppBar(title: 'delete_profile'.tr, isShowActions: false),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Sad to see you go - Figma Custom Container Card
                      _buildSadBannerCard(),
                      const Gap(24),

                      // 2. You'll lose access to card enclosing section title and grids
                      _buildLossAccessCard(isDark, dashboardData),
                      const Gap(24),

                      // 3. Tell us why you're leaving section
                      _buildSectionTitle(
                        svgAssetPath: AppAssets.deleteProfileMessage,
                        iconColor: Theme.of(context).primaryColor,
                        title: "tell_us_why_leaving".tr,
                        subtitle: "feedback_helps_improve".tr,
                        isDark: isDark,
                      ),
                      const Gap(12),
                      _buildFeedbackCard(isDark),
                      const Gap(24),

                      // 4. Confirm your decision section
                      _buildSectionTitle(
                        svgAssetPath: AppAssets.deleteProfileShield,
                        iconColor: Theme.of(context).primaryColor,
                        title: "confirm_your_decision".tr,
                        subtitle: "please_review_before_proceeding".tr,
                        isDark: isDark,
                      ),
                      const Gap(12),
                      _buildConfirmCheckboxesCard(isDark),
                      const Gap(32),

                      // 5. Actions Row (Cancel / Delete)
                      _buildActionsRow(canSubmit, isDark),
                      const Gap(30),
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

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFFF1F3F9),
                  width: 1.2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
              ),
            ),
          ),
          const Gap(14),
          // Title (Left aligned)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildAppTitleWidget(context, "delete_profile".tr),
                const Gap(2),
                Text(
                  "request_to_admin".tr,
                  style: AppFont.font(
                    fontSize: 12,
                    color: isDark
                        ? Colors.grey.shade400
                        : const Color(0xFF6E7890),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSadBannerCard() {
    return Container(
      width: double.infinity,
      height: 192.19,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withValues(alpha: 0.25),
            blurRadius: 38,
            offset: const Offset(0, 20),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Centered SVG delete container icon
          SvgPicture.asset(
            AppAssets.deleteProfileContainer,
            width: 70,
            height: 70,
          ),
          const Gap(16),
          Text(
            "sad_to_see_you_go".tr,
            style: AppFont.font(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "permanently_delete_warning".tr,
              textAlign: TextAlign.center,
              style: AppFont.font(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.8),
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle({
    required String svgAssetPath,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(7),
          child: Center(
            child: SvgPicture.asset(
              svgAssetPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (subtitle != null) ...[
                const Gap(2),
                Text(
                  subtitle,
                  style: AppFont.font(
                    fontSize: 11,
                    color: isDark
                        ? Colors.grey.shade400
                        : const Color(0xFF6E7890),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLossAccessCard(bool isDark, var dashboardData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFF1F5F9),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            svgAssetPath: AppAssets.deleteProfileWarning,
            iconColor: const Color(0xFFEF4444),
            title: "you_will_lose_access_to".tr,
            isDark: isDark,
          ),
          const Gap(16),
          _buildLossAccessGrid(isDark, dashboardData),
        ],
      ),
    );
  }

  Widget _buildLossAccessGrid(bool isDark, var dashboardData) {
    final items = [
      _LossItem(
        AppAssets.deleteProfileMatches,
        "${dashboardData?.matchesCount ?? 0} ${'matches_lbl'.tr}",
        "all_connections".tr,
      ),
      _LossItem(
        AppAssets.deleteProfileChat,
        "${dashboardData?.chatCount ?? 0} ${'chats_lbl'.tr}",
        "message_history".tr,
      ),
      _LossItem(
        AppAssets.deleteProfilePhotos,
        "${dashboardData?.photosCount ?? 0} ${'photos_and_media'.tr}",
        "gallery_and_uploads".tr,
      ),
      _LossItem(
        AppAssets.deleteProfilePremium,
        (ApplicationData.isMemberPaid == true) ? "active_lbl".tr : "free_lbl".tr == "free_lbl" ? "Free" : "free_lbl".tr,
        "active_plan".tr,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFEF4444).withValues(alpha: 0.04),
                const Color(0xFFEF4444).withValues(alpha: 0.02),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFEF4444).withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    item.svgPath,
                    width: 14,
                    height: 14,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFEF4444),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    Text(
                      item.subtitle,
                      style: AppFont.font(
                        fontSize: 9,
                        color: const Color(0xFF6E7890),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeedbackCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFF1F5F9),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.deleteProfileEdit,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                  width: 14,
                  height: 14,
                ),
                const Gap(6),
                Text(
                  "enter_your_reason".tr,
                  style: AppFont.font(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.star_rounded, color: Colors.red, size: 10),
              ],
            ),
          ),
          // TextFormField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _reasonCtrl,
              maxLines: 4,
              maxLength: 500,
              buildCounter:
                  (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => null,
              style: AppFont.font(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText:
                    "delete_reason_hint".tr,
                hintStyle: AppFont.font(
                  fontSize: 13,
                  color: const Color(0xFF94A3B8),
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          // Footer
          Container(
            height: 1,
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : const Color(0xFFF1F5F9),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 12,
                    ),
                    const Gap(4),
                    Text(
                      "min_20_chars_required".tr,
                      style: AppFont.font(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$_charCount / 500",
                  style: AppFont.font(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6E7890),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmCheckboxesCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFF1F5F9),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Checkbox 1
          InkWell(
            onTap: () {
              setState(() {
                _understandPermanently = !_understandPermanently;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomCheckIcon(_understandPermanently),
                const Gap(12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppFont.font(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(
                          text: "understand_permanently_deleted".tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCheckIcon(bool checked) {
    if (checked) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.check, color: Colors.white, size: 12),
        ),
      );
    } else {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
        ),
      );
    }
  }

  Widget _buildActionsRow(bool canSubmit, bool isDark) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2030) : Colors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : const Color(0xFFE2E8F0),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.deleteProfileCancel,
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white : const Color(0xFF1E293B),
                      BlendMode.srcIn,
                    ),
                    width: 18,
                    height: 18,
                  ),
                  const Gap(8),
                  Text(
                    "btn_cancel".tr,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(12),
        // Request Delete Button
        Expanded(
          child: InkWell(
            onTap: canSubmit ? _deleteProfile : null,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: canSubmit
                    ? const LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
                color: canSubmit
                    ? null
                    : (isDark
                          ? const Color(0xFF1E2030)
                          : const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(26),
                boxShadow: canSubmit
                    ? [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
                border: canSubmit
                    ? null
                    : Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.transparent,
                        width: 1.2,
                      ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.deleteProfileConfirmAction,
                    colorFilter: ColorFilter.mode(
                      canSubmit ? Colors.white : const Color(0xFF94A3B8),
                      BlendMode.srcIn,
                    ),
                    width: 18,
                    height: 18,
                  ),
                  const Gap(8),
                  Text(
                    "request_delete".tr,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: canSubmit ? Colors.white : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LossItem {
  final String svgPath;
  final String title;
  final String subtitle;

  _LossItem(this.svgPath, this.title, this.subtitle);
}
