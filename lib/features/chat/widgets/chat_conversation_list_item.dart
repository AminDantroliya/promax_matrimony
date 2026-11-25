import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../../../features/chat/data/models/chat_models.dart';

class ChatConversationListItem extends StatelessWidget {
  final ChatMessage message;
  final String? receiverPhotoUrl;
  final int otherUserChatStatus;

  const ChatConversationListItem({
    super.key,
    required this.message,
    this.receiverPhotoUrl,
    this.otherUserChatStatus = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isReceiver = message.isMessageReceiver;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final String text = message.message ?? "";
    final bool isImage = text.startsWith("http") && (text.contains(".jpg") || text.contains(".png") || text.contains(".jpeg"));
    final bool isAudio = text.startsWith("[audio]") || text.contains("voice_");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: isReceiver ? Alignment.centerLeft : Alignment.centerRight,
        child: isReceiver
            ? _buildReceiverMessage(context, screenWidth, receiverPhotoUrl, isImage, isAudio, isDark)
            : _buildSenderMessage(context, screenWidth, isImage, isAudio, isDark, otherUserChatStatus),
      ),
    );
  }

  Widget _buildReceiverMessage(
    BuildContext context,
    double screenWidth,
    String? avatarUrl,
    bool isImage,
    bool isAudio,
    bool isDark,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Receiver Avatar
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: getImageWidget(url: avatarUrl ?? "", boxFit: BoxFit.cover),
          ),
        ),
        const Gap(8),
        // Bubble Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isImage)
              _buildImageBubble(screenWidth)
            else if (isAudio)
              _buildAudioBubble(context, screenWidth, isDark)
            else
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.68),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF161722) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(4),
                  ),
                  border: Border.all(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEEF0F6),
                    width: 1,
                  ),
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                ),
                child: Text(
                  message.message ?? "",
                  style: AppFont.font(
                    fontSize: 14,
                    color: isDark ? Colors.white : const Color(0xFF1E202C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const Gap(4),
            // Timestamp
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                getFormattedChatDate(message.sendOn?.toString() ?? ""),
                style: AppFont.font(
                  fontSize: 11,
                  color: const Color(0xFF8E90A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSenderMessage(
    BuildContext context,
    double screenWidth,
    bool isImage,
    bool isAudio,
    bool isDark,
    int otherUserChatStatus,
  ) {
    final primaryColor = Theme.of(context).primaryColor;
    int msgStatus = message.chatStatus ?? 0;
    if (message.chatStatus == null) {
      final isReadStr = message.isRead?.toString().toLowerCase();
      if (isReadStr == "2" || isReadStr == "seen" || isReadStr == "y" || isReadStr == "yes") {
        msgStatus = 2;
      } else if (isReadStr == "1" || isReadStr == "delivered") {
        msgStatus = 1;
      }
    }

    // Display highest status reached
    final finalStatus = msgStatus > otherUserChatStatus ? msgStatus : otherUserChatStatus;

    Color badgeColor = const Color(0xFF8E90A6); // Grey by default (sent/delivered)
    IconData badgeIcon = Icons.check_rounded; // Single check

    if (finalStatus == 2) {
      badgeColor = const Color(0xFF39D353); // Green for seen
      badgeIcon = Icons.done_all_rounded; // Double check
    } else if (finalStatus == 1) {
      badgeColor = const Color(0xFF8E90A6); // Grey for delivered
      badgeIcon = Icons.done_all_rounded; // Double check
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isImage)
          _buildImageBubble(screenWidth)
        else if (isAudio)
          _buildAudioBubble(context, screenWidth, isDark)
        else
          Container(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: FigmaColors.primaryGradient(context),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message.message ?? "",
              style: AppFont.font(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        const Gap(4),
        // Timestamp & checkmark badge
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                badgeIcon,
                color: Colors.white,
                size: 8,
              ),
            ),
            const Gap(6),
            Text(
              getFormattedChatDate(message.sendOn?.toString() ?? ""),
              style: AppFont.font(
                fontSize: 11,
                color: const Color(0xFF8E90A6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageBubble(double screenWidth) {
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: getImageWidget(
          url: message.message ?? "",
          boxFit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAudioBubble(BuildContext context, double screenWidth, bool isDark) {
    final cleanDuration = message.message?.replaceAll("[audio]", "").split("_").last ?? "0:24";
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: screenWidth * 0.65,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEEF0F6),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
          ),
          const Gap(10),
          // Waveform bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(15, (index) {
                final height = (index % 3 == 0) ? 14.0 : ((index % 2 == 0) ? 8.0 : 20.0);
                return Container(
                  width: 2.5,
                  height: height,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: index < 9 ? 1.0 : 0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),
          const Gap(10),
          Text(
            cleanDuration,
            style: AppFont.font(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8E90A6),
            ),
          ),
        ],
      ),
    );
  }
}
