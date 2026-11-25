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

class OtherProfileDesign4 extends ConsumerStatefulWidget {
  final ProfileData data;
  final String memberId;
  final OtherMemberProfileResponseModel profileResponse;

  const OtherProfileDesign4({
    super.key,
    required this.data,
    required this.memberId,
    required this.profileResponse,
  });

  @override
  ConsumerState<OtherProfileDesign4> createState() => _OtherProfileDesign4State();
}

class _OtherProfileDesign4State extends ConsumerState<OtherProfileDesign4> {
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
    final data = widget.data;
    final images = OtherProfileHelper.getImageList(data);
    final imageHeight = (SizeConfig.screenHeight ?? 800) * 0.62;
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
            // 1. Cover Image Container with Floating Overlapping Action Buttons (Figma Design 4)
            SizedBox(
              height: imageHeight + 28,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Cover Image Container
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: imageHeight,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
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
                                      Colors.black.withValues(alpha: 0.94),
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
                            bottom: 40,
                            left: 20,
                            right: 20,
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
                                const Gap(6),
                                if (displaySubTitle.isNotEmpty)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Icon(Icons.location_on, color: Color(0xFFFF4B6E), size: 14),
                                      ),
                                      const Gap(4),
                                      Expanded(
                                        child: Text(
                                          displaySubTitle,
                                          style: AppFont.font(
                                            fontSize: 12.5,
                                            height: 1.35,
                                            color: Colors.white.withValues(alpha: 0.9),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                const Gap(10),
                                Row(
                                  children: [
                                    // Online Pill
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.45),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF22C55E),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const Gap(5),
                                          Text(
                                            "Online",
                                            style: AppFont.font(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(8),
                                    if (data.idProofStatus == 1)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.45),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.verified_rounded, color: Colors.white, size: 12),
                                            const Gap(4),
                                            Text(
                                              "Verified",
                                              style: AppFont.font(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (data.matchPercent != null && data.matchPercent.toString().isNotEmpty) ...[
                                      const Gap(8),
                                      GestureDetector(
                                        onTap: _scrollToPartnerPreferences,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [theme.primaryColor, theme.colorScheme.secondary],
                                            ),
                                            borderRadius: BorderRadius.circular(16),
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
                                    const Spacer(),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: _buildDesign4ActionRow(context, ref, data, theme, isDark),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),

                  // Interest Status & Action Banner
                  OtherProfileInterestBanner(
                    memberId: widget.memberId,
                    data: data,
                    margin: const EdgeInsets.only(bottom: 20),
                  ),

                  if (aboutText.isNotEmpty) ...[
                    OtherProfileNumberedHeader(
                      number: "01",
                      title: 'about_me'.tr,
                      isExpanded: !_collapsedSections.contains("about"),
                      onToggle: () => setState(() {
                        if (_collapsedSections.contains("about")) {
                          _collapsedSections.remove("about");
                        } else {
                          _collapsedSections.add("about");
                        }
                      }),
                      isDark: isDark,
                    ),
                    const Gap(_kHeaderToContentSpacing),
                    if (!_collapsedSections.contains("about")) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF222438) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final style = AppFont.font(
                              fontSize: 13.5,
                              height: 1.6,
                              color: isDark ? Colors.white70 : const Color(0xFF5A5E78),
                            );
                            final tp = TextPainter(
                              text: TextSpan(text: aboutText, style: style),
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                            )..layout(maxWidth: constraints.maxWidth);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  aboutText,
                                  maxLines: _isAboutExpanded ? null : 3,
                                  overflow: _isAboutExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                  style: style,
                                ),
                                if (tp.didExceedMaxLines) ...[
                                  const Gap(6),
                                  GestureDetector(
                                    onTap: () => setState(() => _isAboutExpanded = !_isAboutExpanded),
                                    child: Text(
                                      _isAboutExpanded ? 'read_less'.tr : 'read_more'.tr,
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                      const Gap(_kSectionSpacing),
                    ],
                  ],

                  // 2. Contact Details Section
                  OtherProfileNumberedHeader(
                    number: "02",
                    title: 'contact_details'.tr,
                    isExpanded: !_collapsedSections.contains("contactDetails"),
                    onToggle: () => setState(() {
                      if (_collapsedSections.contains("contactDetails")) {
                        _collapsedSections.remove("contactDetails");
                      } else {
                        _collapsedSections.add("contactDetails");
                      }
                    }),
                    isDark: isDark,
                  ),
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
                  OtherProfileNumberedHeader(
                    number: "03",
                    title: 'basic_details'.tr,
                    isExpanded: !_collapsedSections.contains("basicDetails"),
                    onToggle: () => setState(() {
                      if (_collapsedSections.contains("basicDetails")) {
                        _collapsedSections.remove("basicDetails");
                      } else {
                        _collapsedSections.add("basicDetails");
                      }
                    }),
                    isDark: isDark,
                  ),
                  const Gap(_kHeaderToContentSpacing),
                  if (!_collapsedSections.contains("basicDetails")) ...[
                    _buildDesign4BasicDetailsCard(data, isDark, theme, hobbyChips),
                    const Gap(_kSectionSpacing),
                  ],

                  // 4. Dynamic Profile Tabs
                  if (data.myProfileTab != null) ...[
                    ...data.myProfileTab!
                        .where((tab) =>
                            tab.sectionId != "basicDetails" &&
                            !(tab.sectionId?.toLowerCase().contains("basic") ?? false) &&
                            tab.sectionId != "photos_section" &&
                            !(tab.sectionId?.toLowerCase().contains("gallery") ?? false) &&
                            !(tab.sectionId?.toLowerCase().contains("photo") ?? false))
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key + 4;
                      final tab = entry.value;
                      final prefix = index < 10 ? "0$index" : "$index";
                      final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OtherProfileNumberedHeader(
                            number: prefix,
                            title: tab.sectionTitle ?? "",
                            isExpanded: !_collapsedSections.contains(sectionId),
                            onToggle: () => setState(() {
                              if (_collapsedSections.contains(sectionId)) {
                                _collapsedSections.remove(sectionId);
                              } else {
                                _collapsedSections.add(sectionId);
                              }
                            }),
                            isDark: isDark,
                          ),
                          const Gap(_kHeaderToContentSpacing),
                          if (!_collapsedSections.contains(sectionId)) ...[
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
                        ],
                      );
                    }),
                  ],

                  // 5. Partner Preferences Section
                  if (data.partnerPreferenceTab != null && data.partnerPreferenceTab!.isNotEmpty) ...[
                    ...data.partnerPreferenceTab!.toList().asMap().entries.map((entry) {
                      final tab = entry.value;
                      final isFirst = entry.key == 0;
                      final dynamicTabsCount = (data.myProfileTab ?? [])
                          .where((t) =>
                              t.sectionId != "basicDetails" &&
                              !(t.sectionId?.toLowerCase().contains("basic") ?? false) &&
                              t.sectionId != "photos_section" &&
                              !(t.sectionId?.toLowerCase().contains("gallery") ?? false) &&
                              !(t.sectionId?.toLowerCase().contains("photo") ?? false))
                          .length;
                      final index = 4 + dynamicTabsCount + entry.key;
                      final prefix = index < 10 ? "0$index" : "$index";
                      final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
                      return Column(
                        key: isFirst ? _partnerPreferenceKey : null,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OtherProfileNumberedHeader(
                            number: prefix,
                            title: tab.sectionTitle ?? "Partner Preferences",
                            isExpanded: !_collapsedSections.contains(sectionId),
                            onToggle: () => setState(() {
                              if (_collapsedSections.contains(sectionId)) {
                                _collapsedSections.remove(sectionId);
                              } else {
                                _collapsedSections.add(sectionId);
                              }
                            }),
                            isDark: isDark,
                          ),
                          const Gap(_kHeaderToContentSpacing),
                          if (!_collapsedSections.contains(sectionId)) ...[
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
                        ],
                      );
                    }),
                    const Gap(_kSectionSpacing),
                  ],

                  // 6. Gallery Section (Bottom)
                  if (images.isNotEmpty) ...[
                    Builder(builder: (context) {
                      final dynamicTabsCount = (data.myProfileTab ?? [])
                          .where((t) =>
                              t.sectionId != "basicDetails" &&
                              !(t.sectionId?.toLowerCase().contains("basic") ?? false) &&
                              t.sectionId != "photos_section" &&
                              !(t.sectionId?.toLowerCase().contains("gallery") ?? false) &&
                              !(t.sectionId?.toLowerCase().contains("photo") ?? false))
                          .length;
                      final partnerCount = (data.partnerPreferenceTab ?? []).length;
                      final index = 4 + dynamicTabsCount + partnerCount;
                      final prefix = index < 10 ? "0$index" : "$index";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OtherProfileNumberedHeader(
                            number: prefix,
                            title: "Gallery",
                            isExpanded: !_collapsedSections.contains("gallery"),
                            onToggle: () => setState(() {
                              if (_collapsedSections.contains("gallery")) {
                                _collapsedSections.remove("gallery");
                              } else {
                                _collapsedSections.add("gallery");
                              }
                            }),
                            isDark: isDark,
                          ),
                          const Gap(_kHeaderToContentSpacing),
                          if (!_collapsedSections.contains("gallery")) ...[
                            OtherProfileGallery(
                              images: images,
                              data: data,
                              memberId: widget.memberId,
                              borderRadius: 20,
                            ),
                            const Gap(_kSectionSpacing),
                          ],
                        ],
                      );
                    }),
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

  Widget _buildDesign4ActionRow(BuildContext context, WidgetRef ref, ProfileData data, ThemeData theme, bool isDark) {
    final isShortlisted = data.isShortlisted == "1" ||
        data.isShortlisted == 1 ||
        data.isShortlisted == true ||
        data.isShortlisted == "Yes";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Star Shortlist (Gold)
        _buildDesign4LightCircleBtn(
          svgPath: isShortlisted ? AppAssets.figmaShortlistSelected : AppAssets.figmaShortlist,
          iconColor: const Color(0xFFFABE2C),
          isDark: isDark,
          onTap: () => OtherProfileHelper.toggleShortlist(
            context: context,
            ref: ref,
            memberId: widget.memberId,
            data: data,
          ),
        ),
        // Video Call (Purple)
        // Video Call (when enabled) OR Block Profile (when video call disabled - block icon)
        _buildDesign4LightCircleBtn(
          svgPath: ref.watch(featureProvider('enableVideoCall')) ? AppAssets.figmaVideoCallOutline : null,
          iconData: ref.watch(featureProvider('enableVideoCall')) ? null : Icons.block_rounded,
          iconColor: const Color(0xFF9333EA),
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
        // Center Elevated Heart Button
        _buildDesign4CenterHeart(data, theme),
        // Chat (Blue)
        if (ref.watch(featureProvider('enableChat')))
          _buildDesign4LightCircleBtn(
            svgPath: AppAssets.figmaChatOutline,
            iconColor: const Color(0xFF2563EB),
            isDark: isDark,
            onTap: () => OtherProfileHelper.openChat(
              context: context,
              ref: ref,
              data: data,
              memberId: widget.memberId,
            ),
          ),
        // Voice Call (when enabled) OR View Contact (when voice call disabled - keep phone icon)
        _buildDesign4LightCircleBtn(
          svgPath: AppAssets.figmaVoiceCallOutline,
          iconColor: const Color(0xFF16A34A),
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
    );
  }

  Widget _buildDesign4LightCircleBtn({
    String? svgPath,
    IconData? iconData,
    required Color iconColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF222438) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: iconData != null
              ? Icon(iconData, color: iconColor, size: 22)
              : SvgPicture.asset(
                  svgPath!,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
        ),
      ),
    );
  }

