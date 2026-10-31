import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
/// Order code to open right after PIN login: web ?order=CODE or #/order/CODE, or an Android app link (track.html?c=CODE).
String? pendingOrder = _q['order'] ?? RegExp(r'order/([A-Za-z0-9]+)').firstMatch(Uri.base.fragment)?.group(1);
bool loggedIn = false;
final navKey = GlobalKey<NavigatorState>();
void openPending() { final code = pendingOrder; final ctx = navKey.currentContext; if (code == null || !loggedIn || ctx == null) return;
  pendingOrder = null; final o = Store.I.find(code);
  if (o == null) { snack(ctx, 'سفارش $code پیدا نشد'); } else { navKey.currentState!.push(MaterialPageRoute(builder: (_) => OrderPage(o))); } }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Store.I.load();
  final p = await SharedPreferences.getInstance();
  themeMode.value = ThemeMode.values.firstWhere((m) => m.name == (_q['theme'] ?? p.getString('themeMode')), orElse: () => ThemeMode.system);
  themeMode.addListener(() => p.setString('themeMode', themeMode.value.name));
  if (!kIsWeb) { AppLinks().uriLinkStream.listen((u) { final c = codeFromText(u.toString()); if (c != null) { pendingOrder = c; openPending(); } }); }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(valueListenable: themeMode, builder: (_, mode, _) => MaterialApp(
      title: 'سررشته – مدیریت سفارش‌ها', debugShowCheckedModeBanner: false, navigatorKey: navKey,
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
  void go() { if (toEn(pin.text) == demoPin) { loggedIn = true; Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Home())); WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(const Duration(milliseconds: 350), openPending)); } else { setState(() => err = 'رمز اشتباه است'); } }
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
        IconButton(tooltip: 'باز کردن از لینک', icon: const Icon(Icons.open_in_new_rounded), onPressed: () async { await openFromLink(context); setState(() {}); }),
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

const _months = ['فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور', 'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'];
/// Gregorian -> Jalali (year, month) for month grouping.
(int, int, int) jalali(DateTime d) {
  var gy = d.year, gm = d.month, gd = d.day;
  const g = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
  final gy2 = gm > 2 ? gy + 1 : gy;
  var days = 355666 + 365 * gy + ((gy2 + 3) ~/ 4) - ((gy2 + 99) ~/ 100) + ((gy2 + 399) ~/ 400) + gd + g[gm - 1];
  var jy = -1595 + 33 * (days ~/ 12053); days %= 12053; jy += 4 * (days ~/ 1461); days %= 1461;
  if (days > 365) { jy += (days - 1) ~/ 365; days = (days - 1) % 365; }
  final jm = days < 186 ? 1 + days ~/ 31 : 7 + (days - 186) ~/ 30; final jd = 1 + (days < 186 ? days % 31 : (days - 186) % 30);
  return (jy, jm, jd);
}
String monthLabel(DateTime d) { final (y, m, _) = jalali(d); return '${_months[m - 1]} ${fa(y).replaceAll(',', '')}'; }
String jDate(DateTime d) { final (y, m, dd) = jalali(d); return '${fa(dd)} ${_months[m - 1]} ${fa(y).replaceAll(',', '')}'; }

Widget tag(String t, Color col, {IconData? icon}) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  decoration: BoxDecoration(color: col.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20), border: Border.all(color: col.withValues(alpha: 0.25))),
  child: Row(mainAxisSize: MainAxisSize.min, children: [if (icon != null) ...[Icon(icon, size: 13, color: col), const SizedBox(width: 4)],
    Text(t, style: TextStyle(color: col, fontSize: 11, fontWeight: FontWeight.w700))]));

Future<void> openOrder(BuildContext context, Order o) => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderPage(o)));

