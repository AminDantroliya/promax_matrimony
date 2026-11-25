import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/utils/utils.dart';

import '../app_theme/size_config.dart';

class AppPrimaryButton extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final bool isLoading;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    
    final double borderRadius = config.buttonRadius;

    return Container(
      width: width ?? SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: FigmaColors.primaryGradient(context),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledForegroundColor: const Color(0x61000000),
          disabledBackgroundColor: const Color(0x1F000000),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : customTextSemiBoldStyle(
                label,
                getProportionateScreenWidth(15),
                TextAlign.center,
                Colors.white,
              ),
      ),
    );
  }
}

class AppSecondaryButton extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;

  const AppSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final config = ref.watch(appConfigProvider);

    final double borderRadius = config.buttonRadius;

    return Container(
      width: width ?? SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: theme.colorScheme.onSurface,
          side: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            width: 1.5,
          ),
          disabledForegroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: customTextSemiBoldStyle(
          label,
          getProportionateScreenWidth(15),
          TextAlign.center,
          theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
