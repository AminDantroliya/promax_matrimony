// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_story_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(successStoryRepository)
final successStoryRepositoryProvider = SuccessStoryRepositoryProvider._();

final class SuccessStoryRepositoryProvider
    extends
        $FunctionalProvider<
          SuccessStoryRepository,
          SuccessStoryRepository,
          SuccessStoryRepository
        >
    with $Provider<SuccessStoryRepository> {
  SuccessStoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'successStoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$successStoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<SuccessStoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SuccessStoryRepository create(Ref ref) {
    return successStoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SuccessStoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SuccessStoryRepository>(value),
    );
  }
}

String _$successStoryRepositoryHash() =>
    r'c2b6a35ad83018ecde2ef0475fb7216fa73e71ad';
