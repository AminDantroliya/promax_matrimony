import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import '../data/models/event_models.dart';

class BookTicketBottomSheet extends StatefulWidget {
  final EventItem event;
  final Function(int quantity) onNext;

  const BookTicketBottomSheet({
    super.key,
    required this.event,
    required this.onNext,
  });

  static Future<void> show(
    BuildContext context, {
    required EventItem event,
    required Function(int quantity) onNext,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookTicketBottomSheet(
        event: event,
        onNext: onNext,
      ),
    );
  }

  @override
  State<BookTicketBottomSheet> createState() => _BookTicketBottomSheetState();
}

class _BookTicketBottomSheetState extends State<BookTicketBottomSheet> {
  int _selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final sheetBg = isDark ? const Color(0xFF161828) : Colors.white;
    final tintedBoxBg = isDark ? const Color(0xFF222638) : const Color(0xFFF5EFE6);
    final titleColor = isDark ? Colors.white : const Color(0xFF16182F);
    final subtitleColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);
    final iconColor = const Color(0xFF0D9488);

    final maxTickets = widget.event.remainingTickets > 0
        ? (widget.event.remainingTickets < 10
            ? widget.event.remainingTickets
            : 10)
        : 1;

    return Container(
      decoration: BoxDecoration(
        color: sheetBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(16),

            // Header Row: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'book_your_ticket'.tr,
                  style: AppFont.font(
                    color: titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF26293D)
                          : const Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: subtitleColor,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(18),

            // Tinted Event Quick Info Box (Matching Image 3)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: tintedBoxBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date & Time Row
                  Row(
                    children: [
                      // Date
                      if (widget.event.formattedDate.isNotEmpty) ...[
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 18,
                          color: iconColor,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            widget.event.formattedDate,
                            style: AppFont.font(
                              color: titleColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],

                      // Time
                      if (widget.event.formattedTime.isNotEmpty) ...[
                        const Gap(12),
                        Icon(
                          Icons.access_time_rounded,
                          size: 18,
                          color: iconColor,
                        ),
                        const Gap(6),
                        Text(
                          widget.event.formattedTime,
                          style: AppFont.font(
                            color: titleColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Venue Row
                  if (widget.event.venue != null &&
                      widget.event.venue!.trim().isNotEmpty) ...[
                    const Gap(12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: iconColor,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            widget.event.venue!.trim(),
                            style: AppFont.font(
                              color: titleColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Gap(14),

            // Short Description Snippet
            if (widget.event.plainDescription.isNotEmpty) ...[
              Text(
                widget.event.plainDescription,
                style: AppFont.font(
                  color: subtitleColor,
                  fontSize: 13,
                  height: 1.45,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(20),
            ],

            // Bottom Controls: Price Chip, QTY Dropdown, Next Button
            Row(
              children: [
                // Price & Quantity container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: tintedBoxBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price with ticket icon
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.confirmation_number_outlined,
                              size: 18,
                              color: iconColor,
                            ),
                            const Gap(6),
                            Text(
                              widget.event.formattedPrice,
                              style: AppFont.font(
                                color: titleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        // QTY Dropdown
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'qty'.tr,
                              style: AppFont.font(
                                color: subtitleColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(4),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _selectedQuantity,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: subtitleColor,
                                  size: 20,
                                ),
                                dropdownColor: sheetBg,
                                style: AppFont.font(
                                  color: titleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                items: List.generate(
                                  maxTickets,
                                  (index) => DropdownMenuItem(
                                    value: index + 1,
                                    child: Text('${index + 1}'),
                                  ),
                                ),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedQuantity = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(12),

                // Next Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onNext(_selectedQuantity);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9488),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'next'.tr,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
