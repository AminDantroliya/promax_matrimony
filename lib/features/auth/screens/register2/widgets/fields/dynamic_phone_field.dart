import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/features/auth/widgets/country_picker_sheet.dart';
import '../../models/dynamic_form_models.dart';
import 'dynamic_field_container.dart';

class DynamicPhoneField extends ConsumerStatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCountryCodeChanged;

  const DynamicPhoneField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
    this.onCountryCodeChanged,
  });

  @override
  ConsumerState<DynamicPhoneField> createState() => _DynamicPhoneFieldState();
}

class _DynamicPhoneFieldState extends ConsumerState<DynamicPhoneField> {
  late final TextEditingController _controller;
  String _countryCode = "+91";
  String _selectedFlag = "🇮🇳";
  String? _errorText;
  late final List<Country> _countryList;

  @override
  void initState() {
    super.initState();
    final config = ref.read(appConfigProvider);
    _countryCode = config.defaultCountryCode;
    _selectedFlag = config.defaultCountryFlag;
    _initCountryList();
    _parseInitialValue(widget.initialValue);
  }

  void _parseInitialValue(String? raw) {
    final config = ref.read(appConfigProvider);
    if (raw == null || raw.trim().isEmpty) {
      _controller = TextEditingController();
      _countryCode = config.defaultCountryCode;
      _selectedFlag = config.defaultCountryFlag;
      return;
    }
    String val = raw.trim();
    if (val.startsWith("+")) {
      if (val.contains("-")) {
        final parts = val.split("-");
        _countryCode = parts[0];
        val = parts.sublist(1).join("-");
      } else {
        for (final c in _countryList) {
          if (val.startsWith("+${c.dialCode}")) {
            _countryCode = "+${c.dialCode}";
            val = val.substring(_countryCode.length);
            break;
          }
        }
      }
    } else {
      _countryCode = "+91";
    }

    final cleanDial = _countryCode.replaceAll("+", "");
    try {
      final match = _countryList.firstWhere(
        (c) => c.dialCode == cleanDial,
      );
      _selectedFlag = match.flag;
    } catch (_) {}

    _controller = TextEditingController(text: val);
  }

  void _initCountryList() {
    final config = ref.read(appConfigProvider);
    final priorityCodes = [config.defaultCountryIso, 'IN', 'US', 'CA', 'GB', 'AU', 'NZ', 'AE'];
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
        .where((c) => !priorityCodes.any((pc) => pc.toUpperCase() == c.code.toUpperCase()))
        .toList();
    otherList.sort((a, b) => a.name.compareTo(b.name));
    _countryList = [...priorityList, ...otherList];
  }

  @override
  void didUpdateWidget(covariant DynamicPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue && widget.initialValue != null) {
      String val = widget.initialValue!.trim();
      if (val.startsWith("+")) {
        if (val.contains("-")) {
          final parts = val.split("-");
          _countryCode = parts[0];
          val = parts.sublist(1).join("-");
        }
      }
      if (val != _controller.text) {
        _controller.text = val;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _notifyChange() {
    final text = _controller.text.trim();
    if (widget.field.name == 'mobile') {
      widget.onChanged(text);
    } else {
      // Format alternative mobile number with country code (e.g. +91-1241254122)
      if (text.isEmpty) {
        widget.onChanged('');
      } else {
        widget.onChanged('$_countryCode-$text');
      }
    }
  }

  void _showCountryPicker(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF161726) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return CountryPickerSheet(
          countryList: _countryList,
          isDarkMode: isDark,
          onCountrySelected: (country) {
            setState(() {
              _countryCode = "+${country.dialCode}";
              _selectedFlag = country.flag;
            });
            widget.onCountryCodeChanged?.call(_countryCode);
            _notifyChange();
          },
        );
      },
    );
  }

  String? _validate(String? val) {
    final v = val?.trim() ?? '';
    if (widget.field.isRequired && v.isEmpty) {
      return widget.field.validation?.errorMessage ?? 'Please enter phone number';
    }
    if (v.isNotEmpty) {
      final digits = v.replaceAll(RegExp(r'\D'), '');
      final minD = widget.field.validation?.minDigits ?? 7;
      final maxD = widget.field.validation?.maxDigits ?? 15;
      if (digits.length < minD || digits.length > maxD) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DynamicFieldContainer(
      labelText: widget.field.label,
      isRequired: widget.field.isRequired,
      errorText: _errorText,
      child: Row(
        children: [
          // Country Selector Capsule Pill
          GestureDetector(
            onTap: () => _showCountryPicker(context, isDark),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF282B49) : const Color(0xFFF1F3FB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedFlag,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Gap(4),
                  Text(
                    _countryCode,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF16182F),
                    ),
                  ),
                  const Gap(2),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: Color(0xFF8A90A6),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          // Number input
          Expanded(
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              maxLength: 15,
              style: AppFont.font(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF16182F),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                counterText: '',
                errorStyle: const TextStyle(fontSize: 0, height: 0),
                hintText: widget.field.placeholder.isNotEmpty
                    ? widget.field.placeholder
                    : 'Phone number',
                hintStyle: AppFont.font(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8A90A6).withValues(alpha: 0.6),
                ),
              ),
              onChanged: (val) {
                if (_errorText != null) {
                  final err = _validate(val);
                  if (err != _errorText) {
                    setState(() => _errorText = err);
                  }
                }
                _notifyChange();
              },
              validator: (val) {
                final err = _validate(val);
                setState(() => _errorText = err);
                return err != null ? '' : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
