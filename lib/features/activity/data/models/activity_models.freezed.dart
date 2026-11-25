// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityProfileListResponseModel {

 int? get code; String? get status; String? get message; ActivityData? get data;
/// Create a copy of ActivityProfileListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityProfileListResponseModelCopyWith<ActivityProfileListResponseModel> get copyWith => _$ActivityProfileListResponseModelCopyWithImpl<ActivityProfileListResponseModel>(this as ActivityProfileListResponseModel, _$identity);

  /// Serializes this ActivityProfileListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityProfileListResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityProfileListResponseModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityProfileListResponseModel;
  return Object.hash(runtimeType,_this.code,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as ActivityProfileListResponseModel;
  return 'ActivityProfileListResponseModel(code: ${_this.code}, status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ActivityProfileListResponseModelCopyWith<$Res>  {
  factory $ActivityProfileListResponseModelCopyWith(ActivityProfileListResponseModel value, $Res Function(ActivityProfileListResponseModel) _then) = _$ActivityProfileListResponseModelCopyWithImpl;
@useResult
$Res call({
 int? code, String? status, String? message, ActivityData? data
});


$ActivityDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ActivityProfileListResponseModelCopyWithImpl<$Res>
    implements $ActivityProfileListResponseModelCopyWith<$Res> {
  _$ActivityProfileListResponseModelCopyWithImpl(this._self, this._then);

  final ActivityProfileListResponseModel _self;
  final $Res Function(ActivityProfileListResponseModel) _then;

/// Create a copy of ActivityProfileListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(ActivityProfileListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ActivityData?,
  ));
}
/// Create a copy of ActivityProfileListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ActivityDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityProfileListResponseModel].
extension ActivityProfileListResponseModelPatterns on ActivityProfileListResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityProfileListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityProfileListResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityProfileListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ActivityProfileListResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityProfileListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityProfileListResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ActivityData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityProfileListResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? status,  String? message,  ActivityData? data)  $default,) {final _that = this;
switch (_that) {
case _ActivityProfileListResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? status,  String? message,  ActivityData? data)?  $default,) {final _that = this;
switch (_that) {
case _ActivityProfileListResponseModel() when $default != null:
return $default(_that.code,_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityProfileListResponseModel implements ActivityProfileListResponseModel {
  const _ActivityProfileListResponseModel({this.code, this.status, this.message, this.data});
  factory _ActivityProfileListResponseModel.fromJson(Map<String, dynamic> json) => _$ActivityProfileListResponseModelFromJson(json);

@override final  int? code;
@override final  String? status;
@override final  String? message;
@override final  ActivityData? data;

/// Create a copy of ActivityProfileListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityProfileListResponseModelCopyWith<_ActivityProfileListResponseModel> get copyWith => __$ActivityProfileListResponseModelCopyWithImpl<_ActivityProfileListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityProfileListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityProfileListResponseModel&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,status,message,data);
}

@override
String toString() {
    return 'ActivityProfileListResponseModel(code: $code, status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ActivityProfileListResponseModelCopyWith<$Res> implements $ActivityProfileListResponseModelCopyWith<$Res> {
  factory _$ActivityProfileListResponseModelCopyWith(_ActivityProfileListResponseModel value, $Res Function(_ActivityProfileListResponseModel) _then) = __$ActivityProfileListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? status, String? message, ActivityData? data
});


@override $ActivityDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ActivityProfileListResponseModelCopyWithImpl<$Res>
    implements _$ActivityProfileListResponseModelCopyWith<$Res> {
  __$ActivityProfileListResponseModelCopyWithImpl(this._self, this._then);

  final _ActivityProfileListResponseModel _self;
  final $Res Function(_ActivityProfileListResponseModel) _then;

/// Create a copy of ActivityProfileListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_ActivityProfileListResponseModel(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ActivityData?,
  ));
}

/// Create a copy of ActivityProfileListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ActivityDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ActivityData {

 int? get resultCount;@JsonKey(name: 'resultArr', readValue: _readResultList) List<MemberListModel>? get resultArr; int? get sentCount; int? get receivedCount; int? get acceptedCount; int? get pendingReceivedCount; int? get incomingCount; int? get outgoingCount; int? get missedCount;