/// Paste a tracking link (track.html?c=CODE), an app link (?order=CODE / #/order/CODE) or a bare code.
String? codeFromText(String t) {
  final s = toEn(t).trim();
  final m = RegExp(r'[?&](?:c|order)=([A-Za-z0-9]+)').firstMatch(s) ?? RegExp(r'order/([A-Za-z0-9]+)').firstMatch(s) ?? RegExp(r'^\s*([A-Za-z]{2}\d+)\s*$').firstMatch(s);
  return m?.group(1)?.toUpperCase();
}
Future<void> openFromLink(BuildContext context) async {
  final ctl = TextEditingController(); String? err;
  final o = await showDialog<Order>(context: context, builder: (dc) => StatefulBuilder(builder: (dc, set) => AlertDialog(
    title: const Text('باز کردن سفارش از لینک'),
    content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('لینک پیگیری مشتری یا کد سفارش را بچسبان.', style: TextStyle(color: AppColors.of(dc).textMuted, fontSize: 13)), const SizedBox(height: 12),
      TextField(controller: ctl, autofocus: true, textDirection: TextDirection.ltr, decoration: InputDecoration(hintText: 'track.html?c=NR1003 یا NR1003', errorText: err,
        suffixIcon: IconButton(tooltip: 'چسباندن', icon: const Icon(Icons.content_paste_rounded), onPressed: () async { final d = await Clipboard.getData('text/plain'); ctl.text = d?.text ?? ''; set(() {}); }))),
    ]),
    actions: [TextButton(onPressed: () => Navigator.pop(dc), child: const Text('انصراف')),
      FilledButton(onPressed: () { final c = codeFromText(ctl.text); final f = c == null ? null : Store.I.find(c);
        if (f == null) { set(() => err = c == null ? 'لینک یا کد معتبر نیست' : 'سفارشی با کد $c پیدا نشد'); } else { Navigator.pop(dc, f); } }, child: const Text('باز کن'))])));
  if (o != null && context.mounted) await openOrder(context, o);
}

