// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_board_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Chip / search / date filter of the orders tab. Auto-disposed with the tab, like the old widget state.

@ProviderFor(OrderBoardFilterNotifier)
final orderBoardFilterProvider = OrderBoardFilterNotifierProvider._();

/// Chip / search / date filter of the orders tab. Auto-disposed with the tab, like the old widget state.
final class OrderBoardFilterNotifierProvider
    extends $NotifierProvider<OrderBoardFilterNotifier, OrderBoardFilter> {
  /// Chip / search / date filter of the orders tab. Auto-disposed with the tab, like the old widget state.
  OrderBoardFilterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderBoardFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderBoardFilterNotifierHash();

  @$internal
  @override
  OrderBoardFilterNotifier create() => OrderBoardFilterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderBoardFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderBoardFilter>(value),
    );
  }
}

String _$orderBoardFilterNotifierHash() =>
    r'31b91b3fd27abe0b39d389e8a79164961f1f7a79';

/// Chip / search / date filter of the orders tab. Auto-disposed with the tab, like the old widget state.

abstract class _$OrderBoardFilterNotifier extends $Notifier<OrderBoardFilter> {
  OrderBoardFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OrderBoardFilter, OrderBoardFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderBoardFilter, OrderBoardFilter>,
              OrderBoardFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
