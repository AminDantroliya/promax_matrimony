import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/common/data/repositories/action_repository.dart';
import 'package:pro_matrimony/features/profile/screens/other_member_profile_screen.dart';
import 'package:pro_matrimony/utils/utils.dart';

class PhotoRequestBottomSheet extends ConsumerWidget {
  final String memberId;

  const PhotoRequestBottomSheet({super.key, required this.memberId});

  static Future<void> show(BuildContext context, String memberId) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) => PhotoRequestBottomSheet(memberId: memberId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Gap(24),
            // Title
            customTextBoldStyle(
                'photo_request_single_line'.tr,
                20,
                TextAlign.start,
                theme.colorScheme.onSurface),
            const Gap(20),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    showLoading(context);
                    try {
                      await ref.read(actionRepositoryProvider).sendMemberPhotoRequest(
                        receiverMemberId: memberId,
                      );
                    } finally {
                      hideLoading();
                    }
                  },
                  child: Row(
                    children: [
                      _buildIcon(context, Icons.add_photo_alternate_outlined),
                      Gap(getProportionateScreenWidth(20)),
                      Expanded(
                          child: customTextNormalStyle(
                              'photo_request_message'.tr,
                              15,
                              TextAlign.start,
                              theme.colorScheme.onSurface.withValues(alpha: 0.7)))
                    ],
                  ),
                ),
                Gap(getProportionateScreenWidth(20)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OtherMemberProfileScreen(memberId: memberId)));
                  },
                  child: Row(
                    children: [
                      _buildIcon(context, Icons.remove_red_eye_outlined),
                      Gap(getProportionateScreenWidth(20)),
                      Expanded(
                          child: customTextNormalStyle(
                              'btn_view_profile'.tr,
                              15,
                              TextAlign.start,
                              theme.colorScheme.onSurface.withValues(alpha: 0.7)))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon) {
    return Container(
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(getProportionateScreenWidth(40))),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
                width: 1, color: Theme.of(context).dividerColor)),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: getProportionateScreenWidth(25),
        ));
  }
}
