import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

extension ContextX on BuildContext {
  AppColors get colors => AppColors.of(this);

  void snack(String m) => ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(m)));

  void copy(String t) {
    Clipboard.setData(ClipboardData(text: t));
    snack('کپی شد');
  }
}
