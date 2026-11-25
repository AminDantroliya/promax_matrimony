import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/common/data/models/member_models.dart';
import '../../features/common/data/repositories/action_repository.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/app_routes.dart';
import '../../utils/permission_utils.dart';
import '../../utils/utils.dart';

class ProfileCardActionHandler {
  /// Safely resolve effective other member ID (prioritizing receiverMemberId for admin/match items)
  static String getEffectiveMemberId(MemberListModel memberModel) {
    final cand =
        memberModel.receiverMemberId ?? memberModel.memberId ?? memberModel.id;
    return cand?.toString() ?? "";
  }

  /// Centralized logic to send interest / connection request
  static Future<void> sendInterest({
    required BuildContext context,
    required WidgetRef ref,
    required MemberListModel memberModel,
    Function(MemberListModel updatedMember)? onUpdated,
  }) async {
    final memberId = getEffectiveMemberId(memberModel);

    final result = await withLoading(
      context,
      () => ref
          .read(actionRepositoryProvider)
          .sendInterest(receiverMemberId: memberId),
    );

    if (!context.mounted) return;

    handleInterestResult(
      context: context,
      mounted: context.mounted,
      result: result,
      onSuccess: () {
        final updated = memberModel.copyWith(
          interestState: "sent",
          interestStatus: "sent",
        );
        syncInterestActionToAllProviders(ref, memberId, isInterested: true);
        onUpdated?.call(updated);
      },
    );
  }

  /// Centralized logic to toggle shortlist (star/favorite) state
  static Future<void> toggleShortlist({
    required BuildContext context,
    required WidgetRef ref,
    required MemberListModel memberModel,
    Function(MemberListModel updatedMember)? onUpdated,
  }) async {
    final memberId = getEffectiveMemberId(memberModel);
    final isShortlisted =
        memberModel.isShortlisted == "1" ||
        memberModel.isShortlisted == 1 ||
        memberModel.isShortlisted == true ||
        memberModel.isShortlisted == "Yes";

    final success = await withLoading(
      context,
      () => ref
          .read(actionRepositoryProvider)
          .toggleShortlist(
            memberId: memberId,
            isCurrentlyShortlisted: isShortlisted,
          ),
    );

    if (!context.mounted) return;

    if (success) {
      final newShortlistedState = !isShortlisted;
      final newShortlistVal = newShortlistedState ? "1" : "0";
      final updated = memberModel.copyWith(isShortlisted: newShortlistVal);
      showToast(
        isShortlisted ? "removed_from_shortlist".tr : "added_to_shortlist".tr,
      );
      syncShortlistActionToAllProviders(
        ref,
        memberId,
        isShortlisted: newShortlistedState,
      );
      onUpdated?.call(updated);
    }
  }

  /// Centralized logic to toggle block state
  static Future<void> toggleBlock({
    required BuildContext context,
    required WidgetRef ref,
    required MemberListModel memberModel,
    Function(MemberListModel updatedMember)? onUpdated,
  }) async {
    final memberId = getEffectiveMemberId(memberModel);
    final isBlocked =
        memberModel.isBlock == 1 ||
        memberModel.isBlock == "1" ||
        memberModel.isBlock == true;

    final confirmed = await AppDialogs.confirmBlock(
      context,
      isBlocked: isBlocked,
      memberName:
          memberModel.fullname ??
          memberModel.profileTitle ??
          'this_user'.tr,
    );
    if (!confirmed || !context.mounted) return;

    final success = await withLoading(
      context,
      () => ref
          .read(actionRepositoryProvider)
          .toggleBlock(
            memberId: memberId,
            isCurrentlyBlocked: isBlocked,
          ),
    );

    if (success && context.mounted) {
      final newBlockedState = !isBlocked;
      final updated = memberModel.copyWith(isBlock: newBlockedState ? 1 : 0);
      showToast(
        isBlocked ? 'unblocked_success'.tr : 'blocked_success'.tr,
      );
      syncBlockActionToAllProviders(
        ref,
        memberId,
        isBlocked: newBlockedState,
      );
      onUpdated?.call(updated);
    }
  }

  /// Navigate to view full profile of other member
  static void viewProfile(BuildContext context, MemberListModel memberModel) {
    final memberId = getEffectiveMemberId(memberModel);
    AppRoutes.openProfile(context, memberId);
  }

  /// Navigate to chat detail screen
  static Future<void> openChat(
    BuildContext context,
    WidgetRef ref,
    MemberListModel memberModel,
  ) async {
    final hasAccess = await checkChatPermission(context, ref);
    if (!hasAccess || !context.mounted) return;

    final memberId = getEffectiveMemberId(memberModel);
    final name =
        memberModel.fullname?.toString() ??
        memberModel.profileTitle?.toString() ??
        'User';
    AppRoutes.openChat(
      context,
      memberId: memberId,
      receiverName: name,
      receiverPhoto: memberModel.profileImage,
    );
  }

  /// Initiate voice call action using tested Zego/permission pipeline
  static void makeVoiceCall(
    BuildContext context,
    WidgetRef ref,
    MemberListModel memberModel,
  ) {
    initiateAppCall(context, ref, targetModel: memberModel, isVideo: false);
  }

  /// Initiate video call action using tested Zego/permission pipeline
  static void makeVideoCall(
    BuildContext context,
    WidgetRef ref,
    MemberListModel memberModel,
  ) {
    initiateAppCall(context, ref, targetModel: memberModel, isVideo: true);
  }

  /// Show bottom sheet options menu for profile (Block, Report, Share, etc.)
  static void showOptionsMenu(
    BuildContext context,
    WidgetRef ref,
    MemberListModel memberModel,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final isShortlisted =
            memberModel.isShortlisted == "1" ||
            memberModel.isShortlisted == 1 ||
            memberModel.isShortlisted == true;
        final isBlocked =
            memberModel.isBlock == 1 ||
            memberModel.isBlock == "1" ||
            memberModel.isBlock == true;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: Text('view_profile'.tr),
                onTap: () {
                  Navigator.pop(ctx);
                  viewProfile(context, memberModel);
                },
              ),
              ListTile(
                leading: Icon(
                  isShortlisted
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: isShortlisted ? Colors.amber : null,
                ),
                title: Text(
                  isShortlisted ? 'remove_from_shortlist'.tr : 'shortlist'.tr,
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  toggleShortlist(
                    context: context,
                    ref: ref,
                    memberModel: memberModel,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: Text('report_profile'.tr),
                onTap: () {
                  Navigator.pop(ctx);
                  final memberId = getEffectiveMemberId(memberModel);
                  AppRoutes.openReport(context, memberId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block_rounded, color: Colors.red),
                title: Text(
                  isBlocked ? 'unblock_profile'.tr : 'block_profile'.tr,
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  toggleBlock(
                    context: context,
                    ref: ref,
                    memberModel: memberModel,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
