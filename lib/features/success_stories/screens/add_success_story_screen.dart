import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_single_select_dropdown.dart';
import '../../common/data/models/dropdown_models.dart';
import '../../profile/providers/profile_notifier.dart';
import '../data/repositories/success_story_repository.dart';
import '../providers/success_story_notifier.dart';

class AddSuccessStoryScreen extends ConsumerStatefulWidget {
  const AddSuccessStoryScreen({super.key});

  @override
  ConsumerState<AddSuccessStoryScreen> createState() =>
      _AddSuccessStoryScreenState();
}

class _AddSuccessStoryScreenState extends ConsumerState<AddSuccessStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _brideNameController = TextEditingController();
  final TextEditingController _brideMatriIdController = TextEditingController();
  final TextEditingController _groomNameController = TextEditingController();
  final TextEditingController _groomMatriIdController = TextEditingController();
  final TextEditingController _weddingDateController = TextEditingController();
  final TextEditingController _howWeMetController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();

  // Selection states
  bool _isConsented = false;

  // Story & Video Types
  static const List<DropdownOptionModel> _storyTypeOptions = [
    DropdownOptionModel(id: 'Photo Story', val: 'Photo Story'),
    DropdownOptionModel(id: 'Video Story', val: 'Video Story'),
  ];

  static const List<DropdownOptionModel> _videoTypeOptions = [
    DropdownOptionModel(id: 'video', val: 'Upload Video'),
    DropdownOptionModel(id: 'youtube', val: 'YouTube'),
  ];

  DropdownOptionModel? _selectedStoryType;
  DropdownOptionModel? _selectedVideoType;

  // Media files
  File? _couplePhoto;
  File? _videoThumbnail;
  File? _weddingVideoFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final myProfile = ref.read(myProfileProvider).value;
      if (myProfile != null) {
        setState(() {
          if (myProfile.gender?.toString().toLowerCase() == "female") {
            _brideNameController.text = myProfile.fullname?.toString() ?? "";
            _brideMatriIdController.text = myProfile.matriId?.toString() ?? "";
          } else {
            _groomNameController.text = myProfile.fullname?.toString() ?? "";
            _groomMatriIdController.text = myProfile.matriId?.toString() ?? "";
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _brideNameController.dispose();
    _brideMatriIdController.dispose();
    _groomNameController.dispose();
    _groomMatriIdController.dispose();
    _weddingDateController.dispose();
    _howWeMetController.dispose();
    _videoLinkController.dispose();
    super.dispose();
  }

  // Pick Couple Photo
  Future<void> _pickCouplePhoto() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('gallery_lbl'.tr),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 70,
                );
                if (image != null) {
                  setState(() {
                    _couplePhoto = File(image.path);
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text('camera_lbl'.tr),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                );
                if (image != null) {
                  setState(() {
                    _couplePhoto = File(image.path);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Pick Video Thumbnail
  Future<void> _pickVideoThumbnail() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('gallery_lbl'.tr),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 70,
                );
                if (image != null) {
                  setState(() {
                    _videoThumbnail = File(image.path);
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text('camera_lbl'.tr),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                );
                if (image != null) {
                  setState(() {
                    _videoThumbnail = File(image.path);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Pick Video File
  Future<void> _pickVideoFile() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _weddingVideoFile = File(video.path);
      });
    }
  }

  // Select Wedding Date
  Future<void> _selectWeddingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _weddingDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  // Submit flow
  Future<void> _submitStory() async {
    hideKeyboard(context);

    if (!_formKey.currentState!.validate()) {
      showToast('please_fix_form_errors'.tr);
      return;
    }

    if (_weddingDateController.text.isEmpty) {
      showToast('please_select_wedding_date'.tr);
      return;
    }

    if (_howWeMetController.text.length < 100) {
      showToast('story_min_100_chars'.tr);
      return;
    }

    if (_selectedStoryType == null) {
      showToast('please_select_story_type'.tr.isNotEmpty ? 'please_select_story_type'.tr : 'Please select story type');
      return;
    }

    if (_selectedStoryType!.val == 'Photo Story') {
      if (_couplePhoto == null) {
        showToast('please_upload_couple_photo'.tr.isNotEmpty ? 'please_upload_couple_photo'.tr : 'Please upload couple photo');
        return;
      }
    } else if (_selectedStoryType!.val == 'Video Story') {
      if (_selectedVideoType == null) {
        showToast('please_select_video_type'.tr.isNotEmpty ? 'please_select_video_type'.tr : 'Please select video type');
        return;
      }
      if (_selectedVideoType!.val == 'YouTube') {
        if (_videoLinkController.text.trim().isEmpty) {
          showToast('please_enter_video_link'.tr.isNotEmpty ? 'please_enter_video_link'.tr : 'Please enter YouTube video link');
          return;
        }
      } else if (_selectedVideoType!.val == 'Upload Video') {
        if (_videoThumbnail == null) {
          showToast('please_upload_video_thumbnail'.tr.isNotEmpty ? 'please_upload_video_thumbnail'.tr : 'Please upload video thumbnail');
          return;
        }
        if (_weddingVideoFile == null) {
          showToast('please_upload_wedding_video'.tr.isNotEmpty ? 'please_upload_wedding_video'.tr : 'Please upload wedding video');
          return;
        }
      }
    }

    if (!_isConsented) {
      showToast('please_agree_terms'.tr);
      return;
    }

    String formattedMarriageDate = "";
    if (_weddingDateController.text.isNotEmpty) {
      try {
        final parsedDate = DateFormat(
          'dd-MM-yyyy',
        ).parse(_weddingDateController.text);
        formattedMarriageDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      } catch (e) {
        formattedMarriageDate = _weddingDateController.text;
      }
    }

    await withLoading(context, () async {
      try {
        final Map<String, dynamic> fields = {
          "bridename": _brideNameController.text.trim(),
          "brideid": _brideMatriIdController.text.trim(),
          "groomname": _groomNameController.text.trim(),
          "groomid": _groomMatriIdController.text.trim(),
          "marriagedate": formattedMarriageDate,
          "successmessage": _howWeMetController.text.trim(),
          "story_type": _selectedStoryType!.val,
        };

        if (_selectedStoryType!.val == 'Photo Story') {
          if (_couplePhoto != null) {
            final path = _couplePhoto!.path;
            final name = path.split('/').last;
            fields["wedding_photo"] = await MultipartFile.fromFile(
              path,
              filename: name,
            );
          }
        } else if (_selectedStoryType!.id == 'Video Story') {
          fields["video_type"] = _selectedVideoType!.id;
          if (_selectedVideoType!.id == 'youtube') {
            fields["video_link"] = _videoLinkController.text.trim();
          } else if (_selectedVideoType!.id == 'video') {
            if (_videoThumbnail != null) {
              final path = _videoThumbnail!.path;
              final name = path.split('/').last;
              fields["wedding_video_thumbnail"] = await MultipartFile.fromFile(
                path,
                filename: name,
              );
            }
            if (_weddingVideoFile != null) {
              final path = _weddingVideoFile!.path;
              final name = path.split('/').last;
              fields["wedding_video_file"] = await MultipartFile.fromFile(
                path,
                filename: name,
              );
            }
          }
        }

        printLog("*************PARAM-DATA-START*************");
        printParamLog(fields);
        printLog("*************PARAM-DATA-END*************");

        final formData = FormData.fromMap(fields);
        final repository = ref.read(successStoryRepositoryProvider);
        final response = await repository.addSuccessStory(formData);

        if (response.status == "success") {
          showToast(
            response.message.isNotEmpty
                ? response.message
                : 'success_story_submitted'.tr,
          );
          ref
              .read(successStoryProvider.notifier)
              .fetchSuccessStories(isRefresh: true);
          if (mounted) {
            Navigator.pop(context);
          }
        } else {
          showToast(
            response.message.isNotEmpty
                ? response.message
                : 'failed_to_submit_story'.tr,
          );
        }
      } catch (e) {
        showToast("${'error_occurred'.tr}: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgApp,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Zoomed blur background decoration (Figma layer blur 120, opacity 30%)
            Positioned(
              top: 100,
              right: -60,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 120,
                  sigmaY: 120,
                  tileMode: TileMode.decal,
                ),
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // 2. Main content scroll area
            Column(
              children: [
                AppAppBar(title: 'add_success_story'.tr, isShowActions: false),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SECTION 01: Couple Details
                          _buildSectionHeader(
                            icon: Icons.people_outline_rounded,
                            title: 'couple_details_title'.tr,
                            subtitle: 'couple_details_subtitle'.tr,
                            number: "01",
                            isDark: isDark,
                          ),
                          const Gap(16),
                          _buildInputField(
                            label: 'bride_name_lbl'.tr,
                            controller: _brideNameController,
                            prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: AppColors.primary,
                            ),
                            placeholder: 'enter_bride_name'.tr,
                            isDark: isDark,
                            isRequired: true,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'please_enter_bride_name'.tr;
                              }
                              return null;
                            },
                          ),
                          const Gap(14),
                          _buildInputField(
                            label: 'bride_matri_id_lbl'.tr,
                            controller: _brideMatriIdController,
                            prefixIcon: const Icon(
                              Icons.badge_outlined,
                              color: AppColors.primary,
                            ),
                            placeholder: 'enter_bride_matri_id'.tr,
                            isDark: isDark,
                            isRequired: true,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'please_enter_bride_matri_id'.tr;
                              }
                              return null;
                            },
                          ),
                          const Gap(14),
                          _buildInputField(
                            label: 'groom_name_lbl'.tr,
                            controller: _groomNameController,
                            prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: AppColors.primary,
                            ),
                            placeholder: 'enter_groom_name'.tr,
                            isDark: isDark,
                            isRequired: true,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'please_enter_groom_name'.tr;
                              }
                              return null;
                            },
                          ),
                          const Gap(14),
                          _buildInputField(
                            label: 'groom_matri_id_lbl'.tr,
                            controller: _groomMatriIdController,
                            prefixIcon: const Icon(
                              Icons.badge_outlined,
                              color: AppColors.primary,
                            ),
                            placeholder: 'enter_groom_matri_id'.tr,
                            isDark: isDark,
                            isRequired: true,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'please_enter_groom_matri_id'.tr;
                              }
                              return null;
                            },
                          ),
                          const Gap(14),
                          _buildInputField(
                            label: 'wedding_engagement_date_lbl'.tr,
                            controller: _weddingDateController,
                            prefixIcon: SvgPicture.asset(
                              AppAssets.successStoryDate,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                              width: 18,
                              height: 18,
                            ),
                            placeholder: "DD-MM-YYYY",
                            isDark: isDark,
                            readOnly: true,
                            onTap: () => _selectWeddingDate(context),
                            suffixIcon: SvgPicture.asset(
                              AppAssets.successStoryDate,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textSecondary,
                                BlendMode.srcIn,
                              ),
                              width: 18,
                              height: 18,
                            ),
                          ),

                          const Gap(30),

                          // SECTION 02: Your Story
                          _buildSectionHeader(
                            icon: Icons.menu_book_outlined,
                            title: 'your_story_title'.tr,
                            subtitle: 'your_story_subtitle'.tr,
                            number: "02",
                            isDark: isDark,
                          ),
                          const Gap(16),
                          _buildStoryContentField(
                            label: 'tell_us_how_you_met'.tr,
                            controller: _howWeMetController,
                            isDark: isDark,
                          ),

                          const Gap(30),

                          // SECTION 03: Add Media
                          _buildSectionHeader(
                            icon: Icons.photo_library_outlined,
                            title: 'add_media_title'.tr,
                            subtitle: 'add_media_subtitle'.tr,
                            number: "03",
                            isDark: isDark,
                          ),
                          const Gap(16),
                          // 1. Story Type Dropdown
                          AppSingleSelectDropdown(
                            hintText: "${'story_type'.tr} *",
                            items: _storyTypeOptions,
                            selectedItem: _selectedStoryType,
                            isShowSearch: false,
                            validator: (val) {
                              if (val == null) {
                                return 'please_select_story_type'.tr.isNotEmpty
                                    ? 'please_select_story_type'.tr
                                    : 'Please select story type';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                _selectedStoryType = val;
                                if (val?.val == 'Photo Story') {
                                  _selectedVideoType = null;
                                  _videoLinkController.clear();
                                  _videoThumbnail = null;
                                  _weddingVideoFile = null;
                                } else if (val?.val == 'Video Story') {
                                  _couplePhoto = null;
                                }
                              });
                            },
                          ),

                          // If Photo Story selected: show Upload Photo card
                          if (_selectedStoryType?.val == 'Photo Story') ...[
                            const Gap(16),
                            _buildUploadCard(
                              title: 'couple_photo_lbl'.tr,
                              subtitle: _couplePhoto == null
                                  ? 'click_to_upload'.tr
                                  : 'photo_uploaded'.tr,
                              icon: Icons.cloud_upload_outlined,
                              file: _couplePhoto,
                              onTap: _pickCouplePhoto,
                              isDark: isDark,
                              showEditBadge: true,
                            ),
                          ],

                          // If Video Story selected: show Video Type dropdown
                          if (_selectedStoryType?.val == 'Video Story') ...[
                            const Gap(14),
                            AppSingleSelectDropdown(
                              hintText: "${'video_type'.tr} *",
                              items: _videoTypeOptions,
                              selectedItem: _selectedVideoType,
                              isShowSearch: false,
                              validator: (val) {
                                if (_selectedStoryType?.val == 'Video Story' &&
                                    val == null) {
                                  return 'please_select_video_type'.tr.isNotEmpty
                                      ? 'please_select_video_type'.tr
                                      : 'Please select video type';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  _selectedVideoType = val;
                                  if (val?.val == 'YouTube') {
                                    _videoThumbnail = null;
                                    _weddingVideoFile = null;
                                  } else if (val?.val == 'Upload Video') {
                                    _videoLinkController.clear();
                                  }
                                });
                              },
                            ),

                            // If YouTube selected: show YouTube URL input
                            if (_selectedVideoType?.val == 'YouTube') ...[
                              const Gap(16),
                              _buildInputField(
                                label: 'video_link_lbl'.tr,
                                controller: _videoLinkController,
                                prefixIcon: const Icon(
                                  Icons.link_rounded,
                                  color: AppColors.primary,
                                ),
                                placeholder: "https://youtube.com/...",
                                isDark: isDark,
                                isRequired: true,
                                validator: (val) {
                                  if (_selectedStoryType?.val == 'Video Story' &&
                                      _selectedVideoType?.val == 'YouTube') {
                                    if (val == null || val.trim().isEmpty) {
                                      return 'please_enter_video_link'.tr.isNotEmpty
                                          ? 'please_enter_video_link'.tr
                                          : 'Please enter YouTube video link';
                                    }
                                  }
                                  return null;
                                },
                                suffixIcon: const Icon(
                                  Icons.link_rounded,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],

                            // If Upload Video selected: show Video Thumbnail & Wedding Video
                            if (_selectedVideoType?.val == 'Upload Video') ...[
                              const Gap(16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildUploadCard(
                                      title: "${'video_thumbnail'.tr} *",
                                      subtitle: _videoThumbnail == null
                                          ? 'click_to_upload'.tr
                                          : 'photo_uploaded'.tr,
                                      icon: Icons.image_outlined,
                                      file: _videoThumbnail,
                                      onTap: _pickVideoThumbnail,
                                      isDark: isDark,
                                      showEditBadge: true,
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: _buildUploadCard(
                                      title: "${'wedding_video'.tr} *",
                                      subtitle: _weddingVideoFile == null
                                          ? 'drop_or_browse'.tr
                                          : _weddingVideoFile!.path.split('/').last,
                                      icon: Icons.video_call_outlined,
                                      file: _weddingVideoFile,
                                      onTap: _pickVideoFile,
                                      isDark: isDark,
                                      showEditBadge: false,
                                      isVideo: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],

                          const Gap(24),
                          _buildVerificationBanner(isDark),
                          const Gap(20),
                          _buildConsentCheckbox(isDark),
                          const Gap(30),
                          _buildSubmitButton(isDark),
                          const Gap(40),
                        ],
                      ),
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


  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
    required String number,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFont.font(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
              const Gap(2),
              Text(
                subtitle,
                style: AppTextStyles.s6Body(
                  color: isDark ? Colors.white70 : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          number,
          style: AppFont.font(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required Widget prefixIcon,
    required bool isDark,
    bool isRequired = false,
    String? placeholder,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    bool readOnly = false,
    TextStyle? style,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.card,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF1F3F9),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          prefixIcon,
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppFont.font(
                      color: isDark ? Colors.white30 : AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      TextSpan(text: label.toUpperCase()),
                      if (isRequired)
                        const TextSpan(
                          text: " *",
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: controller,
                  validator: validator,
                  readOnly: readOnly,
                  onTap: onTap,
                  style:
                  style ??
                      AppFont.font(
                        color: isDark ? Colors.white : AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: placeholder,
                    hintStyle: AppFont.font(
                      color: isDark ? Colors.white24 : AppColors.textMuted,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (suffixIcon != null) ...[
            const Gap(8),
            GestureDetector(onTap: onTap, child: suffixIcon),
          ],
        ],
      ),
    );
  }

  Widget _buildStoryContentField({
    required String label,
    required TextEditingController controller,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.card,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF1F3F9),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.document_scanner_outlined,
                color: AppColors.primary,
                size: 18,
              ),
              const Gap(10),
              RichText(
                text: TextSpan(
                  style: AppFont.font(
                    color: isDark ? Colors.white30 : AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    TextSpan(text: label.toUpperCase()),
                    const TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            "share_journey_prompt".tr,
            style: AppFont.font(
              color: isDark ? Colors.white54 : AppColors.textSecondary,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const Gap(12),
          ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return TextFormField(
                controller: controller,
                maxLines: 8,
                minLines: 4,
                maxLength: 1000,
                style: AppFont.font(
                  color: isDark ? Colors.white : AppColors.textPrimary,
                  fontSize: 14.5,
                ),
                decoration: InputDecoration(
                  hintText: 'story_placeholder'.tr,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  counterText: "",
                ),
              );
            },
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.primary,
                    size: 14,
                  ),
                  const Gap(6),
                  Text(
                    'min_100_characters'.tr,
                    style: AppFont.font(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  final textLength = controller.text.length;
                  return Text(
                    "$textLength / 1000",
                    style: AppFont.font(
                      fontSize: 11,
                      color: textLength < 100
                          ? Colors.redAccent
                          : (isDark ? Colors.white60 : AppColors.textSecondary),
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required File? file,
    required VoidCallback onTap,
    required bool isDark,
    required bool showEditBadge,
    bool isVideo = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: DashedBorderPainter(
              color: AppColors.primary.withValues(alpha: 0.3),
              borderRadius: 20,
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.02)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: file != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: isVideo
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.video_file_rounded,
                      color: AppColors.primary,
                      size: 38,
                    ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.font(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white70
                              : AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Image.file(file, fit: BoxFit.cover),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: AppColors.primary, size: 20),
                  ),
                  const Gap(10),
                  Text(
                    title,
                    style: AppFont.font(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.white
                          : AppColors.textPrimary,
                    ),
                  ),
                  const Gap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      subtitle,
                      style: AppFont.font(
                        fontSize: 11,
                        color: isDark
                            ? Colors.white30
                            : AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (file != null && showEditBadge)
            Positioned(
              bottom: -6,
              right: -6,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildVerificationBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF1F5F9),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.verified_user_outlined,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'verified_by_team'.tr,
                  style: AppFont.font(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const Gap(2),
                Text(
                  'story_reviewed_24hrs'.tr,
                  style: AppFont.font(
                    fontSize: 11,
                    color: isDark ? Colors.white54 : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentCheckbox(bool isDark) {
    return InkWell(
      onTap: () {
        setState(() {
          _isConsented = !_isConsented;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: _isConsented,
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _isConsented = val;
                  });
                }
              },
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppFont.font(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : AppColors.textSecondary,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: 'i_agree_to_the'.tr),
                  TextSpan(
                    text: 'terms_and_conditions'.tr,
                    style: AppFont.font(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'consent_to_share'.tr,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isDark) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: FigmaColors.primaryGradient(context),
        borderRadius: AppTheme.getButtonBorderRadius(context),
        boxShadow: [FigmaColors.buttonShadow(context)],
      ),
      child: ElevatedButton(
        onPressed: _submitStory,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.getButtonBorderRadius(context),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            const Gap(10),
            Text(
              'submit_love_story'.tr,
              style: AppFont.font(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;
  final double borderRadius;

  DashedBorderPainter({
    this.color = AppColors.primary,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dash = 6.0,
    this.borderRadius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    double distance = 0.0;
    for (PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashPath.addPath(
          measurePath.extractPath(distance, distance + dash),
          Offset.zero,
        );
        distance += dash + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