class OrdersPage extends StatefulWidget { final VoidCallback onChange; const OrdersPage({super.key, required this.onChange}); @override State<OrdersPage> createState() => _OrdersState(); }
class _OrdersState extends State<OrdersPage> {
  static const groups = ['awaiting_confirm', 'pending_payment', 'paid', 'shipped'];
  static const gl = ['منتظر تأیید واریز', 'منتظر واریز', 'پرداخت‌شده', 'ارسال‌شده'];
  int g = 0; final q = TextEditingController(); DateTimeRange? range; String rangeLabel = '';
  Future<void> pickRange() async {
    final now = DateTime.now(); final today = DateTime(now.year, now.month, now.day);
    final v = await showModalBottomSheet<int>(context: context, showDragHandle: true, builder: (bc) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 8), child: Align(alignment: AlignmentDirectional.centerStart, child: Text('فیلتر تاریخ ثبت سفارش', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)))),
      for (final (i, t) in ['امروز', 'این هفته (۷ روز اخیر)', 'این ماه (۳۰ روز اخیر)', 'بازه‌ی دلخواه…'].indexed) ListTile(title: Text(t), onTap: () => Navigator.pop(bc, i)),
      if (range != null) ListTile(leading: const Icon(Icons.close_rounded), title: const Text('حذف فیلتر تاریخ'), onTap: () => Navigator.pop(bc, 9)),
      const SizedBox(height: 8)])));
    if (v == null || !mounted) return;
    if (v == 9) { setState(() => range = null); return; }
    if (v == 3) { final r = await showDateRangePicker(context: context, firstDate: today.subtract(const Duration(days: 400)), lastDate: today, initialDateRange: range);
      if (r != null) setState(() { range = r; rangeLabel = '${jDate(r.start)} تا ${jDate(r.end)}'; }); return; }
    setState(() { range = DateTimeRange(start: today.subtract(Duration(days: [0, 6, 29][v])), end: today); rangeLabel = ['امروز', 'این هفته', 'این ماه'][v]; });
  }
  bool inRange(Order o) => range == null || (!o.createdAt.isBefore(range!.start) && o.createdAt.isBefore(range!.end.add(const Duration(days: 1))));
  Future<void> open(Order o) async { await openOrder(context, o); setState(() {}); widget.onChange(); }
  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final os = Store.I.orders.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final searching = q.text.trim().isNotEmpty || range != null;
    int n(int i) => os.where((o) => o.status == groups[i]).length;
    final follow = os.where((o) => o.followUp).length;
    final unseen = os.where((o) => o.unseen).length;
    final archived = os.where((o) => o.archived).length;
    final paidList = os.where((o) => o.status == 'paid').toList(); final paidSum = paidList.fold(0, (s, o) => s + o.total);
    final results = searching ? os.where((o) => o.matches(q.text) && inRange(o)).toList() : <Order>[];
    final list = os.where((o) => o.status == groups[g]).toList();
    return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 100), children: [
      Row(children: [
        Expanded(child: TextField(controller: q, onChanged: (_) => setState(() {}), decoration: InputDecoration(isDense: true, prefixIcon: const Icon(Icons.search_rounded),
          hintText: 'جستجو: کد سفارش، اسم، موبایل یا آیدی اینستا', hintStyle: TextStyle(fontSize: 13, color: c.textFaint),
          suffixIcon: q.text.isEmpty ? null : IconButton(tooltip: 'پاک کردن', icon: const Icon(Icons.close_rounded), onPressed: () => setState(q.clear))))),
        const SizedBox(width: 8),
        IconButton.outlined(tooltip: 'فیلتر تاریخ', isSelected: range != null, onPressed: pickRange, icon: const Icon(Icons.date_range_rounded)),
      ]),
      if (range != null) Padding(padding: const EdgeInsets.only(top: 10), child: Align(alignment: AlignmentDirectional.centerStart,
        child: InputChip(avatar: const Icon(Icons.event_rounded, size: 16), label: Text('تاریخ: $rangeLabel'), onDeleted: () => setState(() => range = null), deleteButtonTooltipMessage: 'حذف فیلتر'))),
      if (searching) ...[
        Padding(padding: const EdgeInsets.fromLTRB(4, 16, 4, 10), child: Text(results.isEmpty ? '' : '${fa(results.length)} نتیجه در همه‌ی سفارش‌ها (همراه بایگانی)', style: TextStyle(color: c.textMuted, fontSize: 13, fontWeight: FontWeight.w700))),
        if (results.isEmpty) Padding(padding: const EdgeInsets.all(32), child: Column(children: [Icon(Icons.search_off_rounded, size: 40, color: c.textFaint), const SizedBox(height: 10),
          Text('سفارشی با این مشخصات پیدا نشد', style: TextStyle(fontWeight: FontWeight.w700, color: c.text)), const SizedBox(height: 4),
          Text('کد سفارش (مثل NR1003)، بخشی از اسم، شماره موبایل یا آیدی اینستا را امتحان کن${range != null ? '، یا فیلتر تاریخ را بردار' : ''}.', textAlign: TextAlign.center, style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.7))])),
        for (final o in results.take(60)) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () => open(o))),
      ] else ...[
        const SizedBox(height: 14),
        Card(clipBehavior: Clip.antiAlias, child: InkWell(onTap: () async { await Navigator.push(context, MaterialPageRoute(builder: (_) => const ArchivePage())); setState(() {}); },
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(children: [
            Icon(Icons.inventory_2_outlined, color: c.textMuted), const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('بایگانی', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
              Text('سفارش‌های تکمیل‌شده و لغوشده – ${fa(archived)}', style: TextStyle(color: c.textMuted, fontSize: 12))])),
            if (unseen > 0) Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3), decoration: BoxDecoration(color: c.negative, borderRadius: BorderRadius.circular(20)),
              child: Text('${fa(unseen)} جدید', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800))),
            const SizedBox(width: 4), Icon(Icons.chevron_left_rounded, color: c.textFaint)])))),
        const SizedBox(height: 14),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [for (var i = 0; i < 4; i++) Padding(padding: const EdgeInsetsDirectional.only(end: 8),
          child: ChoiceChip(showCheckmark: false, selected: g == i, onSelected: (_) => setState(() => g = i), label: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('${gl[i]} ${fa(n(i))}'),
            if (i == 3 && follow > 0) ...[const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: c.negative, borderRadius: BorderRadius.circular(10)),
              child: Text(fa(follow), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)))]])))])),
        const SizedBox(height: 12),
        if (g == 2) Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: c.line)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('پرداخت‌شده، هنوز ارسال‌نشده', style: TextStyle(color: c.textMuted, fontSize: 12)), const SizedBox(height: 2),
              Text('${fa(paidList.length)} سفارش', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('مبلغ کل', style: TextStyle(color: c.textMuted, fontSize: 12)), const SizedBox(height: 2),
              Text(toman(paidSum), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: c.positive))])])),
        if (g == 3 && follow > 0) Padding(padding: const EdgeInsets.only(bottom: 12), child: Text('${fa(follow)} سفارش بیش از ${fa(deliveryFollowUpDays)} روز است ارسال شده و مشتری هنوز «به دستم رسید» را نزده. پیام بده یا خودت تکمیلش کن.', style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.7))),
        if (list.isEmpty) Padding(padding: const EdgeInsets.all(40), child: Center(child: Text('سفارشی در این وضعیت نیست', style: TextStyle(color: c.textMuted)))),
        for (final o in list) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () => open(o))),
      ],
    ]);
  }
}

