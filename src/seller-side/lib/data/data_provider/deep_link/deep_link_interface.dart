abstract class DeepLinkDataProvider {
  /// Order code in the launch URL (web `?order=CODE` or `#/order/CODE`), if any.
  String? initialOrderCode();

  /// Order codes from Android app links (track.html?c=CODE) while the app runs. Empty on web.
  Stream<String> orderCodes();
}
