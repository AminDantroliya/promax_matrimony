import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pro_matrimony/services/notification_service.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/membership_upgrade_bottom_sheet.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../services/firebase_chat_service.dart';
import '../../../widgets/app_no_records_widget.dart';

import '../providers/chat_notifier.dart';
import '../widgets/chat_conversation_list_item.dart';

class ChatConversationScreen extends ConsumerStatefulWidget {
  final String receiverId;
  final String receiverName;
  final String? receiverPhoto;

  const ChatConversationScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    this.receiverPhoto,
  });

  @override
  ConsumerState<ChatConversationScreen> createState() =>
      _ChatConversationScreenState();
}

class _ChatConversationScreenState
    extends ConsumerState<ChatConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<String?>? _notificationSubscription;
  String? _loadingActionKey;
  bool _isSendingMessage = false;

  @override
  void initState() {
    super.initState();
    ApplicationData.isConversationScreenIsOpen = true;
    ApplicationData.activeReceiverId = widget.receiverId;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final hasAccess = await checkChatPermission(context, ref);
      if (!hasAccess && mounted) {
        context.pop();
        return;
      }
      ref
          .read(chatConversationProvider(widget.receiverId).notifier)
          .fetchMessages(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref
            .read(chatConversationProvider(widget.receiverId).notifier)
            .fetchMessages(isRefresh: false);
      }
    });

    _notificationSubscription = NotificationService
        .onForegroundNotification
        .stream
        .listen((payload) {
          if (payload != null && payload.isNotEmpty) {
            try {
              final data = jsonDecode(payload);
              final notifReceiverId =
                  (data["receiver_id"] ??
                          data["sender_id"] ??
                          data["viewer_id"] ??
                          data["member_id"] ??
                          data["user_id"])
                      ?.toString()
                      .trim();
              final notifConvId = data["conversation_id"]?.toString().trim();
              final currentConvId = ref
                  .read(chatConversationProvider(widget.receiverId))
                  .headerData
                  ?.conversationId
                  ?.toString();

              final isMatch =
                  (notifReceiverId != null &&
                      (notifReceiverId == widget.receiverId ||
                          notifReceiverId == currentConvId)) ||
                  (notifConvId != null &&
                      notifConvId.isNotEmpty &&
                      (notifConvId == currentConvId ||
                          notifConvId == ApplicationData.activeConversationId));

              if (isMatch) {
                final notifType =
                    data["type"]?.toString().toLowerCase().trim() ?? '';
                final isRequestEvent =
                    notifType.contains('request') ||
                    notifType.contains('accept') ||
                    notifType.contains('reject') ||
                    notifType.contains('block');

                if (isRequestEvent) {
                  ref
                      .read(
                        chatConversationProvider(widget.receiverId).notifier,
                      )
                      .fetchMessages(isRefresh: true);
                }
              }
            } catch (e) {
              debugPrint("Error parsing chat notification: $e");
            }
          }
        });
  }

  @override
  void dispose() {
    ApplicationData.isConversationScreenIsOpen = false;
    ApplicationData.activeConversationId = null;
    ApplicationData.activeReceiverId = null;
    _notificationSubscription?.cancel();
    _messageController.dispose();
    _scrollController.dispose();

    try {
      final chatState = ref.read(chatConversationProvider(widget.receiverId));
      final conversationId = chatState.headerData?.conversationId?.toString();
      if (conversationId != null) {
        FirebaseChatService.instance.updateMyChatStatus(conversationId, 1);
        if (FirebaseChatService.instance.currentConversationId == conversationId) {
          FirebaseChatService.instance.currentConversationId = null;
        }
      }
    } catch (e) {
      debugPrint("Error updating status on screen dispose: $e");
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatConversationProvider(widget.receiverId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    // Effective request/block state (local overrides API until next fetch)
    final headerData = state.headerData;
    final myUserIdStr = AppSessionService.getValue(
      SessionDetail.kUserId,
    )?.toString();
    final myUserIdInt = int.tryParse(myUserIdStr ?? '');
    final requestStatus = state.localRequestStatus ?? headerData?.requestStatus;
    final requestedBy = state.localRequestedBy ?? headerData?.requestedBy;
    final isChatBlocked =
        state.localIsChatBlocked ?? (headerData?.isChatBlocked ?? false);
    final isBlocked = headerData?.isBlocked ?? false;
    final receiverName = headerData?.profileTitle ?? widget.receiverName;
    final receiverPhoto = headerData?.profileImage ?? widget.receiverPhoto;

    // Determine if chat is fully open
    final normRequestStatus = requestStatus?.toString().toLowerCase().trim();

    final isRequestAccepted =
        normRequestStatus == 'accepted' || normRequestStatus == 'approved';
    final canChat = isRequestAccepted && !isChatBlocked && !isBlocked;
    final isInitialLoading =
        headerData == null && state.pagingState.error == null;
    final hasInitialError =
        headerData == null && state.pagingState.error != null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getThemeSystemUiOverlayStyle(isDark: isDark),
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF0C0D16)
            : const Color(0xFFF8F9FD),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              _buildFigmaAppBar(context, state, isDark, primaryColor),
              Expanded(
                child: isInitialLoading
                    ? const Center(child: AppLoadingWidget())
                    : hasInitialError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppNoRecordsWidget(
                              noRecordFoundMessage: null,
                            ),
                            const Gap(16),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                      chatConversationProvider(
                                        widget.receiverId,
                                      ).notifier,
                                    )
                                    .fetchMessages(isRefresh: true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: Text('btn_retry'.tr),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await ref
                              .read(
                                chatConversationProvider(
                                  widget.receiverId,
                                ).notifier,
                              )
                              .fetchMessages(isRefresh: true);
                        },
                        color: primaryColor,
                        child: canChat
                            ? _buildMessageList(state, receiverPhoto)
                            : SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: _buildChatGateUI(
                                    context: context,
                                    isDark: isDark,
                                    primaryColor: primaryColor,
                                    requestStatus: requestStatus,
                                    requestedBy: requestedBy,
                                    myUserIdInt: myUserIdInt,
                                    isChatBlocked: isChatBlocked,
                                    isBlocked: isBlocked,
                                    receiverName: receiverName,
                                    receiverPhoto: receiverPhoto,
                                  ),
                                ),
                              ),
                      ),
              ),
              if (canChat && !isInitialLoading && !hasInitialError)
                _buildFigmaInputArea(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFigmaAppBar(
    BuildContext context,
    ChatConversationState state,
    bool isDark,
    Color primaryColor,
  ) {
    final headerData = state.headerData;
    final isOnline =
        state.otherUserChatStatus == 1 ||
        state.otherUserChatStatus == 2 ||
        headerData?.receiverOnlineStatus?.toLowerCase() == "online" ||
        headerData?.receiverOnlineStatus?.toLowerCase() == "active";
    final receiverMatriId =
        headerData?.receiverMemberMatriId ?? widget.receiverName;
    final receiverPhoto =
        headerData?.receiverMemberPhotoUrl ?? widget.receiverPhoto;
    final double topPadding = MediaQuery.of(context).padding.top;
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 14 + topPadding,
        bottom: 14,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button squircle with accent color
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFFF1F3F9),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back, color: accentColor, size: 22),
            ),
          ),
          const Gap(10),
          // User profile image with online badge
          InkWell(
            onTap: () => context.push('/profile-other/${widget.receiverId}'),
            child: Stack(
              alignment: Alignment.bottomRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: getImageWidget(
                      url: receiverPhoto ?? "",
                      boxFit: BoxFit.cover,
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
                      color: isOnline
                          ? const Color(0xFF39D353)
                          : const Color(0xFF8E90A6),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF161722) : Colors.white,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          // User Name & active status text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  receiverMatriId,
                  style: AppFont.font(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1E202C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Row(
                  children: [
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: isOnline
                            ? const Color(0xFF39D353)
                            : const Color(0xFF8E90A6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      isOnline ? 'online'.tr : 'offline'.tr,
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isOnline
                            ? const Color(0xFF39D353)
                            : const Color(0xFF8E90A6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions: voice and video call squircle buttons with accent color
          if (ref.watch(featureProvider('enableVideoCall'))) ...[
            _buildFigmaAppBarCallButton(
              isVideo: true,
              receiverMatriId: receiverMatriId,
              isDark: isDark,
              accentColor: accentColor,
            ),
            const Gap(8),
          ],
          if (ref.watch(featureProvider('enableVoiceCall'))) ...[
            _buildFigmaAppBarCallButton(
              isVideo: false,
              receiverMatriId: receiverMatriId,
              isDark: isDark,
              accentColor: accentColor,
            ),
            const Gap(8),
          ],
          _buildThreeDotMenu(context, state, isDark, accentColor),
        ],
      ),
    );
  }

  Widget _buildThreeDotMenu(
    BuildContext context,
    ChatConversationState state,
    bool isDark,
    Color accentColor,
  ) {
    final headerData = state.headerData;
    final isChatBlocked =
        state.localIsChatBlocked ?? (headerData?.isChatBlocked ?? false);

    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'block_unblock') {
          final action = isChatBlocked ? 'unblock' : 'block';
          showLoading(context);
          final ok = await ref
              .read(chatConversationProvider(widget.receiverId).notifier)
              .blockUnblock(action);
          hideLoading();
          if (ok) {
            showToast(
              isChatBlocked
                  ? 'member_unblocked_success'.tr
                  : 'member_blocked_success'.tr,
            );
          } else {
            showToast('failed_to_change_block_status'.tr);
          }
        }
      },
      iconColor: accentColor,
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'block_unblock',
          child: Row(
            children: [
              Icon(
                isChatBlocked ? Icons.lock_open_rounded : Icons.block_rounded,
                color: isChatBlocked ? Colors.green : Colors.red,
                size: 20,
              ),
              const Gap(10),
              Text(
                isChatBlocked ? 'unblock_chat'.tr : 'block_chat'.tr,
                style: AppFont.font(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isDark ? Colors.white : const Color(0xFF1E202C),
                ),
              ),
            ],
          ),
        ),
      ],
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : const Color(0xFFF1F3F9),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(Icons.more_vert_rounded, color: accentColor, size: 22),
      ),
    );
  }

  Widget _buildFigmaAppBarCallButton({
    required bool isVideo,
    required String receiverMatriId,
    required bool isDark,
    required Color accentColor,
  }) {
    final hasActiveSession = ApplicationData.isMemberPaid == true;
    final state = ref.read(chatConversationProvider(widget.receiverId));
    final headerData = state.headerData;
    final isChatBlocked =
        state.localIsChatBlocked ?? (headerData?.isChatBlocked ?? false);
    final isBlocked = headerData?.isBlocked ?? false;

    return InkWell(
      onTap: () {
        if (!hasActiveSession) {
          _showMembershipPopup();
        }
      },
      child: AbsorbPointer(
        absorbing: !hasActiveSession,
        child: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFF1F3F9),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: ZegoSendCallInvitationButton(
              isVideoCall: isVideo,
              resourceID: "zegouikit_call",
              onWillPressed: () async {
                return await initiateAppCall(
                  context,
                  ref,
                  targetModel: {
                    'matri_id': receiverMatriId,
                    'member_id': widget.receiverId,
                    'video_call_setting': 0,
                    'voice_call_setting': 0,
                    'is_block': (isBlocked || isChatBlocked) ? 1 : 0,
                    'is_blocked': (isBlocked || isChatBlocked),
                    'is_chat_blocked': isChatBlocked,
                  },
                  isVideo: isVideo,
                  sendCallInvitation: false,
                );
              },
              customData: jsonEncode({
                "user_id":
                    AppSessionService.getValue(
                      SessionDetail.kUserId,
                    )?.toString() ??
                    "",
              }),
              icon: ButtonIcon(
                icon: SvgPicture.asset(
                  isVideo
                      ? AppAssets.figmaVideoCallOutline
                      : AppAssets.figmaVoiceCallOutline,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : accentColor,
                    BlendMode.srcIn,
                  ),
                  width: isVideo ? 22 : 19,
                  height: isVideo ? 22 : 19,
                ),
              ),
              iconSize: isVideo ? const Size(22, 22) : const Size(19, 19),
              buttonSize: const Size(44, 44),
              invitees: [
                ZegoUIKitUser(id: receiverMatriId, name: receiverMatriId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(
    ChatConversationState state,
    String? receiverPhoto,
  ) {
    final pagingState = state.pagingState;
    if (pagingState.items.isEmpty) {
      return Center(
        child: AppNoRecordsWidget(
          noRecordFoundMessage: "start_conversation_sub".tr,
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: pagingState.items.length + (pagingState.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == pagingState.items.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final message = pagingState.items[index];
        final isDark = Theme.of(context).brightness == Brightness.dark;

        bool showDateHeader = false;
        String dateString = "";

        if (index == pagingState.items.length - 1) {
          showDateHeader = true;
          dateString = _getDateString(message.sendOn);
        } else {
          final nextMessage = pagingState.items[index + 1];
          final currentDate = _getDateOnly(message.sendOn);
          final nextDate = _getDateOnly(nextMessage.sendOn);

          if (currentDate != nextDate) {
            showDateHeader = true;
            dateString = _getDateString(message.sendOn);
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showDateHeader && dateString.isNotEmpty)
              _buildDateHeader(dateString, isDark),
            ChatConversationListItem(
              key: ValueKey('msg_${message.id}_${message.chatStatus}_${state.otherUserChatStatus}'),
              message: message,
              receiverPhotoUrl: receiverPhoto,
              otherUserChatStatus: state.otherUserChatStatus,
            ),
          ],
        );
      },
    );
  }

  String _getDateOnly(dynamic date) {
    if (date == null) return "";
    try {
      final parsedDate = DateTime.parse(date.toString()).toLocal();
      return "${parsedDate.year}-${parsedDate.month}-${parsedDate.day}";
    } catch (e) {
      return "";
    }
  }

  String _getDateString(dynamic date) {
    if (date == null) return "";
    try {
      final parsedDate = DateTime.parse(date.toString()).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final messageDate = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
      );

      if (messageDate == today) {
        return "today".tr;
      } else if (messageDate == yesterday) {
        return "yesterday".tr;
      } else {
        return DateFormat("dd MMM yyyy").format(parsedDate);
      }
    } catch (e) {
      return "";
    }
  }

  Widget _buildDateHeader(String dateString, bool isDark) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFEEF0F6),
              thickness: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161722) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: primaryColor,
                  size: 16,
                ),
                const Gap(6),
                Text(
                  dateString,
                  style: AppFont.font(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFEEF0F6),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleGateAction(
    String actionKey,
    Future<dynamic> Function() actionFn,
    String defaultErrorMsg,
  ) async {
    if (_loadingActionKey != null) return;
    setState(() {
      _loadingActionKey = actionKey;
    });
    try {
      final res = await actionFn();
      bool ok = false;
      String? serverMessage;

      if (res is bool) {
        ok = res;
      } else if (res is Map) {
        ok = res['success'] == true || res['status'] == 'success';
        serverMessage = res['message']?.toString();
      }

      if (!ok && mounted) {
        final messageToShow =
            (serverMessage != null && serverMessage.trim().isNotEmpty)
            ? serverMessage.trim()
            : defaultErrorMsg;

        final lower = messageToShow.toLowerCase();
        if (lower.contains('plan') ||
            lower.contains('membership') ||
            lower.contains('upgrade')) {
          MembershipUpgradeBottomSheet.show(context, messageToShow);
        } else {
          showToast(messageToShow);
        }
      }
    } catch (_) {
      if (mounted) showToast(defaultErrorMsg);
    } finally {
      if (mounted) {
        setState(() {
          _loadingActionKey = null;
        });
      }
    }
  }

  Widget _buildFigmaInputArea(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFEEF0F6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Input field squircle container
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF0C0D16)
                    : const Color(0xFFF1F3FB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'write_message'.tr,
                  hintStyle: AppFont.font(
                    color: const Color(0xFF8E90A6),
                    fontSize: 13,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                ),
                style: AppFont.font(
                  fontSize: 13,
                  color: isDark ? Colors.white : const Color(0xFF1E202C),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),
          ),
          const Gap(10),
          // Send button circular gradient with theme primary color
          GestureDetector(
            onTap: _isSendingMessage ? null : _handleSendMessage,
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                gradient: FigmaColors.primaryGradient(context),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: _isSendingMessage
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : SvgPicture.asset(
                        AppAssets.figmaSendMessage,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 18,
                        height: 18,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Chat Gate UI ───────────────────────────────────────────────────────────

  Widget _buildChatGateUI({
    required BuildContext context,
    required bool isDark,
    required Color primaryColor,
    required String? requestStatus,
    required dynamic requestedBy,
    required int? myUserIdInt,
    required bool isChatBlocked,
    required bool isBlocked,
    required String receiverName,
    required String? receiverPhoto,
  }) {
    // Determine which state to show
    final normStatus = requestStatus?.toString().toLowerCase().trim();
    _ChatGateVariant variant;
    Color? statusDotColor;
    if (isChatBlocked || isBlocked) {
      variant = _ChatGateVariant.blocked;
      statusDotColor = Colors.red;
    } else if (normStatus == 'rejected') {
      variant = _ChatGateVariant.rejected;
      statusDotColor = Colors.red;
    } else if (normStatus == 'pending') {
      final requestedByInt = requestedBy is int
          ? requestedBy
          : int.tryParse(requestedBy?.toString() ?? '');
      if (requestedByInt == myUserIdInt) {
        variant = _ChatGateVariant.requestSent;
        statusDotColor = primaryColor;
      } else if (requestedByInt != null) {
        variant = _ChatGateVariant.incomingRequest;
        statusDotColor = const Color(0xFFFFA726);
      } else {
        // requestedBy is null -> request not sent by current or other user yet
        variant = _ChatGateVariant.sendRequest;
        statusDotColor = null;
      }
    } else {
      variant = _ChatGateVariant.sendRequest;
      statusDotColor = null;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFEEF0F6),
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGateHeaderAvatar(
            receiverPhoto,
            statusDotColor,
            isDark,
            primaryColor,
          ),
          const Gap(16),
          _buildGateContent(
            context: context,
            isDark: isDark,
            primaryColor: primaryColor,
            variant: variant,
            receiverName: receiverName,
            receiverPhoto: receiverPhoto,
          ),
        ],
      ),
    );
  }

  Widget _buildGateHeaderAvatar(
    String? receiverPhoto,
    Color? statusDotColor,
    bool isDark,
    Color primaryColor,
  ) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.15),
                width: 3.5,
              ),
            ),
            child: ClipOval(
              child: getImageWidget(
                url: receiverPhoto ?? "",
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          if (statusDotColor != null)
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: statusDotColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? const Color(0xFF161722) : Colors.white,
                    width: 3,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGateContent({
    required BuildContext context,
    required bool isDark,
    required Color primaryColor,
    required _ChatGateVariant variant,
    required String receiverName,
    required String? receiverPhoto,
  }) {
    switch (variant) {
      case _ChatGateVariant.sendRequest:
        return _gateLayout(
          isDark: isDark,
          badgeLabel: null,
          badgeColor: null,
          title: 'start_conversation_with'.trParams({'name': receiverName}),
          subtitle: 'send_request_desc'.trParams({'name': receiverName}),
          actions: [
            _gateButton(
              context: context,
              label: 'send_chat_request'.tr,
              gradient: FigmaColors.primaryGradient(context),
              textColor: Colors.white,
              isLoading: _loadingActionKey == 'send',
              onTap: () => _handleGateAction(
                'send',
                () => ref
                    .read(chatConversationProvider(widget.receiverId).notifier)
                    .chatRequest('send'),
                'failed_to_send_request'.tr,
              ),
            ),
          ],
        );

      case _ChatGateVariant.requestSent:
        return _gateLayout(
          isDark: isDark,
          badgeLabel: 'request_sent_caps'.tr,
          badgeColor: primaryColor,
          title: 'waiting_for_response'.trParams({'name': receiverName}),
          subtitle: 'request_sent_desc'.trParams({'name': receiverName}),
          actions: [
            _gateButton(
              context: context,
              label: 'cancel_request'.tr,
              color: isDark ? const Color(0xFF2A2B3D) : const Color(0xFFF1F3FB),
              textColor: isDark ? Colors.white : const Color(0xFF1E202C),
              isLoading: _loadingActionKey == 'cancel',
              onTap: () => _handleGateAction(
                'cancel',
                () => ref
                    .read(chatConversationProvider(widget.receiverId).notifier)
                    .chatRequest('cancel'),
                'failed_to_cancel_request'.tr,
              ),
            ),
          ],
        );

      case _ChatGateVariant.incomingRequest:
        return _gateLayout(
          isDark: isDark,
          badgeLabel: 'new_chat_request_caps'.tr,
          badgeColor: const Color(0xFFFFA726),
          title: 'wants_to_chat_with_you'.trParams({'name': receiverName}),
          subtitle: 'incoming_request_desc'.trParams({'name': receiverName}),
          actions: [
            _gateButton(
              context: context,
              label: 'accept'.tr,
              gradient: FigmaColors.primaryGradient(context),
              textColor: Colors.white,
              isLoading: _loadingActionKey == 'accept',
              onTap: () => _handleGateAction(
                'accept',
                () => ref
                    .read(chatConversationProvider(widget.receiverId).notifier)
                    .chatRequest('accept'),
                'failed_to_accept_request'.tr,
              ),
            ),
            const Gap(12),
            _gateButton(
              context: context,
              label: 'reject'.tr,
              color: Colors.red.withValues(alpha: 0.1),
              textColor: Colors.red,
              isLoading: _loadingActionKey == 'reject',
              onTap: () => _handleGateAction(
                'reject',
                () => ref
                    .read(chatConversationProvider(widget.receiverId).notifier)
                    .chatRequest('reject'),
                'failed_to_reject_request'.tr,
              ),
            ),
          ],
        );

      case _ChatGateVariant.rejected:
        return _gateLayout(
          isDark: isDark,
          badgeLabel: 'chat_rejected_caps'.tr,
          badgeColor: Colors.red,
          title: 'you_rejected_this_chat'.tr,
          subtitle: 'chat_rejected_desc'.trParams({'name': receiverName}),
          actions: [
            _gateButton(
              context: context,
              label: 'allow_new_request'.tr,
              gradient: FigmaColors.primaryGradient(context),
              textColor: Colors.white,
              isLoading: _loadingActionKey == 'allow',
              onTap: () => _handleGateAction(
                'allow',
                () => ref
                    .read(chatConversationProvider(widget.receiverId).notifier)
                    .chatRequest('send'),
                'failed_to_allow_request'.tr,
              ),
            ),
          ],
        );

      case _ChatGateVariant.blocked:
        return _gateLayout(
          isDark: isDark,
          badgeLabel: 'blocked_caps'.tr,
          badgeColor: Colors.red,
          title: 'you_blocked_user'.trParams({'name': receiverName}),
          subtitle: 'blocked_desc'.trParams({'name': receiverName}),
          actions: [
            _gateButton(
              context: context,
              label: 'unblock_user'.trParams({'name': receiverName}),
              color: Colors.green,
              textColor: Colors.white,
              isLoading: _loadingActionKey == 'unblock',
              onTap: () => _handleGateAction(
                'unblock',
                () => ref
                    .read(chatConversationProvider(widget.receiverId).notifier)
                    .blockUnblock('unblock'),
                'failed_to_unblock'.tr,
              ),
            ),
          ],
        );
    }
  }

  Widget _gateLayout({
    required bool isDark,
    required String? badgeLabel,
    required Color? badgeColor,
    required String title,
    required String subtitle,
    required List<Widget> actions,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (badgeLabel != null && badgeColor != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeLabel,
              style: AppFont.font(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: badgeColor,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const Gap(12),
        ],
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppFont.font(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF16182F),
          ),
        ),
        const Gap(8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppFont.font(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E90A6),
            height: 1.5,
          ),
        ),
        const Gap(20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: actions),
      ],
    );
  }

  Widget _gateButton({
    required BuildContext context,
    required String label,
    Color? color,
    Gradient? gradient,
    required Color textColor,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: gradient == null ? (color ?? primaryColor) : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: (color ?? primaryColor).withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                label,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
      ),
    );
  }

  void _handleSendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _isSendingMessage) return;

    final hasAccess = await checkChatPermission(context, ref);
    if (!hasAccess) return;

    setState(() {
      _isSendingMessage = true;
    });

    try {
      final success = await ref
          .read(chatConversationProvider(widget.receiverId).notifier)
          .sendMessage(message);
      if (success) {
        _messageController.clear();
      } else if (mounted) {
        await checkChatPermission(context, ref);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSendingMessage = false;
        });
      }
    }
  }

  void _showMembershipPopup() {
    MembershipUpgradeBottomSheet.show(
      context,
      'upgrade_your_membership_message'.tr,
    );
  }
}

// Gate UI state variants
enum _ChatGateVariant {
  sendRequest,
  requestSent,
  incomingRequest,
  rejected,
  blocked,
}
