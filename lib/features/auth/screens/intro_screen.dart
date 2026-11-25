import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/config/app_config.dart';
import 'package:pro_matrimony/widgets/app_common_background.dart';

import '../../../../app_theme/size_config.dart';
import '../../../../utils/utils.dart';
import 'register2/providers/dynamic_register_notifier.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen>
    with TickerProviderStateMixin {
  final int totalPages = 2;
  final PageController _pageController = PageController();

  // Background wave animation controller
  late final AnimationController _waveController;

  // Slide content entry animation controllers
  late final AnimationController _slide1Controller;
  late final AnimationController _slide2Controller;

  @override
  void initState() {
    super.initState();

    // Infinite slow rotation for background wave
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    // Entry animations for slides
    _slide1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _slide2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _slide1Controller.dispose();
    _slide2Controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (index == 0) {
      _slide1Controller.forward(from: 0.0);
    } else {
      _slide2Controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final config = ref.watch(appConfigProvider);

    return AnnotatedRegion(
      value: getThemeSystemUiOverlayStyle(isDark: false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AppAuthBackground(
          isLight: true,
          child: SafeArea(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [_buildIntro1Slide(config), _buildIntro2Slide(config)],
            ),
          ),
        ),
      ),
    );
  }

  // ── INTRO 1 SLIDE (Feature Highlights Orbit + Staggered Cards) ────────────
  Widget _buildIntro1Slide(AppConfig config) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        children: [
          // ── Orbit Top Illustration ──────────────────────────────────────
          Expanded(
            flex: 6,
            child: AnimatedBuilder(
              animation: _slide1Controller,
              builder: (context, child) {
                final scale = Tween<double>(begin: 0.85, end: 1.0)
                    .animate(
                      CurvedAnimation(
                        parent: _slide1Controller,
                        curve: Curves.easeOutCubic,
                      ),
                    )
                    .value;
                final opacity = Tween<double>(begin: 0.0, end: 1.0)
                    .animate(
                      CurvedAnimation(
                        parent: _slide1Controller,
                        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
                      ),
                    )
                    .value;

                return Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Center(
                      child: SizedBox(
                        width: 330,
                        height: 330,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Dynamic Orbit & Glowing Aura (replaces static blue/purple intro_circle.png)
                            _buildDynamicOrbitIllustration(config),

                            // Center pink heart logo card
                            Image.asset(
                              AppAssets.splashLogoPng,
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),

                            // Avatar 1 - Top Left
                            Positioned(
                              top: 22,
                              left: 46,
                              child: _buildAvatarCircle(
                                AppAssets.figmaProfile1,
                                46,
                              ),
                            ),

                            // Avatar 2 - Top Right
                            Positioned(
                              top: 54,
                              right: 32,
                              child: _buildAvatarCircle(
                                AppAssets.figmaProfile2,
                                44,
                              ),
                            ),

                            // Avatar 3 - Bottom Left
                            Positioned(
                              bottom: 72,
                              left: 52,
                              child: _buildAvatarCircle(
                                AppAssets.figmaProfile1,
                                42,
                              ),
                            ),

                            // Avatar 4 - Bottom Right
                            Positioned(
                              bottom: 34,
                              right: 64,
                              child: _buildAvatarCircle(
                                AppAssets.figmaProfile2,
                                44,
                              ),
                            ),

                            // Tag 1: 100% Verified (Left Orbit)
                            Positioned(
                              top: 102,
                              left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF16182F).withValues(
                                        alpha: 0.08,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF2E7D32),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    const Gap(5),
                                    Text(
                                      '100% Verified',
                                      style: AppFont.font(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF16182F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Tag 2: Trusted App (Right Orbit)
                            Positioned(
                              top: 138,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF16182F).withValues(
                                        alpha: 0.08,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.favorite_rounded,
                                      color: config.primaryColor,
                                      size: 13,
                                    ),
                                    const Gap(5),
                                    Text(
                                      'Trusted App',
                                      style: AppFont.font(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF16182F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Staggered Feature Cards Stack (Exact Figma Specs & Glassmorphism) ──
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card 1: Left -17px via Transform.translate, Padding Left 34px (Figma spec)
                _buildStaggeredGlassCard(
                  config: config,
                  icon: Icons.shield_rounded,
                  title: 'ID Verified Profiles',
                  subtitle: 'Every member is manually verified',
                  alignment: Alignment.centerLeft,
                  offset: const Offset(-17, 0),
                  margin: const EdgeInsets.only(right: 45),
                  padding: const EdgeInsets.fromLTRB(34, 14, 16, 14),
                ),
                const Gap(12),
                // Card 2: Right 17px via Transform.translate, Padding Right 34px (Figma spec)
                _buildStaggeredGlassCard(
                  config: config,
                  icon: Icons.lock_rounded,
                  title: 'Privacy Controls',
                  subtitle: 'You decide who sees your photos',
                  alignment: Alignment.centerRight,
                  offset: const Offset(17, 0),
                  margin: const EdgeInsets.only(left: 45),
                  padding: const EdgeInsets.fromLTRB(16, 14, 34, 14),
                ),
                const Gap(12),
                // Card 3: Family Involvement (Centered Glassmorphism Card)
                _buildStaggeredGlassCard(
                  config: config,
                  icon: Icons.people_rounded,
                  title: 'Family Involvement',
                  subtitle: 'Include parents in your journey',
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Action Row ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [config.gradientStart, config.gradientEnd],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(config.buttonRadius),
                boxShadow: [
                  BoxShadow(
                    color: config.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(config.buttonRadius),
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(8),
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
        ],
      ),
    );
  }

  // ── INTRO 2 SLIDE (Success Story / Rated #1) ───────────────────────────
  Widget _buildIntro2Slide(AppConfig config) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          // ── Rating Badge Top ───────────────────────────────────────────
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF16182F).withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: config.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                const Gap(8),
                Text(
                  'Rated #1 Matrimony App ${DateTime.now().year}',
                  style: AppFont.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF16182F),
                  ),
                ),
              ],
            ),
          ),

          // ── Couple Photo Frames Hero ───────────────────────────────────
          Expanded(
            flex: 6,
            child: AnimatedBuilder(
              animation: _slide2Controller,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Overlapping Heart Photo Frames
                    SizedBox(
                      height: 180,
                      width: 280,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Left Frame (Female)
                          Positioned(
                            left: 20,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF16182F).withValues(alpha: 0.12),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppAssets.figmaProfile1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Right Frame (Male)
                          Positioned(
                            right: 20,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF16182F).withValues(alpha: 0.12),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppAssets.figmaProfile2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(12),

                    // Couple Names
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Priya ',
                          style: AppFont.font(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF16182F),
                          ),
                        ),
                        Text(
                          '& ',
                          style: AppFont.font(
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: config.primaryColor,
                          ),
                        ),
                        Text(
                          'Arjun',
                          style: AppFont.font(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF16182F),
                          ),
                        ),
                      ],
                    ),

                    const Gap(4),

                    // Subtext
                    Text(
                      'Matched January 2026  •  Married April 2026',
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),

                    const Gap(16),

                    // Quote Box
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '" Pro Max Matrimony didn\'t just find us a partner — it helped us find our forever. Best decision we ever made. "',
                        textAlign: TextAlign.center,
                        style: AppFont.font(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF334155),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // ── Bottom Action Buttons ──────────────────────────────────────
          Column(
            children: [
              // Primary Button: Create Free Account ->
              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [config.gradientStart, config.gradientEnd],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(config.buttonRadius),
                  boxShadow: [
                    BoxShadow(
                      color: config.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(config.buttonRadius),
                    onTap: () {
                      ref
                          .read(dynamicRegisterProvider.notifier)
                          .resetRegistration();
                      context.push('/register');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Create Free Account',
                              textAlign: TextAlign.center,
                              style: AppFont.font(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(
                                config.isButtonSquare
                                    ? 4.0
                                    : (config.isButtonRounded ? 8.0 : 20.0),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(12),

              // Light Button: I already have an account
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(config.buttonRadius),
                  border: Border.all(
                    color: const Color(0xFFCBD5E1),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF16182F).withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(config.buttonRadius),
                    onTap: () => context.push('/login'),
                    child: Center(
                      child: Text(
                        'I already have an account',
                        style: AppFont.font(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF16182F),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(16),

              // Member Count Footer Stack
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 24,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: _buildAvatarCircle(
                            AppAssets.figmaProfile1,
                            24,
                          ),
                        ),
                        Positioned(
                          left: 14,
                          child: _buildAvatarCircle(
                            AppAssets.figmaProfile2,
                            24,
                          ),
                        ),
                        Positioned(
                          left: 28,
                          child: _buildAvatarCircle(
                            AppAssets.figmaProfile1,
                            24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  RichText(
                    text: TextSpan(
                      style: AppFont.font(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                      children: [
                        const TextSpan(text: 'Join '),
                        TextSpan(
                          text: '10k+ ',
                          style: AppFont.font(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF16182F),
                          ),
                        ),
                        const TextSpan(text: 'happy members'),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(8),
            ],
          ),
        ],
      ),
    );
  }

  // ── Helper Widgets ────────────────────────────────────────────────────────
  Widget _buildAvatarCircle(String assetPath, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: size > 30 ? 2.5 : 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF16182F).withValues(alpha: 0.10),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(child: Image.asset(assetPath, fit: BoxFit.cover)),
    );
  }

  // ── Dynamic Theme Orbit Illustration (Vectors & Radial Glow) ──────────────
  Widget _buildDynamicOrbitIllustration(AppConfig config) {
    final ringColor = config.primaryColor.withValues(alpha: 0.16);

    return SizedBox(
      width: 330,
      height: 330,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dynamic theme glowing radial aura on minimal light background
          Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  config.primaryColor.withValues(alpha: 0.10),
                  config.gradientEnd.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.70, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: config.primaryColor.withValues(alpha: 0.06),
                  blurRadius: 36,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
          // Ring 1 (Inner Orbit)
          CustomPaint(
            size: const Size(220, 220),
            painter: DashedCirclePainter(
              color: ringColor,
              strokeWidth: 1.0,
              dashWidth: 4,
              dashSpace: 4,
            ),
          ),
          // Ring 2 (Middle Orbit)
          CustomPaint(
            size: const Size(260, 260),
            painter: DashedCirclePainter(
              color: ringColor,
              strokeWidth: 1.0,
              dashWidth: 4,
              dashSpace: 4,
            ),
          ),
          // Ring 3 (Outer Orbit)
          CustomPaint(
            size: const Size(296, 296),
            painter: DashedCirclePainter(
              color: ringColor,
              strokeWidth: 1.0,
              dashWidth: 4,
              dashSpace: 4,
            ),
          ),
          // Ring 4 (Outermost Ambient Orbit)
          CustomPaint(
            size: const Size(330, 330),
            painter: DashedCirclePainter(
              color: ringColor.withValues(alpha: 0.10),
              strokeWidth: 1.0,
              dashWidth: 4,
              dashSpace: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaggeredGlassCard({
    required AppConfig config,
    required IconData icon,
    required String title,
    required String subtitle,
    required Alignment alignment,
    required EdgeInsets margin,
    required EdgeInsets padding,
    Offset offset = Offset.zero,
    BorderRadius? borderRadius,
  }) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(20);

    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: offset,
        child: Container(
          margin: margin,
          child: ClipRRect(
            borderRadius: effectiveRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: effectiveRadius,
                  border: Border.all(
                    color: const Color(0xFFE2E8F0).withValues(alpha: 0.9),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF16182F).withValues(alpha: 0.05),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: config.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: config.primaryColor.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Icon(icon, color: config.primaryColor, size: 22),
                    ),
                    const Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: AppFont.font(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF16182F),
                            ),
                          ),
                          const Gap(3),
                          Text(
                            subtitle,
                            style: AppFont.font(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
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
    );
  }
}

// ── Dashed Circle Painter ──────────────────────────────────────────────────
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.2,
    this.dashWidth = 5,
    this.dashSpace = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle =
          (i * (dashWidth + dashSpace) / circumference) * 2 * math.pi;
      final sweepAngle = (dashWidth / circumference) * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
