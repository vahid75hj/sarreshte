import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

final themeMode = ValueNotifier(ThemeMode.system);
// Optional ?theme=dark|light on web
final _q = Uri.base.queryParameters;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Store.I.load();
  final p = await SharedPreferences.getInstance();
  themeMode.value = ThemeMode.values.firstWhere((m) => m.name == (_q['theme'] ?? p.getString('themeMode')), orElse: () => ThemeMode.system);
  themeMode.addListener(() => p.setString('themeMode', themeMode.value.name));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(valueListenable: themeMode, builder: (_, mode, _) => MaterialApp(
      title: 'سررشته · مدیریت سفارش‌ها', debugShowCheckedModeBanner: false,
      locale: const Locale('fa'), supportedLocales: const [Locale('fa')],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      theme: AppTheme.build(Brightness.light), darkTheme: AppTheme.build(Brightness.dark), themeMode: mode,
      builder: (context, child) { final c = AppColors.of(context); final dark = Theme.of(context).brightness == Brightness.dark;
        // Always mobile layout: centered phone-width column on wide screens.
        return ColoredBox(color: dark ? const Color(0xFF070707) : const Color(0xFFECEBE7), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 430),
          child: DecoratedBox(decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: c.line))), child: ClipRect(child: child)))));
      },
      home: const LoginPage()));
}

void snack(BuildContext c, String m) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(m)));
Future<void> openIg(BuildContext ctx, String handle, {bool dm = true}) async {
  final h = handle.replaceAll('@', '').trim(); if (h.isEmpty) { snack(ctx, 'آیدی اینستاگرام ثبت نشده'); return; }
  if (!await launchUrl(Uri.parse(dm ? 'https://ig.me/m/$h' : 'https://instagram.com/$h'), webOnlyWindowName: '_blank')) {
    await launchUrl(Uri.parse('https://instagram.com/$h'), webOnlyWindowName: '_blank'); }
}
void copy(BuildContext c, String t) { Clipboard.setData(ClipboardData(text: t)); snack(c, 'کپی شد'); }
String ago(DateTime d) { final n = DateTime.now().difference(d); return n.inDays > 0 ? '${fa(n.inDays)} روز پیش' : n.inHours > 0 ? '${fa(n.inHours)} ساعت پیش' : 'همین الان'; }

/// Status pill: positive for done, muted for pending, negative for cancelled.
class StatusPill extends StatelessWidget {
  final String status; const StatusPill(this.status, {super.key});
  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final col = switch (status) { 'shipped' || 'paid' || 'delivered' => c.positive, 'cancelled' => c.negative, 'awaiting_confirm' => c.text, _ => c.textMuted };
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: col.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20), border: Border.all(color: col.withValues(alpha: 0.25))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: col, shape: BoxShape.circle)), const SizedBox(width: 6),
        Text(statusLabels[status]!, style: TextStyle(color: col, fontSize: 12, fontWeight: FontWeight.w700))]));
  }
}

class SectionTitle extends StatelessWidget {
  final String t; final Widget? trailing; const SectionTitle(this.t, {super.key, this.trailing});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(4, 20, 4, 10), child: Row(children: [
    Expanded(child: Text(t, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.of(context).textMuted))), ?trailing]));
}

class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState() => _LoginState(); }
class _LoginState extends State<LoginPage> {
  final pin = TextEditingController(); String err = '';
  void go() { if (toEn(pin.text) == demoPin) { Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Home())); } else { setState(() => err = 'رمز اشتباه است'); } }
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    return Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 380), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [Container(width: 52, height: 52, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: c.line)),
        child: Image.asset('assets/icon/main.png', fit: BoxFit.cover)), const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('سررشته', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: c.text)),
          Text('مدیریت سفارش فروشنده‌های اینستاگرامی', style: TextStyle(fontSize: 13, color: c.textMuted))])]),
      const SizedBox(height: 36),
      Text('ورود به حساب فروشگاه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.text)),
      const SizedBox(height: 16),
      TextField(readOnly: true, enabled: false, controller: TextEditingController(text: shopAccount), textDirection: TextDirection.ltr,
        style: TextStyle(color: c.textMuted), decoration: InputDecoration(labelText: 'حساب فروشگاه', helperText: 'فروشگاه: $storeName (حساب نمونه‌ی دمو)',
          prefixIcon: const Icon(Icons.storefront_outlined), suffixIcon: const Icon(Icons.lock_outline_rounded, size: 18), filled: true, fillColor: c.accentSoft)),
      const SizedBox(height: 16),
      TextField(controller: pin, obscureText: true, keyboardType: TextInputType.number, textAlign: TextAlign.center, onSubmitted: (_) => go(),
        style: const TextStyle(fontSize: 22, letterSpacing: 8, fontWeight: FontWeight.w700),
        decoration: InputDecoration(labelText: 'رمز ورود', errorText: err.isEmpty ? null : err)),
      const SizedBox(height: 16),
      FilledButton(onPressed: go, child: const Text('ورود')),
      const SizedBox(height: 20),
      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.accentSoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: c.line)),
        child: Row(children: [Icon(Icons.info_outline_rounded, size: 18, color: c.textMuted), const SizedBox(width: 8),
          Expanded(child: Text('نسخه‌ی نمایشی — رمز: ۱۲۳۴', style: TextStyle(color: c.textMuted, fontSize: 13)))])),
    ]))))));
  }
}

