import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/generic_member_list_view.dart';
import '../data/models/meeting_models.dart';
import '../providers/meeting_notifier.dart';
import '../widgets/meeting_list_item.dart';

class MeetingListScreen extends ConsumerStatefulWidget {
  const MeetingListScreen({super.key});

  @override
  ConsumerState<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends ConsumerState<MeetingListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(meetingProvider.notifier).fetchMeetings();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(meetingProvider.notifier).fetchMeetings(isRefresh: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(meetingProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'my_meetings'.tr, isShowActions: false),
            Expanded(
              child: GenericMemberListView<Meeting>(
                state: state,
                scrollController: _scrollController,
                onRefresh: () =>
                    ref.read(meetingProvider.notifier).fetchMeetings(),
                itemBuilder: (context, meeting, index) {
                  return MeetingListItem(
                    meeting: meeting,
                    onAction: (status, remark) => _handleAction(
                      meeting,
                      status,
                      remark: remark,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(dynamic meetingOrId, String status, {String? remark}) async {
    showLoading(context);
    final success = await ref
        .read(meetingProvider.notifier)
        .updateStatus(meetingOrId, status, remark: remark);
    hideLoading();
    if (!success) {
      showToast("action_failed".tr);
    }
  }
}
