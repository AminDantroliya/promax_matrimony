import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/features/profile/widgets/other_profile_common_widgets.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';

class OtherProfileDesign5 extends ConsumerStatefulWidget {
  final ProfileData data;
  final String memberId;
  final OtherMemberProfileResponseModel profileResponse;

  const OtherProfileDesign5({
    super.key,
    required this.data,
    required this.memberId,
    required this.profileResponse,
  });

  @override
  ConsumerState<OtherProfileDesign5> createState() => _OtherProfileDesign5State();
}

class _OtherProfileDesign5State extends ConsumerState<OtherProfileDesign5> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contactDetailsKey = GlobalKey();
  final GlobalKey _partnerPreferenceKey = GlobalKey();
  bool _contactRevealed = false;
  bool _isAboutExpanded = false;
  final Set<String> _collapsedSections = {};

  static const double _kSectionSpacing = 24.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToContactDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_contactDetailsKey.currentContext != null) {
        Scrollable.ensureVisible(
          _contactDetailsKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.15,
        );
      }
    });
  }

  void _scrollToPartnerPreferences() {
    setState(() {
      _collapsedSections.removeWhere((id) =>
          id.toLowerCase().contains('partner') ||
          id.toLowerCase().contains('preference'));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_partnerPreferenceKey.currentContext != null) {
        Scrollable.ensureVisible(
          _partnerPreferenceKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    });
  }

  Future<void> _handleViewContact() async {
    await OtherProfileHelper.handleViewContact(
      context: context,
      ref: ref,
      memberId: widget.memberId,
      profileResponse: widget.profileResponse,
      onSuccess: () {
        setState(() {
          _contactRevealed = true;
          _collapsedSections.remove("contactDetails");
        });
        _scrollToContactDetails();
      },
    );
  }

  Future<void> _handleCallAction() async {
    await OtherProfileHelper.handleCallAction(
      context: context,
      ref: ref,
      memberId: widget.memberId,
      profileResponse: widget.profileResponse,
      isRevealed: _contactRevealed,
      onRevealed: () {
        setState(() {
          _contactRevealed = true;
          _collapsedSections.remove("contactDetails");
        });
      },
      scrollToContact: _scrollToContactDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    final Color gradStart = config.gradientStart;
    final Color gradEnd = (config.gradientStart != config.gradientEnd)
        ? config.gradientEnd
        : (theme.primaryColor != theme.colorScheme.secondary
            ? theme.colorScheme.secondary
            : HSLColor.fromColor(gradStart)
                .withLightness((HSLColor.fromColor(gradStart).lightness - 0.15).clamp(0.1, 0.9))
                .toColor());

    final data = widget.data;
    final images = OtherProfileHelper.getImageList(data);
    final displayName = OtherProfileHelper.getDisplayName(data);
    final calculatedAge = OtherProfileHelper.calculateAge(data.birthdate, data.age);
    final displaySubTitle = data.subTitle?.toString().trim() ?? "";
    final hobbyChips = OtherProfileHelper.getHobbyChips(data);
    final isProtected = checkIsPhotoProtected(data);
    final photoUrl = images.isNotEmpty ? images.first : (data.profileImage?.toString() ?? "");
    final headerHeight = (SizeConfig.screenHeight ?? 800) * 0.54;
    final aboutText = OtherProfileHelper.getAboutMeText(data);
    final firstName = data.fullname?.toString().trim().split(' ').first ?? 'Profile';

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF141522)
          : (config.scaffoldBgColor != Colors.transparent
              ? config.scaffoldBgColor
              : theme.scaffoldBackgroundColor),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. Dynamic Gradient Header with Circular Avatar & Title (Figma Design 5)
            Container(
              height: headerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradStart, gradEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(48)),
                boxShadow: [
                  BoxShadow(
                    color: gradEnd.withValues(alpha: 0.35),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(48)),
                child: Stack(
                  children: [
                    // Top-right subtle shimmer circle
                    Positioned(
                      top: -60,
                      right: -60,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    // Bottom-left subtle shimmer circle
                    Positioned(
                      bottom: -40,
                      left: -40,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        MediaQuery.of(context).padding.top + 8,
                        20,
                        20,
                      ),
                      child: Column(
                        children: [
                          // Top App Bar Icons
                          OtherProfileTopAppBar(
                            data: data,
                            memberId: widget.memberId,
                          ),
                          const Spacer(flex: 2),

                          // Large Circular Avatar with Double Ring Glow Border
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Glowing Outer Gradient Ring
                              Container(
                                width: 152,
                                height: 152,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.7),
                                      gradStart,
                                      const Color(0xFFFABE2C),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: gradStart.withValues(alpha: 0.35),
                                      blurRadius: 18,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                              ),
                              // Inner Avatar Container
                              Container(
                                width: 142,
                                height: 142,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? gradEnd : Colors.white,
                                ),
                                child: ClipOval(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      GestureDetector(
                                        onTap: isProtected
                                            ? () => context.push(
                                                  '/send-photo-request',
                                                  extra: OtherProfileHelper.getPhotoExtraParams(images, data, widget.memberId),
                                                )
                                            : () => OtherProfileHelper.openFullScreenImage(context, 0, images),
                                        child: getImageWidget(
                                          url: photoUrl,
                                          boxFit: BoxFit.cover,
                                          isMyPhoto: false,
                                          isProtected: isProtected,
                                          targetGender: data.gender,
                                        ),
                                      ),
                                      if (isProtected)
                                        Positioned.fill(
                                          child: GestureDetector(
                                            onTap: () => context.push(
                                              '/send-photo-request',
                                              extra: OtherProfileHelper.getPhotoExtraParams(images, data, widget.memberId),
                                            ),
                                            child: const ProtectedImageOverlay(
                                              blur: 20,
                                              lockSize: 42,
                                              borderRadius: 80,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              // Green Verified Checkmark Badge on bottom right
                              Positioned(
                                bottom: 6,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF22C55E),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark ? gradEnd : Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),

                          // Premium Member Badge
                          if (ref.watch(featureProvider('showPremiumBadge')) &&
                              checkIsPaid(widget.data))
                            Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4.5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFFABE2C).withValues(alpha: 0.6)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded, color: Color(0xFFFABE2C), size: 13),
                                const Gap(4),
                                Text(
                                  'PREMIUM MEMBER',
                                  style: AppFont.font(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: const Color(0xFFFABE2C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),

                          // Title (Name, Age in Serif with Italic Accent)
                          RichText(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: AppFont.font(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                              children: [
                                TextSpan(text: displayName),
                                if (calculatedAge.isNotEmpty) ...[
                                  const TextSpan(text: ", "),
                                  TextSpan(
                                    text: calculatedAge,
                                    style: AppFont.font(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFE5A88B),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const Gap(6),

                          // Subtitle (Location, Metadata)
                          if (displaySubTitle.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(Icons.location_on, color: Color(0xFFFF4B6E), size: 14),
                                ),
                                const Gap(4),
                                Flexible(
                                  child: Text(
                                    displaySubTitle,
                                    style: AppFont.font(
                                      fontSize: 13,
                                      height: 1.35,
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (data.matchPercent != null && data.matchPercent.toString().isNotEmpty) ...[
                            const Gap(8),
                            GestureDetector(
                              onTap: _scrollToPartnerPreferences,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [gradStart, gradEnd],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: gradEnd.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.favorite_rounded, color: Colors.white, size: 12),
                                    const Gap(4),
                                    Text(
                                      "${data.matchPercent}% Match",
                                      style: AppFont.font(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const Spacer(flex: 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Floating Action Pill Dock
            Container(
              margin: EdgeInsets.only(top: headerHeight - 38),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildDesign5FloatingCapsuleBar(context, ref, data, theme, isDark),
            ),

            // 3. Body Details Content
            Container(
              margin: EdgeInsets.only(top: headerHeight + 56),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Interest Status & Action Banner
                  OtherProfileInterestBanner(
                    memberId: widget.memberId,
                    data: data,
                    margin: const EdgeInsets.only(bottom: 20),
                  ),

                  // 1. About Section
                  if (aboutText.isNotEmpty) ...[
                    _buildDesign5Header("About $firstName", "about", theme, isDark),
                    const Gap(12),
                    if (!_collapsedSections.contains("about")) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF222438) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(Icons.format_quote_rounded, color: theme.primaryColor.withValues(alpha: 0.45), size: 26),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 32),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final textStyle = AppFont.font(
                                    fontSize: 13.5,
                                    height: 1.6,
                                    color: isDark ? Colors.white70 : const Color(0xFF5A5E78),
                                  );

                                  final tp = TextPainter(
                                    text: TextSpan(text: aboutText, style: textStyle),
                                    maxLines: 3,
                                    textDirection: TextDirection.ltr,
                                  )..layout(maxWidth: constraints.maxWidth - 32);

                                  final bool isOverflowing = tp.didExceedMaxLines;

                                  if (!isOverflowing) {
                                    return Text(aboutText, style: textStyle);
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        aboutText,
                                        style: textStyle,
                                        maxLines: _isAboutExpanded ? null : 3,
                                        overflow: _isAboutExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                      ),
                                      const Gap(6),
                                      GestureDetector(
                                        onTap: () => setState(() => _isAboutExpanded = !_isAboutExpanded),
                                        child: Text(
                                          _isAboutExpanded ? 'read_less'.tr : 'read_more'.tr,
                                          style: AppFont.font(
                                            fontSize: 12,
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(_kSectionSpacing),
                    ],
                  ],

                  // 2. Contact Details Section (Immediately below About Me)
                  _buildDesign5Header('contact_details'.tr, "contactDetails", theme, isDark),
                  const Gap(12),
                  if (!_collapsedSections.contains("contactDetails")) ...[
                    OtherProfileContactCard(
                      cardKey: _contactDetailsKey,
                      data: data,
                      isRevealed: _contactRevealed,
                      hasViewedContact: OtherProfileHelper.hasViewedContact(widget.profileResponse.hasViewedContact),
                      onViewContact: _handleViewContact,
                      isDark: isDark,
                    ),
                    const Gap(_kSectionSpacing),
                  ],

                  // 3. Basic Details Section
                  _buildDesign5Header('basic_details'.tr, "basicDetails", theme, isDark),
                  const Gap(12),
                  if (!_collapsedSections.contains("basicDetails")) ...[
                    if (hobbyChips.isNotEmpty) ...[
                      _buildDesign5HobbyGrid(hobbyChips, isDark, theme),
                      const Gap(12),
                    ],
                    _buildDesign5BasicCapsuleCards(data, isDark),
                    const Gap(_kSectionSpacing),
                  ],

                  // 4. Dynamic Remaining Tabs
                  if (data.myProfileTab != null) ...[
                    ...data.myProfileTab!
                        .where((tab) =>
                            tab.sectionId != "basicDetails" &&
                            !(tab.sectionId?.toLowerCase().contains("basic") ?? false) &&
                            tab.sectionId != "photos_section" &&
                            !(tab.sectionId?.toLowerCase().contains("gallery") ?? false) &&
                            !(tab.sectionId?.toLowerCase().contains("photo") ?? false))
                        .map((tab) {
                      final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
                      final isExpanded = !_collapsedSections.contains(sectionId);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDesign5Header(tab.sectionTitle ?? "", sectionId, theme, isDark),
                          const Gap(12),
                          if (isExpanded)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              margin: const EdgeInsets.only(bottom: _kSectionSpacing),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF222438) : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                              ),
                              child: Column(
                                children: [
                                  if (tab.sectionValue != null)
                                    ...tab.sectionValue!
                                        .where((f) => f.value != null && f.value.toString().trim().isNotEmpty && f.value.toString().trim() != "N/A" && f.value.toString().trim() != "[]")
                                        .map((f) => OtherProfileDetailItemRow(label: f.label ?? f.key ?? "", value: f.value.toString(), isDark: isDark)),
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
                  ],

                  // 5. Partner Preferences Section
                  if (data.partnerPreferenceTab != null && data.partnerPreferenceTab!.isNotEmpty) ...[
                    ...data.partnerPreferenceTab!.map((tab) {
                      final isFirst = data.partnerPreferenceTab!.first == tab;
                      final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
                      final isExpanded = !_collapsedSections.contains(sectionId);
                      return Column(
                        key: isFirst ? _partnerPreferenceKey : null,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDesign5Header(tab.sectionTitle ?? "Partner Preferences", sectionId, theme, isDark),
                          const Gap(12),
                          if (isExpanded)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              margin: const EdgeInsets.only(bottom: _kSectionSpacing),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF222438) : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                              ),
                              child: Column(
                                children: [
                                  if (tab.sectionValue != null)
                                    ...tab.sectionValue!
                                        .where((f) => f.value != null && f.value.toString().trim().isNotEmpty && f.value.toString().trim() != "N/A" && f.value.toString().trim() != "[]")
                                        .map((f) => OtherProfileDetailItemRow(label: f.label ?? f.key ?? "", value: f.value.toString(), isDark: isDark)),
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
                    const Gap(_kSectionSpacing),
                  ],

                  // 6. Gallery Section (Bottom)
                  if (images.isNotEmpty) ...[
                    _buildDesign5Header("Gallery", "gallery", theme, isDark),
                    const Gap(12),
                    if (!_collapsedSections.contains("gallery")) ...[
                      _buildDesign5NumberedHorizontalGallery(images, data),
                      const Gap(_kSectionSpacing),
                    ],
                  ],

                  const Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesign5Header(String title, String sectionId, ThemeData theme, bool isDark) {
    final isExpanded = !_collapsedSections.contains(sectionId);

    return InkWell(
      onTap: () {
        setState(() {
          if (_collapsedSections.contains(sectionId)) {
            _collapsedSections.remove(sectionId);
          } else {
            _collapsedSections.add(sectionId);
          }
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppFont.font(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF16182F),
              ),
            ),
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF222438) : const Color(0xFFF4F6FB),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: isDark ? Colors.white60 : const Color(0xFF5E6278),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesign5FloatingCapsuleBar(
    BuildContext context,
    WidgetRef ref,
    ProfileData data,
    ThemeData theme,
    bool isDark,
  ) {
    final isShortlisted = data.isShortlisted == "1" ||
        data.isShortlisted == 1 ||
        data.isShortlisted == true ||
        data.isShortlisted == "Yes";

    return SizedBox(
      height: 76,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // White Capsule Dock
          Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF222438) : Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left group
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 1. Star Shortlist
                      _buildCapsuleCircularBtn(
                        svgPath: isShortlisted ? AppAssets.figmaShortlistSelected : AppAssets.figmaShortlist,
                        iconColor: isShortlisted ? const Color(0xFFFABE2C) : (isDark ? Colors.white70 : const Color(0xFF5E6278)),
                        isDark: isDark,
                        onTap: () => OtherProfileHelper.toggleShortlist(
                          context: context,
                          ref: ref,
                          memberId: widget.memberId,
                          data: data,
                        ),
                      ),
                      // 2. Voice Call (when enabled) OR View Contact (when voice call disabled - keep phone icon)
                      _buildCapsuleCircularBtn(
                        svgPath: AppAssets.figmaVoiceCallOutline,
                        iconColor: isDark ? Colors.white70 : const Color(0xFF5E6278),
                        isDark: isDark,
                        onTap: ref.watch(featureProvider('enableVoiceCall'))
                            ? () => OtherProfileHelper.makeCall(
                                context: context,
                                ref: ref,
                                data: data,
                                memberId: widget.memberId,
                              )
                            : _handleCallAction,
                      ),
                    ],
                  ),
                ),
                // Spacer for Center Heart
                const SizedBox(width: 72),
                // Right group
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 4. Video Call (when enabled) OR Block Profile (when video call disabled - block icon)
                      _buildCapsuleCircularBtn(
                        svgPath: ref.watch(featureProvider('enableVideoCall')) ? AppAssets.figmaVideoCallOutline : null,
                        iconData: ref.watch(featureProvider('enableVideoCall')) ? null : Icons.block_rounded,
                        iconColor: isDark ? Colors.white70 : const Color(0xFF5E6278),
                        isDark: isDark,
                        onTap: ref.watch(featureProvider('enableVideoCall'))
                            ? () => OtherProfileHelper.makeVideoCall(
                                context: context,
                                ref: ref,
                                data: data,
                                memberId: widget.memberId,
                              )
                            : () => OtherProfileHelper.handleBlock(
                                context: context,
                                ref: ref,
                                memberId: widget.memberId,
                                data: data,
                              ),
                      ),
                      // 5. Chat
                      if (ref.watch(featureProvider('enableChat')))
                        _buildCapsuleCircularBtn(
                          svgPath: AppAssets.figmaChatOutline,
                          iconColor: isDark ? Colors.white70 : const Color(0xFF5E6278),
                          isDark: isDark,
                          onTap: () => OtherProfileHelper.openChat(
                            context: context,
                            ref: ref,
                            data: data,
                            memberId: widget.memberId,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Center Elevated Rose Heart Button
          Positioned(
            child: _buildCenterElevatedHeart(data, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildCapsuleCircularBtn({
    String? svgPath,
    IconData? iconData,
    required Color iconColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B1C2A) : const Color(0xFFF3F4F8),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: iconData != null
            ? Icon(iconData, color: iconColor, size: 20)
            : SvgPicture.asset(
                svgPath!,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
      ),
    );
  }

  Widget _buildCenterElevatedHeart(ProfileData data, ThemeData theme) {
    final state = data.interestState?.toLowerCase();
    final status = data.interestStatus?.toLowerCase();
    final isSent = state == "sent" || status == "sent";
    final isAccepted = state == "accepted" || status == "accepted";
    final config = ref.watch(appConfigProvider);
    final Color gradStart = config.gradientStart;
    final Color gradEnd = (config.gradientStart != config.gradientEnd)
        ? config.gradientEnd
        : (theme.primaryColor != theme.colorScheme.secondary
            ? theme.colorScheme.secondary
            : HSLColor.fromColor(gradStart)
                .withLightness((HSLColor.fromColor(gradStart).lightness - 0.15).clamp(0.1, 0.9))
                .toColor());

    return GestureDetector(
      onTap: () => OtherProfileHelper.sendInterest(
        context: context,
        ref: ref,
        memberId: widget.memberId,
        data: data,
      ),
      child: Container(
        height: 74,
        width: 74,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSent || isAccepted
                ? [const Color(0xFF22C55E), const Color(0xFF16A34A)]
                : [gradStart, gradEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isSent || isAccepted ? const Color(0xFF22C55E) : gradStart).withValues(alpha: 0.45),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.figmaSendInterest,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildDesign5HobbyGrid(List<String> hobbies, bool isDark, ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 20) / 3;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: hobbies.map((h) {
            return SizedBox(
              width: cardWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF222438) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4B6E).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.auto_awesome, color: Color(0xFFFF4B6E), size: 16),
                    ),
                    const Gap(8),
                    Text(
                      h,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF16182F),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildDesign5BasicCapsuleCards(ProfileData data, bool isDark) {
    final heightValue = OtherProfileHelper.getTabValueForLabel(
      data,
      'Height',
      directFallback: data.heightStr?.toString() ?? data.height?.toString(),
    );
    final dobValue = OtherProfileHelper.getTabValueForLabel(
      data,
      'Date of Birth',
      directFallback: data.birthdate != null ? getFormattedPlanDate(data.birthdate.toString()) : null,
    );
    final statusValue = OtherProfileHelper.getTabValueForLabel(
      data,
      'Marital Status',
      directFallback: getDisplayString(data.maritalStatus, defaultValue: ""),
    );
    final tongueValue = OtherProfileHelper.getTabValueForLabel(
      data,
      'Mother Tongue',
      directFallback: getDisplayString(data.motherTongue, defaultValue: ""),
    );
    final weightValue = OtherProfileHelper.getTabValueForLabel(
      data,
      'Weight',
      directFallback: data.weight?.toString(),
    );

    final items = [
      if (data.matriId != null && data.matriId.toString().isNotEmpty)
        {'label': 'PROFILE ID', 'value': data.matriId.toString()},
      if (dobValue.isNotEmpty && dobValue != "N/A" && dobValue != "null")
        {'label': 'DATE OF BIRTH', 'value': dobValue},
      if (statusValue.isNotEmpty && statusValue != "N/A" && statusValue != "0" && int.tryParse(statusValue) == null)
        {'label': 'MARITAL STATUS', 'value': statusValue},
      if (tongueValue.isNotEmpty && tongueValue != "N/A" && tongueValue != "0" && int.tryParse(tongueValue) == null)
        {'label': 'MOTHER TONGUE', 'value': tongueValue},
      if (heightValue.isNotEmpty && heightValue != "N/A" && heightValue != "0")
        {'label': 'HEIGHT', 'value': heightValue},
      if (weightValue.isNotEmpty && weightValue != "N/A" && weightValue != "0" && weightValue != "0 kg")
        {'label': 'WEIGHT', 'value': weightValue.contains('kg') ? weightValue : '$weightValue kg'},
    ];

    return Column(
      children: items.map((item) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF222438) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['label']!,
                style: AppFont.font(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: isDark ? Colors.white54 : const Color(0xFF8F96AC),
                ),
              ),
              const Gap(4),
              Text(
                item['value']!,
                style: AppFont.font(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF16182F),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesign5NumberedHorizontalGallery(List<String> images, ProfileData data) {
    final isProtected = checkIsPhotoProtected(data);
    final extraParams = OtherProfileHelper.getPhotoExtraParams(images, data, widget.memberId);

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        separatorBuilder: (_, _) => const Gap(12),
        itemBuilder: (context, index) {
          final numberPrefix = index < 9 ? "0${index + 1}" : "${index + 1}";
          return AspectRatio(
            aspectRatio: 0.72,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: isProtected
                        ? () => context.push('/send-photo-request', extra: extraParams)
                        : () => OtherProfileHelper.openFullScreenImage(context, index, images),
                    child: getImageWidget(
                      url: images[index],
                      boxFit: BoxFit.cover,
                      isProtected: isProtected,
                      targetGender: data.gender,
                    ),
                  ),
                  // Dark bottom gradient for number readability
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.75),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Number Tag (01, 02, 03) matching Figma Design 5
                  Positioned(
                    bottom: 10,
                    left: 12,
                    child: Text(
                      numberPrefix,
                      style: AppFont.font(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (isProtected)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () => context.push('/send-photo-request', extra: extraParams),
                        child: const ProtectedImageOverlay(borderRadius: 20),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
