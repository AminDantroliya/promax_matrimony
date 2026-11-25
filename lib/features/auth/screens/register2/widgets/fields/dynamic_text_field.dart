import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import '../../models/dynamic_form_models.dart';
import 'dynamic_field_container.dart';

const String _eyeSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
  <circle cx="12" cy="12" r="3"></circle>
</svg>
''';

const String _eyeOffSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
  <line x1="1" y1="1" x2="23" y2="23"></line>
</svg>
''';

class DynamicTextField extends StatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final Map<String, dynamic> allFormValues;

  const DynamicTextField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
    this.allFormValues = const {},
  });

  @override
  State<DynamicTextField> createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  late final TextEditingController _controller;
  bool _obscureText = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void didUpdateWidget(covariant DynamicTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null && widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextInputType _getKeyboardType() {
    switch (widget.field.type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'number':
        return TextInputType.number;
      case 'textarea':
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  String? _validate(String? val) {
    final v = val?.trim() ?? '';
    final rule = widget.field.validation;

    if (widget.field.isRequired && v.isEmpty) {
      return rule?.errorMessage ?? 'Please enter ${widget.field.label}';
    }

    if (v.isNotEmpty) {
      if (rule?.minLength != null && v.length < rule!.minLength!) {
        return rule.errorMessage ?? 'Must be at least ${rule.minLength} characters';
      }
      if (rule?.maxLength != null && v.length > rule!.maxLength!) {
        return rule.errorMessage ?? 'Cannot exceed ${rule.maxLength} characters';
      }
      if (rule?.regex != null) {
        final reg = RegExp(rule!.regex!);
        if (!reg.hasMatch(v)) {
          return rule.errorMessage ?? 'Invalid format for ${widget.field.label}';
        }
      }
      if (rule?.matchField != null) {
        final matchVal = widget.allFormValues[rule!.matchField]?.toString() ?? '';
        if (v != matchVal) {
          return rule.errorMessage ?? 'Fields do not match';
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isPassword = widget.field.type == 'password';
    final isTextArea = widget.field.type == 'textarea' || widget.field.maxLines > 1;
    final rule = widget.field.validation;

    return DynamicFieldContainer(
      labelText: widget.field.label,
      isRequired: widget.field.isRequired,
      errorText: _errorText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  keyboardType: _getKeyboardType(),
                  obscureText: isPassword && _obscureText,
                  minLines: isTextArea ? (widget.field.maxLines > 2 ? 3 : 2) : 1,
                  maxLines: isPassword ? 1 : (isTextArea ? widget.field.maxLines : 1),
                  inputFormatters: rule?.maxLength != null
                      ? [LengthLimitingTextInputFormatter(rule!.maxLength)]
                      : null,
                  textCapitalization: widget.field.name == 'fullname'
                      ? TextCapitalization.words
                      : TextCapitalization.none,
                  style: AppFont.font(
                    context: context,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF16182F),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    errorStyle: const TextStyle(fontSize: 0, height: 0),
                    hintText: widget.field.placeholder.isNotEmpty
                        ? widget.field.placeholder
                        : (isPassword ? '••••••••' : 'Enter ${widget.field.label}'),
                    hintStyle: AppFont.font(
                      context: context,
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
                    widget.onChanged(val);
                  },
                  validator: (val) {
                    final err = _validate(val);
                    setState(() => _errorText = err);
                    return err != null ? '' : null; // Suppress default error line since container shows it
                  },
                ),
              ),
              if (isPassword)
                GestureDetector(
                  onTap: () => setState(() => _obscureText = !_obscureText),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.string(
                      _obscureText ? _eyeOffSvg : _eyeSvg,
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8A90A6),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (isTextArea && rule?.maxLength != null)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, _) {
                    return Text(
                      '${value.text.length}/${rule!.maxLength}',
                      style: AppFont.font(
                        context: context,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8A90A6),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
