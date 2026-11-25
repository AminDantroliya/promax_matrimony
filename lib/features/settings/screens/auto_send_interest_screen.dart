import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/glassmorphic_background.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../data/models/ai_interest_models.dart';
import '../providers/ai_interest_notifier.dart';
import '../../home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';

import 'package:pro_matrimony/widgets/app_app_bar.dart';

class AutoSendInterestScreen extends ConsumerStatefulWidget {
  const AutoSendInterestScreen({super.key});

  @override
  ConsumerState<AutoSendInterestScreen> createState() =>
      _AutoSendInterestScreenState();
}

class _AutoSendInterestScreenState
    extends ConsumerState<AutoSendInterestScreen> {
  static const List<int> _limitOptions = [1, 2, 3, 4, 5];

  List<String> get _aiRules => [
    'rule_not_already_sent'.tr,
    'rule_within_daily_limit'.tr,
    'rule_not_blocked_hidden'.tr,
    'rule_respects_plan_limits'.tr,
    'rule_matches_preferences'.tr,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final allowed = await checkAiInterestPermission(context, ref);
      if (!allowed && mounted) {
        Navigator.pop(context);
        return;
      }
      ref.read(aiInterestProvider.notifier).fetchTodayList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final aiState = ref.watch(aiInterestProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassmorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppAppBar(
                title: 'auto_send_interest'.tr,
                isShowActions: true,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                  children: [
                    _buildHeroBanner(isDark),
                    const Gap(20),
                    _buildAutoSendToggleCard(isDark, aiState),
                    const Gap(24),
                    _buildDailyLimitSection(isDark, aiState),
                    const Gap(24),
                    _buildAiRulesSection(isDark),
                    const Gap(24),
                    _buildTodaysSelectionSection(isDark, aiState),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(isDark, aiState),
    );
  }

  // ─── Hero Banner ──────────────────────────────────────────────────────────

  Widget _buildHeroBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: FigmaColors.primaryGradient(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.figmaAiFilter,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'let_ai_do_magic'.tr,
                  style: AppFont.font(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Text(
                  'hero_auto_send_desc'.tr,
                  style: AppFont.font(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Auto Send Toggle ─────────────────────────────────────────────────────

  Widget _buildAutoSendToggleCard(bool isDark, AiInterestState aiState) {
    return _card(
      isDark: isDark,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFFF3EEF7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaAiFilter,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const Gap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'auto_send_interest_ai'.tr,
                      style: AppFont.font(
                        color: isDark ? Colors.white : premiumDarkText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      'ai_sends_daily_top_matches'.tr,
                      style: AppFont.font(
                        color: isDark ? Colors.white38 : premiumSubtitle,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => ref
                    .read(aiInterestProvider.notifier)
                    .setAutoSend(!aiState.autoSendEnabled),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 52,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: aiState.autoSendEnabled
                        ? FigmaColors.primaryGradient(context)
                        : null,
                    color: aiState.autoSendEnabled
                        ? null
                        : (isDark
                            ? Colors.white12
                            : const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        left: aiState.autoSendEnabled ? 26 : 2,
                        top: 2,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.8),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    'auto_send_switch_info'.tr,
                    style: AppFont.font(
                      color: isDark ? Colors.white60 : premiumSubtitle,
                      fontSize: 12,
                      height: 1.4,
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

  // ─── Daily Limit & Compatibility ─────────────────────────────────────────

  Widget _buildDailyLimitSection(bool isDark, AiInterestState aiState) {
    return _card(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFFF3EEF7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaFilterSettings,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'daily_limit_compatibility'.tr,
                    style: AppFont.font(
                      color: isDark ? Colors.white : premiumDarkText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'fine_tune_ai_behavior'.tr,
                    style: AppFont.font(
                      color: isDark ? Colors.white38 : premiumSubtitle,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(24),
          // Daily Limit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'daily_interest_limit_caps'.tr,
                style: AppFont.font(
                  color: isDark ? Colors.white54 : premiumSubtitle,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                '${aiState.dailyLimit}/${'days_lbl'.tr}',
                style: AppFont.font(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              ..._limitOptions.map((limit) {
                final isSelected = limit == aiState.dailyLimit;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => ref
                        .read(aiInterestProvider.notifier)
                        .setDailyLimit(limit),
                    child: Container(
                      height: 44,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : const Color(0xFFF3F4F6)),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: Theme.of(context).primaryColor, width: 1.5)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '$limit',
                          style: AppFont.font(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : (isDark ? Colors.white60 : premiumSubtitle),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              const Icon(
                Icons.shield_outlined,
                size: 14,
                color: Color(0xFF22C55E),
              ),
              const Gap(6),
              Text(
                'ai_never_exceed_limit'.tr,
                style: AppFont.font(
                  color: isDark ? Colors.white38 : premiumSubtitle,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Gap(24),
          // Min Compatibility Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'min_compatibility_score_caps'.tr,
                style: AppFont.font(
                  color: isDark ? Colors.white54 : premiumSubtitle,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                '${aiState.minMatchPercentage}%',
                style: AppFont.font(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Gap(12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 4,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor:
                  isDark ? Colors.white10 : const Color(0xFFE5E7EB),
              thumbColor: Colors.white,
              overlayColor: Theme.of(context).primaryColor.withValues(alpha: 0.12),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: aiState.minMatchPercentage.toDouble(),
              min: 0,
              max: 100,
              divisions: 20,
              onChanged: (v) => ref
                  .read(aiInterestProvider.notifier)
                  .setMinMatchPercentage(v.round()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0%', style: _axisLabel(isDark)),
                Text('50%', style: _axisLabel(isDark)),
                Text('100%', style: _axisLabel(isDark)),
              ],
            ),
          ),
          const Gap(10),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.figmaCompatibilityScore,
                width: 14,
                height: 14,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(6),
              Text(
                'ai_profiles_above_score'.tr,
                style: AppFont.font(
                  color: isDark ? Colors.white38 : premiumSubtitle,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _axisLabel(bool isDark) => AppFont.font(
        color: isDark ? Colors.white30 : premiumSubtitle,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      );

  // ─── AI Rules ─────────────────────────────────────────────────────────────

  Widget _buildAiRulesSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFF3EEF7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaRulesTitle,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ai_rules_before_sending'.tr,
                  style: AppFont.font(
                    color: isDark ? Colors.white : premiumDarkText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'smart_filters_always_apply'.tr,
                  style: AppFont.font(
                    color: isDark ? Colors.white38 : premiumSubtitle,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(12),
        Column(
          children: _aiRules.map((rule) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF3FAF6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFFE1F5E9), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 4),
                    child: SvgPicture.asset(
                      AppAssets.figmaDoubleCorrectCircle,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      rule,
                      style: AppFont.font(
                        color: const Color(0xFF1E3A1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ─── Today's AI Selection ─────────────────────────────────────────────────

  Widget _buildTodaysSelectionSection(bool isDark, AiInterestState aiState) {
    final matches = aiState.todayMatches ?? [];
    final count = matches.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFF3EEF7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaAiFilter,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'todays_ai_selection'.tr,
                  style: AppFont.font(
                    color: isDark ? Colors.white : premiumDarkText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  aiState.isLoadingList
                      ? 'loading_dots'.tr
                      : 'profiles_handpicked_for_you'.trParams({'count': count.toString()}),
                  style: AppFont.font(
                    color: isDark ? Colors.white38 : premiumSubtitle,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(12),
        _card(
          isDark: isDark,
          child: Column(
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : const Color(0xFFF3EEF7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.figmaSendInterest,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'selected_matches'.tr,
                        style: AppFont.font(
                          color: isDark ? Colors.white : premiumDarkText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF2E7D32),
                          size: 12,
                        ),
                        const Gap(4),
                        Text(
                          'ready_lbl'.tr,
                          style: AppFont.font(
                            color: const Color(0xFF2E7D32),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(16),
              // Profile cards
              if (aiState.isLoadingList)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (matches.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'no_profiles_selected_today'.tr,
                      style: AppFont.font(
                        color: isDark ? Colors.white38 : premiumSubtitle,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: matches.take(3).map((match) {
                    return Expanded(
                      child: _buildProfileCard(
                        match: match,
                        isDark: isDark,
                      ),
                    );
                  }).toList(),
                ),
              const Gap(16),
              // Footer info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.figmaElectricity,
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        'ai_will_send_interests_today'.tr,
                        style: AppFont.font(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    required AiInterestMatch match,
    required bool isDark,
  }) {
    final name = match.profileTitle ??
        match.matchedMember?['matri_id']?.toString() ??
        'profile_lbl'.tr;
    final score = match.score != null ? '${match.score}%' : '--';
    final memberId = match.matchedMemberId?.toString() ?? '';
    final imageUrl = match.profileImage;

    return GestureDetector(
      onTap: () {
        if (memberId.isNotEmpty) context.push('/profile-other/$memberId');
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 20),
            decoration: BoxDecoration(
              color:
                  isDark ? const Color(0xFF1E1F2A) : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFECEFF1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: getImageWidget(
                        url: imageUrl, boxFit: BoxFit.cover),
                  ),
                ),
                const Gap(8),
                Text(
                  name,
                  style: AppFont.font(
                    color: isDark ? Colors.white : premiumDarkText,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                score,
                style: AppFont.font(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Bottom Bar ───────────────────────────────────────────────────────────

  Widget _buildBottomActionBar(bool isDark, AiInterestState aiState) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0C0D16) : const Color(0xFFF5F7FC),
      ),
      child: Row(
        children: [
          // Reset button
          GestureDetector(
            onTap: () =>
                ref.read(aiInterestProvider.notifier).reset(),
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: isDark ? 0.3 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaRefresh,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white70 : Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const Gap(12),
          // Save button
          Expanded(
            child: GestureDetector(
              onTap: aiState.isSaving
                  ? null
                  : () async {
                      final success = await ref
                          .read(aiInterestProvider.notifier)
                          .saveSettings();
                      if (mounted) {
                        if (success) {
                          // Refresh dashboard so next open seeds updated values
                          ref.read(dashboardProvider.notifier).refresh();
                          showToast('settings_saved_successfully'.tr);
                          Navigator.pop(context);
                        } else {
                          showToast('failed_to_save_settings'.tr);
                        }
                      }
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 54,
                decoration: BoxDecoration(
                  gradient: aiState.isSaving
                      ? null
                      : FigmaColors.primaryGradient(context),
                  color: aiState.isSaving
                      ? (isDark
                          ? Colors.white24
                          : const Color(0xFFD0D0D0))
                      : null,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: aiState.isSaving
                      ? []
                      : [
                          BoxShadow(
                            color: const Color(0xFF7342EB)
                                .withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                ),
                child: Center(
                  child: aiState.isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.figmaSave,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'save_settings'.tr,
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Widget _card({
    required bool isDark,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13141F) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFF0F0F5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
