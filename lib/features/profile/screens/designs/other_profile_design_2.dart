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

class OtherProfileDesign2 extends ConsumerStatefulWidget {
  final ProfileData data;
  final String memberId;
  final OtherMemberProfileResponseModel profileResponse;

  const OtherProfileDesign2({
    super.key,
    required this.data,
    required this.memberId,
    required this.profileResponse,
  });

  @override
  ConsumerState<OtherProfileDesign2> createState() => _OtherProfileDesign2State();
}

class _OtherProfileDesign2State extends ConsumerState<OtherProfileDesign2> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contactDetailsKey = GlobalKey();
  final GlobalKey _partnerPreferenceKey = GlobalKey();
  int _currentPage = 0;
  Timer? _timer;
  bool _contactRevealed = false;
  bool _isAboutExpanded = false;
  final Set<String> _collapsedSections = {};

  static const double _kSectionSpacing = 24.0;
  static const double _kHeaderToContentSpacing = 12.0;
  static const double _kCardToCardSpacing = 10.0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        final images = OtherProfileHelper.getImageList(widget.data);
        if (images.length > 1) {
          if (_pageController.page!.round() >= images.length - 1) {
            _pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToPartnerPreferences() {
    setState(() {
      if (widget.data.partnerPreferenceTab != null) {
        for (final tab in widget.data.partnerPreferenceTab!) {
          final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
          _collapsedSections.remove(sectionId);
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_partnerPreferenceKey.currentContext != null) {
        Scrollable.ensureVisible(
          _partnerPreferenceKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.15,
        );
      }
    });
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
    final data = widget.data;
    final images = OtherProfileHelper.getImageList(data);
    final imageHeight = (SizeConfig.screenHeight ?? 800) * 0.60;
    final displayTitle = OtherProfileHelper.getDisplayTitle(data);
    final displaySubTitle = data.subTitle?.toString().trim() ?? "";
    final hobbyChips = OtherProfileHelper.getHobbyChips(data);
    final isProtected = checkIsPhotoProtected(data);
    final aboutText = OtherProfileHelper.getAboutMeText(data);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF141522) : const Color(0xFFFFFBF9),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Cover Image Stack with Overlapping Floating Capsule Action Bar (Figma Design 2)
            SizedBox(
              height: imageHeight + 34,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Curved bottom cover image container
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: imageHeight,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (idx) => setState(() => _currentPage = idx),
                            itemCount: images.isEmpty ? 1 : images.length,
                            itemBuilder: (context, index) {
                              final photoUrl = images.isNotEmpty ? images[index] : (data.profileImage?.toString() ?? "");
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  GestureDetector(
                                    onTap: isProtected
                                        ? () => context.push(
                                              '/send-photo-request',
                                              extra: OtherProfileHelper.getPhotoExtraParams(images, data, widget.memberId),
                                            )
                                        : () => OtherProfileHelper.openFullScreenImage(context, index, images),
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
                                          lockSize: 48,
                                          borderRadius: 0,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),

                          // Graduated dark overlay
                          Positioned.fill(
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.25),
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.45),
                                      Colors.black.withValues(alpha: 0.92),
                                    ],
                                    stops: const [0.0, 0.35, 0.65, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Top App Bar Icons
                          Positioned(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 16,
                            right: 16,
                            child: OtherProfileTopAppBar(
                              data: data,
                              memberId: widget.memberId,
                            ),
                          ),

                          // Cover Details Overlay
                          Positioned(
                            bottom: 48,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Top Badges & Dash Indicators Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Verified Profile Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.35),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white24),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.verified_user_rounded, color: Colors.white, size: 12),
                                          const Gap(5),
                                          Text(
                                            'VERIFIED PROFILE',
                                            style: AppFont.font(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.8,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (images.length > 1)
                                      Row(
                                        children: List.generate(images.length, (i) {
                                          final isSel = i == _currentPage;
                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 250),
                                            margin: const EdgeInsets.symmetric(horizontal: 2),
                                            width: isSel ? 18 : 8,
                                            height: 3.5,
                                            decoration: BoxDecoration(
                                              color: isSel ? Colors.white : Colors.white.withValues(alpha: 0.4),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          );
                                        }),
                                      ),
                                  ],
                                ),
                                const Gap(8),

                                // Title, Subtitle and Match Pill Row
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Title and Subtitle Column (Left)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            displayTitle,
                                            style: AppFont.font(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: -0.5,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(4),
                                          if (displaySubTitle.isNotEmpty)
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 2),
                                                  child: Icon(Icons.location_on, color: Colors.white70, size: 14),
                                                ),
                                                const Gap(4),
                                                Expanded(
                                                  child: Text(
                                                    displaySubTitle,
                                                    style: AppFont.font(
                                                      fontSize: 13,
                                                      height: 1.35,
                                                      color: Colors.white.withValues(alpha: 0.85),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),

                                    // Match Pill (Right Center)
                                    if (data.matchPercent != null && data.matchPercent.toString().isNotEmpty) ...[
                                      const Gap(12),
                                      GestureDetector(
                                        onTap: _scrollToPartnerPreferences,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [theme.primaryColor, theme.colorScheme.secondary],
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: theme.primaryColor.withValues(alpha: 0.35),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.favorite_rounded, color: Colors.white, size: 14),
                                              const Gap(5),
                                              Text(
                                                "${data.matchPercent}% Match",
                                                style: AppFont.font(
                                                  fontSize: 11.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Floating Translucent Capsule Action Bar Overlapping bottom of cover
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: _buildDesign2FloatingCapsuleBar(context, ref, data, theme, isDark),
                  ),
                ],
              ),
            ),

            const Gap(24),

            // 2. Body Details Content
            Padding(
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

                  // 1. About Me Section with Read More / Read Less
                  if (aboutText.isNotEmpty) ...[
                    _buildDesign2Header('about_me'.tr, "about", theme, isDark),
                    const Gap(_kHeaderToContentSpacing),
                    if (!_collapsedSections.contains("about")) ...[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final textStyle = AppFont.font(
                            fontSize: 14,
                            height: 1.6,
                            color: isDark ? Colors.white70 : const Color(0xFF5A5E78),
                          );

                          final tp = TextPainter(
                            text: TextSpan(text: aboutText, style: textStyle),
                            maxLines: 4,
                            textDirection: TextDirection.ltr,
                          )..layout(maxWidth: constraints.maxWidth);

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
                                maxLines: _isAboutExpanded ? null : 4,
                                overflow: _isAboutExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                              ),
                              const Gap(6),
                              GestureDetector(
                                onTap: () => setState(() => _isAboutExpanded = !_isAboutExpanded),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _isAboutExpanded ? 'read_less'.tr : 'read_more'.tr,
                                        style: AppFont.font(
                                          fontSize: 12,
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Gap(3),
                                      Icon(
                                        _isAboutExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                        size: 14,
                                        color: theme.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Gap(_kSectionSpacing),
                    ],
                  ],

                  // 2. Contact Details Section (Immediately below About Me)
                  _buildDesign2Header('contact_details'.tr, "contactDetails", theme, isDark),
                  const Gap(_kHeaderToContentSpacing),
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
                  _buildDesign2Header('basic_details'.tr, "basicDetails", theme, isDark),
                  const Gap(_kHeaderToContentSpacing),
                  if (!_collapsedSections.contains("basicDetails")) ...[
                    if (hobbyChips.isNotEmpty) ...[
                      _buildDesign2HobbyGrid(hobbyChips, isDark, theme),
                      const Gap(_kCardToCardSpacing),
                    ],

                    // Profile Info ID Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF222438) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PROFILE INFO',
                                style: AppFont.font(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white54 : const Color(0xFF8F96AC),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const Gap(2),
                              Text(
                                'Created by ${OtherProfileHelper.getCreatedByText(data.profileBy)}',
                                style: AppFont.font(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF16182F),
                                ),
                              ),
                            ],
                          ),
                          if (data.matriId != null && data.matriId.toString().isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'ID',
                                  style: AppFont.font(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white54 : const Color(0xFF8F96AC),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const Gap(2),
                                Text(
                                  data.matriId.toString(),
                                  style: AppFont.font(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const Gap(_kCardToCardSpacing),

                    // 2-Column Compact Rounded Stat Cards Grid
                    _buildDesign2TwoColumnStatCards(data, isDark),
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDesign2Header(tab.sectionTitle ?? "", sectionId, theme, isDark),
                          const Gap(_kHeaderToContentSpacing),
                          if (!_collapsedSections.contains(sectionId)) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              margin: const EdgeInsets.only(bottom: _kSectionSpacing),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF222438) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
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
                        ],
                      );
                    }),
                  ],

                  // 5. Partner Preferences Section
                  if (data.partnerPreferenceTab != null && data.partnerPreferenceTab!.isNotEmpty) ...[
                    ...data.partnerPreferenceTab!.map((tab) {
                      final isFirst = data.partnerPreferenceTab!.first == tab;
                      final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
                      return Column(
                        key: isFirst ? _partnerPreferenceKey : null,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDesign2Header(tab.sectionTitle ?? "Partner Preferences", sectionId, theme, isDark),
                          const Gap(_kHeaderToContentSpacing),
                          if (!_collapsedSections.contains(sectionId)) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              margin: const EdgeInsets.only(bottom: _kSectionSpacing),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF222438) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
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
                        ],
                      );
                    }),
                    const Gap(_kSectionSpacing),
                  ],

                  // 6. Gallery Section (Bottom)
                  if (images.isNotEmpty) ...[
                    _buildDesign2Header("Gallery", "gallery", theme, isDark),
                    const Gap(_kHeaderToContentSpacing),
                    if (!_collapsedSections.contains("gallery")) ...[
                      OtherProfileGallery(
                        images: images,
                        data: data,
                        memberId: widget.memberId,
                        borderRadius: 16,
                      ),
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

  Widget _buildDesign2FloatingCapsuleBar(
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

    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF222438) : Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: isDark ? Colors.white10 : Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Star Shortlist
          _buildCapsuleIconButton(
            svgPath: isShortlisted ? AppAssets.figmaShortlistSelected : AppAssets.figmaShortlist,
            iconColor: isShortlisted ? const Color(0xFFFABE2C) : (isDark ? Colors.white70 : const Color(0xFF5E6278)),
            onTap: () => OtherProfileHelper.toggleShortlist(
              context: context,
              ref: ref,
              memberId: widget.memberId,
              data: data,
            ),
          ),
          // Voice Call (when enabled) OR View Contact (when voice call disabled - keep phone icon)
          _buildCapsuleIconButton(
            svgPath: AppAssets.figmaVoiceCallOutline,
            iconColor: isDark ? Colors.white70 : const Color(0xFF5E6278),
            onTap: ref.watch(featureProvider('enableVoiceCall'))
                ? () => OtherProfileHelper.makeCall(
                      context: context,
                      ref: ref,
                      data: data,
                      memberId: widget.memberId,
                    )
                : _handleCallAction,
          ),
          // Center Elevated Heart Button
          _buildCenterElevatedHeart(data, theme),
          // Video Call (when enabled) OR Block Profile (when video call disabled - block icon)
          _buildCapsuleIconButton(
            svgPath: ref.watch(featureProvider('enableVideoCall')) ? AppAssets.figmaVideoCallOutline : null,
            iconData: ref.watch(featureProvider('enableVideoCall')) ? null : Icons.block_rounded,
            iconColor: isDark ? Colors.white70 : const Color(0xFF5E6278),
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
          if (ref.watch(featureProvider('enableChat')))
            _buildCapsuleIconButton(
              svgPath: AppAssets.figmaChatOutline,
              iconColor: isDark ? Colors.white70 : const Color(0xFF5E6278),
              onTap: () => OtherProfileHelper.openChat(
                context: context,
                ref: ref,
                data: data,
                memberId: widget.memberId,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCapsuleIconButton({
    String? svgPath,
    IconData? iconData,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: iconData != null
            ? Icon(iconData, color: iconColor, size: 22)
            : SvgPicture.asset(
                svgPath!,
                width: 22,
                height: 22,
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

    return GestureDetector(
      onTap: () => OtherProfileHelper.sendInterest(
        context: context,
        ref: ref,
        memberId: widget.memberId,
        data: data,
      ),
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSent || isAccepted
                ? [const Color(0xFF22C55E), const Color(0xFF16A34A)]
                : [theme.primaryColor, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isSent ? const Color(0xFF22C55E) : theme.primaryColor).withValues(alpha: 0.45),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.figmaSendInterest,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildDesign2Header(String title, String sectionId, ThemeData theme, bool isDark) {
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
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF16182F),
                letterSpacing: -0.2,
              ),
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF222438) : const Color(0xFFF0F2F8),
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

  Widget _buildDesign2HobbyGrid(List<String> hobbies, bool isDark, ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16) / 3;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: hobbies.take(6).map((hobby) {
            return SizedBox(
              width: itemWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF222438) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: theme.primaryColor, size: 13),
                    const Gap(6),
                    Expanded(
                      child: Text(
                        hobby,
                        style: AppFont.font(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF16182F),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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

  Widget _buildDesign2TwoColumnStatCards(ProfileData data, bool isDark) {
    final calculatedAge = OtherProfileHelper.calculateAge(data.birthdate, data.age);
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

    final rawCards = [
      if (calculatedAge.isNotEmpty && calculatedAge != "0") {'label': 'AGE', 'value': '$calculatedAge yrs'},
      if (heightValue.isNotEmpty && heightValue != "N/A" && heightValue != "0") {'label': 'HEIGHT', 'value': heightValue},
      if (dobValue.isNotEmpty && dobValue != "N/A" && dobValue != "null") {'label': 'DATE OF BIRTH', 'value': dobValue},
      if (statusValue.isNotEmpty && statusValue != "N/A" && statusValue != "0" && int.tryParse(statusValue) == null) {'label': 'STATUS', 'value': statusValue},
      if (tongueValue.isNotEmpty && tongueValue != "N/A" && tongueValue != "0" && int.tryParse(tongueValue) == null) {'label': 'TONGUE', 'value': tongueValue},
      if (weightValue.isNotEmpty && weightValue != "N/A" && weightValue != "0" && weightValue != "0 kg") {'label': 'WEIGHT', 'value': weightValue.contains('kg') ? weightValue : '$weightValue kg'},
    ];

    if (rawCards.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 10) / 2;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: rawCards.map((c) {
            return SizedBox(
              width: cardWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF222438) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      c['label'] ?? '',
                      style: AppFont.font(
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white54 : const Color(0xFF8F96AC),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      c['value'] ?? '',
                      style: AppFont.font(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF16182F),
                      ),
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
}
