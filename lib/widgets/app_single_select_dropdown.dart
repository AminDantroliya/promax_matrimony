import 'package:dropdown_search/dropdown_search.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';

import '../features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

class AppSingleSelectDropdown extends ConsumerStatefulWidget {
  final String hintText;
  final bool? isShowSearch;
  final bool? isEnabled;
  final List<DropdownOptionModel> items;
  final DropdownOptionModel? selectedItem;
  final ValueChanged<DropdownOptionModel?> onChanged;
  final FormFieldValidator<DropdownOptionModel?>? validator;

  const AppSingleSelectDropdown({
    super.key,
    required this.hintText,
    this.isShowSearch,
    this.isEnabled,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.validator,
  });

  @override
  ConsumerState<AppSingleSelectDropdown> createState() =>
      _CustomSingleSelectDropdownWidgetState();
}

class _CustomSingleSelectDropdownWidgetState
    extends ConsumerState<AppSingleSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hint = widget.hintText.replaceAll('*', '').trim();

    final hasValidSelected = widget.selectedItem != null &&
        widget.selectedItem!.id != null &&
        widget.selectedItem!.val != null;
    final effectiveSelectedItem = hasValidSelected ? widget.selectedItem : null;

    return FormField<DropdownOptionModel>(
      key: ValueKey(effectiveSelectedItem?.id ?? effectiveSelectedItem?.val),
      validator: widget.validator,
      initialValue: effectiveSelectedItem,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<DropdownOptionModel> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: state.hasError ? theme.colorScheme.error : Colors.transparent,
                  width: state.hasError ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: m_ui.Material(
                  type: m_ui.MaterialType.transparency,
                  child: DropdownSearch<DropdownOptionModel>(
                  itemAsString: (DropdownOptionModel model) =>
                  model.val ?? widget.hintText,
                  selectedItem: state.value,
                  enabled: widget.isEnabled ?? true,
                  compareFn: (item1, item2) => item1.id == item2.id,
                  items: (filter, infiniteScrollProps) => widget.items,
                  onSelected: (val) {
                    state.didChange(val);
                    widget.onChanged(val);
                  },
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
                  decoratorProps: const DropDownDecoratorProps(
                    decoration: m_ui.InputDecoration(
                      border: m_ui.InputBorder.none,
                      enabledBorder: m_ui.InputBorder.none,
                      focusedBorder: m_ui.InputBorder.none,
                      errorBorder: m_ui.InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  popupProps: PopupProps.modalBottomSheet(
                    showSearchBox: widget.isShowSearch != null
                        ? widget.isShowSearch!
                        : (widget.items.length > 10),
                    searchDelay: const Duration(milliseconds: 50),
                    showSelectedItems: true,
                    itemBuilder: (context, item, isDisabled, isSelected) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        child: Text(
                          item.val.toString(),
                          style: AppFont.font(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? theme.primaryColor
                                : theme.colorScheme.onSurface,
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
                        hintText: 'search_param'.trParams({'name': hint}),
                        labelStyle: m_ui.TextStyle(
                            fontFamily: AppFont.activeFont,
                            color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6)),
                        hintStyle: m_ui.TextStyle(
                            fontFamily: AppFont.activeFont,
                            color: isDark ? Colors.white60 : Colors.black.withValues(alpha: 0.3)),
                        fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        filled: true,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                      child: RichText(
                        text: TextSpan(
                          text: widget.hintText.replaceAll('*', '').trim(),
                          style: AppFont.font(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                          ),
                          children: [
                            if (widget.hintText.contains('*'))
                              const TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
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
                  dropdownBuilder: (context, selectedItem) {
                    final displayText = selectedItem == null
                        ? 'select_param'.trParams({'name': hint})
                        : selectedItem.val.toString();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: widget.hintText.replaceAll('*', '').trim().toUpperCase(),
                            style: AppFont.font(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
                              letterSpacing: 0.5,
                            ),
                            children: [
                              if (widget.hintText.contains('*'))
                                const TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        ),
                        const Gap(4),
                        Text(
                          displayText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.font(
                            fontSize: 15,
                            fontWeight: selectedItem == null ? FontWeight.w500 : FontWeight.w700,
                            color: selectedItem == null
                                ? (isDark ? Colors.white60 : Colors.black.withValues(alpha: 0.3))
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
            if (state.hasError) ...[
              const Gap(6),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  state.errorText ?? '',
                  style: AppFont.font(
                    fontSize: 12,
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
