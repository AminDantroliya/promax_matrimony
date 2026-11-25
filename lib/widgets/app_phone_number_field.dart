import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import '../utils/utils.dart';

class AppPhoneNumberField extends ConsumerStatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final String? Function(PhoneNumber?)? validator;
  final bool? readOnly;
  final bool? enabled;
  final String? hint;
  final String? initialCountryCode;
  final GestureTapCallback? onTap;
  final List<Country>? countryList;
  final bool showCountryFlag;

  const AppPhoneNumberField({
    super.key,
    required this.labelText,
    this.controller,
    this.onChanged,
    this.onCountryChanged,
    this.validator,
    this.readOnly,
    this.enabled,
    this.hint,
    this.initialCountryCode,
    this.onTap,
    this.countryList,
    this.showCountryFlag = true,
  });

  @override
  ConsumerState<AppPhoneNumberField> createState() =>
      CustomPhoneNumberWidgetState();
}

class CustomPhoneNumberWidgetState extends ConsumerState<AppPhoneNumberField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hint = widget.hint ?? widget.labelText.replaceAll('*', '').trim();

    return FormField<PhoneNumber>(
      validator: widget.validator,
      builder: (FormFieldState<PhoneNumber> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: state.hasError
                      ? theme.colorScheme.error
                      : (_isFocused
                      ? theme.colorScheme.primary
                      : (isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFE2E8F0))),
                  width: _isFocused || state.hasError ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: widget.labelText.replaceAll('*', '').trim(),
                        style: AppFont.font(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6),
                          letterSpacing: 0.2,
                        ),
                        children: [
                          if (widget.labelText.contains('*'))
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                        ],
                      ),
                    ),
                    const Gap(2),
                    IntlPhoneField(
                      textAlignVertical: TextAlignVertical.center,
                      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                      focusNode: _focusNode,
                      controller: widget.controller,
                      onTap: widget.onTap,
                      readOnly: widget.readOnly ?? false,
                      enabled: widget.enabled ?? true,
                      invalidMessage: 'invalid_phone_error'.tr,
                      dialogType: DialogType.showModalBottomSheet,
                      keyboardType: TextInputType.number,
                      decoration: m_ui.InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                          fontFamily: AppFont.activeFont,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white24 : Colors.black.withValues(alpha: 0.24),
                        ),
                        border: m_ui.InputBorder.none,
                        enabledBorder: m_ui.InputBorder.none,
                        focusedBorder: m_ui.InputBorder.none,
                        errorBorder: m_ui.InputBorder.none,
                        focusedErrorBorder: m_ui.InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        isDense: true,
                        counterText: "",
                      ),
                      initialCountryCode: getCountryCode(
                        widget.initialCountryCode ??
                            ref.watch(appConfigProvider).defaultCountryCode,
                      ),
                      dropdownIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 20,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      dropdownIconPosition: IconPosition.trailing,
                      showCountryFlag: widget.showCountryFlag,
                      dropdownTextStyle: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                      flagsButtonMargin: EdgeInsets.zero,
                      flagsButtonPadding: const EdgeInsets.only(left: 0, right: 8),
                      countries: widget.countryList,
                      pickerDialogStyle: PickerDialogStyle(
                        countryCodeStyle: AppFont.font(color: theme.colorScheme.onSurface, fontSize: 15),
                        countryNameStyle: AppFont.font(color: theme.colorScheme.onSurface, fontSize: 15),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                        searchFieldPadding: const EdgeInsets.symmetric(horizontal: 16),
                        listTileDivider: Divider(height: 1, color: theme.dividerColor),
                        searchFieldInputDecoration: m_ui.InputDecoration(
                          labelText: "Search country",
                          labelStyle: TextStyle(fontFamily: AppFont.activeFont, color: isDark ? const Color(0xFF8E90A6) : const Color(0xFF8E90A6)),
                          hintStyle: TextStyle(fontFamily: AppFont.activeFont, color: isDark ? Colors.white30 : Colors.black.withValues(alpha: 0.3)),
                          fillColor: theme.colorScheme.surface,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: m_ui.OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          enabledBorder: m_ui.OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          focusedBorder: m_ui.OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                          ),
                        ),
                      ),
                      onChanged: (phone) {
                        state.didChange(phone);
                        widget.onChanged?.call(phone);
                      },
                      onCountryChanged: widget.onCountryChanged,
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError) ...[
              const Gap(4),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: 12,
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
