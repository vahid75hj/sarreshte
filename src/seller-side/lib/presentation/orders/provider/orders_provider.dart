import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/order/order_entity.dart';
import '../../../domain/failure_model.dart';
import '../../../domain/repository/order/order_repository.dart';
import '../../../domain/use_case/order/add_order.dart';
import '../../../domain/use_case/order/get_orders.dart';
import '../../../domain/use_case/order/reset_demo_data.dart';
import '../../../domain/use_case/order/update_order.dart';

part 'orders_provider.g.dart';

/// All orders (single source of truth for the orders, archive, customers and reorder screens).
@Riverpod(keepAlive: true)
class Orders extends _$Orders {
  @override
  ResultData<List<OrderEntity>> build() => GetIt.I<GetOrdersUseCase>()();

  Future<ResultData<OrderEntity>> updateOrder(UpdateOrderParams params) async {
    final r = await GetIt.I<UpdateOrderUseCase>()(params);
    ref.invalidateSelf();
    return r;
  }

  Future<ResultData<OrderEntity>> add(OrderEntity draft) async {
    final r = await GetIt.I<AddOrderUseCase>()(draft);
    ref.invalidateSelf();
    return r;
  }

  Future<void> resetDemo() async {
    await GetIt.I<ResetDemoDataUseCase>()();
    ref.invalidateSelf();
  }
}
