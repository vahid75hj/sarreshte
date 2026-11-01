import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/riverpod_helper.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/app_constants.dart';
import '../../../common/utils/number_utils.dart';
import '../../../data/entities/order/order_status.dart';
import '../../../domain/use_case/order/filter_orders.dart';
import '../../../routes/app_router.dart';
import '../provider/order_board_filter_provider.dart';
import '../provider/orders_provider.dart';
import '../widget/archive_entry_card.dart';
import '../widget/date_range_sheet.dart';
import '../widget/order_card.dart';
import '../widget/order_filter_chips.dart';
import '../widget/paid_summary_card.dart';

/// Orders tab: search + date filter, archive entry, status chips and the open-order board.
class OrdersPage extends HookConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final q = useTextEditingController();
    final f = ref.watch(orderBoardFilterProvider);
    final filter = ref.read(orderBoardFilterProvider.notifier);
    return ResultDataView(
    value: ref.watch(ordersProvider), tryAgain: () => ref.invalidate(ordersProvider),
    successBuilder: (orders) {
      final c = AppColors.of(context);
      final uc = GetIt.I<FilterOrdersUseCase>();
      final os = uc.newestFirst(orders);
      final follow = os.where((o) => o.followUp).length;
      final unseen = os.where((o) => o.unseen).length;
      final archived = os.where((o) => o.archived).length;
      final paidList = os.where((o) => o.status == OrderStatus.paid).toList(); final paidSum = paidList.fold(0, (s, o) => s + o.total);
      final results = f.searching ? uc.search(orders, f.query, f.range) : const [];
      final list = uc.group(orders, f.group);
      final lateN = os.where((o) => o.shipLate).length;
      Future<void> pickRange() async {
        final r = await pickOrderDateRange(context, f.range);
        switch (r) {
          case DateRangeCleared(): filter.clearRange();
          case DateRangePicked(:final range, :final label): filter.setRange(range, label);
          case null: break;
        }
      }
      return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 100), children: [
        Row(children: [
          Expanded(child: TextField(controller: q, onChanged: filter.setQuery, decoration: InputDecoration(isDense: true, prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'جستجو: کد سفارش، اسم، موبایل یا آیدی اینستا', hintStyle: TextStyle(fontSize: 13, color: c.textFaint),
            suffixIcon: q.text.isEmpty ? null : IconButton(tooltip: 'پاک کردن', icon: const Icon(Icons.close_rounded), onPressed: () { q.clear(); filter.setQuery(''); })))),
          const SizedBox(width: 8),
          IconButton.outlined(tooltip: 'فیلتر تاریخ', isSelected: f.range != null, onPressed: pickRange, icon: const Icon(Icons.date_range_rounded)),
        ]),
        if (f.range != null) Padding(padding: const EdgeInsets.only(top: 10), child: Align(alignment: AlignmentDirectional.centerStart,
          child: InputChip(avatar: const Icon(Icons.event_rounded, size: 16), label: Text('تاریخ: ${f.rangeLabel}'), onDeleted: filter.clearRange, deleteButtonTooltipMessage: 'حذف فیلتر'))),
        if (f.searching) ...[
          Padding(padding: const EdgeInsets.fromLTRB(4, 16, 4, 10), child: Text(results.isEmpty ? '' : '${fa(results.length)} نتیجه در همه‌ی سفارش‌ها (همراه بایگانی)', style: TextStyle(color: c.textMuted, fontSize: 13, fontWeight: FontWeight.w700))),
          if (results.isEmpty) Padding(padding: const EdgeInsets.all(32), child: Column(children: [Icon(Icons.search_off_rounded, size: 40, color: c.textFaint), const SizedBox(height: 10),
            Text('سفارشی با این مشخصات پیدا نشد', style: TextStyle(fontWeight: FontWeight.w700, color: c.text)), const SizedBox(height: 4),
            Text('کد سفارش (مثل NR1003)، بخشی از اسم، شماره موبایل یا آیدی اینستا را امتحان کن${f.range != null ? '، یا فیلتر تاریخ را بردار' : ''}.', textAlign: TextAlign.center, style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.7))])),
          for (final o in results.take(60)) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () => AppRouter.toOrder(context, o.code))),
        ] else ...[
          const SizedBox(height: 14),
          ArchiveEntryCard(archived: archived, unseen: unseen, onTap: () => AppRouter.toArchive(context)),
          const SizedBox(height: 14),
          OrderFilterChips(orders: os, selected: f.group, onSelected: filter.setGroup, lateCount: lateN, followCount: follow),
          const SizedBox(height: 12),
          if (f.group == 2) PaidSummaryCard(count: paidList.length, sum: paidSum),
          if (f.group == 2 && lateN > 0) Padding(padding: const EdgeInsets.only(bottom: 12), child: Text('${fa(lateN)} سفارش بیش از ${fa(AppConstants.shipLateDays)} روز است پولش آمده و هنوز ارسال نشده. قدیمی‌ترین‌ها بالا هستند.', style: TextStyle(color: c.negative, fontSize: 13, height: 1.7, fontWeight: FontWeight.w600))),
          if (f.group == 3 && follow > 0) Padding(padding: const EdgeInsets.only(bottom: 12), child: Text('${fa(follow)} سفارش بیش از ${fa(AppConstants.deliveryFollowUpDays)} روز است ارسال شده و مشتری هنوز «به دستم رسید» را نزده. پیام بده یا خودت تکمیلش کن.', style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.7))),
          if (list.isEmpty) Padding(padding: const EdgeInsets.all(40), child: Center(child: Text('سفارشی در این وضعیت نیست', style: TextStyle(color: c.textMuted)))),
          for (final o in list) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () => AppRouter.toOrder(context, o.code))),
        ],
      ]);
    },
  );
  }
}
