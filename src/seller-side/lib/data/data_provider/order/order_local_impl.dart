import '../../entities/order/order_entity.dart';
import '../../network/custom_exception.dart';
import '../seed/demo_seed.dart';
import '../storage/storage_interface.dart';
import 'order_interface.dart';

class OrderLocalDataProviderImpl implements OrderDataProvider {
  final StorageDataProvider _storage;
  OrderLocalDataProviderImpl({required StorageDataProvider storage}) : _storage = storage;

  @override
  List<OrderEntity> getOrders() => _storage.read().orders;

  @override
  Future<void> saveOrder(OrderEntity order) async {
    final s = _storage.read();
    final i = s.orders.indexWhere((o) => o.code == order.code);
    if (i < 0) throw NotFoundException(errorMessage: 'سفارش ${order.code} پیدا نشد');
    await _storage.write(s.copyWith(orders: [...s.orders]..[i] = order));
  }

  @override
  Future<OrderEntity> addOrder(OrderEntity draft) async {
    final s = _storage.read();
    final id = s.orders.fold(0, (m, x) => x.id > m ? x.id : m) + 1;
    final o = draft.copyWith(id: id, code: 'NR${2000 + id}');
    await _storage.write(s.copyWith(orders: [...s.orders, o]));
    return o;
  }

  @override
  Future<void> resetDemo() => _storage.write(DemoSeed.build());
}
