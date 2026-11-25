import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/utils/utils.dart';
import '../../models/dynamic_form_models.dart';
import 'dynamic_field_container.dart';

class DynamicMultiDropdownField extends StatelessWidget {
  final FormFieldModel field;
  final List<DropdownOptionModel> items;
  final List<DropdownOptionModel> selectedItems;
  final ValueChanged<List<DropdownOptionModel>> onChanged;
  final bool isLoading;
  final bool isPartnerPreference;

  const DynamicMultiDropdownField({
    super.key,
    required this.field,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.isLoading = false,
    this.isPartnerPreference = false,
  });

  bool get _isPartner =>
      isPartnerPreference ||
      field.name.toLowerCase().startsWith('part_') ||
      field.name.toLowerCase().startsWith('partner_') ||
      field.label.toLowerCase().contains('partner');

  List<DropdownOptionModel> get _effectiveItems {
    if (!_isPartner || items.isEmpty) return items;
    final hasDnm = items.any((e) =>
        e.id?.toString() == 'DOES_NOT_MATTER' ||
        e.val?.toString().toLowerCase() == 'does not matter');
    if (hasDnm) return items;
    return [
      DropdownOptionModel(
        id: 'DOES_NOT_MATTER',
        val: 'does_not_matter'.tr.isNotEmpty && 'does_not_matter'.tr != 'does_not_matter'
            ? 'does_not_matter'.tr
            : 'Does Not Matter',
      ),
      ...items,
    ];
  }

  void _showMultiSelectSheet(
    BuildContext context,
    bool isDark,
    FormFieldState<List<DropdownOptionModel>> state,
  ) {
    final opts = _effectiveItems;
    if (opts.isEmpty) return;
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    showModalBottomSheet<List<DropdownOptionModel>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF161726) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return _MultiDropdownBottomSheet(
          field: field,
          items: opts,
          initialSelected: selectedItems,
          isDark: isDark,
          isPartnerPreference: _isPartner,
        );
      },
    ).then((result) {
      if (result != null) {
        state.didChange(result);
        onChanged(result);
      }
    });
  }

  String? _validate(List<DropdownOptionModel>? val) {
    if (field.isRequired && (val == null || val.isEmpty)) {
      return field.validation?.errorMessage ??
          'Please select at least one ${field.label.toLowerCase()}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FormField<List<DropdownOptionModel>>(
      key: ValueKey(selectedItems.map((e) => e.id).join(',')),
      initialValue: selectedItems,
      validator: _validate,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (FormFieldState<List<DropdownOptionModel>> state) {
        final current = state.value ?? selectedItems;
        final displayVal = current
            .map((e) => e.val?.toString() ?? '')
            .where((e) => e.isNotEmpty)
            .join(', ');

        return DynamicFieldContainer(
          labelText: field.label,
          isRequired: field.isRequired,
          errorText: state.errorText,
          onTap: !isLoading && items.isNotEmpty
              ? () => _showMultiSelectSheet(context, isDark, state)
              : null,
          trailing: isLoading
              ? SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  ),
                )
              : null,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayVal.isNotEmpty
                      ? displayVal
                      : (field.placeholder.isNotEmpty
                          ? field.placeholder
                          : 'Select ${field.label}'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: displayVal.isNotEmpty
                      ? AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color:
                              isDark ? Colors.white : const Color(0xFF16182F),
                        )
                      : AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8A90A6).withValues(alpha: 0.6),
                        ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_rounded,
                color: Color(0xFF8A90A6),
                size: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MultiDropdownBottomSheet extends StatefulWidget {
  final FormFieldModel field;
  final List<DropdownOptionModel> items;
  final List<DropdownOptionModel> initialSelected;
  final bool isDark;
  final bool isPartnerPreference;

  const _MultiDropdownBottomSheet({
    required this.field,
    required this.items,
    required this.initialSelected,
    required this.isDark,
    this.isPartnerPreference = false,
  });

  @override
  State<_MultiDropdownBottomSheet> createState() =>
      _MultiDropdownBottomSheetState();
}

class _MultiDropdownBottomSheetState extends State<_MultiDropdownBottomSheet> {
  late final TextEditingController _searchController;
  late final List<DropdownOptionModel> _tempSelected;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tempSelected = List<DropdownOptionModel>.from(widget.initialSelected);
    if (widget.isPartnerPreference &&
        _tempSelected.any((e) => e.id?.toString() == 'DOES_NOT_MATTER') &&
        _tempSelected.length > 1) {
      _tempSelected.removeWhere((e) => e.id?.toString() == 'DOES_NOT_MATTER');
    }
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final theme = Theme.of(context);

    final filtered = widget.items.where((e) {
      if (_searchQuery.isEmpty) return true;
      final label = e.val?.toString().toLowerCase() ?? '';
      return label.contains(_searchQuery);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SafeArea(
        bottom: true,
        top: false,
        right: false,
        left: false,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select ${widget.field.label}',
                style: AppFont.font(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF16182F),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: isDark ? Colors.white70 : const Color(0xFF8A90A6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Search Field
          if (widget.items.length > 6)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFF4F6F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                style: AppFont.font(
                  fontSize: 14,
                  color: isDark ? Colors.white : const Color(0xFF16182F),
                ),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: AppFont.font(
                    color: const Color(0xFF8A90A6),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFF8A90A6),
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(
                      Icons.clear_rounded,
                      size: 18,
                      color: Color(0xFF8A90A6),
                    ),
                    onPressed: () => _searchController.clear(),
                  )
                      : null,
                ),
              ),
            ),
          const SizedBox(height: 12),

          // List View
          Expanded(
            child: filtered.isEmpty
                ? Center(
              child: Text(
                'No options found',
                style: AppFont.font(
                  color: const Color(0xFF8A90A6),
                ),
              ),
            )
                : ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFF1F3F6),
              ),
              itemBuilder: (context, idx) {
                final item = filtered[idx];
                final isSelected =
                _tempSelected.any((e) => e.id == item.id);
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  title: Text(
                    item.val?.toString() ?? '',
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isDark
                          ? Colors.white
                          : const Color(0xFF16182F),
                    ),
                  ),
                  leading: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isSelected
                            ? theme.primaryColor
                            : (isDark
                            ? const Color(0xFF3E4160)
                            : const Color(0xFFD1D5DB)),
                        width: 1.5,
                      ),
                      color: isSelected
                          ? theme.primaryColor
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(
                      CupertinoIcons.checkmark,
                      size: 13,
                      color: Colors.white,
                    )
                        : null,
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _tempSelected
                            .removeWhere((e) => e.id == item.id);
                      } else {
                        if (widget.isPartnerPreference &&
                            (item.id?.toString() == 'DOES_NOT_MATTER' ||
                                item.val?.toString().toLowerCase() ==
                                    'does not matter')) {
                          _tempSelected.clear();
                          _tempSelected.add(item);
                        } else {
                          if (widget.isPartnerPreference) {
                            _tempSelected.removeWhere((e) =>
                            e.id?.toString() == 'DOES_NOT_MATTER' ||
                                e.val?.toString().toLowerCase() ==
                                    'does not matter');
                          }
                          _tempSelected.add(item);
                        }
                      }
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _tempSelected);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.getButtonBorderRadius(context),
                ),
              ),
              child: Text(
                'Apply (${_tempSelected.length})',
                style: AppFont.font(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),)
    );
  }
}
