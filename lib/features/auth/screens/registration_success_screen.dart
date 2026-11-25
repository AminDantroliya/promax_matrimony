import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../app_theme/app_font.dart';
import '../../../config/providers/config_providers.dart';

class RegistrationSuccessScreen extends ConsumerStatefulWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  ConsumerState<RegistrationSuccessScreen> createState() =>
      _RegistrationSuccessScreenState();
}

class _RegistrationSuccessScreenState
    extends ConsumerState<RegistrationSuccessScreen>
    with SingleTickerProviderStateMixin {
  static const int _totalSeconds = 5;
  int _secondsRemaining = _totalSeconds;
  Timer? _countdownTimer;

  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.65, curve: Curves.elasticOut),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.25).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animController.forward();
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _navigateToLogin();
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0D0E18), Color(0xFF17192C)],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFF7F8), Color(0xFFFFF0F3)],
                  ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // ── Celebration Icon with Animated Pulse Rings ──
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer Ripple 2
                          Transform.scale(
                            scale: _pulseAnimation.value * 1.25,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: config.primaryColor.withValues(
                                  alpha: (0.12 * (1.0 - _animController.value))
                                      .clamp(0.0, 0.12),
                                ),
                              ),
                            ),
                          ),
                          // Outer Ripple 1
                          Transform.scale(
                            scale: _pulseAnimation.value * 1.1,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: config.primaryColor.withValues(
                                  alpha: (0.22 * (1.0 - _animController.value))
                                      .clamp(0.0, 0.22),
                                ),
                              ),
                            ),
                          ),
                          // Core Badge
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              width: 104,
                              height: 104,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    config.gradientStart,
                                    config.gradientEnd,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: config.primaryColor.withValues(
                                      alpha: 0.38,
                                    ),
                                    blurRadius: 28,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 56,
                                ),
                              ),
                            ),
                          ),
                          // Sparkle Decor 1
                          Positioned(
                            top: 8,
                            right: 28,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                color: config.primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                          // Sparkle Decor 2
                          Positioned(
                            bottom: 12,
                            left: 24,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Icon(
                                Icons.star_rounded,
                                color: config.primaryColor.withValues(
                                  alpha: 0.7,
                                ),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const Gap(36),

                  // ── Title & Message Animated Slide/Fade ────────
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Registration Successful! 🎉',
                            textAlign: TextAlign.center,
                            style: AppFont.font(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF16182F),
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Your profile has been created successfully.\nWelcome to ${config.appName}!',
                            textAlign: TextAlign.center,
                            style: AppFont.font(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF6B7280),
                            ),
                          ),
                          const Gap(32),

                          // ── 5-Second Timer Indicator ──────────
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF262948)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF35395E)
                                    : const Color(0xFFF0E5E7),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: isDark ? 0.25 : 0.04,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    value: _secondsRemaining / _totalSeconds,
                                    strokeWidth: 2.2,
                                    backgroundColor: config.primaryColor
                                        .withValues(alpha: 0.15),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      config.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Redirecting to login in $_secondsRemaining second${_secondsRemaining == 1 ? '' : 's'}...',
                                  style: AppFont.font(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white70
                                        : const Color(0xFF5B6275),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // ── Login Now Button ───────────────────────────
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: GestureDetector(
                        onTap: _navigateToLogin,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(config.buttonRadius),
                            gradient: LinearGradient(
                              colors: [
                                config.gradientStart,
                                config.gradientEnd,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: config.primaryColor.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login Now',
                                  style: AppFont.font(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 20,
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
          ),
        ),
      ),
    );
  }
}
