import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/riverpod_helper.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/number_utils.dart';
import '../../../data/entities/product/product_entity.dart';
import '../provider/products_provider.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = AppColors.of(context);
    final notifier = ref.read(productsProvider.notifier);
    Future<void> edit([ProductEntity? p]) async {
      final n = TextEditingController(text: p?.name), pr = TextEditingController(text: p?.price.toString());
      final ok = await showDialog<bool>(context: context, builder: (c) => AlertDialog(title: Text(p == null ? 'محصول جدید' : 'ویرایش محصول'), content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: n, decoration: const InputDecoration(labelText: 'نام')), const SizedBox(height: 12),
        TextField(controller: pr, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'قیمت (تومان)'))]),
        actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('انصراف')),
          SizedBox(width: 110, child: FilledButton(style: FilledButton.styleFrom(minimumSize: const Size(0, 44)), onPressed: () => Navigator.pop(c, true), child: const Text('ذخیره')))]));
      final price = int.tryParse(toEn(pr.text)); if (ok != true || n.text.isEmpty || price == null) return;
      await notifier.upsert(p, n.text, price);
    }
    return Scaffold(backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(onPressed: edit, child: const Icon(Icons.add_rounded)),
      body: ResultDataView(value: ref.watch(productsProvider), tryAgain: () => ref.invalidate(productsProvider), successBuilder: (products) =>
        ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 100), children: [Card(child: Column(children: [for (final (i, p) in products.indexed) ...[
          if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
          ListTile(contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 4), onTap: () => edit(p),
            title: Text(p.name, style: TextStyle(fontWeight: FontWeight.w700, color: p.active ? c.text : c.textFaint)),
            subtitle: Text(toman(p.price), style: TextStyle(color: c.textMuted)),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Switch(value: p.active, onChanged: (v) => notifier.setActive(p, v)),
              IconButton(icon: Icon(Icons.delete_outline_rounded, color: c.textFaint), onPressed: () => notifier.remove(p))]))]]))])));
  }
}
