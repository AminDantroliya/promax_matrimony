import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/chat/data/models/chat_models.dart';
import '../../../features/chat/data/repositories/chat_repository.dart';

part 'chat_member_notifier.freezed.dart';
part 'chat_member_notifier.g.dart';

@freezed
abstract class ChatMemberState with _$ChatMemberState {
  const factory ChatMemberState({
    @Default([]) List<ChatMember> memberList,
    @Default(1) int page,
    @Default(0) int totalCount,
    @Default(false) bool isLoadingMore,
    @Default(null) ChatMemberListResponseModel? response,
  }) = _ChatMemberState;
}

@riverpod
class ChatMemberNotifier extends _$ChatMemberNotifier {
  late final String _type;

  @override
  FutureOr<ChatMemberState> build(String type) async {
    // type: "online" or "recent"
    _type = type;
    return _fetchMemberList(type, 1);
  }

  Future<ChatMemberState> _fetchMemberList(String type, int page) async {
    final params = {
      "page": page.toString(),
      "limit": "10",
      "type": type,
    };
    final response = await ref.read(chatRepositoryProvider).getChatMemberList(params);
    return ChatMemberState(
      memberList: response.data?.resultList ?? [],
      page: page,
      totalCount: response.data?.resultCount ?? 0,
      response: response,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchMemberList(_type, 1));
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore || currentState.memberList.length >= currentState.totalCount) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.page + 1;
    final params = {
      "page": nextPage.toString(),
      "limit": "10",
      "type": _type,
    };

    try {
      final response = await ref.read(chatRepositoryProvider).getChatMemberList(params);
      state = AsyncValue.data(currentState.copyWith(
        memberList: [...currentState.memberList, ...(response.data?.resultList ?? [])],
        page: nextPage,
        isLoadingMore: false,
        response: response,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
