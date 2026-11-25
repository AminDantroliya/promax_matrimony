import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../profile/data/models/profile_models.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    int? code,
    String? status,
    String? message,
    @JsonKey(readValue: _readLoginData) LoginData? data,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

Object? _readLoginData(Map json, String key) {
  final value = json[key];
  if (value is List) {
    return null;
  }
  return value;
}

@freezed
abstract class LoginData with _$LoginData {
  const factory LoginData({
    String? token,
    @JsonKey(name: 'member_data') ProfileData? memberData,
    @JsonKey(name: 'is_match_swipable_profile') bool? isMatchSwipableProfile,
  }) = _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}
