import 'package:flutter/material.dart';
import 'package:pro_matrimony/utils/app_assets.dart';

class MoreMenuSection {
  final String titleKey;
  final List<MoreMenuItem> items;

  MoreMenuSection({
    required this.titleKey,
    required List<MoreMenuItem> items,
  }) : items = List<MoreMenuItem>.from(items);
}

class MoreMenuItem {
  final String labelKey;
  final String svgIcon;
  final String routePath;
  final Color baseColor;
  final Color pastelBgColor;
  final bool hasNewBadge;
  final int badgeCount;
  final VoidCallback? customTap;

  const MoreMenuItem({
    required this.labelKey,
    required this.svgIcon,
    required this.routePath,
    required this.baseColor,
    required this.pastelBgColor,
    this.hasNewBadge = false,
    this.badgeCount = 0,
    this.customTap,
  });
}

List<MoreMenuSection> getMoreMenuSections({
  required dynamic dashboardData,
  required bool isPersonalized,
  Map<String, bool> features = const {},
  Color? primaryColor,
  Color? accentColor,
}) {
  final enableMeeting = features['enableMeeting'] ?? true;
  final enableShortlist = features['enableShortlist'] ?? true;
  final enableBlockProfile = features['enableBlockProfile'] ?? true;
  final enablePhotoRequest = features['enablePhotoRequest'] ?? true;
  final enableMembershipPlans = features['enableMembershipPlans'] ?? true;
  final enableVoiceCall = features['enableVoiceCall'] ?? true;
  final enableVideoCall = features['enableVideoCall'] ?? true;

  int parseCount(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is String) return int.tryParse(val) ?? 0;
    return 0;
  }

  final List<MoreMenuSection> sections = [
    MoreMenuSection(
      titleKey: 'my_activity',
      items: [
        MoreMenuItem(
          labelKey: 'interest',
          svgIcon: AppAssets.icMenuInterest,
          routePath: '/connections',
          baseColor: primaryColor ?? const Color(0xFFE11D48),
          pastelBgColor: primaryColor?.withValues(alpha: 0.12) ?? const Color(0xFFFDEEF2),
          badgeCount: parseCount(dashboardData?.interestCount),
        ),
        MoreMenuItem(
          labelKey: 'shortlisted',
          svgIcon: AppAssets.icMenuShortlisted,
          routePath: '/shortlisted-profiles',
          baseColor: const Color(0xFFF59E0B),
          pastelBgColor: const Color(0xFFFEF3E2),
          badgeCount: parseCount(dashboardData?.shortlistCount),
        ),
        MoreMenuItem(
          labelKey: 'blocked',
          svgIcon: AppAssets.icMenuBlockedList,
          routePath: '/blocked-profiles',
          baseColor: const Color(0xFFEF4444),
          pastelBgColor: const Color(0xFFFDE8E8),
          badgeCount: parseCount(dashboardData?.blockedCount),
        ),
        MoreMenuItem(
          labelKey: 'photo_request_single_line',
          svgIcon: AppAssets.icMenuPhotoRequest,
          routePath: '/photo-requests',
          baseColor: const Color(0xFFEC4899),
          pastelBgColor: const Color(0xFFFCEBF2),
          badgeCount: parseCount(dashboardData?.photoRequestCount),
        ),
        MoreMenuItem(
          labelKey: 'viewed_profile_title',
          svgIcon: AppAssets.icMenuViewedProfile,
          routePath: '/viewed-profiles',
          baseColor: const Color(0xFF3B82F6),
          pastelBgColor: const Color(0xFFE8F2FE),
          badgeCount: parseCount(dashboardData?.viewedProfileCount),
        ),
        MoreMenuItem(
          labelKey: 'viewed_contact_title',
          svgIcon: AppAssets.icMenuViewedContact,
          routePath: '/viewed-contacts',
          baseColor: const Color(0xFF10B981),
          pastelBgColor: const Color(0xFFE8F7F0),
          badgeCount: parseCount(dashboardData?.viewedContactCount),
        ),
      ],
    ),
    MoreMenuSection(
      titleKey: 'discover',
      items: [
        const MoreMenuItem(
          labelKey: 'recently_joined',
          svgIcon: AppAssets.icMenuRecentlyJoined,
          routePath: '/recently-joined-matches',
          baseColor: Color(0xFF10B981),
          pastelBgColor: Color(0xFFE8F7F0),
          hasNewBadge: true,
        ),
        const MoreMenuItem(
          labelKey: 'recently_login',
          svgIcon: AppAssets.icMenuRecentlyLogin,
          routePath: '/recently-login-matches',
          baseColor:  Color(0xFFF97316),
          pastelBgColor:  Color(0xFFFEF0E6),
          hasNewBadge: true,
        ),
        MoreMenuItem(
          labelKey: 'new_matches',
          svgIcon: AppAssets.icMenuNewMatches,
          routePath: '/recommended-matches',
          baseColor: primaryColor ?? const Color(0xFFEC4899),
          pastelBgColor: primaryColor?.withValues(alpha: 0.12) ?? const Color(0xFFFDEEF2),
        ),
        // MoreMenuItem(
        //   labelKey: 'events',
        //   svgIcon: AppAssets.icMenuEvents,
        //   routePath: '/events',
        //   baseColor: const Color(0xFF0D9488),
        //   pastelBgColor: const Color(0xFFE6FFFA),
        //   hasNewBadge: true,
        // ),
      ],
    ),
    MoreMenuSection(
      titleKey: 'personalize',
      items: [
        MoreMenuItem(
          labelKey: 'suggested_matches',
          svgIcon: AppAssets.icMenuSuggestedMatches,
          routePath: '/suggested-matches',
          baseColor: primaryColor ?? const Color(0xFFEC4899),
          pastelBgColor: primaryColor?.withValues(alpha: 0.12) ?? const Color(0xFFFDEEF2),
          hasNewBadge: true,
        ),
        MoreMenuItem(
          labelKey: 'meeting_list',
          svgIcon: AppAssets.icMenuMeetingList,
          routePath: '/meetings',
          baseColor: accentColor ?? const Color(0xFF8B5CF6),
          pastelBgColor: accentColor?.withValues(alpha: 0.12) ?? const Color(0xFFF2ECFE),
        ),
        const MoreMenuItem(
          labelKey: 'chat_with_manager',
          svgIcon: AppAssets.icMenuChatWithAdmin,
          routePath: '/help-support',
          baseColor: Color(0xFFF97316),
          pastelBgColor: Color(0xFFFEF0E6),
          hasNewBadge: true,
        ),
      ],
    ),
    MoreMenuSection(
      titleKey: 'account_plans',
      items: [
        const MoreMenuItem(
          labelKey: 'current_plan',
          svgIcon: AppAssets.icMenuCurrentPlan,
          routePath: '/current-plan',
          baseColor: Color(0xFFF59E0B),
          pastelBgColor: Color(0xFFFEF3E2),
        ),
        MoreMenuItem(
          labelKey: 'membership',
          svgIcon: AppAssets.icMenuMembershipPlan,
          routePath: '/plans',
          baseColor: accentColor ?? const Color(0xFF8B5CF6),
          pastelBgColor: accentColor?.withValues(alpha: 0.12) ?? const Color(0xFFF2ECFE),
        ),
        const MoreMenuItem(
          labelKey: 'privacy_settings',
          svgIcon: AppAssets.icMenuPrivacySettings,
          routePath: '/privacy-settings',
          baseColor: Color(0xFF10B981),
          pastelBgColor: Color(0xFFE8F7F0),
        ),
      ],
    ),
    MoreMenuSection(
      titleKey: 'general',
      items: [
        MoreMenuItem(
          labelKey: 'call_history',
          svgIcon: AppAssets.icMenuCallHistory,
          routePath: '/call-history',
          baseColor: Color(0xFFEC4899),
          pastelBgColor: Color(0xFFFDEEF2),
        ),
        MoreMenuItem(
          labelKey: 'privacy_settings',
          svgIcon: AppAssets.icMenuPrivacySettings,
          routePath: '/privacy-settings',
          baseColor:  Color(0xFF10B981),
          pastelBgColor:  Color(0xFFE8F7F0),
        ),
        MoreMenuItem(
          labelKey: 'settings',
          svgIcon: AppAssets.icMenuSettings,
          routePath: '/settings',
          baseColor:  Color(0xFF3B82F6),
          pastelBgColor:  Color(0xFFEBF3FE),
        ),
      ],
    ),
  ];

  if (!isPersonalized) {
    sections.removeWhere((section) => section.titleKey == 'personalize');
  }

  if (!enableMeeting) {
    for (final section in sections) {
      section.items.removeWhere((item) => item.labelKey == 'meeting_list');
    }
  }
  if (!enableShortlist) {
    for (final section in sections) {
      section.items.removeWhere((item) => item.labelKey == 'shortlisted');
    }
  }
  if (!enableBlockProfile) {
    for (final section in sections) {
      section.items.removeWhere((item) => item.labelKey == 'blocked');
    }
  }
  if (!enablePhotoRequest) {
    for (final section in sections) {
      section.items.removeWhere((item) => item.labelKey == 'photo_request_single_line');
    }
  }
  if (!enableMembershipPlans) {
    for (final section in sections) {
      section.items.removeWhere((item) => item.labelKey == 'membership' || item.labelKey == 'current_plan');
    }
  }
  if (!enableVoiceCall && !enableVideoCall) {
    for (final section in sections) {
      section.items.removeWhere((item) => item.labelKey == 'call_history');
    }
  }

  sections.removeWhere((section) => section.items.isEmpty);

  return sections;
}
