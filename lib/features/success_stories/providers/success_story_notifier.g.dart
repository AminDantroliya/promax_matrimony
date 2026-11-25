// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_story_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SuccessStoryNotifier)
final successStoryProvider = SuccessStoryNotifierProvider._();

final class SuccessStoryNotifierProvider
    extends $NotifierProvider<SuccessStoryNotifier, PagingState<SuccessStory>> {
  SuccessStoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'successStoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$successStoryNotifierHash();

  @$internal
  @override
  SuccessStoryNotifier create() => SuccessStoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<SuccessStory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<SuccessStory>>(value),
    );
  }
}

String _$successStoryNotifierHash() =>
    r'c79fdb180979bf23b259c29d8bf1c73d96c7f49d';

abstract class _$SuccessStoryNotifier
    extends $Notifier<PagingState<SuccessStory>> {
  PagingState<SuccessStory> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<PagingState<SuccessStory>, PagingState<SuccessStory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PagingState<SuccessStory>, PagingState<SuccessStory>>,
              PagingState<SuccessStory>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(successStoryDetails)
final successStoryDetailsProvider = SuccessStoryDetailsFamily._();

final class SuccessStoryDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SuccessStory>,
          SuccessStory,
          FutureOr<SuccessStory>
        >
    with $FutureModifier<SuccessStory>, $FutureProvider<SuccessStory> {
  SuccessStoryDetailsProvider._({
    required SuccessStoryDetailsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'successStoryDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$successStoryDetailsHash();

  @override
  String toString() {
    return r'successStoryDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SuccessStory> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SuccessStory> create(Ref ref) {
    final argument = this.argument as int;
    return successStoryDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SuccessStoryDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$successStoryDetailsHash() =>
    r'c229989a18b460a5e33330ec217681092b3b02d5';

final class SuccessStoryDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SuccessStory>, int> {
  SuccessStoryDetailsFamily._()
    : super(
        retry: null,
        name: r'successStoryDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SuccessStoryDetailsProvider call(int storyId) =>
      SuccessStoryDetailsProvider._(argument: storyId, from: this);

  @override
  String toString() => r'successStoryDetailsProvider';
}
