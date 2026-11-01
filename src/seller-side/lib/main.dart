import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/sl_config.dart';
import 'common/theme/app_colors.dart';
import 'common/theme/app_theme.dart';
import 'common/theme/theme_provider.dart';
import 'presentation/auth/page/login_page.dart';
import 'routes/app_router.dart';
import 'routes/pending_order_link.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await slConfig(GetIt.instance);
  GetIt.I<PendingOrderLink>(); // start listening for order links
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
    title: 'سررشته – مدیریت سفارش‌ها', debugShowCheckedModeBanner: false, navigatorKey: AppRouter.navigatorKey,
    locale: const Locale('fa'), supportedLocales: const [Locale('fa')],
    localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
    theme: AppTheme.build(Brightness.light), darkTheme: AppTheme.build(Brightness.dark), themeMode: ref.watch(appThemeModeProvider),
    builder: (context, child) { final c = AppColors.of(context); final dark = Theme.of(context).brightness == Brightness.dark;
      // Always mobile layout: centered phone-width column on wide screens.
      return ColoredBox(color: dark ? const Color(0xFF070707) : const Color(0xFFECEBE7), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 430),
        child: DecoratedBox(decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: c.line))), child: ClipRect(child: child)))));
    },
    home: const LoginPage());
}
