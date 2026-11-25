import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/services/notification_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/generic_member_list_view.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart' hide otherProfileProvider;
import '../providers/matches_notifier.dart';
import '../widgets/admin_match_card.dart';

import 'package:pro_matrimony/widgets/profile_cards/profile_card_widget.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  final MatchType type;
  final String title;

  const MatchesScreen({super.key, required this.type, required this.title});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = ref.read(matchesProvider(widget.type));
      if (state.items.isEmpty && !state.isLoading) {
        ref.read(matchesProvider(widget.type).notifier).fetchMatches();
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
              notifType == 'personalized_chat_from_admin' ||
              notifType == 'match_from_admin') {
            printLog('MatchesScreen: Received $notifType notification. Refreshing matches.');
            ref.read(matchesProvider(widget.type).notifier).fetchMatches();
          }
        } catch (e) {
          printLog('Error parsing foreground notification in MatchesScreen: $e');
        }
      }
    });
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels;
      if (maxScroll > 0 &&
          position.userScrollDirection == ScrollDirection.reverse &&
          currentScroll >= maxScroll - 250) {
        final notifier = ref.read(matchesProvider(widget.type).notifier);
        final state = ref.read(matchesProvider(widget.type));
        if (!state.isLoading && !state.isLoadingMore && notifier.hasMore) {
          notifier.fetchMatches(isRefresh: false);
        }
      }
    }
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(matchesProvider(widget.type));
    final myProfile = ref.watch(myProfileProvider).value;
    final isPersonalized = myProfile?.userType?.toString() == "1";
    final isMatchFromAdmin = (isPersonalized && widget.type == MatchType.suggested) || widget.type == MatchType.admin;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final config = ref.watch(appConfigProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAppBar(
              title: isMatchFromAdmin ? "" : widget.title,
              isShowActions: false,
            ),
            if (isMatchFromAdmin)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic brand gradient tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            config.gradientStart.withValues(
                                alpha: isDarkMode ? 0.25 : 0.12),
                            config.gradientEnd.withValues(
                                alpha: isDarkMode ? 0.15 : 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: config.gradientStart.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 13,
                            color: config.gradientStart,
                          ),
                          const Gap(5),
                          Text(
                            'CURATED BY MATCHMAKER',
                            style: AppFont.font(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                              color: config.gradientStart,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'match_from_admin'.tr,
                      style: AppFont.font(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'match_from_admin_sub'.tr,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              key: ValueKey('matches_${widget.type}'),
              child: GenericMemberListView<MemberListModel>(
                state: state,
                isGrid: false,
                scrollController: _scrollController,
                showLoadingMore: true,
                onRefresh: () => ref
                    .read(matchesProvider(widget.type).notifier)
                    .fetchMatches(),
                itemBuilder: (context, member, index) {
                  if (isMatchFromAdmin) {
                    return AdminMatchCard(
                      member: member,
                      matchType: widget.type,
                      isGrid: false,
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ProfileCardWidget(
                      memberModel: member,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
