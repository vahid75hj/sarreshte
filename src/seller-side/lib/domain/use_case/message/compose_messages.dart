import '../../../common/utils/app_constants.dart';
import '../../../common/utils/number_utils.dart';
import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../../data/entities/order/order_entity.dart';

/// DM texts the seller copies to customers.
class ComposeDeliveryMessageUseCase {
  String call(OrderEntity o) => 'سلام ${o.name} عزیز 🌸 سفارش ${o.code} چند روز پیش با پست ارسال شده. به دستت رسید؟ اگه رسیده، لطفاً از این لینک «سفارش به دستم رسید» رو بزن و نظرت رو بگو: ${AppConstants.trackLink(o.code)} — ${AppConstants.storeName}';
}

class ComposePayReminderUseCase {
  String call(OrderEntity o) => 'سلام ${o.name} عزیز 🌸 سفارش ${o.code} (${toman(o.total)}) هنوز منتظر واریزه. اگه هنوز می‌خوایش، از این لینک پرداخت و رسید رو بفرست: ${AppConstants.payLink(o.code)} — ${AppConstants.storeName}';
}

class ComposeReorderReminderUseCase {
  String call(CustomerStatEntity c) => 'سلام ${c.name} عزیز 🌸 ${fa(c.daysSince)} روز از خرید ${c.lastItems.map((i) => i.name).join('، ')} گذشته. اگه شمعت رو به آخر رسوندی، با این لینک در یک دقیقه همون سفارش قبلی رو ثبت کن: ${AppConstants.storeLink} — ${AppConstants.storeName}';
}

class ComposeTrackLinkMessageUseCase {
  String call(OrderEntity o) => 'سلام ${o.name} عزیز، وضعیت سفارشت رو اینجا ببین: ${AppConstants.trackLink(o.code)}';
}
