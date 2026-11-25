// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dropdownRepository)
final dropdownRepositoryProvider = DropdownRepositoryProvider._();

final class DropdownRepositoryProvider
    extends
        $FunctionalProvider<
          DropdownRepository,
          DropdownRepository,
          DropdownRepository
        >
    with $Provider<DropdownRepository> {
  DropdownRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dropdownRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dropdownRepositoryHash();

  @$internal
  @override
  $ProviderElement<DropdownRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DropdownRepository create(Ref ref) {
    return dropdownRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DropdownRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DropdownRepository>(value),
    );
  }
}

String _$dropdownRepositoryHash() =>
    r'025a5c25dc41373fb105b14c255698ae222dfd04';
