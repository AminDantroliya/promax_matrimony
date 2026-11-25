import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/ai_interest_models.dart';
import '../data/repositories/settings_repository.dart';
import '../../home/providers/dashboard_notifier.dart';

part 'ai_interest_notifier.g.dart';
part 'ai_interest_notifier.freezed.dart';

// ─── State ────────────────────────────────────────────────────────────────────

@freezed
abstract class AiInterestState with _$AiInterestState {
  const factory AiInterestState({
    @Default(true) bool autoSendEnabled,
    @Default(5) int dailyLimit,
    @Default(60) int minMatchPercentage,
    @Default(false) bool isSaving,
    @Default(false) bool isLoadingList,
    List<AiInterestMatch>? todayMatches,
    String? error,
  }) = _AiInterestState;
}

// ─── Notifier ────────────────────────────────────────────────────────────────

@riverpod
class AiInterestNotifier extends _$AiInterestNotifier {
  @override
  AiInterestState build() {
    // dashboardProvider returns AsyncValue<DashboardData?>, .value is DashboardData?
    final dashboardData = ref.read(dashboardProvider).value;
    return AiInterestState(
      autoSendEnabled: (dashboardData?.autoInterestEnabled ?? 1) == 1,
      dailyLimit: dashboardData?.dailyInterestLimit ?? 5,
      minMatchPercentage: dashboardData?.minMatchPercentage ?? 60,
    );
  }

  void setAutoSend(bool value) => state = state.copyWith(autoSendEnabled: value);

  void setDailyLimit(int value) => state = state.copyWith(dailyLimit: value);

  void setMinMatchPercentage(int value) =>
      state = state.copyWith(minMatchPercentage: value);

  /// Saves settings to `ai-interest/update-settings`
  Future<bool> saveSettings() async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      final repo = ref.read(settingsRepositoryProvider);
      final result = await repo.updateAiSettings({
        'auto_interest_enabled': state.autoSendEnabled ? 1 : 0,
        'daily_interest_limit': state.dailyLimit,
        'min_match_percentage': state.minMatchPercentage,
      });
      final success = result['status'] == 'success' || result['code'] == 200;
      state = state.copyWith(isSaving: false);
      return success;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }

  /// Fetches today's AI match list from `ai-interest/list`
  Future<void> fetchTodayList() async {
    state = state.copyWith(isLoadingList: true, error: null);
    try {
      final repo = ref.read(settingsRepositoryProvider);
      final response = await repo.getAiInterestList();
      state = state.copyWith(
        isLoadingList: false,
        todayMatches: response.data?.resultList ?? [],
      );
    } catch (e) {
      state = state.copyWith(isLoadingList: false, error: e.toString());
    }
  }

  /// Resets to dashboard defaults
  void reset() {
    final dashboardData = ref.read(dashboardProvider).value;
    state = AiInterestState(
      autoSendEnabled: (dashboardData?.autoInterestEnabled ?? 1) == 1,
      dailyLimit: dashboardData?.dailyInterestLimit ?? 5,
      minMatchPercentage: dashboardData?.minMatchPercentage ?? 60,
    );
  }
}
