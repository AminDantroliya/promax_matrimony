import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';


import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import '../../common/providers/dropdown_notifier.dart';
import '../../../features/profile/data/models/profile_models.dart';
import '../../home/providers/dashboard_notifier.dart';
import '../providers/profile_notifier.dart';
import 'manage_photos_screen.dart';
import '../dynamic/screens/dynamic_edit_profile_screen.dart';
import '../widgets/other_profile_common_widgets.dart';
import 'package:pro_matrimony/utils/utils.dart';


class ViewMyProfileScreen extends ConsumerStatefulWidget {
  final bool showAppBar;
  const ViewMyProfileScreen({super.key, this.showAppBar = true});

  @override
  ConsumerState<ViewMyProfileScreen> createState() =>
      _ViewMyProfileScreenState();
}

class _ViewMyProfileScreenState extends ConsumerState<ViewMyProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myProfileProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(languageProvider);
    final profileAsync = ref.watch(myProfileProvider);
    final dashboardAsync = ref.watch(dashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: widget.showAppBar,
        child: Column(
          children: [
            if (widget.showAppBar)
              AppAppBar(
                title: 'edit_profile'.tr,
                isShowActions: false,
              ),
            const Gap(10),
            // Progress completeness card
            dashboardAsync.maybeWhen(
              data: (data) => _buildCompletenessCard(context, data, isDark),
              orElse: () => const SizedBox.shrink(),
            ),
            _buildTabSelector(),
            Expanded(
              child: profileAsync.when(
                data: (profile) => profile == null
                    ? Center(child: Text("profile_data_not_found".tr))
                    : Column(
                        children: [
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildProfileTab(
                                  profile,
                                  profile.myProfileTab ?? [],
                                ),
                                _buildProfileTab(
                                  profile,
                                  profile.partnerPreferenceTab ?? [],
                                ),
                              ],
                            ),
                          ),
                          _buildFigmaBottomButton(context),
                        ],
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) =>
                    Center(child: Text("${'failed_to_load_options'.tr}: $err")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigmaAppBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : const Color(0xFFEEF0F6),
                  width: 1,
                ),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
              ),
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppTitleWidget(context, "${'edit_lbl'.tr} ${'profile_lbl'.tr}"),
                const Gap(2),
                Text(
                  'edit_profile_subtitle'.tr,
                  style: AppFont.font(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8E90A6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletenessCard(
    BuildContext context,
    dynamic data,
    bool isDark,
  ) {
    final completeness =
        double.tryParse(data?.profilePercentage?.toString() ?? "65") ?? 65;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: FigmaColors.primaryGradient(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.figmaEditProfileSection,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'complete_your_profile'.tr,
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Gap(2),
                            Text(
                              'better_profile_matches'.tr,
                              style: AppFont.font(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${completeness.toInt()}%",
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  // Progress Bar
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: completeness / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFAD00), Color(0xFFFF8400)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return AppTabBar(
      tabs: ['my_profile'.tr, 'partner_preference'.tr],
      icons: const [
        Icon(Icons.person_rounded),
        Icon(Icons.verified_user_rounded),
      ],
      selectedIndex: _selectedTab,
      onTap: (v) {
        setState(() {
          _selectedTab = v;
          _tabController.animateTo(v);
        });
      },
    );
  }

  Widget _buildProfileTab(ProfileData profile, List<TabData> tabs) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tabs.length,
      itemBuilder: (context, index) => ProfileSectionWidget(
        profile: profile,
        tab: tabs[index],
        onNavigateToEdit: _navigateToEdit,
      ),
    );
  }

  Widget _buildFigmaBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: FigmaPrimaryButton(
        text: 'edit_photo_or_id_proof'.tr,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ManagePhotosScreen()),
        ),
        leadingIcon: SvgPicture.asset(
          AppAssets.figmaPhotoGallery,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          width: 18,
          height: 18,
        ),
      ),
    );
  }

  void _navigateToEdit(
    BuildContext context,
    ProfileData profile,
    String sectionKey,
  ) {
    final k = sectionKey.toLowerCase();
    if (k.contains("gallery") || k.contains("photo")) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ManagePhotosScreen()),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DynamicEditProfileScreen(
          sectionKey: sectionKey,
          profileData: profile,
        ),
      ),
    );
  }
}

