import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/extention/context.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/theme_provider.dart';
import '../../../common/utils/app_constants.dart';
import '../../../routes/app_router.dart';
import '../../customers/page/customers_page.dart';
import '../../orders/page/orders_page.dart';
import '../../orders/provider/orders_provider.dart';
import '../../orders/widget/open_from_link_dialog.dart';
import '../../products/page/products_page.dart';
import '../../reorder/page/reorder_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  static const titles = ['سفارش‌ها', 'مشتری‌ها', 'یادآوری سفارش دوباره', 'محصولات'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = useState(0);
    const pages = [OrdersPage(), CustomersPage(), ReorderPage(), ProductsPage()];
    final themeMode = ref.watch(appThemeModeProvider);
    return Scaffold(
      appBar: AppBar(titleSpacing: 20, title: Text(titles[tab.value]), actions: [
        IconButton(tooltip: 'باز کردن از لینک', icon: const Icon(Icons.open_in_new_rounded), onPressed: () => openFromLink(context)),
        IconButton(tooltip: 'کپی لینک سفارش فروشگاه', icon: const Icon(Icons.link_rounded), onPressed: () => context.copy(AppConstants.storeLink)),
        PopupMenuButton<int>(icon: const Icon(Icons.more_vert_rounded), itemBuilder: (_) => [
          PopupMenuItem(value: 1, child: Text(
            themeMode == ThemeMode.dark || (themeMode == ThemeMode.system && Theme.of(context).brightness == Brightness.dark) ? 'تم روشن' : 'تم تیره')),
          const PopupMenuItem(value: 2, child: Text('تم: پیروی از سیستم')),
          const PopupMenuItem(value: 3, child: Text('بازگردانی داده‌های دمو')),
        ], onSelected: (v) async {
          final mode = ref.read(appThemeModeProvider.notifier);
          if (v == 1) mode.set(Theme.of(context).brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
          if (v == 2) mode.set(ThemeMode.system);
          if (v == 3) await ref.read(ordersProvider.notifier).resetDemo();
        }),
        const SizedBox(width: 8),
      ]),
      body: pages[tab.value],
      floatingActionButton: tab.value == 0 ? FloatingActionButton.extended(icon: const Icon(Icons.content_paste_rounded), label: const Text('دایرکت ← سفارش', style: TextStyle(fontWeight: FontWeight.w700)),
        onPressed: () => AppRouter.toDmImport(context)) : null,
      bottomNavigationBar: DecoratedBox(decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.of(context).line))),
        child: NavigationBar(selectedIndex: tab.value, onDestinationSelected: (i) => tab.value = i, destinations: const [
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded), label: 'سفارش‌ها'),
          NavigationDestination(icon: Icon(Icons.people_outline_rounded), selectedIcon: Icon(Icons.people_rounded), label: 'مشتری‌ها'),
          NavigationDestination(icon: Icon(Icons.notifications_none_rounded), selectedIcon: Icon(Icons.notifications_rounded), label: 'یادآوری'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2_rounded), label: 'محصولات')])));
  }
}
