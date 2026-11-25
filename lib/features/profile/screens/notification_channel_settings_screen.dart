import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import '../data/models/privacy_settings_models.dart';
import '../providers/privacy_settings_notifier.dart';

class NotificationChannelSettingsScreen extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final String templateType; // 'email' / 'notification' / 'sms'

  const NotificationChannelSettingsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.templateType,
  });

  @override
  ConsumerState<NotificationChannelSettingsScreen> createState() =>
      _NotificationChannelSettingsScreenState();
}

class _NotificationChannelSettingsScreenState
    extends ConsumerState<NotificationChannelSettingsScreen> {
  bool _isInitialized = false;
  
  // Track selected status dynamically
  late List<TemplateItem> _templates;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final settingsAsync = ref.watch(privacySettingsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: settingsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text("failed_to_load_settings".tr)),
          data: (settings) {
            if (settings != null && !_isInitialized) {
              // Extract target template list
              if (widget.templateType == 'email') {
                _templates = List.from(settings.emailTemplates);
              } else if (widget.templateType == 'sms') {
                _templates = List.from(settings.smsTemplates);
              } else {
                _templates = List.from(settings.notificationTemplates);
              }
              _isInitialized = true;
            }

            final isAllSelected = _templates.isNotEmpty && _templates.every((t) => t.selected);

            return Column(
              children: [
                AppAppBar(
                  title: widget.title.tr,
                  isShowActions: false,
                ),
                const Gap(10),

                // Select All Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF131422).withValues(alpha: 0.5) : const Color(0xFFF9F9FB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF0F0F6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'select_all_caps'.tr,
                          style: AppFont.font(
                            color: isDark ? Colors.white70 : const Color(0xFF1E1E2F),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Switch(
                          value: isAllSelected,
                          onChanged: (val) {
                            setState(() {
                              _templates = _templates.map((t) => t.copyWith(selected: val)).toList();
                            });
                          },
                          activeThumbColor: primaryColor,
                          activeTrackColor: primaryColor.withValues(alpha: 0.3),
                          inactiveThumbColor: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                          inactiveTrackColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                        ),
                      ],
                    ),
                  ),
                ),

                // List view of template options
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _templates.length,
                    itemBuilder: (context, index) {
                      final item = _templates[index];
                      return _buildTemplateRow(item, index, isDark);
                    },
                  ),
                ),

                // Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: _buildSaveButton(
                    onPressed: () => _saveAlertSettings(),
                    isDark: isDark,
                    primaryColor: primaryColor,
                    gradientStart: primaryColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTemplateRow(TemplateItem item, int index, bool isDark) {
    final primaryColor = Theme.of(context).primaryColor;

    // Elegant soft colors matching selected state
    final cardBg = item.selected
        ? (isDark ? const Color(0xFF1A1B30) : const Color(0xFFF6F5FF))
        : (isDark ? const Color(0xFF131422) : Colors.white);
        
    final textDark = isDark ? Colors.white : const Color(0xFF1E1E2F);
    
    // Icon mapping based on templateType
    IconData itemIcon = Icons.notifications_none_rounded;
    if (widget.templateType == 'email') {
      itemIcon = Icons.alternate_email_rounded;
    } else if (widget.templateType == 'sms') {
      itemIcon = Icons.chat_bubble_outline_rounded;
    } else {
      itemIcon = Icons.notifications_active_outlined;
    }

    final Color iconBgColor = isDark 
        ? primaryColor.withValues(alpha: 0.15) 
        : primaryColor.withValues(alpha: 0.08);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.selected
              ? primaryColor.withValues(alpha: 0.3)
              : (isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFE5E7EB)),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              itemIcon,
              color: primaryColor,
              size: 20,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Text(
              item.templateName,
              style: AppFont.font(
                color: textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: item.selected,
            onChanged: (val) {
              setState(() {
                _templates[index] = item.copyWith(selected: val);
              });
            },
            activeThumbColor: primaryColor,
            activeTrackColor: primaryColor.withValues(alpha: 0.3),
            inactiveThumbColor: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
            inactiveTrackColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          ),
        ],
      ),
    );
  }


  Widget _buildSaveButton({
    required VoidCallback onPressed,
    required bool isDark,
    required Color primaryColor,
    required Color gradientStart,
  }) {
    return FigmaPrimaryButton(
      text: 'save_changes'.tr,
      onPressed: onPressed,
      leadingIcon: const Icon(Icons.save_outlined, color: Colors.white, size: 20),
    );
  }

  Future<void> _saveAlertSettings() async {
    try {
      showLoading(context);

      final selectedIds = _templates
          .where((t) => t.selected)
          .map((t) => t.id)
          .toList();

      await ref.read(privacySettingsProvider.notifier).updateAlerts(
        widget.templateType,
        selectedIds,
      );

      hideLoading();
      showToast('settings_updated_success'.tr);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      hideLoading();
      showToast('failed_to_update_alert_settings'.tr);
    }
  }
}
