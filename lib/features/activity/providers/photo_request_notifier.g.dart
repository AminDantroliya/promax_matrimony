// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_request_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotoRequestNotifier)
final photoRequestProvider = PhotoRequestNotifierFamily._();

final class PhotoRequestNotifierProvider
    extends $NotifierProvider<PhotoRequestNotifier, PhotoRequestState> {
  PhotoRequestNotifierProvider._({
    required PhotoRequestNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'photoRequestProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$photoRequestNotifierHash();

  @override
  String toString() {
    return r'photoRequestProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PhotoRequestNotifier create() => PhotoRequestNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoRequestState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoRequestState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PhotoRequestNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$photoRequestNotifierHash() =>
    r'47577e6ac29ec9cb561ae494b3726ddd6b8e6360';

final class PhotoRequestNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PhotoRequestNotifier,
          PhotoRequestState,
          PhotoRequestState,
          PhotoRequestState,
          String
        > {
  PhotoRequestNotifierFamily._()
    : super(
        retry: null,
        name: r'photoRequestProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PhotoRequestNotifierProvider call(String type) =>
      PhotoRequestNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'photoRequestProvider';
}

abstract class _$PhotoRequestNotifier extends $Notifier<PhotoRequestState> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  PhotoRequestState build(String type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PhotoRequestState, PhotoRequestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotoRequestState, PhotoRequestState>,
              PhotoRequestState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
