import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/utils/number_utils.dart';

/// «بایگانی» row on the orders tab with the unseen-completions badge.
class ArchiveEntryCard extends StatelessWidget {
  final int archived, unseen;
  final VoidCallback onTap;
  const ArchiveEntryCard({super.key, required this.archived, required this.unseen, required this.onTap});

  @override
  Widget build(BuildContext context) { final c = AppColors.of(context);
    return Card(clipBehavior: Clip.antiAlias, child: InkWell(onTap: onTap,
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(children: [
        Icon(Icons.inventory_2_outlined, color: c.textMuted), const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('بایگانی', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          Text('سفارش‌های تکمیل‌شده و لغوشده – ${fa(archived)}', style: TextStyle(color: c.textMuted, fontSize: 12))])),
        if (unseen > 0) Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3), decoration: BoxDecoration(color: c.negative, borderRadius: BorderRadius.circular(20)),
          child: Text('${fa(unseen)} جدید', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800))),
        const SizedBox(width: 4), Icon(Icons.chevron_left_rounded, color: c.textFaint)]))));
  }
}
