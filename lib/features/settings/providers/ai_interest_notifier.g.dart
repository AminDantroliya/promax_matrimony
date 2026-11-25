// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_interest_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AiInterestNotifier)
final aiInterestProvider = AiInterestNotifierProvider._();

final class AiInterestNotifierProvider
    extends $NotifierProvider<AiInterestNotifier, AiInterestState> {
  AiInterestNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiInterestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiInterestNotifierHash();

  @$internal
  @override
  AiInterestNotifier create() => AiInterestNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiInterestState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiInterestState>(value),
    );
  }
}

String _$aiInterestNotifierHash() =>
    r'1f0786a55806b12a0343a5c256ace07245bfd61b';

abstract class _$AiInterestNotifier extends $Notifier<AiInterestState> {
  AiInterestState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AiInterestState, AiInterestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AiInterestState, AiInterestState>,
              AiInterestState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
