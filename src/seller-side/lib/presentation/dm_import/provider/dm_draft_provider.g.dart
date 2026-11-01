// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dm_draft_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Draft order extracted from a pasted DM (null until «استخراج سفارش»).

@ProviderFor(DmDraft)
final dmDraftProvider = DmDraftProvider._();

/// Draft order extracted from a pasted DM (null until «استخراج سفارش»).
final class DmDraftProvider extends $NotifierProvider<DmDraft, OrderEntity?> {
  /// Draft order extracted from a pasted DM (null until «استخراج سفارش»).
  DmDraftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dmDraftProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dmDraftHash();

  @$internal
  @override
  DmDraft create() => DmDraft();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderEntity?>(value),
    );
  }
}

String _$dmDraftHash() => r'b74c5dcb0080ca055c9b67656fedd88f3e3ab74a';

/// Draft order extracted from a pasted DM (null until «استخراج سفارش»).

abstract class _$DmDraft extends $Notifier<OrderEntity?> {
  OrderEntity? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OrderEntity?, OrderEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderEntity?, OrderEntity?>,
              OrderEntity?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
