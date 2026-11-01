/// Order status values (stored as strings in the demo5 JSON) and their Persian labels.
abstract final class OrderStatus {
  static const pendingPayment = 'pending_payment';
  static const awaitingConfirm = 'awaiting_confirm';
  static const paid = 'paid';
  static const shipped = 'shipped';
  static const delivered = 'delivered';
  static const cancelled = 'cancelled';
  static const cancelledByCustomer = 'cancelled_by_customer';

  static const labels = {
    pendingPayment: 'منتظر واریز',
    awaitingConfirm: 'منتظر تأیید واریز',
    paid: 'پرداخت‌شده',
    shipped: 'ارسال‌شده',
    delivered: 'تکمیل‌شده',
    cancelled: 'لغو‌شده',
    cancelledByCustomer: 'لغو توسط مشتری',
  };
}
