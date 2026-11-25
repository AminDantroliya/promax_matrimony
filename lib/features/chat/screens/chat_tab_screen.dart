import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/features/chat/providers/chat_notifier.dart';
import 'package:pro_matrimony/features/chat/screens/chat_member_list_screen.dart';
import 'package:pro_matrimony/utils/utils.dart';

class ChatTabScreen extends ConsumerStatefulWidget {
  const ChatTabScreen({super.key});

  @override
  ConsumerState<ChatTabScreen> createState() => _MessageTabScreenState();
}

class _MessageTabScreenState extends ConsumerState<ChatTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
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
    final recentState = ref.watch(chatMemberListProvider("recent_chat"));
    final onlineState = ref.watch(chatMemberListProvider("online"));

    final recentCount = recentState.totalCount;
    final onlineCount = onlineState.totalCount;

    return Column(
      children: [
        _buildSearchField(isDark),
        AppTabBar(
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
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ChatListTabContent(
                type: "recent_chat",
                searchQuery: _searchQuery,
              ),
              ChatListTabContent(type: "online", searchQuery: _searchQuery),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFFEEF0F6),
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
          prefixIcon: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: SvgPicture.asset(
              AppAssets.figmaSearch,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          hintText: 'search_conversations'.tr,
          hintStyle: AppFont.font(
            color: const Color(0xFF8E90A6),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: AppFont.font(
          fontSize: 14,
          color: isDark ? Colors.white : const Color(0xFF1E202C),
        ),
      ),
    );
  }
}
