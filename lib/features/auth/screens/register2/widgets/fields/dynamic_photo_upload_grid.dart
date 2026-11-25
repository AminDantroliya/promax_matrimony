import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/dynamic_form_models.dart';
import '../common/dashed_rect_painter.dart';

class DynamicPhotoUploadGrid extends StatefulWidget {
  final List<FormFieldModel> fields;
  final Map<String, dynamic> formValues;
  final void Function(String fieldName, File? file) onPhotoChanged;

  const DynamicPhotoUploadGrid({
    super.key,
    required this.fields,
    required this.formValues,
    required this.onPhotoChanged,
  });

  @override
  State<DynamicPhotoUploadGrid> createState() => _DynamicPhotoUploadGridState();
}

class _DynamicPhotoUploadGridState extends State<DynamicPhotoUploadGrid> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndCrop(FormFieldModel field, ImageSource source) async {
    final theme = Theme.of(context);
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 88);
      if (picked == null) return;

      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Photo',
            toolbarColor: theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Profile Photo',
            aspectRatioLockEnabled: false,
          ),
        ],
      );

      if (cropped != null) {
        final f = File(cropped.path);
        widget.onPhotoChanged(field.name, f);
      }
    } catch (_) {}
  }

  void _showSourcePickerModal(FormFieldModel field) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E2038) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload Photo',
                    style: AppFont.font(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E2038),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: isDark ? Colors.white54 : Colors.black45),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                        _pickAndCrop(field, ImageSource.camera);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: isDark ? 0.2 : 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.primaryColor.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: theme.primaryColor,
                                size: 24,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Camera',
                              style: AppFont.font(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF1E2038),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                        _pickAndCrop(field, ImageSource.gallery);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: isDark ? 0.2 : 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.primaryColor.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.photo_library_rounded,
                                color: theme.primaryColor,
                                size: 24,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Gallery',
                              style: AppFont.font(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF1E2038),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSlot({
    required BuildContext context,
    required FormFieldModel field,
    required int index,
    required File? file,
    required bool hasError,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isFirst = index == 0 || field.name == 'photo1';

    // ── Uploaded State ────────────────────────────────────────────────────────
    if (file != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                file,
                fit: BoxFit.cover,
              ),

              // Gradient overlay for badges
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 48,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Main Badge
              if (isFirst)
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE11D48),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.white, size: 13),
                        const SizedBox(width: 3),
                        Text(
                          'MAIN',
                          style: AppFont.font(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Edit Button (Top Left)
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () => _showSourcePickerModal(field),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),

              // Delete Button (Top Right)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => widget.onPhotoChanged(field.name, null),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.95),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ── Empty / Add Slot State ────────────────────────────────────────────────
    return GestureDetector(
      onTap: () => _showSourcePickerModal(field),
      child: CustomPaint(
        painter: DashedRectPainter(
          color: hasError
              ? const Color(0xFFFF4D4F)
              : (isDark
                  ? const Color(0xFF3F4468)
                  : theme.primaryColor.withValues(alpha: 0.38)),
          strokeWidth: 1.5,
          dashLength: 6,
          gap: 4,
          radius: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2038) : const Color(0xFFFFFBFB),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: isDark ? 0.25 : 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: theme.primaryColor,
                  size: 26,
                ),
              ),
              const Gap(8),
              Text(
                'ADD',
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: theme.primaryColor,
                ),
              ),
              const Gap(3),
              Text(
                isFirst ? 'Main Photo *' : 'Photo ${index + 1}',
                style: AppFont.font(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isFirst
                      ? (isDark ? Colors.white70 : const Color(0xFF64748B))
                      : (isDark ? Colors.white38 : const Color(0xFF94A3B8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Check if required first photo is missing
    final firstField = widget.fields.isNotEmpty ? widget.fields.first : null;
    final firstFile = firstField != null ? widget.formValues[firstField.name] as File? : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FormField<File>(
        initialValue: firstFile,
        validator: (val) {
          if (firstField?.isRequired == true && firstFile == null) {
            return firstField?.validation?.errorMessage ?? 'Please upload at least 1 profile photo';
          }
          return null;
        },
        builder: (FormFieldState<File> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Profile & Gallery Photos',
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E2038),
                    ),
                  ),
                  if (firstField?.isRequired == true)
                    const Text(
                      ' *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF4D4F),
                      ),
                    ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Max 4 Photos',
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(4),
              Text(
                'Profiles with 4 clear photos receive up to 5x more matching requests',
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white60 : const Color(0xFF8A90A6),
                ),
              ),
              const Gap(8),
              InkWell(
                onTap: () => _showPhotoGuidelinesBottomSheet(context),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_outlined,
                        size: 16,
                        color: isDark ? Colors.white70 : const Color(0xFF5B6275),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Not sure what to upload?',
                        style: AppFont.font(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : const Color(0xFF5B6275),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(14),

              // ── 2 Columns x 2 Rows Grid (4 Photos) ──────────────────────────
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.fields.length.clamp(1, 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.82, // 3:4 portrait aspect ratio
                ),
                itemBuilder: (context, index) {
                  final field = widget.fields[index];
                  final file = widget.formValues[field.name] as File?;
                  final hasError = state.hasError && index == 0 && file == null;

                  return _buildPhotoSlot(
                    context: context,
                    field: field,
                    index: index,
                    file: file,
                    hasError: hasError,
                  );
                },
              ),

              if (state.hasError) ...[
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    state.errorText ?? '',
                    style: AppFont.font(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF4D4F),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _showPhotoGuidelinesBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E2038) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white24 : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.photo_library_outlined,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Photo Upload Guidelines',
                        style: AppFont.font(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF16182F),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: Icon(
                        Icons.close_rounded,
                        color: isDark ? Colors.white54 : const Color(0xFF8A90A6),
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Follow these simple guidelines to make your profile stand out and get 5x more matching responses!',
                  style: AppFont.font(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: isDark ? Colors.white60 : const Color(0xFF8A90A6),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildGuidelineItem(
                          context: context,
                          icon: Icons.image_outlined,
                          title: 'Clear & Recent Photos',
                          description:
                              'Ensure your face is clearly visible. Group photos, side profiles, or heavily edited selfies are not recommended.',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 10),
                        _buildGuidelineItem(
                          context: context,
                          icon: Icons.wb_sunny_outlined,
                          title: 'Proper Lighting & Background',
                          description:
                              'Photos shot in natural daylight or well-lit indoor spaces with clean, non-distracting backgrounds perform best.',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 10),
                        _buildGuidelineItem(
                          context: context,
                          icon: Icons.insert_drive_file_outlined,
                          title: 'Supported Formats',
                          description:
                              'Upload PNG or JPEG files under 5MB. You can add up to 5 photos (1 main + 4 supplementary photos).',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 10),
                        _buildGuidelineItem(
                          context: context,
                          icon: Icons.face_retouching_off_outlined,
                          title: 'Avoid Accessories',
                          description:
                              'Avoid wearing sunglasses, hats, or masks in your main profile photo so other members can recognize you.',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.getButtonBorderRadius(ctx),
                      ),
                    ),
                    child: Text(
                      'Got It',
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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

  Widget _buildGuidelineItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF262948) : const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF32365A) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF16182F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppFont.font(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
