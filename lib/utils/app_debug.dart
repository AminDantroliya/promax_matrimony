import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import '../core/config/env_config.dart';

bool get isProductionMode => !EnvConfig.enableLogging;

void printLog(dynamic object) {
  if (EnvConfig.enableLogging) {
    debugPrint("Debug [${EnvConfig.envName}] : => $object");
  }
}

void printParamLog(Map<String, dynamic> params) {
  if (EnvConfig.enableLogging) {
    params.forEach((key, value) {
      debugPrint("Debug [${EnvConfig.envName}] : => $key:$value");
    });
  }
}

void printDioParamLog(dio.FormData params) {
  if (EnvConfig.enableLogging) {
    for (var element in params.files) {
      final file = element.value;
      debugPrint("Debug [${EnvConfig.envName}] : => ${element.key}:${file.filename}");
    }
  }
}

void printObjectLog(Object? params) {
  if (EnvConfig.enableLogging && params is Map<String, dynamic>) {
    final buffer = StringBuffer(
      "Debug Params [${EnvConfig.envName}] : =>"
          "\n----------------------------",
    );

    params.forEach((key, value) {
      buffer.write("\n  ${key.toString()}:${value.toString()}");
    });

    debugPrint(
      "${buffer.toString()}"
          "\n----------------------------",
    );
  }
}
