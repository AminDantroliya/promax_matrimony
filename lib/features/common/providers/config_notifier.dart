import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pro_matrimony/features/common/data/models/common_models.dart';
import 'package:pro_matrimony/features/common/data/repositories/config_repository.dart';
import 'package:pro_matrimony/preference/session_keys.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_notifier.g.dart';

enum ConfigStatus { initial, loading, success, forceUpdate, maintenance, error }

class ConfigState {
  final ConfigStatus status;
  final String? errorMessage;
  final TokenResponseModel? tokenConfig;

  ConfigState({
    this.status = ConfigStatus.initial,
    this.errorMessage,
    this.tokenConfig,
  });

  ConfigState copyWith({
    ConfigStatus? status,
    String? errorMessage,
    TokenResponseModel? tokenConfig,
  }) {
    return ConfigState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tokenConfig: tokenConfig ?? this.tokenConfig,
    );
  }
}

@riverpod
class ConfigNotifier extends _$ConfigNotifier {
  @override
  ConfigState build() => ConfigState();

  Future<void> initializeApp() async {
    state = state.copyWith(status: ConfigStatus.loading);

    try {
      // 1. Get App Version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      // 2. Get Token & Config
      final params = {
        "app_version": appVersion,
        "device_type": Platform.isAndroid ? "android" : "ios",
      };

      final tokenResponse = await ref
          .read(configRepositoryProvider)
          .getToken(params);

      if (tokenResponse.status == "success") {
        //if (tokenResponse.data?.isForceUpdate == true) {
        // Temporarily restrict force update screen
        if (tokenResponse.data?.isForceUpdate == true) {
          state = state.copyWith(
            status: ConfigStatus.forceUpdate,
            tokenConfig: tokenResponse,
          );
          return;
        }

        if (tokenResponse.data?.appUnderMaintenance == "Yes") {
          state = state.copyWith(
            status: ConfigStatus.maintenance,
            tokenConfig: tokenResponse,
          );
          return;
        }

        final otpMethod = tokenResponse.data?.otpLoginMethod?.toString() ?? 'firebase';
        await AppSessionService.setValue('otp_login_method', otpMethod);

        state = state.copyWith(
          status: ConfigStatus.success,
          tokenConfig: tokenResponse,
        );
      } else {
        state = state.copyWith(
          status: ConfigStatus.error,
          errorMessage: tokenResponse.message,
        );
      }
    } catch (e) {
      printLog("Config Initialization Error: $e");
      state = state.copyWith(
        status: ConfigStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  bool get isLoggedIn =>
      AppSessionService.getValue(SessionDetail.kIsLoggedIn) ?? false;
}
