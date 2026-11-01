// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All orders (single source of truth for the orders, archive, customers and reorder screens).

@ProviderFor(Orders)
final ordersProvider = OrdersProvider._();

/// All orders (single source of truth for the orders, archive, customers and reorder screens).
final class OrdersProvider
    extends $NotifierProvider<Orders, ResultData<List<OrderEntity>>> {
  /// All orders (single source of truth for the orders, archive, customers and reorder screens).
  OrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersHash();

  @$internal
  @override
  Orders create() => Orders();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultData<List<OrderEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultData<List<OrderEntity>>>(
        value,
      ),
    );
  }
}

String _$ordersHash() => r'98656edcc287261abfff11d59869aa180eea41b2';

/// All orders (single source of truth for the orders, archive, customers and reorder screens).

abstract class _$Orders extends $Notifier<ResultData<List<OrderEntity>>> {
  ResultData<List<OrderEntity>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ResultData<List<OrderEntity>>,
              ResultData<List<OrderEntity>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ResultData<List<OrderEntity>>,
                ResultData<List<OrderEntity>>
              >,
              ResultData<List<OrderEntity>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
