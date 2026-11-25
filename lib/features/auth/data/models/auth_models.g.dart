// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    _LoginResponseModel(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: _readLoginData(json, 'data') == null
          ? null
          : LoginData.fromJson(
              _readLoginData(json, 'data') as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$LoginResponseModelToJson(_LoginResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

_LoginData _$LoginDataFromJson(Map<String, dynamic> json) => _LoginData(
  token: json['token'] as String?,
  memberData: json['member_data'] == null
      ? null
      : ProfileData.fromJson(json['member_data'] as Map<String, dynamic>),
  isMatchSwipableProfile: json['is_match_swipable_profile'] as bool?,
);

Map<String, dynamic> _$LoginDataToJson(_LoginData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'member_data': instance.memberData,
      'is_match_swipable_profile': instance.isMatchSwipableProfile,
    };
