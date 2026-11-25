import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/chat/data/models/chat_models.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

class ChatMemberListItem extends ConsumerWidget {
  final ChatMember member;

  const ChatMemberListItem({super.key, required this.member});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        final hasAccess = await checkChatPermission(context, ref);
        if (!hasAccess || !context.mounted) return;

        context.push(
          '/chat-conversation/${member.memberId}',
          extra: {
            'receiverName': member.fullname ?? 'user'.tr,
            'receiverPhoto': member.profileImage,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenWidth(12)),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: getProportionateScreenWidth(55),
                    width: getProportionateScreenWidth(55),
                    child: getImageWidget(
                        url: member.profileImage ?? "", boxFit: BoxFit.cover),
                  ),
                ),
                if (member.memberOnlineStatus == "Online")
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            Gap(getProportionateScreenWidth(15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: customTextSemiBoldStyle(
                            member.fullname ?? 'not_available'.tr,
                            getProportionateScreenWidth(15),
                            TextAlign.start,
                            Theme.of(context).colorScheme.onSurface),
                      ),
                      if (member.lastMessageTime != null)
                        customTextNormalStyle(
                            member.lastMessageTime!,
                            getProportionateScreenWidth(11),
                            TextAlign.start,
                            Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Expanded(
                        child: customTextSingleLineNormalStyle(
                          member.lastMessageText ?? 'start_chatting'.tr,
                          getProportionateScreenWidth(13),
                          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      if (member.unreadMessageCount != null && member.unreadMessageCount! > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: appPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            member.unreadMessageCount.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