class Home extends StatefulWidget { const Home({super.key}); @override State<Home> createState() => _HomeState(); }
class _HomeState extends State<Home> {
  int tab = 0;
  static const titles = ['سفارش‌ها', 'مشتری‌ها', 'یادآوری سفارش دوباره', 'محصولات'];
  @override
  Widget build(BuildContext context) {
    final pages = [OrdersPage(onChange: () => setState(() {})), const CustomersPage(), const ReorderPage(), const ProductsPage()];
    return Scaffold(
      appBar: AppBar(titleSpacing: 20, title: Text(titles[tab]), actions: [
        IconButton(tooltip: 'کپی لینک سفارش فروشگاه', icon: const Icon(Icons.link_rounded), onPressed: () => copy(context, storeLink)),
        PopupMenuButton<int>(icon: const Icon(Icons.more_vert_rounded), itemBuilder: (_) => [
          PopupMenuItem(value: 1, child: ValueListenableBuilder(valueListenable: themeMode, builder: (_, m, _) => Text(
            m == ThemeMode.dark || (m == ThemeMode.system && Theme.of(context).brightness == Brightness.dark) ? 'تم روشن' : 'تم تیره'))),
          const PopupMenuItem(value: 2, child: Text('تم: پیروی از سیستم')),
          const PopupMenuItem(value: 3, child: Text('بازگردانی داده‌های دمو')),
        ], onSelected: (v) async {
          if (v == 1) themeMode.value = Theme.of(context).brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
          if (v == 2) themeMode.value = ThemeMode.system;
          if (v == 3) { await Store.I.reset(); setState(() {}); }
        }),
        const SizedBox(width: 8),
      ]),
      body: pages[tab],
      floatingActionButton: tab == 0 ? FloatingActionButton.extended(icon: const Icon(Icons.content_paste_rounded), label: const Text('دایرکت ← سفارش', style: TextStyle(fontWeight: FontWeight.w700)),
        onPressed: () async { await Navigator.push(context, MaterialPageRoute(builder: (_) => const DmPage())); setState(() {}); }) : null,
      bottomNavigationBar: DecoratedBox(decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.of(context).line))),
        child: NavigationBar(selectedIndex: tab, onDestinationSelected: (i) => setState(() => tab = i), destinations: const [
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded), label: 'سفارش‌ها'),
          NavigationDestination(icon: Icon(Icons.people_outline_rounded), selectedIcon: Icon(Icons.people_rounded), label: 'مشتری‌ها'),
          NavigationDestination(icon: Icon(Icons.notifications_none_rounded), selectedIcon: Icon(Icons.notifications_rounded), label: 'یادآوری'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2_rounded), label: 'محصولات')])));
  }
}

