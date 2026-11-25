// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedSearchNotifier)
final savedSearchProvider = SavedSearchNotifierProvider._();

final class SavedSearchNotifierProvider
    extends $AsyncNotifierProvider<SavedSearchNotifier, SavedSearchState> {
  SavedSearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedSearchNotifierHash();

  @$internal
  @override
  SavedSearchNotifier create() => SavedSearchNotifier();
}

String _$savedSearchNotifierHash() =>
    r'74bd3c0bf50860891aa5b5acc3e3fed3532e2ee1';

abstract class _$SavedSearchNotifier extends $AsyncNotifier<SavedSearchState> {
  FutureOr<SavedSearchState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SavedSearchState>, SavedSearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SavedSearchState>, SavedSearchState>,
              AsyncValue<SavedSearchState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
