import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/widgets/app_common_background.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import '../providers/event_notifier.dart';

class RegisteredEventsScreen extends ConsumerWidget {
  const RegisteredEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registeredEventsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    final titleColor = isDark ? Colors.white : const Color(0xFF16182F);
    final subtitleColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final cardBg = isDark ? const Color(0xFF161828) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF26293D) : const Color(0xFFE5E7EB);
    const tealColor = Color(0xFF0D9488);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppCommonBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF222538) : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: titleColor,
                        ),
                      ),
                    ),
                    const Gap(14),
                    Text(
                      'registered_events'.tr,
                      style: AppFont.font(
                        color: titleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              // Content List
              Expanded(
                child: RefreshIndicator(
                  color: primaryColor,
                  onRefresh: () async {
                    await ref
                        .read(registeredEventsProvider.notifier)
                        .fetchRegisteredEvents();
                  },
                  child: state.isLoading && state.items.isEmpty
                      ? const Center(child: AppLoadingWidget())
                      : state.items.isEmpty
                          ? ListView(
                              children: [
                                const Gap(60),
                                AppNoRecordsWidget(
                                  noRecordFoundMessage: 'no_registered_events'.tr,
                                ),
                              ],
                            )
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              itemCount: state.items.length,
                              separatorBuilder: (context, index) => const Gap(14),
                              itemBuilder: (context, index) {
                                final item = state.items[index];
                                final event = item.event;

                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: cardBorder, width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? Colors.black.withValues(alpha: 0.25)
                                            : const Color(0x06000000),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Top row: Booking ID & Status Pill
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${'booking_id'.tr} #${item.id}',
                                            style: AppFont.font(
                                              color: subtitleColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: tealColor.withValues(alpha: 0.12),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              item.paymentStatus
                                                      ?.toUpperCase() ??
                                                  'CONFIRMED',
                                              style: AppFont.font(
                                                color: tealColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(10),

                                      // Event Title
                                      Text(
                                        event?.title ??
                                            'Event #${item.eventId ?? item.id}',
                                        style: AppFont.font(
                                          color: titleColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      // Venue & Date
                                      if (event != null &&
                                          (event.venue?.isNotEmpty == true ||
                                              event.formattedDate.isNotEmpty)) ...[
                                        const Gap(6),
                                        Row(
                                          children: [
                                            if (event.venue?.isNotEmpty == true) ...[
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 14,
                                                color: subtitleColor,
                                              ),
                                              const Gap(4),
                                              Text(
                                                event.venue!,
                                                style: AppFont.font(
                                                  color: subtitleColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Gap(10),
                                            ],
                                            if (event.formattedDate.isNotEmpty) ...[
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                size: 13,
                                                color: subtitleColor,
                                              ),
                                              const Gap(4),
                                              Text(
                                                event.formattedDate,
                                                style: AppFont.font(
                                                  color: subtitleColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                      const Divider(height: 20, thickness: 0.6),

                                      // Ticket count & Price summary
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'tickets_booked_lbl'.tr,
                                                style: AppFont.font(
                                                  color: subtitleColor,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              const Gap(2),
                                              Text(
                                                '${item.ticketsQty} ${'tickets'.tr.toLowerCase()}',
                                                style: AppFont.font(
                                                  color: titleColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'total_payment'.tr,
                                                style: AppFont.font(
                                                  color: subtitleColor,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              const Gap(2),
                                              Text(
                                                item.formattedTotal,
                                                style: AppFont.font(
                                                  color: tealColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // Payment Mode & Transaction ID
                                      if (item.transactionId?.isNotEmpty == true ||
                                          item.paymentMode?.isNotEmpty == true) ...[
                                        const Gap(8),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? const Color(0xFF222538)
                                                : const Color(0xFFF9FAFB),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '${item.paymentMode ?? ''} ${item.transactionId != null ? '• ${item.transactionId}' : ''}'
                                                .trim(),
                                            style: AppFont.font(
                                              color: subtitleColor,
                                              fontSize: 11,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
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
