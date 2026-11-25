import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/event_models.dart';
import '../data/repositories/event_repository.dart';

class EventListState {
  final List<EventItem> events;
  final bool isLoading;
  final bool isLoadingMore;
  final String searchKeyword;
  final int currentPage;
  final bool hasMore;
  final String? error;

  const EventListState({
    this.events = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.searchKeyword = '',
    this.currentPage = 1,
    this.hasMore = true,
    this.error,
  });

  EventListState copyWith({
    List<EventItem>? events,
    bool? isLoading,
    bool? isLoadingMore,
    String? searchKeyword,
    int? currentPage,
    bool? hasMore,
    String? error,
  }) {
    return EventListState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}

class EventListNotifier extends Notifier<EventListState> {
  EventRepository get _repository => ref.read(eventRepositoryProvider);

  @override
  EventListState build() {
    Future.microtask(() => fetchEvents());
    return const EventListState();
  }

  Future<void> fetchEvents({
    bool isRefresh = false,
    String? keyword,
  }) async {
    final search = keyword ?? state.searchKeyword;
    if (isRefresh) {
      state = state.copyWith(
        isLoading: true,
        error: null,
        currentPage: 1,
        searchKeyword: search,
      );
    } else {
      state = state.copyWith(
        isLoading: state.events.isEmpty,
        error: null,
        searchKeyword: search,
      );
    }

    try {
      final response = await _repository.getEvents(
        keyword: search,
        page: 1,
      );

      final newItems = response.data?.data ?? [];
      final lastPage = response.data?.lastPage;
      final total = response.data?.total;

      bool hasMore = newItems.isNotEmpty;
      if (lastPage != null) {
        hasMore = 1 < lastPage;
      } else if (total != null) {
        hasMore = newItems.length < total;
      }

      state = state.copyWith(
        events: newItems,
        isLoading: false,
        currentPage: 1,
        hasMore: hasMore,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);
    final nextPage = state.currentPage + 1;

    try {
      final response = await _repository.getEvents(
        keyword: state.searchKeyword,
        page: nextPage,
      );

      final newItems = response.data?.data ?? [];
      final lastPage = response.data?.lastPage;

      bool hasMore = newItems.isNotEmpty;
      if (lastPage != null) {
        hasMore = nextPage < lastPage;
      }

      state = state.copyWith(
        events: [...state.events, ...newItems],
        isLoadingMore: false,
        currentPage: nextPage,
        hasMore: hasMore,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void search(String keyword) {
    fetchEvents(isRefresh: true, keyword: keyword);
  }
}

final eventListProvider =
    NotifierProvider<EventListNotifier, EventListState>(
  EventListNotifier.new,
);

final eventDetailsProvider =
    FutureProvider.family<EventItem?, int>((ref, eventId) async {
  final repo = ref.watch(eventRepositoryProvider);
  final res = await repo.getEventDetails(eventId);
  return res.data;
});

class RegisteredEventsState {
  final List<RegisteredEventItem> items;
  final bool isLoading;
  final String? error;

  const RegisteredEventsState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  RegisteredEventsState copyWith({
    List<RegisteredEventItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return RegisteredEventsState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RegisteredEventsNotifier extends Notifier<RegisteredEventsState> {
  EventRepository get _repository => ref.read(eventRepositoryProvider);

  @override
  RegisteredEventsState build() {
    Future.microtask(() => fetchRegisteredEvents());
    return const RegisteredEventsState();
  }

  Future<void> fetchRegisteredEvents() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _repository.getRegisteredEvents();
      state = state.copyWith(
        items: res.data?.data ?? [],
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final registeredEventsProvider =
    NotifierProvider<RegisteredEventsNotifier, RegisteredEventsState>(
  RegisteredEventsNotifier.new,
);