  Widget _buildDesign4CenterHeart(ProfileData data, ThemeData theme) {
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
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSent || isAccepted
                ? [const Color(0xFF22C55E), const Color(0xFF16A34A)]
                : const [Color(0xFFE8798F), Color(0xFFD64D70)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isSent ? const Color(0xFF22C55E) : const Color(0xFFD64D70)).withValues(alpha: 0.45),
              blurRadius: 20,
              offset: const Offset(0, 8),
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

  Widget _buildDesign4BasicDetailsCard(ProfileData data, bool isDark, ThemeData theme, List<String> hobbyChips) {
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

    final stats = [
      if (calculatedAge.isNotEmpty && calculatedAge != "0")
        {'icon': Icons.calendar_month_outlined, 'label': 'AGE', 'value': '$calculatedAge yrs'},
      if (heightValue.isNotEmpty && heightValue != "N/A" && heightValue != "0")
        {'icon': Icons.straighten_rounded, 'label': 'HEIGHT', 'value': heightValue},
      if (weightValue.isNotEmpty && weightValue != "N/A" && weightValue != "0" && weightValue != "0 kg")
        {'icon': Icons.scale_rounded, 'label': 'WEIGHT', 'value': weightValue.contains('kg') ? weightValue : '$weightValue kg'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top 3 Stat Cards in a row (Age, Height, Weight)
        if (stats.isNotEmpty)
          Row(
            children: stats.map((st) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: st == stats.last ? 0 : 10),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF222438) : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
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
                        child: Icon(st['icon'] as IconData, color: const Color(0xFFFF4B6E), size: 16),
                      ),
                      const Gap(8),
                      Text(
                        st['label'] as String,
                        style: AppFont.font(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white54 : const Color(0xFF8F96AC),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        st['value'] as String,
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
          ),

        // 2. Hobbies Grid (2 Columns pill cards)
        if (hobbyChips.isNotEmpty) ...[
          const Gap(14),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 10) / 2;
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: hobbyChips.map((h) {
                  return SizedBox(
                    width: cardWidth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF222438) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: Color(0xFFFF4B6E), size: 14),
                          const Gap(8),
                          Expanded(
                            child: Text(
                              h,
                              style: AppFont.font(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
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
          ),
        ],

        // 3. Key-Value Card
        const Gap(14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF222438) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFF0F2F8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              if (data.matriId != null && data.matriId.toString().isNotEmpty)
                _buildDesign4TileRow(Icons.badge_outlined, 'Profile ID', data.matriId.toString(), isDark),
              if (dobValue.isNotEmpty && dobValue != "N/A" && dobValue != "null")
                _buildDesign4TileRow(Icons.calendar_today_outlined, 'Date of Birth', dobValue, isDark),
              if (statusValue.isNotEmpty && statusValue != "N/A" && statusValue != "0" && statusValue != "1")
                _buildDesign4TileRow(Icons.favorite_border_rounded, 'Marital Status', statusValue, isDark),
              if (tongueValue.isNotEmpty && tongueValue != "N/A" && tongueValue != "0" && tongueValue != "3")
                _buildDesign4TileRow(Icons.language_rounded, 'Mother Tongue', tongueValue, isDark, isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesign4TileRow(IconData icon, String key, String value, bool isDark, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: isDark ? Colors.white10 : const Color(0xFFF6F7FB))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF4B6E).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFFF4B6E), size: 14),
          ),
          const Gap(10),
          Expanded(
            child: Text(
              key,
              style: AppFont.font(
                fontSize: 13,
                color: isDark ? Colors.white60 : const Color(0xFF8F96AC),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: AppFont.font(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF16182F),
            ),
          ),
        ],
      ),
    );
  }
}
