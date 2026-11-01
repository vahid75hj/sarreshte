import '../../entities/order/order_entity.dart';

abstract class OrderDataProvider {
  List<OrderEntity> getOrders();
  Future<void> saveOrder(OrderEntity order);
  /// Assigns the next id and an NR2xxx code, then stores it.
  Future<OrderEntity> addOrder(OrderEntity draft);
  Future<void> resetDemo();
}
