import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/plan/providers/plan_notifier.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/invoice_download_button.dart';
import 'plans_screen.dart';
import 'addon_plan_screen.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;

  const DashedDivider({
    super.key,
    this.height = 1.0,
    this.color = Colors.grey,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashGap)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}

class CurrentPlanScreen extends ConsumerWidget {
  final bool fromCheckout;
  const CurrentPlanScreen({super.key, this.fromCheckout = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(myProfileProvider);
    final currentPlanAsync = ref.watch(currentPlanProvider);
    final addonPackagesAsync = ref.watch(addonPackageListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final canPopRoute = Navigator.canPop(context);
    final hasAddons = addonPackagesAsync.value?.isNotEmpty ?? false;

    return PopScope(
      canPop: !fromCheckout && canPopRoute,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go('/home');
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
          bottomNavigationBar: hasAddons ? _buildStickyAddonButton(context, isDark) : null,
          body: Stack(
            children: [
              // Premium Gradient Header Background
              Container(
                height: 245,
                decoration: BoxDecoration(
                  gradient: FigmaColors.primaryGradient(context),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              // Header Content & Scrollable View
              SafeArea(
                child: Column(
                  children: [
                    // Premium App Bar Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          _buildHeaderButton(
                            context,
                            icon: Icons.arrow_back,
                            onTap: () {
                              if (fromCheckout || !Navigator.canPop(context)) {
                                context.go('/home');
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          const Gap(14),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _buildSplitHeaderTitle(
                                context,
                                'current_membership'.tr,
                              ),
                            ),
                          ),
                          const Gap(10),
                          _buildHeaderButton(
                            context,
                            icon: Icons.calendar_month_outlined,
                            onTap: () => context.push('/plan-history'),
                          ),
                        ],
                      ),
                    ),
                    // Content area
                    Expanded(
                      child: currentPlanAsync.when(
                        data: (data) => data == null
                            ? Center(child: Text('no_current_plan_found'.tr))
                            : _buildContent(context, ref, data, isDark),
                        loading: () => const Center(child: AppLoadingWidget()),
                        error: (err, stack) =>
                            Center(child: Text("Error: $err")),
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

  Widget _buildStickyAddonButton(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13141F) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddonPlanScreen()),
          );
        },
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            gradient: FigmaColors.primaryGradient(context),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.30),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              const Gap(16),
              const Icon(
                Icons.extension_rounded,
                color: Colors.white,
                size: 20,
              ),
              const Gap(10),
              Text(
                'buy_addon_plan'.tr,
                style: AppFont.font(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const Gap(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSplitHeaderTitle(BuildContext context, String text) {
    return buildAppTitleWidget(
      context,
      text,
      primaryColor: Colors.white,
      secondaryColor: Colors.white,
    );
  }

  Widget _buildHeaderButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    dynamic data,
    bool isDark,
  ) {
    final plan = data.currentPlanArr;

    // Remaining Calculation logic
    int connectTotal = 0;
    int connectUsed = 0;
    if (plan?.interestsTotal != null) {
      connectTotal = int.tryParse(plan.interestsTotal.toString()) ?? 0;
      connectUsed = int.tryParse(plan.interestsUsed?.toString() ?? "0") ?? 0;
    } else {
      connectTotal = int.tryParse(plan?.planTotalInterest ?? "0") ?? 0;
      connectUsed = int.tryParse(plan?.interestUsed?.toString() ?? "0") ?? 0;
    }
    int remainingConnect = connectTotal - connectUsed;
    if (remainingConnect < 0) remainingConnect = 0;

    int contactsTotal = 0;
    int contactsUsed = 0;
    if (plan?.contactViewsTotal != null) {
      contactsTotal = int.tryParse(plan.contactViewsTotal.toString()) ?? 0;
      contactsUsed =
          int.tryParse(plan.contactViewsUsed?.toString() ?? "0") ?? 0;
    } else {
      contactsTotal = int.tryParse(plan?.planViewContact ?? "0") ?? 0;
      contactsUsed =
          int.tryParse(plan?.viewContactsUsed?.toString() ?? "0") ?? 0;
    }
    int remainingContacts = contactsTotal - contactsUsed;
    if (remainingContacts < 0) remainingContacts = 0;

    int viewProfileTotal = 0;
    int viewProfileUsed = 0;
    if (plan?.viewProfileTotal != null) {
      viewProfileTotal = int.tryParse(plan.viewProfileTotal.toString()) ?? 0;
      viewProfileUsed =
          int.tryParse(plan.viewProfileUsed?.toString() ?? "0") ?? 0;
    } else if (plan?.planViewProfile != null) {
      viewProfileTotal = int.tryParse(plan.planViewProfile.toString()) ?? 0;
      viewProfileUsed = 0;
    }
    int remainingViewProfiles = viewProfileTotal - viewProfileUsed;
    if (remainingViewProfiles < 0) remainingViewProfiles = 0;

    int videoTotal = 0;
    int videoUsed = 0;
    if (plan?.videoMinutesTotal != null) {
      videoTotal = int.tryParse(plan.videoMinutesTotal.toString()) ?? 0;
      videoUsed = int.tryParse(plan.videoMinutesUsed?.toString() ?? "0") ?? 0;
    } else {
      final parts = (plan?.planVideoCallRemaining ?? "0 / 0").split('/');
      if (parts.length == 2) {
        final rem = int.tryParse(parts[0].trim()) ?? 0;
        final tot = int.tryParse(parts[1].trim()) ?? 0;
        videoTotal = tot;
        videoUsed = tot - rem;
      }
    }
    int remainingVideo = videoTotal - videoUsed;
    if (remainingVideo < 0) remainingVideo = 0;

    int audioTotal = 0;
    int audioUsed = 0;
    if (plan?.audioMinutesTotal != null) {
      audioTotal = int.tryParse(plan.audioMinutesTotal.toString()) ?? 0;
      audioUsed = int.tryParse(plan.audioMinutesUsed?.toString() ?? "0") ?? 0;
    } else {
      final parts = (plan?.planAudioCallRemaining ?? "0 / 0").split('/');
      if (parts.length == 2) {
        final rem = int.tryParse(parts[0].trim()) ?? 0;
        final tot = int.tryParse(parts[1].trim()) ?? 0;
        audioTotal = tot;
        audioUsed = tot - rem;
      }
    }
    int remainingAudio = audioTotal - audioUsed;
    if (remainingAudio < 0) remainingAudio = 0;

    String allowedChat = "no".tr;
    if (plan?.canChat != null) {
      allowedChat =
          (plan.canChat == true ||
              plan.canChat == 1 ||
              plan.canChat.toString() == "true")
          ? "yes".tr
          : "no".tr;
    } else {
      allowedChat = plan?.chat ?? "no".tr;
    }

    String allowedAiInterest = "no".tr;
    if (plan?.aiInterest != null) {
      allowedAiInterest =
          (plan!.aiInterest == true ||
              plan.aiInterest == 1 ||
              plan.aiInterest.toString() == "1" ||
              plan.aiInterest.toString().toLowerCase() == "yes")
          ? "yes".tr
          : "no".tr;
    }

    final bool isAiMatchmakingEnabled =
        ref.watch(featureProvider('enableAiMatchmaking'));
    final bool enableVideoCall = ref.watch(featureProvider('enableVideoCall'));
    final bool enableVoiceCall = ref.watch(featureProvider('enableVoiceCall'));
    final bool hasPlanDescription = plan?.planDescription != null &&
        plan!.planDescription!.trim().isNotEmpty;

    final String activeDate =
        plan?.planActivateDate ?? plan?.planActivated ?? "";
    final String expiryDate = plan?.planExpiryDate ?? plan?.planExpired ?? "";
    final String currencyStr = plan?.currencyCode ?? plan?.planCurrency ?? "₹";

    // Validity Calculation
    final start = _parseDate(activeDate);
    final expiry = _parseDate(expiryDate);

    int totalDays = 0;
    int remainingDays = 0;
    double validityProgress = 0.0;

    if (start != null && expiry != null) {
      totalDays = expiry.difference(start).inDays;
      if (totalDays < 0) totalDays = 0;

      final now = DateTime.now();
      final todayDate = DateTime(now.year, now.month, now.day);
      final cleanExpiry = DateTime(expiry.year, expiry.month, expiry.day);

      remainingDays = cleanExpiry.difference(todayDate).inDays;
      if (remainingDays < 0) remainingDays = 0;

      if (totalDays > 0) {
        remainingDays = remainingDays.clamp(0, totalDays);
        validityProgress = remainingDays / totalDays;
      }
    } else {
      if (plan?.totalValidityDays != null) {
        totalDays = int.tryParse(plan.totalValidityDays.toString()) ?? 0;
        remainingDays = totalDays;
        validityProgress = 1.0;
      }
    }

    final String validityText = totalDays > 0
        ? "$remainingDays / $totalDays ${'days_left_lbl'.tr}"
        : "n_a".tr;

    final autoVal = plan?.autoRenewing;
    final bool isAutoRenewing =
        autoVal == 1 ||
        autoVal == "1" ||
        autoVal == true ||
        autoVal?.toString().toLowerCase() == "yes" ||
        autoVal?.toString().toLowerCase() == "true";

    final String expiryLabel = 'expire_on'.tr;
    final Color expiryTextColor = isAutoRenewing
        ? (isDark ? Colors.white70 : const Color(0xFF00903A))
        : (isDark ? Colors.white54 : Colors.red.shade500);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(currentPlanProvider);
        ref.invalidate(myProfileProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: 12,
        ),
        child: Column(
          children: [
            // Active Plan details card
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1F2E) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: FigmaColors.primaryGradient(context),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.figmaPremium,
                                width: 24,
                                height: 24,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -3,
                            right: -3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFA000), // Gold Star badge
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan?.planName ?? "n_a".tr,
                              style: AppFont.font(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const Gap(4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "$currencyStr${plan?.grandTotal ?? '0'} ",
                                    style: AppFont.font(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.white70
                                          : const Color(0xFF5A5A7A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Active badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              'active_plan_lbl'.tr,
                              style: const TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  DashedDivider(
                    color: isDark ? Colors.white24 : Colors.grey.shade200,
                    dashWidth: 4,
                    dashGap: 3,
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.figmaCalendar,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              isDark ? Colors.white54 : Colors.grey.shade400,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Gap(6),
                          Text(
                            'validity_lbl'.tr,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white54
                                  : Colors.grey.shade500,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        validityText,
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF16182F),
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: validityProgress,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : const Color(0xFFF1F4FA),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const Gap(14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${'started_dot'.tr} · ${getFormattedPlanDate(activeDate)}",
                          style: AppFont.font(
                            fontSize: 10.5,
                            color: isDark ? Colors.white54 : Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(6),
                      Flexible(
                        child: Text(
                          "$expiryLabel · ${getFormattedPlanDate(expiryDate)}",
                          textAlign: TextAlign.end,
                          style: AppFont.font(
                            fontSize: 10.5,
                            color: expiryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Included benefits card
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1F2E) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : const Color(0xFFF5F6FA),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          AppAssets.figmaMembership,
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.white70 : const Color(0xFF4A5568),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'what_included'.tr,
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const Gap(15),
                  Divider(
                    height: 1,
                    color: isDark ? Colors.white12 : Colors.grey.shade200,
                  ),
                  const Gap(8),
                  _benefitRow(
                    context,
                    'Allowed_Connect'.tr,
                    AppAssets.figmaConnect,
                    remaining: remainingConnect,
                    total: connectTotal,
                    isDark: isDark,
                  ),
                  _benefitRow(
                    context,
                    'allowed_view_profiles'.tr,
                    AppAssets.figmaViewedProfile,
                    remaining: remainingViewProfiles,
                    total: viewProfileTotal,
                    isDark: isDark,
                  ),
                  _benefitRow(
                    context,
                    'Allowed_Contacts'.tr,
                    AppAssets.figmaVoiceCall,
                    remaining: remainingContacts,
                    total: contactsTotal,
                    isDark: isDark,
                  ),
                  if (enableVideoCall)
                    _benefitRow(
                      context,
                      'video_call'.tr,
                      AppAssets.figmaVideoCall,
                      remaining: remainingVideo,
                      total: videoTotal,
                      unit: 'mins_lbl'.tr,
                      isDark: isDark,
                    ),
                  if (enableVoiceCall)
                    _benefitRow(
                      context,
                      'voice_call'.tr,
                      AppAssets.figmaVoiceCall,
                      remaining: remainingAudio,
                      total: audioTotal,
                      unit: 'mins_lbl'.tr,
                      isDark: isDark,
                    ),
                  _benefitRow(
                    context,
                    'live_chat'.tr,
                    AppAssets.figmaChat,
                    chatValue: allowedChat,
                    isDark: isDark,
                    isLast: !isAiMatchmakingEnabled && !hasPlanDescription,
                  ),
                  if (isAiMatchmakingEnabled)
                    _benefitRow(
                      context,
                      'allowed_auto_ai_interest'.tr,
                      AppAssets.icDashboardAiCompatibility,
                      chatValue: allowedAiInterest,
                      isDark: isDark,
                      isLast: !hasPlanDescription,
                    ),
                  if (hasPlanDescription) ...[
                    const Gap(8),
                    Divider(
                      height: 1,
                      color: isDark ? Colors.white12 : Colors.grey.shade200,
                    ),
                    const Gap(12),
                    Text(
                      'plan_description_lbl'.tr,
                      style: AppFont.font(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      plan!.planDescription!,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Billing summary card
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1F2E) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : const Color(0xFFF5F6FA),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          AppAssets.figmaDocument,
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.white70 : const Color(0xFF4A5568),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'billing_summary_lbl'.tr,
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const Gap(15),
                  Divider(
                    height: 1,
                    color: isDark ? Colors.white12 : Colors.grey.shade200,
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount'.tr,
                        style: AppFont.font(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        "$currencyStr ${plan?.discountAmount ?? "0"}",
                        style: AppFont.font(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand_Total'.tr,
                        style: AppFont.font(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        "$currencyStr ${plan?.grandTotal ?? "0"}",
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF16182F),
                        ),
                      ),
                    ],
                  ),
                  if (plan?.paymentMode != null &&
                      plan.paymentMode.toString().trim().isNotEmpty) ...[
                    const Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'payment_mode_lbl'.tr,
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white70
                                : Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          plan.paymentMode.toString().toUpperCase(),
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (plan?.downloadInvoice != null &&
                      plan!.downloadInvoice!.isNotEmpty) ...[
                    const Gap(16),
                    DashedDivider(
                      color: isDark ? Colors.white24 : Colors.grey.shade200,
                      dashWidth: 4,
                      dashGap: 3,
                    ),
                    const Gap(14),
                    InvoiceDownloadButton(
                      url: plan.downloadInvoice!,
                      invoiceId: plan.id?.toString() ?? "",
                    ),
                  ],
                ],
              ),
            ),

            // Add-on packages section
            if (data.addOnPlanArr?.isNotEmpty ?? false) ...[
              const Gap(24),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    "add_on_package".tr,
                    style: AppFont.font(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              ...data.addOnPlanArr!.map(
                (addOn) => _buildAddOnItem(
                  context,
                  addOn,
                  plan?.planCurrency ?? currencyStr,
                  isDark,
                ),
              ),
            ],

            // Upgrade banner at bottom
            const Gap(24),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PlansScreen()),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: FigmaColors.primaryGradient(context),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: Color(0xFFFFA000),
                        size: 24,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'btn_upgrade_now'.tr,
                            style: AppFont.font(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            enableVideoCall
                                ? 'unlock_unlimited_video'.tr
                                : 'unlock_unlimited_matches'.tr,
                            style: AppFont.font(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }

  DateTime? _parseDate(String dateStr) {
    if (dateStr == "0000-00-00" || dateStr.isEmpty || dateStr == "-") {
      return null;
    }
    try {
      return DateTime.tryParse(dateStr) ??
          DateFormat("yyyy-MM-dd").parse(dateStr);
    } catch (_) {
      try {
        return DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  Widget _benefitRow(
    BuildContext context,
    String label,
    String iconPath, {
    int? remaining,
    int? total,
    String? unit,
    String? chatValue,
    required bool isDark,
    bool isLast = false,
  }) {
    Widget valueWidget;
    if (chatValue != null) {
      final isNo = chatValue.trim().toLowerCase() == 'no';
      valueWidget = Text(
        chatValue,
        style: AppFont.font(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isNo
              ? (isDark ? Colors.white38 : Colors.grey.shade500)
              : (isDark ? Colors.white : const Color(0xFF16182F)),
        ),
      );
    } else {
      final rem = remaining ?? 0;
      final tot = total ?? 0;
      final unitSuffix = (unit != null && unit.isNotEmpty) ? " $unit" : "";
      valueWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$rem$unitSuffix ",
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF16182F),
                  ),
                ),
                TextSpan(
                  text: 'remaining_lbl'.tr,
                  style: AppFont.font(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),
          const Gap(2),
          Text(
            "${'out_of_total'.tr} $tot$unitSuffix ${'total_lbl'.tr}",
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black87,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white70 : const Color(0xFF4A5568),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  label,
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              valueWidget,
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: isDark ? Colors.white12 : Colors.grey.shade100,
          ),
      ],
    );
  }

  Widget _buildAddOnItem(
    BuildContext context,
    dynamic addOn,
    String? currency,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1F2E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(9),
                child: SvgPicture.asset(
                  AppAssets.figmaDiamonds,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white70 : const Color(0xFF4A5568),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  addOn.packageTitle ?? "n_a".tr,
                  style: AppFont.font(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Text(
                "${currency ?? ""} ${addOn.packageAmount ?? "0"}",
                style: AppFont.font(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF16182F),
                ),
              ),
            ],
          ),
          const Gap(14),
          Divider(
            height: 1,
            color: isDark ? Colors.white12 : Colors.grey.shade100,
          ),
          const Gap(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                addOn.packageCategory ?? "Validity Extension",
                style: AppFont.font(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
              ),
              Text(
                addOn.packageCount?.toString() ?? "0",
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          if (addOn.description != null &&
              addOn.description.toString().isNotEmpty) ...[
            const Gap(10),
            Text(
              addOn.description,
              style: AppFont.font(
                fontSize: 13,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.65),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