class ProfileSectionWidget extends ConsumerStatefulWidget {
  final ProfileData profile;
  final TabData tab;
  final Function(BuildContext, ProfileData, String) onNavigateToEdit;

  const ProfileSectionWidget({
    super.key,
    required this.profile,
    required this.tab,
    required this.onNavigateToEdit,
  });

  @override
  ConsumerState<ProfileSectionWidget> createState() => _ProfileSectionWidgetState();
}

class _ProfileSectionWidgetState extends ConsumerState<ProfileSectionWidget> {
  bool _isExpanded = true;

  String _resolveOccupationTitle(dynamic rawValue) {
    if (rawValue == null) return "";
    final str = rawValue.toString().trim();
    if (str.isEmpty || str == "0" || str == "null") return "";

    final intId = int.tryParse(str);
    if (intId != null) {
      final dropdownData = ref.watch(allDropdownsProvider).value;
      final occupations = dropdownData?.occupationList;
      if (occupations != null && occupations.isNotEmpty) {
        final match = occupations.cast<DropdownOptionModel?>().firstWhere(
          (e) => e != null && (e.id.toString() == str || e.id == intId),
          orElse: () => null,
        );
        if (match != null && match.val != null && match.val.toString().isNotEmpty) {
          return match.val.toString();
        }
      }
    }
    return str;
  }

  String _getSectionIcon(String sectionId) {
    final k = sectionId.toLowerCase();
    if (k.contains("basic")) return AppAssets.figmaBasicDetails;
    if (k.contains("religion") || k.contains("religious"))
      return AppAssets.figmaReligionDetails;
    if (k.contains("contact") || k.contains("location"))
      return AppAssets.figmaContactDetails;
    if (k.contains("education") || k.contains("occupation"))
      return AppAssets.figmaEducationDetails;
    if (k.contains("family")) return AppAssets.figmaFamilyDetails;
    if (k.contains("gallery") || k.contains("photo"))
      return AppAssets.figmaPhotoGallery;
    return AppAssets.figmaLifestyleDetails;
  }

