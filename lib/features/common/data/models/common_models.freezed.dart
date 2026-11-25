// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppLanguage {

 String get name; String get code; String get country; String get subtitle;
/// Create a copy of AppLanguage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLanguageCopyWith<AppLanguage> get copyWith => _$AppLanguageCopyWithImpl<AppLanguage>(this as AppLanguage, _$identity);

  /// Serializes this AppLanguage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppLanguage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLanguage&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppLanguage;
  return Object.hash(runtimeType,_this.name,_this.code,_this.country,_this.subtitle);
}

@override
String toString() {
  final _this = this as AppLanguage;
  return 'AppLanguage(name: ${_this.name}, code: ${_this.code}, country: ${_this.country}, subtitle: ${_this.subtitle})';
}


}

/// @nodoc
abstract mixin class $AppLanguageCopyWith<$Res>  {
  factory $AppLanguageCopyWith(AppLanguage value, $Res Function(AppLanguage) _then) = _$AppLanguageCopyWithImpl;
@useResult
$Res call({
 String name, String code, String country, String subtitle
});




}
/// @nodoc
class _$AppLanguageCopyWithImpl<$Res>
    implements $AppLanguageCopyWith<$Res> {
  _$AppLanguageCopyWithImpl(this._self, this._then);

  final AppLanguage _self;
  final $Res Function(AppLanguage) _then;

/// Create a copy of AppLanguage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = null,Object? country = null,Object? subtitle = null,}) {
  return _then(AppLanguage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLanguage].
extension AppLanguagePatterns on AppLanguage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppLanguage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppLanguage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppLanguage value)  $default,){
final _that = this;
switch (_that) {
case _AppLanguage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppLanguage value)?  $default,){
final _that = this;
switch (_that) {
case _AppLanguage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String code,  String country,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppLanguage() when $default != null:
return $default(_that.name,_that.code,_that.country,_that.subtitle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String code,  String country,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _AppLanguage():
return $default(_that.name,_that.code,_that.country,_that.subtitle);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String code,  String country,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _AppLanguage() when $default != null:
return $default(_that.name,_that.code,_that.country,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppLanguage implements AppLanguage {
  const _AppLanguage({required this.name, required this.code, required this.country, required this.subtitle});
  factory _AppLanguage.fromJson(Map<String, dynamic> json) => _$AppLanguageFromJson(json);

@override final  String name;
@override final  String code;
@override final  String country;
@override final  String subtitle;

/// Create a copy of AppLanguage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppLanguageCopyWith<_AppLanguage> get copyWith => __$AppLanguageCopyWithImpl<_AppLanguage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppLanguageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppLanguage&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.country, country) || other.country == country)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,code,country,subtitle);
}

@override
String toString() {
    return 'AppLanguage(name: $name, code: $code, country: $country, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$AppLanguageCopyWith<$Res> implements $AppLanguageCopyWith<$Res> {
  factory _$AppLanguageCopyWith(_AppLanguage value, $Res Function(_AppLanguage) _then) = __$AppLanguageCopyWithImpl;
@override @useResult
$Res call({
 String name, String code, String country, String subtitle
});




}
/// @nodoc
class __$AppLanguageCopyWithImpl<$Res>
    implements _$AppLanguageCopyWith<$Res> {
  __$AppLanguageCopyWithImpl(this._self, this._then);

  final _AppLanguage _self;
  final $Res Function(_AppLanguage) _then;

/// Create a copy of AppLanguage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = null,Object? country = null,Object? subtitle = null,}) {
  return _then(_AppLanguage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ConfigData {

@JsonKey(name: 'android_version', fromJson: _parseString) String? get androidVersion;@JsonKey(name: 'ios_version', fromJson: _parseString) String? get iosVersion;@JsonKey(name: 'app_under_maintenance', fromJson: _parseString) String? get appUnderMaintenance;@JsonKey(name: 'is_force_update', fromJson: _parseBool) bool? get isForceUpdate;@JsonKey(name: 'otp_login_method', fromJson: _parseString) String? get otpLoginMethod;
/// Create a copy of ConfigData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigDataCopyWith<ConfigData> get copyWith => _$ConfigDataCopyWithImpl<ConfigData>(this as ConfigData, _$identity);

  /// Serializes this ConfigData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConfigData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigData&&(identical(other.androidVersion, _this.androidVersion) || other.androidVersion == _this.androidVersion)&&(identical(other.iosVersion, _this.iosVersion) || other.iosVersion == _this.iosVersion)&&(identical(other.appUnderMaintenance, _this.appUnderMaintenance) || other.appUnderMaintenance == _this.appUnderMaintenance)&&(identical(other.isForceUpdate, _this.isForceUpdate) || other.isForceUpdate == _this.isForceUpdate)&&(identical(other.otpLoginMethod, _this.otpLoginMethod) || other.otpLoginMethod == _this.otpLoginMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConfigData;
  return Object.hash(runtimeType,_this.androidVersion,_this.iosVersion,_this.appUnderMaintenance,_this.isForceUpdate,_this.otpLoginMethod);
}

@override
String toString() {
  final _this = this as ConfigData;
  return 'ConfigData(androidVersion: ${_this.androidVersion}, iosVersion: ${_this.iosVersion}, appUnderMaintenance: ${_this.appUnderMaintenance}, isForceUpdate: ${_this.isForceUpdate}, otpLoginMethod: ${_this.otpLoginMethod})';
}


}

/// @nodoc
abstract mixin class $ConfigDataCopyWith<$Res>  {
  factory $ConfigDataCopyWith(ConfigData value, $Res Function(ConfigData) _then) = _$ConfigDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'android_version', fromJson: _parseString) String? androidVersion,@JsonKey(name: 'ios_version', fromJson: _parseString) String? iosVersion,@JsonKey(name: 'app_under_maintenance', fromJson: _parseString) String? appUnderMaintenance,@JsonKey(name: 'is_force_update', fromJson: _parseBool) bool? isForceUpdate,@JsonKey(name: 'otp_login_method', fromJson: _parseString) String? otpLoginMethod
});




}
/// @nodoc
class _$ConfigDataCopyWithImpl<$Res>
    implements $ConfigDataCopyWith<$Res> {
  _$ConfigDataCopyWithImpl(this._self, this._then);

  final ConfigData _self;
  final $Res Function(ConfigData) _then;

/// Create a copy of ConfigData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? androidVersion = freezed,Object? iosVersion = freezed,Object? appUnderMaintenance = freezed,Object? isForceUpdate = freezed,Object? otpLoginMethod = freezed,}) {
  return _then(ConfigData(
androidVersion: freezed == androidVersion ? _self.androidVersion : androidVersion // ignore: cast_nullable_to_non_nullable
as String?,iosVersion: freezed == iosVersion ? _self.iosVersion : iosVersion // ignore: cast_nullable_to_non_nullable
as String?,appUnderMaintenance: freezed == appUnderMaintenance ? _self.appUnderMaintenance : appUnderMaintenance // ignore: cast_nullable_to_non_nullable
as String?,isForceUpdate: freezed == isForceUpdate ? _self.isForceUpdate : isForceUpdate // ignore: cast_nullable_to_non_nullable
as bool?,otpLoginMethod: freezed == otpLoginMethod ? _self.otpLoginMethod : otpLoginMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfigData].
extension ConfigDataPatterns on ConfigData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfigData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfigData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfigData value)  $default,){
final _that = this;
switch (_that) {
case _ConfigData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfigData value)?  $default,){
final _that = this;
switch (_that) {
case _ConfigData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'android_version', fromJson: _parseString)  String? androidVersion, @JsonKey(name: 'ios_version', fromJson: _parseString)  String? iosVersion, @JsonKey(name: 'app_under_maintenance', fromJson: _parseString)  String? appUnderMaintenance, @JsonKey(name: 'is_force_update', fromJson: _parseBool)  bool? isForceUpdate, @JsonKey(name: 'otp_login_method', fromJson: _parseString)  String? otpLoginMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfigData() when $default != null:
return $default(_that.androidVersion,_that.iosVersion,_that.appUnderMaintenance,_that.isForceUpdate,_that.otpLoginMethod);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'android_version', fromJson: _parseString)  String? androidVersion, @JsonKey(name: 'ios_version', fromJson: _parseString)  String? iosVersion, @JsonKey(name: 'app_under_maintenance', fromJson: _parseString)  String? appUnderMaintenance, @JsonKey(name: 'is_force_update', fromJson: _parseBool)  bool? isForceUpdate, @JsonKey(name: 'otp_login_method', fromJson: _parseString)  String? otpLoginMethod)  $default,) {final _that = this;
switch (_that) {
case _ConfigData():
return $default(_that.androidVersion,_that.iosVersion,_that.appUnderMaintenance,_that.isForceUpdate,_that.otpLoginMethod);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'android_version', fromJson: _parseString)  String? androidVersion, @JsonKey(name: 'ios_version', fromJson: _parseString)  String? iosVersion, @JsonKey(name: 'app_under_maintenance', fromJson: _parseString)  String? appUnderMaintenance, @JsonKey(name: 'is_force_update', fromJson: _parseBool)  bool? isForceUpdate, @JsonKey(name: 'otp_login_method', fromJson: _parseString)  String? otpLoginMethod)?  $default,) {final _that = this;
switch (_that) {
case _ConfigData() when $default != null:
return $default(_that.androidVersion,_that.iosVersion,_that.appUnderMaintenance,_that.isForceUpdate,_that.otpLoginMethod);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfigData implements ConfigData {
  const _ConfigData({@JsonKey(name: 'android_version', fromJson: _parseString) this.androidVersion, @JsonKey(name: 'ios_version', fromJson: _parseString) this.iosVersion, @JsonKey(name: 'app_under_maintenance', fromJson: _parseString) this.appUnderMaintenance, @JsonKey(name: 'is_force_update', fromJson: _parseBool) this.isForceUpdate, @JsonKey(name: 'otp_login_method', fromJson: _parseString) this.otpLoginMethod});
  factory _ConfigData.fromJson(Map<String, dynamic> json) => _$ConfigDataFromJson(json);

@override@JsonKey(name: 'android_version', fromJson: _parseString) final  String? androidVersion;
@override@JsonKey(name: 'ios_version', fromJson: _parseString) final  String? iosVersion;
@override@JsonKey(name: 'app_under_maintenance', fromJson: _parseString) final  String? appUnderMaintenance;
@override@JsonKey(name: 'is_force_update', fromJson: _parseBool) final  bool? isForceUpdate;
@override@JsonKey(name: 'otp_login_method', fromJson: _parseString) final  String? otpLoginMethod;

/// Create a copy of ConfigData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfigDataCopyWith<_ConfigData> get copyWith => __$ConfigDataCopyWithImpl<_ConfigData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfigDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfigData&&(identical(other.androidVersion, androidVersion) || other.androidVersion == androidVersion)&&(identical(other.iosVersion, iosVersion) || other.iosVersion == iosVersion)&&(identical(other.appUnderMaintenance, appUnderMaintenance) || other.appUnderMaintenance == appUnderMaintenance)&&(identical(other.isForceUpdate, isForceUpdate) || other.isForceUpdate == isForceUpdate)&&(identical(other.otpLoginMethod, otpLoginMethod) || other.otpLoginMethod == otpLoginMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,androidVersion,iosVersion,appUnderMaintenance,isForceUpdate,otpLoginMethod);
}

@override
String toString() {
    return 'ConfigData(androidVersion: $androidVersion, iosVersion: $iosVersion, appUnderMaintenance: $appUnderMaintenance, isForceUpdate: $isForceUpdate, otpLoginMethod: $otpLoginMethod)';
}


}

/// @nodoc
abstract mixin class _$ConfigDataCopyWith<$Res> implements $ConfigDataCopyWith<$Res> {
  factory _$ConfigDataCopyWith(_ConfigData value, $Res Function(_ConfigData) _then) = __$ConfigDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'android_version', fromJson: _parseString) String? androidVersion,@JsonKey(name: 'ios_version', fromJson: _parseString) String? iosVersion,@JsonKey(name: 'app_under_maintenance', fromJson: _parseString) String? appUnderMaintenance,@JsonKey(name: 'is_force_update', fromJson: _parseBool) bool? isForceUpdate,@JsonKey(name: 'otp_login_method', fromJson: _parseString) String? otpLoginMethod
});




}
/// @nodoc
class __$ConfigDataCopyWithImpl<$Res>
    implements _$ConfigDataCopyWith<$Res> {
  __$ConfigDataCopyWithImpl(this._self, this._then);

  final _ConfigData _self;
  final $Res Function(_ConfigData) _then;

/// Create a copy of ConfigData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? androidVersion = freezed,Object? iosVersion = freezed,Object? appUnderMaintenance = freezed,Object? isForceUpdate = freezed,Object? otpLoginMethod = freezed,}) {
  return _then(_ConfigData(
androidVersion: freezed == androidVersion ? _self.androidVersion : androidVersion // ignore: cast_nullable_to_non_nullable
as String?,iosVersion: freezed == iosVersion ? _self.iosVersion : iosVersion // ignore: cast_nullable_to_non_nullable
as String?,appUnderMaintenance: freezed == appUnderMaintenance ? _self.appUnderMaintenance : appUnderMaintenance // ignore: cast_nullable_to_non_nullable
as String?,isForceUpdate: freezed == isForceUpdate ? _self.isForceUpdate : isForceUpdate // ignore: cast_nullable_to_non_nullable
as bool?,otpLoginMethod: freezed == otpLoginMethod ? _self.otpLoginMethod : otpLoginMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TokenResponseModel {

 int? get code; String? get status; String? get message; ConfigData? get data;
/// Create a copy of TokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenResponseModelCopyWith<TokenResponseModel> get copyWith => _$TokenResponseModelCopyWithImpl<TokenResponseModel>(this as TokenResponseModel, _$identity);

  /// Serializes this TokenResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TokenResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TokenResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as TokenResponseModel;
  return 'TokenResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $TokenResponseModelCopyWith<$Res>  {
  factory $TokenResponseModelCopyWith(TokenResponseModel value, $Res Function(TokenResponseModel) _then) = _$TokenResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, ConfigData? data
});


$ConfigDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$TokenResponseModelCopyWithImpl<$Res>
    implements $TokenResponseModelCopyWith<$Res> {
  _$TokenResponseModelCopyWithImpl(this._self, this._then);

  final TokenResponseModel _self;
  final $Res Function(TokenResponseModel) _then;

/// Create a copy of TokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(TokenResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ConfigData?,
  ));
}
/// Create a copy of TokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfigDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ConfigDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [TokenResponseModel].
extension TokenResponseModelPatterns on TokenResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _TokenResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _TokenResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ConfigData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ConfigData? data)  $default,) {final _that = this;
switch (_that) {
case _TokenResponseModel():
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  ConfigData? data)?  $default,) {final _that = this;
switch (_that) {
case _TokenResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenResponseModel implements TokenResponseModel {
  const _TokenResponseModel({this.code, this.status, this.message, this.data});
  factory _TokenResponseModel.fromJson(Map<String, dynamic> json) => _$TokenResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  ConfigData? data;

/// Create a copy of TokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenResponseModelCopyWith<_TokenResponseModel> get copyWith => __$TokenResponseModelCopyWithImpl<_TokenResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'TokenResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$TokenResponseModelCopyWith<$Res> implements $TokenResponseModelCopyWith<$Res> {
  factory _$TokenResponseModelCopyWith(_TokenResponseModel value, $Res Function(_TokenResponseModel) _then) = __$TokenResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, ConfigData? data
});


@override $ConfigDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$TokenResponseModelCopyWithImpl<$Res>
    implements _$TokenResponseModelCopyWith<$Res> {
  __$TokenResponseModelCopyWithImpl(this._self, this._then);

  final _TokenResponseModel _self;
  final $Res Function(_TokenResponseModel) _then;

/// Create a copy of TokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_TokenResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ConfigData?,
  ));
}

/// Create a copy of TokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfigDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ConfigDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
