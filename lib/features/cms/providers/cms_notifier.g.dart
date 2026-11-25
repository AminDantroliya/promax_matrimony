// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CMSNotifier)
final cMSProvider = CMSNotifierFamily._();

final class CMSNotifierProvider
    extends $AsyncNotifierProvider<CMSNotifier, CmsData?> {
  CMSNotifierProvider._({
    required CMSNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cMSProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cMSNotifierHash();

  @override
  String toString() {
    return r'cMSProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CMSNotifier create() => CMSNotifier();

  @override
  bool operator ==(Object other) {
    return other is CMSNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cMSNotifierHash() => r'783f6ac4119c12e5ddeeb76d03d21b61bcd909db';

final class CMSNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CMSNotifier,
          AsyncValue<CmsData?>,
          CmsData?,
          FutureOr<CmsData?>,
          String
        > {
  CMSNotifierFamily._()
    : super(
        retry: null,
        name: r'cMSProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CMSNotifierProvider call(String pageName) =>
      CMSNotifierProvider._(argument: pageName, from: this);

  @override
  String toString() => r'cMSProvider';
}

abstract class _$CMSNotifier extends $AsyncNotifier<CmsData?> {
  late final _$args = ref.$arg as String;
  String get pageName => _$args;

  FutureOr<CmsData?> build(String pageName);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CmsData?>, CmsData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CmsData?>, CmsData?>,
              AsyncValue<CmsData?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