class OrdersPage extends StatefulWidget { final VoidCallback onChange; const OrdersPage({super.key, required this.onChange}); @override State<OrdersPage> createState() => _OrdersState(); }
class _OrdersState extends State<OrdersPage> {
  static const groups = {0: ['pending_payment', 'awaiting_confirm'], 1: ['paid'], 2: ['shipped'], 3: ['delivered']};
  static const gl = ['منتظر واریز', 'پرداخت‌شده', 'ارسال‌شده', 'تکمیل‌شده'];
  int g = 0;
  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final os = Store.I.orders.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    int n(int i) => os.where((o) => groups[i]!.contains(o.status)).length;
    final open = n(0) + n(1);
    final openSum = os.where((o) => groups[0]!.contains(o.status) || o.status == 'paid').fold(0, (s, o) => s + o.total);
    final toConfirm = os.where((o) => o.status == 'awaiting_confirm').length;
    final list = os.where((o) => groups[g]!.contains(o.status)).toList();
    final dark = Theme.of(context).brightness == Brightness.dark;
    final hc = dark ? c.copyWith(accent: const Color(0xFF242424), onAccent: c.text) : c;
    return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 100), children: [
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: hc.accent, borderRadius: BorderRadius.circular(14), border: Border.all(color: c.line)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('سفارش‌های باز', style: TextStyle(color: hc.onAccent.withValues(alpha: 0.7), fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(fa(open), style: TextStyle(color: hc.onAccent, fontSize: 52, height: 1.1, fontWeight: FontWeight.w800)), const SizedBox(width: 10),
            Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('هنوز ارسال نشده', style: TextStyle(color: hc.onAccent.withValues(alpha: 0.7), fontSize: 14)))]),
          const SizedBox(height: 14),
          Divider(color: hc.onAccent.withValues(alpha: 0.15)),
          const SizedBox(height: 12),
          Row(children: [
            _stat(hc, 'مبلغ در جریان', toman(openSum)),
            _stat(hc, 'رسید منتظر تأیید', fa(toConfirm)),
          ]),
        ])),
      const SizedBox(height: 20),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [for (var i = 0; i < 4; i++) Padding(padding: const EdgeInsetsDirectional.only(end: 8),
        child: ChoiceChip(showCheckmark: false, label: Text('${gl[i]} ${fa(n(i))}'), selected: g == i, onSelected: (_) => setState(() => g = i)))])),
      const SizedBox(height: 12),
      if (list.isEmpty) Padding(padding: const EdgeInsets.all(40), child: Center(child: Text('سفارشی اینجا نیست', style: TextStyle(color: c.textMuted)))),
      for (final o in list) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => OrderPage(o))); setState(() {}); widget.onChange(); })),
    ]);
  }
  Widget _stat(AppColors c, String l, String v) => Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(l, style: TextStyle(color: c.onAccent.withValues(alpha: 0.6), fontSize: 12)), const SizedBox(height: 2),
    Text(v, style: TextStyle(color: c.onAccent, fontSize: 16, fontWeight: FontWeight.w700))]));
}

class OrderCard extends StatelessWidget {
  final Order o; final VoidCallback onTap; const OrderCard(this.o, {super.key, required this.onTap});
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    return Card(clipBehavior: Clip.antiAlias, child: InkWell(onTap: onTap, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CircleAvatar(radius: 18, backgroundColor: c.accentSoft, child: Text(o.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          Text('${o.code} · ${ago(o.createdAt)}', style: TextStyle(color: c.textFaint, fontSize: 12)),
        ])),
        StatusPill(o.status),
      ]),
      const SizedBox(height: 12), Divider(color: c.line), const SizedBox(height: 12),
      Row(children: [
        Expanded(child: Text(o.items.map((i) => '${fa(i.qty)}× ${i.name}').join('، '), style: TextStyle(color: c.textMuted, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 12),
        Text(toman(o.total), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ]),
    ]))));
  }
}

