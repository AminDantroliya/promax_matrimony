// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MembershipNotifier)
final membershipProvider = MembershipNotifierProvider._();

final class MembershipNotifierProvider
    extends $NotifierProvider<MembershipNotifier, MembershipState> {
  MembershipNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipNotifierHash();

  @$internal
  @override
  MembershipNotifier create() => MembershipNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MembershipState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MembershipState>(value),
    );
  }
}

String _$membershipNotifierHash() =>
    r'900d71e1d0bf8cf26ea868ba4c5a79096d9380bc';

abstract class _$MembershipNotifier extends $Notifier<MembershipState> {
  MembershipState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MembershipState, MembershipState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MembershipState, MembershipState>,
              MembershipState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
