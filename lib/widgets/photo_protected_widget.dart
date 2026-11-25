import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_svg/svg.dart';

import '../app_theme/size_config.dart';
import '../utils/app_assets.dart';

/// A unified widget for displaying a protected/blurred overlay on images.
class ProtectedImageOverlay extends StatelessWidget {
  final double? width;
  final double? height;
  final double blur;
  final double borderRadius;
  final double lockSize;
  final Alignment lockAlignment;
  final EdgeInsets? lockPadding;

  const ProtectedImageOverlay({
    super.key,
    this.width,
    this.height,
    this.blur = 15,
    this.borderRadius = 10,
    this.lockSize = 60,
    this.lockAlignment = Alignment.center,
    this.lockPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: lockAlignment,
      children: [
        if (blur > 0)
          BlurryContainer(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            blur: blur,
            elevation: 1,
            color: Colors.black.withValues(alpha: 0.35),
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(getProportionateScreenWidth(borderRadius)),
            child: const SizedBox.expand(),
          ),
        Padding(
          padding: lockPadding ?? EdgeInsets.zero,
          child: Container(
            height: getProportionateScreenWidth(lockSize),
            width: getProportionateScreenWidth(lockSize),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(lockSize * 0.16)),
              child: SvgPicture.asset(AppAssets.icProtectedLock),
            ),
          ),
        ),
      ],
    );
  }
}

// Backward compatibility wrappers
Widget protectedWidget() => const ProtectedImageOverlay(borderRadius: 0);
Widget protectedWidget2() => const ProtectedImageOverlay(height: 450);
Widget protectedPhotoReceive() => ProtectedImageOverlay(width: SizeConfig.screenWidth! - 170, height: 260);
Widget protectedPhotoSent() => ProtectedImageOverlay(width: SizeConfig.screenWidth! / 2.4, height: 160);
Widget protectedSmallWidget() => const ProtectedImageOverlay(width: 70, height: 90, blur: 5, lockSize: 35);
Widget protectedMidWidget() => const ProtectedImageOverlay(width: 110, height: 140, blur: 10, lockSize: 35);
Widget protectedDashboardWidget() => const ProtectedImageOverlay(height: 160, blur: 10, lockSize: 35);
Widget protectedDashboardWidget2() => ProtectedImageOverlay(width: SizeConfig.screenWidth! / 2.4, height: 160, blur: 10, lockSize: 35);
Widget protectedGridviewWidget() => ProtectedImageOverlay(width: SizeConfig.screenWidth! / 2.4, height: 165, blur: 10, lockSize: 35);
Widget protectedCallHistoryWidget() => const ProtectedImageOverlay(height: 50, blur: 5, lockSize: 20, borderRadius: 50);
Widget protectedChatWidget() => const ProtectedImageOverlay(height: 55, blur: 5, lockSize: 20, borderRadius: 50);
Widget protectedDashboardDesignWidget() => const ProtectedImageOverlay(lockAlignment: Alignment.topCenter, lockPadding: EdgeInsets.only(top: 50));
