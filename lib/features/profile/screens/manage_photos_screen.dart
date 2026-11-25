import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../providers/photo_notifier.dart';
import '../providers/profile_notifier.dart';

// Custom SVG Status Icons
const String svgClock = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#FF9500" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="12" cy="12" r="10"></circle>
  <polyline points="12 6 12 12 16 14"></polyline>
</svg>
''';

const String svgVerified = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#34C759" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="12" cy="12" r="10" fill="#34C759"></circle>
  <polyline points="9 11 12 14 16 9" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></polyline>
</svg>
''';

class ManagePhotosScreen extends ConsumerStatefulWidget {
  final int? initialIndex;
  const ManagePhotosScreen({super.key, this.initialIndex});

  @override
  ConsumerState<ManagePhotosScreen> createState() => _ManagePhotosScreenState();
}

class _ManagePhotosScreenState extends ConsumerState<ManagePhotosScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialIndex ?? 0;
  }

  void _syncTabController(int count) {
    if (_tabController == null || _tabController!.length != count) {
      _tabController?.dispose();
      if (_selectedTab >= count) _selectedTab = 0;
      _tabController = TabController(
        vsync: this,
        length: count,
        initialIndex: _selectedTab,
      );
      _tabController!.addListener(() {
        if (_tabController!.indexIsChanging) return;
        setState(() {
          _selectedTab = _tabController!.index;
        });
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final showIdProof = ref.watch(featureProvider('enableIdentityVerification'));
    final showHoroscope = ref.watch(featureProvider('enableHoroscope'));

    final List<String> tabTitles = ['my_photos_tab'.tr];
    final List<Widget> tabViews = [const MyPhotosTab()];

    if (showIdProof) {
      tabTitles.add('my_id_proof_tab'.tr);
      tabViews.add(const MyIdProofTab());
    }
    if (showHoroscope) {
      tabTitles.add('my_horoscope_tab'.tr);
      tabViews.add(const MyHoroscopeTab());
    }

    _syncTabController(tabTitles.length);

    ref.listen<AsyncValue<void>>(photoProvider, (previous, next) {
      next.when(
        data: (_) => hideLoading(),
        loading: () => showLoading(context, isDark: isDarkMode),
        error: (e, _) {
          hideLoading();
          showToast(e.toString());
        },
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'manage_photos_title'.tr, isShowActions: false),
            if (tabTitles.length > 1) _buildSegmentedControl(isDarkMode, tabTitles),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(bool isDarkMode, List<String> tabTitles) {
    return AppTabBar(
      tabs: tabTitles,
      selectedIndex: _selectedTab,
      variant: TabBarVariant.segmented,
      onTap: (v) {
        setState(() {
          _selectedTab = v;
          _tabController?.animateTo(v);
        });
      },
    );
  }
}

class MyPhotosTab extends ConsumerWidget {
  const MyPhotosTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(myProfileProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);
    final maxPhotos = config.maxPhotosAllowed;

    return profileState.when(
      data: (profile) {
        if (profile == null) {
          return Center(child: Text("no_photos_available".tr));
        }

        final allPhotoCards = [
          _buildPhotoCard(
            context,
            ref,
            profile.photo1,
            profile.photo1Status,
            "photo1",
            true,
            isDarkMode,
          ),
          _buildPhotoCard(
            context,
            ref,
            profile.photo2,
            profile.photo2Status,
            "photo2",
            false,
            isDarkMode,
          ),
          _buildPhotoCard(
            context,
            ref,
            profile.photo3,
            profile.photo3Status,
            "photo3",
            false,
            isDarkMode,
          ),
          _buildPhotoCard(
            context,
            ref,
            profile.photo4,
            profile.photo4Status,
            "photo4",
            false,
            isDarkMode,
          ),
        ];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1 / 1.3,
            children: allPhotoCards.take(maxPhotos).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }

  Widget _buildPhotoCard(
    BuildContext context,
    WidgetRef ref,
    String? url,
    String? status,
    String photoKey,
    bool isMain,
    bool isDarkMode,
  ) {
    final double cardWidth = ((SizeConfig.screenWidth ?? 375.0) - 47) / 2;
    final double cardHeight = cardWidth * 1.3;
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: url != null && url.isNotEmpty
                ? getImageWidget(
                    url: url,
                    boxFit: BoxFit.cover,
                    isMyPhoto: true,
                    imageWidth: cardWidth,
                    imageHeight: cardHeight,
                  )
                : _buildAddImagePlaceholder(context, ref, photoKey, isDarkMode),
          ),
          if (url != null && url.isNotEmpty) ...[
            if (!isMain && status != null && status.isNotEmpty)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.string(
                    status == "APPROVED" ? svgVerified : svgClock,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            if (isMain)
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      const Gap(4),
                      Text(
                        'main_lbl'.tr,
                        style: AppFont.font(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => _showPicker(context, ref, photoKey, isMain),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icEdit,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
              ),
            ),
            if (!isMain)
              Positioned(
                bottom: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () =>
                      ref.read(photoProvider.notifier).deletePhoto(photoKey),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.icDelete,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFFF2D55),
                          BlendMode.srcIn,
                        ),
                        width: 14,
                        height: 14,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddImagePlaceholder(
    BuildContext context,
    WidgetRef ref,
    String photoKey,
    bool isDarkMode,
  ) {
    return GestureDetector(
      onTap: () => _showPicker(context, ref, photoKey, false),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: isDarkMode ? const Color(0xFF383A4E) : const Color(0xFFC7CAD9),
          borderRadius: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.figmaAddImage,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
                width: 32,
                height: 32,
              ),
              const Gap(10),
              Text(
                'add_image'.tr,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF1E202C),
                ),
              ),
              const Gap(4),
              Text(
                "PNG / JPG",
                style: AppFont.font(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white30 : const Color(0xFF8E90A6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(
    BuildContext context,
    WidgetRef ref,
    String photoKey,
    bool isMain,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
          topRight: Radius.circular(getProportionateScreenWidth(20)),
        ),
      ),
      builder: (bc) => SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(10),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: appPrimaryColor,
                ),
                title: customTextSemiBoldStyle(
                  'gallery'.tr,
                  getProportionateScreenWidth(16),
                  TextAlign.start,
                  Colors.black,
                ),
                onTap: () {
                  Navigator.pop(bc);
                  _pickAndCrop(ref, photoKey, isMain, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: appPrimaryColor),
                title: customTextSemiBoldStyle(
                  'camera'.tr,
                  getProportionateScreenWidth(16),
                  TextAlign.start,
                  Colors.black,
                ),
                onTap: () {
                  Navigator.pop(bc);
                  _pickAndCrop(ref, photoKey, isMain, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndCrop(
    WidgetRef ref,
    String photoKey,
    bool isMain,
    ImageSource source,
  ) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source, imageQuality: 50);
    if (image == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.3),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: appPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'Crop'),
      ],
    );

    if (croppedFile != null) {
      ref
          .read(photoProvider.notifier)
          .uploadPhoto(file: File(croppedFile.path), photoKey: photoKey);
    }
  }
}

class MyIdProofTab extends ConsumerStatefulWidget {
  const MyIdProofTab({super.key});

  @override
  ConsumerState<MyIdProofTab> createState() => _MyIdProofTabState();
}

class _MyIdProofTabState extends ConsumerState<MyIdProofTab> {
  String? _selectedDocType;
  File? _localFrontFile;
  File? _localBackFile;

  String _getUiIdType(String? apiType) {
    if (apiType == null) return "Aadhaar";
    switch (apiType) {
      case "Aadhaar":
      case "Aadhar Card":
        return "Aadhaar";
      case "PAN Card":
        return "PAN Card";
      case "Passport":
        return "Passport";
      case "License":
      case "Driving License":
        return "License";
      default:
        return "Aadhaar";
    }
  }

  String _getApiIdType(String type) {
    switch (type) {
      case "Aadhaar":
        return "Aadhar Card";
      case "PAN Card":
        return "PAN Card";
      case "Passport":
        return "Passport";
      case "License":
        return "Driving License";
      default:
        return type;
    }
  }

  bool _isApproved(dynamic status) {
    if (status == null) return false;
    final s = status.toString().trim().toUpperCase();
    return s == "APPROVED" ||
        s == "VERIFIED" ||
        s == "PROVED" ||
        s == "VERIFY" ||
        s == "YES" ||
        s == "1";
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(myProfileProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return profileState.when(
      data: (profile) {
        if (profile == null) {
          return Center(child: Text("no_id_proof_available".tr));
        }

        final bool isApproved = _isApproved(profile.idProofStatus);

        if (isApproved) {
          _selectedDocType = _getUiIdType(profile.idProofType);
        } else {
          _selectedDocType ??= _getUiIdType(profile.idProofType);
        }

        final bool isTypeChanged =
            _selectedDocType != _getUiIdType(profile.idProofType);
        final bool canSave = isTypeChanged
            ? (_localFrontFile != null && _localBackFile != null)
            : (_localFrontFile != null || _localBackFile != null);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDocTypeSelector(isDarkMode, isApproved),
              const Gap(24),
              _buildUploadSection(
                context,
                ref,
                profile.idProofFront,
                profile.idProofStatus,
                "front",
                isDarkMode,
                isApproved,
              ),
              const Gap(20),
              _buildUploadSection(
                context,
                ref,
                profile.idProofBack,
                profile.idProofStatus,
                "back",
                isDarkMode,
                isApproved,
              ),
              if (!isApproved) ...[
                const Gap(30),
                _buildSaveButton(context, canSave, isDarkMode),
              ],
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }

  Widget _buildSaveButton(BuildContext context, bool canSave, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: GestureDetector(
        onTap: canSave ? _handleSave : null,
        child: Container(
          decoration: BoxDecoration(
            gradient: canSave
                ? FigmaColors.primaryGradient(context)
                : null,
            color: canSave
                ? null
                : (isDarkMode
                      ? const Color(0xFF282A3A)
                      : const Color(0xFFEEF0F6)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'save_id_proof'.tr,
              style: AppFont.font(
                color: canSave
                    ? Colors.white
                    : (isDarkMode ? Colors.white30 : const Color(0xFF8E90A6)),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    final profile = ref.read(myProfileProvider).value;
    if (profile == null) return;
    if (_isApproved(profile.idProofStatus)) {
      showToast('id_proof_already_verified'.tr);
      return;
    }

    final success = await ref
        .read(photoProvider.notifier)
        .uploadIdProof(
          frontFile: _localFrontFile,
          backFile: _localBackFile,
          idProofType: _getApiIdType(_selectedDocType ?? "Aadhaar"),
        );

    if (success) {
      setState(() {
        _localFrontFile = null;
        _localBackFile = null;
      });
      showToast('id_proof_saved_success'.tr);
    }
  }

  Widget _buildDocTypeSelector(bool isDarkMode, bool isApproved) {
    final docTypes = [
      {"id": "Aadhaar", "labelKey": "id_proof_aadhaar", "icon": AppAssets.figmaAadhaar},
      {"id": "PAN Card", "labelKey": "id_proof_pan", "icon": AppAssets.figmaPanCard},
      {"id": "Passport", "labelKey": "id_proof_passport", "icon": AppAssets.figmaDocument},
      {"id": "License", "labelKey": "id_proof_license", "icon": AppAssets.figmaDocument},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3.5,
      ),
      itemCount: docTypes.length,
      itemBuilder: (context, index) {
        final doc = docTypes[index];
        final id = doc["id"]!;
        final labelKey = doc["labelKey"]!;
        final icon = doc["icon"]!;
        final isSelected = _selectedDocType == id;
        final bool isEnabled = !isApproved || isSelected;

        return Opacity(
          opacity: isEnabled ? 1.0 : 0.45,
          child: GestureDetector(
            onTap: isApproved
                ? () {
                    if (!isSelected) {
                      showToast('id_proof_already_verified'.tr);
                    }
                  }
                : () {
                    setState(() {
                      _selectedDocType = id;
                      _localFrontFile = null;
                      _localBackFile = null;
                    });
                  },
            child: Container(
              decoration: BoxDecoration(
                gradient: isSelected
                    ? FigmaColors.primaryGradient(context)
                    : null,
                color: isSelected
                    ? null
                    : (isDarkMode ? const Color(0xFF161722) : Colors.white),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : (isDarkMode
                            ? const Color(0xFF282A3A)
                            : const Color(0xFFEEF0F6)),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isSelected ? 0.15 : 0.03,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? Colors.white
                          : (isDarkMode
                                ? Colors.white60
                                : const Color(0xFF8E90A6)),
                      BlendMode.srcIn,
                    ),
                    width: 18,
                    height: 18,
                  ),
                  const Gap(8),
                  Flexible(
                    child: Text(
                      labelKey.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? Colors.white
                            : (isDarkMode
                                  ? Colors.white70
                                  : const Color(0xFF5B6B7C)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadSection(
    BuildContext context,
    WidgetRef ref,
    String? serverUrl,
    String? status,
    String side,
    bool isDarkMode,
    bool isApproved,
  ) {
    final double cardWidth = (SizeConfig.screenWidth ?? 375.0) - 32;
    final double cardHeight = cardWidth / 1.5;
    final File? localFile = side == 'front' ? _localFrontFile : _localBackFile;

    final profile = ref.read(myProfileProvider).value;
    final isTypeChanged =
        _selectedDocType != _getUiIdType(profile?.idProofType);
    final bool hasServerImage =
        !isTypeChanged && serverUrl != null && serverUrl.isNotEmpty;
    final bool showImage = localFile != null || hasServerImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          side == 'front' ? 'front_side_caps'.tr : 'back_side_caps'.tr,
          style: AppFont.font(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white30 : const Color(0xFF8E90A6),
            letterSpacing: 1.0,
          ),
        ),
        const Gap(8),
        Container(
          height: cardHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF161722) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: showImage
                    ? (localFile != null
                          ? Image.file(
                              localFile,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: cardHeight,
                            )
                          : getImageWidget(
                              url: serverUrl!,
                              boxFit: BoxFit.cover,
                              placeHolder: AppAssets.placeholderPng,
                              imageWidth: SizeConfig.screenWidth,
                              imageHeight: cardHeight,
                            ))
                    : _buildUploadPlaceholder(
                        context,
                        ref,
                        side,
                        isDarkMode,
                        isApproved,
                      ),
              ),
              if (showImage) ...[
                if (hasServerImage && status != null && status.isNotEmpty)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.string(
                        isApproved ? svgVerified : svgClock,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                if (!isApproved) ...[
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => _showPicker(context, ref, side),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.icEdit,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        if (localFile != null) {
                          setState(() {
                            if (side == 'front') {
                              _localFrontFile = null;
                            } else {
                              _localBackFile = null;
                            }
                          });
                        } else {
                          ref.read(photoProvider.notifier).deleteIdProof(side);
                        }
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.icDelete,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFFF2D55),
                              BlendMode.srcIn,
                            ),
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder(
    BuildContext context,
    WidgetRef ref,
    String side,
    bool isDarkMode,
    bool isApproved,
  ) {
    return GestureDetector(
      onTap: isApproved ? null : () => _showPicker(context, ref, side),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: isDarkMode ? const Color(0xFF383A4E) : const Color(0xFFC7CAD9),
          borderRadius: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF1E202C)
                      : const Color(0xFFF5F6FA),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaUpload,
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
              Text(
                side == 'front' ? 'upload_front_side'.tr : 'upload_back_side'.tr,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF1E202C),
                ),
              ),
              const Gap(4),
              Text(
                'browse_image'.tr,
                style: AppFont.font(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white30 : const Color(0xFF8E90A6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context, WidgetRef ref, String side) {
    final profile = ref.read(myProfileProvider).value;
    if (_isApproved(profile?.idProofStatus)) {
      showToast('id_proof_already_verified'.tr);
      return;
    }
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
          topRight: Radius.circular(getProportionateScreenWidth(20)),
        ),
      ),
      builder: (bc) => SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(10),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: appPrimaryColor,
                ),
                title: customTextSemiBoldStyle(
                  'gallery'.tr,
                  getProportionateScreenWidth(16),
                  TextAlign.start,
                  Colors.black,
                ),
                onTap: () {
                  Navigator.pop(bc);
                  _pickAndCrop(ref, side, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: appPrimaryColor),
                title: customTextSemiBoldStyle(
                  'camera'.tr,
                  getProportionateScreenWidth(16),
                  TextAlign.start,
                  Colors.black,
                ),
                onTap: () {
                  Navigator.pop(bc);
                  _pickAndCrop(ref, side, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndCrop(
    WidgetRef ref,
    String side,
    ImageSource source,
  ) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source, imageQuality: 50);
    if (image == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: appPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'Crop'),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        if (side == 'front') {
          _localFrontFile = File(croppedFile.path);
        } else {
          _localBackFile = File(croppedFile.path);
        }
      });
    }
  }
}

class MyHoroscopeTab extends ConsumerWidget {
  const MyHoroscopeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(myProfileProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return profileState.when(
      data: (profile) {
        if (profile == null) {
          return Center(child: Text("no_horoscope_available".tr));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHoroscopeSection(
                context,
                ref,
                profile.horoscopeFile,
                profile.horoscopeStatus,
                isDarkMode,
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }

  Widget _buildHoroscopeSection(
    BuildContext context,
    WidgetRef ref,
    String? url,
    String? status,
    bool isDarkMode,
  ) {
    final double cardWidth = (SizeConfig.screenWidth ?? 375.0) - 32;
    final double cardHeight = cardWidth / 1.5;
    return Container(
      height: cardHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF161722) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: url != null && url.isNotEmpty
                ? getImageWidget(
                    url: url,
                    placeHolder: AppAssets.placeholderPng,
                    boxFit: BoxFit.cover,
                    imageWidth: SizeConfig.screenWidth,
                    imageHeight: cardHeight,
                  )
                : _buildUploadPlaceholder(context, ref, isDarkMode),
          ),
          if (url != null && url.isNotEmpty) ...[
            if (status != null && status.isNotEmpty)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.string(
                    status == "APPROVED" ? svgVerified : svgClock,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => _showPicker(context, ref),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icEdit,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => ref.read(photoProvider.notifier).deleteHoroscope(),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icDelete,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFF2D55),
                        BlendMode.srcIn,
                      ),
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadPlaceholder(
    BuildContext context,
    WidgetRef ref,
    bool isDarkMode,
  ) {
    return GestureDetector(
      onTap: () => _showPicker(context, ref),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: isDarkMode ? const Color(0xFF383A4E) : const Color(0xFFC7CAD9),
          borderRadius: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF1E202C)
                      : const Color(0xFFF5F6FA),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaUpload,
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
              Text(
                'horoscope'.tr,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF1E202C),
                ),
              ),
              const Gap(4),
              Text(
                'browse_image'.tr,
                style: AppFont.font(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white30 : const Color(0xFF8E90A6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
          topRight: Radius.circular(getProportionateScreenWidth(20)),
        ),
      ),
      builder: (bc) => SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(10),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: appPrimaryColor,
                ),
                title: customTextSemiBoldStyle(
                  'gallery'.tr,
                  getProportionateScreenWidth(16),
                  TextAlign.start,
                  Colors.black,
                ),
                onTap: () {
                  Navigator.pop(bc);
                  _pickAndCrop(ref, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: appPrimaryColor),
                title: customTextSemiBoldStyle(
                  'camera'.tr,
                  getProportionateScreenWidth(16),
                  TextAlign.start,
                  Colors.black,
                ),
                onTap: () {
                  Navigator.pop(bc);
                  _pickAndCrop(ref, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndCrop(WidgetRef ref, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source, imageQuality: 50);
    if (image == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: appPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'Crop'),
      ],
    );

    if (croppedFile != null) {
      ref.read(photoProvider.notifier).uploadHoroscope(File(croppedFile.path));
    }
  }
}

// Dashed Border Painter implementation
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;
  final double borderRadius;

  DashedBorderPainter({
    this.color = const Color(0xFFC7CAD9),
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dash = 6.0,
    this.borderRadius = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final dashPath = Path();
    double distance = 0.0;

    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final len = dash;
        if (distance + len > pathMetric.length) {
          dashPath.addPath(
            pathMetric.extractPath(distance, pathMetric.length),
            Offset.zero,
          );
        } else {
          dashPath.addPath(
            pathMetric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len + gap;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
