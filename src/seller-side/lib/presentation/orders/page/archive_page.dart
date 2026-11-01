import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/riverpod_helper.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/date_utils.dart';
import '../../../common/utils/number_utils.dart';
import '../../../common/widget/section_title.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../data/entities/order/order_status.dart';
import '../../../routes/app_router.dart';
import '../provider/orders_provider.dart';
import '../widget/order_card.dart';

/// Completed / cancelled orders: unseen first, then grouped by Jalali month, 20 at a time.
class ArchivePage extends HookConsumerWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shown = useState(const [20, 20]);
    final value = ref.watch(ordersProvider);
    final orders = value.getOr(const <OrderEntity>[]);
    Widget card(OrderEntity o) => Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () => AppRouter.toOrder(context, o.code)));
    Widget tab(int t) { final c = AppColors.of(context); final all = orders.where((o) => t == 0 ? o.status == OrderStatus.delivered : o.cancelled).toList()..sort((a, b) {
        if (a.unseen != b.unseen) return a.unseen ? -1 : 1; return b.createdAt.compareTo(a.createdAt); });
      final unseen = all.where((o) => o.unseen).toList(); final rest = all.where((o) => !o.unseen).toList();
      final page = rest.take(shown.value[t]).toList();
      final kids = <Widget>[];
      if (t == 0) kids.add(Padding(padding: const EdgeInsets.fromLTRB(4, 4, 4, 0), child: Text('سفارش‌هایی که مشتری «به دستم رسید» را زده یا تو تکمیلشان کرده‌ای. نقطه‌ی قرمز یعنی هنوز بازش نکرده‌ای.', style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.7))));
      if (unseen.isNotEmpty) { kids.add(SectionTitle('جدید – دیده‌نشده ${fa(unseen.length)}')); for (final o in unseen) { kids.add(card(o)); } }
      String? m;
      for (final o in page) { final l = monthLabel(o.createdAt); if (l != m) { m = l; kids.add(SectionTitle(l)); } kids.add(card(o)); }
      if (all.isEmpty) kids.add(Padding(padding: const EdgeInsets.all(40), child: Center(child: Text('سفارشی اینجا نیست', style: TextStyle(color: c.textMuted)))));
      if (rest.length > shown.value[t]) { kids.add(Padding(padding: const EdgeInsets.only(top: 6), child: OutlinedButton(onPressed: () => shown.value = [for (var i = 0; i < 2; i++) shown.value[i] + (i == t ? 20 : 0)], child: Text('نمایش بیشتر (${fa(rest.length - shown.value[t])} سفارش دیگر)')))); }
      else if (rest.isNotEmpty) { kids.add(Padding(padding: const EdgeInsets.all(16), child: Center(child: Text('همه‌ی ${fa(all.length)} سفارش نمایش داده شد', style: TextStyle(color: c.textFaint, fontSize: 12))))); }
      return ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 32), children: kids);
    }
    final u = orders.where((o) => o.unseen).length;
    final done = orders.where((o) => o.status == OrderStatus.delivered).length, canc = orders.where((o) => o.cancelled).length;
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(title: const Text('بایگانی'), bottom: TabBar(tabs: [
      Tab(text: 'تکمیل‌شده ${fa(done)}${u > 0 ? ' – ${fa(u)} جدید' : ''}'), Tab(text: 'لغوشده ${fa(canc)}')])),
      body: ResultDataView(value: value, tryAgain: () => ref.invalidate(ordersProvider), successBuilder: (_) => TabBarView(children: [tab(0), tab(1)]))));
  }
}
