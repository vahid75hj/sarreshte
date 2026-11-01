import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/extention/context.dart';
import '../../../common/riverpod_helper.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/contact_utils.dart';
import '../../../common/utils/number_utils.dart';
import '../../../common/widget/section_title.dart';
import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../../domain/use_case/message/compose_messages.dart';
import '../provider/reorder_provider.dart';

/// Reorder reminders: customers who bought 30–60 days ago; «ارسال کردم» moves them to the sent list.
class ReorderPage extends ConsumerWidget {
  const ReorderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sent = ref.watch(sentRemindersProvider).getOr(const {});
    final compose = GetIt.I<ComposeReorderReminderUseCase>();
    Future<void> mark(CustomerStatEntity x, bool v) async {
      await ref.read(sentRemindersProvider.notifier).mark(x.mobile, v);
      if (context.mounted && v) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${x.name} به «ارسال‌شده‌ها» رفت'), action: SnackBarAction(label: 'برگردان', onPressed: () => mark(x, false))));
    }
    return ResultDataView(value: ref.watch(reorderDueProvider), tryAgain: () => ref.invalidate(reorderDueProvider), successBuilder: (all) {
      final c = AppColors.of(context);
      final todo = all.where((x) => !sent.contains(x.mobile)).toList(), done = all.where((x) => sent.contains(x.mobile)).toList();
      return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), children: [
        Text('مشتری‌هایی که ۳۰ تا ۶۰ روز پیش خرید کرده‌اند. پیام را کپی کن، دایرکتشان را باز کن و بفرست؛ بعد «ارسال کردم» را بزن.', style: TextStyle(color: c.textMuted, height: 1.7)),
        SectionTitle('برای ارسال – ${fa(todo.length)}'),
        if (todo.isEmpty) Padding(padding: const EdgeInsets.all(28), child: Center(child: Text('همه‌ی یادآوری‌ها ارسال شده ✓', style: TextStyle(color: c.textMuted)))),
        for (final x in todo) Padding(padding: const EdgeInsets.only(bottom: 10), child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Text(x.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const SizedBox(width: 8),
            if (x.instagram.isNotEmpty) Text('@${x.instagram}', textDirection: TextDirection.ltr, style: TextStyle(color: c.textMuted, fontSize: 12)), const Spacer(),
            Text('${fa(x.daysSince)} روز پیش', style: TextStyle(color: c.textFaint, fontSize: 12))]),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.background, borderRadius: BorderRadius.circular(12), border: Border.all(color: c.line)),
            child: Text(compose(x), style: TextStyle(color: c.textMuted, height: 1.7, fontSize: 13))),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.copy_rounded, size: 18), label: const Text('کپی پیام'), onPressed: () => context.copy(compose(x)))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('باز کردن دایرکت'), onPressed: () { context.copy(compose(x)); openIg(context, x.instagram); })),
          ]),
          const SizedBox(height: 8),
          FilledButton.icon(icon: const Icon(Icons.check_rounded), label: const Text('ارسال کردم'), onPressed: () => mark(x, true)),
        ])))),
        if (done.isNotEmpty) ...[
          SectionTitle('ارسال‌شده – ${fa(done.length)}'),
          Card(child: Column(children: [for (final (i, x) in done.indexed) ...[
            if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
            ListTile(leading: Icon(Icons.check_circle_rounded, color: c.positive), title: Text(x.name, style: TextStyle(color: c.textMuted, fontWeight: FontWeight.w600)),
              subtitle: Text('یادآوری فرستاده شد', style: TextStyle(color: c.textFaint, fontSize: 12)),
              trailing: TextButton(onPressed: () => mark(x, false), child: const Text('برگردان')))]])),
        ],
      ]);
    });
  }
}
