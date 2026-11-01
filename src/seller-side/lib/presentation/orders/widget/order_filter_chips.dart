import 'package:flutter/material.dart';

import '../../../common/utils/number_utils.dart';
import '../../../common/widget/count_badge.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../domain/use_case/order/filter_orders.dart';

/// The four open-order chips; «پرداخت‌شده» and «ارسال‌شده» carry a red count when something needs attention.
class OrderFilterChips extends StatelessWidget {
  static const labels = ['منتظر تأیید واریز', 'منتظر واریز', 'پرداخت‌شده', 'ارسال‌شده'];
  final List<OrderEntity> orders;
  final int selected;
  final ValueChanged<int> onSelected;
  final int lateCount, followCount;
  const OrderFilterChips({super.key, required this.orders, required this.selected, required this.onSelected, required this.lateCount, required this.followCount});

  @override
  Widget build(BuildContext context) {
    int n(int i) => orders.where((o) => o.status == openOrderGroups[i]).length;
    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [for (var i = 0; i < 4; i++) Padding(padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(showCheckmark: false, selected: selected == i, onSelected: (_) => onSelected(i), label: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('${labels[i]} ${fa(n(i))}'),
        if (i == 2 && lateCount > 0) ...[const SizedBox(width: 6), CountBadge(lateCount)],
        if (i == 3 && followCount > 0) ...[const SizedBox(width: 6), CountBadge(followCount)]])))]));
  }
}
