import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/utils/app_assets.dart';
import '../../models/dynamic_form_models.dart';
import 'dynamic_field_container.dart';

class DynamicSegmentSelector extends StatelessWidget {
  final FormFieldModel field;
  final List<DropdownOptionModel>? items;
  final String? selectedValue;
  final ValueChanged<String> onChanged;

  const DynamicSegmentSelector({
    super.key,
    required this.field,
    this.items,
    this.selectedValue,
    required this.onChanged,
  });

  List<FieldOption> get _resolvedOptions {
    if (field.options != null && field.options!.isNotEmpty) {
      return field.options!;
    }
    if (items != null && items!.isNotEmpty) {
      return items!
          .map(
            (e) => FieldOption(
              id: (e.id ?? e.val ?? '').toString(),
              label: (e.val ?? e.id ?? '').toString(),
            ),
          )
          .where((o) => o.id.isNotEmpty)
          .toList();
    }
    return [];
  }

  bool get _isGenderSelector {
    if (field.name.toLowerCase() == 'gender') return true;
    final options = _resolvedOptions;
    return options.any((o) => o.id.toLowerCase() == 'male') &&
        options.any((o) => o.id.toLowerCase() == 'female');
  }

  bool get _isDocumentTypeSelector {
    final name = field.name.toLowerCase();
    final source = (field.dropdownSource ?? '').toLowerCase();
    return name.contains('id_proof') ||
        name.contains('document') ||
        source.contains('id_proof') ||
        source.contains('document');
  }

  String _getDocumentSvgAsset(String name) {
    final n = name.toLowerCase();
    if (n.contains('aadhar') || n.contains('aadhaar')) {
      return AppAssets.figmaAadhaar;
    }
    if (n.contains('pan')) {
      return AppAssets.figmaPanCard;
    }
    if (n.contains('license') ||
        n.contains('licence') ||
        n.contains('driving')) {
      return AppAssets.figmaLicence;
    }
    if (n.contains('passport') || n.contains('passbook')) {
      return AppAssets.figmaPassbook;
    }
    return AppAssets.figmaDocument;
  }

