// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MeetingNotifier)
final meetingProvider = MeetingNotifierProvider._();

final class MeetingNotifierProvider
    extends $NotifierProvider<MeetingNotifier, PagingState<MemberListModel>> {
  MeetingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meetingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meetingNotifierHash();

  @$internal
  @override
  MeetingNotifier create() => MeetingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<MemberListModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<MemberListModel>>(value),
    );
  }
}

String _$meetingNotifierHash() => r'289c791e8f6864c7a2f744c51bfb4a8fe185fe81';

abstract class _$MeetingNotifier
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
