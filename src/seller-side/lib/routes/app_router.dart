import 'package:flutter/material.dart';

import '../presentation/customers/page/customer_page.dart';
import '../presentation/dm_import/page/dm_page.dart';
import '../presentation/home/page/home_page.dart';
import '../presentation/orders/page/archive_page.dart';
import '../presentation/orders/page/order_page.dart';

/// Plain Navigator routing (no auto_route, so web links like `/sarreshte/seller/?order=NR1003` keep working).
/// Routes are pushed without a RouteSettings name on purpose: unnamed routes are not reported to the
/// browser, so the URL stays exactly as before.
abstract final class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> toHome(BuildContext context) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));

  static Future<void> toOrder(BuildContext context, String code) => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderPage(code)));

  static Future<void> toArchive(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const ArchivePage()));

  static Future<void> toCustomer(BuildContext context, String mobile) => Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerPage(mobile)));

  static Future<void> toDmImport(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const DmPage()));
}