class OrderCard extends StatelessWidget {
  final Order o; final VoidCallback onTap; const OrderCard(this.o, {super.key, required this.onTap});
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    final tags = <Widget>[
      if (o.unseen && o.rating > 0) tag('نظر جدید', c.negative, icon: Icons.star_rounded),
      if (o.followUp) tag('پیگیری تحویل – ${ago(o.createdAt)}', c.negative, icon: Icons.local_shipping_outlined),
      if (o.payReminder) tag('یادآوری پرداخت – ${ago(o.createdAt)}', c.negative),
      if (o.archived && o.rating > 0 && !o.unseen) tag('${fa(o.rating)}★', o.privateReview ? c.negative : c.positive),
    ];
    return Card(clipBehavior: Clip.antiAlias, child: InkWell(onTap: onTap, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Stack(clipBehavior: Clip.none, children: [CircleAvatar(radius: 18, backgroundColor: c.accentSoft, child: Text(o.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
          if (o.unseen) Positioned(top: -1, right: -1, child: Container(width: 11, height: 11, decoration: BoxDecoration(color: c.negative, shape: BoxShape.circle, border: Border.all(color: c.card, width: 2))))]),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.name, style: TextStyle(fontSize: 16, fontWeight: o.unseen ? FontWeight.w800 : FontWeight.w700)),
          Text('${o.code} – ${ago(o.createdAt)}', style: TextStyle(color: c.textFaint, fontSize: 12)),
        ])),
        StatusPill(o.status),
      ]),
      const SizedBox(height: 12), Divider(color: c.line), const SizedBox(height: 12),
      Row(children: [
        Expanded(child: Text(o.items.map((i) => '${fa(i.qty)}× ${i.name}').join('، '), style: TextStyle(color: c.textMuted, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 12),
        Text(toman(o.total), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ]),
      if (tags.isNotEmpty || o.payReminder || o.followUp) ...[
        const SizedBox(height: 12),
        Row(children: [Expanded(child: Wrap(spacing: 6, runSpacing: 6, children: tags)),
          if (o.payReminder) TextButton.icon(icon: const Icon(Icons.send_rounded, size: 16), label: const Text('پیام در دایرکت'), onPressed: () { copy(context, Store.I.payReminder(o)); openIg(context, o.instagram); }),
          if (o.followUp) TextButton.icon(icon: const Icon(Icons.send_rounded, size: 16), label: const Text('پیام در دایرکت'), onPressed: () { copy(context, Store.I.deliveryMsg(o)); openIg(context, o.instagram); }),
        ]),
      ],
    ]))));
  }
}

class ArchivePage extends StatefulWidget { const ArchivePage({super.key}); @override State<ArchivePage> createState() => _ArchiveState(); }
class _ArchiveState extends State<ArchivePage> {
  final shown = [20, 20];
  Widget tab(int t) { final c = AppColors.of(context); final st = t == 0 ? 'delivered' : 'cancelled';
    final all = Store.I.orders.where((o) => o.status == st).toList()..sort((a, b) {
      if (a.unseen != b.unseen) return a.unseen ? -1 : 1; return b.createdAt.compareTo(a.createdAt); });
    final unseen = all.where((o) => o.unseen).toList(); final rest = all.where((o) => !o.unseen).toList();
    final page = rest.take(shown[t]).toList();
    final kids = <Widget>[];
    if (t == 0) kids.add(Padding(padding: const EdgeInsets.fromLTRB(4, 4, 4, 0), child: Text('سفارش‌هایی که مشتری «به دستم رسید» را زده یا تو تکمیلشان کرده‌ای. نقطه‌ی قرمز یعنی هنوز بازش نکرده‌ای.', style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.7))));
    if (unseen.isNotEmpty) { kids.add(SectionTitle('جدید – دیده‌نشده ${fa(unseen.length)}')); for (final o in unseen) { kids.add(card(o)); } }
    String? m;
    for (final o in page) { final l = monthLabel(o.createdAt); if (l != m) { m = l; kids.add(SectionTitle(l)); } kids.add(card(o)); }
    if (all.isEmpty) kids.add(Padding(padding: const EdgeInsets.all(40), child: Center(child: Text('سفارشی اینجا نیست', style: TextStyle(color: c.textMuted)))));
    if (rest.length > shown[t]) { kids.add(Padding(padding: const EdgeInsets.only(top: 6), child: OutlinedButton(onPressed: () => setState(() => shown[t] += 20), child: Text('نمایش بیشتر (${fa(rest.length - shown[t])} سفارش دیگر)')))); }
    else if (rest.isNotEmpty) { kids.add(Padding(padding: const EdgeInsets.all(16), child: Center(child: Text('همه‌ی ${fa(all.length)} سفارش نمایش داده شد', style: TextStyle(color: c.textFaint, fontSize: 12))))); }
    return ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 32), children: kids);
  }
  Widget card(Order o) => Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () async { await openOrder(context, o); setState(() {}); }));
  @override
  Widget build(BuildContext context) { final u = Store.I.orders.where((o) => o.unseen).length;
    final done = Store.I.orders.where((o) => o.status == 'delivered').length, canc = Store.I.orders.where((o) => o.status == 'cancelled').length;
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(title: const Text('بایگانی'), bottom: TabBar(tabs: [
      Tab(text: 'تکمیل‌شده ${fa(done)}${u > 0 ? ' – ${fa(u)} جدید' : ''}'), Tab(text: 'لغوشده ${fa(canc)}')])),
      body: TabBarView(children: [tab(0), tab(1)])));
  }
}

