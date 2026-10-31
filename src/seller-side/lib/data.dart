// DEMO ONLY: local mock data (seeded), persisted with shared_preferences. No server.
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const storeLink = 'https://vahid75hj.github.io/sarreshte/client/order.html?s=noora';
const storeName = 'شمع نورا';
const demoPin = '1234';
const shopAccount = 'noora@sarreshte.app';
const shopInstagram = 'noora.candle';

class Product { int id; String name; int price; bool active;
  Product(this.id, this.name, this.price, {this.active = true});
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'price': price, 'active': active};
  factory Product.fromJson(Map j) => Product(j['id'], j['name'], j['price'], active: j['active']); }

class Item { String name; int price; int qty; Item(this.name, this.price, this.qty);
  Map<String, dynamic> toJson() => {'name': name, 'price': price, 'qty': qty};
  factory Item.fromJson(Map j) => Item(j['name'], j['price'], j['qty']); }

class Order { int id; String code, name, mobile, address, note, status, payRef, postalCode, instagram, comment; int rating; bool hasReceipt; DateTime createdAt; List<Item> items;
  Order({required this.id, required this.code, required this.name, required this.mobile, required this.address, this.note = '', required this.status,
    this.payRef = '', this.postalCode = '', this.instagram = '', this.comment = '', this.rating = 0, this.hasReceipt = false, required this.createdAt, required this.items});
  bool get privateReview => rating > 0 && rating <= 3;
  int get total => items.fold(0, (s, i) => s + i.price * i.qty);
  Map<String, dynamic> toJson() => {'id': id, 'code': code, 'name': name, 'mobile': mobile, 'address': address, 'note': note, 'status': status,
    'payRef': payRef, 'postalCode': postalCode, 'hasReceipt': hasReceipt, 'instagram': instagram, 'rating': rating, 'comment': comment, 'createdAt': createdAt.toIso8601String(), 'items': items.map((e) => e.toJson()).toList()};
  factory Order.fromJson(Map j) => Order(id: j['id'], code: j['code'], name: j['name'], mobile: j['mobile'], address: j['address'], note: j['note'], status: j['status'],
    payRef: j['payRef'], postalCode: j['postalCode'], hasReceipt: j['hasReceipt'], instagram: j['instagram'] ?? '', rating: j['rating'] ?? 0, comment: j['comment'] ?? '', createdAt: DateTime.parse(j['createdAt']), items: (j['items'] as List).map((e) => Item.fromJson(e)).toList()); }

class CustomerStat { final String name, mobile, address, instagram; final int count, spent; final DateTime last; final List<Item> lastItems;
  CustomerStat(this.name, this.mobile, this.address, this.instagram, this.count, this.spent, this.last, this.lastItems);
  int get daysSince => DateTime.now().difference(last).inDays; }

const statusLabels = {'pending_payment': 'منتظر واریز', 'awaiting_confirm': 'منتظر تأیید واریز', 'paid': 'پرداخت‌شده', 'shipped': 'ارسال‌شده', 'delivered': 'تکمیل‌شده', 'cancelled': 'لغو‌شده'};