class OrderPage extends StatefulWidget { final Order o; const OrderPage(this.o, {super.key}); @override State<OrderPage> createState() => _OrderState(); }
class _OrderState extends State<OrderPage> {
  late final post = TextEditingController(text: widget.o.postalCode);
  void set(String s) { setState(() => widget.o.status = s); Store.I.save(); snack(context, 'وضعیت: ${statusLabels[s]}'); }
  Widget row(String k, String v, {bool bold = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [
    Expanded(child: Text(k, style: TextStyle(color: AppColors.of(context).textMuted))), Text(v, style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w600, fontSize: bold ? 17 : 14))]));
  @override
  Widget build(BuildContext context) { final o = widget.o; final c = AppColors.of(context);
    const pad = EdgeInsets.all(16);
    return Scaffold(appBar: AppBar(title: Text('سفارش ${o.code}')), body: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 32), children: [
      Card(child: Padding(padding: pad, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text('مبلغ کل', style: TextStyle(color: c.textMuted)), const Spacer(), StatusPill(o.status)]),
        const SizedBox(height: 6),
        Text(toman(o.total), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
        Text('ثبت‌شده ${ago(o.createdAt)}', style: TextStyle(color: c.textFaint, fontSize: 12)),
      ]))),
      const SectionTitle('مشتری'),
      Card(child: Padding(padding: pad, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(radius: 20, backgroundColor: c.accentSoft, child: Text(o.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2), Text(fa(int.parse(o.mobile)).replaceAll(',', '').padLeft(11, '۰'), style: TextStyle(color: c.textMuted)),
          const SizedBox(height: 6), Text(o.address, style: TextStyle(color: c.text, height: 1.6)),
          if (o.instagram.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: InkWell(onTap: () => openIg(context, o.instagram),
            child: Text('اینستاگرام: @${o.instagram}', textDirection: TextDirection.ltr, style: TextStyle(color: c.text, fontWeight: FontWeight.w600)))),
          if (o.note.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text('توضیح: ${o.note}', style: TextStyle(color: c.textMuted))),
        ])),
        IconButton(tooltip: 'کپی برای برچسب پست', icon: const Icon(Icons.copy_rounded, size: 20), onPressed: () => copy(context, '${o.name}\n${o.mobile}\n${o.address}')),
      ]))),
      if (o.status == 'delivered') ...[
        const SectionTitle('نظر مشتری'),
        Card(child: Padding(padding: pad, child: o.rating == 0 ? Text('مشتری تحویل را تأیید کرده؛ هنوز نظری ثبت نکرده.', style: TextStyle(color: c.textMuted)) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [for (var i = 1; i <= 5; i++) Icon(Icons.star_rounded, size: 22, color: i <= o.rating ? const Color(0xFFE0A43A) : c.line), const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: (o.privateReview ? c.negative : c.positive).withValues(alpha: 0.10), border: Border.all(color: (o.privateReview ? c.negative : c.positive).withValues(alpha: 0.25))),
              child: Text(o.privateReview ? 'بازخورد خصوصی' : 'به اینستاگرام هدایت شد', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: o.privateReview ? c.negative : c.positive)))]),
          if (o.comment.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 10), child: Text('«${o.comment}»', style: TextStyle(color: c.text, height: 1.7))),
          if (o.privateReview) Padding(padding: const EdgeInsets.only(top: 8), child: Text('این نظر فقط برای شما فرستاده شده و جایی منتشر نشده؛ بهتر است با مشتری تماس بگیرید.', style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.6))),
          if (o.privateReview && o.instagram.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 10), child: OutlinedButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('پیام به مشتری در دایرکت'), onPressed: () => openIg(context, o.instagram))),
        ]))),
      ],
      const SectionTitle('اقلام'),
      Card(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Column(children: [
        for (final i in o.items) row('${fa(i.qty)} × ${i.name}', toman(i.price * i.qty)),
        Divider(color: c.line), row('جمع', toman(o.total), bold: true)]))),
      const SectionTitle('پرداخت'),
      Card(child: Padding(padding: pad, child: Row(children: [
        Icon(o.payRef.isEmpty ? Icons.hourglass_empty_rounded : Icons.receipt_rounded, color: c.textMuted), const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.payRef.isEmpty ? 'هنوز واریزی اعلام نشده' : 'شماره پیگیری واریز: ${o.payRef}', style: const TextStyle(fontWeight: FontWeight.w600)),
          if (o.hasReceipt) Text('عکس رسید پیوست شده (دمو)', style: TextStyle(color: c.textMuted, fontSize: 13)),
        ]))]))),
      const SizedBox(height: 20),
      if (o.status == 'pending_payment' || o.status == 'awaiting_confirm') FilledButton.icon(icon: const Icon(Icons.check_rounded), label: const Text('تأیید واریز'), onPressed: () => set('paid')),
      if (o.status == 'paid' || o.status == 'shipped') ...[
        TextField(controller: post, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'کد رهگیری پست', prefixIcon: Icon(Icons.local_shipping_outlined))),
        const SizedBox(height: 12),
        FilledButton(onPressed: () { o.postalCode = toEn(post.text); set('shipped'); }, child: Text(o.status == 'shipped' ? 'ذخیره کد رهگیری' : 'ثبت کد و ارسال'))],
      const SizedBox(height: 10),
      OutlinedButton.icon(icon: const Icon(Icons.link_rounded), onPressed: () => copy(context, 'سلام ${o.name} عزیز، وضعیت سفارشت رو اینجا ببین: ${storeLink.replaceFirst('order.html?s=noora', 'track.html?c=${o.code}')}'), label: const Text('کپی لینک پیگیری برای مشتری')),
      const SectionTitle('تغییر دستی وضعیت'),
      Wrap(spacing: 8, runSpacing: 8, children: [for (final s in statusLabels.keys) ChoiceChip(showCheckmark: false, label: Text(statusLabels[s]!), selected: o.status == s, onSelected: (_) => set(s))]),
    ]));
  }
}

