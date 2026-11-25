// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConnectionNotifier)
final connectionProvider = ConnectionNotifierFamily._();

final class ConnectionNotifierProvider
    extends $NotifierProvider<ConnectionNotifier, ConnectionState> {
  ConnectionNotifierProvider._({
    required ConnectionNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'connectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$connectionNotifierHash();

  @override
  String toString() {
    return r'connectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ConnectionNotifier create() => ConnectionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ConnectionNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$connectionNotifierHash() =>
    r'aeabcd93f7fd7e7fc4fca64e2fb79242facc18ed';

final class ConnectionNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ConnectionNotifier,
          ConnectionState,
          ConnectionState,
          ConnectionState,
          String
        > {
  ConnectionNotifierFamily._()
    : super(
        retry: null,
        name: r'connectionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConnectionNotifierProvider call(String type) =>
      ConnectionNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'connectionProvider';
}

abstract class _$ConnectionNotifier extends $Notifier<ConnectionState> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  ConnectionState build(String type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ConnectionState, ConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConnectionState, ConnectionState>,
              ConnectionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
