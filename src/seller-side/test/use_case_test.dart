import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:seller_app/data/data_provider/order/order_interface.dart';
import 'package:seller_app/data/data_provider/product/product_interface.dart';
import 'package:seller_app/data/data_provider/seed/demo_seed.dart';
import 'package:seller_app/data/entities/demo/demo_snapshot_entity.dart';
import 'package:seller_app/data/entities/order/item_entity.dart';
import 'package:seller_app/data/entities/order/order_entity.dart';
import 'package:seller_app/data/entities/order/order_status.dart';
import 'package:seller_app/data/entities/product/product_entity.dart';
import 'package:seller_app/domain/failure_model.dart';
import 'package:seller_app/domain/repository/auth/auth_repository.dart';
import 'package:seller_app/domain/repository/customer/customer_repository.dart';
import 'package:seller_app/domain/repository/order/order_repository.dart';
import 'package:seller_app/domain/repository/product/product_repository.dart';
import 'package:seller_app/domain/use_case/auth/login.dart';
import 'package:seller_app/domain/use_case/customer/get_customer_detail.dart';
import 'package:seller_app/domain/use_case/customer/list_reorder_due.dart';
import 'package:seller_app/domain/use_case/order/filter_orders.dart';
import 'package:seller_app/domain/use_case/order/find_order_by_code.dart';
import 'package:seller_app/domain/use_case/order/parse_dm_order.dart';
import 'package:seller_app/domain/use_case/order/update_order.dart';

/// In-memory fake data provider (no shared_preferences).
class FakeOrders implements OrderDataProvider {
  List<OrderEntity> orders;
  FakeOrders(this.orders);
  @override
  List<OrderEntity> getOrders() => orders;
  @override
  Future<void> saveOrder(OrderEntity o) async => orders = [for (final x in orders) x.code == o.code ? o : x];
  @override
  Future<OrderEntity> addOrder(OrderEntity d) async => d;
  @override
  Future<void> resetDemo() async {}
}

class FakeProducts implements ProductDataProvider {
  @override
  List<ProductEntity> getProducts() => DemoSeed.build().products;
  @override
  Future<void> saveProducts(List<ProductEntity> p) async {}
}

OrderEntity order(String code, String status, int daysAgo, {String mobile = '09120000000', int rating = 0}) => OrderEntity(
    id: 0, code: code, name: 'مشتری', mobile: mobile, address: '', status: status, rating: rating,
    createdAt: DateTime.now().subtract(Duration(days: daysAgo)), items: const [ItemEntity(name: 'شمع', price: 100, qty: 2)]);

void main() {
  group('FilterOrdersUseCase', () {
    final uc = FilterOrdersUseCase();
    test('default chip is «منتظر تأیید واریز», or «پرداخت‌شده» when a paid order is late to ship', () {
      expect(uc.defaultGroup([order('A', OrderStatus.paid, 1)]), 0);
      expect(uc.defaultGroup([order('A', OrderStatus.paid, 3)]), 2);
    });
    test('open groups list the oldest first', () {
      final list = uc.group([order('NEW', OrderStatus.awaitingConfirm, 0), order('OLD', OrderStatus.awaitingConfirm, 4)], 0);
      expect(list.map((o) => o.code), ['OLD', 'NEW']);
    });
    test('search accepts Persian digits and spans archived orders', () {
      final r = uc.search([order('NR1003', OrderStatus.delivered, 40), order('NR2000', OrderStatus.paid, 1)], 'NR۱۰۰۳', null);
      expect(r.single.code, 'NR1003');
    });
  });

  group('order use cases', () {
    test('find by code is case-insensitive and returns NotFoundFailure for unknown codes', () {
      final uc = FindOrderByCodeUseCase(repository: OrderRepository(dataProvider: FakeOrders([order('NR1003', OrderStatus.paid, 1)])));
      expect(uc(' nr1003 ').isRight(), true);
      expect(uc('NR9999').getLeft().toNullable(), isA<NotFoundFailure>());
    });
    test('update sets status and postal code', () async {
      final fake = FakeOrders([order('NR1', OrderStatus.paid, 1)]);
      final r = await UpdateOrderUseCase(repository: OrderRepository(dataProvider: fake))(const UpdateOrderParams(code: 'NR1', status: OrderStatus.shipped, postalCode: '123'));
      expect(r.isRight(), true);
      expect(fake.orders.single.status, OrderStatus.shipped);
      expect(fake.orders.single.postalCode, '123');
    });
    test('DM parsing extracts name, mobile, address and quantities', () {
      final r = ParseDmOrderUseCase(productRepository: ProductRepository(dataProvider: FakeProducts()))(
          'سلام ۲ تا شمع لیوانی بزرگ میخوام\nاسمم: لیلا صادقی\nآدرس: تبریز، ولیعصر، کوچه ۳\n۰۹۳۵۱۲۳۴۵۶۷').getRight().toNullable()!;
      expect(r.name, 'لیلا صادقی');
      expect(r.mobile, '09351234567');
      expect(r.address, 'تبریز، ولیعصر، کوچه ۳');
      expect(r.items.single.qty, 2);
    });
  });

  group('customer use cases', () {
    test('reorder reminders only include customers who bought 30–60 days ago', () {
      final repo = CustomerRepository(orderDataProvider: FakeOrders([
        order('A', OrderStatus.delivered, 10, mobile: '1'), order('B', OrderStatus.delivered, 45, mobile: '2'), order('C', OrderStatus.delivered, 90, mobile: '3')]));
      expect(ListReorderDueUseCase(repository: repo)().getRight().toNullable()!.map((c) => c.mobile), ['2']);
    });
    test('customer detail excludes cancelled orders from spend and averages ratings', () {
      final repo = CustomerRepository(orderDataProvider: FakeOrders([
        order('A', OrderStatus.delivered, 10, rating: 5), order('B', OrderStatus.delivered, 20, rating: 2), order('C', OrderStatus.cancelledByCustomer, 1)]));
      final d = GetCustomerDetailUseCase(repository: repo)('09120000000').getRight().toNullable()!;
      expect(d.validCount, 2);
      expect(d.spent, 400);
      expect(d.avgRating, 3.5);
      expect(d.orders.first.code, 'C');
    });
  });

  test('login accepts the demo PIN in Persian digits only', () {
    final uc = LoginUseCase(repository: const AuthRepository());
    expect(uc('۱۲۳۴').isRight(), true);
    expect(uc('0000'), isA<Left<FailureModel, void>>());
  });

  test('demo5 JSON saved by the previous build still loads and re-encodes with the same keys', () {
    final raw = jsonDecode(File('test/fixtures/demo5_saved_by_previous_build.json').readAsStringSync()) as Map<String, dynamic>;
    final s = DemoSnapshotEntity.fromJson(raw);
    expect(s.orders.length, (raw['orders'] as List).length);
    final again = jsonDecode(jsonEncode(s.toJson())) as Map<String, dynamic>;
    expect((again['orders'] as List).first.keys.toSet(), ((raw['orders'] as List).first as Map).keys.toSet());
    expect(again, raw);
  });
}
