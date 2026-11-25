// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OtherProfileNotifier)
final otherProfileProvider = OtherProfileNotifierFamily._();

final class OtherProfileNotifierProvider
    extends
        $AsyncNotifierProvider<
          OtherProfileNotifier,
          OtherMemberProfileResponseModel
        > {
  OtherProfileNotifierProvider._({
    required OtherProfileNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'otherProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$otherProfileNotifierHash();

  @override
  String toString() {
    return r'otherProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OtherProfileNotifier create() => OtherProfileNotifier();

  @override
  bool operator ==(Object other) {
    return other is OtherProfileNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$otherProfileNotifierHash() =>
    r'1a69f74496959856535dc94cc3e873f100cbc046';

final class OtherProfileNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          OtherProfileNotifier,
          AsyncValue<OtherMemberProfileResponseModel>,
          OtherMemberProfileResponseModel,
          FutureOr<OtherMemberProfileResponseModel>,
          String
        > {
  OtherProfileNotifierFamily._()
    : super(
        retry: null,
        name: r'otherProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OtherProfileNotifierProvider call(String memberId) =>
      OtherProfileNotifierProvider._(argument: memberId, from: this);

  @override
  String toString() => r'otherProfileProvider';
}

abstract class _$OtherProfileNotifier
    extends $AsyncNotifier<OtherMemberProfileResponseModel> {
  late final _$args = ref.$arg as String;
  String get memberId => _$args;

  FutureOr<OtherMemberProfileResponseModel> build(String memberId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<OtherMemberProfileResponseModel>,
              OtherMemberProfileResponseModel
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<OtherMemberProfileResponseModel>,
                OtherMemberProfileResponseModel
              >,
              AsyncValue<OtherMemberProfileResponseModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
