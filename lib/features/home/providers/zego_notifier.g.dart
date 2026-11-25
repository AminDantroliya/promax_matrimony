// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zego_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ZegoNotifier)
final zegoProvider = ZegoNotifierProvider._();

final class ZegoNotifierProvider extends $NotifierProvider<ZegoNotifier, void> {
  ZegoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'zegoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$zegoNotifierHash();

  @$internal
  @override
  ZegoNotifier create() => ZegoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$zegoNotifierHash() => r'3b50f7fe1a0a612faadb95453113151cb80e5403';

abstract class _$ZegoNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
