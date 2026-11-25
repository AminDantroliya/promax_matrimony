import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import '../data/models/event_models.dart';

class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    final cardBg = isDark ? const Color(0xFF161828) : Colors.white;
    final borderColor = isDark ? const Color(0xFF26293D) : const Color(0xFFE5E7EB);
    final titleColor = isDark ? Colors.white : const Color(0xFF16182F);
    final subtitleColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : const Color(0x0A000000),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: primaryColor.withValues(alpha: 0.1),
          highlightColor: primaryColor.withValues(alpha: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image Banner with Price / Sold out Tag
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: event.bannerImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: event.bannerImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: isDark
                                  ? const Color(0xFF222538)
                                  : const Color(0xFFF3F4F6),
                              child: const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: isDark
                                  ? const Color(0xFF222538)
                                  : const Color(0xFFF3F4F6),
                              child: Icon(
                                Icons.event_rounded,
                                size: 48,
                                color: isDark
                                    ? const Color(0xFF4B5563)
                                    : const Color(0xFF9CA3AF),
                              ),
                            ),
                          )
                        : Container(
                            color: isDark
                                ? const Color(0xFF222538)
                                : const Color(0xFFF3F4F6),
                            child: Icon(
                              Icons.event_rounded,
                              size: 48,
                              color: isDark
                                  ? const Color(0xFF4B5563)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                  ),

                  // Top Right Tag (Price or Sold Out)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: event.isSoldOut
                            ? const Color(0xFFEF4444)
                            : (primaryColor != Colors.transparent
                                ? primaryColor
                                : const Color(0xFF0D9488)),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        event.isSoldOut
                            ? 'sold_out'.tr
                            : event.formattedPrice,
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Event Information Area
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date & Time
                    if (event.formattedDateTime.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: subtitleColor,
                          ),
                          const Gap(6),
                          Expanded(
                            child: Text(
                              event.formattedDateTime,
                              style: AppFont.font(
                                color: subtitleColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                    ],

                    // Title
                    Text(
                      event.title,
                      style: AppFont.font(
                        color: titleColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Description snippet
                    if (event.plainDescription.isNotEmpty) ...[
                      const Gap(6),
                      Text(
                        event.plainDescription,
                        style: AppFont.font(
                          color: subtitleColor,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    // Venue chip at bottom
                    if (event.venue != null && event.venue!.trim().isNotEmpty) ...[
                      const Gap(10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: primaryColor,
                          ),
                          const Gap(4),
                          Expanded(
                            child: Text(
                              event.venue!.trim(),
                              style: AppFont.font(
                                color: titleColor.withValues(alpha: 0.8),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
    );
  }
}
