import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/features/auth/screens/register2/models/dynamic_form_models.dart';
import 'package:pro_matrimony/features/auth/screens/register2/providers/dynamic_register_notifier.dart';
import 'dynamic_field_container.dart';

class DynamicAiBioField extends ConsumerStatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const DynamicAiBioField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  @override
  ConsumerState<DynamicAiBioField> createState() => _DynamicAiBioFieldState();
}

class _DynamicAiBioFieldState extends ConsumerState<DynamicAiBioField> {
  late final TextEditingController _controller;
  bool _isGenerating = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void didUpdateWidget(covariant DynamicAiBioField oldWidget) {
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

  String? _validate(String? val) {
    final v = val?.trim() ?? '';
    final rule = widget.field.validation;

    if (widget.field.isRequired && v.isEmpty) {
      return rule?.errorMessage ?? 'Please enter ${widget.field.label}';
    }

    if (v.isNotEmpty) {
      if (rule?.minLength != null && v.length < rule!.minLength!) {
        return rule.errorMessage ??
            'Must be at least ${rule.minLength} characters';
      }
      if (rule?.maxLength != null && v.length > rule!.maxLength!) {
        return rule.errorMessage ??
            'Cannot exceed ${rule.maxLength} characters';
      }
      if (rule?.regex != null) {
        final reg = RegExp(rule!.regex!);
        if (!reg.hasMatch(v)) {
          return rule.errorMessage ?? 'Invalid format for ${widget.field.label}';
        }
      }
    }
    return null;
  }

  Future<void> _handleGenerateAI() async {
    setState(() => _isGenerating = true);
    final notifier = ref.read(dynamicRegisterProvider.notifier);
    final bio = await notifier.generateAboutMeWithAI(context);
    setState(() => _isGenerating = false);

    if (bio != null && bio.isNotEmpty) {
      setState(() {
        _controller.text = bio;
        _errorText = _validate(bio);
      });
      widget.onChanged(bio);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final maxLen = widget.field.validation?.maxLength;

    return DynamicFieldContainer(
      labelText: widget.field.label,
      isRequired: widget.field.isRequired,
      errorText: _errorText,
      headerTrailing: widget.field.hasAiGenerate
          ? InkWell(
              onTap: _isGenerating ? null : _handleGenerateAI,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.primaryColor, theme.colorScheme.secondary],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isGenerating)
                      const SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      _isGenerating ? 'Generating...' : 'AI ✨',
                      style: AppFont.font(
                        context: context,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            minLines: 3,
            maxLines: widget.field.maxLines > 1 ? widget.field.maxLines : 5,
            inputFormatters: maxLen != null
                ? [LengthLimitingTextInputFormatter(maxLen)]
                : null,
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
              return err != null ? '' : null;
            },
            style: AppFont.font(
              context: context,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF16182F),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              hintText: widget.field.placeholder.isNotEmpty
                  ? widget.field.placeholder
                  : 'Write a few lines about yourself...',
              hintStyle: AppFont.font(
                context: context,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8A90A6).withValues(alpha: 0.6),
              ),
            ),
          ),
          if (maxLen != null)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, _) {
                    return Text(
                      '${value.text.length}/$maxLen',
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
