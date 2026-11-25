import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/utils/api_urls.dart';

import '../../../features/common/data/models/member_models.dart';
import '../data/repositories/activity_repository.dart';
import '../widgets/call_history_list_item.dart';
import '../../../widgets/app_no_records_widget.dart';

class CallHistoryItem {
  final MemberListModel member;
  final bool isVideo;
  CallHistoryItem({required this.member, required this.isVideo});
}

class CallHistoryScreen extends ConsumerStatefulWidget {
  const CallHistoryScreen({super.key});

  @override
  ConsumerState<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends ConsumerState<CallHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 1;
  int _incomingCount = 0;
  int _outgoingCount = 0;
  int _missedCount = 0;
  Timer? _searchDebounce;
  List<CallHistoryItem> _allCalls = [];
  List<CallHistoryItem> _filteredCalls = [];
  String _searchQuery = "";
  String _selectedFilter = "All"; // "All", "Missed", "Video", "Voice"

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCalls();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreCalls();
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchCalls() async {
    setState(() {
      _isLoading = true;
      _page = 1;
      _hasMore = true;
      _allCalls = [];
    });
    await _loadCalls(isRefresh: true);
  }

  Future<void> _loadCalls({required bool isRefresh}) async {
    try {
      final repository = ref.read(activityRepositoryProvider);

      String typeParam = "";
      if (_selectedFilter == "Voice") {
        typeParam = "voice";
      } else if (_selectedFilter == "Video") {
        typeParam = "video";
      } else if (_selectedFilter == "Missed") {
        typeParam = "missed";
      }

      final params = {
        "page": _page.toString(),
        "limit": "15",
        "type": typeParam,
        "search_keyword": _searchQuery,
      };

      final response = await repository.getActivityProfileList(
        videoCallHistoryListApi,
        params,
      );

      final callList = response.data?.resultArr ?? [];

      if (response.data?.incomingCount != null) {
        _incomingCount = response.data!.incomingCount!;
      }
      if (response.data?.outgoingCount != null) {
        _outgoingCount = response.data!.outgoingCount!;
      }
      if (response.data?.missedCount != null) {
        _missedCount = response.data!.missedCount!;
      }

      if (callList.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
          _isLoadingMore = false;
          if (isRefresh) {
            _allCalls = [];
            _filteredCalls = [];
          }
        });
        return;
      }

      final list = <CallHistoryItem>[];
      for (final c in callList) {
        final typeStr = (c.sendType ?? "").toString().toLowerCase();
        final isVideo = typeStr.contains("video") || (_selectedFilter == "Video");
        list.add(CallHistoryItem(member: c, isVideo: isVideo));
      }

      setState(() {
        if (isRefresh) {
          _allCalls = list;
        } else {
          _allCalls.addAll(list);
        }

        // Sort by date descending
        _allCalls.sort((a, b) {
          final da = DateTime.tryParse(a.member.sentDate ?? "") ?? DateTime(1970);
          final db = DateTime.tryParse(b.member.sentDate ?? "") ?? DateTime(1970);
          return db.compareTo(da);
        });

        _isLoading = false;
        _isLoadingMore = false;
        _applyFilter();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
      showToast("Failed to fetch call history");
    }
  }

  Future<void> _loadMoreCalls() async {
    if (_isLoading || _isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);
    _page++;
    await _loadCalls(isRefresh: false);
  }

  bool _isZeroMinute(dynamic activeCallMinute) {
    if (activeCallMinute == null) return true;
    if (activeCallMinute is num) return activeCallMinute == 0;
    final str = activeCallMinute.toString().trim();
    if (str.isEmpty || str == "0" || str == "0.0") return true;
    final val = num.tryParse(str);
    return val == null || val == 0;
  }

  void _applyFilter() {
    final query = _searchQuery.toLowerCase().trim();
    final filtered = _allCalls.where((item) {
      final name = (item.member.fullname ?? "").toString().toLowerCase();
      final id = (item.member.matriId ?? "").toString().toLowerCase();
      final matchesSearch =
          query.isEmpty || name.contains(query) || id.contains(query);

      if (!matchesSearch) return false;

      if (_selectedFilter == "Missed") {
        return _isZeroMinute(item.member.activeCallMinute);
      } else if (_selectedFilter == "Video") {
        return item.isVideo;
      } else if (_selectedFilter == "Voice") {
        return !item.isVideo;
      }

      return true;
    }).toList();

    setState(() {
      _filteredCalls = filtered;
    });
  }

  Map<String, List<CallHistoryItem>> _groupCalls(List<CallHistoryItem> items) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    final groups = <String, List<CallHistoryItem>>{
      "TODAY": [],
      "YESTERDAY": [],
      "EARLIER": [],
    };

