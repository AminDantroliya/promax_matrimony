import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import '../../providers/privacy_settings_notifier.dart';

class PrivacySettingsDesign1 extends ConsumerStatefulWidget {
  final String? scrollToSection;

  const PrivacySettingsDesign1({
    super.key,
    this.scrollToSection,
  });

  @override
  ConsumerState<PrivacySettingsDesign1> createState() =>
      _PrivacySettingsDesign1State();
}

class _PrivacySettingsDesign1State
    extends ConsumerState<PrivacySettingsDesign1> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsAsync = ref.watch(privacySettingsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: settingsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text("failed_to_load_settings".tr)),
          data: (settings) {
            if (settings != null && !_isInitialized) {
              _selectedPhotoVisibility = settings.photoVisibility;
              _selectedContactVisibility = settings.contactVisibility;
              _selectedVideoCallSetting = settings.videoCallSetting;
              _selectedVoiceCallSetting = settings.voiceCallSetting;
              _isInitialized = true;
            }

            final photoCard = _buildSectionCard(
              key: _photoKey,
              isHighlighted: _highlightedSection == 'photo',
              title: 'photo_visibility_caps'.tr,
              subtitle: 'who_can_view_your_photos_sub'.tr,
              icon: Icons.image_rounded,
              iconColor: Theme.of(context).primaryColor,
              iconBgColor:
                  Theme.of(context).primaryColor.withValues(alpha: 0.12),
              isDark: isDark,
              children: [
                _buildOptionRowItem(
                  title: 'view_to_all'.tr,
                  subtitle: 'anyone_can_view_photos_sub'.tr,
                  isSelected: _selectedPhotoVisibility == 1,
                  onTap: () =>
                      setState(() => _selectedPhotoVisibility = 1),
                  isDark: isDark,
                ),
                _buildOptionRowItem(
                  title: 'only_premium_members'.tr,
                  subtitle: 'upgraded_users_can_see_photos_sub'.tr,
                  isSelected: _selectedPhotoVisibility == 2,
                  onTap: () =>
                      setState(() => _selectedPhotoVisibility = 2),
                  isDark: isDark,
                ),
                _buildOptionRowItem(
                  title: 'hide_from_all'.tr,
                  subtitle: 'photos_remain_private_sub'.tr,
                  isSelected: _selectedPhotoVisibility == 0,
                  onTap: () =>
                      setState(() => _selectedPhotoVisibility = 0),
                  isDark: isDark,
                ),
              ],
            );

            final contactCard = _buildSectionCard(
              key: _contactKey,
              isHighlighted: _highlightedSection == 'contact',
              title: 'contact_settings_caps'.tr,
              subtitle: 'who_can_see_contact_info_sub'.tr,
              icon: Icons.phone_rounded,
              iconColor: const Color(0xFFEC4899),
              iconBgColor: const Color(0xFFFCE7F3),
              isDark: isDark,
              children: [
                _buildOptionRowItem(
                  title: 'show_to_paid_members'.tr,
                  subtitle: 'only_premium_see_contact_sub'.tr,
                  isSelected: _selectedContactVisibility == 0,
                  onTap: () => setState(
                    () => _selectedContactVisibility = 0,
                  ),
                  isDark: isDark,
                ),
                _buildOptionRowItem(
                  title: 'accepted_interests_paid'.tr,
                  subtitle: 'approved_matches_premium_users_sub'.tr,
                  isSelected: _selectedContactVisibility == 1,
                  onTap: () => setState(
                    () => _selectedContactVisibility = 1,
                  ),
                  isDark: isDark,
                ),
              ],
            );

            final videoCard = _buildSectionCard(
              key: _videoKey,
              isHighlighted: _highlightedSection == 'video',
              title: 'video_call_settings_caps'.tr,
              subtitle: 'who_can_video_call_you_sub'.tr,
              icon: Icons.videocam_rounded,
              iconColor: const Color(0xFF10B981),
              iconBgColor: const Color(0xFFE2F9EE),
              isDark: isDark,
              children: [
                _buildOptionRowItem(
                  title: 'all_paid_members'.tr,
                  subtitle: 'only_premium_video_call_sub'.tr,
                  isSelected: _selectedVideoCallSetting == 0,
                  onTap: () =>
                      setState(() => _selectedVideoCallSetting = 0),
                  isDark: isDark,
                ),
                _buildOptionRowItem(
                  title: 'accepted_interests_paid'.tr,
                  subtitle: 'approved_matches_premium_users_sub'.tr,
                  isSelected: _selectedVideoCallSetting == 1,
                  onTap: () =>
                      setState(() => _selectedVideoCallSetting = 1),
                  isDark: isDark,
                ),
              ],
            );

            final voiceCard = _buildSectionCard(
              key: _voiceKey,
              isHighlighted: _highlightedSection == 'voice',
              title: 'voice_call_settings_caps'.tr,
              subtitle: 'who_can_voice_call_you_sub'.tr,
              icon: Icons.mic_rounded,
              iconColor: const Color(0xFFF59E0B),
              iconBgColor: const Color(0xFFFEF3C7),
              isDark: isDark,
              children: [
                _buildOptionRowItem(
                  title: 'all_paid_members'.tr,
                  subtitle: 'only_premium_voice_call_sub'.tr,
                  isSelected: _selectedVoiceCallSetting == 0,
                  onTap: () =>
                      setState(() => _selectedVoiceCallSetting = 0),
                  isDark: isDark,
                ),
                _buildOptionRowItem(
                  title: 'accepted_interests_paid'.tr,
                  subtitle: 'approved_matches_premium_users_sub'.tr,
                  isSelected: _selectedVoiceCallSetting == 1,
                  onTap: () =>
                      setState(() => _selectedVoiceCallSetting = 1),
                  isDark: isDark,
                ),
              ],
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
                AppAppBar(
                  title: 'privacy_settings'.tr,
                  isShowActions: false,
                ),

                // Main scrollable settings content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...sections,
                        const Gap(24),
                      ],
                    ),
                  ),
                ),

                // Sticky Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: _buildSaveButton(
                    onPressed: () => _saveAllSettings(settings),
                    isDark: isDark,
                  ),
                ),
              ],
            );
          },
        ),
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
    required List<Widget> children,
    required bool isDark,
    bool isHighlighted = false,
  }) {
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131422) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHighlighted ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: isHighlighted ? 20 : 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFont.font(
                        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      subtitle,
                      style: AppFont.font(
                        color: isDark
                            ? Colors.white60
                            : const Color(0xFF7A7A9E),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F9EE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "ACTIVE",
                  style: AppFont.font(
                    color: const Color(0xFF10B981),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildOptionRowItem({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context)
                  .primaryColor
                  .withValues(alpha: isDark ? 0.2 : 0.08)
              : (isDark ? const Color(0xFF1A1B2E) : const Color(0xFFFAFAFC)),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : (isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF0F0F6)),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : (isDark ? Colors.white30 : const Color(0xFFDCDCE6)),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFont.font(
                      color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: AppFont.font(
                      color: isDark ? Colors.white60 : const Color(0xFF7A7A9E),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton({
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return FigmaPrimaryButton(
      text: 'save_changes'.tr,
      onPressed: onPressed,
      leadingIcon: const Icon(Icons.save_outlined, color: Colors.white, size: 20),
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
