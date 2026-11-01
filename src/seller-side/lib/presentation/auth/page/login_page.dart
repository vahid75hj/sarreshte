import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/utils/app_constants.dart';
import '../../../routes/app_router.dart';
import '../../../routes/pending_order_link.dart';
import '../provider/login_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = AppColors.of(context);
    final pin = useTextEditingController();
    final err = ref.watch(loginProvider);
    void go() {
      if (ref.read(loginProvider.notifier).submit(pin.text)) {
        AppRouter.toHome(context);
        GetIt.I<PendingOrderLink>().onLoggedIn();
      }
    }
    return Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 380), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [Container(width: 52, height: 52, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: c.line)),
        child: Image.asset('assets/icon/main.png', fit: BoxFit.cover)), const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('سررشته', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: c.text)),
          Text('مدیریت سفارش فروشنده‌های اینستاگرامی', style: TextStyle(fontSize: 13, color: c.textMuted))])]),
      const SizedBox(height: 36),
      Text('ورود به حساب فروشگاه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.text)),
      const SizedBox(height: 16),
      TextField(readOnly: true, enabled: false, controller: TextEditingController(text: AppConstants.shopAccount), textDirection: TextDirection.ltr,
        style: TextStyle(color: c.textMuted), decoration: InputDecoration(labelText: 'حساب فروشگاه', helperText: 'فروشگاه: ${AppConstants.storeName} (حساب نمونه‌ی دمو)',
          prefixIcon: const Icon(Icons.storefront_outlined), suffixIcon: const Icon(Icons.lock_outline_rounded, size: 18), filled: true, fillColor: c.accentSoft)),
      const SizedBox(height: 16),
      TextField(controller: pin, obscureText: true, keyboardType: TextInputType.number, textAlign: TextAlign.center, onSubmitted: (_) => go(),
        style: const TextStyle(fontSize: 22, letterSpacing: 8, fontWeight: FontWeight.w700),
        decoration: InputDecoration(labelText: 'رمز ورود', errorText: err.isEmpty ? null : err)),
      const SizedBox(height: 16),
      FilledButton(onPressed: go, child: const Text('ورود')),
      const SizedBox(height: 20),
      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.accentSoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: c.line)),
        child: Row(children: [Icon(Icons.info_outline_rounded, size: 18, color: c.textMuted), const SizedBox(width: 8),
          Expanded(child: Text('نسخه‌ی نمایشی — رمز: ۱۲۳۴', style: TextStyle(color: c.textMuted, fontSize: 13)))])),
    ]))))));
  }
}
