import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pro_matrimony/services/notification_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:pro_matrimony/features/chat/data/models/chat_models.dart';
import 'package:pro_matrimony/features/search/providers/search_notifier.dart';
import '../providers/manager_chat_notifier.dart';

class ManagerChatScreen extends ConsumerStatefulWidget {
  const ManagerChatScreen({super.key});

  @override
  ConsumerState<ManagerChatScreen> createState() => _ManagerChatScreenState();
}

class _ManagerChatScreenState extends ConsumerState<ManagerChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    ApplicationData.isManagerChatScreenOpen = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(managerChatProvider.notifier).fetchMessages(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        ref.read(managerChatProvider.notifier).fetchMessages(isRefresh: false);
      }
    });

    _notificationSubscription = NotificationService.onForegroundNotification.stream.listen((payload) {
      if (payload != null && payload.isNotEmpty) {
        try {
          final data = jsonDecode(payload);
          final notifType = (data["type"] ??
                  data["noti_type"] ??
                  data["notification_type"] ??
                  data["action"])
              ?.toString()
              .toLowerCase()
              .trim() ?? '';

          if (notifType == 'personalize_chat_from_admin' ||
              notifType == 'personalized_chat_from_admin') {
            printLog('ManagerChatScreen: Received personalize_chat_from_admin notification. Refreshing messages.');
            ref.read(managerChatProvider.notifier).fetchMessages(isRefresh: true);
          }
        } catch (e) {
          printLog('Error parsing foreground notification in ManagerChatScreen: $e');
        }
      }
    });
  }

  @override
  void dispose() {
    ApplicationData.isManagerChatScreenOpen = false;
    _notificationSubscription?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();
    
    final success = await ref.read(managerChatProvider.notifier).sendMessage(text);
    if (!success) {
      showToast("action_failed".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(managerChatProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0C0D16)
          : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, isDark),
            Expanded(
              child: _buildMessageList(state, isDark),
            ),
            _buildInputArea(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Theme.of(context).primaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: isDark ? Colors.white : Theme.of(context).primaryColor,
                size: 22,
              ),
            ),
          ),
          const Gap(10),
          Stack(
            alignment: Alignment.bottomRight,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    Icons.support_agent_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF39D353),
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? const Color(0xFF161722) : Colors.white, width: 2.5),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAppTitleWidget(context, "matrimonial_manager".tr, fontSize: 15),
                const Gap(2),
                Row(
                  children: [
                    Container(
                      height: 6,
                      width: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF39D353),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "active_now".tr,
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF39D353),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(PagingState<ChatMessage> state, bool isDark) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: AppLoadingWidget());
    }

    if (state.items.isEmpty && !state.isLoading) {
      return AppNoRecordsWidget(noRecordFoundMessage: 'no_conversation_found'.tr);
    }

    return Column(
      children: [
        if (state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            itemCount: state.items.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemBuilder: (context, index) {
              final message = state.items[index];
              final showDateHeader = _shouldShowDateHeader(state.items, index);
              final dateHeaderStr = showDateHeader
                  ? _getFormattedHeaderDate(message.sendOn ?? "")
                  : "";

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showDateHeader && dateHeaderStr.isNotEmpty)
                    _buildDateHeader(dateHeaderStr, isDark),
                  _buildMessageBubble(message, isDark),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isDark) {
    final isSender = message.isSender ?? false;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: isSender
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: const BoxDecoration(
                        color: Color(0xFF39D353),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
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
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.support_agent_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
            ),
    );
  }

  Widget _buildInputArea(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEEF0F6),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0C0D16) : const Color(0xFFF1F3F9),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                style: AppFont.font(
                  color: isDark ? Colors.white : const Color(0xFF1E202C),
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "write_message".tr,
                  hintStyle: AppFont.font(
                    color: const Color(0xFF8E90A6),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Gap(10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                gradient: FigmaColors.primaryGradient(context),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _shouldShowDateHeader(List<ChatMessage> items, int index) {
    if (index == items.length - 1) {
      return true;
    }
    final current = DateTime.tryParse(items[index].sendOn ?? "");
    final next = DateTime.tryParse(items[index + 1].sendOn ?? "");
    if (current == null || next == null) {
      return false;
    }
    return current.year != next.year ||
        current.month != next.month ||
        current.day != next.day;
  }

  String _getFormattedHeaderDate(String serverDate) {
    try {
      final date = DateTime.tryParse(serverDate);
      if (date == null) return "";
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final messageDate = DateTime(date.year, date.month, date.day);

      if (messageDate == today) {
        return "${'today_word'.tr}, ${DateFormat('MMMM d').format(date)}";
      } else if (messageDate == yesterday) {
        return "${'yesterday_word'.tr}, ${DateFormat('MMMM d').format(date)}";
      } else {
        return DateFormat('MMMM d, yyyy').format(date);
      }
    } catch (e) {
      return "";
    }
  }

  Widget _buildDateHeader(String dateString, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEEF0F6),
              thickness: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161722) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const Gap(6),
                Text(
                  dateString,
                  style: AppFont.font(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEEF0F6),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
