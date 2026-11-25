import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/dynamic_form_models.dart';
import '../common/dashed_rect_painter.dart';

class DynamicSelfieField extends StatefulWidget {
  final FormFieldModel field;
  final File? initialFile;
  final ValueChanged<File?> onChanged;

  const DynamicSelfieField({
    super.key,
    required this.field,
    this.initialFile,
    required this.onChanged,
  });

  @override
  State<DynamicSelfieField> createState() => _DynamicSelfieFieldState();
}

class _DynamicSelfieFieldState extends State<DynamicSelfieField> {
  File? _selfieFile;

  @override
  void initState() {
    super.initState();
    _selfieFile = widget.initialFile;
  }

  Future<void> _captureSelfie() async {
    try {
      final String? path = await context.push<String>('/selfie-camera');
      if (path != null && mounted) {
        final f = File(path);
        setState(() => _selfieFile = f);
        widget.onChanged(f);
        return;
      }
    } catch (_) {}

    // Fallback if selfie-camera route is cancelled or unavailable
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 88,
      );
      if (picked != null && mounted) {
        final f = File(picked.path);
        setState(() => _selfieFile = f);
        widget.onChanged(f);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FormField<File>(
        initialValue: _selfieFile,
        validator: (val) {
          if (widget.field.isRequired && _selfieFile == null) {
            return widget.field.validation?.errorMessage ?? 'Live selfie verification is required';
          }
          return null;
        },
        builder: (FormFieldState<File> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Captured State: Square Box ────────────────────────────────
              if (_selfieFile != null) ...[
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF10B981),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withValues(alpha: 0.18),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            _selfieFile!,
                            fit: BoxFit.cover,
                          ),

                          // Gradient shadow for bottom badge
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 60,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.65),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Selfie Verified Pill
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.verified_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Selfie Verified',
                                      style: AppFont.font(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Delete / Retake Button (Top Right)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _selfieFile = null);
                                state.didChange(null);
                                widget.onChanged(null);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444).withValues(alpha: 0.95),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Center(
                  child: TextButton.icon(
                    onPressed: _captureSelfie,
                    icon: Icon(
                      Icons.refresh_rounded,
                      size: 16,
                      color: theme.primaryColor,
                    ),
                    label: Text(
                      'Retake Selfie',
                      style: AppFont.font(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ]

              // ── Empty / Unverified State: Horizontal Card ─────────────────
              else ...[
                GestureDetector(
                  onTap: _captureSelfie,
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
                          // Face Icon Badge
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: isDark ? 0.25 : 0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.face_retouching_natural_rounded,
                              size: 28,
                              color: theme.primaryColor,
                            ),
                          ),
                          const Gap(14),

                          // Titles
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Verify Selfie',
                                      style: AppFont.font(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: isDark ? Colors.white : const Color(0xFF1E2038),
                                      ),
                                    ),
                                    if (widget.field.isRequired)
                                      const Text(
                                        ' *',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF4D4F),
                                        ),
                                      ),
                                  ],
                                ),
                                const Gap(3),
                                Text(
                                  widget.field.description ??
                                      'Required camera face alignment check',
                                  style: AppFont.font(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white60 : const Color(0xFF8A90A6),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Chevron / Action Icon
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 13,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              if (state.hasError) ...[
                const Gap(8),
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
            ],
          );
        },
      ),
    );
  }
}
