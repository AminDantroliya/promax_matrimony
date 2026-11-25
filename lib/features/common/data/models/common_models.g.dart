// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppLanguage _$AppLanguageFromJson(Map<String, dynamic> json) => _AppLanguage(
  name: json['name'] as String,
  code: json['code'] as String,
  country: json['country'] as String,
  subtitle: json['subtitle'] as String,
);

Map<String, dynamic> _$AppLanguageToJson(_AppLanguage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'country': instance.country,
      'subtitle': instance.subtitle,
    };

_ConfigData _$ConfigDataFromJson(Map<String, dynamic> json) => _ConfigData(
  androidVersion: _parseString(json['android_version']),
  iosVersion: _parseString(json['ios_version']),
  appUnderMaintenance: _parseString(json['app_under_maintenance']),
  isForceUpdate: _parseBool(json['is_force_update']),
  otpLoginMethod: _parseString(json['otp_login_method']),
);

Map<String, dynamic> _$ConfigDataToJson(_ConfigData instance) =>
    <String, dynamic>{
      'android_version': instance.androidVersion,
      'ios_version': instance.iosVersion,
      'app_under_maintenance': instance.appUnderMaintenance,
      'is_force_update': instance.isForceUpdate,
      'otp_login_method': instance.otpLoginMethod,
    };

_TokenResponseModel _$TokenResponseModelFromJson(Map<String, dynamic> json) =>
    _TokenResponseModel(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ConfigData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenResponseModelToJson(_TokenResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
