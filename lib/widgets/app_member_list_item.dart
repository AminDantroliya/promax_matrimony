import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';

import '../app_theme/size_config.dart';
import '../features/common/data/models/member_models.dart';
import '../features/common/data/repositories/action_repository.dart';
import '../features/home/providers/dashboard_notifier.dart';
import '../utils/app_routes.dart';
import '../utils/permission_utils.dart';
import '../utils/utils.dart';
import 'photo_request_bottom_sheet.dart';
import 'image_widget.dart';

class AppMemberListItem extends ConsumerStatefulWidget {
  final MemberListModel memberModel;
  final int? index;
  final int design;

  const AppMemberListItem({
    super.key,
    required this.memberModel,
    this.index,
    required this.design,
  });

  @override
  ConsumerState<AppMemberListItem> createState() => _CommonMemberListItemState();
}

class _CommonMemberListItemState extends ConsumerState<AppMemberListItem> {
  late MemberListModel memberModel;

  @override
  void initState() {
    super.initState();
    memberModel = widget.memberModel;
  }

  @override
  void didUpdateWidget(AppMemberListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.memberModel != widget.memberModel) {
      memberModel = widget.memberModel;
    }
  }
  
  // Shared Action Methods
  Future<void> _handleShortlist() async {
    final isShortlisted = checkIsShortlisted(memberModel);
    final success = await withLoading(
      context,
      () => ref.read(actionRepositoryProvider).toggleShortlist(
        memberId: memberModel.id.toString(),
        isCurrentlyShortlisted: isShortlisted,
      ),
    );
    if (success) {
      setState(() {
        memberModel = memberModel.copyWith(
          isShortlisted: isShortlisted ? "0" : "1",
        );
      });
      ref.read(dashboardProvider.notifier).updateMemberShortlist(
        (memberModel.id ?? memberModel.memberId).toString(),
        !isShortlisted,
      );
    }
  }

  Future<void> _handleInterest() async {
    if (widget.design == 2) showLoading(context);
    final result = await ref.read(actionRepositoryProvider).sendInterest(
      receiverMemberId: memberModel.id.toString(),
    );
    if (widget.design == 2) hideLoading();

    if (!mounted) return;
    handleInterestResult(
      context: context,
      mounted: mounted,
      result: result,
      onSuccess: () => setState(() {
        memberModel = memberModel.copyWith(interestState: "sent");
      }),
    );
  }

  void _handleChat() async {
    final hasAccess = await checkChatPermission(context, ref);
    if (!hasAccess || !mounted) return;

    context.push(
      '/chat-conversation/${memberModel.memberId}',
      extra: {
        'receiverName': memberModel.profileTitle ?? "User",
        'receiverPhoto': memberModel.profileImage,
      },
    );
  }

  void _handleProfile() {
    context.push('/profile-other/${memberModel.memberId}');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.design == 1) {
      return _buildDesign1();
    } else {
      return _buildDesign2();
    }
  }

  // --- Design 1 Implementation ---
  Widget _buildDesign1() {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(8),
        right: getProportionateScreenWidth(8),
        top: getProportionateScreenWidth(10),
      ),
      child: Stack(
        children: [
          _buildImageSection(500, 15),
          _buildImageGradient(150, gradientImage),
          _buildMemberDetailsDesign1(),
          _buildBottomActionsDesign1(),
        ],
      ),
    );
  }

  Widget _buildMemberDetailsDesign1() {
    return Positioned(
      top: getProportionateScreenWidth(15),
      left: getProportionateScreenWidth(15),
      right: getProportionateScreenWidth(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextBoldStyle(
                  "${memberModel.profileTitle}",
                  getProportionateScreenWidth(20),
                  TextAlign.start,
                  Colors.white,
                ),
                customTextNormalStyle(
                  "${memberModel.subTitle}",
                  getProportionateScreenWidth(13),
                  TextAlign.start,
                  Colors.white.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
          if (checkIsPaid(memberModel) && ref.watch(featureProvider('showPremiumBadge'))) _buildPremiumTag(),
        ],
      ),
    );
  }

  Widget _buildBottomActionsDesign1() {
    return Positioned(
      left: getProportionateScreenWidth(15),
      right: getProportionateScreenWidth(15),
      bottom: getProportionateScreenWidth(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _circleActionBtn(
            svgAsset: checkIsShortlisted(memberModel)
                ? AppAssets.figmaShortlistSelected
                : AppAssets.figmaShortlist,
            svgColor: checkIsShortlisted(memberModel)
                ? const Color(0xFFFABE2C)
                : Colors.white,
            gradient: gradientLike,
            onTap: _handleShortlist,
          ),
          _circleActionBtn(
            icon: checkIsInterest(memberModel) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            gradient: gradientPrimary,
            size: 50,
            onTap: _handleInterest,
          ),
          _circleActionBtn(
            svgAsset: AppAssets.figmaChat,
            gradient: gradientMessage,
            onTap: _handleChat,
            padding: 9,
          ),
        ],
      ),
    );
  }

  // --- Design 2 Implementation ---
  Widget _buildDesign2() {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(8),
        right: getProportionateScreenWidth(8),
        bottom: getProportionateScreenWidth(10),
      ),
      child: Stack(
        children: [
          _buildImageSection(450, 15, marginBottom: 40),
          _buildTopActionsDesign2(),
          _buildMemberDetailsDesign2(),
          _buildBottomActionsDesign2(),
        ],
      ),
    );
  }

  Widget _buildTopActionsDesign2() {
    return Positioned(
      top: getProportionateScreenWidth(10),
      right: getProportionateScreenWidth(10),
      child: Container(
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          border: Border.all(width: 1, color: Colors.white.withValues(alpha: 0.2)),
          shape: BoxShape.circle,
        ),
        child: _buildPopupMenu(),
      ),
    );
  }

  Widget _buildMemberDetailsDesign2() {
    return Positioned(
      bottom: getProportionateScreenWidth(90),
      left: getProportionateScreenWidth(15),
      right: getProportionateScreenWidth(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customTextBoldStyle("${memberModel.profileTitle}", getProportionateScreenWidth(20), TextAlign.center, Colors.white),
          const Gap(5),
          customTextNormalStyle("${memberModel.subTitle}", getProportionateScreenWidth(13), TextAlign.center, Colors.white.withValues(alpha: 0.8)),
        ],
      ),
    );
  }

  Widget _buildBottomActionsDesign2() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: getProportionateScreenWidth(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _borderedActionBtn(
            svgAsset: checkIsShortlisted(memberModel)
                ? AppAssets.figmaShortlistSelected
                : AppAssets.figmaShortlist,
            svgColor: checkIsShortlisted(memberModel)
                ? const Color(0xFFFABE2C)
                : Colors.white,
            onTap: _handleShortlist,
          ),
          _borderedActionBtn(
            icon: checkIsInterest(memberModel) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            bgColor: Colors.red,
            iconColor: Colors.white,
            onTap: _handleInterest,
          ),
          _borderedActionBtn(
            svgAsset: AppAssets.figmaChat,
            onTap: _handleChat,
            svgColor: appPrimaryColor,
          ),
        ],
      ),
    );
  }

  // --- Shared UI Components ---

  Widget _buildImageSection(double height, double radius, {double marginBottom = 0}) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Stack(
        children: [
          InkWell(
            onTap: _handleProfile,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Container(
              width: SizeConfig.screenWidth,
              height: getProportionateScreenWidth(height),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(radius),
                border: widget.design == 1 ? Border.all(width: 1, color: Theme.of(context).dividerColor.withValues(alpha: 0.1)) : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: getImageWidget(
                  url: getDisplayString(memberModel.profileImage, defaultValue: ""),
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (widget.design == 2) _buildImageGradient(200, gradientImage2, bottom: 0),
          _buildProtectedOverlay(height, radius),
        ],
      ),
    );
  }

  Widget _buildProtectedOverlay(double height, double radius) {
    final isProtected = checkIsPhotoProtected(memberModel) &&
        getDisplayString(memberModel.profileImage, defaultValue: "") != "";
    
    return Visibility(
      visible: isProtected,
      child: InkWell(
        onTap: () {
          PhotoRequestBottomSheet.show(
            context,
            memberModel.memberId.toString(),
          );
        },
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: ProtectedImageOverlay(height: height, borderRadius: radius),
      ),
    );
  }

  Widget _buildImageGradient(double height, Gradient gradient, {double? top, double? bottom}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: 0,
      right: 0,
      child: Container(
        width: SizeConfig.screenWidth,
        height: getProportionateScreenWidth(height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(top == 0 ? 15 : 0),
            topRight: Radius.circular(top == 0 ? 15 : 0),
            bottomLeft: Radius.circular(bottom == 0 ? 15 : 0),
            bottomRight: Radius.circular(bottom == 0 ? 15 : 0),
          ),
          gradient: gradient,
        ),
      ),
    );
  }

  Widget _buildPremiumTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: FigmaColors.primaryGradient(context),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.figmaPremium,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 14,
            height: 14,
          ),
          const Gap(4),
          customTextNormalStyle("Premium", getProportionateScreenWidth(12), TextAlign.start, Colors.white),
        ],
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_horiz_outlined, color: Colors.white, size: getProportionateScreenWidth(25)),
      onSelected: (value) {
        if (value == 1) {
          final isBlocked = checkIsBlocked(memberModel);
          _addRemoveBlockRequest(isBlocked);
        } else if (value == 2) {
          AppRoutes.openReport(context, memberModel.memberId.toString());
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: customTextNormalStyle(
            checkIsBlocked(memberModel) ? "unblock".tr : "block".tr,
            getProportionateScreenWidth(15),
            TextAlign.start,
            Theme.of(context).colorScheme.onSurface,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: customTextNormalStyle("raise_complaint".tr, getProportionateScreenWidth(15), TextAlign.start, Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }

  Future<void> _addRemoveBlockRequest(bool isCurrentlyBlocked) async {
    final success = await withLoading(
      context,
      () => ref.read(actionRepositoryProvider).toggleBlock(
        memberId: memberModel.memberId.toString(),
        isCurrentlyBlocked: isCurrentlyBlocked,
      ),
    );
    if (success) {
      setState(() {
        memberModel = memberModel.copyWith(
          isBlock: isCurrentlyBlocked ? "0" : "1",
        );
      });
    }
  }

  Widget _circleActionBtn({IconData? icon, String? svgAsset, Color? svgColor, required Gradient gradient, required VoidCallback onTap, double size = 40, double padding = 0}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenWidth(size),
        width: getProportionateScreenWidth(size),
        padding: padding > 0 ? EdgeInsets.all(getProportionateScreenWidth(padding)) : (svgAsset != null ? const EdgeInsets.all(8) : null),
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
        child: icon != null 
          ? Icon(icon, color: Colors.white, size: getProportionateScreenWidth(30))
          : SvgPicture.asset(
              svgAsset!,
              colorFilter: svgColor != null ? ColorFilter.mode(svgColor, BlendMode.srcIn) : null,
            ),
      ),
    );
  }

  Widget _borderedActionBtn({IconData? icon, String? svgAsset, required VoidCallback onTap, Color? bgColor, Color? iconColor, Color? svgColor}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        height: getProportionateScreenWidth(55),
        width: getProportionateScreenWidth(55),
        padding: svgAsset != null ? const EdgeInsets.all(11) : null,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.surface,
            width: getProportionateScreenWidth(5),
          ),
        ),
        child: icon != null 
          ? Icon(icon, color: iconColor ?? appPrimaryColor, size: 28)
          : SvgPicture.asset(svgAsset!, colorFilter: svgColor != null ? ColorFilter.mode(svgColor, BlendMode.srcIn) : null),
      ),
    );
  }
}
