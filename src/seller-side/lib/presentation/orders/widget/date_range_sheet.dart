import 'package:flutter/material.dart';

import '../../../common/utils/date_utils.dart';

/// Bottom sheet: today / 7 days / 30 days / custom range / clear. Returns null when dismissed.
sealed class DateRangeChoice {}

class DateRangeCleared extends DateRangeChoice {}

class DateRangePicked extends DateRangeChoice {
  final DateTimeRange range;
  final String label;
  DateRangePicked(this.range, this.label);
}

Future<DateRangeChoice?> pickOrderDateRange(BuildContext context, DateTimeRange? current) async {
  final now = DateTime.now(); final today = DateTime(now.year, now.month, now.day);
  final v = await showModalBottomSheet<int>(context: context, showDragHandle: true, builder: (bc) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
    const Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 8), child: Align(alignment: AlignmentDirectional.centerStart, child: Text('فیلتر تاریخ ثبت سفارش', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)))),
    for (final (i, t) in ['امروز', 'این هفته (۷ روز اخیر)', 'این ماه (۳۰ روز اخیر)', 'بازه‌ی دلخواه…'].indexed) ListTile(title: Text(t), onTap: () => Navigator.pop(bc, i)),
    if (current != null) ListTile(leading: const Icon(Icons.close_rounded), title: const Text('حذف فیلتر تاریخ'), onTap: () => Navigator.pop(bc, 9)),
    const SizedBox(height: 8)])));
  if (v == null || !context.mounted) return null;
  if (v == 9) return DateRangeCleared();
  if (v == 3) {
    final r = await showDateRangePicker(context: context, firstDate: today.subtract(const Duration(days: 400)), lastDate: today, initialDateRange: current);
    return r == null ? null : DateRangePicked(r, '${jDate(r.start)} تا ${jDate(r.end)}');
  }
  return DateRangePicked(DateTimeRange(start: today.subtract(Duration(days: [0, 6, 29][v])), end: today), ['امروز', 'این هفته', 'این ماه'][v]);
}
