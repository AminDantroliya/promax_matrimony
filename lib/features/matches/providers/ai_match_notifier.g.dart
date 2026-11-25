// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_match_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AiMatchNotifier)
final aiMatchProvider = AiMatchNotifierProvider._();

final class AiMatchNotifierProvider
    extends $NotifierProvider<AiMatchNotifier, PagingState<MemberListModel>> {
  AiMatchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiMatchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiMatchNotifierHash();

  @$internal
  @override
  AiMatchNotifier create() => AiMatchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<MemberListModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<MemberListModel>>(value),
    );
  }
}

String _$aiMatchNotifierHash() => r'ed44f48f42ec161494ad9f68d6f9deb6ee7f681d';

abstract class _$AiMatchNotifier
    extends $Notifier<PagingState<MemberListModel>> {
  PagingState<MemberListModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<PagingState<MemberListModel>, PagingState<MemberListModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                PagingState<MemberListModel>,
                PagingState<MemberListModel>
              >,
              PagingState<MemberListModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
