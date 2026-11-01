import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/extention/context.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/contact_utils.dart';
import '../../../common/utils/date_utils.dart';
import '../../../common/utils/number_utils.dart';
import '../../../common/widget/error.dart';
import '../../../common/widget/section_title.dart';
import '../../../domain/use_case/contact/contact_customer.dart';
import '../../../routes/app_router.dart';
import '../../orders/widget/order_card.dart';
import '../provider/customers_provider.dart';

/// One customer: contact actions, purchase stats and all their orders.
class CustomerPage extends ConsumerWidget {
  final String mobile;
  const CustomerPage(this.mobile, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(customerDetailProvider(mobile)).match(
    (f) => Scaffold(appBar: AppBar(), body: RetryFailureWidget(error: f, tryAgain: () => ref.invalidate(customerDetailProvider(mobile)))),
    (d) {
      final c = AppColors.of(context);
      final os = d.orders; final l = os.first; final ig = d.instagram;
      Widget stat(String k, String v) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: c.line)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(k, style: TextStyle(color: c.textMuted, fontSize: 12)), const SizedBox(height: 4),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)]));
      return Scaffold(appBar: AppBar(title: Text(l.name)), body: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 32), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [CircleAvatar(radius: 24, backgroundColor: c.accentSoft, child: Text(l.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w800, fontSize: 18))),
            const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              Text(l.mobile, textDirection: TextDirection.ltr, style: TextStyle(color: c.textMuted)),
              if (ig.isNotEmpty) Text('@$ig', textDirection: TextDirection.ltr, style: TextStyle(color: c.textMuted))]))]),
          const SizedBox(height: 10), Text(l.address, style: TextStyle(color: c.text, height: 1.6)),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(child: FilledButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('پیام در دایرکت'), onPressed: () => openIg(context, ig))),
            const SizedBox(width: 8),
            IconButton.outlined(tooltip: 'تماس', icon: const Icon(Icons.call_rounded), onPressed: () => GetIt.I<CallCustomerUseCase>()(l.mobile)),
            const SizedBox(width: 4),
            IconButton.outlined(tooltip: 'کپی شماره', icon: const Icon(Icons.copy_rounded), onPressed: () => context.copy(l.mobile)),
          ]),
        ]))),
        const SectionTitle('آمار خرید'),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2.4, children: [
          stat('تعداد سفارش', '${fa(d.validCount)}${os.length > d.validCount ? ' (+${fa(os.length - d.validCount)} لغو)' : ''}'),
          stat('جمع خرید', toman(d.spent)),
          stat('میانگین خرید', d.validCount == 0 ? '—' : toman(d.spent ~/ d.validCount)),
          stat('میانگین امتیاز', d.avgRating == null ? 'بدون نظر' : '${faDigits(d.avgRating!.toStringAsFixed(1))} ★ از ${fa(d.ratedCount)}'),
          stat('اولین سفارش', jDate(os.last.createdAt)),
          stat('آخرین سفارش', jDate(os.first.createdAt)),
        ]),
        const SizedBox(height: 8), stat('محصول پرتکرار', d.topProduct),
        SectionTitle('سفارش‌ها – ${fa(os.length)}'),
        for (final o in os) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () => AppRouter.toOrder(context, o.code))),
      ]));
    },
  );
}
