import 'package:flutter/material.dart';

/// Small coloured tag used on order cards.
class TagWidget extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  const TagWidget(this.text, this.color, {super.key, this.icon});

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withValues(alpha: 0.25))),
    child: Row(mainAxisSize: MainAxisSize.min, children: [if (icon != null) ...[Icon(icon, size: 13, color: color), const SizedBox(width: 4)],
      Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700))]));
}
