import 'package:dropdown_search/dropdown_search.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/config/app_config.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';

import '../app_theme/app_theme.dart';
import '../features/common/data/models/dropdown_models.dart';

export 'package:pro_matrimony/widgets/app_tab_bar.dart';

// ── CUSTOM FIGMA RANGE BAR ───────────────────────────────────────────────────
class SearchRangeBar extends ConsumerWidget {
  final String title;
  final String displayValue;
  final RangeValues values;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<RangeValues> onChanged;

  const SearchRangeBar({
    super.key,
    required this.title,
    required this.displayValue,
    required this.values,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);
    final isUnderlined = AppInputFieldStyle.resolveDesign(config) == 'underlined';

    return Container(
      padding: isUnderlined
          ? const EdgeInsets.fromLTRB(4, 12, 4, 12)
          : const EdgeInsets.fromLTRB(20, 16, 20, 12),
      decoration: AppInputFieldStyle.buildContainerDecoration(
        context: context,
        config: config,
        suppressUnderline: true,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: AppFont.font(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                displayValue,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const Gap(8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: theme.primaryColor,
              thumbColor: theme.primaryColor,
              inactiveTrackColor: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFEEF0FB),
              trackHeight: 4,
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 9,
                elevation: 3,
              ),
              overlayColor: theme.primaryColor.withValues(alpha: 0.15),
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
            ),
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CUSTOM FIGMA DROPDOWN ────────────────────────────────────────────────────
class SearchIconDropdown extends ConsumerWidget {
  final String labelText;
  final IconData icon;
  final List<DropdownOptionModel> items;
  final List<DropdownOptionModel> selectedItems;
  final ValueChanged<List<DropdownOptionModel>> onChanged;
  final bool? isShowSearch;
  final FormFieldValidator<List<DropdownOptionModel>>? validator;

  const SearchIconDropdown({
    super.key,
    required this.labelText,
    required this.icon,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.isShowSearch,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);
    final isUnderlined = AppInputFieldStyle.resolveDesign(config) == 'underlined';

    if (items.isNotEmpty && items.length <= 5) {
      return _buildChipSelectionView(context, theme, isDark, config);
    }

    return Container(
      decoration: AppInputFieldStyle.buildContainerDecoration(
        context: context,
        config: config,
      ),
      child: ClipRRect(
        borderRadius: AppInputFieldStyle.getBorderRadius(config),
        child: m_ui.Material(
          type: m_ui.MaterialType.transparency,
          child: DropdownSearch<DropdownOptionModel>.multiSelection(
          itemAsString: (DropdownOptionModel model) => model.val!,
          selectedItems: selectedItems,
          compareFn: (item1, item2) => item1.id == item2.id,
          items: (filter, infiniteScrollProps) => items,
          onSelected: onChanged,
          validator: validator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconOpened: Icon(
                CupertinoIcons.chevron_up,
                size: 16,
                color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
              ),
              iconClosed: Icon(
                CupertinoIcons.chevron_down,
                size: 16,
                color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: m_ui.InputDecoration(
              border: m_ui.InputBorder.none,
              enabledBorder: m_ui.InputBorder.none,
              focusedBorder: m_ui.InputBorder.none,
              errorBorder: m_ui.InputBorder.none,
              contentPadding: m_ui.EdgeInsets.symmetric(
                horizontal: isUnderlined ? 4 : 16,
                vertical: 12,
              ),
            ),
            baseStyle: AppFont.font(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          selectedItemsScrollProps: const ScrollProps(
            scrollDirection: Axis.horizontal,
          ),
          popupProps: MultiSelectionPopupProps.modalBottomSheet(
            showSearchBox: isShowSearch ?? (items.length > 10),
            searchDelay: const Duration(milliseconds: 50),
            showSelectedItems: false,
            checkBoxBuilder: (context, item, isDisabled, isSelected) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : (isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFE2E8F0)),
                      width: 1.5,
                    ),
                    gradient: isSelected
                        ? FigmaColors.primaryGradient(context)
                        : null,
                  ),
                  child: isSelected
                      ? const Icon(
                    CupertinoIcons.checkmark,
                    size: 12,
                    color: Colors.white,
                  )
                      : null,
                ),
              );
            },
            itemBuilder: (context, item, isDisabled, isSelected) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  item.val.toString(),
                  style: AppFont.font(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? theme.primaryColor : theme.colorScheme.onSurface,
                  ),
                ),
              );
            },
            listViewProps: const ListViewProps(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            searchFieldProps: TextFieldProps(
              style: m_ui.TextStyle(
                fontFamily: AppFont.activeFont,
                color: theme.colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: m_ui.InputDecoration(
                labelText: 'search_lbl'.tr,
                hintText: 'search_param'.trParams({'name': labelText}),
                labelStyle: m_ui.TextStyle(fontFamily: AppFont.activeFont, color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6)),
                hintStyle: m_ui.TextStyle(fontFamily: AppFont.activeFont, color: isDark ? Colors.white60 : Colors.black.withValues(alpha: 0.3)),
                fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                filled: true,
                contentPadding: const m_ui.EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: m_ui.OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: m_ui.BorderSide.none,
                ),
                enabledBorder: m_ui.OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: m_ui.BorderSide.none,
                ),
                focusedBorder: m_ui.OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: m_ui.BorderSide(color: theme.primaryColor, width: 1.5),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                labelText,
                style: AppFont.font(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            modalBottomSheetProps: ModalBottomSheetProps(
              backgroundColor: theme.colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              showDragHandle: true,
            ),
          ),
          dropdownBuilder: (context, selectedList) {
            final displayText = selectedList.isEmpty
                ? 'select_param'.trParams({'name': labelText})
                : selectedList.map((e) => e.val.toString()).join(", ");

            return Row(
              children: [
                // Squircle container on the left using theme.primaryColor
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: theme.primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                const Gap(16),
                // Text Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        labelText,
                        style: AppFont.font(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
                          letterSpacing: 0.2,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        displayText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: selectedList.isEmpty ? FontWeight.w500 : FontWeight.w700,
                          color: selectedList.isEmpty
                              ? (isDark ? Colors.white30 : Colors.black.withValues(alpha: 0.3))
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
  }

  Widget _buildChipSelectionView(
      BuildContext context,
      ThemeData theme,
      bool isDark,
      AppConfig? config,
      ) {
    final primaryColor = theme.primaryColor;
    final primaryGradient = FigmaColors.primaryGradient(context);
    final design = AppInputFieldStyle.resolveDesign(config);
    final isUnderlined = design == 'underlined';

    return Container(
      width: double.infinity,
      padding: isUnderlined
          ? const EdgeInsets.fromLTRB(4, 12, 4, 16)
          : const EdgeInsets.all(16),
      decoration: AppInputFieldStyle.buildContainerDecoration(
        context: context,
        config: config,
        suppressUnderline: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labelText,
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      selectedItems.isEmpty
                          ? 'choose_one_or_more'.tr
                          : selectedItems.map((e) => e.val.toString()).join(", "),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: selectedItems.isEmpty
                            ? (isDark ? Colors.white30 : Colors.black.withValues(alpha: 0.3))
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              final isSelected = selectedItems.any((e) => e.id == item.id);
              return GestureDetector(
                onTap: () {
                  final newSelection = List<DropdownOptionModel>.from(selectedItems);
                  if (isSelected) {
                    newSelection.removeWhere((e) => e.id == item.id);
                  } else {
                    newSelection.add(item);
                  }
                  onChanged(newSelection);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: isSelected ? primaryGradient : null,
                    color: isSelected
                        ? null
                        : (isDark
                        ? (design == 'filled' ? const Color(0xFF2A2E45) : darkSecondary)
                        : (design == 'filled'
                        ? Colors.white
                        : const Color(0xFFF6F7FB))),
                    border: isSelected
                        ? null
                        : Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : (design == 'filled'
                          ? Colors.transparent
                          : const Color(0xFFE2E8F0)),
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                        : (design == 'filled'
                        ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]
                        : null),
                  ),
                  child: Text(
                    item.val.toString(),
                    style: AppFont.font(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                          ? Colors.white.withValues(alpha: 0.85)
                          : const Color(0xFF4A4C62)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── CUSTOM FIGMA CHECKBOX ────────────────────────────────────────────────────
class SearchCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SearchCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.dividerColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.01),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: value ? Colors.transparent : (isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFE2E8F0)),
                  width: 1.5,
                ),
                gradient: value
                    ? FigmaColors.primaryGradient(context)
                    : null,
              ),
              child: value
                  ? const Icon(
                CupertinoIcons.checkmark,
                size: 14,
                color: Colors.white,
              )
                  : null,
            ),
            const Gap(12),
            Expanded(
              child: Text(
                label,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── CUSTOM FIGMA TEXT FIELD ───────────────────────────────────────────────────
class SearchIconTextField extends ConsumerWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final IconData? icon;
  final Widget? suffixIcon;
  final String? hint;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final bool readOnly;

  const SearchIconTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.icon,
    this.suffixIcon,
    this.hint,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    return Container(
      decoration: AppInputFieldStyle.buildContainerDecoration(
        context: context,
        config: config,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: theme.primaryColor,
                    size: 20,
                  ),
                ),
              ),
              const Gap(16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labelText,
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
                      letterSpacing: 0.2,
                    ),
                  ),
                  TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: obscureText,
                    onChanged: onChanged,
                    validator: validator,
                    onTap: onTap,
                    readOnly: readOnly,
                    maxLines: maxLines,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white24 : Colors.black.withValues(alpha: 0.24),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            ?suffixIcon,
          ],
        ),
      ),
    );
  }
}
