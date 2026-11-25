import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/utils/utils.dart';

import 'package:pro_matrimony/utils/permission_utils.dart';
import '../../../features/chat/data/models/chat_models.dart';
import '../../../widgets/photo_request_bottom_sheet.dart';
import '../providers/chat_notifier.dart';

class ChatListItem extends ConsumerWidget {
  final ChatMember member;
  const ChatListItem({super.key, required this.member});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final otherUserStatus = ref.watch(otherUserChatStatusStreamProvider(
      conversationId: member.id.toString(),
      otherUserId: member.memberId.toString(),
    )).value ?? 0;

    return InkWell(
      onTap: () async {
        final hasAccess = await checkChatPermission(context, ref);
        if (!hasAccess || !context.mounted) return;

        context.push(
          '/chat-conversation/${member.memberId}',
          extra: {
            'receiverName': member.fullname ?? "Chat",
            'receiverPhoto': member.profileImage,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161722) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildAvatar(context, 55, isDark, otherUserStatus),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.fullname ?? member.profileTitle ?? 'not_available'.tr,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E202C),
                    ),
                  ),
                  const Gap(4),
                  (() {
                    final subtitleText = member.lastMessageText ?? member.subTitle;
                    if (subtitleText == null) return const SizedBox.shrink();
                    final isTyping = subtitleText.trim().toLowerCase() == "typing...";
                    return Text(
                      subtitleText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: isTyping ? FontWeight.w600 : FontWeight.w500,
                        fontStyle: isTyping ? FontStyle.italic : FontStyle.normal,
                        color: isTyping
                            ? Theme.of(context).primaryColor
                            : const Color(0xFF8E90A6),
                      ),
                    );
                  }())
                ],
              ),
            ),
            const Gap(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (member.lastMessageTime != null)
                  Text(
                    member.lastMessageTime!,
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8E90A6),
                    ),
                  ),
                const Gap(6),
                if (member.unreadMessageCount != null && member.unreadMessageCount! > 0)
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      member.unreadMessageCount.toString(),
                      style: AppFont.font(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                else if (member.lastMessageText != null && member.lastMessageText!.trim() != "Send the first message")
                  (() {
                    if (otherUserStatus == 2) {
                      return SizedBox(
                        height: 20,
                        child: Icon(
                          Icons.done_all_rounded,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    } else if (otherUserStatus == 1) {
                      return const SizedBox(
                        height: 20,
                        child: Icon(
                          Icons.done_all_rounded,
                          size: 16,
                          color: Color(0xFF8E90A6), // grey for delivered
                        ),
                      );
                    } else {
                      return const SizedBox(
                        height: 20,
                        child: Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: Color(0xFF8E90A6), // grey for sent
                        ),
                      );
                    }
                  }())
                else
                  const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, double size, bool isDark, int otherUserStatus) {
    final isPhotoProtected = member.isPhotoProtected == 1;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFEEF0F6),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(size),
                child: getImageWidget(url: member.profileImage ?? "", boxFit: BoxFit.cover),
              ),
              if (isPhotoProtected && member.profileImage != null && member.profileImage!.isNotEmpty)
                InkWell(
                  onTap: () => PhotoRequestBottomSheet.show(context, member.memberId.toString()),
                  child: protectedChatWidget(),
                ),
            ],
          ),
        ),
        if (otherUserStatus == 1 || otherUserStatus == 2 || member.memberOnlineStatus?.toLowerCase() == "online")
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? const Color(0xFF161722) : Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
