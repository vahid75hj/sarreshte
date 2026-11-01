import 'package:flutter/material.dart' show DateTimeRange;

import '../../../data/entities/order/order_entity.dart';
import '../../../data/entities/order/order_status.dart';

/// The four open-order groups shown as chips, in display order.
const openOrderGroups = [OrderStatus.awaitingConfirm, OrderStatus.pendingPayment, OrderStatus.paid, OrderStatus.shipped];

/// Pure board logic for the orders tab (no I/O, so it is a plain function object).
class FilterOrdersUseCase {
  /// Default chip: «پرداخت‌شده» when something is late to ship, else «منتظر تأیید واریز».
  int defaultGroup(List<OrderEntity> orders) => orders.any((o) => o.shipLate) ? 2 : 0;

  /// Orders of one group; open groups oldest first so a forgotten one can't sink.
  List<OrderEntity> group(List<OrderEntity> orders, int g) {
    final os = newestFirst(orders);
    final list = os.where((o) => o.status == openOrderGroups[g]).toList();
    if (g < 3) list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return list;
  }

  /// Search across all orders (including archive) by text and optional created-at range.
  List<OrderEntity> search(List<OrderEntity> orders, String q, DateTimeRange? range) =>
      newestFirst(orders).where((o) => o.matches(q) && inRange(o, range)).toList();

  bool inRange(OrderEntity o, DateTimeRange? range) =>
      range == null || (!o.createdAt.isBefore(range.start) && o.createdAt.isBefore(range.end.add(const Duration(days: 1))));

  List<OrderEntity> newestFirst(List<OrderEntity> orders) => orders.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
