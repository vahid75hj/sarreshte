// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reorderDue)
final reorderDueProvider = ReorderDueProvider._();

final class ReorderDueProvider
    extends
        $FunctionalProvider<
          ResultData<List<CustomerStatEntity>>,
          ResultData<List<CustomerStatEntity>>,
          ResultData<List<CustomerStatEntity>>
        >
    with $Provider<ResultData<List<CustomerStatEntity>>> {
  ReorderDueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reorderDueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reorderDueHash();

  @$internal
  @override
  $ProviderElement<ResultData<List<CustomerStatEntity>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResultData<List<CustomerStatEntity>> create(Ref ref) {
    return reorderDue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultData<List<CustomerStatEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<ResultData<List<CustomerStatEntity>>>(value),
    );
  }
}

String _$reorderDueHash() => r'ad302ec5b5ab5f669aec50f66e8f333ce528c37e';

/// Mobiles marked «ارسال کردم».

@ProviderFor(SentReminders)
final sentRemindersProvider = SentRemindersProvider._();

/// Mobiles marked «ارسال کردم».
final class SentRemindersProvider
    extends $NotifierProvider<SentReminders, ResultData<Set<String>>> {
  /// Mobiles marked «ارسال کردم».
  SentRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentRemindersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentRemindersHash();

  @$internal
  @override
  SentReminders create() => SentReminders();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultData<Set<String>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultData<Set<String>>>(value),
    );
  }
}

String _$sentRemindersHash() => r'086356b3b490b9aff6b652c65b6eb2de330505b3';

/// Mobiles marked «ارسال کردم».

abstract class _$SentReminders extends $Notifier<ResultData<Set<String>>> {
  ResultData<Set<String>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ResultData<Set<String>>, ResultData<Set<String>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResultData<Set<String>>, ResultData<Set<String>>>,
              ResultData<Set<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
