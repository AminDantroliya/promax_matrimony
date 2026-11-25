import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

class AppTextField extends ConsumerStatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String? iconImg;
  final Color? iconBackColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hint;
  final int? maxLine;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final EdgeInsets? scrollPadding;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.readOnly,
    this.iconImg,
    this.iconBackColor = Colors.transparent,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.maxLine = 1,
    this.maxLength = 1000,
    this.onTap,
    this.scrollPadding,
  });

  @override
  ConsumerState<AppTextField> createState() =>
      _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends ConsumerState<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  TextEditingController? _localController;
  FormFieldState<String>? _fieldState;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_localController ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _effectiveController.addListener(_onControllerChange);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerChange);
      _effectiveController.addListener(_onControllerChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _effectiveController.removeListener(_onControllerChange);
    _localController?.dispose();
    super.dispose();
  }

  void _onControllerChange() {
    if (_fieldState != null && _fieldState!.value != _effectiveController.text) {
      _fieldState!.didChange(_effectiveController.text);
    }
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
    final config = ref.watch(appConfigProvider);
    final hint = widget.hint ?? widget.labelText.replaceAll('*', '').trim();

    return FormField<String>(
      validator: (val) => widget.validator?.call(_effectiveController.text),
      initialValue: _effectiveController.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<String> state) {
        _fieldState = state;
        if (state.value != _effectiveController.text) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && state.value != _effectiveController.text) {
              state.didChange(_effectiveController.text);
            }
          });
        }
        // Build custom text field matching Search Screen Figma fields (without prefix icon)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: AppInputFieldStyle.buildContainerDecoration(
                context: context,
                config: config,
                isFocused: _isFocused,
                hasError: state.hasError,
              ),
              child: Padding(
                padding: AppInputFieldStyle.getContainerPadding(
                  config,
                  defaultPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
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
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                    const Gap(2),
                    TextField(
                      focusNode: _focusNode,
                      controller: _effectiveController,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.obscureText,
                      onChanged: (val) {
                        state.didChange(val);
                        if (widget.onChanged != null) {
                          widget.onChanged!(val);
                        }
                      },
                      onTap: widget.onTap,
                      readOnly: widget.readOnly ?? false,
                      maxLines: widget.maxLine,
                      maxLength: widget.maxLength,
                      inputFormatters: widget.inputFormatters,
                      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
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
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        isDense: true,
                        counterText: '',
                        suffixIcon: widget.suffixIcon != null
                            ? IconTheme(
                                data: IconThemeData(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                                  size: 20,
                                ),
                                child: widget.suffixIcon!,
                              )
                            : null,
                      ),
                    ),
                  ],
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
