// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotoNotifier)
final photoProvider = PhotoNotifierProvider._();

final class PhotoNotifierProvider
    extends $NotifierProvider<PhotoNotifier, AsyncValue<void>> {
  PhotoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoNotifierHash();

  @$internal
  @override
  PhotoNotifier create() => PhotoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$photoNotifierHash() => r'7ab7a4b47d751cc50663f97345edb9d6e67979c4';

abstract class _$PhotoNotifier extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
