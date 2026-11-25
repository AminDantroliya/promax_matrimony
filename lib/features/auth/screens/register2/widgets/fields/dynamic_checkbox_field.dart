import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import '../../models/dynamic_form_models.dart';

class DynamicCheckboxField extends StatefulWidget {
  final FormFieldModel field;
  final bool? initialValue;
  final ValueChanged<bool> onChanged;

  const DynamicCheckboxField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<DynamicCheckboxField> createState() => _DynamicCheckboxFieldState();
}

class _DynamicCheckboxFieldState extends State<DynamicCheckboxField> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue ?? (widget.field.defaultValue as bool? ?? true);
  }

  @override
  void didUpdateWidget(covariant DynamicCheckboxField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null && widget.initialValue != _isChecked) {
      _isChecked = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2038) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? const Color(0xFF2E3150) : const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _isChecked = !_isChecked);
                widget.onChanged(_isChecked);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _isChecked ? theme.primaryColor : (isDark ? const Color(0xFF282B49) : Colors.white),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _isChecked ? theme.primaryColor : const Color(0xFFCBD5E1),
                    width: 1.5,
                  ),
                ),
                child: _isChecked
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
            ),
            const Gap(12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppFont.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : const Color(0xFF64748B),
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(text: "I agree to ProMatri's "),
                    TextSpan(
                      text: "Terms of Service",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(
                            '/cms',
                            extra: {"page_name": "Terms and Condition"},
                          );
                        },
                      style: AppFont.font(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                      ),
                    ),
                    const TextSpan(text: " and acknowledge the "),
                    TextSpan(
                      text: "Privacy Policy",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(
                            '/cms',
                            extra: {"page_name": "Privacy Policy"},
                          );
                        },
                      style: AppFont.font(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
