import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/utils/number_utils.dart';

/// Paid but not shipped: count and total.
class PaidSummaryCard extends StatelessWidget {
  final int count, sum;
  const PaidSummaryCard({super.key, required this.count, required this.sum});

  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: c.line)),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('پرداخت‌شده، هنوز ارسال‌نشده', style: TextStyle(color: c.textMuted, fontSize: 12)), const SizedBox(height: 2),
          Text('${fa(count)} سفارش', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('مبلغ کل', style: TextStyle(color: c.textMuted, fontSize: 12)), const SizedBox(height: 2),
          Text(toman(sum), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: c.positive))])]));
  }
}
