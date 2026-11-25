// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchResultNotifier)
final searchResultProvider = SearchResultNotifierProvider._();

final class SearchResultNotifierProvider
    extends $AsyncNotifierProvider<SearchResultNotifier, SearchResultState> {
  SearchResultNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultNotifierHash();

  @$internal
  @override
  SearchResultNotifier create() => SearchResultNotifier();
}

String _$searchResultNotifierHash() =>
    r'6176e3e4f9427d7bdd0578403fa03dabc531b9c2';

abstract class _$SearchResultNotifier
    extends $AsyncNotifier<SearchResultState> {
  FutureOr<SearchResultState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SearchResultState>, SearchResultState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SearchResultState>, SearchResultState>,
              AsyncValue<SearchResultState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