class OrderPage extends StatefulWidget { final Order o; const OrderPage(this.o, {super.key}); @override State<OrderPage> createState() => _OrderState(); }
class _OrderState extends State<OrderPage> {
  late final post = TextEditingController(text: widget.o.postalCode);
  @override
  void initState() { super.initState(); if (!widget.o.seen) { widget.o.seen = true; Store.I.save(); } }
  Future<void> complete() async {
    final ok = await showDialog<bool>(context: context, builder: (dc) => AlertDialog(title: const Text('تکمیل سفارش؟'),
      content: const Text('مطمئنی سفارش به دست مشتری رسیده؟ سفارش به «بایگانی › تکمیل‌شده» می‌رود. مشتری هنوز می‌تواند از لینک پیگیری نظر بدهد.'),
      actions: [TextButton(onPressed: () => Navigator.pop(dc, false), child: const Text('انصراف')), FilledButton(onPressed: () => Navigator.pop(dc, true), child: const Text('بله، تکمیلش کن'))]));
    if (ok == true) set('delivered');
  }
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
      if (o.followUp) ...[
        const SizedBox(height: 12),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.negative.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: c.negative.withValues(alpha: 0.25))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('پیگیری تحویل', style: TextStyle(fontWeight: FontWeight.w800, color: c.negative)), const SizedBox(height: 4),
            Text('${ago(o.createdAt)} ارسال شده و مشتری هنوز «به دستم رسید» را نزده. معمولاً پست ${fa(deliveryFollowUpDays)} روزه می‌رسد.', style: TextStyle(color: c.textMuted, height: 1.7, fontSize: 13)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('پیام در دایرکت'), onPressed: () { copy(context, Store.I.deliveryMsg(o)); openIg(context, o.instagram); })),
              const SizedBox(width: 8),
              Expanded(child: FilledButton.icon(icon: const Icon(Icons.check_rounded, size: 18), label: const Text('تکمیلش کن'), onPressed: complete)),
            ]),
          ])),
      ],
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

