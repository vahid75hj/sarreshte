import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String t;
  final Widget? trailing;
  const SectionTitle(this.t, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(4, 20, 4, 10), child: Row(children: [
    Expanded(child: Text(t, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.of(context).textMuted))), ?trailing]));
}
