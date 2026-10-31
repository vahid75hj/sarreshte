import 'package:flutter/material.dart';

/// Design tokens adapted from Kaka (kaka_mobile/lib/theme/kaka_colors.dart), monochrome accent.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.background, required this.card, required this.line, required this.text, required this.textMuted,
      required this.textFaint, required this.accent, required this.accentText, required this.onAccent, required this.accentSoft,
      required this.positive, required this.negative});
  final Color background, card, line, text, textMuted, textFaint, accent, accentText, onAccent, accentSoft, positive, negative;

  static AppColors of(BuildContext context) => Theme.of(context).extension<AppColors>()!;

  static const dark = AppColors(background: Color(0xFF0E0E0E), card: Color(0xFF1A1A1A), line: Color(0xFF262626), text: Color(0xFFF5F5F5),
      textMuted: Color(0xFF8A8A8A), textFaint: Color(0xFF5C5C5C), accent: Color(0xFFF5F5F5), accentText: Color(0xFFF5F5F5),
      onAccent: Color(0xFF0E0E0E), accentSoft: Color(0x0DFFFFFF), positive: Color(0xFF6FBF94), negative: Color(0xFFE07A72));
  static const light = AppColors(background: Color(0xFFF7F7F5), card: Color(0xFFFFFFFF), line: Color(0xFFE7E6E1), text: Color(0xFF111111),
      textMuted: Color(0xFF6E6E6A), textFaint: Color(0xFFA3A29C), accent: Color(0xFF111111), accentText: Color(0xFF111111),
      onAccent: Color(0xFFFFFFFF), accentSoft: Color(0x0D000000), positive: Color(0xFF2F8A5E), negative: Color(0xFFC24E47));

  static AppColors resolve(Brightness b) => b == Brightness.dark ? dark : light;

  @override
  AppColors copyWith({Color? background, Color? card, Color? line, Color? text, Color? textMuted, Color? textFaint, Color? accent,
          Color? accentText, Color? onAccent, Color? accentSoft, Color? positive, Color? negative}) =>
      AppColors(background: background ?? this.background, card: card ?? this.card, line: line ?? this.line, text: text ?? this.text,
          textMuted: textMuted ?? this.textMuted, textFaint: textFaint ?? this.textFaint, accent: accent ?? this.accent,
          accentText: accentText ?? this.accentText, onAccent: onAccent ?? this.onAccent, accentSoft: accentSoft ?? this.accentSoft,
          positive: positive ?? this.positive, negative: negative ?? this.negative);

  @override
  AppColors lerp(AppColors? o, double t) {
    if (o == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(background: l(background, o.background), card: l(card, o.card), line: l(line, o.line), text: l(text, o.text),
        textMuted: l(textMuted, o.textMuted), textFaint: l(textFaint, o.textFaint), accent: l(accent, o.accent),
        accentText: l(accentText, o.accentText), onAccent: l(onAccent, o.onAccent), accentSoft: l(accentSoft, o.accentSoft),
        positive: l(positive, o.positive), negative: l(negative, o.negative));
  }
}
