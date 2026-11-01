import '../../entities/demo/demo_snapshot_entity.dart';
import '../../entities/order/item_entity.dart';
import '../../entities/order/order_entity.dart';
import '../../entities/product/product_entity.dart';

/// Seeded demo data (shop «شمع نورا»). Dates are relative to now.
abstract final class DemoSeed {
  static DemoSnapshotEntity build() {
    const products = [ProductEntity(id: 1, name: 'شمع لیوانی کوچک', price: 180000), ProductEntity(id: 2, name: 'شمع لیوانی بزرگ', price: 420000),
      ProductEntity(id: 3, name: 'شمع گل‌سنگی', price: 250000), ProductEntity(id: 4, name: 'پک هدیه سه‌تایی', price: 690000)];
    const c = [['مریم احمدی', '09121111111', 'تهران، ونک، خ ملاصدرا، پ ۱۲', 'maryam.ahmadi'], ['سارا کریمی', '09122222222', 'اصفهان، چهارباغ بالا، کوچه ۸', 'sara.karimi'], ['نگار رضایی', '09123333333', 'شیراز، معالی‌آباد، پ ۴', 'negar_rz'],
      ['الهام موسوی', '09124444444', 'مشهد، سجاد، بلوار جامی', 'elham.mousavi'], ['زهرا نوری', '09125555555', 'کرج، گوهردشت، فاز ۲', 'zahra.noori'],
      ['رها صادقی', '09126666666', 'تبریز، ولیعصر، خ توانیر', 'raha.sadeghi'], ['مینا حیدری', '09127777777', 'رشت، گلسار، خ ۹۵', 'mina_heydari']];
    const extra = [['فاطمه جعفری', '09131000001', 'یزد، صفاییه', 'fatemeh.jfr'], ['نرگس امینی', '09131000002', 'قم، صفاشهر', 'narges.amini'], ['لیلا قاسمی', '09131000003', 'اهواز، کیانپارس', 'leila_ghasemi'],
      ['سمیرا یوسفی', '09131000004', 'کرمان، بلوار جمهوری', 'samira.ysf'], ['پریسا کاظمی', '09131000005', 'ساری، خ فرهنگ', 'parisa.kz'], ['آزاده رحیمی', '09131000006', 'همدان، بوعلی', 'azadeh.rahimi'],
      ['شیوا عباسی', '09131000007', 'قزوین، نوروزیان', 'shiva.abbasi'], ['مهسا اکبری', '09131000008', 'اراک، خ شهید بهشتی', 'mahsa.akbari']];
    const reviews = {10: [5, 'بوی شمع فوق‌العاده بود، بسته‌بندی هم خیلی شیک 🌸'], 11: [4, 'خوب بود، فقط ارسال یک روز دیر رسید'], 12: [2, 'یکی از شمع‌ها ترک داشت و فتیله‌اش کج بود']};
    const spec = [[0, 2, 1, 'delivered', 45], [1, 1, 2, 'delivered', 40], [2, 4, 1, 'delivered', 35], [0, 2, 1, 'shipped', 10], [3, 3, 1, 'paid', 3], [4, 1, 3, 'paid', 2],
      [3, 2, 2, 'awaiting_confirm', 1], [4, 3, 1, 'awaiting_confirm', 1], [3, 1, 1, 'pending_payment', 2], [4, 4, 1, 'pending_payment', 0], [1, 2, 1, 'delivered', 50], [2, 3, 1, 'delivered', 55], [4, 1, 2, 'delivered', 20], [5, 3, 1, 'shipped', 7], [6, 1, 2, 'shipped', 2], [5, 2, 1, 'delivered', 1], [6, 4, 1, 'delivered', 3], [1, 1, 1, 'cancelled_by_customer', 1]];
    const unseenIdx = {11, 12, 15, 16};
    const reviews2 = {15: [5, 'خیلی قشنگ بود، ممنون 🙏']};
    final orders = <OrderEntity>[
      for (var i = 0; i < spec.length; i++) () {
        final s = spec[i]; final cu = c[s[0] as int]; final p = products[(s[1] as int) - 1]; final st = s[3] as String;
        final rv = reviews[i] ?? reviews2[i];
        return OrderEntity(id: i + 1, code: 'NR${1000 + i}', name: cu[0], mobile: cu[1], address: cu[2], instagram: cu[3], rating: rv == null ? 0 : rv[0] as int, comment: rv == null ? '' : rv[1] as String, status: st, payRef: st == 'pending_payment' || st == 'cancelled_by_customer' ? '' : '${4000 + i * 7}',
          hasReceipt: st == 'awaiting_confirm', postalCode: st == 'shipped' || st == 'delivered' ? '1234567890$i' : '', createdAt: DateTime.now().subtract(Duration(days: s[4] as int)), seen: !unseenIdx.contains(i), items: [ItemEntity(name: p.name, price: p.price, qty: s[2] as int)]);
      }(),
    ];
    // ~50 older archived orders (completed / cancelled) to demo archive grouping + pagination.
    const cm = ['عالی بود 🌸', 'رایحه‌اش محشره', 'بسته‌بندی خیلی خوب بود', 'دیر رسید ولی خوب بود', 'سایزش از عکس کوچیک‌تر بود'];
    for (var k = 0; k < 50; k++) {
      final cu = extra[k % extra.length]; final p = products[k % 4]; final st = k % 7 == 3 ? 'cancelled' : 'delivered'; final id = orders.length + 1;
      final rt = st == 'cancelled' ? 0 : k % 5 == 0 ? 5 : k % 9 == 4 ? 3 : k % 4 == 1 ? 4 : 0;
      orders.add(OrderEntity(id: id, code: 'NR${900 - k}', name: cu[0], mobile: cu[1], address: cu[2], instagram: cu[3], status: st, payRef: st == 'cancelled' ? '' : '${3000 + k * 11}',
        postalCode: st == 'delivered' ? '98765432${10 + k}' : '', rating: rt, comment: rt == 0 ? '' : cm[k % cm.length], createdAt: DateTime.now().subtract(Duration(days: 60 + (k * 2.3).round(), hours: k % 9)),
        items: [ItemEntity(name: p.name, price: p.price, qty: 1 + k % 3)]));
    }
    return DemoSnapshotEntity(products: products, orders: orders);
  }
}
