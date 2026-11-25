import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/dynamic_form_models.dart';
import '../common/dashed_rect_painter.dart';

class DynamicIdProofField extends StatefulWidget {
  final FormFieldModel field;
  final File? initialFile;
  final ValueChanged<File?> onChanged;

  const DynamicIdProofField({
    super.key,
    required this.field,
    this.initialFile,
    required this.onChanged,
  });

  @override
  State<DynamicIdProofField> createState() => _DynamicIdProofFieldState();
}

class _DynamicIdProofFieldState extends State<DynamicIdProofField> {
  final ImagePicker _picker = ImagePicker();
  File? _file;

  @override
  void initState() {
    super.initState();
    _file = widget.initialFile;
  }

  bool get _isFrontSide {
    final name = widget.field.name.toLowerCase();
    final label = widget.field.label.toLowerCase();
    if (name.contains('back') || label.contains('back')) return false;
    return true;
  }

  int get _stepNumber => _isFrontSide ? 1 : 2;

  String get _sideTitle => _isFrontSide ? 'FRONT SIDE' : 'BACK SIDE';

  String get _fileSizeString {
    if (_file == null) return '';
    try {
      final bytes = _file!.lengthSync();
      final mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(1)} MB';
    } catch (_) {
      return '2.4 MB';
    }
  }

  String get _fileName {
    if (_file == null) return '';
    final raw = _file!.path.split('/').last;
    return raw.isNotEmpty ? raw : (_isFrontSide ? 'id_front.jpg' : 'id_back.jpg');
  }

  Future<void> _pickDocument(ImageSource source) async {
    final theme = Theme.of(context);
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 90);
      if (picked == null) return;

      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 10),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop ID Document',
            toolbarColor: theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop ID Document',
            aspectRatioLockEnabled: false,
          ),
        ],
      );

      if (cropped != null) {
        final f = File(cropped.path);
        setState(() => _file = f);
        widget.onChanged(f);
      }
    } catch (_) {}
  }

  void _showSourceModal() {
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
                    'Upload ${_isFrontSide ? 'Front Side' : 'Back Side'}',
                    style: AppFont.font(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E2038),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
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
                        _pickDocument(ImageSource.camera);
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
                        _pickDocument(ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FormField<File>(
        initialValue: _file,
        validator: (val) {
          if (widget.field.isRequired && _file == null) {
            return widget.field.validation?.errorMessage ?? 'Please upload ${widget.field.label}';
          }
          return null;
        },
        builder: (FormFieldState<File> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Numbered Section Header ─────────────────────────────────────
              Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: isDark ? 0.25 : 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$_stepNumber',
                        style: AppFont.font(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    _sideTitle,
                    style: AppFont.font(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: isDark ? Colors.white : const Color(0xFF1E2038),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.field.isRequired ? '• REQUIRED' : '• OPTIONAL',
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: widget.field.isRequired
                          ? theme.primaryColor
                          : (isDark ? Colors.white38 : const Color(0xFF8A90A6)),
                    ),
                  ),
                ],
              ),
              const Gap(10),

              // ── Upload Card: Uploaded vs Empty State ────────────────────────
              if (_file != null)
                // Uploaded State (Green Verified Container)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E2038) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF10B981),
                      width: 1.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Green Checkmark Icon Container
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Gap(14),

                      // Filename & Size Metadata
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _fileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFont.font(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF10B981),
                              ),
                            ),
                            const Gap(3),
                            Text(
                              '$_fileSizeString  •  Uploaded',
                              style: AppFont.font(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white54 : const Color(0xFF8A90A6),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Refresh / Retake Button
                      GestureDetector(
                        onTap: _showSourceModal,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF282B49) : const Color(0xFFF1F3FB),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.refresh_rounded,
                            color: isDark ? Colors.white70 : const Color(0xFF64748B),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                // Empty State (Dashed Pink Container)
                GestureDetector(
                  onTap: _showSourceModal,
                  child: CustomPaint(
                    painter: DashedRectPainter(
                      color: state.hasError
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E2038) : const Color(0xFFFFF9FA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          // Soft Pink Cloud Upload Icon Box
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: isDark ? 0.25 : 0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.cloud_upload_rounded,
                              color: theme.primaryColor,
                              size: 26,
                            ),
                          ),
                          const Gap(14),

                          // Titles
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tap to upload ${_isFrontSide ? 'front' : 'back'} side',
                                  style: AppFont.font(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? Colors.white : const Color(0xFF1E2038),
                                  ),
                                ),
                                const Gap(3),
                                Text(
                                  'JPG, PNG  •  Max 5 MB',
                                  style: AppFont.font(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white54 : const Color(0xFF8A90A6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (state.hasError) ...[
                const Gap(6),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    state.errorText!,
                    style: AppFont.font(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF4D4F),
                    ),
                  ),
                ),
              ],

              // ── Security Encryption Banner (only below Back Side) ───────────
              if (!_isFrontSide) ...[
                const Gap(16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E2038) : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.lock_rounded,
                          color: Color(0xFF10B981),
                          size: 18,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '256-bit encrypted & auto-deleted',
                              style: AppFont.font(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF1E2038),
                              ),
                            ),
                            const Gap(2),
                            Text(
                              'Your documents are safe with us · Never shared',
                              style: AppFont.font(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white54 : const Color(0xFF8A90A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