class Store {
  static final Store I = Store._(); Store._();
  List<Product> products = []; List<Order> orders = []; Set<String> sent = {};
  Future<void> load() async {
    final p = await SharedPreferences.getInstance(); final s = p.getString('demo3');
    if (s == null) { seed(); await save(); return; }
    final j = jsonDecode(s); products = (j['products'] as List).map((e) => Product.fromJson(e)).toList(); orders = (j['orders'] as List).map((e) => Order.fromJson(e)).toList(); sent = ((j['sent'] ?? []) as List).cast<String>().toSet();
  }
  Future<void> save() async => (await SharedPreferences.getInstance()).setString('demo3', jsonEncode({'products': products, 'orders': orders, 'sent': sent.toList()}));
  Future<void> reset() async { seed(); await save(); }
  void seed() { sent = {};
    products = [Product(1, 'شمع لیوانی کوچک', 180000), Product(2, 'شمع لیوانی بزرگ', 420000), Product(3, 'شمع گل‌سنگی', 250000), Product(4, 'پک هدیه سه‌تایی', 690000)];
    const c = [['مریم احمدی', '09121111111', 'تهران، ونک، خ ملاصدرا، پ ۱۲', 'maryam.ahmadi'], ['سارا کریمی', '09122222222', 'اصفهان، چهارباغ بالا، کوچه ۸', 'sara.karimi'], ['نگار رضایی', '09123333333', 'شیراز، معالی‌آباد، پ ۴', 'negar_rz'],
      ['الهام موسوی', '09124444444', 'مشهد، سجاد، بلوار جامی', 'elham.mousavi'], ['زهرا نوری', '09125555555', 'کرج، گوهردشت، فاز ۲', 'zahra.noori']];
    const reviews = {10: [5, 'بوی شمع فوق‌العاده بود، بسته‌بندی هم خیلی شیک 🌸'], 11: [4, 'خوب بود، فقط ارسال یک روز دیر رسید'], 12: [2, 'یکی از شمع‌ها ترک داشت و فتیله‌اش کج بود']};
    const spec = [[0, 2, 1, 'shipped', 45], [1, 1, 2, 'shipped', 40], [2, 4, 1, 'shipped', 35], [0, 2, 1, 'shipped', 10], [3, 3, 1, 'paid', 3], [4, 1, 3, 'paid', 2],
      [3, 2, 2, 'awaiting_confirm', 1], [4, 3, 1, 'awaiting_confirm', 1], [3, 1, 1, 'pending_payment', 2], [4, 4, 1, 'pending_payment', 0], [1, 2, 1, 'delivered', 50], [2, 3, 1, 'delivered', 55], [4, 1, 2, 'delivered', 20]];
    orders = [for (var i = 0; i < spec.length; i++) () { final s = spec[i]; final cu = c[s[0] as int]; final p = products[(s[1] as int) - 1]; final st = s[3] as String;
      final rv = reviews[i];
      return Order(id: i + 1, code: 'NR${1000 + i}', name: cu[0], mobile: cu[1], address: cu[2], instagram: cu[3], rating: rv == null ? 0 : rv[0] as int, comment: rv == null ? '' : rv[1] as String, status: st, payRef: st == 'pending_payment' ? '' : '${4000 + i * 7}',
        hasReceipt: st == 'awaiting_confirm', postalCode: st == 'shipped' || st == 'delivered' ? '1234567890$i' : '', createdAt: DateTime.now().subtract(Duration(days: s[4] as int)), items: [Item(p.name, p.price, s[2] as int)]); }()];
  }
  List<CustomerStat> customers() {
    final m = <String, List<Order>>{};
    for (final o in orders.where((o) => o.status != 'cancelled')) { m.putIfAbsent(o.mobile, () => []).add(o); }
    return m.values.map((os) { os.sort((a, b) => b.createdAt.compareTo(a.createdAt)); final l = os.first;
      return CustomerStat(l.name, l.mobile, l.address, os.map((o) => o.instagram).firstWhere((x) => x.isNotEmpty, orElse: () => ''), os.length, os.fold(0, (s, o) => s + o.total), l.createdAt, l.items); }).toList()..sort((a, b) => b.count.compareTo(a.count));
  }
  List<CustomerStat> reorderDue() => customers().where((c) => c.daysSince >= 30 && c.daysSince <= 60).toList();
  Future<void> markSent(String mobile, bool v) async { v ? sent.add(mobile) : sent.remove(mobile); await save(); }
  String payReminder(Order o) => 'سلام ${o.name} عزیز 🌸 سفارش ${o.code} (${toman(o.total)}) هنوز منتظر واریزه. اگه هنوز می‌خوایش، از این لینک پرداخت و رسید رو بفرست: ${storeLink.replaceFirst('order.html?s=noora', 'order.html?s=noora&pay=${o.code}')} — $storeName';
  String reminder(CustomerStat c) => 'سلام ${c.name} عزیز 🌸 ${fa(c.daysSince)} روز از خرید ${c.lastItems.map((i) => i.name).join('، ')} گذشته. اگه شمعت رو به آخر رسوندی، با این لینک در یک دقیقه همون سفارش قبلی رو ثبت کن: $storeLink — $storeName';
  /// Simple regex heuristic: DM text -> draft order (no LLM).
  Order parseDm(String t) {
    final en = toEn(t); final items = <Item>[];
    for (final p in products) { final key = p.name.split(' ').last; if (t.contains(key)) { final m = RegExp('(\\d+)\\s*(?:تا|عدد)?[^\\d\\n]{0,20}$key').firstMatch(en); items.add(Item(p.name, p.price, m == null ? 1 : int.parse(m.group(1)!))); } }
    String grab(String re) => RegExp(re).firstMatch(t)?.group(1)?.trim() ?? '';
    return Order(id: 0, code: '', name: grab(r'(?:اسمم|اسم|نام)\s*[:：]?\s*([^\n،,]+)'), mobile: RegExp(r'09\d{9}').firstMatch(en)?.group(0) ?? '',
      address: grab(r'(?:آدرس|ادرس)\s*[:：]?\s*([^\n]+)'), status: 'pending_payment', createdAt: DateTime.now(), items: items);
  }
  void add(Order o) { o.id = orders.fold(0, (s, x) => x.id > s ? x.id : s) + 1; o.code = 'NR${2000 + o.id}'; orders.add(o); save(); }
}
String toEn(String s) => s.replaceAllMapped(RegExp('[۰-۹]'), (m) => '${'۰۱۲۳۴۵۶۷۸۹'.indexOf(m[0]!)}');
String fa(num n) { final s = n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ','); return s.replaceAllMapped(RegExp(r'\d'), (m) => '۰۱۲۳۴۵۶۷۸۹'[int.parse(m[0]!)]); }
String toman(num n) => '${fa(n)} تومان';
