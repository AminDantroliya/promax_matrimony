import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';

import 'designs/my_profile_design_1.dart';
import 'designs/my_profile_design_2.dart';

class MyProfileScreen extends ConsumerWidget {
  final String? profileDesign;

  const MyProfileScreen({
    super.key,
    this.profileDesign,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final rawDesign = (profileDesign ?? config.myProfileDesign).trim();
    final match = RegExp(r'(\d+)').firstMatch(rawDesign);
    final designId = match != null ? int.tryParse(match.group(1)!) : 1;

    switch (designId) {
      case 2:
        return const MyProfileDesign2();
      case 1:
      default:
        return const MyProfileDesign1();
    }
  }
}
