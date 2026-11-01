import 'package:flutter/material.dart';

import '../common/extention/context.dart';
import '../data/data_provider/deep_link/deep_link_interface.dart';
import '../domain/use_case/order/find_order_by_code.dart';
import '../presentation/orders/page/order_page.dart';
import 'app_router.dart';

/// Opens an order that arrived by link (web `?order=CODE`, `#/order/CODE`, or an Android app link)
/// right after the PIN login.
class PendingOrderLink {
  final FindOrderByCodeUseCase _findOrder;
  String? _pending;
  bool _loggedIn = false;

  PendingOrderLink({required DeepLinkDataProvider deepLinks, required FindOrderByCodeUseCase findOrder}) : _findOrder = findOrder {
    _pending = deepLinks.initialOrderCode();
    deepLinks.orderCodes().listen((c) {
      _pending = c;
      openPending();
    });
  }

  void onLoggedIn() {
    _loggedIn = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(const Duration(milliseconds: 350), openPending));
  }

  void openPending() {
    final code = _pending;
    final ctx = AppRouter.navigatorKey.currentContext;
    if (code == null || !_loggedIn || ctx == null) return;
    _pending = null;
    _findOrder(code).match(
      (_) => ctx.snack('سفارش $code پیدا نشد'),
      (o) => AppRouter.navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => OrderPage(o.code))),
    );
  }
}
