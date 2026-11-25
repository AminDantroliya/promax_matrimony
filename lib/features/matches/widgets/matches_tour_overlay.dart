import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

class MatchesTourOverlay extends StatefulWidget {
  final VoidCallback onDismiss;
  final String? imageUrl;
  final double bottom;

  const MatchesTourOverlay({
    super.key,
    required this.onDismiss,
    this.imageUrl,
    this.bottom = 24.0,
  });

  @override
  State<MatchesTourOverlay> createState() => _MatchesTourOverlayState();
}

class _MatchesTourOverlayState extends State<MatchesTourOverlay> {
  int _step =
      0; // 0: Welcome Tour, 1: Swipe Left (PASS), 2: Swipe Right (SHORTLIST)

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      right: 15,
      top: 0,
      bottom: widget.bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                ? DecorationImage(
                    image: NetworkImage(widget.imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black.withValues(alpha: 0.70),
                  Colors.black.withValues(alpha: 0.95),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: _buildTourContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildTourContent() {
    switch (_step) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildPassStep();
      case 2:
        return _buildShortlistStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildWelcomeStep() {
    return Stack(
      children: [
        // Top Tour Pills
        Positioned(
          top: 24,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.replay, color: Colors.white, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.videocam, color: Colors.amber, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'tour_caps'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Welcome Text & Action Buttons (Center - Bottom)
        Positioned(
          bottom: 40,
          left: 24,
          right: 24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'matches_tour_welcome_title'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
              const Gap(12),
              Text(
                'matches_tour_welcome_desc'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const Gap(32),

              // Show Me Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _step = 1;
                  });
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF07E48), Color(0xFFF65B5B)],
                    ),
                    borderRadius: BorderRadius.circular(27),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF56854).withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'show_me'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(16),

              // Skip Button
              TextButton(
                onPressed: widget.onDismiss,
                child: Text(
                  'no_thanks_explore'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPassStep() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _step = 2;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // PASS Stamp
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 4),
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withValues(alpha: 0.1),
            ),
            child: Text(
              'pass_caps'.tr,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),

          // Gesture Hand indicator
          Positioned(
            bottom: 120,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.red,
                  size: 24,
                ),
                const Gap(8),
                const Icon(Icons.circle, color: Colors.red, size: 10),
                const Icon(Icons.circle, color: Colors.red, size: 10),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.swipe_left,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Description
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'swipe_left_to'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'not_interested_move_on'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortlistStep() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onDismiss,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SHORTLIST Stamp
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 4),
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withValues(alpha: 0.1),
            ),
            child: Text(
              'shortlist_caps'.tr,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),

          // Gesture Hand indicator
          Positioned(
            bottom: 120,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.swipe_right,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
                const Gap(12),
                const Icon(Icons.circle, color: Colors.green, size: 10),
                const Icon(Icons.circle, color: Colors.green, size: 10),
                const Gap(8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green,
                  size: 24,
                ),
              ],
            ),
          ),

          // Bottom Description
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'swipe_right_to_shortlist'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, color: Colors.green, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'if_they_like_you_back_match'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
