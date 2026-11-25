import 'package:flutter/material.dart';
import 'package:pro_matrimony/widgets/app_common_background.dart';

export 'package:pro_matrimony/widgets/app_common_background.dart';

/// Legacy alias for AppCommonBackground
class GlassmorphicBackground extends StatelessWidget {
  final Widget child;
  const GlassmorphicBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppCommonBackground(child: child);
  }
}

/// Legacy alias for AppCommonPageTransitionsBuilder
class GlassmorphicPageTransitionsBuilder extends AppCommonPageTransitionsBuilder {
  const GlassmorphicPageTransitionsBuilder({required super.platformBuilder});
}
