import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/utils/number_utils.dart';
import '../../../common/widget/section_title.dart';
import '../provider/dm_draft_provider.dart';

/// Paste a customer's DM -> editable draft order -> «ثبت سفارش».
class DmPage extends HookConsumerWidget {
  const DmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = AppColors.of(context);
    final t = useTextEditingController(text: 'سلام ۲ تا شمع لیوانی بزرگ میخوام\nاسمم: لیلا صادقی\nآدرس: تبریز، ولیعصر، کوچه ۳\n۰۹۳۵۱۲۳۴۵۶۷');
    final name = useTextEditingController(), mobile = useTextEditingController(), address = useTextEditingController();
    useListenable(Listenable.merge([name, mobile, address]));
    final d = ref.watch(dmDraftProvider);
    void extract() { final o = ref.read(dmDraftProvider.notifier).extract(t.text); if (o == null) return; name.text = o.name; mobile.text = o.mobile; address.text = o.address; }
    final mobileOk = RegExp(r'^09\d{9}$').hasMatch(toEn(mobile.text).trim());
    Future<void> submit() async { final nav = Navigator.of(context); await ref.read(dmDraftProvider.notifier).submit(name: name.text, mobile: mobile.text, address: address.text); nav.pop(); }
    Widget kv(String k, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 64, child: Text(k, style: TextStyle(color: c.textMuted))), Expanded(child: Text(v.isEmpty ? '—' : v, style: const TextStyle(fontWeight: FontWeight.w600)))]));
    Widget field(TextEditingController ctl, String label, {bool ltr = false, String? err, int lines = 1}) => Padding(padding: const EdgeInsets.only(bottom: 12), child: TextField(controller: ctl, maxLines: lines,
      textDirection: ltr ? TextDirection.ltr : null, keyboardType: ltr ? TextInputType.phone : null, decoration: InputDecoration(labelText: label, errorText: err)));
    final ok = d != null && d.items.isNotEmpty && mobileOk && name.text.trim().isNotEmpty;
    return Scaffold(appBar: AppBar(title: const Text('دایرکت ← سفارش')), body: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 32), children: [
      Text('متن دایرکت مشتری را بچسبان تا یک سفارش پیش‌نویس ساخته شود.', style: TextStyle(color: c.textMuted)),
      const SizedBox(height: 4),
      Text('در این دمو استخراج با قاعده‌ی ساده انجام می‌شود؛ در نسخه‌ی واقعی این کار با هوش مصنوعی است و فروشنده فقط پیش‌نویس را تأیید می‌کند.', style: TextStyle(color: c.textFaint, fontSize: 12, height: 1.7)),
      const SizedBox(height: 12),
      TextField(controller: t, maxLines: 6, decoration: const InputDecoration(hintText: 'متن دایرکت')),
      const SizedBox(height: 12), FilledButton(onPressed: extract, child: const Text('استخراج سفارش')),
      if (d != null) ...[const SectionTitle('پیش‌نویس — قبل از ثبت چک کن'), Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        field(name, 'نام', err: name.text.trim().isEmpty ? 'نام لازم است' : null),
        field(mobile, 'موبایل', ltr: true, err: mobileOk ? null : 'موبایل لازم است (مثل 09121234567)'),
        field(address, 'آدرس', lines: 2),
        kv('اقلام', d.items.isEmpty ? 'محصولی پیدا نشد؛ متن را اصلاح کن' : d.items.map((i) => '${fa(i.qty)} × ${i.name}').join('\n')), Divider(color: c.line), kv('جمع', toman(d.total)),
        const SizedBox(height: 12),
        FilledButton(onPressed: ok ? submit : null, child: const Text('ثبت سفارش'))])))],
    ]));
  }
}
