import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/app_session_service.dart';
import '../../../preference/session_keys.dart';
import '../../../utils/app_debug.dart';
import '../../../utils/utils.dart';

import '../../../utils/application_data.dart';
import '../../../services/zego_initialization_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../services/registration_token_holder.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  // Base URL from FlavorConfig — set before any API call (including /app-config)
  final flavor = ref.watch(flavorConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: flavor.baseUrl,
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final sessionToken = AppSessionService.getValue(SessionDetail.kAccessToken);
        final regToken = RegistrationTokenHolder.token;
        // Prioritize temporary registration token if actively in registration flow, else session token
        final token = (regToken != null && regToken.trim().isNotEmpty) ? regToken : sessionToken;

        final langCode = AppSessionService.getValue(SessionDetail.kLanguageCode) ?? "en";
        final userId = AppSessionService.getValue(SessionDetail.kUserId);

        if (token != null && token.toString().trim().isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        options.headers['lang'] = langCode;
        options.headers['lang_code'] = langCode;
        options.headers['Accept-Language'] = langCode;
        options.headers.remove('content-length');

        // Add user_id to POST request body if missing (except for other user profile fetch & registration steps)
        final isRegistrationRequest = options.path.contains("register");
        if (options.method == 'POST' && userId != null && !isRegistrationRequest) {
          final isUserProfileFetch = options.path.contains("user-profile");
          if (!isUserProfileFetch) {
            if (options.data is Map) {
              options.data['user_id'] = options.data['user_id'] ?? userId;
            } else if (options.data is FormData) {
              final formData = options.data as FormData;
              if (!formData.fields.any((field) => field.key == 'user_id')) {
                formData.fields.add(MapEntry('user_id', userId.toString()));
              }
            }
          }
        }

        // Print request details including method, api, headers, params and token
        final isMultipart = options.data is FormData;
        final methodStr = isMultipart ? '${options.method} (MULTIPART)' : options.method;

        dynamic printableParams;
        if (isMultipart) {
          final formData = options.data as FormData;
          final fieldsMap = Map.fromEntries(formData.fields);
          final filesList = formData.files.map((e) => '${e.key}: ${e.value.filename}').toList();
          printableParams = {
            'fields': fieldsMap,
            if (filesList.isNotEmpty) 'files': filesList,
          };
        } else {
          printableParams = options.data ?? options.queryParameters;
        }

        printLog('--- API Request ---');
        printLog('method : $methodStr');
        printLog('api : ${options.uri}');
        printLog('headers : ${options.headers}');
        printLog('params : $printableParams');
        printLog('token : $token (isRegToken: ${regToken != null})');

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        printLog('--- API Response ---');
        printLog('api : ${response.requestOptions.uri}');
        printLog('response : ${response.data}');

        // Handle Unauthenticated (even if HTTP status is 200, but JSON message/status indicates unauthenticated)
        final isUnauthResponse = response.data is Map &&
            (response.data["message"]?.toString().toLowerCase().contains("unauthenticated") == true ||
                response.data["status"]?.toString().toLowerCase() == "unauthenticated" ||
                response.data["code"]?.toString() == "401");

        if (isUnauthResponse) {
          printLog('Unauthenticated response received. Clearing session and redirecting to login...');

          // Clear session & runtime state
          ApplicationData.isMemberPaid = false;
          try {
            ZegoUIKitPrebuiltCallInvitationService().uninit();
          } catch (_) {}

          // Schedule automatic redirection to login screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final context = ZegoInitializationService.navigatorKey.currentContext;
            if (context != null && context.mounted) {
              GoRouter.of(context).go('/login');
            }
          });

          await AppSessionService.clear();

          // Reject the request to stop the flow in the calling notifier
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              error: 'Unauthenticated',
            ),
          );
        }

        // Normalise the `data` field: the server sends `data: []` (empty List)
        // on error responses, but typed models expect a Map or null.
        // Fixing this here once avoids having to handle it in every repository.
        if (response.data is Map) {
          final raw = response.data as Map<String, dynamic>;
          if (raw.containsKey('data') && raw['data'] is List && (raw['data'] as List).isEmpty) {
            response.data = {...raw, 'data': null};
          }
        }

        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        printLog('onError: ${e.message}');
        
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        final isUnauth = statusCode == 401 ||
            (responseData is Map &&
                responseData["message"]?.toString().toLowerCase().contains("unauthenticated") == true);

        if (isUnauth) {
          printLog('Unauthenticated 401 error. Clearing session and redirecting to login...');
          ApplicationData.isMemberPaid = false;
          try {
            ZegoUIKitPrebuiltCallInvitationService().uninit();
          } catch (_) {}

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final context = ZegoInitializationService.navigatorKey.currentContext;
            if (context != null && context.mounted) {
              GoRouter.of(context).go('/login');
            }
          });

          await AppSessionService.clear();
          return handler.next(e);
        }

        if (statusCode != null && statusCode >= 500) {
          showToast('something_went_wrong_please_try_again_later'.tr);
        } else if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.connectionError) {
          showToast('connection_timeout_please_check_your_internet_connection_and_try_again'.tr);
        }

        // Global resolution for non-401 API errors (500, timeout, connection failures):
        // Resolves response gracefully so repositories receive valid map payloads
        // and Riverpod providers do not enter infinite retry loops.
        final String userFriendlyMessage = (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.sendTimeout ||
                e.type == DioExceptionType.connectionError ||
                e.error.toString().contains('SocketException') ||
                e.error.toString().contains('Failed host lookup'))
            ? 'connection_timeout_please_check_your_internet_connection_and_try_again'.tr
            : (e.message ?? 'something_went_wrong_please_try_again_later'.tr);

        final fallbackData = (responseData is Map<String, dynamic>)
            ? responseData
            : <String, dynamic>{
                "status": "error",
                "message": userFriendlyMessage,
                "data": null,
              };

        return handler.resolve(
          Response(
            requestOptions: e.requestOptions,
            data: fallbackData,
            statusCode: statusCode ?? 500,
          ),
        );
      },
    ),
  );

  return dio;
}