class CustomersPage extends StatelessWidget { const CustomersPage({super.key});
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context); final cs = Store.I.customers();
    return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), children: [
      Text('${fa(cs.length)} مشتری · ${fa(cs.where((x) => x.count > 1).length)} مشتری ثابت', style: TextStyle(color: c.textMuted)),
      const SizedBox(height: 12),
      Card(child: Column(children: [for (final (i, x) in cs.indexed) ...[
        if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
        ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: CircleAvatar(backgroundColor: c.accentSoft, child: Text(x.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
          title: Row(children: [Text(x.name, style: const TextStyle(fontWeight: FontWeight.w700)), if (x.count > 1) ...[const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: c.positive.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
              child: Text('ثابت', style: TextStyle(color: c.positive, fontSize: 11, fontWeight: FontWeight.w700)))]]),
          subtitle: Text('${fa(x.count)} سفارش · آخرین خرید ${fa(x.daysSince)} روز پیش', style: TextStyle(color: c.textMuted, fontSize: 13)),
          trailing: Text(toman(x.spent), style: const TextStyle(fontWeight: FontWeight.w700)))]])),
    ]);
  }
}

class ReorderPage extends StatefulWidget { const ReorderPage({super.key}); @override State<ReorderPage> createState() => _ReorderState(); }
class _ReorderState extends State<ReorderPage> {
  Future<void> mark(CustomerStat x, bool v) async { await Store.I.markSent(x.mobile, v); setState(() {});
    if (mounted && v) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${x.name} به «ارسال‌شده‌ها» رفت'), action: SnackBarAction(label: 'برگردان', onPressed: () => mark(x, false)))); }
  @override
  Widget build(BuildContext context) { final all = Store.I.reorderDue(); final c = AppColors.of(context);
    final todo = all.where((x) => !Store.I.sent.contains(x.mobile)).toList(), done = all.where((x) => Store.I.sent.contains(x.mobile)).toList();
    return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), children: [
      Text('مشتری‌هایی که ۳۰ تا ۶۰ روز پیش خرید کرده‌اند. پیام را کپی کن، دایرکتشان را باز کن و بفرست؛ بعد «ارسال کردم» را بزن.', style: TextStyle(color: c.textMuted, height: 1.7)),
      SectionTitle('برای ارسال · ${fa(todo.length)}'),
      if (todo.isEmpty) Padding(padding: const EdgeInsets.all(28), child: Center(child: Text('همه‌ی یادآوری‌ها ارسال شده ✓', style: TextStyle(color: c.textMuted)))),
      for (final x in todo) Padding(padding: const EdgeInsets.only(bottom: 10), child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text(x.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const SizedBox(width: 8),
          if (x.instagram.isNotEmpty) Text('@${x.instagram}', textDirection: TextDirection.ltr, style: TextStyle(color: c.textMuted, fontSize: 12)), const Spacer(),
          Text('${fa(x.daysSince)} روز پیش', style: TextStyle(color: c.textFaint, fontSize: 12))]),
        const SizedBox(height: 10),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.background, borderRadius: BorderRadius.circular(12), border: Border.all(color: c.line)),
          child: Text(Store.I.reminder(x), style: TextStyle(color: c.textMuted, height: 1.7, fontSize: 13))),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.copy_rounded, size: 18), label: const Text('کپی پیام'), onPressed: () => copy(context, Store.I.reminder(x)))),
          const SizedBox(width: 8),
          Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('باز کردن دایرکت'), onPressed: () { copy(context, Store.I.reminder(x)); openIg(context, x.instagram); })),
        ]),
        const SizedBox(height: 8),
        FilledButton.icon(icon: const Icon(Icons.check_rounded), label: const Text('ارسال کردم'), onPressed: () => mark(x, true)),
      ])))),
      if (done.isNotEmpty) ...[
        SectionTitle('ارسال‌شده · ${fa(done.length)}'),
        Card(child: Column(children: [for (final (i, x) in done.indexed) ...[
          if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
          ListTile(leading: Icon(Icons.check_circle_rounded, color: c.positive), title: Text(x.name, style: TextStyle(color: c.textMuted, fontWeight: FontWeight.w600)),
            subtitle: Text('یادآوری فرستاده شد', style: TextStyle(color: c.textFaint, fontSize: 12)),
            trailing: TextButton(onPressed: () => mark(x, false), child: const Text('برگردان')))]])),
      ],
    ]);
  }
}

