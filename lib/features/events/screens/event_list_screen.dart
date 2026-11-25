import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/widgets/app_common_background.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import '../providers/event_notifier.dart';
import '../widgets/event_card.dart';

class EventListScreen extends ConsumerStatefulWidget {
  const EventListScreen({super.key});

  @override
  ConsumerState<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends ConsumerState<EventListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(eventListProvider.notifier).loadMore();
    }
  }

  void _performSearch() {
    FocusScope.of(context).unfocus();
    ref
        .read(eventListProvider.notifier)
        .fetchEvents(isRefresh: true, keyword: _searchController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    final titleColor = isDark ? Colors.white : const Color(0xFF16182F);
    final subtitleColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final searchBg = isDark ? const Color(0xFF1A1C2E) : Colors.white;
    final searchBorder = isDark ? const Color(0xFF2E324B) : const Color(0xFFE5E7EB);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppCommonBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    if (Navigator.of(context).canPop()) ...[
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF222538)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: titleColor,
                          ),
                        ),
                      ),
                      const Gap(12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'events'.tr,
                            style: AppFont.font(
                              color: titleColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            'events_subtitle'.tr,
                            style: AppFont.font(
                              color: subtitleColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Action: Registered Events / My Bookings Button
                    IconButton(
                      tooltip: 'registered_events'.tr,
                      onPressed: () => context.push('/registered-events'),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.confirmation_number_outlined,
                          size: 20,
                          color: Color(0xFF0D9488),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar matching Image 1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: searchBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: searchBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.25)
                            : const Color(0x08000000),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (_) => _performSearch(),
                          style: AppFont.font(
                            color: titleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'search_keywords_hint'.tr,
                            hintStyle: AppFont.font(
                              color: subtitleColor,
                              fontSize: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.clear, size: 18, color: subtitleColor),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch();
                          },
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Material(
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: _performSearch,
                            borderRadius: BorderRadius.circular(10),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.search_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(6),

              // Events List View
              Expanded(
                child: RefreshIndicator(
                  color: primaryColor,
                  onRefresh: () async {
                    await ref.read(eventListProvider.notifier).fetchEvents(
                          isRefresh: true,
                          keyword: _searchController.text.trim(),
                        );
                  },
                  child: state.isLoading && state.events.isEmpty
                      ? const Center(child: AppLoadingWidget())
                      : state.events.isEmpty
                          ? ListView(
                              children: [
                                const Gap(60),
                                AppNoRecordsWidget(
                                  noRecordFoundMessage: 'no_events_found'.tr,
                                ),
                              ],
                            )
                          : ListView.separated(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 24,
                              ),
                              itemCount:
                                  state.events.length + (state.isLoadingMore ? 1 : 0),
                              separatorBuilder: (context, index) => const Gap(16),
                              itemBuilder: (context, index) {
                                if (index >= state.events.length) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final event = state.events[index];
                                return EventCard(
                                  event: event,
                                  onTap: () {
                                    context.push('/events/${event.id}', extra: event);
                                  },
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
