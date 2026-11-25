import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_models.freezed.dart';
part 'common_models.g.dart';

@freezed
abstract class AppLanguage with _$AppLanguage {
  const factory AppLanguage({
    required String name,
    required String code,
    required String country,
    required String subtitle,
  }) = _AppLanguage;

  factory AppLanguage.fromJson(Map<String, dynamic> json) =>
      _$AppLanguageFromJson(json);
}
String? _parseString(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value ? "Yes" : "No";
  return value.toString();
}

bool? _parseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  final str = value.toString().toLowerCase().trim();
  return str == "true" || str == "yes" || str == "1";
}

@freezed
abstract class ConfigData with _$ConfigData {
  const factory ConfigData({
    @JsonKey(name: 'android_version', fromJson: _parseString) String? androidVersion,
    @JsonKey(name: 'ios_version', fromJson: _parseString) String? iosVersion,
    @JsonKey(name: 'app_under_maintenance', fromJson: _parseString) String? appUnderMaintenance,
    @JsonKey(name: 'is_force_update', fromJson: _parseBool) bool? isForceUpdate,
    @JsonKey(name: 'otp_login_method', fromJson: _parseString) String? otpLoginMethod,
  }) = _ConfigData;

  factory ConfigData.fromJson(Map<String, dynamic> json) =>
      _$ConfigDataFromJson(json);
}

@freezed
abstract class TokenResponseModel with _$TokenResponseModel {
  const factory TokenResponseModel({
    int? code,
    String? status,
    String? message,
    ConfigData? data,
  }) = _TokenResponseModel;

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseModelFromJson(json);
}
