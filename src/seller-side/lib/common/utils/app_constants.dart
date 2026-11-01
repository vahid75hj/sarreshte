/// Demo constants. DEMO ONLY: no server; data lives in shared_preferences.
abstract final class AppConstants {
  static const storeLink = 'https://vahid75hj.github.io/sarreshte/client/order.html?s=noora';
  static const storeName = 'شمع نورا';
  static const demoPin = '1234';
  static const shopAccount = 'noora@sarreshte.app';
  static const shopInstagram = 'noora.candle';

  /// Shipped orders older than this with no customer action get «پیگیری تحویل».
  static const deliveryFollowUpDays = 5;

  /// Paid orders older than this and not shipped yet get «ارسال عقب افتاده».
  static const shipLateDays = 2;

  /// shared_preferences keys. `demo5` keeps the JSON format of earlier builds.
  static const storageKey = 'demo5';
  static const themeModeKey = 'themeMode';

  /// Customer-side tracking / payment links built from [storeLink].
  static String trackLink(String code) => storeLink.replaceFirst('order.html?s=noora', 'track.html?c=$code');
  static String payLink(String code) => storeLink.replaceFirst('order.html?s=noora', 'order.html?s=noora&pay=$code');
}
