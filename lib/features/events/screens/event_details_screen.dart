import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/widgets/app_common_background.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import '../data/models/event_models.dart';
import '../providers/event_notifier.dart';
import '../widgets/book_ticket_bottom_sheet.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final int eventId;
  final EventItem? initialEvent;

  const EventDetailsScreen({
    super.key,
    required this.eventId,
    this.initialEvent,
  });

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String? urlStr) async {
    if (urlStr == null || urlStr.trim().isEmpty) return;
    try {
      final uri = Uri.parse(urlStr.trim());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _openBookingSheet(EventItem event) {
    BookTicketBottomSheet.show(
      context,
      event: event,
      onNext: (selectedQty) {
        context.push(
          '/event-confirmation',
          extra: {
            'event': event,
            'quantity': selectedQty,
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailsAsync = ref.watch(eventDetailsProvider(widget.eventId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleColor = isDark ? Colors.white : const Color(0xFF16182F);
    final subtitleColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final cardBg = isDark ? const Color(0xFF161828) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF26293D) : const Color(0xFFE5E7EB);
    const tealColor = Color(0xFF0D9488);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppCommonBackground(
        child: SafeArea(
          child: detailsAsync.when(
            loading: () => widget.initialEvent != null
                ? _buildContent(
                    context,
                    widget.initialEvent!,
                    isDark,
                    titleColor,
                    subtitleColor,
                    cardBg,
                    cardBorder,
                    tealColor,
                  )
                : const Center(child: AppLoadingWidget()),
            error: (err, _) => widget.initialEvent != null
                ? _buildContent(
                    context,
                    widget.initialEvent!,
                    isDark,
                    titleColor,
                    subtitleColor,
                    cardBg,
                    cardBorder,
                    tealColor,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'no_events_found'.tr,
                          style: AppFont.font(color: titleColor, fontSize: 16),
                        ),
                        const Gap(12),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('back_to_events'.tr),
                        ),
                      ],
                    ),
                  ),
            data: (eventData) {
              final event = eventData ?? widget.initialEvent;
              if (event == null) {
                return Center(
                  child: Text(
                    'no_events_found'.tr,
                    style: AppFont.font(color: titleColor, fontSize: 16),
                  ),
                );
              }
              return _buildContent(
                context,
                event,
                isDark,
                titleColor,
                subtitleColor,
                cardBg,
                cardBorder,
                tealColor,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    EventItem event,
    bool isDark,
    Color titleColor,
    Color subtitleColor,
    Color cardBg,
    Color cardBorder,
    Color tealColor,
  ) {
    final images = event.allImages;

    return Column(
      children: [
        // App Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(
                'event_details'.tr,
                style: AppFont.font(
                  color: titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),

        // Scrollable Body
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Image Carousel Banner with Rounded Corners (matching Image 2)
                if (images.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 240,
                      color: isDark ? const Color(0xFF1E2132) : const Color(0xFFF3F4F6),
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: images.length,
                            onPageChanged: (idx) {
                              setState(() {
                                _currentImageIndex = idx;
                              });
                            },
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: images[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.event,
                                    size: 56,
                                    color: subtitleColor,
                                  ),
                                ),
                              );
                            },
                          ),

                          // Dot indicators inside banner at bottom center
                          if (images.length > 1)
                            Positioned(
                              bottom: 12,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images.length,
                                  (idx) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    width: _currentImageIndex == idx ? 16 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: _currentImageIndex == idx
                                          ? tealColor
                                          : Colors.white.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(16),
                ],

                // 2. Title & Price Tag Row (Matching Image 2)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: AppFont.font(
                              color: titleColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (event.formattedDateTime.isNotEmpty) ...[
                            const Gap(6),
                            Text(
                              event.formattedDateTime,
                              style: AppFont.font(
                                color: subtitleColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Gap(12),
                    // Price Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: event.isSoldOut ? const Color(0xFFEF4444) : tealColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: tealColor.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        event.isSoldOut ? 'sold_out'.tr : event.formattedPrice,
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // 3. Description (HTML / Plain text)
                if (event.description != null && event.description!.trim().isNotEmpty) ...[
                  HtmlWidget(
                    event.description!,
                    textStyle: AppFont.font(
                      color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const Gap(20),
                ],

                // 4. Contact & Venue Info Card (Matching Image 2 sidebar)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cardBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black.withValues(alpha: 0.2) : const Color(0x06000000),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Venue
                      if (event.venue != null && event.venue!.trim().isNotEmpty)
                        _buildContactRow(
                          icon: Icons.location_on_outlined,
                          text: event.venue!.trim(),
                          titleColor: titleColor,
                          tealColor: tealColor,
                          onTap: () => _launchUrl(event.mapAddress),
                        ),

                      // Contact Phone
                      if (event.contactNumber != null && event.contactNumber!.trim().isNotEmpty) ...[
                        const Divider(height: 24, thickness: 0.6),
                        _buildContactRow(
                          icon: Icons.phone_outlined,
                          text: event.contactNumber!.trim(),
                          titleColor: titleColor,
                          tealColor: tealColor,
                          onTap: () => _launchUrl('tel:${event.contactNumber!.trim()}'),
                        ),
                      ],

                      // Contact Email
                      if (event.contactEmail != null && event.contactEmail!.trim().isNotEmpty) ...[
                        const Divider(height: 24, thickness: 0.6),
                        _buildContactRow(
                          icon: Icons.mail_outline_rounded,
                          text: event.contactEmail!.trim(),
                          titleColor: titleColor,
                          tealColor: tealColor,
                          onTap: () => _launchUrl('mailto:${event.contactEmail!.trim()}'),
                        ),
                      ],
                    ],
                  ),
                ),
                const Gap(16),

                // 5. Social Media Icons Row (Matching Image 2)
                if (_hasAnySocialLink(event)) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (event.eventInstagramLink?.isNotEmpty == true)
                          _buildSocialButton(
                            Icons.camera_alt_outlined,
                            'Instagram',
                            () => _launchUrl(event.eventInstagramLink),
                            isDark,
                          ),
                        if (event.eventFacebookLink?.isNotEmpty == true)
                          _buildSocialButton(
                            Icons.facebook_outlined,
                            'Facebook',
                            () => _launchUrl(event.eventFacebookLink),
                            isDark,
                          ),
                        if (event.eventYoutubeLink?.isNotEmpty == true)
                          _buildSocialButton(
                            Icons.play_circle_outline_rounded,
                            'YouTube',
                            () => _launchUrl(event.eventYoutubeLink),
                            isDark,
                          ),
                        if (event.eventPinterestLink?.isNotEmpty == true)
                          _buildSocialButton(
                            Icons.push_pin_outlined,
                            'Pinterest',
                            () => _launchUrl(event.eventPinterestLink),
                            isDark,
                          ),
                        if (event.eventTwitterLink?.isNotEmpty == true)
                          _buildSocialButton(
                            Icons.alternate_email_rounded,
                            'X',
                            () => _launchUrl(event.eventTwitterLink),
                            isDark,
                          ),
                      ],
                    ),
                  ),
                  const Gap(16),
                ],

                // 6. Map Address Preview / Action
                if (event.mapAddress != null && event.mapAddress!.trim().isNotEmpty) ...[
                  InkWell(
                    onTap: () => _launchUrl(event.mapAddress),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: cardBorder, width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: tealColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.map_outlined, color: tealColor, size: 24),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'venue'.tr,
                                  style: AppFont.font(
                                    color: subtitleColor,
                                    fontSize: 12,
                                  ),
                                ),
                                const Gap(2),
                                Text(
                                  event.venue?.isNotEmpty == true ? event.venue! : 'open_in_maps'.tr,
                                  style: AppFont.font(
                                    color: titleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: subtitleColor),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24),
                ],
              ],
            ),
          ),
        ),

        // Sticky Bottom "Book Now" Button Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: cardBg,
            border: Border(top: BorderSide(color: cardBorder, width: 1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: event.isSoldOut ? null : () => _openBookingSheet(event),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade400,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  event.isSoldOut ? 'sold_out'.tr : 'book_now'.tr,
                  style: AppFont.font(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String text,
    required Color titleColor,
    required Color tealColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: tealColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: tealColor),
            ),
            const Gap(12),
            Expanded(
              child: Text(
                text,
                style: AppFont.font(
                  color: titleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasAnySocialLink(EventItem event) {
    return (event.eventInstagramLink?.isNotEmpty == true) ||
        (event.eventFacebookLink?.isNotEmpty == true) ||
        (event.eventYoutubeLink?.isNotEmpty == true) ||
        (event.eventPinterestLink?.isNotEmpty == true) ||
        (event.eventTwitterLink?.isNotEmpty == true);
  }

  Widget _buildSocialButton(
    IconData icon,
    String tooltip,
    VoidCallback onTap,
    bool isDark,
  ) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF222538) : const Color(0xFFF3F4F6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: isDark ? Colors.white : const Color(0xFF374151),
        ),
      ),
    );
  }
}
