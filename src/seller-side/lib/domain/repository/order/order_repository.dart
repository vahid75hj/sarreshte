import 'package:equatable/equatable.dart';

import '../../../data/data_provider/order/order_interface.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../data/network/custom_exception.dart';
import '../../exception_handling.dart';
import '../../failure_model.dart';

part 'order_params.dart';

class OrderRepository {
  final OrderDataProvider _dataProvider;
  const OrderRepository({required OrderDataProvider dataProvider}) : _dataProvider = dataProvider;

  ResultData<List<OrderEntity>> getOrders() => resultOf(_dataProvider.getOrders);

  ResultData<OrderEntity> findByCode(String code) => resultOf(() {
    final c = code.trim().toUpperCase();
    for (final o in _dataProvider.getOrders()) {
      if (o.code == c) return o;
    }
    throw NotFoundException(errorMessage: 'سفارش $c پیدا نشد');
  });

  Future<ResultData<OrderEntity>> updateOrder(UpdateOrderParams params) => () async {
    final o = findByCode(params.code).getOrElse((f) => throw NotFoundException(errorMessage: f.message));
    final u = o.copyWith(status: params.status ?? o.status, postalCode: params.postalCode ?? o.postalCode, seen: params.seen ?? o.seen);
    await _dataProvider.saveOrder(u);
    return u;
  }().mapToEither();

  Future<ResultData<OrderEntity>> addOrder(OrderEntity draft) => _dataProvider.addOrder(draft).mapToEither();

  Future<ResultData<void>> resetDemo() => _dataProvider.resetDemo().mapToEither();
}
