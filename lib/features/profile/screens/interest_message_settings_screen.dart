import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

import '../providers/privacy_settings_notifier.dart';

class InterestMessageSettingsScreen extends ConsumerStatefulWidget {
  const InterestMessageSettingsScreen({super.key});

  @override
  ConsumerState<InterestMessageSettingsScreen> createState() =>
      _InterestMessageSettingsScreenState();
}

class _InterestMessageSettingsScreenState
    extends ConsumerState<InterestMessageSettingsScreen> {
  bool _sendWithInterest = false;
  String _sentMessage = "";
  bool _sendOnAccept = false;
  String _acceptedMessage = "";

  bool _isInitialized = false;
  final _sentMessageController = TextEditingController();
  final _acceptedMessageController = TextEditingController();

  bool _isEditingSent = false;
  bool _isEditingAccepted = false;

  @override
  void dispose() {
    _sentMessageController.dispose();
    _acceptedMessageController.dispose();
    super.dispose();
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
              _sendWithInterest = settings.interestSentMsgSetting == 1;
              _sentMessage = settings.interestSentMessage ?? "Hi, I would like to connect with you.";
              _sendOnAccept = settings.interestAcceptMsgSetting == 1;
              _acceptedMessage = settings.interestAcceptedMessage ?? "Hey, good to connect with you!";
              
              _sentMessageController.text = _sentMessage;
              _acceptedMessageController.text = _acceptedMessage;
              _isInitialized = true;
            }

            return Column(
              children: [
                AppAppBar(
                  title: 'message_settings'.tr,
                  isShowActions: false,
                ),
                const Gap(10),

                // Content body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Card 1: Send Message with Interest
                        _buildMessageConfigCard(
                          title: "Send Message with interest",
                          description: "This message will be sent automatically when you send an interest",
                          isEnabled: _sendWithInterest,
                          onToggle: (val) => setState(() => _sendWithInterest = val),
                          message: _sentMessage,
                          controller: _sentMessageController,
                          isEditing: _isEditingSent,
                          onEditPressed: () => setState(() => _isEditingSent = true),
                          onSaveInline: () {
                            setState(() {
                              _sentMessage = _sentMessageController.text;
                              _isEditingSent = false;
                            });
                          },
                          isDark: isDark,
                        ),
                        const Gap(20),

                        // Card 2: Send Message on Accept
                        _buildMessageConfigCard(
                          title: "Send Message when interest accepted",
                          description: "This message will be sent automatically when you accept an interest",
                          isEnabled: _sendOnAccept,
                          onToggle: (val) => setState(() => _sendOnAccept = val),
                          message: _acceptedMessage,
                          controller: _acceptedMessageController,
                          isEditing: _isEditingAccepted,
                          onEditPressed: () => setState(() => _isEditingAccepted = true),
                          onSaveInline: () {
                            setState(() {
                              _acceptedMessage = _acceptedMessageController.text;
                              _isEditingAccepted = false;
                            });
                          },
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ),

                // Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: _buildSaveButton(
                    onPressed: () => _saveInterestMessages(settings),
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

  Widget _buildMessageConfigCard({
    required String title,
    required String description,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
    required String message,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditPressed,
    required VoidCallback onSaveInline,
    required bool isDark,
  }) {
    final cardBg = isDark ? const Color(0xFF131422) : Colors.white;
    final textDark = isDark ? Colors.white : const Color(0xFF1E1E2F);
    final textMuted = isDark ? Colors.white60 : const Color(0xFF7A7A9E);
    final primaryColor = Theme.of(context).primaryColor;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppFont.font(
                    color: textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: isEnabled,
                onChanged: onToggle,
                activeThumbColor: primaryColor,
              ),
            ],
          ),
          const Gap(4),
          Text(
            description,
            style: AppFont.font(
              color: textMuted,
              fontSize: 12,
            ),
          ),
          const Gap(15),

          // Message box
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: isEnabled
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black26 : const Color(0xFFF9F9FB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white10 : const Color(0xFFE2E2EA),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: isEditing
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextField(
                                controller: controller,
                                maxLines: 3,
                                style: AppFont.font(
                                  color: textDark,
                                  fontSize: 13,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your message...",
                                ),
                              ),
                              const Gap(8),
                              ElevatedButton(
                                onPressed: onSaveInline,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppTheme.getButtonBorderRadius(context),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                                child: Text(
                                  "Done",
                                  style: AppFont.font(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Message:",
                                style: AppFont.font(
                                  color: primaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(6),
                              Text(
                                '"$message"',
                                style: AppFont.font(
                                  color: textDark,
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const Gap(10),
                              InkWell(
                                onTap: onEditPressed,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 14,
                                      color: primaryColor,
                                    ),
                                    const Gap(4),
                                    Text(
                                      "Edit Message",
                                      style: AppFont.font(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFF0F0F6),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Icon(
            icon,
            color: isDark ? Colors.white : const Color(0xFF1E1E2F),
            size: 20,
          ),
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

  Future<void> _saveInterestMessages(dynamic settings) async {
    if (settings == null) return;

    try {
      showLoading(context);

      await ref.read(privacySettingsProvider.notifier).updateInterestMessage(
        sendInterestSetting: _sendWithInterest ? 1 : 0,
        interestSentMessage: _sentMessage,
        acceptInterestSetting: _sendOnAccept ? 1 : 0,
        interestAcceptedMessage: _acceptedMessage,
      );

      hideLoading();
      showToast('message_settings_saved_success'.tr);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      hideLoading();
      showToast('failed_to_save_message_settings'.tr);
    }
  }
}
