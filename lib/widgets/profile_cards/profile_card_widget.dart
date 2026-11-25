import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_config.dart';
import '../../features/common/data/models/member_models.dart';
import 'cards/profile_card_1.dart';
import 'cards/profile_card_2.dart';
import 'cards/profile_card_3.dart';
import 'cards/profile_card_4.dart';
import 'cards/profile_card_5.dart';
import 'cards/profile_card_6.dart';

class ProfileCardWidget extends ConsumerWidget {
  final MemberListModel memberModel;
  final String? cardStyle;
  final Function(MemberListModel updated)? onActionComplete;

  const ProfileCardWidget({
    super.key,
    required this.memberModel,
    this.cardStyle,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final rawStyle = (cardStyle ?? config.profileCardStyle).trim();
    final match = RegExp(r'(\d+)').firstMatch(rawStyle);
    final styleId = match != null ? int.tryParse(match.group(1)!) : 1;

    switch (styleId) {
      case 2:
        return ProfileCard2(
          memberModel: memberModel,
          onActionComplete: onActionComplete,
        );
      case 3:
        return ProfileCard3(
          memberModel: memberModel,
          onActionComplete: onActionComplete,
        );
      case 4:
        return ProfileCard4(
          memberModel: memberModel,
          onActionComplete: onActionComplete,
        );
      case 5:
        return ProfileCard5(
          memberModel: memberModel,
          onActionComplete: onActionComplete,
        );
      case 6:
        return ProfileCard6(
          memberModel: memberModel,
          onActionComplete: onActionComplete,
        );
      case 1:
      default:
        return ProfileCard1(
          memberModel: memberModel,
          onActionComplete: onActionComplete,
        );
    }
  }
}
