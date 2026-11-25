import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/common/providers/config_notifier.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/core/routing/router_provider.dart';
import 'package:pro_matrimony/services/app_notification_handler.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/services/notification_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> args;
  const SplashScreen({super.key, required this.args});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // ── Animation controllers ───────────────────────────────────────────────
  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final AnimationController _breatheController;
  late final AnimationController _loadingController;

  // ── Animations ──────────────────────────────────────────────────────────
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _breatheScale;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleOpacity;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _loadingProgressAnim;

  late final DateTime _splashStartTime;

  @override
  void initState() {
    super.initState();
    _splashStartTime = DateTime.now();

    // ── Logo: smooth scale in from 0.75 -> 1.04 -> 1.0 ──────────────
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.75, end: 1.04)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 65,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.04, end: 0.98)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.98, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
    ]).animate(_logoController);

    _logoOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
      ),
    );

    // ── Subtle continuous logo breathing ────────────────────────────
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _breatheScale = Tween<double>(begin: 0.985, end: 1.015).animate(
      CurvedAnimation(
        parent: _breatheController,
        curve: Curves.easeInOutSine,
      ),
    );

    // ── Text: staggered fade-in with smooth upward slide ─────────────
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _titleOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _subtitleOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
      ),
    );
    _subtitleSlide = Tween(begin: const Offset(0, 0.35), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // ── Loading progress: smooth progress bar animation ────────────
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _loadingProgressAnim = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOutCubic,
    );

    // ── Kick off animation sequence ──────────────────────────────────
    _logoController.forward().then((_) {
      if (mounted) {
        _textController.forward();
        _breatheController.repeat(reverse: true);
      }
    });
    _loadingController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(configProvider.notifier).initializeApp();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _breatheController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final appVersion = ref.watch(appVersionProvider).value ?? '';

    ref.listen<ConfigState>(configProvider, (previous, next) {
      if (next.status == ConfigStatus.success) {
        _handleRedirection();
      } else if (next.status == ConfigStatus.forceUpdate) {
        _handleRedirection();
      } else if (next.status == ConfigStatus.maintenance) {
        context.go('/maintenance');
      } else if (next.status == ConfigStatus.error) {
        showToast(next.errorMessage ?? 'error_occurred'.tr);
        _handleRedirection();
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFBFC),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF7F8FA),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Subtle ambient background shapes for soft visual depth
              Positioned(
                top: -100,
                right: -80,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFEDF2F7).withValues(alpha: 0.6),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -60,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE2E8F0).withValues(alpha: 0.35),
                  ),
                ),
              ),

              // ── Centered logo + title + subtitle ───────────────────────────
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo with scale + gentle breathe
                    AnimatedBuilder(
                      animation: Listenable.merge([_logoController, _breatheController]),
                      builder: (context, child) {
                        final breathe = _logoController.isCompleted
                            ? _breatheScale.value
                            : 1.0;
                        return Opacity(
                          opacity: _logoOpacity.value,
                          child: Transform.scale(
                            scale: _logoScale.value * breathe,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF16182F).withValues(alpha: 0.05),
                              blurRadius: 36,
                              spreadRadius: 4,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          AppAssets.splashLogoPng,
                          width: 210,
                          height: 210,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // App Title & Tagline
                    Transform.translate(
                      offset: const Offset(0, -25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // App Title: ProMatri (Single unified dark color)
                          AnimatedBuilder(
                            animation: _textController,
                            builder: (context, _) {
                              return SlideTransition(
                                position: _titleSlide,
                                child: Opacity(
                                  opacity: _titleOpacity.value,
                                  child: Text(
                                    'ProMatri',
                                    style: AppFont.font(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF16182F),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 8),

                          // Tagline: Where souls find their forever
                          AnimatedBuilder(
                            animation: _textController,
                            builder: (context, _) {
                              return SlideTransition(
                                position: _subtitleSlide,
                                child: Opacity(
                                  opacity: _subtitleOpacity.value,
                                  child: Text(
                                    'Where souls find their forever',
                                    style: AppFont.font(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Bottom Version & Bar Indicator ────────────────────────────
              Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Smooth animated loading indicator
                    Container(
                      width: 84,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: AnimatedBuilder(
                          animation: _loadingProgressAnim,
                          builder: (context, child) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: _loadingProgressAnim.value,
                                child: Container(
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      appVersion.isNotEmpty ? 'VERSION $appVersion' : 'VERSION 1.0.0',
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 3.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isZegoCallActive() {
    try {
      final roomId = ZegoUIKit().getRoom().id;
      final roomState = ZegoUIKit().getRoomStateStream().value;
      final isActive = roomId.isNotEmpty || roomState.reason == ZegoRoomStateChangedReason.Logined;
      printLog("ZEGO_CHECK: roomId='$roomId', roomReason=${roomState.reason} => isActive=$isActive");
      return isActive;
    } catch (e) {
      printLog("ZEGO_CHECK_ERROR: $e");
      return false;
    }
  }

  bool _isCallPayload(Map<String, dynamic>? payload) {
    if (payload == null) return false;
    final action =
        payload["type"]?.toString() ??
        payload["noti_type"]?.toString() ??
        payload["notification_type"]?.toString() ??
        payload["action"]?.toString() ??
        "";
    return payload.containsKey("call_id") ||
        payload.containsKey("zego") ||
        payload.containsKey("call_type") ||
        action.toLowerCase().contains("call");
  }

  // ── Redirection logic ─────────────────────────────────────────────────
  Future<void> _handleRedirection() async {
    final Map<String, dynamic>? argPayload =
        widget.args['message_payload'] as Map<String, dynamic>?;

    Map<String, dynamic>? payload = argPayload;
    bool isFromNotification = widget.args['is_from_notification'] == true;

    if (!isFromNotification && NotificationService.initialNotificationPayload != null) {
      try {
        final decoded = jsonDecode(NotificationService.initialNotificationPayload!);
        if (decoded is Map<String, dynamic>) {
          payload = decoded;
          isFromNotification = true;
        }
      } catch (e) {
        printLog("SplashScreen: Error decoding initialNotificationPayload: $e");
      }
      NotificationService.initialNotificationPayload = null;
    }

    final bool isCallNotification =
        isFromNotification && _isCallPayload(payload);

    // Skip the 2.5-second splash timer completely for Zego incoming calls
    if (!isCallNotification && !_isZegoCallActive()) {
      const minSplashDuration = Duration(milliseconds: 2500);
      final elapsed = DateTime.now().difference(_splashStartTime);
      if (elapsed < minSplashDuration) {
        await Future.delayed(minSplashDuration - elapsed);
      }
    }
    if (!mounted) return;

    // IF A ZEGO CALL IS ACTIVE, WAIT UNTIL CALL FINISHES BEFORE SWAPPING ROUTE!
    if (_isZegoCallActive()) {
      printLog("SplashScreen: Active Zego Call detected. Pausing splash route replacement until call ends.");
      while (mounted && _isZegoCallActive()) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
      if (!mounted) return;
    }

    final isLoggedIn = ref.read(configProvider.notifier).isLoggedIn;
    if (isFromNotification && payload != null && isLoggedIn) {
      _handleNotificationRedirection(payload);
    } else {
      if (isLoggedIn) {
        final registerStepStr = AppSessionService.getValue('registerStep');
        final step = int.tryParse(registerStepStr?.toString() ?? '9') ?? 9;

        // If registration is required and not yet complete, force the user
        // back to the login screen on every app reopen so they re-authenticate
        // and continue from the wizard step after logging in again.
        if (registerStepStatus == 'Enable' && step < 9) {
          AppSessionService.clear().then((_) {
            if (mounted) context.go('/login');
          });
        } else {
          context.go('/home');
        }
      } else {
        context.go('/intro');
      }
    }
  }

  void _handleNotificationRedirection(Map<String, dynamic> payload) {
    final action =
        (payload["type"]?.toString() ??
        payload["noti_type"]?.toString() ??
        payload["notification_type"]?.toString() ??
        payload["action"]?.toString() ??
        "").toLowerCase().trim();

    final otherId =
        payload["viewer_id"]?.toString() ??
        payload["sender_id"]?.toString() ??
        payload["member_id"]?.toString() ??
        payload["matri_id"]?.toString() ??
        payload["user_id"]?.toString() ??
        payload["sender_member_id"]?.toString();

    final bool isCallPayload = payload.containsKey("call_id") ||
        payload.containsKey("zego") ||
        payload.containsKey("call_type") ||
        action.toLowerCase().contains("call");

    if (isCallPayload) {
      printLog("SplashScreen: Call notification payload detected. Navigating to /home to preserve call UI.");
      context.go('/home');
      return;
    }

    final bool isPlanOrMembership = action.contains('plan') ||
        action.contains('membership') ||
        action.contains('subscription') ||
        action.contains('payment');
    final bool isExpired = action.contains('expire');

    final String title = (payload["title"]?.toString() ?? "").toLowerCase();
    final String message = ((payload["body"]?.toString() ?? payload["message"]?.toString()) ?? "").toLowerCase();
    final bool textSuggestsPlan = (title.contains("plan") || title.contains("membership")) ||
        (message.contains("plan assigned") || message.contains("membership assigned"));

    printLog("SplashScreen: Handling notification redirection: action=$action, isPlanOrMembership=$isPlanOrMembership");

    void navigateAfterHome(String route, {Object? extra}) {
      context.go('/home');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.push(route, extra: extra);
        }
      });
    }

    switch (action) {
      case "featured_profile":
      case "featured":
      case "featured_member":
      case "featured_members":
        context.go('/home');
        break;
      case "viewed_profile":
      case "viewed_contact_details":
      case "profile_view":
      case "profile_viewed":
        if (otherId != null && otherId.isNotEmpty) {
          navigateAfterHome('/profile-other/$otherId');
        } else {
          context.go('/home');
        }
        break;
      case "membership_purchase_success":
      case "membership_purchase":
      case "payment_received":
      case "plan_subscribed":
      case "plan_subscription":
      case "admin_plan_assign":
      case "admin_plan_assigned":
      case "admin_assign_plan":
      case "admin_plan":
      case "plan_assigned":
      case "plan_assign":
      case "membership_plan_assigned":
      case "membership_plan_assign":
      case "membership_assigned":
      case "membership_assign":
      case "assign_plan":
      case "assign_membership_plan":
      case "membership_plan":
      case "current_plan":
        navigateAfterHome('/current-plan');
        break;
      case "plan_expired":
        navigateAfterHome('/plans');
        break;
      case "interest_received":
        navigateAfterHome('/connections', extra: "received");
        break;
      case "accept_connection":
      case "reject_connection":
      case "accept_interest":
      case "accept_interest_received":
        navigateAfterHome('/connections');
        break;
      case "photo_request_received":
        navigateAfterHome('/photo-requests', extra: "received");
        break;
      case "photo_request_accept":
      case "photo_request_reject":
        ApplicationData.isToOpenPhotoRequestSentScreen = true;
        navigateAfterHome('/photo-requests');
        break;
      case "chat_message_received":
      case "new_chat_request":
        final titleVal = payload["title"]?.toString() ?? "";
        final senderName = titleVal.contains("from ")
            ? titleVal.split("from ").last
            : (titleVal.isNotEmpty ? titleVal : "User");
        if (otherId != null && otherId.isNotEmpty) {
          navigateAfterHome(
            '/chat-conversation/$otherId',
            extra: {'receiverName': senderName},
          );
        } else {
          context.go('/home');
        }
        break;
      case "personalize_chat_from_admin":
      case "personalized_chat_from_admin":
        navigateAfterHome('/chat-with-admin');
        break;
      case "match_from_admin":
        AppNotificationHandler.handleMatchFromAdminRedirection(
          context: context,
          ref: ref,
        );
        break;
      case "id_proof_approval":
      case "id_proof_photo_approval":
        navigateAfterHome('/manage-photos?index=1');
        break;
      case "photos_approval":
      case "profile_photo_approval":
        navigateAfterHome('/manage-photos?index=0');
        break;
      case "horoscope_approval":
      case "horoscope_photo_approval":
        navigateAfterHome('/manage-photos?index=2');
        break;
      default:
        if (isCallPayload) {
          context.go('/home');
        } else if (isPlanOrMembership || textSuggestsPlan) {
          if (isExpired) {
            navigateAfterHome('/plans');
          } else {
            navigateAfterHome('/current-plan');
          }
        } else if (otherId != null && otherId.isNotEmpty) {
          navigateAfterHome('/profile-other/$otherId');
        } else {
          context.go('/home');
        }
        break;
    }
  }
}
