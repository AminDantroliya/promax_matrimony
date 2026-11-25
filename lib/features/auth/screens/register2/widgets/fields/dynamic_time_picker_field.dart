import 'package:flutter/material.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import '../../models/dynamic_form_models.dart';
import 'dynamic_field_container.dart';

class DynamicTimePickerField extends StatefulWidget {
  final FormFieldModel field;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const DynamicTimePickerField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<DynamicTimePickerField> createState() => _DynamicTimePickerFieldState();
}

class _DynamicTimePickerFieldState extends State<DynamicTimePickerField> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _parseInitial();
  }

  void _parseInitial() {
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      final parts = widget.initialValue!.split(':');
      if (parts.length >= 2) {
        final h = int.tryParse(parts[0]) ?? 0;
        final m = int.tryParse(parts[1]) ?? 0;
        _selectedTime = TimeOfDay(hour: h, minute: m);
      }
    }
  }

  @override
  void didUpdateWidget(covariant DynamicTimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _parseInitial();
    }
  }

  Future<void> _selectTime(BuildContext context, FormFieldState<String> state) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
      final formatted =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
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

    return FormField<String>(
      initialValue: widget.initialValue ?? '',
      validator: _validate,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (FormFieldState<String> state) {
        final displayStr = _selectedTime != null
            ? _selectedTime!.format(context)
            : (state.value?.isNotEmpty == true ? state.value! : '');

        return DynamicFieldContainer(
          labelText: widget.field.label,
          isRequired: widget.field.isRequired,
          errorText: state.errorText,
          onTap: () => _selectTime(context, state),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayStr.isNotEmpty
                      ? displayStr
                      : (widget.field.placeholder.isNotEmpty
                          ? widget.field.placeholder
                          : 'Select time (HH:MM)'),
                  style: displayStr.isNotEmpty
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
                Icons.access_time_rounded,
                color: Color(0xFF8A90A6),
                size: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
