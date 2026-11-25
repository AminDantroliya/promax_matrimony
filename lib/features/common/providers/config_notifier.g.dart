// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConfigNotifier)
final configProvider = ConfigNotifierProvider._();

final class ConfigNotifierProvider
    extends $NotifierProvider<ConfigNotifier, ConfigState> {
  ConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configNotifierHash();

  @$internal
  @override
  ConfigNotifier create() => ConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConfigState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConfigState>(value),
    );
  }
}

String _$configNotifierHash() => r'cc5db0550e132af8cc36512c424e98251bec868c';

abstract class _$ConfigNotifier extends $Notifier<ConfigState> {
  ConfigState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ConfigState, ConfigState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConfigState, ConfigState>,
              ConfigState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