class ProductsPage extends StatefulWidget { const ProductsPage({super.key}); @override State<ProductsPage> createState() => _ProductsState(); }
class _ProductsState extends State<ProductsPage> {
  Future<void> edit([Product? p]) async {
    final n = TextEditingController(text: p?.name), pr = TextEditingController(text: p?.price.toString());
    final ok = await showDialog<bool>(context: context, builder: (c) => AlertDialog(title: Text(p == null ? 'محصول جدید' : 'ویرایش محصول'), content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: n, decoration: const InputDecoration(labelText: 'نام')), const SizedBox(height: 12),
      TextField(controller: pr, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'قیمت (تومان)'))]),
      actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('انصراف')),
        SizedBox(width: 110, child: FilledButton(style: FilledButton.styleFrom(minimumSize: const Size(0, 44)), onPressed: () => Navigator.pop(c, true), child: const Text('ذخیره')))]));
    final price = int.tryParse(toEn(pr.text)); if (ok != true || n.text.isEmpty || price == null) return;
    setState(() { if (p == null) { Store.I.products.add(Product(Store.I.products.fold(0, (s, x) => x.id > s ? x.id : s) + 1, n.text, price)); } else { p.name = n.text; p.price = price; } }); Store.I.save();
  }
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    return Scaffold(backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(onPressed: edit, child: const Icon(Icons.add_rounded)),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 100), children: [Card(child: Column(children: [for (final (i, p) in Store.I.products.indexed) ...[
        if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
        ListTile(contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 4), onTap: () => edit(p),
          title: Text(p.name, style: TextStyle(fontWeight: FontWeight.w700, color: p.active ? c.text : c.textFaint)),
          subtitle: Text(toman(p.price), style: TextStyle(color: c.textMuted)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Switch(value: p.active, onChanged: (v) { setState(() => p.active = v); Store.I.save(); }),
            IconButton(icon: Icon(Icons.delete_outline_rounded, color: c.textFaint), onPressed: () { setState(() => Store.I.products.remove(p)); Store.I.save(); })]))]]))]));
  }
}

class DmPage extends StatefulWidget { const DmPage({super.key}); @override State<DmPage> createState() => _DmState(); }
class _DmState extends State<DmPage> {
  final t = TextEditingController(text: 'سلام ۲ تا شمع لیوانی بزرگ میخوام\nاسمم: لیلا صادقی\nآدرس: تبریز، ولیعصر، کوچه ۳\n۰۹۳۵۱۲۳۴۵۶۷'); Order? d;
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    Widget kv(String k, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 64, child: Text(k, style: TextStyle(color: c.textMuted))), Expanded(child: Text(v.isEmpty ? '—' : v, style: const TextStyle(fontWeight: FontWeight.w600)))]));
    return Scaffold(appBar: AppBar(title: const Text('دایرکت ← سفارش')), body: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 32), children: [
      Text('متن دایرکت مشتری را بچسبان تا یک سفارش پیش‌نویس ساخته شود.', style: TextStyle(color: c.textMuted)),
      const SizedBox(height: 12),
      TextField(controller: t, maxLines: 6, decoration: const InputDecoration(hintText: 'متن دایرکت')),
      const SizedBox(height: 12), FilledButton(onPressed: () => setState(() => d = Store.I.parseDm(t.text)), child: const Text('استخراج سفارش')),
      if (d != null) ...[const SectionTitle('پیش‌نویس — قبل از ثبت چک کن'), Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        kv('نام', d!.name), kv('موبایل', d!.mobile), kv('آدرس', d!.address),
        kv('اقلام', d!.items.map((i) => '${fa(i.qty)} × ${i.name}').join('\n')), Divider(color: c.line), kv('جمع', toman(d!.total)),
        const SizedBox(height: 12),
        FilledButton(onPressed: d!.items.isEmpty ? null : () { Store.I.add(d!); Navigator.pop(context); }, child: const Text('ثبت سفارش'))])))],
    ]));
  }
}
