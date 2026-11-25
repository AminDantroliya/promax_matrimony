// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyProfileNotifier)
final myProfileProvider = MyProfileNotifierProvider._();

final class MyProfileNotifierProvider
    extends $AsyncNotifierProvider<MyProfileNotifier, ProfileData?> {
  MyProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProfileNotifierHash();

  @$internal
  @override
  MyProfileNotifier create() => MyProfileNotifier();
}

String _$myProfileNotifierHash() => r'e9184005d9d14ae7b9638381c7705445dbdfff6f';

abstract class _$MyProfileNotifier extends $AsyncNotifier<ProfileData?> {
  FutureOr<ProfileData?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProfileData?>, ProfileData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileData?>, ProfileData?>,
              AsyncValue<ProfileData?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(OtherProfileNotifier)
final otherProfileProvider = OtherProfileNotifierFamily._();

final class OtherProfileNotifierProvider
    extends $AsyncNotifierProvider<OtherProfileNotifier, ProfileData?> {
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
    r'6ae5504db664507a7618c17b73a9208d45c9273b';

final class OtherProfileNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          OtherProfileNotifier,
          AsyncValue<ProfileData?>,
          ProfileData?,
          FutureOr<ProfileData?>,
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

abstract class _$OtherProfileNotifier extends $AsyncNotifier<ProfileData?> {
  late final _$args = ref.$arg as String;
  String get memberId => _$args;

  FutureOr<ProfileData?> build(String memberId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProfileData?>, ProfileData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileData?>, ProfileData?>,
              AsyncValue<ProfileData?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