    for (final item in items) {
      final dt = DateTime.tryParse(item.member.sentDate ?? "");
      if (dt == null) {
        groups["EARLIER"]!.add(item);
        continue;
      }

      if (dt.year == today.year && dt.month == today.month && dt.day == today.day) {
        groups["TODAY"]!.add(item);
      } else if (dt.year == yesterday.year && dt.month == yesterday.month && dt.day == yesterday.day) {
        groups["YESTERDAY"]!.add(item);
      } else {
        groups["EARLIER"]!.add(item);
      }
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final int incoming = _incomingCount;
    final int outgoing = _outgoingCount;
    final int missed = _missedCount;

    final groups = _groupCalls(_filteredCalls);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0C0D16) : const Color(0xFFFAF7F5),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchCalls,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              _buildFigmaAppBar(context, isDark),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _buildFigmaInsightsCard(incoming, outgoing, missed, isDark),
                      _buildFigmaSearchField(isDark),
                      const Gap(14),
                      _buildFigmaTabs(isDark),
                      const Gap(10),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (_filteredCalls.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: AppNoRecordsWidget(
                            noRecordFoundMessage: 'no_calls_found'.tr,
                          ),
                        )
                      else ...[
                        if (groups["TODAY"]!.isNotEmpty)
                          _buildSectionList("TODAY", groups["TODAY"]!),
                        if (groups["YESTERDAY"]!.isNotEmpty)
                          _buildSectionList("YESTERDAY", groups["YESTERDAY"]!),
                        if (groups["EARLIER"]!.isNotEmpty)
                          _buildSectionList("EARLIER", groups["EARLIER"]!),
                      ],
                      if (_isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      const Gap(40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top Navigation App Bar (Figma Design) ──────────────────────────────────
  Widget _buildFigmaAppBar(BuildContext context, bool isDark) {
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 6),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaBack,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ),
          const Gap(14),

          // Title: "Call History"
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Call ",
                    style: AppFont.font(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF16182F),
                      letterSpacing: -0.3,
                    ),
                  ),
                  TextSpan(
                    text: "History",
                    style: AppFont.font(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Notifications Button
          GestureDetector(
            onTap: () => context.push('/notifications'),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.figmaNotifications,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondary,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                  ),
                  Positioned(
                    top: 11,
                    right: 12,
                    child: Container(
                      height: 7,
                      width: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8446B),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Gap(10),

          // Settings Button
          GestureDetector(
            onTap: () => context.push('/settings'),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF23253B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.figmaSettings,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top Insights Card (Preserved layout with all white icons) ───────────────
  Widget _buildFigmaInsightsCard(int incoming, int outgoing, int missed, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF180A22).withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: FigmaColors.primaryGradient(context),
                ),
              ),
            ),
            Positioned(
              top: -150,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -120,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'call_insights'.tr,
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            'this_week_activity'.tr,
                            style: AppFont.font(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppAssets.figmaInsights,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInsightItem(
                        AppAssets.figmaIncomingCall,
                        incoming.toString().padLeft(2, '0'),
                        "incoming",
                        Colors.white, // All top card icons white
                      ),
                      _buildInsightDivider(),
                      _buildInsightItem(
                        AppAssets.figmaOutgoingCall,
                        outgoing.toString().padLeft(2, '0'),
                        "outgoing",
                        Colors.white, // All top card icons white
                      ),
                      _buildInsightDivider(),
                      _buildInsightItem(
                        AppAssets.figmaMissedCall,
                        missed.toString().padLeft(2, '0'),
                        "missed",
                        Colors.white, // All top card icons white
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

  Widget _buildInsightDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withValues(alpha: 0.15),
    );
  }

  Widget _buildInsightItem(String svgPath, String value, String label, Color iconColor) {
    return Expanded(
      child: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: AppFont.font(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    svgPath,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    width: 18,
                    height: 18,
                  ),
                  const Gap(6),
                  Text(
                    label.tr,
                    style: AppFont.font(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Search Field ──────────────────────────────────────────────────────────
  Widget _buildFigmaSearchField(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFEEF0F6),
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
          _searchQuery = val;
          _searchDebounce?.cancel();
          _searchDebounce = Timer(const Duration(milliseconds: 400), () {
            _fetchCalls();
          });
        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 10),
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
          prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          hintText: 'search_calls'.tr,
          hintStyle: AppFont.font(
            color: const Color(0xFF8E90A6),
            fontSize: 14,
            fontWeight: FontWeight.w500,
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

  // ── Figma Pill Tabs (All, Missed, Video, Voice) ───────────────────────────
  Widget _buildFigmaTabs(bool isDark) {
    final tabs = [
      {"key": "All", "label": "All", "svg": AppAssets.figmaVoiceCallOutline},
      {"key": "Missed", "label": "Missed", "svg": AppAssets.figmaMissedCall},
      {"key": "Video", "label": "Video", "svg": AppAssets.figmaVideoCallOutline},
      {"key": "Voice", "label": "Voice", "svg": AppAssets.figmaVoiceCallOutline},
    ];

    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = _selectedFilter == tab["key"];
          final label = tab["label"] as String;
          final svgPath = tab["svg"] as String;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  if (_selectedFilter != tab["key"]) {
                    setState(() {
                      _selectedFilter = tab["key"] as String;
                    });
                    _applyFilter();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryColor
                        : (isDark ? const Color(0xFF161722) : Colors.white),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected
                          ? primaryColor
                          : (isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFEEF0F6)),
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        svgPath,
                        width: 14,
                        height: 14,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? Colors.white
                              : (isDark ? Colors.white70 : const Color(0xFF555770)),
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        label,
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? Colors.white70 : const Color(0xFF555770)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Section List with Figma Count Accent ──────────────────────────────────
  Widget _buildSectionList(String title, List<CallHistoryItem> items) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF8E90A6),
                  letterSpacing: 0.8,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.figmaVoiceCallOutline,
                    width: 13,
                    height: 13,
                    colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  ),
                  const Gap(4),
                  Text(
                    '${items.length} calls',
                    style: AppFont.font(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return CallHistoryListItem(
              member: items[index].member,
              index: index,
              isVideo: items[index].isVideo,
            );
          },
        ),
      ],
    );
  }
}