  String _getDocumentSubtitle(String name, String? existingSubtitle) {
    if (existingSubtitle != null && existingSubtitle.isNotEmpty) {
      return existingSubtitle;
    }
    final n = name.toLowerCase();
    if (n.contains('aadhar') || n.contains('aadhaar')) return 'Fastest option';
    if (n.contains('pan')) return 'Tax verified';
    if (n.contains('passport')) return 'Global ID';
    if (n.contains('license') || n.contains('licence') || n.contains('driving')) {
      return 'Driving ID';
    }
    if (n.contains('voter')) return 'Govt verified';
    return 'Identity proof';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final options = _resolvedOptions;

    // ── 1. GENDER SELECTOR ──────────────────────────────────────────────────
    if (_isGenderSelector) {
      return FormField<String>(
        key: ValueKey(selectedValue),
        initialValue: selectedValue,
        validator: (val) {
          if (field.isRequired && (val == null || val.trim().isEmpty)) {
            return field.validation?.errorMessage ??
                'Please select your gender';
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          final current = state.value ?? selectedValue ?? '';
          final isMale = current.toLowerCase() == 'male';
          final isFemale = current.toLowerCase() == 'female';

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Male Card
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          state.didChange('Male');
                          onChanged('Male');
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: isMale
                                    ? theme.primaryColor.withValues(
                                        alpha: isDark ? 0.2 : 0.08,
                                      )
                                    : (isDark
                                          ? const Color(0xFF1E2038)
                                          : Colors.white),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isMale
                                      ? theme.primaryColor
                                      : (isDark
                                            ? const Color(0xFF2E3150)
                                            : const Color(0xFFE5E7EB)),
                                  width: isMale ? 1.5 : 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: isDark ? 0.2 : 0.03,
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: isMale
                                            ? theme.primaryColor
                                            : (isDark
                                                  ? const Color(0xFF282B49)
                                                  : const Color(0xFFF8F5F2)),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        Icons.male_rounded,
                                        color: isMale
                                            ? Colors.white
                                            : (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF8A90A6)),
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    'Male',
                                    style: AppFont.font(
                                      fontSize: 16,
                                      fontWeight: isMale
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: isMale
                                          ? theme.primaryColor
                                          : (isDark
                                                ? Colors.white
                                                : const Color(0xFF16182F)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isMale)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: theme.primaryColor,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(14),
                    // Female Card
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          state.didChange('Female');
                          onChanged('Female');
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: isFemale
                                    ? theme.primaryColor.withValues(
                                        alpha: isDark ? 0.2 : 0.08,
                                      )
                                    : (isDark
                                          ? const Color(0xFF1E2038)
                                          : Colors.white),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isFemale
                                      ? theme.primaryColor
                                      : (isDark
                                            ? const Color(0xFF2E3150)
                                            : const Color(0xFFE5E7EB)),
                                  width: isFemale ? 1.5 : 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: isDark ? 0.2 : 0.03,
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: isFemale
                                            ? theme.primaryColor
                                            : (isDark
                                                  ? const Color(0xFF282B49)
                                                  : const Color(0xFFF8F5F2)),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        Icons.female_rounded,
                                        color: isFemale
                                            ? Colors.white
                                            : (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF8A90A6)),
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    'Female',
                                    style: AppFont.font(
                                      fontSize: 16,
                                      fontWeight: isFemale
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: isFemale
                                          ? theme.primaryColor
                                          : (isDark
                                                ? Colors.white
                                                : const Color(0xFF16182F)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isFemale)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: theme.primaryColor,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.hasError) ...[
                  const Gap(6),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      state.errorText ?? '',
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF4D4F),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      );
    }

    // ── 2. DOCUMENT TYPE SELECTOR (2x2 Grid of Cards - Figma Exact) ────────
    if (_isDocumentTypeSelector) {
      return FormField<String>(
        key: ValueKey(selectedValue),
        initialValue: selectedValue,
        validator: (val) {
          if (field.isRequired && (val == null || val.trim().isEmpty)) {
            return field.validation?.errorMessage ??
                'Please select an ID proof type';
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          final current = state.value ?? selectedValue ?? '';

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.35,
                  ),
                  itemBuilder: (context, index) {
                    final opt = options[index];
                    final isSelected =
                        current.isNotEmpty &&
                        (opt.id.toLowerCase() == current.toLowerCase() ||
                            opt.label.toLowerCase() == current.toLowerCase());
                    final svgAsset = _getDocumentSvgAsset(opt.label);
                    final subtitle = _getDocumentSubtitle(
                      opt.label,
                      opt.subtitle,
                    );

                    return GestureDetector(
                      onTap: () {
                        state.didChange(opt.id);
                        onChanged(opt.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.primaryColor.withValues(
                                  alpha: isDark ? 0.22 : 0.07,
                                )
                              : (isDark
                                    ? const Color(0xFF1E2038)
                                    : Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? theme.primaryColor
                                : (isDark
                                      ? const Color(0xFF2E3150)
                                      : const Color(0xFFE5E7EB)),
                            width: isSelected ? 1.6 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.2 : 0.03,
                              ),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.primaryColor
                                    : (isDark
                                          ? const Color(0xFF282B49)
                                          : const Color(0xFFF1F3FB)),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  svgAsset,
                                  width: 18,
                                  height: 18,
                                  colorFilter: ColorFilter.mode(
                                    isSelected
                                        ? Colors.white
                                        : (isDark
                                              ? Colors.white70
                                              : const Color(0xFF64748B)),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    opt.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFont.font(
                                      fontSize: 12.5,
                                      fontWeight: isSelected
                                          ? FontWeight.w800
                                          : FontWeight.w700,
                                      color: isSelected
                                          ? theme.primaryColor
                                          : (isDark
                                                ? Colors.white
                                                : const Color(0xFF16182F)),
                                    ),
                                  ),
                                  const Gap(1),
                                  Text(
                                    subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFont.font(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? Colors.white38
                                          : const Color(0xFF8A90A6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (state.hasError) ...[
                  const Gap(6),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      state.errorText ?? '',
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF4D4F),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      );
    }

    // ── 3. GENERIC SEGMENT SELECTOR (Pill Wrap) ─────────────────────────────
    return FormField<String>(
      key: ValueKey(selectedValue),
      initialValue: selectedValue ?? field.defaultValue?.toString(),
      validator: (val) {
        if (field.isRequired && (val == null || val.trim().isEmpty)) {
          return field.validation?.errorMessage ??
              'Please select ${field.label.toLowerCase()}';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        final current =
            state.value ??
            selectedValue ??
            field.defaultValue?.toString() ??
            '';

        return DynamicFieldContainer(
          labelText: field.label,
          isRequired: field.isRequired,
          errorText: state.errorText,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((opt) {
              final isSelected =
                  current.isNotEmpty &&
                  opt.id.toLowerCase() == current.toLowerCase();

              return GestureDetector(
                onTap: () {
                  state.didChange(opt.id);
                  onChanged(opt.id);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.primaryColor.withValues(
                            alpha: isDark ? 0.25 : 0.1,
                          )
                        : (isDark
                              ? const Color(0xFF282B49)
                              : const Color(0xFFF1F3FB)),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? theme.primaryColor
                          : Colors.transparent,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.check_rounded,
                          color: theme.primaryColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        opt.label,
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: isSelected
                              ? theme.primaryColor
                              : (isDark
                                    ? Colors.white70
                                    : const Color(0xFF16182F)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
