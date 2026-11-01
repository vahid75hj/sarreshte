import '../../../data/data_provider/order/order_interface.dart';
import '../../../data/entities/customer/customer_detail_entity.dart';
import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../data/network/custom_exception.dart';
import '../../exception_handling.dart';
import '../../failure_model.dart';

/// Customers are not stored; they are derived from orders (grouped by mobile).
class CustomerRepository {
  final OrderDataProvider _orders;
  const CustomerRepository({required OrderDataProvider orderDataProvider}) : _orders = orderDataProvider;

  ResultData<List<CustomerStatEntity>> listCustomers() => resultOf(() => buildCustomers(_orders.getOrders()));

  ResultData<CustomerDetailEntity> getDetail(String mobile) => resultOf(() => buildDetail(_orders.getOrders(), mobile));

  static List<CustomerStatEntity> buildCustomers(List<OrderEntity> orders) {
    final m = <String, List<OrderEntity>>{};
    for (final o in orders.where((o) => !o.cancelled)) {
      m.putIfAbsent(o.mobile, () => []).add(o);
    }
    return m.values.map((os) {
      os.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final l = os.first;
      return CustomerStatEntity(name: l.name, mobile: l.mobile, address: l.address, instagram: os.map((o) => o.instagram).firstWhere((x) => x.isNotEmpty, orElse: () => ''),
        count: os.length, spent: os.fold(0, (s, o) => s + o.total), last: l.createdAt, lastItems: l.items);
    }).toList()..sort((a, b) => b.count.compareTo(a.count));
  }

  static CustomerDetailEntity buildDetail(List<OrderEntity> orders, String mobile) {
    final os = orders.where((o) => o.mobile == mobile).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (os.isEmpty) throw NotFoundException(errorMessage: 'مشتری پیدا نشد');
    final valid = os.where((o) => !o.cancelled).toList();
    final spent = valid.fold(0, (s, o) => s + o.total);
    final qty = <String, int>{};
    for (final o in valid) {
      for (final i in o.items) {
        qty[i.name] = (qty[i.name] ?? 0) + i.qty;
      }
    }
    final top = qty.isEmpty ? '—' : (qty.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key;
    final rated = os.where((o) => o.rating > 0).toList();
    return CustomerDetailEntity(orders: os, validCount: valid.length, spent: spent, topProduct: top,
      avgRating: rated.isEmpty ? null : rated.fold(0, (s, o) => s + o.rating) / rated.length, ratedCount: rated.length,
      instagram: os.map((o) => o.instagram).firstWhere((x) => x.isNotEmpty, orElse: () => ''));
  }
}
