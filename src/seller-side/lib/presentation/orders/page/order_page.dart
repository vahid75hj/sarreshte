import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/extention/context.dart';
import '../../../common/riverpod_helper.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/app_constants.dart';
import '../../../common/utils/contact_utils.dart';
import '../../../common/utils/date_utils.dart';
import '../../../common/utils/number_utils.dart';
import '../../../common/widget/error.dart';
import '../../../common/widget/section_title.dart';
import '../../../common/widget/status_pill.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../data/entities/order/order_status.dart';
import '../../../domain/repository/order/order_repository.dart';
import '../../../domain/use_case/message/compose_messages.dart';
import '../../../domain/use_case/order/find_order_by_code.dart';
import '../provider/orders_provider.dart';

/// One order: amount, customer, delivery follow-up, review, items, payment and status actions.
class OrderPage extends HookConsumerWidget {
  final String code;
  const OrderPage(this.code, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(ordersProvider);
    final found = GetIt.I<FindOrderByCodeUseCase>()(code);
    final post = useTextEditingController(text: found.map((o) => o.postalCode).getOr(''));
    // Opening a completed order marks it as seen (clears the archive badge).
    useEffect(() {
      if (found.map((o) => !o.seen).getOr(false)) {
        Future.microtask(() => ref.read(ordersProvider.notifier).updateOrder(UpdateOrderParams(code: code, seen: true)));
      }
      return null;
    }, const []);
    return found.match((f) => Scaffold(appBar: AppBar(), body: RetryFailureWidget(error: f, tryAgain: () => ref.invalidate(ordersProvider))), (o) => _body(context, ref, o, post));
  }

