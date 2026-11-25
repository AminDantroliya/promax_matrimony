// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PrivacySettingsNotifier)
final privacySettingsProvider = PrivacySettingsNotifierProvider._();

final class PrivacySettingsNotifierProvider
    extends
        $AsyncNotifierProvider<PrivacySettingsNotifier, PrivacySettingsData?> {
  PrivacySettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'privacySettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$privacySettingsNotifierHash();

  @$internal
  @override
  PrivacySettingsNotifier create() => PrivacySettingsNotifier();
}

String _$privacySettingsNotifierHash() =>
    r'8dc9c5bababa562b9e90e8f97963b4b22f58cdde';

abstract class _$PrivacySettingsNotifier
    extends $AsyncNotifier<PrivacySettingsData?> {
  FutureOr<PrivacySettingsData?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<PrivacySettingsData?>, PrivacySettingsData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PrivacySettingsData?>,
                PrivacySettingsData?
              >,
              AsyncValue<PrivacySettingsData?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
