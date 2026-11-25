import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../app_theme/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_widget.dart';
import '../../common/data/models/member_models.dart';
import '../../common/data/repositories/action_repository.dart';
import '../providers/activity_notifier.dart';

class ShortlistedMemberListItem extends ConsumerWidget {
  final MemberListModel memberModel;
  final int index;
  final String url;

  const ShortlistedMemberListItem({
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
                _shortlistAction(context, ref),
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

  Widget _shortlistAction(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 10,
      right: 10,
      child: InkWell(
        onTap: () => _removeShortlist(context, ref),
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.figmaShortlistSelected,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFABE2C),
                BlendMode.srcIn,
              ),
              width: 18,
              height: 18,
            ),
          ),
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

  Future<void> _removeShortlist(BuildContext context, WidgetRef ref) async {
    showLoading(context);
    try {
      final success = await ref.read(actionRepositoryProvider).toggleShortlist(
        memberId: memberModel.memberId.toString(),
        isCurrentlyShortlisted: true,
      );
      
      hideLoading();
      
      if (success) {
        showToast("removed_from_shortlist".tr);
        // Refresh the list
        ref.read(activityProvider(url).notifier).removeMember(memberModel.memberId ?? -1);
      } else {
        showToast("failed_to_update_shortlist".tr);
      }
    } catch (e) {
      hideLoading();
      showToast("something_went_wrong".tr);
    }
  }
}
