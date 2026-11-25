import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';
import '../../models/dynamic_form_models.dart';

class DynamicRangeSliderField extends ConsumerStatefulWidget {
  final FormFieldModel field;
  final RangeValues? initialValue;
  final ValueChanged<RangeValues> onChanged;

  const DynamicRangeSliderField({
    super.key,
    required this.field,
    this.initialValue,
    required this.onChanged,
  });

  @override
  ConsumerState<DynamicRangeSliderField> createState() =>
      _DynamicRangeSliderFieldState();
}

class _DynamicRangeSliderFieldState
    extends ConsumerState<DynamicRangeSliderField> {
  late RangeValues _range;
  late double _min;
  late double _max;

  @override
  void initState() {
    super.initState();
    _min = widget.field.minVal ??
        (widget.field.name.contains('height') ? 48.0 : 18.0);
    _max = (widget.field.maxVal != null && widget.field.maxVal! > _min)
        ? widget.field.maxVal!
        : (widget.field.name.contains('height') ? 84.0 : 60.0);

    if (widget.initialValue != null) {
      final s = widget.initialValue!.start.clamp(_min, _max);
      final e = widget.initialValue!.end.clamp(_min, _max);
      _range = RangeValues(s <= e ? s : _min, s <= e ? e : _max);
    } else if (widget.field.defaultRange != null &&
        widget.field.defaultRange!.length >= 2) {
      final s = widget.field.defaultRange![0].clamp(_min, _max);
      final e = widget.field.defaultRange![1].clamp(_min, _max);
      _range = RangeValues(s <= e ? s : _min, s <= e ? e : _max);
    } else {
      _range = RangeValues(_min, _max);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.initialValue == null) {
        widget.onChanged(_range);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DynamicRangeSliderField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null && widget.initialValue != _range) {
      final s = widget.initialValue!.start.clamp(_min, _max);
      final e = widget.initialValue!.end.clamp(_min, _max);
      setState(() {
        _range = RangeValues(s <= e ? s : _min, s <= e ? e : _max);
      });
    }
  }

  String _formatRangeLabel(RangeValues range) {
    if (widget.field.name.contains('height')) {
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
    final config = ref.watch(appConfigProvider);
    final isUnderlined =
        AppInputFieldStyle.resolveDesign(config) == 'underlined';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
                  _formatRangeLabel(_range),
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
                values: _range,
                min: _min,
                max: _max,
                divisions: (_max - _min).round().clamp(1, 500),
                onChanged: (newRange) {
                  setState(() => _range = newRange);
                  widget.onChanged(newRange);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
