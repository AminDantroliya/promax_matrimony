import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../settings/data/repositories/settings_repository.dart';
import '../data/models/privacy_settings_models.dart';
import '../../../utils/api_urls.dart';

part 'privacy_settings_notifier.g.dart';

@riverpod
class PrivacySettingsNotifier extends _$PrivacySettingsNotifier {
  @override
  FutureOr<PrivacySettingsData?> build() async {
    final response = await ref.read(settingsRepositoryProvider).getPrivacySettings();
    return PrivacySettingsData.fromJson(response);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(settingsRepositoryProvider).getPrivacySettings();
      return PrivacySettingsData.fromJson(response);
    });
  }

  Future<Map<String, dynamic>> updateSetting(String key, int value) async {
    final params = {key: value};
    return await ref.read(settingsRepositoryProvider).updatePrivacySetting(params);
  }

  Future<Map<String, dynamic>> updateAllSettings({
    required int photoVisibility,
    required int contactVisibility,
    required int videoCallSetting,
    required int voiceCallSetting,
  }) async {
    final params = {
      'photo_visibility': photoVisibility,
      'contact_visibility': contactVisibility,
      'video_call_setting': videoCallSetting,
      'voice_call_setting': voiceCallSetting,
    };
    return await ref.read(settingsRepositoryProvider).updatePrivacySetting(params);
  }

  Future<Map<String, dynamic>> updateAlerts(String templateType, List<int> templateIds) async {
    final params = {
      'template_type': templateType,
      'template_ids': templateIds.join(','),
    };
    return await ref.read(settingsRepositoryProvider).performAction(updateAlertsApi, params);
  }

  Future<Map<String, dynamic>> updateInterestMessage({
    required int sendInterestSetting,
    required String interestSentMessage,
    required int acceptInterestSetting,
    required String interestAcceptedMessage,
  }) async {
    final params = {
      'send_interest_setting': sendInterestSetting,
      'interest_sent_message': interestSentMessage,
      'accept_interest_setting': acceptInterestSetting,
      'interest_accepted_message': interestAcceptedMessage,
    };
    return await ref.read(settingsRepositoryProvider).performAction(updateInterestMessageApi, params);
  }
}
