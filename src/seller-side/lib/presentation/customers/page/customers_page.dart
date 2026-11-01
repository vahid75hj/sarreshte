import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/riverpod_helper.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/number_utils.dart';
import '../../../routes/app_router.dart';
import '../provider/customers_provider.dart';

/// Customers derived from orders, with search and «ثابت» (repeat) badge.
class CustomersPage extends HookConsumerWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final q = useTextEditingController();
    useListenable(q);
    return ResultDataView(value: ref.watch(customersProvider), tryAgain: () => ref.invalidate(customersProvider), successBuilder: (all) {
      final c = AppColors.of(context);
      final t = toEn(q.text).trim().toLowerCase().replaceAll('@', '');
      final cs = t.isEmpty ? all : all.where((x) => x.name.contains(q.text.trim()) || x.mobile.contains(t) || x.instagram.toLowerCase().contains(t)).toList();
      return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), children: [
        TextField(controller: q, decoration: InputDecoration(isDense: true, prefixIcon: const Icon(Icons.search_rounded),
          hintText: 'جستجو: اسم، موبایل یا آیدی اینستا', hintStyle: TextStyle(fontSize: 13, color: c.textFaint),
          suffixIcon: q.text.isEmpty ? null : IconButton(tooltip: 'پاک کردن', icon: const Icon(Icons.close_rounded), onPressed: q.clear))),
        const SizedBox(height: 12),
        Text(t.isEmpty ? '${fa(all.length)} مشتری – ${fa(all.where((x) => x.count > 1).length)} مشتری ثابت' : '${fa(cs.length)} نتیجه', style: TextStyle(color: c.textMuted)),
        const SizedBox(height: 12),
        if (cs.isEmpty) Padding(padding: const EdgeInsets.all(32), child: Center(child: Text('مشتری‌ای با این مشخصات پیدا نشد', style: TextStyle(color: c.textMuted)))),
        if (cs.isNotEmpty) Card(child: Column(children: [for (final (i, x) in cs.indexed) ...[
          if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
          ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            onTap: () => AppRouter.toCustomer(context, x.mobile),
            leading: CircleAvatar(backgroundColor: c.accentSoft, child: Text(x.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
            title: Row(children: [Flexible(child: Text(x.name, style: const TextStyle(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)), if (x.count > 1) ...[const SizedBox(width: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: c.positive.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                child: Text('ثابت', style: TextStyle(color: c.positive, fontSize: 11, fontWeight: FontWeight.w700)))]]),
            subtitle: Text('${fa(x.count)} سفارش – آخرین خرید ${fa(x.daysSince)} روز پیش', style: TextStyle(color: c.textMuted, fontSize: 13)),
            trailing: Text(toman(x.spent), style: const TextStyle(fontWeight: FontWeight.w700)))]])),
      ]);
    });
  }
}
