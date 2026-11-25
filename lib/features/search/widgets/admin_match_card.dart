import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../features/common/data/models/member_models.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/photo_protected_widget.dart';
import '../../../widgets/photo_request_bottom_sheet.dart';
import '../../../widgets/profile_cards/profile_card_action_handler.dart';
import '../providers/matches_notifier.dart';

/// Modern, dynamic card for "Match From Admin" supporting both List and Grid layouts.
/// Uses brand gradients and theme-aware colors with zero static hardcoding.
class AdminMatchCard extends ConsumerStatefulWidget {
  final MemberListModel member;
  final MatchType matchType;
  final bool isGrid;
  final Function(MemberListModel updated)? onActionComplete;

  const AdminMatchCard({
    super.key,
    required this.member,
    required this.matchType,
    required this.isGrid,
    this.onActionComplete,
  });

  @override
  ConsumerState<AdminMatchCard> createState() => _AdminMatchCardState();
}

class _AdminMatchCardState extends ConsumerState<AdminMatchCard> {
  bool _isLoading = false;
  String? _loadingAction; // "accept" for accept, "reject" for reject

  Future<void> _handleAction(String action) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _loadingAction = action;
    });

    try {
      final matchId = widget.member.id?.toString() ??
          widget.member.memberId?.toString() ??
          "";
      await ref
          .read(matchesProvider(widget.matchType).notifier)
          .updateMatchAction(matchId, action);

      final isAccept = action == "1" || action == "accept";
      showToast(isAccept
          ? 'match_request_accepted'.tr
          : 'match_request_rejected'.tr);

      final updated = widget.member.copyWith(
        response: isAccept ? 1 : 2,
      );
      widget.onActionComplete?.call(updated);
    } catch (e) {
      showToast("${'action_failed'.tr}: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingAction = null;
        });
      }
    }
  }

  void _viewProfile(BuildContext context) {
    final targetId = (widget.member.receiverMemberId ??
            widget.member.memberId ??
            widget.member.id)
        ?.toString() ??
        "";
    if (targetId.isNotEmpty) {
      AppRoutes.openProfile(context, targetId);
    } else {
      ProfileCardActionHandler.viewProfile(context, widget.member);
    }
  }

  void _onPhotoTap(BuildContext context, bool isProtected, String memberId) {
    if (isProtected) {
      PhotoRequestBottomSheet.show(context, memberId);
    } else {
      _viewProfile(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    final primaryColor = config.primaryColor;
    final accentColor = config.accentColor;
    final gradientStart = config.gradientStart;
    final gradientEnd = config.gradientEnd;

    final member = widget.member;
    final memberId = (member.receiverMemberId ?? member.memberId ?? member.id).toString();
    final isProtected = checkIsPhotoProtected(member);

    final title = member.profileTitle?.toString().trim().isNotEmpty == true
        ? member.profileTitle.toString()
        : member.fullname?.toString().trim().isNotEmpty == true
            ? member.fullname.toString()
            : 'N/A';

    final subTitle = member.subTitle?.toString().trim().isNotEmpty == true
        ? member.subTitle.toString()
        : [
            member.cityName,
            member.religion,
          ].where((e) => e != null && e.toString().trim().isNotEmpty).join(' · ');

    final photoUrl = (member.profileImage?.toString().trim().isNotEmpty == true)
        ? member.profileImage.toString()
        : (member.photo1?.toString().trim().isNotEmpty == true)
            ? member.photo1.toString()
            : "";

    final responseVal = member.response; // 0/null = Pending, 1 = Accept, 2 = Reject
    final isPending = responseVal == null ||
        responseVal == 0 ||
        responseVal.toString() == "0";
    final isAccepted = responseVal == 1 || responseVal.toString() == "1";
    final isRejected = responseVal == 2 || responseVal.toString() == "2";

    if (widget.isGrid) {
      return _buildGridCard(
        context: context,
        theme: theme,
        isDark: isDark,
        primaryColor: primaryColor,
        gradientStart: gradientStart,
        gradientEnd: gradientEnd,
        memberId: memberId,
        isProtected: isProtected,
        title: title,
        subTitle: subTitle,
        photoUrl: photoUrl,
        isPending: isPending,
        isAccepted: isAccepted,
        isRejected: isRejected,
      );
    }

    return _buildListCard(
      context: context,
      theme: theme,
      isDark: isDark,
      primaryColor: primaryColor,
      accentColor: accentColor,
      gradientStart: gradientStart,
      gradientEnd: gradientEnd,
      memberId: memberId,
      isProtected: isProtected,
      title: title,
      subTitle: subTitle,
      photoUrl: photoUrl,
      isPending: isPending,
      isAccepted: isAccepted,
      isRejected: isRejected,
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // LIST VIEW CARD (Horizontal, rich gradients, dynamic colors, zero awkward wrap)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildListCard({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required Color primaryColor,
    required Color accentColor,
    required Color gradientStart,
    required Color gradientEnd,
    required String memberId,
    required bool isProtected,
    required String title,
    required String subTitle,
    required String photoUrl,
    required bool isPending,
    required bool isAccepted,
    required bool isRejected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  theme.colorScheme.surface,
                  Color.alphaBlend(
                    primaryColor.withValues(alpha: 0.08),
                    theme.colorScheme.surface,
                  ),
                ]
              : [
                  theme.colorScheme.surface,
                  Color.alphaBlend(
                    primaryColor.withValues(alpha: 0.03),
                    theme.colorScheme.surface,
                  ),
                ],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : primaryColor.withValues(alpha: 0.12),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : primaryColor.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _viewProfile(context),
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Avatar + Info + Status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo with dynamic gradient ring (taps open photo request if protected)
                  GestureDetector(
                    onTap: () => _onPhotoTap(context, isProtected, memberId),
                    child: Container(
                      width: 76,
                      height: 76,
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [gradientStart, gradientEnd],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17.5),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            getImageWidget(
                              url: photoUrl,
                              boxFit: BoxFit.cover,
                              imageWidth: 72,
                              imageHeight: 72,
                              isProtected: isProtected,
                              targetGender: widget.member.gender,
                            ),
                            if (isProtected)
                              const Positioned.fill(
                                child: ProtectedImageOverlay(
                                  blur: 10,
                                  lockSize: 22,
                                  borderRadius: 17.5,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(14),
                  // Member details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFont.font(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const Gap(8),
                            _buildStatusBadge(
                              isPending: isPending,
                              isAccepted: isAccepted,
                              isRejected: isRejected,
                              isCompact: true,
                            ),
                          ],
                        ),
                        const Gap(5),
                        Text(
                          subTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.font(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.65),
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(6),
                        // Curated matchmaker pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.auto_awesome_rounded,
                                size: 11,
                                color: primaryColor,
                              ),
                              const Gap(4),
                              Text(
                                'match_from_admin'.tr,
                                style: AppFont.font(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Gap(14),

              // Action Section (Pending Buttons or Finalized Status Ribbon)
              if (isPending) ...[
                Row(
                  children: [
                    // Reject Button
                    Expanded(
                      flex: 2,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _isLoading ? null : () => _handleAction("reject"),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : theme.colorScheme.onSurface
                                        .withValues(alpha: 0.15),
                              ),
                            ),
                            child: Center(
                              child: _isLoading && (_loadingAction == "reject" || _loadingAction == "2")
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xFFEF4444)),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.close_rounded,
                                          size: 16,
                                          color: isDark
                                              ? Colors.white70
                                              : theme.colorScheme.onSurface
                                                  .withValues(alpha: 0.7),
                                        ),
                                        const Gap(5),
                                        Text(
                                          'btn_reject'.tr,
                                          style: AppFont.font(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? Colors.white70
                                                : theme.colorScheme.onSurface
                                                    .withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    // Accept Button with Dynamic Brand Gradient
                    Expanded(
                      flex: 3,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _isLoading ? null : () => _handleAction("accept"),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [gradientStart, gradientEnd],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: gradientStart.withValues(alpha: 0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: _isLoading && (_loadingAction == "accept" || _loadingAction == "1")
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.favorite_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        const Gap(6),
                                        Text(
                                          'accept_lbl'.tr,
                                          style: AppFont.font(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
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
              ] else ...[
                // Finalized Status Ribbon (Accepted / Rejected)
                InkWell(
                  onTap: () => _viewProfile(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isAccepted
                          ? const Color(0xFF10B981).withValues(alpha: 0.1)
                          : const Color(0xFFEF4444).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isAccepted
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          size: 16,
                          color: isAccepted
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                        const Gap(6),
                        Expanded(
                          child: Text(
                            isAccepted ? 'accepted_lbl'.tr : 'rejected_lbl'.tr,
                            style: AppFont.font(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isAccepted
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                            ),
                          ),
                        ),
                        Text(
                          'view_profile'.tr,
                          style: AppFont.font(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                        const Gap(2),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 11,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // GRID VIEW CARD (Vertical, fits 2-column grid, zero overflow, rich gradient)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildGridCard({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required Color primaryColor,
    required Color gradientStart,
    required Color gradientEnd,
    required String memberId,
    required bool isProtected,
    required String title,
    required String subTitle,
    required String photoUrl,
    required bool isPending,
    required bool isAccepted,
    required bool isRejected,
  }) {
    return GestureDetector(
      onTap: () => _viewProfile(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo Background
              getImageWidget(
                url: photoUrl,
                boxFit: BoxFit.cover,
                imageWidth: double.infinity,
                imageHeight: double.infinity,
                isProtected: isProtected,
                targetGender: widget.member.gender,
              ),

              if (isProtected)
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _onPhotoTap(context, isProtected, memberId),
                    child: const ProtectedImageOverlay(
                      blur: 14,
                      lockSize: 32,
                      borderRadius: 22,
                    ),
                  ),
                ),

              // Gradient Scrim Overlay for high contrast
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.45),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.65),
                        Colors.black.withValues(alpha: 0.95),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.28, 0.65, 1.0],
                    ),
                  ),
                ),
              ),

              // Top Floating Badges
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status Badge
                    _buildStatusBadge(
                      isPending: isPending,
                      isAccepted: isAccepted,
                      isRejected: isRejected,
                      isCompact: true,
                    ),
                    // Matchmaker Star Icon
                    Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          size: 14,
                          color: gradientStart,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Info & Actions
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _viewProfile(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const Gap(8),

                    // Grid Action Buttons (Zero Overflow)
                    if (isPending) ...[
                      Row(
                        children: [
                          // Compact Reject Icon Button
                          GestureDetector(
                            onTap: _isLoading ? null : () => _handleAction("reject"),
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.45),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.25),
                                ),
                              ),
                              child: Center(
                                child: _isLoading && (_loadingAction == "reject" || _loadingAction == "2")
                                    ? const SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.close_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                          const Gap(6),
                          // Expanded Accept Button with Brand Gradient
                          Expanded(
                            child: GestureDetector(
                              onTap:
                                  _isLoading ? null : () => _handleAction("accept"),
                              child: Container(
                                height: 34,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [gradientStart, gradientEnd],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(17),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          gradientStart.withValues(alpha: 0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: _isLoading && (_loadingAction == "accept" || _loadingAction == "1")
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.check_rounded,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            const Gap(3),
                                            Flexible(
                                              child: Text(
                                                'accept_lbl'.tr,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    AppFont.font(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
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
                    ] else ...[
                      // Accepted / Rejected status ribbon in Grid
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isAccepted
                                ? const [Color(0xFF10B981), Color(0xFF059669)]
                                : const [Color(0xFFEF4444), Color(0xFFDC2626)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isAccepted
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                              const Gap(4),
                              Flexible(
                                child: Text(
                                  isAccepted
                                      ? 'accepted_lbl'.tr
                                      : 'rejected_lbl'.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFont.font(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  // ───────────────────────────────────────────────────────────────────────────
  // DYNAMIC STATUS BADGE (Warm Amber / Emerald Green / Soft Coral)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildStatusBadge({
    required bool isPending,
    required bool isAccepted,
    required bool isRejected,
    bool isCompact = false,
  }) {
    List<Color> gradientColors;
    IconData icon;
    String label;

    if (isAccepted) {
      gradientColors = const [Color(0xFF10B981), Color(0xFF059669)];
      icon = Icons.check_circle_rounded;
      label = 'accepted_lbl'.tr;
    } else if (isRejected) {
      gradientColors = const [Color(0xFFEF4444), Color(0xFFDC2626)];
      icon = Icons.cancel_rounded;
      label = 'rejected_lbl'.tr;
    } else {
      gradientColors = const [Color(0xFFF59E0B), Color(0xFFD97706)];
      icon = Icons.schedule_rounded;
      label = 'pending_lbl'.tr;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 7 : 9,
        vertical: isCompact ? 3.5 : 4.5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isCompact ? 10.5 : 12,
            color: Colors.white,
          ),
          const Gap(3.5),
          Text(
            label.toUpperCase(),
            style: AppFont.font(
              color: Colors.white,
              fontSize: isCompact ? 9 : 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
