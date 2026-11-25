// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cmsRepository)
final cmsRepositoryProvider = CmsRepositoryProvider._();

final class CmsRepositoryProvider
    extends $FunctionalProvider<CmsRepository, CmsRepository, CmsRepository>
    with $Provider<CmsRepository> {
  CmsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cmsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cmsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CmsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CmsRepository create(Ref ref) {
    return cmsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CmsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CmsRepository>(value),
    );
  }
}

String _$cmsRepositoryHash() => r'5f688e0f700c9dcea31bc177183892900aa7cf51';