  Widget _body(BuildContext context, WidgetRef ref, OrderEntity o, TextEditingController post) {
    final c = AppColors.of(context);
    const pad = EdgeInsets.all(16);
    Future<void> set(String s, {String? postalCode}) async {
      await ref.read(ordersProvider.notifier).updateOrder(UpdateOrderParams(code: o.code, status: s, postalCode: postalCode));
      if (context.mounted) context.snack('وضعیت: ${OrderStatus.labels[s]}');
    }
    Future<void> complete() async {
      final ok = await showDialog<bool>(context: context, builder: (dc) => AlertDialog(title: const Text('تکمیل سفارش؟'),
        content: const Text('مطمئنی سفارش به دست مشتری رسیده؟ سفارش به «بایگانی › تکمیل‌شده» می‌رود. مشتری هنوز می‌تواند از لینک پیگیری نظر بدهد.'),
        actions: [TextButton(onPressed: () => Navigator.pop(dc, false), child: const Text('انصراف')), FilledButton(onPressed: () => Navigator.pop(dc, true), child: const Text('بله، تکمیلش کن'))]));
      if (ok == true) await set(OrderStatus.delivered);
    }
    Widget row(String k, String v, {bool bold = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [
      Expanded(child: Text(k, style: TextStyle(color: c.textMuted))), Text(v, style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w600, fontSize: bold ? 17 : 14))]));
    return Scaffold(appBar: AppBar(title: Text('سفارش ${o.code}')), body: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 32), children: [
      Card(child: Padding(padding: pad, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text('مبلغ کل', style: TextStyle(color: c.textMuted)), const Spacer(), StatusPill(o.status)]),
        const SizedBox(height: 6),
        Text(toman(o.total), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
        Text('ثبت‌شده ${ago(o.createdAt)}', style: TextStyle(color: c.textFaint, fontSize: 12)),
      ]))),
      const SectionTitle('مشتری'),
      Card(child: Padding(padding: pad, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(radius: 20, backgroundColor: c.accentSoft, child: Text(o.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2), Text(o.mobile.isEmpty ? '—' : faDigits(o.mobile), textDirection: TextDirection.ltr, style: TextStyle(color: c.textMuted)),
          const SizedBox(height: 6), Text(o.address, style: TextStyle(color: c.text, height: 1.6)),
          if (o.instagram.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: InkWell(onTap: () => openIg(context, o.instagram),
            child: Text('اینستاگرام: @${o.instagram}', textDirection: TextDirection.ltr, style: TextStyle(color: c.text, fontWeight: FontWeight.w600)))),
          if (o.note.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text('توضیح: ${o.note}', style: TextStyle(color: c.textMuted))),
        ])),
        IconButton(tooltip: 'کپی برای برچسب پست', icon: const Icon(Icons.copy_rounded, size: 20), onPressed: () => context.copy('${o.name}\n${o.mobile}\n${o.address}')),
      ]))),
      if (o.followUp) ...[
        const SizedBox(height: 12),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.negative.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: c.negative.withValues(alpha: 0.25))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('پیگیری تحویل', style: TextStyle(fontWeight: FontWeight.w800, color: c.negative)), const SizedBox(height: 4),
            Text('${ago(o.createdAt)} ارسال شده و مشتری هنوز «به دستم رسید» را نزده. معمولاً پست ${fa(AppConstants.deliveryFollowUpDays)} روزه می‌رسد.', style: TextStyle(color: c.textMuted, height: 1.7, fontSize: 13)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('پیام در دایرکت'), onPressed: () { context.copy(GetIt.I<ComposeDeliveryMessageUseCase>()(o)); openIg(context, o.instagram); })),
              const SizedBox(width: 8),
              Expanded(child: FilledButton.icon(icon: const Icon(Icons.check_rounded, size: 18), label: const Text('تکمیلش کن'), onPressed: complete)),
            ]),
          ])),
      ],
      if (o.status == OrderStatus.delivered) ...[
        const SectionTitle('نظر مشتری'),
        Card(child: Padding(padding: pad, child: o.rating == 0 ? Text('مشتری تحویل را تأیید کرده؛ هنوز نظری ثبت نکرده.', style: TextStyle(color: c.textMuted)) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [for (var i = 1; i <= 5; i++) Icon(Icons.star_rounded, size: 22, color: i <= o.rating ? const Color(0xFFE0A43A) : c.line), const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: (o.privateReview ? c.negative : c.positive).withValues(alpha: 0.10), border: Border.all(color: (o.privateReview ? c.negative : c.positive).withValues(alpha: 0.25))),
              child: Text(o.privateReview ? 'بازخورد خصوصی' : 'به اینستاگرام هدایت شد', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: o.privateReview ? c.negative : c.positive)))]),
          if (o.comment.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 10), child: Text('«${o.comment}»', style: TextStyle(color: c.text, height: 1.7))),
          if (o.privateReview) Padding(padding: const EdgeInsets.only(top: 8), child: Text('این نظر فقط برای شما فرستاده شده و جایی منتشر نشده؛ بهتر است با مشتری تماس بگیرید.', style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.6))),
          if (o.privateReview && o.instagram.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 10), child: OutlinedButton.icon(icon: const Icon(Icons.send_rounded, size: 18), label: const Text('پیام به مشتری در دایرکت'), onPressed: () => openIg(context, o.instagram))),
        ]))),
      ],
      const SectionTitle('اقلام'),
      Card(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Column(children: [
        for (final i in o.items) row('${fa(i.qty)} × ${i.name}', toman(i.price * i.qty)),
        Divider(color: c.line), row('جمع', toman(o.total), bold: true)]))),
      const SectionTitle('پرداخت'),
      Card(child: Padding(padding: pad, child: Row(children: [
        Icon(o.payRef.isEmpty ? Icons.hourglass_empty_rounded : Icons.receipt_rounded, color: c.textMuted), const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.payRef.isEmpty ? 'هنوز واریزی اعلام نشده' : 'شماره پیگیری واریز: ${o.payRef}', style: const TextStyle(fontWeight: FontWeight.w600)),
          if (o.hasReceipt) Text('عکس رسید پیوست شده (دمو)', style: TextStyle(color: c.textMuted, fontSize: 13)),
        ]))]))),
      const SizedBox(height: 20),
      if (o.status == OrderStatus.pendingPayment || o.status == OrderStatus.awaitingConfirm) FilledButton.icon(icon: const Icon(Icons.check_rounded), label: const Text('تأیید واریز'), onPressed: () => set(OrderStatus.paid)),
      if (o.status == OrderStatus.paid || o.status == OrderStatus.shipped) ...[
        TextField(controller: post, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'کد رهگیری پست', prefixIcon: Icon(Icons.local_shipping_outlined))),
        const SizedBox(height: 12),
        FilledButton(onPressed: () => set(OrderStatus.shipped, postalCode: toEn(post.text)), child: Text(o.status == OrderStatus.shipped ? 'ذخیره کد رهگیری' : 'ثبت کد و ارسال'))],
      const SizedBox(height: 10),
      OutlinedButton.icon(icon: const Icon(Icons.link_rounded), onPressed: () => context.copy(GetIt.I<ComposeTrackLinkMessageUseCase>()(o)), label: const Text('کپی لینک پیگیری برای مشتری')),
      const SectionTitle('تغییر دستی وضعیت'),
      Wrap(spacing: 8, runSpacing: 8, children: [for (final s in OrderStatus.labels.keys.where((k) => k != OrderStatus.cancelledByCustomer)) ChoiceChip(showCheckmark: false, label: Text(OrderStatus.labels[s]!), selected: o.status == s, onSelected: (_) => set(s))]),
    ]));
  }
}
