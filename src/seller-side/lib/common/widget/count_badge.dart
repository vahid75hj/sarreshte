import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/number_utils.dart';

/// Red count bubble used on filter chips.
class CountBadge extends StatelessWidget {
  final int count;
  const CountBadge(this.count, {super.key});

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    decoration: BoxDecoration(color: AppColors.of(context).negative, borderRadius: BorderRadius.circular(10)),
    child: Text(fa(count), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)));
}
