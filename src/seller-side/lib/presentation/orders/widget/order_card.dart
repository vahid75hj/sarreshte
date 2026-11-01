import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/extention/context.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/contact_utils.dart';
import '../../../common/utils/date_utils.dart';
import '../../../common/utils/number_utils.dart';
import '../../../common/widget/status_pill.dart';
import '../../../common/widget/tag_widget.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../domain/use_case/message/compose_messages.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity o;
  final VoidCallback onTap;
  const OrderCard(this.o, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    final tags = <Widget>[
      if (o.unseen && o.rating > 0) TagWidget('نظر جدید', c.negative, icon: Icons.star_rounded),
      if (o.shipLate) TagWidget('ارسال عقب افتاده – ${ago(o.createdAt)}', c.negative, icon: Icons.schedule_rounded),
      if (o.followUp) TagWidget('پیگیری تحویل – ${ago(o.createdAt)}', c.negative, icon: Icons.local_shipping_outlined),
      if (o.payReminder) TagWidget('یادآوری پرداخت – ${ago(o.createdAt)}', c.negative),
      if (o.archived && o.rating > 0 && !o.unseen) TagWidget('${fa(o.rating)}★', o.privateReview ? c.negative : c.positive),
    ];
    return Card(clipBehavior: Clip.antiAlias, child: InkWell(onTap: onTap, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Stack(clipBehavior: Clip.none, children: [CircleAvatar(radius: 18, backgroundColor: c.accentSoft, child: Text(o.name.characters.first, style: TextStyle(color: c.text, fontWeight: FontWeight.w700))),
          if (o.unseen) Positioned(top: -1, right: -1, child: Container(width: 11, height: 11, decoration: BoxDecoration(color: c.negative, shape: BoxShape.circle, border: Border.all(color: c.card, width: 2))))]),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o.name, style: TextStyle(fontSize: 16, fontWeight: o.unseen ? FontWeight.w800 : FontWeight.w700)),
          Text('${o.code} – ${ago(o.createdAt)}', style: TextStyle(color: c.textFaint, fontSize: 12)),
        ])),
        StatusPill(o.status),
      ]),
      const SizedBox(height: 12), Divider(color: c.line), const SizedBox(height: 12),
      Row(children: [
        Expanded(child: Text(o.items.map((i) => '${fa(i.qty)}× ${i.name}').join('، '), style: TextStyle(color: c.textMuted, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 12),
        Text(toman(o.total), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ]),
      if (tags.isNotEmpty || o.payReminder || o.followUp) ...[
        const SizedBox(height: 12),
        Row(children: [Expanded(child: Wrap(spacing: 6, runSpacing: 6, children: tags)),
          if (o.payReminder) TextButton.icon(icon: const Icon(Icons.send_rounded, size: 16), label: const Text('پیام در دایرکت'), onPressed: () { context.copy(GetIt.I<ComposePayReminderUseCase>()(o)); openIg(context, o.instagram); }),
          if (o.followUp) TextButton.icon(icon: const Icon(Icons.send_rounded, size: 16), label: const Text('پیام در دایرکت'), onPressed: () { context.copy(GetIt.I<ComposeDeliveryMessageUseCase>()(o)); openIg(context, o.instagram); }),
        ]),
      ],
    ]))));
  }
}
