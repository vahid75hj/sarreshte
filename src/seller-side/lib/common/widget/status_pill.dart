import 'package:flutter/material.dart';

import '../../data/entities/order/order_status.dart';
import '../theme/app_colors.dart';

/// Status pill: positive for done, muted for pending, negative for cancelled.
class StatusPill extends StatelessWidget {
  final String status;
  const StatusPill(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final col = switch (status) {
      OrderStatus.shipped || OrderStatus.paid || OrderStatus.delivered => c.positive,
      OrderStatus.cancelled || OrderStatus.cancelledByCustomer => c.negative,
      OrderStatus.awaitingConfirm => c.text,
      _ => c.textMuted,
    };
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: col.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20), border: Border.all(color: col.withValues(alpha: 0.25))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: col, shape: BoxShape.circle)), const SizedBox(width: 6),
        Text(OrderStatus.labels[status]!, style: TextStyle(color: col, fontSize: 12, fontWeight: FontWeight.w700))]));
  }
}
