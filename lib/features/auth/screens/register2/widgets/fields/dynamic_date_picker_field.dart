import 'package:flutter/material.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:intl/intl.dart';
import '../../models/dynamic_form_models.dart';
import 'dynamic_field_container.dart';

class DynamicDatePickerField extends StatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final Map<String, dynamic> allFormValues;

  const DynamicDatePickerField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
    this.allFormValues = const {},
  });

  @override
  State<DynamicDatePickerField> createState() => _DynamicDatePickerFieldState();
}

class _DynamicDatePickerFieldState extends State<DynamicDatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _parseInitial();
  }

  void _parseInitial() {
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      try {
        _selectedDate = DateTime.tryParse(widget.initialValue!) ??
            DateFormat('yyyy-MM-dd').tryParse(widget.initialValue!);
      } catch (_) {}
    }
  }

  @override
  void didUpdateWidget(covariant DynamicDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _parseInitial();
    }
  }

  Future<void> _selectDate(BuildContext context, FormFieldState<String> state) async {
    final now = DateTime.now();
    final gender = widget.allFormValues['gender']?.toString().toLowerCase() ?? 'male';
    final isMale = gender == 'male';

    final minAgeMale = widget.field.validation?.minAgeMale ?? 21;
    final minAgeFemale = widget.field.validation?.minAgeFemale ?? 18;
    final minAgeYears = isMale ? minAgeMale : minAgeFemale;

    final maxDate = DateTime(now.year - minAgeYears, now.month, now.day);
    final initialDate = _selectedDate ?? maxDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(maxDate) ? maxDate : initialDate,
      firstDate: DateTime(1940),
      lastDate: maxDate,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      state.didChange(formatted);
      widget.onChanged(formatted);
    }
  }

  String? _validate(String? val) {
    if (widget.field.isRequired && (val == null || val.trim().isEmpty)) {
      return widget.field.validation?.errorMessage ??
          'Please select ${widget.field.label.toLowerCase()}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final formattedInitial = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : (widget.initialValue ?? '');

    return FormField<String>(
      initialValue: formattedInitial,
      validator: _validate,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (FormFieldState<String> state) {
        final displayText = _selectedDate != null
            ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
            : (state.value?.isNotEmpty == true ? state.value! : '');

        return DynamicFieldContainer(
          labelText: widget.field.label,
          isRequired: widget.field.isRequired,
          errorText: state.errorText,
          onTap: () => _selectDate(context, state),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayText.isNotEmpty
                      ? displayText
                      : (widget.field.placeholder.isNotEmpty
                          ? widget.field.placeholder
                          : 'DD-MM-YYYY'),
                  style: displayText.isNotEmpty
                      ? AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF16182F),
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
