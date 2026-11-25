import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';

import '../providers/chat_notifier.dart';
import '../widgets/chat_list_item.dart';

class ChatMemberListScreen extends ConsumerStatefulWidget {
  const ChatMemberListScreen({super.key});

  @override
  ConsumerState<ChatMemberListScreen> createState() => _ChatMemberListScreenState();
}

class _ChatMemberListScreenState extends ConsumerState<ChatMemberListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _selectedTab = _tabController.index;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatMemberListProvider("recent_chat").notifier).fetchMembers();
      ref.read(chatMemberListProvider("online").notifier).fetchMembers();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0C0D16) : const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            _buildFigmaAppBar(context, isDark),
            const Gap(10),
            _buildFigmaSearchField(isDark),
            _buildTabSelector(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ChatListTabContent(type: "recent_chat", searchQuery: _searchQuery),
                  ChatListTabContent(type: "online", searchQuery: _searchQuery),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigmaAppBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppTitleWidget(context, 'inbox_messages'.tr),
                const Gap(2),
                Text(
                  'connect_with_your_matches'.tr,
                  style: AppFont.font(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8E90A6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFigmaSearchField(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFEEF0F6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark
                ? const Color(0xFF8E90A6)
                : Theme.of(context).primaryColor,
            size: 20,
          ),
          hintText: 'search_messages'.tr,
          hintStyle: AppFont.font(
            color: const Color(0xFF8E90A6),
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: AppFont.font(
          fontSize: 14,
          color: isDark ? Colors.white : const Color(0xFF1E202C),
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    final recentState = ref.watch(chatMemberListProvider("recent_chat"));
    final onlineState = ref.watch(chatMemberListProvider("online"));
    final recentCount = recentState.items.length;
    final onlineCount = onlineState.items.length;

    return AppTabBar(
      tabs: ['recent_chat'.tr, 'online_member'.tr],
      badgeTexts: [
        recentCount.toString(),
        onlineCount.toString(),
      ],
      selectedIndex: _selectedTab,
      onTap: (v) {
        setState(() {
          _selectedTab = v;
          _tabController.animateTo(v);
        });
      },
    );
  }
}

class ChatListTabContent extends ConsumerStatefulWidget {
  final String type;
  final String searchQuery;
  const ChatListTabContent({super.key, required this.type, this.searchQuery = ""});

  @override
  ConsumerState<ChatListTabContent> createState() => _ChatListTabContentState();
}

class _ChatListTabContentState extends ConsumerState<ChatListTabContent> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(chatMemberListProvider(widget.type));
      if (state.items.isEmpty && !state.isLoading) {
        ref.read(chatMemberListProvider(widget.type).notifier).fetchMembers(isRefresh: true, searchKeyword: widget.searchQuery);
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        ref.read(chatMemberListProvider(widget.type).notifier).fetchMembers(isRefresh: false);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ChatListTabContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        if (mounted) {
          ref.read(chatMemberListProvider(widget.type).notifier).fetchMembers(
            isRefresh: true,
            searchKeyword: widget.searchQuery,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatMemberListProvider(widget.type));

    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: AppLoadingWidget());
    }

    final query = widget.searchQuery.toLowerCase().trim();
    final filteredItems = state.items.where((member) {
      final name = (member.fullname ?? member.profileTitle ?? "").toString().toLowerCase();
      final msg = (member.lastMessageText ?? "").toString().toLowerCase();
      return query.isEmpty || name.contains(query) || msg.contains(query);
    }).toList();

    Future<void> handleRefresh() async {
      await ref.read(chatMemberListProvider(widget.type).notifier).fetchMembers(
        isRefresh: true,
        searchKeyword: widget.searchQuery,
      );
    }

    if (filteredItems.isEmpty && !state.isLoading) {
      return RefreshIndicator(
        onRefresh: handleRefresh,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: const AppNoRecordsWidget(),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: handleRefresh,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              itemBuilder: (context, index) {
                return ChatListItem(member: filteredItems[index]);
              },
            ),
          ),
          if (state.isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LoadingPaginationWidget(show: true),
            ),
        ],
      ),
    );
  }
}
