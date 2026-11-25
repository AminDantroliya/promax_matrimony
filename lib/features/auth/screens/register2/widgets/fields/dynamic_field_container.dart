import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';

class DynamicFieldContainer extends ConsumerWidget {
  final String labelText;
  final Widget child;
  final Widget? trailing;
  final Widget? headerTrailing;
  final VoidCallback? onTap;
  final String? errorText;
  final bool isRequired;
  final bool suppressUnderline;

  const DynamicFieldContainer({
    super.key,
    required this.labelText,
    required this.child,
    this.trailing,
    this.headerTrailing,
    this.onTap,
    this.errorText,
    this.isRequired = false,
    this.suppressUnderline = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasError = errorText != null && errorText!.isNotEmpty;
    final config = ref.watch(appConfigProvider);

    return Padding(
      padding: EdgeInsets.only(bottom: hasError ? 8 : 16),
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
                hasError: hasError,
                suppressUnderline: suppressUnderline,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      context: context,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                              ],
                            ),
                            ?headerTrailing,
                          ],
                        ),
                        const SizedBox(height: 6),
                        child,
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 8),
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
                  context: context,
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