class CustomersPage extends StatefulWidget { const CustomersPage({super.key}); @override State<CustomersPage> createState() => _CustomersState(); }
class _CustomersState extends State<CustomersPage> {
  final q = TextEditingController();
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context); final all = Store.I.customers();
    final t = toEn(q.text).trim().toLowerCase().replaceAll('@', '');
    final cs = t.isEmpty ? all : all.where((x) => x.name.contains(q.text.trim()) || x.mobile.contains(t) || x.instagram.toLowerCase().contains(t)).toList();
    return ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), children: [
      TextField(controller: q, onChanged: (_) => setState(() {}), decoration: InputDecoration(isDense: true, prefixIcon: const Icon(Icons.search_rounded),
        hintText: 'جستجو: اسم، موبایل یا آیدی اینستا', hintStyle: TextStyle(fontSize: 13, color: c.textFaint),
        suffixIcon: q.text.isEmpty ? null : IconButton(tooltip: 'پاک کردن', icon: const Icon(Icons.close_rounded), onPressed: () => setState(q.clear)))),
      const SizedBox(height: 12),
      Text(t.isEmpty ? '${fa(all.length)} مشتری – ${fa(all.where((x) => x.count > 1).length)} مشتری ثابت' : '${fa(cs.length)} نتیجه', style: TextStyle(color: c.textMuted)),
      const SizedBox(height: 12),
      if (cs.isEmpty) Padding(padding: const EdgeInsets.all(32), child: Center(child: Text('مشتری‌ای با این مشخصات پیدا نشد', style: TextStyle(color: c.textMuted)))),
      if (cs.isNotEmpty) Card(child: Column(children: [for (final (i, x) in cs.indexed) ...[
        if (i > 0) Divider(color: c.line, indent: 16, endIndent: 16),
        ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          onTap: () async { await Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerPage(x.mobile))); setState(() {}); },
          leading: CircleAvatar(backgroundColor: c.accentSoft, child: Text(x.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
          title: Row(children: [Flexible(child: Text(x.name, style: const TextStyle(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)), if (x.count > 1) ...[const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: c.positive.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
              child: Text('ثابت', style: TextStyle(color: c.positive, fontSize: 11, fontWeight: FontWeight.w700)))]]),
          subtitle: Text('${fa(x.count)} سفارش – آخرین خرید ${fa(x.daysSince)} روز پیش', style: TextStyle(color: c.textMuted, fontSize: 13)),
          trailing: Text(toman(x.spent), style: const TextStyle(fontWeight: FontWeight.w700)))]])),
    ]);
  }
}

class CustomerPage extends StatefulWidget { final String mobile; const CustomerPage(this.mobile, {super.key}); @override State<CustomerPage> createState() => _CustomerState(); }
class _CustomerState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    final os = Store.I.orders.where((o) => o.mobile == widget.mobile).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final l = os.first; final valid = os.where((o) => o.status != 'cancelled').toList();
    final spent = valid.fold(0, (s, o) => s + o.total);
    final qty = <String, int>{}; for (final o in valid) { for (final i in o.items) { qty[i.name] = (qty[i.name] ?? 0) + i.qty; } }
    final top = qty.isEmpty ? '—' : (qty.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key;
    final rated = os.where((o) => o.rating > 0).toList();
    final ig = os.map((o) => o.instagram).firstWhere((x) => x.isNotEmpty, orElse: () => '');
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
          IconButton.outlined(tooltip: 'تماس', icon: const Icon(Icons.call_rounded), onPressed: () => launchUrl(Uri.parse('tel:${l.mobile}'))),
          const SizedBox(width: 4),
          IconButton.outlined(tooltip: 'کپی شماره', icon: const Icon(Icons.copy_rounded), onPressed: () => copy(context, l.mobile)),
        ]),
      ]))),
      const SectionTitle('آمار خرید'),
      GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2.4, children: [
        stat('تعداد سفارش', '${fa(valid.length)}${os.length > valid.length ? ' (+${fa(os.length - valid.length)} لغو)' : ''}'),
        stat('جمع خرید', toman(spent)),
        stat('میانگین خرید', valid.isEmpty ? '—' : toman(spent ~/ valid.length)),
        stat('میانگین امتیاز', rated.isEmpty ? 'بدون نظر' : '${(rated.fold(0, (s, o) => s + o.rating) / rated.length).toStringAsFixed(1).replaceAllMapped(RegExp(r'\d'), (m) => '۰۱۲۳۴۵۶۷۸۹'[int.parse(m[0]!)])} ★ از ${fa(rated.length)}'),
        stat('اولین سفارش', jDate(os.last.createdAt)),
        stat('آخرین سفارش', jDate(os.first.createdAt)),
      ]),
      const SizedBox(height: 8), stat('محصول پرتکرار', top),
      SectionTitle('سفارش‌ها – ${fa(os.length)}'),
      for (final o in os) Padding(padding: const EdgeInsets.only(bottom: 10), child: OrderCard(o, onTap: () async { await openOrder(context, o); setState(() {}); })),
    ]));
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
      SectionTitle('برای ارسال – ${fa(todo.length)}'),
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
        SectionTitle('ارسال‌شده – ${fa(done.length)}'),
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