/// Create a copy of ActivityData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityDataCopyWith<ActivityData> get copyWith => _$ActivityDataCopyWithImpl<ActivityData>(this as ActivityData, _$identity);

  /// Serializes this ActivityData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityData&&(identical(other.resultCount, _this.resultCount) || other.resultCount == _this.resultCount)&&const DeepCollectionEquality().equals(other.resultArr, _this.resultArr)&&(identical(other.sentCount, _this.sentCount) || other.sentCount == _this.sentCount)&&(identical(other.receivedCount, _this.receivedCount) || other.receivedCount == _this.receivedCount)&&(identical(other.acceptedCount, _this.acceptedCount) || other.acceptedCount == _this.acceptedCount)&&(identical(other.pendingReceivedCount, _this.pendingReceivedCount) || other.pendingReceivedCount == _this.pendingReceivedCount)&&(identical(other.incomingCount, _this.incomingCount) || other.incomingCount == _this.incomingCount)&&(identical(other.outgoingCount, _this.outgoingCount) || other.outgoingCount == _this.outgoingCount)&&(identical(other.missedCount, _this.missedCount) || other.missedCount == _this.missedCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityData;
  return Object.hash(runtimeType,_this.resultCount,const DeepCollectionEquality().hash(_this.resultArr),_this.sentCount,_this.receivedCount,_this.acceptedCount,_this.pendingReceivedCount,_this.incomingCount,_this.outgoingCount,_this.missedCount);
}

@override
String toString() {
  final _this = this as ActivityData;
  return 'ActivityData(resultCount: ${_this.resultCount}, resultArr: ${_this.resultArr}, sentCount: ${_this.sentCount}, receivedCount: ${_this.receivedCount}, acceptedCount: ${_this.acceptedCount}, pendingReceivedCount: ${_this.pendingReceivedCount}, incomingCount: ${_this.incomingCount}, outgoingCount: ${_this.outgoingCount}, missedCount: ${_this.missedCount})';
}


}

