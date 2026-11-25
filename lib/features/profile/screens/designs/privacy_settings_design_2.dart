import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/features/notifications/providers/notification_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import '../../providers/privacy_settings_notifier.dart';

class PrivacySettingsDesign2 extends ConsumerStatefulWidget {
  final String? scrollToSection;

  const PrivacySettingsDesign2({
    super.key,
    this.scrollToSection,
  });

  @override
  ConsumerState<PrivacySettingsDesign2> createState() =>
      _PrivacySettingsDesign2State();
}

class _PrivacySettingsDesign2State
    extends ConsumerState<PrivacySettingsDesign2> {
  int? _selectedPhotoVisibility;
  int? _selectedContactVisibility;
  int? _selectedVideoCallSetting;
  int? _selectedVoiceCallSetting;
  bool _isInitialized = false;

  final GlobalKey _photoKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _videoKey = GlobalKey();
  final GlobalKey _voiceKey = GlobalKey();

  String? _highlightedSection;

  @override
  void initState() {
    super.initState();
    _highlightedSection = widget.scrollToSection;
    if (widget.scrollToSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(widget.scrollToSection!);
      });
    }
  }

  void _scrollToSection(String section) {
    GlobalKey? key;
    if (section == 'photo') {
      key = _photoKey;
    } else if (section == 'contact') {
      key = _contactKey;
    } else if (section == 'video') {
      key = _videoKey;
    } else if (section == 'voice') {
      key = _voiceKey;
    }

    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _highlightedSection = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(privacySettingsProvider);
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: settingsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text("failed_to_load_settings".tr)),
          data: (settings) {
            if (settings != null && !_isInitialized) {
              _selectedPhotoVisibility = settings.photoVisibility ?? 1;
              _selectedContactVisibility =
                  (settings.contactVisibility == 1) ? 1 : 0;
              _selectedVideoCallSetting = settings.videoCallSetting ?? 0;
              _selectedVoiceCallSetting = settings.voiceCallSetting ?? 0;
              _isInitialized = true;
            }

            final photoCard = _buildSectionCard(
              key: _photoKey,
              isHighlighted: _highlightedSection == 'photo',
              title: 'photo_visibility_caps'.tr == 'photo_visibility_caps'
                  ? 'Photo Visibility'
                  : 'photo_visibility_caps'.tr,
              subtitle: 'who_can_view_your_photos_sub'.tr ==
                      'who_can_view_your_photos_sub'
                  ? 'Who can view your photos'
                  : 'who_can_view_your_photos_sub'.tr,
              icon: Icons.image_rounded,
              iconColor: theme.primaryColor,
              iconBgColor: theme.primaryColor.withValues(alpha: 0.12),
              isDark: isDark,
              theme: theme,
              tiles: const [
                _TileOption(
                  label: 'EVERYONE',
                  icon: Icons.people_alt_rounded,
                  value: 1,
                  info: 'Anyone can view your profile photos when browsing matches.',
                ),
                _TileOption(
                  label: 'PREMIUM',
                  icon: Icons.workspace_premium_rounded,
                  value: 2,
                  info: 'Upgraded users can see your photos.',
                ),
                _TileOption(
                  label: 'HIDDEN',
                  icon: Icons.lock_rounded,
                  value: 0,
                  info: 'Your photos remain completely private and hidden from all.',
                ),
              ],
              selectedValue: _selectedPhotoVisibility ?? 1,
              onSelect: (val) => setState(() => _selectedPhotoVisibility = val),
            );

            final contactCard = _buildSectionCard(
              key: _contactKey,
              isHighlighted: _highlightedSection == 'contact',
              title: 'contact_settings_caps'.tr == 'contact_settings_caps'
                  ? 'Contact Details'
                  : 'contact_settings_caps'.tr,
              subtitle: 'who_can_see_contact_info_sub'.tr ==
                      'who_can_see_contact_info_sub'
                  ? 'Who can see your contact info'
                  : 'who_can_see_contact_info_sub'.tr,
              icon: Icons.phone_rounded,
              iconColor: const Color(0xFFFF7A00),
              iconBgColor: const Color(0xFFFFF2E8),
              isDark: isDark,
              theme: theme,
              tiles: const [
                _TileOption(
                  label: 'EVERYONE',
                  icon: Icons.people_alt_rounded,
                  value: 0,
                  info: 'All paid and upgraded members can view your contact.',
                ),
                _TileOption(
                  label: 'MATCHED',
                  icon: Icons.favorite_rounded,
                  value: 1,
                  info: 'Only accepted matches & premium members can see your contact.',
                ),
              ],
              selectedValue: _selectedContactVisibility ?? 0,
              onSelect: (val) => setState(() => _selectedContactVisibility = val),
            );

            final videoCard = _buildSectionCard(
              key: _videoKey,
              isHighlighted: _highlightedSection == 'video',
              title: 'video_call_settings_caps'.tr == 'video_call_settings_caps'
                  ? 'Video Call Settings'
                  : 'video_call_settings_caps'.tr,
              subtitle: 'who_can_video_call_you_sub'.tr ==
                      'who_can_video_call_you_sub'
                  ? 'Who can video call you directly'
                  : 'who_can_video_call_you_sub'.tr,
              icon: Icons.videocam_rounded,
              iconColor: const Color(0xFF7C3AED),
              iconBgColor: const Color(0xFFF3EEFF),
              isDark: isDark,
              theme: theme,
              tiles: const [
                _TileOption(
                  label: 'EVERYONE',
                  icon: Icons.people_alt_rounded,
                  value: 0,
                  info: 'All paid members can initiate video calls with you.',
                ),
                _TileOption(
                  label: 'MATCHED',
                  icon: Icons.favorite_rounded,
                  value: 1,
                  info: 'Only approved matches & premium users can video call with you.',
                ),
                _TileOption(
                  label: 'HIDDEN',
                  icon: Icons.lock_rounded,
                  value: 2,
                  info: 'Direct video calls are disabled.',
                ),
              ],
              selectedValue: _selectedVideoCallSetting ?? 0,
              onSelect: (val) => setState(() => _selectedVideoCallSetting = val),
            );

            final voiceCard = _buildSectionCard(
              key: _voiceKey,
              isHighlighted: _highlightedSection == 'voice',
              title: 'voice_call_settings_caps'.tr == 'voice_call_settings_caps'
                  ? 'Voice Call Settings'
                  : 'voice_call_settings_caps'.tr,
              subtitle: 'who_can_voice_call_you_sub'.tr ==
                      'who_can_voice_call_you_sub'
                  ? 'Who can voice call you directly'
                  : 'who_can_voice_call_you_sub'.tr,
              icon: Icons.mic_rounded,
              iconColor: const Color(0xFFF59E0B),
              iconBgColor: const Color(0xFFFEF3C7),
              isDark: isDark,
              theme: theme,
              tiles: const [
                _TileOption(
                  label: 'EVERYONE',
                  icon: Icons.people_alt_rounded,
                  value: 0,
                  info: 'All paid members can initiate voice calls with you.',
                ),
                _TileOption(
                  label: 'MATCHED',
                  icon: Icons.favorite_rounded,
                  value: 1,
                  info: 'Only approved matches & premium users can voice call with you.',
                ),
                _TileOption(
                  label: 'HIDDEN',
                  icon: Icons.lock_rounded,
                  value: 2,
                  info: 'Direct voice calls are disabled.',
                ),
              ],
              selectedValue: _selectedVoiceCallSetting ?? 0,
              onSelect: (val) => setState(() => _selectedVoiceCallSetting = val),
            );

            final enableVideoCall = ref.watch(featureProvider('enableVideoCall'));
            final enableVoiceCall = ref.watch(featureProvider('enableVoiceCall'));

            final List<Widget> sections = [];
            final List<Widget> defaultOrder = [
              photoCard,
              contactCard,
              if (enableVideoCall) videoCard,
              if (enableVoiceCall) voiceCard,
            ];

            if (widget.scrollToSection == 'photo') {
              sections.addAll([
                photoCard,
                contactCard,
                if (enableVideoCall) videoCard,
                if (enableVoiceCall) voiceCard,
              ]);
            } else if (widget.scrollToSection == 'contact') {
              sections.addAll([
                contactCard,
                photoCard,
                if (enableVideoCall) videoCard,
                if (enableVoiceCall) voiceCard,
              ]);
            } else if (widget.scrollToSection == 'video' && enableVideoCall) {
              sections.addAll([
                videoCard,
                photoCard,
                contactCard,
                if (enableVoiceCall) voiceCard,
              ]);
            } else if (widget.scrollToSection == 'voice' && enableVoiceCall) {
              sections.addAll([
                voiceCard,
                photoCard,
                contactCard,
                if (enableVideoCall) videoCard,
              ]);
            } else {
              sections.addAll(defaultOrder);
            }

            return Column(
              children: [
                // Custom Figma Top Header
                _buildFigmaHeader(context, isDark, theme, accentColor),

                // Main Scrollable Settings Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Column(
                      children: [
                        ...sections,
                        const Gap(16),
                      ],
                    ),
                  ),
                ),

                // Sticky Bottom Save Pill Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: _buildFigmaSavePillButton(
                    context: context,
                    theme: theme,
                    onPressed: () => _saveAllSettings(settings),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFigmaHeader(
    BuildContext context,
    bool isDark,
    ThemeData theme,
    Color accentColor,
  ) {
    final dashboardUnread =
        ref.watch(dashboardProvider).value?.unreadNotificationCount ?? 0;
    final notificationUnread = ref.watch(unreadNotificationCountProvider);
    final unreadCount =
        dashboardUnread > 0 ? dashboardUnread : notificationUnread;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left back arrow squircle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
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
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: accentColor,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          const Gap(14),
          // Title & Subtitle (Left aligned)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildAppTitleWidget(context, 'privacy_settings'.tr),
                const Gap(2),
                Text(
                  'Privacy Center',
                  style: AppFont.font(
                    fontSize: 12,
                    color: isDark
                        ? Colors.grey.shade400
                        : const Color(0xFF8F96AC),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),

          // Right Actions: Notification Bell + Settings Gear
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Notification Squircle
              GestureDetector(
                onTap: () => context.push('/notifications'),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.icAppbarNotifications,
                        colorFilter: ColorFilter.mode(
                          accentColor,
                          BlendMode.srcIn,
                        ),
                        width: 22,
                        height: 22,
                      ),
                      if (unreadCount > 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const Gap(8),

              // Settings Squircle
              GestureDetector(
                onTap: () => context.push('/settings'),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
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
                      Icons.settings_rounded,
                      color: accentColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    Key? key,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required bool isDark,
    required ThemeData theme,
    required List<_TileOption> tiles,
    required int selectedValue,
    required ValueChanged<int> onSelect,
    bool isHighlighted = false,
  }) {
    final activeTile = tiles.firstWhere(
      (t) => t.value == selectedValue,
      orElse: () => tiles.first,
    );

    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1B2E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHighlighted
              ? theme.primaryColor
              : (isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : const Color(0xFFF1F3F9)),
          width: isHighlighted ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? theme.primaryColor.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: isHighlighted ? 20 : 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Row
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDark ? iconColor.withValues(alpha: 0.15) : iconBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFont.font(
                        color: isDark ? Colors.white : const Color(0xFF16182F),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      subtitle,
                      style: AppFont.font(
                        color: isDark
                            ? Colors.white60
                            : const Color(0xFF8F96AC),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // ACTIVE Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF00B67A).withValues(alpha: 0.15)
                      : const Color(0xFFE6F9F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00B67A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "ACTIVE",
                      style: AppFont.font(
                        color: const Color(0xFF00B67A),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),

          // 3-Segment Button Tile Row
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131422) : const Color(0xFFF4F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: tiles.map((tile) {
                final isSelected = tile.value == selectedValue;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelect(tile.value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? FigmaColors.primaryGradient(context)
                            : null,
                        color: isSelected ? theme.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: theme.primaryColor.withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            tile.icon,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? Colors.white60 : const Color(0xFF6E7890)),
                            size: 18,
                          ),
                          const Gap(4),
                          Text(
                            tile.label,
                            style: AppFont.font(
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? Colors.white60 : const Color(0xFF6E7890)),
                              fontSize: 10.5,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Informational Helper Box below
          Container(
            margin: const EdgeInsets.only(top: 14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color:
                  theme.primaryColor.withValues(alpha: isDark ? 0.12 : 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    theme.primaryColor.withValues(alpha: isDark ? 0.2 : 0.25),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "i",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    activeTile.info,
                    style: AppFont.font(
                      color: isDark ? Colors.white70 : const Color(0xFF4B5563),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
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

  Widget _buildFigmaSavePillButton({
    required BuildContext context,
    required ThemeData theme,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.verified_user_rounded,
              color: Colors.white,
              size: 20,
            ),
            Text(
              'Save Privacy Settings',
              style: AppFont.font(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAllSettings(dynamic settings) async {
    if (settings == null) return;

    final hasPhotoChanged =
        _selectedPhotoVisibility != settings.photoVisibility;
    final hasContactChanged =
        _selectedContactVisibility != settings.contactVisibility;
    final hasVideoChanged =
        _selectedVideoCallSetting != settings.videoCallSetting;
    final hasVoiceChanged =
        _selectedVoiceCallSetting != settings.voiceCallSetting;

    if (!hasPhotoChanged &&
        !hasContactChanged &&
        !hasVideoChanged &&
        !hasVoiceChanged) {
      showToast('no_settings_changed'.tr);
      return;
    }

    try {
      showLoading(context);

      await ref.read(privacySettingsProvider.notifier).updateAllSettings(
            photoVisibility: _selectedPhotoVisibility ?? settings.photoVisibility ?? 0,
            contactVisibility: _selectedContactVisibility ?? settings.contactVisibility ?? 0,
            videoCallSetting: _selectedVideoCallSetting ?? settings.videoCallSetting ?? 0,
            voiceCallSetting: _selectedVoiceCallSetting ?? settings.voiceCallSetting ?? 0,
          );

      hideLoading();
      showToast('privacy_settings_updated_success'.tr);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      hideLoading();
      showToast('failed_to_update_settings'.tr);
    }
  }
}

class _TileOption {
  final String label;
  final IconData icon;
  final int value;
  final String info;

  const _TileOption({
    required this.label,
    required this.icon,
    required this.value,
    required this.info,
  });
}
