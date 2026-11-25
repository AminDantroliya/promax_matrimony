import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../features/common/data/models/member_models.dart';
import '../../utils/permission_utils.dart';
import '../../utils/utils.dart';
import 'profile_card_action_handler.dart';

enum ProfileCardActionStyle {
  glass,
  light,
  circle,
  list,
}

class ProfileCardActionButtons extends ConsumerWidget {
  final MemberListModel memberModel;
  final ProfileCardActionStyle style;
  final Function(MemberListModel updatedMember)? onActionComplete;

  // Optional direct callback overrides (used by list card or custom screens)
  final VoidCallback? onShortlist;
  final VoidCallback? onAudioCall;
  final VoidCallback? onVideoCall;
  final VoidCallback? onChat;
  final VoidCallback? onInterest;
  final VoidCallback? onViewProfile;
  final VoidCallback? onBlock;

  const ProfileCardActionButtons({
    super.key,
    required this.memberModel,
    this.style = ProfileCardActionStyle.glass,
    this.onActionComplete,
    this.onShortlist,
    this.onAudioCall,
    this.onVideoCall,
    this.onChat,
    this.onInterest,
    this.onViewProfile,
    this.onBlock,
  });

  bool get _isShortlisted =>
      checkIsShortlisted(memberModel) ||
      memberModel.isShortlisted == "1" ||
      memberModel.isShortlisted == 1 ||
      memberModel.isShortlisted == true ||
      memberModel.isShortlisted == "Yes";