/// @nodoc
abstract mixin class $ActivityDataCopyWith<$Res>  {
  factory $ActivityDataCopyWith(ActivityData value, $Res Function(ActivityData) _then) = _$ActivityDataCopyWithImpl;
@useResult
$Res call({
 int? resultCount,@JsonKey(name: 'resultArr', readValue: _readResultList) List<MemberListModel>? resultArr, int? sentCount, int? receivedCount, int? acceptedCount, int? pendingReceivedCount, int? incomingCount, int? outgoingCount, int? missedCount
});




}
/// @nodoc
class _$ActivityDataCopyWithImpl<$Res>
    implements $ActivityDataCopyWith<$Res> {
  _$ActivityDataCopyWithImpl(this._self, this._then);

  final ActivityData _self;
  final $Res Function(ActivityData) _then;

/// Create a copy of ActivityData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultCount = freezed,Object? resultArr = freezed,Object? sentCount = freezed,Object? receivedCount = freezed,Object? acceptedCount = freezed,Object? pendingReceivedCount = freezed,Object? incomingCount = freezed,Object? outgoingCount = freezed,Object? missedCount = freezed,}) {
  return _then(ActivityData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultArr: freezed == resultArr ? _self.resultArr : resultArr // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,sentCount: freezed == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int?,receivedCount: freezed == receivedCount ? _self.receivedCount : receivedCount // ignore: cast_nullable_to_non_nullable
as int?,acceptedCount: freezed == acceptedCount ? _self.acceptedCount : acceptedCount // ignore: cast_nullable_to_non_nullable
as int?,pendingReceivedCount: freezed == pendingReceivedCount ? _self.pendingReceivedCount : pendingReceivedCount // ignore: cast_nullable_to_non_nullable
as int?,incomingCount: freezed == incomingCount ? _self.incomingCount : incomingCount // ignore: cast_nullable_to_non_nullable
as int?,outgoingCount: freezed == outgoingCount ? _self.outgoingCount : outgoingCount // ignore: cast_nullable_to_non_nullable
as int?,missedCount: freezed == missedCount ? _self.missedCount : missedCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityData].
extension ActivityDataPatterns on ActivityData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityData value)  $default,){
final _that = this;
switch (_that) {
case _ActivityData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityData value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<MemberListModel>? resultArr,  int? sentCount,  int? receivedCount,  int? acceptedCount,  int? pendingReceivedCount,  int? incomingCount,  int? outgoingCount,  int? missedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityData() when $default != null:
return $default(_that.resultCount,_that.resultArr,_that.sentCount,_that.receivedCount,_that.acceptedCount,_that.pendingReceivedCount,_that.incomingCount,_that.outgoingCount,_that.missedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<MemberListModel>? resultArr,  int? sentCount,  int? receivedCount,  int? acceptedCount,  int? pendingReceivedCount,  int? incomingCount,  int? outgoingCount,  int? missedCount)  $default,) {final _that = this;
switch (_that) {
case _ActivityData():
return $default(_that.resultCount,_that.resultArr,_that.sentCount,_that.receivedCount,_that.acceptedCount,_that.pendingReceivedCount,_that.incomingCount,_that.outgoingCount,_that.missedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<MemberListModel>? resultArr,  int? sentCount,  int? receivedCount,  int? acceptedCount,  int? pendingReceivedCount,  int? incomingCount,  int? outgoingCount,  int? missedCount)?  $default,) {final _that = this;
switch (_that) {
case _ActivityData() when $default != null:
return $default(_that.resultCount,_that.resultArr,_that.sentCount,_that.receivedCount,_that.acceptedCount,_that.pendingReceivedCount,_that.incomingCount,_that.outgoingCount,_that.missedCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityData implements ActivityData {
  const _ActivityData({this.resultCount, @JsonKey(name: 'resultArr', readValue: _readResultList)  List<MemberListModel>? resultArr, this.sentCount, this.receivedCount, this.acceptedCount, this.pendingReceivedCount, this.incomingCount, this.outgoingCount, this.missedCount}): _resultArr = resultArr;
  factory _ActivityData.fromJson(Map<String, dynamic> json) => _$ActivityDataFromJson(json);

@override final  int? resultCount;
 final  List<MemberListModel>? _resultArr;
@override@JsonKey(name: 'resultArr', readValue: _readResultList) List<MemberListModel>? get resultArr {
  final value = _resultArr;
  if (value == null) return null;
  if (_resultArr is EqualUnmodifiableListView) return _resultArr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? sentCount;
@override final  int? receivedCount;
@override final  int? acceptedCount;
@override final  int? pendingReceivedCount;
@override final  int? incomingCount;
@override final  int? outgoingCount;
@override final  int? missedCount;

/// Create a copy of ActivityData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityDataCopyWith<_ActivityData> get copyWith => __$ActivityDataCopyWithImpl<_ActivityData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityData&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount)&&const DeepCollectionEquality().equals(other.resultArr, _resultArr)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.receivedCount, receivedCount) || other.receivedCount == receivedCount)&&(identical(other.acceptedCount, acceptedCount) || other.acceptedCount == acceptedCount)&&(identical(other.pendingReceivedCount, pendingReceivedCount) || other.pendingReceivedCount == pendingReceivedCount)&&(identical(other.incomingCount, incomingCount) || other.incomingCount == incomingCount)&&(identical(other.outgoingCount, outgoingCount) || other.outgoingCount == outgoingCount)&&(identical(other.missedCount, missedCount) || other.missedCount == missedCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resultCount,const DeepCollectionEquality().hash(_resultArr),sentCount,receivedCount,acceptedCount,pendingReceivedCount,incomingCount,outgoingCount,missedCount);
}

@override
String toString() {
    return 'ActivityData(resultCount: $resultCount, resultArr: $resultArr, sentCount: $sentCount, receivedCount: $receivedCount, acceptedCount: $acceptedCount, pendingReceivedCount: $pendingReceivedCount, incomingCount: $incomingCount, outgoingCount: $outgoingCount, missedCount: $missedCount)';
}


}

/// @nodoc
abstract mixin class _$ActivityDataCopyWith<$Res> implements $ActivityDataCopyWith<$Res> {
  factory _$ActivityDataCopyWith(_ActivityData value, $Res Function(_ActivityData) _then) = __$ActivityDataCopyWithImpl;
@override @useResult
$Res call({
 int? resultCount,@JsonKey(name: 'resultArr', readValue: _readResultList) List<MemberListModel>? resultArr, int? sentCount, int? receivedCount, int? acceptedCount, int? pendingReceivedCount, int? incomingCount, int? outgoingCount, int? missedCount
});




}
/// @nodoc
class __$ActivityDataCopyWithImpl<$Res>
    implements _$ActivityDataCopyWith<$Res> {
  __$ActivityDataCopyWithImpl(this._self, this._then);

  final _ActivityData _self;
  final $Res Function(_ActivityData) _then;

/// Create a copy of ActivityData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultCount = freezed,Object? resultArr = freezed,Object? sentCount = freezed,Object? receivedCount = freezed,Object? acceptedCount = freezed,Object? pendingReceivedCount = freezed,Object? incomingCount = freezed,Object? outgoingCount = freezed,Object? missedCount = freezed,}) {
  return _then(_ActivityData(
resultCount: freezed == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int?,resultArr: freezed == resultArr ? _self._resultArr : resultArr // ignore: cast_nullable_to_non_nullable
as List<MemberListModel>?,sentCount: freezed == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int?,receivedCount: freezed == receivedCount ? _self.receivedCount : receivedCount // ignore: cast_nullable_to_non_nullable
as int?,acceptedCount: freezed == acceptedCount ? _self.acceptedCount : acceptedCount // ignore: cast_nullable_to_non_nullable
as int?,pendingReceivedCount: freezed == pendingReceivedCount ? _self.pendingReceivedCount : pendingReceivedCount // ignore: cast_nullable_to_non_nullable
as int?,incomingCount: freezed == incomingCount ? _self.incomingCount : incomingCount // ignore: cast_nullable_to_non_nullable
as int?,outgoingCount: freezed == outgoingCount ? _self.outgoingCount : outgoingCount // ignore: cast_nullable_to_non_nullable
as int?,missedCount: freezed == missedCount ? _self.missedCount : missedCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
