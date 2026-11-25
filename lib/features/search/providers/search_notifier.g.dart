// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchCriteriaNotifier)
final searchCriteriaProvider = SearchCriteriaNotifierProvider._();

final class SearchCriteriaNotifierProvider
    extends $NotifierProvider<SearchCriteriaNotifier, SearchCriteria> {
  SearchCriteriaNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchCriteriaProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchCriteriaNotifierHash();

  @$internal
  @override
  SearchCriteriaNotifier create() => SearchCriteriaNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchCriteria value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchCriteria>(value),
    );
  }
}

String _$searchCriteriaNotifierHash() =>
    r'7f372e62ee0262884b3c812cf739336a8837a13c';

abstract class _$SearchCriteriaNotifier extends $Notifier<SearchCriteria> {
  SearchCriteria build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SearchCriteria, SearchCriteria>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchCriteria, SearchCriteria>,
              SearchCriteria,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchResultNotifier)
final searchResultProvider = SearchResultNotifierProvider._();

final class SearchResultNotifierProvider
    extends
        $NotifierProvider<SearchResultNotifier, PagingState<MemberListModel>> {
  SearchResultNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultNotifierHash();

  @$internal
  @override
  SearchResultNotifier create() => SearchResultNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<MemberListModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<MemberListModel>>(value),
    );
  }
}

String _$searchResultNotifierHash() =>
    r'5296faeb55dae5adfe5fd35f4275b2673ac050f7';

abstract class _$SearchResultNotifier
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

@ProviderFor(SavedSearchNotifier)
final savedSearchProvider = SavedSearchNotifierProvider._();

final class SavedSearchNotifierProvider
    extends
        $NotifierProvider<SavedSearchNotifier, PagingState<SavedSearchFilter>> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<SavedSearchFilter> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<SavedSearchFilter>>(
        value,
      ),
    );
  }
}

String _$savedSearchNotifierHash() =>
    r'277726139d3b106ca39e30d271b96f14cd66e007';

abstract class _$SavedSearchNotifier
    extends $Notifier<PagingState<SavedSearchFilter>> {
  PagingState<SavedSearchFilter> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              PagingState<SavedSearchFilter>,
              PagingState<SavedSearchFilter>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                PagingState<SavedSearchFilter>,
                PagingState<SavedSearchFilter>
              >,
              PagingState<SavedSearchFilter>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
