import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../widgets/image_widget.dart';
import '../../../utils/utils.dart';
import '../../profile/providers/other_profile_notifier.dart';
import '../providers/zego_notifier.dart';

/// Foreground overlay rendered on top of Zego's call screen.
///
/// VIDEO calls → thin gradient header with profile name + timer position,
///               NO duplicate action buttons (Zego provides those natively).
/// VOICE calls → full blurred-bg overlay with big avatar, name, subtitle.
///
/// Both modes force immersive full-screen (status bar hidden) on entry and
/// restore it on exit.
class CallForegroundOverlay extends ConsumerStatefulWidget {
  final bool isVideoCall;
  final String otherUserId;
  final String fallbackName;

  const CallForegroundOverlay({
    super.key,
    required this.isVideoCall,
    required this.otherUserId,
    required this.fallbackName,
  });

  @override
  ConsumerState<CallForegroundOverlay> createState() => _CallForegroundOverlayState();
}

class _CallForegroundOverlayState extends ConsumerState<CallForegroundOverlay> {
  late final ZegoNotifier _zegoNotifier;

  @override
  void initState() {
    super.initState();
    _zegoNotifier = ref.read(zegoProvider.notifier);
    // Hide status bar + nav bar for true full-screen call experience.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    // Guaranteed fallback: sync call history on disconnect when overlay widget unmounts
    _zegoNotifier.syncCallHistoryOnDisconnect();
    // Restore system UI when call screen is gone.
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    });

    Widget overlayChild;
    if (widget.otherUserId.isEmpty) {
      overlayChild = _buildOverlay(context, displayName: widget.fallbackName, photoUrl: '', subtitle: '');
    } else {
      final profileAsync = ref.watch(otherProfileProvider(widget.otherUserId));
      overlayChild = profileAsync.when(
        data: (profileModel) {
          final profile = profileModel.data;
          final String photoUrl = profile?.profileImage ?? '';
          final String matriId = (profile?.matriId != null &&
                  profile!.matriId.toString().isNotEmpty &&
                  profile.matriId.toString() != "null")
              ? profile.matriId.toString()
              : widget.fallbackName;
          final String displayName = matriId;
          final int age = profile?.age != null ? int.tryParse(profile!.age.toString()) ?? 0 : 0;
          final String city = profile?.cityName ?? '';
          final String subtitle = [
            if (age > 0) '$age ${'yrs'.tr}',
            if (city.isNotEmpty) city,
          ].join(' · ');
          return _buildOverlay(context, displayName: displayName, photoUrl: photoUrl, subtitle: subtitle);
        },
        loading: () => _buildOverlay(context, displayName: widget.fallbackName, photoUrl: '', subtitle: '', isLoading: true),
        error: (error, stack) => _buildOverlay(context, displayName: widget.fallbackName, photoUrl: '', subtitle: ''),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: overlayChild,
    );
  }

  Widget _buildOverlay(
    BuildContext context, {
    required String displayName,
    required String photoUrl,
    required String subtitle,
    bool isLoading = false,
  }) {
    return widget.isVideoCall
        ? _VideoCallOverlay(
            displayName: displayName,
            photoUrl: photoUrl,
            subtitle: subtitle,
          )
        : _VoiceCallOverlay(
            displayName: displayName,
            photoUrl: photoUrl,
            subtitle: subtitle,
          );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// VIDEO CALL OVERLAY
// A slim gradient top-bar showing the remote user's name + photo.
// No buttons – Zego's bottomMenuBar handles all controls.
// ═══════════════════════════════════════════════════════════════════════════

class _VideoCallOverlay extends StatelessWidget {
  final String displayName;
  final String photoUrl;
  final String subtitle;

  const _VideoCallOverlay({
    required this.displayName,
    required this.photoUrl,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Top gradient scrim so text is readable over live video
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 180,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.75),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Bottom gradient scrim so controls are readable
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.80),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Top bar: Minimize button (left) + Contact info (center) + Switch Camera button (right)
        // Matches invitation screen top bar layout 100%
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ── Top Left: Minimize button ─────────────────────────────
                  GestureDetector(
                    onTap: () {
                      try {
                        ZegoUIKitPrebuiltCallController().minimize.minimize(context);
                      } catch (e) {
                        debugPrint("Minimize error: $e");
                      }
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fullscreen_exit_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  // ── Top Center: Name chip + Subtitle ──────────────────────
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            displayName,
                            style: AppFont.font(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(4),
                          const CallTimerWidget(),
                          if (subtitle.isNotEmpty) ...[
                            const Gap(4),
                            Text(
                              subtitle,
                              style: AppFont.font(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // ── Top Right: Switch Camera button ───────────────────────
                  ValueListenableBuilder<bool>(
                    valueListenable: ZegoUIKit()
                        .getUseFrontFacingCameraStateNotifier(
                          ZegoUIKit().getLocalUser().id,
                        ),
                    builder: (context, isFront, _) {
                      return GestureDetector(
                        onTap: () => ZegoUIKit().useFrontFacingCamera(!isFront),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cameraswitch_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Single-row bottom capsule pill (matches invitation calling screen) ──
        const _CallBottomCapsulePill(isVideoCall: true),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// VOICE CALL OVERLAY
// Full blurred background with large avatar + name + subtitle.
// Zego's native bars handle mic/speaker/hang-up.
// ═══════════════════════════════════════════════════════════════════════════

class _VoiceCallOverlay extends StatelessWidget {
  final String photoUrl;
  final String displayName;
  final String subtitle;

  const _VoiceCallOverlay({
    required this.photoUrl,
    required this.displayName,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Blurred background ─────────────────────────────────────────────
        Positioned.fill(
          child: photoUrl.isNotEmpty
              ? getImageWidget(url: photoUrl, boxFit: BoxFit.cover)
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
                    ),
                  ),
                ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: Container(color: Colors.black.withValues(alpha: 0.52)),
          ),
        ),

        // ── Decorative glowing circles ────────────────────────────────────
        Positioned(
          top: -80,
          right: -60,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).primaryColor.withValues(alpha: 0.18),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: -70,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFEC4899).withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // ── Content ────────────────────────────────────────────────────────
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Glowing pulsing avatar
              _GlowAvatar(photoUrl: photoUrl),

              const Gap(32),

              // Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName,
                      style: AppFont.font(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(12),
                    const CallTimerWidget(),
                    if (subtitle.isNotEmpty) ...[
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_rounded, color: Theme.of(context).primaryColor, size: 13),
                            const Gap(5),
                            Flexible(
                              child: Text(
                                subtitle,
                                style: AppFont.font(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const Spacer(flex: 3), // Bottom spacer to center the profile content vertically
            ],
          ),
        ),

        // ── Single-row bottom capsule pill (matches invitation calling screen) ──
        const _CallBottomCapsulePill(isVideoCall: false),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Glowing Avatar with animated ring
// ─────────────────────────────────────────────────────────────────────────────

class _GlowAvatar extends StatefulWidget {
  final String photoUrl;
  const _GlowAvatar({required this.photoUrl});

  @override
  State<_GlowAvatar> createState() => _GlowAvatarState();
}

class _GlowAvatarState extends State<_GlowAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.45),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Container(
          width: 148,
          height: 148,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          child: ClipOval(
            child: widget.photoUrl.isNotEmpty
                ? getImageWidget(url: widget.photoUrl, boxFit: BoxFit.cover)
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 72),
                  ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CALLING INVITATION FOREGROUND
// Single-row pill with mic/speaker/camera/end-call shown on the "Calling..."
// invitation page BEFORE the call is answered.
// Replaces Zego's default two-row toolbar layout.
// ═══════════════════════════════════════════════════════════════════════════

class CallingInvitationForeground extends StatelessWidget {
  final ZegoCallingBuilderInfo info;

  const CallingInvitationForeground({super.key, required this.info});

  bool get _isVideo => info.callType == ZegoCallInvitationType.videoCall;

  @override
  Widget build(BuildContext context) {
    // Hide custom action buttons for incoming call invitations (invitee).
    // Callee should only see native Decline and Accept buttons until call is accepted.
    final localUser = ZegoUIKit().getLocalUser();
    if (localUser.id != info.inviter.id) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 36, left: 24, right: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(48),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ── Mic toggle ─────────────────────────────────────────────
                ValueListenableBuilder<bool>(
                  valueListenable: ZegoUIKit().getLocalUser().microphone,
                  builder: (context, isMicOn, _) {
                    return _ActionButton(
                      icon: isMicOn ? Icons.mic_rounded : Icons.mic_off_rounded,
                      bgColor: isMicOn
                          ? Colors.white.withValues(alpha: 0.18)
                          : Colors.red.withValues(alpha: 0.85),
                      onTap: () => ZegoUIKit().turnMicrophoneOn(!isMicOn),
                    );
                  },
                ),

                // ── Speaker toggle ─────────────────────────────────────────
                ValueListenableBuilder<ZegoUIKitAudioRoute>(
                  valueListenable: ZegoUIKit().getAudioOutputDeviceNotifier(
                    ZegoUIKit().getLocalUser().id,
                  ),
                  builder: (context, route, _) {
                    final isSpeaker = route == ZegoUIKitAudioRoute.speaker;
                    return _ActionButton(
                      icon: isSpeaker
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      bgColor: Colors.white.withValues(alpha: 0.18),
                      onTap: () =>
                          ZegoUIKit().setAudioOutputToSpeaker(!isSpeaker),
                    );
                  },
                ),

                // ── Camera toggle (video only) ──────────────────────────────
                if (_isVideo)
                  ValueListenableBuilder<bool>(
                    valueListenable: ZegoUIKit().getLocalUser().camera,
                    builder: (context, isCameraOn, _) {
                      return _ActionButton(
                        icon: isCameraOn
                            ? Icons.videocam_rounded
                            : Icons.videocam_off_rounded,
                        bgColor: isCameraOn
                            ? Colors.white.withValues(alpha: 0.18)
                            : Colors.red.withValues(alpha: 0.85),
                        onTap: () => ZegoUIKit().turnCameraOn(!isCameraOn),
                      );
                    },
                  ),

                // ── End call (cancel / reject invitation) ──────────────────
                _ActionButton(
                  icon: Icons.call_end_rounded,
                  bgColor: const Color(0xFFEF4444),
                  onTap: () async {
                    try {
                      final localUser = ZegoUIKit().getLocalUser();
                      final callees = info.invitees
                          .map((u) => ZegoCallUser(u.id, u.name))
                          .toList();
                      if (localUser.id == info.inviter.id) {
                        // Caller canceling the outgoing invitation
                        await ZegoUIKitPrebuiltCallInvitationService().cancel(
                          callees: callees,
                        );
                      } else {
                        // Callee rejecting the incoming invitation
                        await ZegoUIKitPrebuiltCallInvitationService().reject();
                      }
                    } catch (e) {
                      debugPrint("Error canceling call invitation: $e");
                    }
                    if (context.mounted) {
                      try {
                        ZegoUIKitPrebuiltCallController().hangUp(context);
                      } catch (_) {}
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small circular icon button used inside [CallingInvitationForeground].
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CALL BOTTOM CAPSULE PILL
// Single-row dark capsule pill containing Mic, Speaker, Camera, and End Call
// buttons rendered inside active connected call room.
// ═══════════════════════════════════════════════════════════════════════════

class _CallBottomCapsulePill extends StatelessWidget {
  final bool isVideoCall;

  const _CallBottomCapsulePill({required this.isVideoCall});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 36, left: 24, right: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(48),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ── Mic toggle ─────────────────────────────────────────────
                ValueListenableBuilder<bool>(
                  valueListenable: ZegoUIKit().getLocalUser().microphone,
                  builder: (context, isMicOn, _) {
                    return _ActionButton(
                      icon: isMicOn ? Icons.mic_rounded : Icons.mic_off_rounded,
                      bgColor: isMicOn
                          ? Colors.white.withValues(alpha: 0.18)
                          : Colors.red.withValues(alpha: 0.85),
                      onTap: () => ZegoUIKit().turnMicrophoneOn(!isMicOn),
                    );
                  },
                ),

                // ── Speaker toggle ─────────────────────────────────────────
                ValueListenableBuilder<ZegoUIKitAudioRoute>(
                  valueListenable: ZegoUIKit().getAudioOutputDeviceNotifier(
                    ZegoUIKit().getLocalUser().id,
                  ),
                  builder: (context, route, _) {
                    final isSpeaker = route == ZegoUIKitAudioRoute.speaker;
                    return _ActionButton(
                      icon: isSpeaker
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      bgColor: Colors.white.withValues(alpha: 0.18),
                      onTap: () =>
                          ZegoUIKit().setAudioOutputToSpeaker(!isSpeaker),
                    );
                  },
                ),

                // ── Camera toggle (video only) ──────────────────────────────
                if (isVideoCall)
                  ValueListenableBuilder<bool>(
                    valueListenable: ZegoUIKit().getLocalUser().camera,
                    builder: (context, isCameraOn, _) {
                      return _ActionButton(
                        icon: isCameraOn
                            ? Icons.videocam_rounded
                            : Icons.videocam_off_rounded,
                        bgColor: isCameraOn
                            ? Colors.white.withValues(alpha: 0.18)
                            : Colors.red.withValues(alpha: 0.85),
                        onTap: () => ZegoUIKit().turnCameraOn(!isCameraOn),
                      );
                    },
                  ),

                // ── End Call ───────────────────────────────────────────────
                _ActionButton(
                  icon: Icons.call_end_rounded,
                  bgColor: const Color(0xFFEF4444),
                  onTap: () =>
                      ZegoUIKitPrebuiltCallController().hangUp(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CALL TIMER WIDGET
// Displays real-time live call duration (00:00, 00:01, etc.)
// ═══════════════════════════════════════════════════════════════════════════

class CallTimerWidget extends StatefulWidget {
  const CallTimerWidget({super.key});

  @override
  State<CallTimerWidget> createState() => _CallTimerWidgetState();
}

class _CallTimerWidgetState extends State<CallTimerWidget> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final remMinutes = minutes % 60;
      final hoursStr = hours.toString().padLeft(2, '0');
      return '$hoursStr:${remMinutes.toString().padLeft(2, '0')}:$secondsStr';
    }
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          const Gap(6),
          Text(
            _formatDuration(_seconds),
            style: AppFont.font(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