  bool get _isInterestSent =>
      memberModel.interestState == "sent" ||
      memberModel.interestStatus == "sent" ||
      checkIsInterest(memberModel);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    final bool voiceEnabled = ref.watch(featureProvider('enableVoiceCall'));
    final bool videoEnabled = ref.watch(featureProvider('enableVideoCall'));
    final bool callsEnabled = voiceEnabled || videoEnabled;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildShortlistButton(context, ref, primaryColor),
        _buildCallOrBlockButton(context, ref, primaryColor, callsEnabled),
        _buildHeartBtn(
          context: context,
          ref: ref,
          primaryColor: primaryColor,
          isInterestSent: _isInterestSent,
        ),
        _buildVideoOrChatButton(context, ref, primaryColor, callsEnabled),
        _buildChatOrViewButton(context, ref, primaryColor, callsEnabled),
      ],
    );
  }

  Widget _buildShortlistButton(BuildContext context, WidgetRef ref, Color primaryColor) {
    return _buildActionBtn(
      svgPath: _isShortlisted
          ? AppAssets.figmaShortlistSelected
          : AppAssets.figmaShortlist,
      iconColor: _isShortlisted
          ? const Color(0xFFFABE2C)
          : _defaultIconColor(primaryColor),
      onTap: onShortlist ??
          () => ProfileCardActionHandler.toggleShortlist(
                context: context,
                ref: ref,
                memberModel: memberModel,
                onUpdated: onActionComplete,
              ),
    );
  }

  Widget _buildCallOrBlockButton(
    BuildContext context,
    WidgetRef ref,
    Color primaryColor,
    bool callsEnabled,
  ) {
    if (callsEnabled) {
      return _buildActionBtn(
        svgPath: AppAssets.figmaVoiceCall,
        iconColor: style == ProfileCardActionStyle.light
            ? const Color(0xFF22C55E)
            : Colors.white,
        onTap: onAudioCall != null
            ? () async {
                final granted = await checkAndRequestCallPermissions(
                  isVideo: false,
                );
                if (granted) onAudioCall!();
              }
            : () => ProfileCardActionHandler.makeVoiceCall(
                  context,
                  ref,
                  memberModel,
                ),
      );
    }
    return _buildActionBtn(
      icon: Icons.block_rounded,
      iconColor: _defaultIconColor(primaryColor),
      onTap: onBlock ??
          () => ProfileCardActionHandler.toggleBlock(
                context: context,
                ref: ref,
                memberModel: memberModel,
                onUpdated: onActionComplete,
              ),
    );
  }

  Widget _buildVideoOrChatButton(
    BuildContext context,
    WidgetRef ref,
    Color primaryColor,
    bool callsEnabled,
  ) {
    if (callsEnabled) {
      return _buildActionBtn(
        svgPath: AppAssets.figmaVideoCall,
        iconColor: _defaultIconColor(primaryColor),
        onTap: onVideoCall != null
            ? () async {
                final granted = await checkAndRequestCallPermissions(
                  isVideo: true,
                );
                if (granted) onVideoCall!();
              }
            : () => ProfileCardActionHandler.makeVideoCall(
                  context,
                  ref,
                  memberModel,
                ),
      );
    }
    return _buildActionBtn(
      svgPath: AppAssets.figmaChat,
      iconColor: _defaultIconColor(primaryColor),
      onTap: onChat ??
          () => ProfileCardActionHandler.openChat(
                context,
                ref,
                memberModel,
              ),
    );
  }

  Widget _buildChatOrViewButton(
    BuildContext context,
    WidgetRef ref,
    Color primaryColor,
    bool callsEnabled,
  ) {
    if (callsEnabled) {
      return _buildActionBtn(
        svgPath: AppAssets.figmaChat,
        iconColor: _defaultIconColor(primaryColor),
        onTap: onChat ??
            () => ProfileCardActionHandler.openChat(
                  context,
                  ref,
                  memberModel,
                ),
      );
    }
    return _buildActionBtn(
      icon: Icons.visibility_rounded,
      iconColor: _defaultIconColor(primaryColor),
      onTap: onViewProfile ??
          () => ProfileCardActionHandler.viewProfile(
                context,
                memberModel,
              ),
    );
  }

  Color _defaultIconColor(Color primaryColor) {
    switch (style) {
      case ProfileCardActionStyle.light:
        return primaryColor;
      case ProfileCardActionStyle.glass:
      case ProfileCardActionStyle.circle:
      case ProfileCardActionStyle.list:
        return Colors.white;
    }
  }

  Widget _buildActionBtn({
    String? svgPath,
    IconData? icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    double size = 46;
    BoxDecoration decoration;

    switch (style) {
      case ProfileCardActionStyle.glass:
        size = 48;
        decoration = BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        );
        break;
      case ProfileCardActionStyle.light:
        size = 44;
        decoration = const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        );
        break;
      case ProfileCardActionStyle.circle:
      case ProfileCardActionStyle.list:
        size = 46;
        decoration = BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        );
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: decoration,
        child: Center(
          child: svgPath != null
              ? SvgPicture.asset(
                  svgPath,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  width: 20,
                  height: 20,
                )
              : Icon(icon, color: iconColor, size: 20),
        ),
      ),
    );
  }

  Widget _buildHeartBtn({
    required BuildContext context,
    required WidgetRef ref,
    required Color primaryColor,
    required bool isInterestSent,
  }) {
    final bool isAccepted = checkIsInterestAccepted(memberModel);
    final bool isRejected = checkIsInterestRejected(memberModel);

    double heartSize;
    double iconSize;
    Color buttonColor;
    Color shadowColor;
    Widget heartIcon;

    if (style == ProfileCardActionStyle.list) {
      heartSize = 62;
      iconSize = 30;
      List<Color> gradientColors;

      if (isAccepted) {
        gradientColors = const [Color(0xFF10B981), Color(0xFF059669)];
        shadowColor = const Color(0xFF10B981).withValues(alpha: 0.35);
        heartIcon = Icon(Icons.favorite_rounded, color: Colors.white, size: iconSize);
      } else if (isRejected) {
        gradientColors = const [Color(0xFFEF4444), Color(0xFFDC2626)];
        shadowColor = const Color(0xFFEF4444).withValues(alpha: 0.35);
        heartIcon = Icon(Icons.favorite_rounded, color: Colors.white, size: iconSize);
      } else if (isInterestSent) {
        gradientColors = [
          FigmaColors.primaryGradient(context).colors.first,
          FigmaColors.primaryGradient(context).colors.last,
        ];
        shadowColor = Theme.of(context).primaryColor.withValues(alpha: 0.35);
        heartIcon = Icon(Icons.favorite_rounded, color: Colors.white, size: iconSize);
      } else {
        gradientColors = [
          FigmaColors.primaryGradient(context).colors.first,
          FigmaColors.primaryGradient(context).colors.last,
        ];
        shadowColor = Theme.of(context).primaryColor.withValues(alpha: 0.35);
        heartIcon = SvgPicture.asset(
          AppAssets.figmaSendInterest,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 26,
          height: 26,
        );
      }

      return InkWell(
        onTap: onInterest ??
            () => ProfileCardActionHandler.sendInterest(
                  context: context,
                  ref: ref,
                  memberModel: memberModel,
                  onUpdated: onActionComplete,
                ),
        child: Container(
          width: heartSize,
          height: heartSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: gradientColors),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(child: heartIcon),
        ),
      );
    }

    // Standard Cards: glass (54), light (52), circle (56)
    switch (style) {
      case ProfileCardActionStyle.glass:
        heartSize = 54;
        iconSize = 26;
        break;
      case ProfileCardActionStyle.light:
        heartSize = 52;
        iconSize = 24;
        break;
      case ProfileCardActionStyle.circle:
      default:
        heartSize = 56;
        iconSize = 28;
        break;
    }

    buttonColor = isInterestSent ? const Color(0xFF22C55E) : primaryColor;
    shadowColor = buttonColor.withValues(alpha: 0.35);

    return GestureDetector(
      onTap: onInterest ??
          () => ProfileCardActionHandler.sendInterest(
                context: context,
                ref: ref,
                memberModel: memberModel,
                onUpdated: onActionComplete,
              ),
      child: Container(
        height: heartSize,
        width: heartSize,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            isInterestSent ? Icons.check_rounded : Icons.favorite_rounded,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
