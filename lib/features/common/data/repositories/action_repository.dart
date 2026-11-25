import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../utils/api_urls.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/membership_upgrade_bottom_sheet.dart';

part 'action_repository.g.dart';

class ActionRepository extends BaseRepository {
  ActionRepository(super.dio);

  // ─── Raw API Methods ────────────────────────────────────────────────────────

  Future<ApiResponse> addConnection(Map<String, dynamic> params) async {
    final response = await postRequest(sendConnectionApi, params);
    return response;
  }

  Future<String> addRemoveShortlist(Map<String, dynamic> params) async {
    final response = await postRequest(shortlistActionApi, params);
    return response.status;
  }

  Future<String> sendPhotoRequest(Map<String, dynamic> params) async {
    final response = await postRequest(sendPhotoRequestApi, params);
    return response.status;
  }

  Future<String> performAction(String url, Map<String, dynamic> params) async {
    final response = await postRequest(url, params);
    return response.status;
  }

  // ─── High-Level Action Helpers ───────────────────────────────────────────────
  // Use these in UI widgets to avoid duplicating error-handling boilerplate.

  /// Sends a connection/interest request.
  /// Returns an [InterestResult] so the caller can handle UI feedback
  /// (e.g. showing the membership upgrade dialog) after checking `mounted`.
  Future<InterestResult> sendInterest({
    required String receiverMemberId,
  }) async {
    final response = await addConnection({"receiver_member_id": receiverMemberId});
    if (response.status == "success") {
      return InterestSuccess(response.message);
    } else if (response.status == "error") {
      final msg = response.message;
      if (msg.toLowerCase().contains("paid member") ||
          msg.toLowerCase().contains("upgrade")) {
        return InterestUpgradeRequired(msg);
      } else {
        showToast(msg);
        return const InterestFailure();
      }
    }
    return const InterestFailure();
  }

  /// Toggles shortlist state (add/remove) for a member.
  /// Returns `true` when the action succeeded on the server.
  Future<bool> toggleShortlist({
    required String memberId,
    required bool isCurrentlyShortlisted,
  }) async {
    final action = isCurrentlyShortlisted ? "remove" : "add";
    final response = await postRequest(shortlistActionApi, {
      "receiver_member_id": memberId,
      "action": action,
    });
    return response.status == "success" ||
        response.message.toLowerCase().contains("already shortlisted");
  }

  /// Toggles block state (block/unblock) for a member.
  /// Returns `true` when the action succeeded on the server.
  Future<bool> toggleBlock({
    required String memberId,
    required bool isCurrentlyBlocked,
  }) async {
    final status = await performAction(blockActionApi, {
      "receiver_member_id": memberId,
      "action": isCurrentlyBlocked ? "remove" : "add",
    });
    return status == "success";
  }

  /// Sends a photo request to a member.
  /// Returns `true` when the action succeeded on the server.
  Future<bool> sendMemberPhotoRequest({
    required String receiverMemberId,
  }) async {
    final response = await postRequest(sendPhotoRequestApi, {
      "receiver_member_id": receiverMemberId,
    });
    showToast(response.message);
    return response.status == "success";
  }
}

@riverpod
ActionRepository actionRepository(Ref ref) {
  return ActionRepository(ref.watch(dioProvider));
}

// ─── Interest Action Result Types ──────────────────────────────────────────

sealed class InterestResult {
  const InterestResult();
}

class InterestSuccess extends InterestResult {
  final String message;
  const InterestSuccess(this.message);
}

class InterestFailure extends InterestResult {
  const InterestFailure();
}

class InterestUpgradeRequired extends InterestResult {
  final String message;
  const InterestUpgradeRequired(this.message);
}

/// Global UI helper to handle InterestResult without violating async-context lints.
void handleInterestResult({
  required BuildContext context,
  required bool mounted,
  required InterestResult result,
  required VoidCallback onSuccess,
}) {
  if (!mounted || !context.mounted) return;
  if (result is InterestSuccess) {
    showSuccessToast(
      context,
      result.message,
      icon: Icons.favorite_rounded,
    );
    onSuccess();
  } else if (result is InterestUpgradeRequired) {
    MembershipUpgradeBottomSheet.show(context, result.message);
  }
}
