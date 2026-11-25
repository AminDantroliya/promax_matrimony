import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';

import 'designs/privacy_settings_design_1.dart';
import 'designs/privacy_settings_design_2.dart';

class PrivacySettingsScreen extends ConsumerWidget {
  final String? scrollToSection;
  final String? privacyDesign;

  const PrivacySettingsScreen({
    super.key,
    this.scrollToSection,
    this.privacyDesign,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final rawDesign = (privacyDesign ?? config.privacySettingsDesign).trim();
    final match = RegExp(r'(\d+)').firstMatch(rawDesign);
    final designId = match != null ? int.tryParse(match.group(1)!) : 1;

    switch (designId) {
      case 2:
        return PrivacySettingsDesign2(scrollToSection: scrollToSection);
      case 1:
      default:
        return PrivacySettingsDesign1(scrollToSection: scrollToSection);
    }
  }
}