  String _getSectionSubtitle(String sectionId, ProfileData profile) {
    final k = sectionId.toLowerCase();
    if (k.contains("basic"))
      return "${'created_by_self'.tr} · ${profile.matriId ?? ''}";
    if (k.contains("contact") || k.contains("location"))
      return 'phone_email_address'.tr;
    if (k.contains("religion") || k.contains("religious"))
      return 'religion_caste_gotra'.tr;
    if (k.contains("family")) return 'parents_siblings_info'.tr;
    if (k.contains("education") || k.contains("occupation"))
      return 'qualifications_and_career'.tr;
    if (k.contains("gallery") || k.contains("photo")) return 'photos_and_media'.tr;
    return 'habits_and_preferences'.tr;
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final tab = widget.tab;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(20),
              bottom: Radius.circular(_isExpanded ? 0 : 20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                         _getSectionIcon(tab.sectionId ?? tab.sectionTitle ?? ""),
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  const Gap(12),
                  // Title + Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (tab.sectionTitle ?? "").tr,
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1E202C),
                          ),
                        ),
                        const Gap(2),
                        Text(
                          _getSectionSubtitle(
                            tab.sectionId ?? tab.sectionTitle ?? "",
                            profile,
                          ),
                          style: AppFont.font(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8E90A6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Edit Action squircle
                  GestureDetector(
                    onTap: () => widget.onNavigateToEdit(
                      context,
                      profile,
                      tab.sectionId ?? tab.sectionTitle ?? "",
                    ),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.figmaEdit,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor,
                            BlendMode.srcIn,
                          ),
                          width: 14,
                          height: 14,
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  RotatedBox(
                    quarterTurns: _isExpanded ? 3 : 1,
                    child: SvgPicture.asset(
                      AppAssets.figmaNavigationForward,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8E90A6),
                        BlendMode.srcIn,
                      ),
                      width: 6,
                      height: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded details content
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: Color(0xFFEEF0F6), height: 1),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (tab.sectionId == "basicDetails" ||
                          tab.sectionId == "basic_details") ...[
                        _buildFigmaTagsRow(profile),
                        const Gap(16),
                      ],
                      ...() {
                        final sTitle = tab.sectionTitle?.toLowerCase() ?? "";
                        final isGallerySection = sTitle.contains("gallery") ||
                            sTitle.contains("photo") ||
                            tab.sectionId == "galleryDetails" ||
                            tab.sectionId == "gallery_details";

                        if (isGallerySection) {
                          return [
                            _buildGalleryGrid(
                              context,
                              tab.sectionValue ?? [],
                              profile,
                              isDark,
                            ),
                          ];
                        }

                        final widgets = <Widget>[];
                        final list = tab.sectionValue ?? [];
                        for (final val in list) {
                          if (val.key == "brother_details" ||
                              val.key == "sister_details" ||
                              val.key == "paternal_family" ||
                              val.key == "maternal_family") {
                            continue;
                          }

                          final isHeightField = val.key == "height" ||
                              (val.label != null &&
                                  val.label!.trim().toLowerCase() == "height");
                          final displayValue = isHeightField
                              ? formatDisplayHeight(val.value ?? "", appendHeight: false)
                              : (val.value ?? "");

                          widgets.add(
                            _buildFigmaDetailRow(
                              context,
                              val.label ?? "",
                              displayValue,
                              isDark,
                            ),
                          );


                          if (val.key == "no_of_married_brother" &&
                              profile.brotherDetailsArr != null &&
                              profile.brotherDetailsArr!.isNotEmpty) {
                            widgets.add(
                              _buildBrotherSisterDetails(
                                profile.brotherDetailsArr!,
                                'brother_details_title'.tr,
                                isDark,
                              ),
                            );
                          }

                          if (val.key == "no_of_married_sister" &&
                              profile.sisterDetailsArr != null &&
                              profile.sisterDetailsArr!.isNotEmpty) {
                            widgets.add(
                              _buildBrotherSisterDetails(
                                profile.sisterDetailsArr!,
                                'sister_details_title'.tr,
                                isDark,
                              ),
                            );
                          }
                        }

                        if (tab.sectionId == "familyDetails" ||
                            tab.sectionId == "family_details") {
                          if (profile.paternalFamily != null &&
                              profile.paternalFamily!.isNotEmpty) {
                            widgets.add(
                              _buildPaternalMaternalFamily(
                                profile.paternalFamily!,
                                'paternal_family_details_title'.tr,
                                isDark,
                              ),
                            );
                          }
                          if (profile.maternalFamily != null &&
                              profile.maternalFamily!.isNotEmpty) {
                            widgets.add(
                              _buildPaternalMaternalFamily(
                                profile.maternalFamily!,
                                'maternal_family_details_title'.tr,
                                isDark,
                              ),
                            );
                          }
                        }

                        return widgets;
                      }(),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  Widget _buildBrotherSisterDetails(
    List<dynamic> list,
    String title,
    bool isDark,
  ) {
    final validItems = list.where((item) {
      final name =
          item['name'] ?? item['brother_name'] ?? item['sister_name'] ?? "";
      final mobile =
          item['mobile'] ??
          item['brother_mobile_number'] ??
          item['sister_mobile_number'] ??
          "";
      final occupation =
          item['occupation'] ??
          item['brother_occupation'] ??
          item['sister_occupation'] ??
          "";
      return name.toString().isNotEmpty ||
          mobile.toString().isNotEmpty ||
          occupation.toString().isNotEmpty;
    }).toList();

    if (validItems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        Text(
          title,
          style: AppFont.font(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const Gap(8),
        ...validItems.map((item) {
          final name =
              item['name'] ?? item['brother_name'] ?? item['sister_name'] ?? "";
          final mobile =
              item['mobile'] ??
              item['brother_mobile_number'] ??
              item['sister_mobile_number'] ??
              "";
          final rawOcc =
              item['occupation'] ??
              item['brother_occupation'] ??
              item['sister_occupation'] ??
              "";
          final occupation = _resolveOccupationTitle(rawOcc);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFEEF0F6),
              ),
            ),
            child: Column(
              children: [
                if (name.toString().isNotEmpty)
                  _buildFigmaDetailRowNoDivider(
                    'name_lbl'.tr,
                    name.toString(),
                    isDark,
                  ),
                if (mobile.toString().isNotEmpty)
                  _buildFigmaDetailRowNoDivider(
                    'mobile_number'.tr,
                    mobile.toString(),
                    isDark,
                  ),
                if (occupation.toString().isNotEmpty)
                  _buildFigmaDetailRowNoDivider(
                    'occupation_lbl'.tr,
                    occupation.toString(),
                    isDark,
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPaternalMaternalFamily(
    List<dynamic> list,
    String title,
    bool isDark,
  ) {
    if (list.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        Text(
          title,
          style: AppFont.font(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const Gap(8),
        ...list.map((item) {
          final gf = item['grand_father_name']?.toString() ?? "";
          final gm = item['grand_mother_name']?.toString() ?? "";
          final uName = item['uncle_name']?.toString() ?? "";
          final uNum = item['uncle_number']?.toString() ?? "";
          final uOccRaw = item['uncle_occupation']?.toString() ?? "";
          final uOcc = _resolveOccupationTitle(uOccRaw);
          final aName = item['aunt_name']?.toString() ?? "";
          final aNum = item['aunt_number']?.toString() ?? "";
          final aOccRaw = item['aunt_occupation']?.toString() ?? "";
          final aOcc = _resolveOccupationTitle(aOccRaw);

          if (gf.isEmpty && gm.isEmpty && uName.isEmpty && aName.isEmpty)
            return const SizedBox.shrink();

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFEEF0F6),
              ),
            ),
            child: Column(
              children: [
                if (gf.isNotEmpty)
                  _buildFigmaDetailRowNoDivider('grandfather_name'.tr, gf, isDark),
                if (gm.isNotEmpty)
                  _buildFigmaDetailRowNoDivider('grandmother_name'.tr, gm, isDark),
                if (uName.isNotEmpty)
                  _buildFigmaDetailRowNoDivider('uncle_name'.tr, uName, isDark),
                if (uNum.isNotEmpty)
                  _buildFigmaDetailRowNoDivider(
                    'uncle_mobile_number'.tr,
                    uNum,
                    isDark,
                  ),
                if (uOcc.isNotEmpty && uOcc != "0")
                  _buildFigmaDetailRowNoDivider(
                    'uncle_occupation'.tr,
                    uOcc,
                    isDark,
                  ),
                if (aName.isNotEmpty)
                  _buildFigmaDetailRowNoDivider('aunt_name'.tr, aName, isDark),
                if (aNum.isNotEmpty)
                  _buildFigmaDetailRowNoDivider(
                    'aunt_mobile_number'.tr,
                    aNum,
                    isDark,
                  ),
                if (aOcc.isNotEmpty && aOcc != "0")
                  _buildFigmaDetailRowNoDivider(
                    'aunt_occupation'.tr,
                    aOcc,
                    isDark,
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFigmaDetailRowNoDivider(
    String label,
    String value,
    bool isDark,
  ) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final textStyle = AppFont.font(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF1E202C),
          height: 1.4,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  label.tr,
                  style: AppFont.font(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8E90A6),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                flex: 6,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final tp = TextPainter(
                      text: TextSpan(text: value.tr, style: textStyle),
                      maxLines: 2,
                      textDirection: TextDirection.ltr,
                      textScaler: MediaQuery.textScalerOf(context),
                    )..layout(maxWidth: constraints.maxWidth);

                    final bool isOverflowing = tp.didExceedMaxLines;

                    if (!isOverflowing) {
                      return Text(
                        value.tr,
                        textAlign: TextAlign.end,
                        style: textStyle,
                      );
                    }

                    return GestureDetector(
                      onTap: () => OtherProfileHelper.showDetailBottomSheet(
                        context,
                        label.tr,
                        value.tr,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            value.tr,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle,
                          ),
                          const Gap(4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'read_more'.tr,
                                  style: AppFont.font(
                                    fontSize: 11,
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(3),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 9,
                                  color: theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFigmaTagsRow(ProfileData profile) {
    final tags = <String>[];
    if (profile.age != null) {
      String ageStr = profile.age.toString();
      final match = RegExp(r'\d+').firstMatch(ageStr);
      if (match != null) {
        tags.add("${match.group(0)} yrs");
      } else {
        tags.add(ageStr);
      }
    }
    final rawHeight = (profile.heightStr != null &&
            profile.heightStr.toString().trim().isNotEmpty)
        ? profile.heightStr.toString().trim()
        : profile.height?.toString().trim();
    if (rawHeight != null && rawHeight.isNotEmpty) {
      final formattedHeight = formatDisplayHeight(rawHeight, appendHeight: true);
      if (formattedHeight.isNotEmpty) {
        tags.add(formattedHeight);
      }
    }


    if (tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((t) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            t.tr,
            style: AppFont.font(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFigmaDetailRow(
    BuildContext context,
    String label,
    String value,
    bool isDark,
  ) {
    final isUrl =
        value.startsWith("http://") ||
        value.startsWith("https://") ||
        value.contains("/storage/") ||
        value.endsWith(".jpg") ||
        value.endsWith(".jpeg") ||
        value.endsWith(".png") ||
        value.endsWith(".webp");

    final theme = Theme.of(context);
    final textStyle = AppFont.font(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: isDark ? Colors.white : const Color(0xFF1E202C),
      height: 1.4,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  label.tr,
                  style: AppFont.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8E90A6),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                flex: 6,
                child: isUrl
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showFullPhotoDialog(context, value),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: getImageWidget(
                              url: value,
                              imageWidth: 64,
                              imageHeight: 64,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final tp = TextPainter(
                            text: TextSpan(text: value.tr, style: textStyle),
                            maxLines: 2,
                            textDirection: TextDirection.ltr,
                            textScaler: MediaQuery.textScalerOf(context),
                          )..layout(maxWidth: constraints.maxWidth);

                          final bool isOverflowing = tp.didExceedMaxLines;

                          if (!isOverflowing) {
                            return Text(
                              value.tr,
                              textAlign: TextAlign.end,
                              style: textStyle,
                            );
                          }

                          return GestureDetector(
                            onTap: () => OtherProfileHelper.showDetailBottomSheet(
                              context,
                              label.tr,
                              value.tr,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  value.tr,
                                  textAlign: TextAlign.end,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle,
                                ),
                                const Gap(4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'read_more'.tr,
                                        style: AppFont.font(
                                          fontSize: 11,
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Gap(3),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 9,
                                        color: theme.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          const Gap(10),
          DottedDivider(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : const Color(0xFFEEF0F6),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryGrid(
    BuildContext context,
    List<SectionValue> sectionValues,
    ProfileData profile,
    bool isDark,
  ) {
    final photoItems = <Map<String, String>>[];

    if (sectionValues.isNotEmpty) {
      for (int i = 0; i < sectionValues.length; i++) {
        final val = sectionValues[i];
        photoItems.add({
          'label': val.label ?? "Photo ${i + 1}",
          'url': val.value?.toString() ?? "",
        });
      }
    } else {
      final photos = [
        profile.photo1,
        profile.photo2,
        profile.photo3,
        profile.photo4,
      ];
      for (int i = 0; i < photos.length; i++) {
        if (photos[i] != null && photos[i].toString().isNotEmpty) {
          photoItems.add({
            'label': "Photo ${i + 1}",
            'url': photos[i].toString(),
          });
        }
      }
    }

    if (photoItems.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          "no_photos_available".tr,
          style: AppFont.font(
            fontSize: 13,
            color: const Color(0xFF8E90A6),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photoItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1 / 1.3,
      ),
      itemBuilder: (context, index) {
        final item = photoItems[index];
        final label = item['label'] ?? "";
        final url = item['url'] ?? "";

        return GestureDetector(
          onTap: () {
            if (url.isNotEmpty) {
              _showFullPhotoDialog(context, url);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161722) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: url.isNotEmpty
                        ? getImageWidget(
                            url: url,
                            boxFit: BoxFit.cover,
                            isMyPhoto: true,
                            imageWidth: double.infinity,
                            imageHeight: double.infinity,
                          )
                        : Container(
                            color: isDark
                                ? Colors.white10
                                : const Color(0xFFE2E8F0),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: isDark
                                    ? Colors.white30
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      label.tr,
                      textAlign: TextAlign.center,
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFullPhotoDialog(BuildContext context, String url) {
    if (url.isEmpty) return;
    context.push('/photo-viewer', extra: {
      'imageList': [url],
      'initialIndex': 0,
    });
  }
}

class DottedDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashSpace;

  const DottedDivider({
    super.key,
    this.color = const Color(0xFFD1D5DB),
    this.height = 1,
    this.dashWidth = 3.5,
    this.dashSpace = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }),
          );
        },
      ),
    );
  }
}
