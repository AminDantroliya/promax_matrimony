import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/common/data/models/member_models.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/widgets/photo_request_bottom_sheet.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/utils/app_routes.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import '../../../../features/common/data/repositories/action_repository.dart';
import '../../../../widgets/profile_cards/profile_card_action_handler.dart';

class DatingCardSwiper extends ConsumerStatefulWidget {
  final List<MemberListModel> items;
  final int currentIndex;
  final bool isLoadingMore;
  final Function(int index) onSwipeLeft;
  final Function(int index) onSwipeRight;
  final Function(int index) onTapCard;
  final VoidCallback onEmpty;

  const DatingCardSwiper({
    super.key,
    required this.items,
    required this.currentIndex,
    this.isLoadingMore = false,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onTapCard,
    required this.onEmpty,
  });

  @override
  ConsumerState<DatingCardSwiper> createState() => _DatingCardSwiperState();
}

class _DatingCardSwiperState extends ConsumerState<DatingCardSwiper>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  bool _isAnimating = false;

  // Local state to track toggled shortlist status to make UI instantly responsive
  final Map<String, bool> _localShortlisted = {};

  // Local state to track toggled interest status to make UI instantly responsive
  final Map<String, bool> _localInterested = {};

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _swipeLeft() {
    if (_isAnimating) return;
    _isAnimating = true;
    final startOffset = _dragOffset;
    final endOffset = Offset(-SizeConfig.screenWidth! * 1.5, _dragOffset.dy);

    _slideAnimation = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward(from: 0.0).then((_) {
      widget.onSwipeLeft(widget.currentIndex);
      setState(() {
        _dragOffset = Offset.zero;
        _isAnimating = false;
      });
    });
  }

  void _swipeRight() {
    if (_isAnimating) return;
    _isAnimating = true;
    final startOffset = _dragOffset;
    final endOffset = Offset(SizeConfig.screenWidth! * 1.5, _dragOffset.dy);

    _slideAnimation = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward(from: 0.0).then((_) {
      widget.onSwipeRight(widget.currentIndex);
      setState(() {
        _dragOffset = Offset.zero;
        _isAnimating = false;
      });
    });
  }

  void _snapBack() {
    _isAnimating = true;
    _slideAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
        );

    _animController.forward(from: 0.0).then((_) {
      setState(() {
        _dragOffset = Offset.zero;
        _isAnimating = false;
      });
    });
  }

  void _confirmVoiceCall(MemberListModel member) {
    initiateAppCall(context, ref, targetModel: member, isVideo: false);
  }

  void _confirmVideoCall(MemberListModel member) {
    initiateAppCall(context, ref, targetModel: member, isVideo: true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentIndex >= widget.items.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onEmpty();
      });

      if (widget.isLoadingMore) {
        return const Center(
          child: AppLoadingWidget(),
        );
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.people_outline,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            customTextBoldStyle(
              "no_profiles_found".tr,
              18,
              TextAlign.center,
              Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 8),
            customTextNormalStyle(
              "try_switching_tabs".tr,
              14,
              TextAlign.center,
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ],
        ),
      );
    }

    final topMember = widget.items[widget.currentIndex];
    final hasNext = widget.currentIndex + 1 < widget.items.length;
    final nextMember = hasNext ? widget.items[widget.currentIndex + 1] : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // Photo aspect ratio from Edit Photo:
        // CropAspectRatio(ratioX: 1, ratioY: 1.3) => 1 / 1.3 ≈ 0.7692 (Height = Width * 1.3)
        const double photoAspectRatio = 1 / 1.3;

        // Calculate card dimensions respecting photo aspect ratio
        double cardWidth = availableWidth;
        double cardHeight = cardWidth / photoAspectRatio;

        if (cardHeight > availableHeight) {
          // If height is constrained by screen, use full available height to maximize photo size
          cardHeight = availableHeight;
        } else if (availableHeight - cardHeight < 60) {
          // If the difference is small (<60px), fill full height to avoid an awkward gap
          cardHeight = availableHeight;
        }

        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
            // Next Card in Stack
            if (nextMember != null)
              Positioned.fill(
                child: Transform.scale(
                  scale: 0.95,
                  child: Opacity(
                    opacity: 0.7,
                    child: _buildCardView(
                      nextMember,
                      cardWidth,
                      cardHeight,
                      isInteractive: false,
                    ),
                  ),
                ),
              ),

            // Top Card (with swipe gestures)
            Positioned.fill(
              child: _isAnimating
                  ? AnimatedBuilder(
                      animation: _slideAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: _slideAnimation.value,
                          child: Transform.rotate(
                            angle:
                                (_slideAnimation.value.dx / cardWidth) *
                                (math.pi / 12),
                            child: _buildCardView(
                              topMember,
                              cardWidth,
                              cardHeight,
                              isInteractive: false,
                            ),
                          ),
                        );
                      },
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.onTapCard(widget.currentIndex);
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          _dragOffset += details.delta;
                        });
                      },
                      onPanEnd: (details) {
                        final velocity = details.velocity.pixelsPerSecond.dx;
                        if (_dragOffset.dx > 120 || velocity > 800) {
                          _swipeRight();
                        } else if (_dragOffset.dx < -120 || velocity < -800) {
                          _swipeLeft();
                        } else {
                          _snapBack();
                        }
                      },
                      child: Transform.translate(
                        offset: _dragOffset,
                        child: Transform.rotate(
                          angle: (_dragOffset.dx / cardWidth) * (math.pi / 12),
                          child: Stack(
                            children: [
                              _buildCardView(
                                topMember,
                                cardWidth,
                                cardHeight,
                                isInteractive: true,
                              ),

                              // SHORTLIST Stamp (Swipe Right)
                              if (_dragOffset.dx > 20)
                                Positioned(
                                  top: 100,
                                  left: 40,
                                  child: Transform.rotate(
                                    angle: -math.pi / 12,
                                    child: Opacity(
                                      opacity: math.min(
                                        1.0,
                                        (_dragOffset.dx - 20) / 100,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                        ),
                                        child: const Text(
                                          "SHORTLIST",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              // PASS Stamp (Swipe Left)
                              if (_dragOffset.dx < -20)
                                Positioned(
                                  top: 100,
                                  right: 40,
                                  child: Transform.rotate(
                                    angle: math.pi / 12,
                                    child: Opacity(
                                      opacity: math.min(
                                        1.0,
                                        (-_dragOffset.dx - 20) / 100,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                        ),
                                        child: const Text(
                                          "PASS",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
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
          ],
        ),
      ),
    );
  },
);
  }

  Widget _buildCardView(
    MemberListModel member,
    double width,
    double height, {
    required bool isInteractive,
  }) {
    final String image = member.profileImage ?? "";
    final isProtected = member.isPhotoProtected == 1;

    // Parse religion and state for pills (prefer model fields, fallback to subtitle, never show numeric IDs)
    String religion = (member.religion ?? '').toString().trim();
    String stateName = (member.stateName ?? '').toString().trim();

    if (religion.isEmpty || int.tryParse(religion) != null) {
      religion = '';
      final String subtitle = member.subTitle ?? "";
      final parts = subtitle.split(',');
      if (parts.length > 2) {
        final candidate = parts[2].trim();
        if (candidate.isNotEmpty && int.tryParse(candidate) == null) {
          religion = candidate;
        }
      }
    }

    if (stateName.isEmpty || int.tryParse(stateName) != null) {
      stateName = '';
      final String subtitle = member.subTitle ?? "";
      final parts = subtitle.split(',');
      if (parts.length > 4) {
        final candidate = parts[4].trim();
        if (candidate.isNotEmpty && int.tryParse(candidate) == null) {
          stateName = candidate;
        }
      }
    }

    final String key = member.memberId.toString();
    final isShortlisted =
        _localShortlisted[key] ??
        (member.isShortlisted == true ||
            member.isShortlisted?.toString() == "1");
    final isInterested = _localInterested[key] ?? checkIsInterest(member);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Profile Photo
              getImageWidget(url: image, boxFit: BoxFit.cover),

              // Protected Photo Overlay
              if (isProtected)
                Positioned.fill(
                  child: InkWell(
                    onTap: isInteractive
                        ? () => PhotoRequestBottomSheet.show(
                            context,
                            member.memberId.toString(),
                          )
                        : null,
                    child: const ProtectedImageOverlay(
                      blur: 16,
                      lockSize: 50,
                      lockAlignment: Alignment(0, -0.10),
                      borderRadius: 32,
                    ),
                  ),
                ),

              // Bottom Gradient Overlay for text readability
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.95),
                        Colors.black.withValues(alpha: 0.5),
                        Colors.black.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.0, 0.35, 0.55, 0.85],
                    ),
                  ),
                ),
              ),

              // Top Bar circular controls (Online Indicator & More Options)
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Premium Badge if plan_status is "Paid" and showPremiumBadge is true
                    if (checkIsPaid(member) && ref.watch(featureProvider('showPremiumBadge')))
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: FigmaColors.primaryGradient(context),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.figmaPremium,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 18,
                            height: 18,
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 36, height: 36),

                    // More Menu Circle
                    Theme(
                      data: Theme.of(context).copyWith(
                        cardColor: Theme.of(context).colorScheme.surface,
                      ),
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        enabled: isInteractive,
                        icon: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        onSelected: (value) async {
                          if (value == 'block') {
                            final memberId = (member.memberId ?? member.id).toString();
                            _swipeLeft(); // Pass profile on block
                            showToast("profile_blocked_successfully".tr);
                            try {
                              await ref.read(actionRepositoryProvider).toggleBlock(
                                memberId: memberId,
                                isCurrentlyBlocked: false,
                              );
                            } catch (_) {}
                          } else if (value == 'report') {
                            AppRoutes.openReport(
                              context,
                              (member.memberId ?? member.id).toString(),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'block',
                            child: customTextNormalStyle(
                              "block_lbl".tr,
                              15,
                              TextAlign.start,
                              Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          PopupMenuItem(
                            value: 'report',
                            child: customTextNormalStyle(
                              "report_lbl".tr,
                              15,
                              TextAlign.start,
                              Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Match Card Details & Interactive Controls
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. Profile Title
                      Text(
                        (member.profileTitle ?? '').toString(),
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // 2. Profile Subtitle
                      if ((member.subTitle ?? '').toString().isNotEmpty)
                        Text(
                          member.subTitle.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 16),

                      // 3. Horizontal pills row
                      Row(
                        children: [
                          // Pill 1: Location/State
                          if (stateName.isNotEmpty && int.tryParse(stateName) == null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.figmaLocation,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    stateName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],

                          // Pill 2: Religion
                          if (religion.isNotEmpty && int.tryParse(religion) == null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.figmaReligion,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    religion,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],

                          const Spacer(),

                          // Pill 3: Match Percentage Badge (RIGHT SIDE)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: FigmaColors.primaryGradient(context),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'match_percent_suffix'.trParams({
                                'percent':
                                '${() {
                                  final rawRatio = getFieldValue(member, 'matchPercent') ?? getFieldValue(member, 'match_percent') ?? getFieldValue(member, 'match_ratio') ?? getFieldValue(member, 'match_percentage');
                                  if (rawRatio != null && rawRatio.toString().isNotEmpty) {
                                    final parsed = int.tryParse(rawRatio.toString());
                                    if (parsed != null && parsed > 0) return parsed;
                                  }
                                  return 0;
                                }()}',
                              }),
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                    // 4. Overlaid Action Buttons Row (Star, Phone, Heart Hero, Video, Chat)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Button 1: Star (Shortlist toggle)
                        _buildCircleBtn(
                          svgPath: isShortlisted
                              ? AppAssets.figmaShortlistSelected
                              : AppAssets.figmaShortlist,
                          iconColor: isShortlisted
                              ? const Color(0xFFFABE2C)
                              : Colors.white,
                          onTap: isInteractive
                              ? () async {
                                  final isCurrentlyShortlisted = isShortlisted;
                                  setState(() {
                                    _localShortlisted[key] =
                                        !isCurrentlyShortlisted;
                                  });
                                  final success = await ref
                                      .read(actionRepositoryProvider)
                                      .toggleShortlist(
                                        memberId: member.id.toString(),
                                        isCurrentlyShortlisted:
                                            isCurrentlyShortlisted,
                                      );
                                  if (success) {
                                    showToast(
                                      isCurrentlyShortlisted
                                          ? "removed_from_shortlist".tr
                                          : "shortlisted_successfully".tr,
                                    );
                                  } else {
                                    setState(() {
                                      _localShortlisted[key] =
                                          isCurrentlyShortlisted;
                                    });
                                    showToast("action_failed".tr);
                                  }
                                }
                              : () {},
                        ),

                        // Button 2: Voice Call (when enabled) OR Block (when disabled)
                        Builder(
                          builder: (context) {
                            final bool voiceEnabled = ref.watch(featureProvider('enableVoiceCall'));
                            final bool videoEnabled = ref.watch(featureProvider('enableVideoCall'));
                            final bool callsEnabled = voiceEnabled || videoEnabled;

                            if (callsEnabled) {
                              return _buildCircleBtn(
                                svgPath: AppAssets.figmaVoiceCall,
                                iconColor: Colors.white,
                                onTap: isInteractive
                                    ? () => _confirmVoiceCall(member)
                                    : () {},
                              );
                            } else {
                              return _buildCircleBtn(
                                iconData: Icons.block_rounded,
                                iconColor: Colors.white,
                                onTap: isInteractive
                                    ? () => ProfileCardActionHandler.toggleBlock(
                                          context: context,
                                          ref: ref,
                                          memberModel: member,
                                          onUpdated: (updated) {
                                            if (updated.isBlock == 1) {
                                              _swipeLeft();
                                            }
                                          },
                                        )
                                    : () {},
                              );
                            }
                          },
                        ),

                        // Button 3 (Center): Heart Hero Button (Express Interest / Swipe Right)
                        Builder(
                          builder: (context) {
                            final theme = Theme.of(context);
                            final primaryGradient = FigmaColors.primaryGradient(context);
                            final bool isAcc = checkIsInterestAccepted(member);
                            final bool isRej = checkIsInterestRejected(member);
                            final bool isInt =
                                isInterested || checkIsInterest(member);

                            List<Color> gradColors;
                            Color shColor;
                            Widget icWidget;

                            if (isAcc) {
                              gradColors = const [
                                Color(0xFF10B981),
                                Color(0xFF059669),
                              ];
                              shColor = const Color(
                                0xFF10B981,
                              ).withValues(alpha: 0.40);
                              icWidget = const Icon(
                                Icons.favorite_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                            } else if (isRej) {
                              gradColors = const [
                                Color(0xFFEF4444),
                                Color(0xFFDC2626),
                              ];
                              shColor = const Color(
                                0xFFEF4444,
                              ).withValues(alpha: 0.40);
                              icWidget = const Icon(
                                Icons.favorite_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                            } else if (isInt) {
                              gradColors = [
                                primaryGradient.colors.first,
                                primaryGradient.colors.last,
                              ];
                              shColor = theme.primaryColor.withValues(
                                alpha: 0.45,
                              );
                              icWidget = const Icon(
                                Icons.favorite_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                            } else {
                              gradColors = [
                                primaryGradient.colors.first,
                                primaryGradient.colors.last,
                              ];
                              shColor = theme.primaryColor.withValues(
                                alpha: 0.45,
                              );
                              icWidget = SvgPicture.asset(
                                AppAssets.figmaSendInterest,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                                width: 28,
                                height: 28,
                              );
                            }

                            return GestureDetector(
                              onTap: isInteractive
                                  ? () async {
                                      if (isInt) {
                                        showToast("already_sent_connection_error".tr);
                                        _swipeLeft();
                                        return;
                                      }
                                      setState(() {
                                        _localInterested[key] = true;
                                      });
                                      final result = await ref
                                          .read(actionRepositoryProvider)
                                          .sendInterest(
                                            receiverMemberId: member.memberId
                                                .toString(),
                                          );
                                      if (!context.mounted) return;
                                      handleInterestResult(
                                        context: context,
                                        mounted: mounted,
                                        result: result,
                                        onSuccess: () {
                                          _swipeLeft();
                                        },
                                      );
                                      if (result is! InterestSuccess) {
                                        setState(() {
                                          _localInterested[key] = false;
                                        });
                                      }
                                    }
                                  : null,
                              child: Container(
                                height: 58,
                                width: 58,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradColors,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: shColor,
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(child: icWidget),
                              ),
                            );
                          },
                        ),

                        // Button 4: Video call (when enabled) OR Chat (when disabled)
                        Builder(
                          builder: (context) {
                            final bool voiceEnabled = ref.watch(featureProvider('enableVoiceCall'));
                            final bool videoEnabled = ref.watch(featureProvider('enableVideoCall'));
                            final bool callsEnabled = voiceEnabled || videoEnabled;

                            if (callsEnabled) {
                              return _buildCircleBtn(
                                svgPath: AppAssets.figmaVideoCall,
                                iconColor: Colors.white,
                                onTap: isInteractive
                                    ? () => _confirmVideoCall(member)
                                    : () {},
                              );
                            } else {
                              return _buildCircleBtn(
                                svgPath: AppAssets.figmaChat,
                                iconColor: Colors.white,
                                onTap: isInteractive
                                    ? () async {
                                        final hasAccess = await checkChatPermission(context, ref);
                                        if (!hasAccess || !context.mounted) return;

                                        context.push(
                                          '/chat-conversation/${member.memberId}',
                                          extra: {
                                            'receiverName': member.profileTitle,
                                            'receiverPhoto': member.profileImage,
                                          },
                                        );
                                      }
                                    : () {},
                              );
                            }
                          },
                        ),

                        // Button 5: Message Chat (when enabled) OR View (when disabled)
                        Builder(
                          builder: (context) {
                            final bool voiceEnabled = ref.watch(featureProvider('enableVoiceCall'));
                            final bool videoEnabled = ref.watch(featureProvider('enableVideoCall'));
                            final bool callsEnabled = voiceEnabled || videoEnabled;

                            if (callsEnabled) {
                              return _buildCircleBtn(
                                svgPath: AppAssets.figmaChat,
                                iconColor: Colors.white,
                                onTap: isInteractive
                                    ? () async {
                                        final hasAccess = await checkChatPermission(context, ref);
                                        if (!hasAccess || !context.mounted) return;

                                        context.push(
                                          '/chat-conversation/${member.memberId}',
                                          extra: {
                                            'receiverName': member.profileTitle,
                                            'receiverPhoto': member.profileImage,
                                          },
                                        );
                                      }
                                    : () {},
                              );
                            } else {
                              return _buildCircleBtn(
                                iconData: Icons.visibility_rounded,
                                iconColor: Colors.white,
                                onTap: isInteractive
                                    ? () => widget.onTapCard(widget.currentIndex)
                                    : () {},
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleBtn({
    String? svgPath,
    IconData? iconData,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Center(
          child: iconData != null
              ? Icon(
                  iconData,
                  color: iconColor,
                  size: 20,
                )
              : (svgPath != null
                  ? SvgPicture.asset(
                      svgPath,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    )
                  : const SizedBox.shrink()),
        ),
      ),
    );
  }
}
