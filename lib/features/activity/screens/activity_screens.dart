import 'package:flutter/material.dart';
import '../../../../utils/api_urls.dart';
import 'activity_list_screen.dart';
import 'call_history_screen.dart';
import '../../../../utils/utils.dart';

class RecentlyJoinedScreen extends StatelessWidget {
  const RecentlyJoinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityListScreen(
      url: getRecentJoinedListApi,
      title: 'recently_joined_member'.tr,
    );
  }
}

class RecentlyLoginScreen extends StatelessWidget {
  const RecentlyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityListScreen(
      url: getRecentLoginListApi,
      title: 'recently_login'.tr,
    );
  }
}

class ShortlistedScreen extends StatelessWidget {
  const ShortlistedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityListScreen(
      url: getShortlistedListApi,
      title: 'shortlisted_profile'.tr,
    );
  }
}

class BlockedProfilesScreen extends StatelessWidget {
  const BlockedProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityListScreen(
      url: getBlockedListApi,
      title: 'blocked_profile'.tr,
    );
  }
}

class ViewedProfilesScreen extends StatelessWidget {
  const ViewedProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityListScreen(
      url: getViewedProfileListApi,
      title: 'viewed_profile'.tr,
    );
  }
}

class ViewedContactsScreen extends StatelessWidget {
  const ViewedContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityListScreen(
      url: getViewedContactListApi,
      title: 'viewed_contact'.tr,
    );
  }
}

class CallHistoryScreenWrapper extends StatelessWidget {
  const CallHistoryScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const CallHistoryScreen();
  }
}
