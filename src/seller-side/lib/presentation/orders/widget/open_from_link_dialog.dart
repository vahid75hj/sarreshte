import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/utils/link_utils.dart';
import '../../../domain/use_case/order/find_order_by_code.dart';
import '../../../routes/app_router.dart';

/// Paste a customer's tracking link (or a bare code) and open that order.
Future<void> openFromLink(BuildContext context) async {
  final ctl = TextEditingController();
  String? err;
  final code = await showDialog<String>(context: context, builder: (dc) => StatefulBuilder(builder: (dc, set) => AlertDialog(
    title: const Text('باز کردن سفارش از لینک'),
    content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('لینک پیگیری مشتری یا کد سفارش را بچسبان.', style: TextStyle(color: AppColors.of(dc).textMuted, fontSize: 13)), const SizedBox(height: 12),
      TextField(controller: ctl, autofocus: true, textDirection: TextDirection.ltr, decoration: InputDecoration(hintText: 'track.html?c=NR1003 یا NR1003', errorText: err,
        suffixIcon: IconButton(tooltip: 'چسباندن', icon: const Icon(Icons.content_paste_rounded), onPressed: () async { final d = await Clipboard.getData('text/plain'); ctl.text = d?.text ?? ''; set(() {}); }))),
    ]),
    actions: [TextButton(onPressed: () => Navigator.pop(dc), child: const Text('انصراف')),
      FilledButton(onPressed: () {
        final c = codeFromText(ctl.text);
        if (c == null) return set(() => err = 'لینک یا کد معتبر نیست');
        GetIt.I<FindOrderByCodeUseCase>()(c).match((_) => set(() => err = 'سفارشی با کد $c پیدا نشد'), (o) => Navigator.pop(dc, o.code));
      }, child: const Text('باز کن'))])));
  if (code != null && context.mounted) await AppRouter.toOrder(context, code);
}
