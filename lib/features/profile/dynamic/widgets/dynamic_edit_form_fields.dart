import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/auth/screens/register2/models/dynamic_form_models.dart';
import 'package:pro_matrimony/features/auth/widgets/country_picker_sheet.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';

/// Base dynamic container supporting card, outlined, filled, and underlined designs
class DynamicEditContainer extends ConsumerWidget {
  final String labelText;
  final bool isRequired;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? errorText;
  final bool isFocused;
  final bool suppressUnderline;

  const DynamicEditContainer({
    super.key,
    required this.labelText,
    this.isRequired = false,
    required this.child,
    this.trailing,
    this.onTap,
    this.errorText,
    this.isFocused = false,
    this.suppressUnderline = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasError = errorText != null && errorText!.isNotEmpty;
    final config = ref.watch(appConfigProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap != null
                ? () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    onTap!();
                  }
                : null,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: AppInputFieldStyle.getContainerPadding(
                config,
                isGroupOrSlider: suppressUnderline,
              ),
              decoration: AppInputFieldStyle.buildContainerDecoration(
                context: context,
                config: config,
                isFocused: isFocused,
                hasError: hasError,
                suppressUnderline: suppressUnderline,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              labelText,
                              style: AppInputFieldStyle.getLabelStyle(
                                context: context,
                                config: config,
                                hasError: hasError,
                              ),
                            ),
                            if (isRequired)
                              Text(
                                ' *',
                                style: AppFont.font(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                        const Gap(4),
                        child,
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const Gap(8),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                errorText!,
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Single Select Dropdown matching screenshot design
class DynamicEditSingleDropdown extends StatelessWidget {
  final FormFieldModel field;
  final List<DropdownOptionModel> items;
  final dynamic selectedValue;
  final ValueChanged<dynamic> onChanged;
  final bool isLoading;
  final bool isPartnerPreference;

  const DynamicEditSingleDropdown({
    super.key,
    required this.field,
    required this.items,
    this.selectedValue,
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

  DropdownOptionModel? _findSelected() {
    if (selectedValue == null) return null;
    final valStr = selectedValue.toString().trim();
    if (valStr.isEmpty) return null;

    final opts = _effectiveItems;
    // 1. Priority: exact match on ID
    for (final item in opts) {
      if (item.id != null && item.id.toString() == valStr) {
        return item;
      }
    }

    // 2. Fallback: match on val only if no ID matched
    for (final item in opts) {
      if (item.val != null && item.val.toString() == valStr) {
        return item;
      }
    }

    return DropdownOptionModel(id: valStr, val: valStr);
  }

  void _showBottomSheet(BuildContext context, FormFieldState<dynamic> state) {
    final opts = _effectiveItems;
    if (opts.isEmpty) return;
    FocusScope.of(context).unfocus();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<DropdownOptionModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E2038) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _SingleSelectionSheet(
        title: field.label,
        items: opts,
        selectedId: selectedValue?.toString(),
        isDark: isDark,
      ),
    ).then((result) {
      if (result != null) {
        final newId = result.id?.toString() ?? result.val?.toString() ?? '';
        state.didChange(newId);
        onChanged(newId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FormField<dynamic>(
      key: ValueKey('${field.name}_${selectedValue?.toString()}'),
      initialValue: selectedValue,
      validator: (v) {
        if (field.isRequired && (v == null || v.toString().trim().isEmpty)) {
          return field.validation?.errorMessage ??
              'please_select_param'.trParams({'name': field.label});
        }
        return null;
      },
      builder: (FormFieldState<dynamic> state) {
        final selected = _findSelected();
        final displayText = selected?.val?.toString() ?? '';

        return DynamicEditContainer(
          labelText: field.label,
          isRequired: field.isRequired,
          errorText: state.errorText,
          onTap: () => _showBottomSheet(context, state),
          trailing: isLoading
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: Color(0xFF8E90A6),
                ),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              displayText.isNotEmpty
                  ? displayText
                  : (field.placeholder.isNotEmpty
                      ? field.placeholder
                      : 'Select ${field.label}'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFont.font(
                fontSize: 15,
                fontWeight: displayText.isNotEmpty ? FontWeight.w700 : FontWeight.w500,
                color: displayText.isNotEmpty
                    ? (isDark ? Colors.white : const Color(0xFF1E2038))
                    : const Color(0xFF8A90A6),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SingleSelectionSheet extends StatefulWidget {
  final String title;
  final List<DropdownOptionModel> items;
  final String? selectedId;
  final bool isDark;

  const _SingleSelectionSheet({
    required this.title,
    required this.items,
    this.selectedId,
    required this.isDark,
  });

  @override
  State<_SingleSelectionSheet> createState() => _SingleSelectionSheetState();
}

class _SingleSelectionSheetState extends State<_SingleSelectionSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<DropdownOptionModel> _filtered = [];
  String? _resolvedSelectedId;

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
    _searchCtrl.addListener(_onSearch);

    if (widget.selectedId != null && widget.selectedId!.trim().isNotEmpty) {
      final s = widget.selectedId!.trim();
      // First priority: match strictly by ID
      DropdownOptionModel? matched;
      for (final i in widget.items) {
        if (i.id != null && i.id.toString() == s) {
          matched = i;
          break;
        }
      }
      // Fallback: match by display value only if no ID matched
      if (matched == null) {
        for (final i in widget.items) {
          if (i.val != null && i.val.toString() == s) {
            matched = i;
            break;
          }
        }
      }
      _resolvedSelectedId = matched?.id?.toString() ?? matched?.val?.toString() ?? s;
    }
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase().trim();
    if (q.isEmpty) {
      setState(() => _filtered = widget.items);
    } else {
      setState(() {
        _filtered = widget.items
            .where((i) => (i.val?.toString() ?? '').toLowerCase().contains(q))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: widget.isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: AppFont.font(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: widget.isDark ? Colors.white : const Color(0xFF1E2038),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: widget.isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: widget.isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.items.length > 7) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: TextField(
                    controller: _searchCtrl,
                    style: AppFont.font(
                      fontSize: 14,
                      color: widget.isDark ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'search'.tr,
                      hintStyle: AppFont.font(
                        fontSize: 14,
                        color: const Color(0xFF8A90A6),
                      ),
                      prefixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF8A90A6)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      fillColor: widget.isDark ? const Color(0xFF282A45) : const Color(0xFFF1F3F9),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filtered.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  itemBuilder: (context, index) {
                    final item = _filtered[index];
                    final isSelected = _resolvedSelectedId != null &&
                        ((item.id != null && item.id.toString() == _resolvedSelectedId) ||
                         (item.id == null && item.val != null && item.val.toString() == _resolvedSelectedId));

                    return ListTile(
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: isSelected
                          ? theme.primaryColor.withValues(alpha: 0.08)
                          : Colors.transparent,
                      title: Text(
                        item.val?.toString() ?? '',
                        style: AppFont.font(
                          fontSize: 14.5,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? theme.primaryColor
                              : (widget.isDark ? Colors.white : const Color(0xFF1E2038)),
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check_circle_rounded, color: theme.primaryColor, size: 20)
                          : null,
                      onTap: () => Navigator.pop(context, item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Text Input & Text Area Field matching screenshot design
class DynamicEditTextInput extends StatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final bool isNumber;

  const DynamicEditTextInput({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
    this.isNumber = false,
  });

  @override
  State<DynamicEditTextInput> createState() => _DynamicEditTextInputState();
}

class _DynamicEditTextInputState extends State<DynamicEditTextInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void didUpdateWidget(covariant DynamicEditTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null &&
        widget.initialValue != _controller.text &&
        !_isFocused) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMulti = widget.field.maxLines > 1 || widget.field.type == 'textarea';

    return FormField<String>(
      key: ValueKey(widget.field.name),
      initialValue: _controller.text,
      validator: (v) {
        if (widget.field.isRequired && isNullFromBlankString(_controller.text)) {
          return widget.field.validation?.errorMessage ??
              'please_enter_param'.trParams({'name': widget.field.label});
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return DynamicEditContainer(
          labelText: widget.field.label,
          isRequired: widget.field.isRequired,
          errorText: state.errorText,
          isFocused: _isFocused,
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: isMulti ? widget.field.maxLines : 1,
            keyboardType: widget.isNumber || widget.field.type == 'number'
                ? TextInputType.number
                : (isMulti ? TextInputType.multiline : TextInputType.text),
            style: AppFont.font(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E2038),
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.field.placeholder.isNotEmpty
                  ? widget.field.placeholder
                  : 'Enter ${widget.field.label}',
              hintStyle: AppFont.font(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8A90A6),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (val) {
              state.didChange(val);
              widget.onChanged(val);
            },
          ),
        );
      },
    );
  }
}

/// Phone Field with flag picker & dial code matching Screenshot 1
class DynamicEditPhoneField extends ConsumerStatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const DynamicEditPhoneField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  @override
  ConsumerState<DynamicEditPhoneField> createState() =>
      _DynamicEditPhoneFieldState();
}

class _DynamicEditPhoneFieldState
    extends ConsumerState<DynamicEditPhoneField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;
  late String _dialCode;
  late String _flag;
  late final List<Country> _countryList;

  @override
  void initState() {
    super.initState();
    final config = ref.read(appConfigProvider);
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
    _dialCode = config.defaultCountryCode.isNotEmpty
        ? (config.defaultCountryCode.startsWith('+')
            ? config.defaultCountryCode
            : '+${config.defaultCountryCode}')
        : '+91';
    _flag = config.defaultCountryFlag.isNotEmpty
        ? config.defaultCountryFlag
        : '🇮🇳';
    _initCountryList();
    _parseInitial(widget.initialValue, isInit: true);
  }

  void _initCountryList() {
    final config = ref.read(appConfigProvider);
    final priorityCodes = [
      config.defaultCountryIso,
      'IN',
      'US',
      'CA',
      'GB',
      'AU',
      'NZ',
      'AE',
    ];
    final List<Country> priorityList = [];
    for (var code in priorityCodes) {
      try {
        final match = countries.firstWhere(
          (c) => c.code.toUpperCase() == code.toUpperCase(),
        );
        if (!priorityList.any((c) => c.code == match.code)) {
          priorityList.add(match);
        }
      } catch (_) {}
    }
    final List<Country> otherList = countries
        .where((c) => !priorityCodes
            .any((pc) => pc.toUpperCase() == c.code.toUpperCase()))
        .toList();
    otherList.sort((a, b) => a.name.compareTo(b.name));
    _countryList = [...priorityList, ...otherList];
  }

  void _parseInitial(String? raw, {bool isInit = false}) {
    final config = ref.read(appConfigProvider);
    final defaultCode = config.defaultCountryCode.isNotEmpty
        ? (config.defaultCountryCode.startsWith('+')
            ? config.defaultCountryCode
            : '+${config.defaultCountryCode}')
        : '+91';

    var rawText = (raw ?? '').trim();
    String newDialCode = defaultCode;
    String newPhone = '';

    if (rawText.isNotEmpty) {
      if (rawText.contains('-')) {
        final parts = rawText.split('-');
        newDialCode = parts[0].startsWith('+') ? parts[0] : '+${parts[0]}';
        newPhone = parts.sublist(1).join('-');
      } else if (rawText.startsWith('+')) {
        Country? matched;
        for (final c in _countryList) {
          if (rawText.startsWith('+${c.dialCode}')) {
            matched = c;
            break;
          }
        }
        if (matched != null) {
          newDialCode = '+${matched.dialCode}';
          newPhone = rawText.substring(matched.dialCode.length + 1);
        } else {
          newDialCode = defaultCode;
          newPhone = rawText;
        }
      } else {
        newDialCode = defaultCode;
        newPhone = rawText;
      }
    }

    _dialCode = newDialCode;
    final c = _countryList.firstWhere(
      (c) => '+${c.dialCode}' == _dialCode,
      orElse: () => _countryList.firstWhere(
        (c) => c.code.toUpperCase() == config.defaultCountryIso.toUpperCase(),
        orElse: () => countries.first,
      ),
    );
    _flag = c.flag;

    if (isInit) {
      _controller.text = newPhone;
    } else if (!_isFocused && _controller.text != newPhone) {
      _controller.text = newPhone;
    }
  }

  @override
  void didUpdateWidget(covariant DynamicEditPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != null) {
      _parseInitial(widget.initialValue, isInit: false);
    }
  }

  void _showCountryPicker(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E2038) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => CountryPickerSheet(
        countryList: _countryList,
        isDarkMode: isDark,
        onCountrySelected: (c) {
          setState(() {
            _dialCode = '+${c.dialCode}';
            _flag = c.flag;
          });
          _notify();
        },
      ),
    );
  }

  void _notify() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      widget.onChanged('');
    } else {
      widget.onChanged('$_dialCode-$text');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FormField<String>(
      key: ValueKey(widget.field.name),
      initialValue: _controller.text,
      validator: (v) {
        if (widget.field.isRequired && _controller.text.trim().isEmpty) {
          return 'please_enter_phone_number'.tr;
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return DynamicEditContainer(
          labelText: widget.field.label,
          isRequired: widget.field.isRequired,
          errorText: state.errorText,
          isFocused: _isFocused,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _showCountryPicker(context),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_flag, style: const TextStyle(fontSize: 18)),
                    const Gap(6),
                    Text(
                      _dialCode,
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1E2038),
                      ),
                    ),
                    const Gap(4),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      size: 14,
                      color: Color(0xFF8E90A6),
                    ),
                    const Gap(10),
                    Container(
                      width: 1,
                      height: 20,
                      color: isDark ? Colors.white24 : Colors.black12,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  style: AppFont.font(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1E2038),
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.field.placeholder.isNotEmpty
                        ? widget.field.placeholder
                        : 'Phone number',
                    hintStyle: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8A90A6),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) {
                    state.didChange(val);
                    _notify();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Time Picker Field matching Screenshot 1 (e.g. 11:57 AM)
class DynamicEditTimePicker extends StatelessWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const DynamicEditTimePicker({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  String _formatDisplay(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    try {
      final parts = raw.split(':');
      if (parts.length >= 2) {
        final h = int.tryParse(parts[0]) ?? 0;
        final m = int.tryParse(parts[1]) ?? 0;
        final period = h >= 12 ? 'PM' : 'AM';
        final displayHour = h == 0 ? 12 : (h > 12 ? h - 12 : h);
        return '${displayHour.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')} $period';
      }
    } catch (_) {}
    return raw;
  }

  void _pickTime(BuildContext context, FormFieldState<String> state) async {
    int initialHour = 12;
    int initialMinute = 0;

    if (initialValue != null && initialValue!.isNotEmpty) {
      final parts = initialValue!.split(':');
      if (parts.length >= 2) {
        initialHour = int.tryParse(parts[0]) ?? 12;
        initialMinute = int.tryParse(parts[1]) ?? 0;
      }
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: initialMinute),
    );

    if (picked != null) {
      final h = picked.hour.toString().padLeft(2, '0');
      final m = picked.minute.toString().padLeft(2, '0');
      final val24 = '$h:$m';
      state.didChange(val24);
      onChanged(val24);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final display = _formatDisplay(initialValue);

    return FormField<String>(
      initialValue: initialValue,
      validator: (v) {
        if (field.isRequired && (v == null || v.trim().isEmpty)) {
          return 'please_select_param'.trParams({'name': field.label});
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return DynamicEditContainer(
          labelText: field.label,
          isRequired: field.isRequired,
          errorText: state.errorText,
          onTap: () => _pickTime(context, state),
          trailing: const Icon(
            CupertinoIcons.clock,
            size: 16,
            color: Color(0xFF8E90A6),
          ),
          child: Text(
            display.isNotEmpty ? display : 'HH:MM AM',
            style: AppFont.font(
              fontSize: 15,
              fontWeight: display.isNotEmpty ? FontWeight.w700 : FontWeight.w500,
              color: display.isNotEmpty
                  ? (isDark ? Colors.white : const Color(0xFF1E2038))
                  : const Color(0xFF8A90A6),
            ),
          ),
        );
      },
    );
  }
}

/// Multi-Select Dropdown matching Partner Preference / Education
class DynamicEditMultiDropdown extends StatelessWidget {
  final FormFieldModel field;
  final List<DropdownOptionModel> items;
  final dynamic selectedValue;
  final ValueChanged<String> onChanged;
  final bool isLoading;
  final bool isPartnerPreference;

  const DynamicEditMultiDropdown({
    super.key,
    required this.field,
    required this.items,
    this.selectedValue,
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

  List<String> _getSelectedIds() {
    if (selectedValue == null) return [];
    if (selectedValue is List) {
      return (selectedValue as List)
          .map((e) => e is DropdownOptionModel ? (e.id?.toString() ?? '') : e.toString())
          .where((s) => s.isNotEmpty)
          .toList();
    }
    final str = selectedValue.toString().trim();
    if (str.isEmpty) return [];
    return str.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  }

  void _showBottomSheet(BuildContext context, FormFieldState<String> state) {
    final opts = _effectiveItems;
    if (opts.isEmpty) return;
    FocusScope.of(context).unfocus();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentSelected = _getSelectedIds();

    showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E2038) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _MultiSelectionSheet(
        title: field.label,
        items: opts,
        initialSelected: currentSelected,
        isDark: isDark,
        isPartnerPreference: _isPartner,
      ),
    ).then((result) {
      if (result != null) {
        final joined = result.join(',');
        state.didChange(joined);
        onChanged(joined);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedIds = _getSelectedIds();
    final opts = _effectiveItems;

    final selectedNames = opts
        .where((i) => selectedIds.contains(i.id?.toString()))
        .map((i) => i.val?.toString() ?? '')
        .toList();

    final displayText = selectedNames.isNotEmpty
        ? selectedNames.join(', ')
        : (selectedIds.isNotEmpty ? '${selectedIds.length} selected' : '');

    return FormField<String>(
      initialValue: selectedIds.join(','),
      validator: (v) {
        if (field.isRequired && (v == null || v.trim().isEmpty)) {
          return 'please_select_param'.trParams({'name': field.label});
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return DynamicEditContainer(
          labelText: field.label,
          isRequired: field.isRequired,
          errorText: state.errorText,
          onTap: () => _showBottomSheet(context, state),
          trailing: isLoading
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: Color(0xFF8E90A6),
                ),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              displayText.isNotEmpty
                  ? displayText
                  : (field.placeholder.isNotEmpty
                      ? field.placeholder
                      : 'Select ${field.label}'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFont.font(
                fontSize: 15,
                fontWeight: displayText.isNotEmpty ? FontWeight.w700 : FontWeight.w500,
                color: displayText.isNotEmpty
                    ? (isDark ? Colors.white : const Color(0xFF1E2038))
                    : const Color(0xFF8A90A6),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MultiSelectionSheet extends StatefulWidget {
  final String title;
  final List<DropdownOptionModel> items;
  final List<String> initialSelected;
  final bool isDark;
  final bool isPartnerPreference;

  const _MultiSelectionSheet({
    required this.title,
    required this.items,
    required this.initialSelected,
    required this.isDark,
    this.isPartnerPreference = false,
  });

  @override
  State<_MultiSelectionSheet> createState() => _MultiSelectionSheetState();
}

class _MultiSelectionSheetState extends State<_MultiSelectionSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  late final Set<String> _selected;
  List<DropdownOptionModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initialSelected);
    if (widget.isPartnerPreference && _selected.contains('DOES_NOT_MATTER') && _selected.length > 1) {
      _selected.remove('DOES_NOT_MATTER');
    }
    _filtered = widget.items;
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase().trim();
    if (q.isEmpty) {
      setState(() => _filtered = widget.items);
    } else {
      setState(() {
        _filtered = widget.items
            .where((i) => (i.val?.toString() ?? '').toLowerCase().contains(q))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: widget.isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: AppFont.font(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: widget.isDark ? Colors.white : const Color(0xFF1E2038),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, _selected.toList()),
                      child: Text(
                        'btn_done'.tr,
                        style: AppFont.font(
                          fontWeight: FontWeight.w700,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.items.length > 7) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: TextField(
                    controller: _searchCtrl,
                    style: AppFont.font(
                      fontSize: 14,
                      color: widget.isDark ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'search'.tr,
                      hintStyle: AppFont.font(
                        fontSize: 14,
                        color: const Color(0xFF8A90A6),
                      ),
                      prefixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF8A90A6)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      fillColor: widget.isDark ? const Color(0xFF282A45) : const Color(0xFFF1F3F9),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filtered.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  itemBuilder: (context, index) {
                    final item = _filtered[index];
                    final itemId = item.id?.toString() ?? item.val?.toString() ?? '';
                    final isChecked = _selected.contains(itemId);

                    return CheckboxListTile(
                      dense: true,
                      activeColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        item.val?.toString() ?? '',
                        style: AppFont.font(
                          fontSize: 14.5,
                          fontWeight: isChecked ? FontWeight.w700 : FontWeight.w500,
                          color: isChecked
                              ? theme.primaryColor
                              : (widget.isDark ? Colors.white : const Color(0xFF1E2038)),
                        ),
                      ),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            if (widget.isPartnerPreference && itemId == 'DOES_NOT_MATTER') {
                              _selected.clear();
                              _selected.add('DOES_NOT_MATTER');
                            } else {
                              if (widget.isPartnerPreference) {
                                _selected.remove('DOES_NOT_MATTER');
                              }
                              _selected.add(itemId);
                            }
                          } else {
                            _selected.remove(itemId);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dual-thumb Range Slider Field matching Search & Register Partner Preference
class DynamicEditRangeSlider extends ConsumerStatefulWidget {
  final FormFieldModel field;
  final RangeValues? initialValue;
  final ValueChanged<RangeValues> onChanged;

  const DynamicEditRangeSlider({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  @override
  ConsumerState<DynamicEditRangeSlider> createState() =>
      _DynamicEditRangeSliderState();
}

class _DynamicEditRangeSliderState
    extends ConsumerState<DynamicEditRangeSlider> {
  late RangeValues _current;
  late double _min;
  late double _max;

  @override
  void initState() {
    super.initState();
    final isHeight = widget.field.name.contains('height');
    _min = widget.field.minVal ?? (isHeight ? 48.0 : 18.0);
    _max = (widget.field.maxVal != null && widget.field.maxVal! > _min)
        ? widget.field.maxVal!
        : (isHeight ? 84.0 : 60.0);

    if (widget.initialValue != null) {
      final s = widget.initialValue!.start.clamp(_min, _max);
      final e = widget.initialValue!.end.clamp(_min, _max);
      _current = RangeValues(s <= e ? s : _min, s <= e ? e : _max);
    } else if (widget.field.defaultRange != null &&
        widget.field.defaultRange!.length >= 2) {
      final s = widget.field.defaultRange![0].clamp(_min, _max);
      final e = widget.field.defaultRange![1].clamp(_min, _max);
      _current = RangeValues(s <= e ? s : _min, s <= e ? e : _max);
    } else {
      _current = RangeValues(_min, _max);
    }
  }

  @override
  void didUpdateWidget(covariant DynamicEditRangeSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null && widget.initialValue != _current) {
      final s = widget.initialValue!.start.clamp(_min, _max);
      final e = widget.initialValue!.end.clamp(_min, _max);
      setState(() {
        _current = RangeValues(s <= e ? s : _min, s <= e ? e : _max);
      });
    }
  }

  String _formatRangeLabel(RangeValues range, bool isHeight) {
    if (isHeight) {
      final start = range.start.round();
      final end = range.end.round();
      if (_max <= 100) {
        final sFt = start ~/ 12;
        final sIn = start % 12;
        final eFt = end ~/ 12;
        final eIn = end % 12;
        return "$sFt-$sIn ft - $eFt-$eIn ft";
      }
      return '$start cm - $end cm';
    }
    return '${range.start.round()} Year - ${range.end.round()} Year';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isHeight = widget.field.name.contains('height');
    final config = ref.watch(appConfigProvider);
    final isUnderlined =
        AppInputFieldStyle.resolveDesign(config) == 'underlined';

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.field.label.toUpperCase(),
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF8E90A6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (widget.field.isRequired)
                      Text(
                        ' *',
                        style: AppFont.font(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
                Text(
                  _formatRangeLabel(_current, isHeight),
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
                inactiveTrackColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFEEF0FB),
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
                values: _current,
                min: _min,
                max: _max,
                divisions: (_max - _min).round().clamp(1, 500),
                onChanged: (values) {
                  setState(() => _current = values);
                  widget.onChanged(values);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
