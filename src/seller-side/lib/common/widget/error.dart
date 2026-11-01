import 'package:flutter/material.dart';

import '../../domain/failure_model.dart';
import '../theme/app_colors.dart';

/// Shown when a use case returns a [FailureModel] (e.g. unreadable local data).
class RetryFailureWidget extends StatelessWidget {
  final FailureModel error;
  final VoidCallback tryAgain;
  const RetryFailureWidget({super.key, required this.error, required this.tryAgain});

  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisSize: MainAxisSize.min, children: [
    Icon(Icons.error_outline_rounded, size: 40, color: AppColors.of(context).negative), const SizedBox(height: 10),
    Text(error.message, textAlign: TextAlign.center, style: TextStyle(color: AppColors.of(context).textMuted)), const SizedBox(height: 12),
    OutlinedButton(onPressed: tryAgain, child: const Text('تلاش دوباره'))])));
}
