import '../../../common/utils/number_utils.dart';
import '../../../data/entities/order/item_entity.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../data/entities/order/order_status.dart';
import '../../failure_model.dart';
import '../../repository/product/product_repository.dart';

/// DM text -> draft order. Simple regex heuristic in the demo (an LLM in the real product).
class ParseDmOrderUseCase {
  final ProductRepository _products;
  ParseDmOrderUseCase({required ProductRepository productRepository}) : _products = productRepository;

  ResultData<OrderEntity> call(String t) => _products.getProducts().map((products) {
    final en = toEn(t);
    final items = <ItemEntity>[];
    for (final p in products) {
      final key = p.name.split(' ').last;
      if (t.contains(key)) {
        final m = RegExp('(\\d+)\\s*(?:تا|عدد)?[^\\d\\n]{0,20}$key').firstMatch(en);
        items.add(ItemEntity(name: p.name, price: p.price, qty: m == null ? 1 : int.parse(m.group(1)!)));
      }
    }
    String grab(String re) => RegExp(re).firstMatch(t)?.group(1)?.trim() ?? '';
    return OrderEntity(id: 0, code: '', name: grab(r'(?:اسمم|اسم|نام)\s*[:：]?\s*([^\n،,]+)'), mobile: RegExp(r'09\d{9}').firstMatch(en)?.group(0) ?? '',
      address: grab(r'(?:آدرس|ادرس)\s*[:：]?\s*([^\n]+)'), status: OrderStatus.pendingPayment, createdAt: DateTime.now(), items: items);
  });
}
