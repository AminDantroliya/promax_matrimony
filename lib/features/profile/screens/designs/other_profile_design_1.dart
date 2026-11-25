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

class OtherProfileDesign1 extends ConsumerStatefulWidget {
  final ProfileData data;
  final String memberId;
  final OtherMemberProfileResponseModel profileResponse;

  const OtherProfileDesign1({
    super.key,
    required this.data,
    required this.memberId,
    required this.profileResponse,
  });

  @override
  ConsumerState<OtherProfileDesign1> createState() => _OtherProfileDesign1State();
}

class _OtherProfileDesign1State extends ConsumerState<OtherProfileDesign1> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contactDetailsKey = GlobalKey();
  final GlobalKey _partnerPreferenceKey = GlobalKey();
  int _currentPage = 0;
  Timer? _timer;
  bool _contactRevealed = false;
  final Set<String> _collapsedSections = {};

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
    final imageHeight = (SizeConfig.screenHeight ?? 800) * 0.68;
    final displayTitle = OtherProfileHelper.getDisplayTitle(data);
    final displaySubTitle = data.subTitle?.toString().trim() ?? "";
    final aboutText = OtherProfileHelper.getAboutMeText(data);
    final hobbyChips = OtherProfileHelper.getHobbyChips(data);
    final basicTab = data.myProfileTab?.cast<TabData?>().firstWhere(
      (tab) =>
          tab != null &&
          (tab.sectionId == "basicDetails" ||
              (tab.sectionId?.toLowerCase().contains("basic") ?? false) ||
              (tab.sectionTitle?.toLowerCase().contains("basic") ?? false)),
      orElse: () => null,
    );
    final basicDetailsFields = basicTab?.sectionValue
            ?.where((f) =>
                f.value != null &&
                f.value.toString().trim().isNotEmpty &&
                f.value.toString().trim() != "N/A" &&
                f.value.toString().trim() != "null" &&
                f.value.toString().trim() != "[]" &&
                f.key != "hobbies" &&
                f.key != "hobby" &&
                !(f.label?.toLowerCase().contains("hobby") ?? false))
            .toList() ??
        [];
    final hasDob = basicDetailsFields.any((f) {
      final k = f.key?.toLowerCase() ?? "";
      final l = f.label?.toLowerCase() ?? "";
      return k.contains("birth") || l.contains("birth") || k == "dob";
    });
    final hasMatriId = basicDetailsFields.any((f) {
      final k = f.key?.toLowerCase() ?? "";
      final l = f.label?.toLowerCase() ?? "";
      return k == "profile_id" || k == "matri_id" || l.contains("profile id");
    });
    final isProtected = checkIsPhotoProtected(data);

    return SingleChildScrollView(
      controller: _scrollController,
      child: Stack(
        children: [
          // Hero Image Carousel
          SizedBox(
            height: imageHeight,
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

                // Elegant Top Gradient
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.65),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Top Actions Header (Unified)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 16,
                  right: 16,
                  child: OtherProfileTopAppBar(
                    memberId: widget.memberId,
                    data: data,
                  ),
                ),

                // Dark Bottom Gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 240,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ),


                // User Info Overlay
                Positioned(
                  bottom: 155,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              displayTitle,
                              style: AppFont.font(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(6),
                          const Icon(
                            Icons.verified,
                            color: Color(0xFF22C55E),
                            size: 20,
                          ),
                        ],
                      ),
                      if (displaySubTitle.isNotEmpty) ...[
                        const Gap(4),
                        Text(
                          displaySubTitle,
                          style: AppFont.font(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.9),
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Match Percentage (Left) & Image Dots Indicator (Right)
                if ((data.matchPercent != null && data.matchPercent.toString().isNotEmpty) || images.length > 1)
                  Positioned(
                    bottom: 110,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Match percentage pill
                        if (data.matchPercent != null && data.matchPercent.toString().isNotEmpty)
                          GestureDetector(
                            onTap: _scrollToPartnerPreferences,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [theme.primaryColor, theme.colorScheme.secondary],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.favorite, color: Colors.white, size: 13),
                                  const Gap(5),
                                  Text(
                                    "${data.matchPercent}% ${'match'.tr.toUpperCase()}",
                                    style: AppFont.font(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),

                        // Right: Image Dots Indicator
                        if (images.length > 1)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(images.length, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                height: 4,
                                width: _currentPage == index ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),

                // Floating Action Bar
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: _buildDesign1ActionButtons(context, ref, data, theme),
                ),
              ],
            ),
          ),

          // 2. White Curved Bottom Sheet Panel
          Padding(
            padding: EdgeInsets.only(top: imageHeight - 24),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Centered drag handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 24),
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.grey.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  // Interest Status & Action Banner
                  OtherProfileInterestBanner(
                    memberId: widget.memberId,
                    data: data,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  ),

                  // 1. About Section
                  if (aboutText.isNotEmpty) ...[
                    _buildExpandableSection(
                      title: 'about_me'.tr,
                      sectionId: 'about',
                      child: Text(
                        aboutText,
                        style: AppFont.font(
                          fontSize: 14,
                          height: 1.6,
                          color: isDark ? Colors.white70 : const Color(0xFF5A5E78),
                        ),
                      ),
                    ),
                  ],

                  // 2. Contact Details Section (Immediately below About Me)
                  _buildExpandableSection(
                    title: 'contact_details'.tr,
                    sectionId: 'contactDetails',
                    child: OtherProfileContactCard(
                      cardKey: _contactDetailsKey,
                      data: data,
                      isRevealed: _contactRevealed,
                      hasViewedContact: OtherProfileHelper.hasViewedContact(widget.profileResponse.hasViewedContact),
                      onViewContact: _handleViewContact,
                      isDark: isDark,
                    ),
                  ),

                  // 3. Basic Details Section
                  _buildExpandableSection(
                    title: 'basic_details'.tr,
                    sectionId: 'basicDetails',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hobbyChips.isNotEmpty) ...[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: hobbyChips.map((chip) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  chip,
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const Gap(14),
                        ],
                        if (!hasMatriId && data.matriId != null && data.matriId.toString().isNotEmpty)
                          OtherProfileDetailItemRow(label: 'profile_id'.tr, value: data.matriId.toString(), isDark: isDark),
                        if (basicDetailsFields.isNotEmpty) ...[
                          if (!hasDob && data.birthdate != null && data.birthdate.toString().isNotEmpty)
                            OtherProfileDetailItemRow(label: 'date_of_birth'.tr, value: data.birthdate.toString(), isDark: isDark),
                          ...basicDetailsFields.map((f) => OtherProfileDetailItemRow(
                                label: f.label ?? f.key ?? "",
                                value: (f.key?.toLowerCase() == 'height' || f.label?.toLowerCase() == 'height')
                                    ? formatDisplayHeight(f.value.toString(), appendHeight: false)
                                    : f.value.toString(),
                                isDark: isDark,
                              )),
                        ] else ...[
                          if (data.birthdate != null && data.birthdate.toString().isNotEmpty)
                            OtherProfileDetailItemRow(label: 'date_of_birth'.tr, value: data.birthdate.toString(), isDark: isDark),
                          if (data.maritalStatus != null && data.maritalStatus.toString().isNotEmpty && int.tryParse(data.maritalStatus.toString()) == null)
                            OtherProfileDetailItemRow(label: 'marital_status'.tr, value: data.maritalStatus.toString(), isDark: isDark),
                          if (data.motherTongue != null && data.motherTongue.toString().isNotEmpty && int.tryParse(data.motherTongue.toString()) == null)
                            OtherProfileDetailItemRow(label: 'mother_tongue'.tr, value: data.motherTongue.toString(), isDark: isDark),
                          if ((data.heightStr != null && data.heightStr.toString().isNotEmpty) ||
                              (data.height != null && data.height.toString().isNotEmpty))
                            OtherProfileDetailItemRow(
                              label: 'height'.tr,
                              value: formatDisplayHeight(
                                data.heightStr?.toString().isNotEmpty == true
                                    ? data.heightStr.toString()
                                    : data.height.toString(),
                                appendHeight: false,
                              ),
                              isDark: isDark,
                            ),
                          if (data.weight != null && data.weight.toString().isNotEmpty)
                            OtherProfileDetailItemRow(label: 'weight'.tr, value: data.weight.toString(), isDark: isDark),
                        ],
                      ],
                    ),
                  ),

                  // 4. Dynamic Tabs
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
                      return _buildExpandableSection(
                        title: tab.sectionTitle ?? "",
                        sectionId: sectionId,
                        child: Column(
                          children: [
                            if (tab.sectionValue != null)
                              ...tab.sectionValue!
                                  .where((f) =>
                                      f.value != null &&
                                      f.value.toString().trim().isNotEmpty &&
                                      f.value.toString().trim() != "N/A" &&
                                      f.value.toString().trim() != "[]")
                                  .map((f) => OtherProfileDetailItemRow(
                                        label: f.label ?? f.key ?? "",
                                        value: f.value.toString(),
                                        isDark: isDark,
                                      )),
                          ],
                        ),
                      );
                    }),
                  ],

                  // Partner Preferences Section
                  if (data.partnerPreferenceTab != null && data.partnerPreferenceTab!.isNotEmpty) ...[
                    ...data.partnerPreferenceTab!.map((tab) {
                      final isFirst = data.partnerPreferenceTab!.first == tab;
                      final sectionId = tab.sectionId ?? tab.sectionTitle ?? "";
                      return _buildExpandableSection(
                        key: isFirst ? _partnerPreferenceKey : null,
                        title: tab.sectionTitle ?? "Partner Preferences",
                        sectionId: sectionId,
                        child: Column(
                          children: [
                            if (tab.sectionValue != null)
                              ...tab.sectionValue!
                                  .where((f) =>
                                      f.value != null &&
                                      f.value.toString().trim().isNotEmpty &&
                                      f.value.toString().trim() != "N/A" &&
                                      f.value.toString().trim() != "[]")
                                  .map((f) => OtherProfileDetailItemRow(
                                        label: f.label ?? f.key ?? "",
                                        value: f.value.toString(),
                                        isDark: isDark,
                                      )),
                          ],
                        ),
                      );
                    }),
                  ],

                  // Gallery Section
                  if (images.isNotEmpty)
                    _buildExpandableSection(
                      title: 'gallery'.tr,
                      sectionId: 'gallery',
                      child: OtherProfileGallery(
                        images: images,
                        data: data,
                        memberId: widget.memberId,
                        borderRadius: 16,
                      ),
                    ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesign1ActionButtons(BuildContext context, WidgetRef ref, ProfileData data, ThemeData theme) {
    final isShortlisted = data.isShortlisted == "1" ||
        data.isShortlisted == 1 ||
        data.isShortlisted == true ||
        data.isShortlisted == "Yes";
    final enableVoiceCall = ref.watch(featureProvider('enableVoiceCall'));
    final enableVideoCall = ref.watch(featureProvider('enableVideoCall'));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Star Shortlist
        _buildCircleActionBtn(
          svgPath: isShortlisted ? AppAssets.figmaShortlistSelected : AppAssets.figmaShortlist,
          iconColor: isShortlisted ? const Color(0xFFFABE2C) : Colors.white,
          onTap: () => OtherProfileHelper.toggleShortlist(
            context: context,
            ref: ref,
            memberId: widget.memberId,
            data: data,
          ),
        ),
        const Gap(14),
        // Voice Call (when enabled) OR View Contact (when voice call disabled - keep phone icon)
        _buildCircleActionBtn(
          svgPath: AppAssets.figmaVoiceCallOutline,
          iconColor: Colors.white,
          onTap: enableVoiceCall
              ? () => OtherProfileHelper.makeCall(
                    context: context,
                    ref: ref,
                    data: data,
                    memberId: widget.memberId,
                  )
              : _handleCallAction,
        ),
        const Gap(14),
        // Center Heart Hero Button
        _buildCenterHeroHeart(data, theme),
        const Gap(14),
        // Video Call (when enabled) OR Block Profile (when video call disabled - block icon)
        _buildCircleActionBtn(
          svgPath: enableVideoCall ? AppAssets.figmaVideoCallOutline : null,
          iconData: enableVideoCall ? null : Icons.block_rounded,
          iconColor: Colors.white,
          onTap: enableVideoCall
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
        if (ref.watch(featureProvider('enableChat'))) ...[
          const Gap(14),
          // Chat
          _buildCircleActionBtn(
            svgPath: AppAssets.figmaChatOutline,
            iconColor: Colors.white,
            onTap: () => OtherProfileHelper.openChat(
              context: context,
              ref: ref,
              data: data,
              memberId: widget.memberId,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCircleActionBtn({
    String? svgPath,
    IconData? iconData,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          color: const Color(0xCC121212),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: iconData != null
              ? Icon(iconData, color: iconColor, size: 22)
              : SvgPicture.asset(
                  svgPath!,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
        ),
      ),
    );
  }

  Widget _buildCenterHeroHeart(ProfileData data, ThemeData theme) {
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
        height: 64,
        width: 64,
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
              color: (isSent ? const Color(0xFF22C55E) : theme.primaryColor).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
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

  Widget _buildExpandableSection({
    Key? key,
    required String title,
    required String sectionId,
    required Widget child,
  }) {
    final isExpanded = !_collapsedSections.contains(sectionId);
    final theme = Theme.of(context);

    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (_collapsedSections.contains(sectionId)) {
                  _collapsedSections.remove(sectionId);
                } else {
                  _collapsedSections.add(sectionId);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppFont.font(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Gap(10),
            child,
          ],
          const Gap(12),
          Divider(height: 1, color: Colors.grey.withValues(alpha: 0.15)),
        ],
      ),
    );
  }
}
