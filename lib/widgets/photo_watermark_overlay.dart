import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';

/// An elegant anti-tamper watermark overlay that renders when
/// `enableWatermarkPhotos` is enabled in Admin Settings.
/// Uses a CustomPainter to guarantee zero layout overflow on any screen size.
class PhotoWatermarkOverlay extends ConsumerWidget {
  final bool isFullScreen;

  const PhotoWatermarkOverlay({
    super.key,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(featureProvider('enableWatermarkPhotos'));
    if (!enabled) return const SizedBox.shrink();

    final appName = ref.watch(appConfigProvider).appName;
    final text = appName.trim().isNotEmpty
        ? appName.trim().toUpperCase()
        : 'PRO MATRIMONY';

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Repeating diagonal watermark pattern painted via Canvas (never overflows)
            Positioned.fill(
              child: CustomPaint(
                painter: _WatermarkPainter(
                  text: text,
                  isFullScreen: isFullScreen,
                ),
              ),
            ),

            // 2. Prominent center frosted security badge
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Transform.rotate(
                    angle: -0.22,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isFullScreen ? 20 : 12,
                        vertical: isFullScreen ? 8 : 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.38),
                        borderRadius: BorderRadius.circular(isFullScreen ? 12 : 8),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.50),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.30),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_user_rounded,
                            color: Colors.white.withValues(alpha: 0.90),
                            size: isFullScreen ? 20 : 14,
                          ),
                          SizedBox(width: isFullScreen ? 8 : 4),
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: isFullScreen ? 16 : 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: isFullScreen ? 2.5 : 1.2,
                              color: Colors.white.withValues(alpha: 0.95),
                              shadows: const [
                                Shadow(
                                  color: Colors.black87,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WatermarkPainter extends CustomPainter {
  final String text;
  final bool isFullScreen;

  _WatermarkPainter({
    required this.text,
    required this.isFullScreen,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final textStyle = TextStyle(
      fontSize: isFullScreen ? 14 : 10,
      fontWeight: FontWeight.w900,
      letterSpacing: isFullScreen ? 2.5 : 1.5,
      color: Colors.white.withValues(alpha: isFullScreen ? 0.22 : 0.16),
      shadows: const [
        Shadow(
          color: Colors.black54,
          blurRadius: 3,
          offset: Offset(1, 1),
        ),
      ],
    );

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    final stepX = textWidth + (isFullScreen ? 50.0 : 30.0);
    final stepY = textHeight + (isFullScreen ? 60.0 : 35.0);

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-0.35);
    canvas.translate(-size.width / 2, -size.height / 2);

    final maxDim = math.sqrt(size.width * size.width + size.height * size.height);
    final startX = (size.width - maxDim) / 2 - stepX;
    final endX = (size.width + maxDim) / 2 + stepX;
    final startY = (size.height - maxDim) / 2 - stepY;
    final endY = (size.height + maxDim) / 2 + stepY;

    for (double y = startY; y < endY; y += stepY) {
      for (double x = startX; x < endX; x += stepX) {
        textPainter.paint(canvas, Offset(x, y));
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WatermarkPainter oldDelegate) {
    return oldDelegate.text != text || oldDelegate.isFullScreen != isFullScreen;
  }
}
