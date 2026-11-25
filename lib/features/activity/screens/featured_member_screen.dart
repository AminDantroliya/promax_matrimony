import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter/material.dart';
import 'package:pro_matrimony/features/activity/screens/activity_member_list_screen.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/utils/utils.dart';

class FeaturedMemberScreen extends ConsumerWidget {
  const FeaturedMemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'featured_members'.tr, isShowActions: true),
            const Expanded(
              child: ActivityMemberListScreen(
                url: getFeaturedMemberListApi,
                noRecordMsg: "No featured member found",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
