import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:pro_matrimony/utils/utils.dart';

/// Selfie camera screen that detects faces in "live" mode.
///
/// Strategy: Rather than streaming raw camera bytes (which has YUV format /
/// rotation issues across devices), we take a silent JPEG snapshot every
/// 600 ms and run ML Kit on the file path — `InputImage.fromFilePath` always
/// works correctly because Android embeds the correct EXIF orientation in the
/// JPEG. This gives a live detection feel with zero byte-format complexity.
class SelfieCameraScreen extends StatefulWidget {
  const SelfieCameraScreen({super.key});

  @override
  State<SelfieCameraScreen> createState() => _SelfieCameraScreenState();
}

class _SelfieCameraScreenState extends State<SelfieCameraScreen>
    with TickerProviderStateMixin {
  // ── Camera ────────────────────────────────────────────────────────────────
  CameraController? _cameraController;
  bool _isCameraReady = false;

  // ── Face detection ────────────────────────────────────────────────────────
  late FaceDetector _faceDetector;
  Timer? _detectionTimer;
  bool _isProcessing = false;
  bool _faceDetected = false;

  // ── Capture ───────────────────────────────────────────────────────────────
  bool _isCapturing = false;

  // ── Animation ─────────────────────────────────────────────────────────────
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // ── Colors ────────────────────────────────────────────────────────────────
  static const _green = Color(0xFF22C55E);
  static const _red = Color(0xFFEF5350);

  // ─────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        // Require face to be at least 25% of the shorter image dimension.
        // This rejects small background faces or partial chin/forehead slivers.
        minFaceSize: 0.95,
        enableClassification: true,
        enableLandmarks: true,
        enableContours: true,
      ),
    );

    _initCamera();
  }

  // ── Camera init ───────────────────────────────────────────────────────────

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final front = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() => _isCameraReady = true);

      // Begin periodic face detection
      _startDetectionTimer();
    } catch (e) {
      debugPrint('[Selfie] Camera init error: $e');
    }
  }

  // ── Periodic detection ────────────────────────────────────────────────────

  void _startDetectionTimer() {
    _detectionTimer?.cancel();
    _detectionTimer = Timer.periodic(
      const Duration(milliseconds: 600),
      (_) => _detectFaceFromSnapshot(),
    );
  }

  Future<void> _detectFaceFromSnapshot() async {
    if (_isProcessing ||
        _isCapturing ||
        !_isCameraReady ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    _isProcessing = true;
    String? tempPath;

    try {
      // Silent JPEG capture — InputImage.fromFilePath handles EXIF orientation
      final xFile = await _cameraController!.takePicture();
      tempPath = xFile.path;

      // ── Decode image dimensions from JPEG ──────────────────────────────
      final bytes = await File(tempPath).readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final imgW = frame.image.width.toDouble();
      final imgH = frame.image.height.toDouble();
      frame.image.dispose();

      // ── Run ML Kit face detection ──────────────────────────────────────
      final inputImage = InputImage.fromFilePath(tempPath);
      final faces = await _faceDetector.processImage(inputImage);

      // ── Validate: face must be 100% inside oval zone ───
      //
      // The oval in the UI sits at:
      //   center  ≈ (50 %, 43 %) of screen
      //   width   ≈ 72 % of screen width
      //   height  ≈ 44 % of screen height
      //
      // We mirror these proportions onto the captured image dimensions.
      // Oval centre / radii in relative coords:
      //   ocx = 0.50, ocy = 0.43
      //   orx = 0.36 (half-width), ory = 0.22 (half-height)
      //
      // A face is 100% inside the oval zone when:
      //  1. All 4 corners of the face bounding box are inside the ellipse.
      //  2. Face is of a reasonable size (at least 20% of image width).

      bool detected = false;
      for (final face in faces) {
        final box = face.boundingBox;

        // Relative coordinates of the face bounding box boundaries (0 to 1)
        final left = box.left / imgW;
        final right = box.right / imgW;
        final top = box.top / imgH;
        final bottom = box.bottom / imgH;

        final fw = (right - left); // face width ratio

        // Oval definition
        const ocx = 0.50;
        const ocy = 0.43;
        const orx = 0.36; // radius X
        const ory = 0.22; // radius Y

        // Helper to test if a point (x, y) is inside the oval ellipse
        bool isPointInside(double px, double py) {
          final dx = (px - ocx) / orx;
          final dy = (py - ocy) / ory;
          return (dx * dx + dy * dy) <= 1.0;
        }

        // Test all four corners of the face bounding box
        final topLeftInside = isPointInside(left, top);
        final topRightInside = isPointInside(right, top);
        final bottomLeftInside = isPointInside(left, bottom);
        final bottomRightInside = isPointInside(right, bottom);

        // Face must be fully within the oval and have a reasonable size
        final fullyInsideOval =
            topLeftInside &&
            topRightInside &&
            bottomLeftInside &&
            bottomRightInside;

        final isFullFace = fw >= 0.20;

        if (fullyInsideOval && isFullFace) {
          detected = true;
          break;
        }
      }

      if (mounted && detected != _faceDetected) {
        setState(() => _faceDetected = detected);
      }
    } catch (e) {
      debugPrint('[Selfie] Detection snapshot error: $e');
    } finally {
      // Always delete the temp snapshot to free storage
      if (tempPath != null) {
        try {
          File(tempPath).deleteSync();
        } catch (_) {}
      }
      _isProcessing = false;
    }
  }

  // ── Final capture ─────────────────────────────────────────────────────────

  Future<void> _captureSelfie() async {
    if (_isCapturing || !_faceDetected || !_isCameraReady) return;

    _detectionTimer?.cancel();
    setState(() => _isCapturing = true);

    try {
      final xFile = await _cameraController!.takePicture();
      if (mounted) Navigator.pop(context, xFile.path);
    } catch (e) {
      debugPrint('[Selfie] Final capture error: $e');
      if (mounted) {
        setState(() => _isCapturing = false);
        _startDetectionTimer();
      }
    }
  }

  // ── Dispose ───────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _detectionTimer?.cancel();
    _pulseController.dispose();
    _cameraController?.dispose();
    _faceDetector.close();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final borderColor = _faceDetected ? _green : _red;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Live camera preview ──────────────────────────────────────
            if (_isCameraReady && _cameraController != null)
              Positioned.fill(child: CameraPreview(_cameraController!))
            else
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const Gap(16),
                    Text(
                      'starting_camera'.tr,
                      style: const TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
              ),

            // ── Oval mask + animated border ──────────────────────────────
            if (_isCameraReady)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, _) => CustomPaint(
                      painter: _OvalPainter(
                        borderColor: borderColor,
                        pulseScale: _faceDetected ? _pulseAnimation.value : 1.0,
                        isCapturing: _isCapturing,
                      ),
                    ),
                  ),
                ),
              ),

            // ── Back button ──────────────────────────────────────────────
            Positioned(
              top: 12,
              left: 12,
              child: _CircleButton(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),

            // ── Status badge ─────────────────────────────────────────────
            Positioned(
              top: 72,
              left: 24,
              right: 24,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: _StatusBadge(
                  key: ValueKey(_faceDetected),
                  faceDetected: _faceDetected,
                  isCapturing: _isCapturing,
                ),
              ),
            ),

            // ── Scanning pulse indicator (top-right) ─────────────────────
            Positioned(
              top: 12,
              right: 12,
              child: _ScanningDot(scanning: !_isCapturing && _isCameraReady),
            ),

            // ── Tip row ──────────────────────────────────────────────────
            Positioned(
              bottom: 148,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Tip(icon: Icons.wb_sunny_outlined, label: 'good_light'.tr),
                  const Gap(28),
                  _Tip(icon: Icons.face, label: 'face_forward'.tr),
                  const Gap(28),
                  _Tip(icon: Icons.center_focus_strong, label: 'stay_centred'.tr),
                ],
              ),
            ),

            // ── Capture button ───────────────────────────────────────────
            Positioned(
              bottom: 44,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (_faceDetected && !_isCapturing)
                        ? _captureSelfie
                        : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 76,
                      width: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_faceDetected && !_isCapturing)
                            ? Colors.white
                            : Colors.white24,
                        border: Border.all(
                          color: _faceDetected ? _green : Theme.of(context).primaryColor,
                          width: 4,
                        ),
                        boxShadow: (_faceDetected && !_isCapturing)
                            ? [
                                BoxShadow(
                                  color: _green.withValues(alpha: 0.5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                      child: _isCapturing
                          ? const Padding(
                              padding: EdgeInsets.all(18),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: _green,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: _faceDetected ? _green : Colors.white38,
                            ),
                    ),
                  ),
                  const Gap(12),
                  Text(
                    _isCapturing
                        ? 'capturing'.tr
                        : _faceDetected
                        ? 'tap_to_capture'.tr
                        : 'align_face_to_capture'.tr,
                    style: AppFont.font(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _faceDetected ? Colors.white : Colors.white54,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Oval painter
// ════════════════════════════════════════════════════════════════════════════

class _OvalPainter extends CustomPainter {
  final Color borderColor;
  final double pulseScale;
  final bool isCapturing;

  _OvalPainter({
    required this.borderColor,
    required this.pulseScale,
    required this.isCapturing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.43),
      width: size.width * 0.72 * pulseScale,
      height: size.height * 0.44 * pulseScale,
    );

    // Dark mask outside oval
    final maskPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    final maskPath = Path()
      ..addRect(Offset.zero & size)
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(maskPath, maskPaint);

    // Oval border
    canvas.drawOval(
      ovalRect,
      Paint()
        ..color = borderColor
        ..strokeWidth = 3.5
        ..style = PaintingStyle.stroke,
    );

    // Corner accent arcs
    final accent = Paint()
      ..color = borderColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final r = 32.0;
    final arcRects = [
      Rect.fromCenter(
        center: Offset(ovalRect.left + r / 2, ovalRect.top + r / 2),
        width: r,
        height: r,
      ),
      Rect.fromCenter(
        center: Offset(ovalRect.right - r / 2, ovalRect.top + r / 2),
        width: r,
        height: r,
      ),
      Rect.fromCenter(
        center: Offset(ovalRect.left + r / 2, ovalRect.bottom - r / 2),
        width: r,
        height: r,
      ),
      Rect.fromCenter(
        center: Offset(ovalRect.right - r / 2, ovalRect.bottom - r / 2),
        width: r,
        height: r,
      ),
    ];
    const startAngles = [3.14159, 4.71239, 1.5708, 0.0];
    for (int i = 0; i < arcRects.length; i++) {
      canvas.drawArc(arcRects[i], startAngles[i], 0.85, false, accent);
    }
  }

  @override
  bool shouldRepaint(covariant _OvalPainter old) =>
      old.borderColor != borderColor ||
      old.pulseScale != pulseScale ||
      old.isCapturing != isCapturing;
}

// ════════════════════════════════════════════════════════════════════════════
// Small reusable widgets
// ════════════════════════════════════════════════════════════════════════════

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const _CircleButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(10), child: child),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool faceDetected;
  final bool isCapturing;
  const _StatusBadge({
    super.key,
    required this.faceDetected,
    required this.isCapturing,
  });

  @override
  Widget build(BuildContext context) {
    final bg = faceDetected
        ? Colors.green.shade800.withValues(alpha: 0.88)
        : Colors.black.withValues(alpha: 0.6);
    final border = faceDetected ? const Color(0xFF4CAF50) : Colors.white12;
    final icon = faceDetected
        ? Icons.check_circle_outline
        : Icons.face_outlined;
    final text = isCapturing
        ? 'capturing'.tr
        : faceDetected
        ? 'face_detected_tap_capture'.tr
        : 'position_face_inside_oval'.tr;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const Gap(8),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppFont.font(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanningDot extends StatefulWidget {
  final bool scanning;
  const _ScanningDot({required this.scanning});

  @override
  State<_ScanningDot> createState() => _ScanningDotState();
}

class _ScanningDotState extends State<_ScanningDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.scanning) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent.withValues(alpha: _anim.value),
              ),
            ),
            const Gap(6),
            Text(
              'scanning_caps'.tr,
              style: AppFont.font(
                fontSize: 9,
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Tip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white54, size: 18),
        const Gap(4),
        Text(
          label,
          style: AppFont.font(
            fontSize: 10,
            color: Colors.white54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
