// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
//
// BACKWARD COMPATIBILITY SHIM
// This file re-exports AppConfig from its new canonical location:
//   lib/config/app_config.dart
//
// All existing imports like:
//   import 'package:pro_matrimony/core/config/app_config.dart';
// continue to work without changes.
//
// The appConfigProvider is now in lib/config/providers/config_providers.dart
// but is also re-exported here so legacy code compiles.

export '../../config/app_config.dart';
export '../../config/providers/config_providers.dart' show appConfigProvider;
