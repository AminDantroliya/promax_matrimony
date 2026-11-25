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
    extends $NotifierProvider<MeetingNotifier, PagingState<Meeting>> {
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
  Override overrideWithValue(PagingState<Meeting> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<Meeting>>(value),
    );
  }
}

String _$meetingNotifierHash() => r'5430c0131043e065b566afa7a0b7dacfb3aa0b42';

abstract class _$MeetingNotifier extends $Notifier<PagingState<Meeting>> {
  PagingState<Meeting> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PagingState<Meeting>, PagingState<Meeting>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PagingState<Meeting>, PagingState<Meeting>>,
              PagingState<Meeting>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
