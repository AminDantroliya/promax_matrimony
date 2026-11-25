// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerificationNotifier)
final verificationProvider = VerificationNotifierProvider._();

final class VerificationNotifierProvider
    extends $NotifierProvider<VerificationNotifier, VerificationState> {
  VerificationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verificationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verificationNotifierHash();

  @$internal
  @override
  VerificationNotifier create() => VerificationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerificationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerificationState>(value),
    );
  }
}

String _$verificationNotifierHash() =>
    r'0c5b9573352f7ae10ab7d5cb122c7554bfdd7acf';

abstract class _$VerificationNotifier extends $Notifier<VerificationState> {
  VerificationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<VerificationState, VerificationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VerificationState, VerificationState>,
              VerificationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
