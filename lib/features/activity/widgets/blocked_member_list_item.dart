import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../app_theme/size_config.dart';
import '../../../utils/api_urls.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_widget.dart';
import '../../common/data/models/member_models.dart';
import '../../common/data/repositories/action_repository.dart';
import '../providers/activity_notifier.dart';

class BlockedMemberListItem extends ConsumerWidget {
  final MemberListModel memberModel;
  final int index;
  final String url;

  const BlockedMemberListItem({
    super.key,
    required this.memberModel,
    required this.index,
    required this.url,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(getProportionateScreenWidth(5)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _imageWidget(),
                _unblockAction(context, ref),
              ],
            ),
          ),
          _memberDetails(context, isDark),
        ],
      ),
    );
  }

  Widget _imageWidget() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: getImageWidget(
        url: getDisplayString(memberModel.profileImage, defaultValue: ""),
        boxFit: BoxFit.cover,
        imageWidth: double.infinity,
      ),
    );
  }

  Widget _unblockAction(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 10,
      right: 10,
      child: InkWell(
        onTap: () => _unblockUser(context, ref),
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.block, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _memberDetails(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          customTextBoldStyle(
            memberModel.profileTitle ?? "",
            getProportionateScreenWidth(14),
            TextAlign.center,
            Theme.of(context).colorScheme.onSurface,
          ),
          const Gap(2),
          customTextNormalStyle(
            memberModel.subTitle ?? "",
            getProportionateScreenWidth(11),
            TextAlign.center,
            Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Future<void> _unblockUser(BuildContext context, WidgetRef ref) async {
    showLoading(context);
    try {
      final effectiveId = memberModel.memberId ?? memberModel.receiverMemberId ?? memberModel.id;
      final params = {
        "receiver_member_id": effectiveId.toString(),
        "action": "remove", // remove for unblock
      };

      final status = await ref.read(actionRepositoryProvider).performAction(blockActionApi, params);
      
      hideLoading();
      
      if (status == "success") {
        showToast("user_unblocked_success".tr);
        // Refresh the blocked list
        ref.read(activityProvider(url).notifier).removeMember((effectiveId ?? -1).toString());
      } else {
        showToast("something_went_wrong".tr);
      }
    } catch (e) {
      hideLoading();
      showToast("something_went_wrong".tr);
    }
  }
}
