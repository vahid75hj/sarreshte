import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Adapted from Kaka's KakaTheme.build: flat, no elevation, 1px line borders, Vazirmatn.
abstract final class AppTheme {
  static ThemeData build(Brightness brightness) {
    final c = AppColors.resolve(brightness);
    final scheme = ColorScheme.fromSeed(seedColor: c.accent, brightness: brightness, dynamicSchemeVariant: DynamicSchemeVariant.monochrome).copyWith(
        primary: c.accent, onPrimary: c.onAccent, surface: c.background, onSurface: c.text, onSurfaceVariant: c.textMuted,
        surfaceContainer: c.card, surfaceContainerLow: c.card, surfaceContainerHigh: c.card, surfaceContainerHighest: c.card,
        outline: c.line, outlineVariant: c.line, error: c.negative, secondaryContainer: c.accentSoft, onSecondaryContainer: c.text);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: c.line));
    OutlineInputBorder ib(Color col, [double w = 1]) => OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: col, width: w));
    const f = 'Vazirmatn';
    return ThemeData(
      useMaterial3: true, brightness: brightness, colorScheme: scheme, fontFamily: f, scaffoldBackgroundColor: c.background, extensions: [c],
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(backgroundColor: c.background, foregroundColor: c.text, surfaceTintColor: Colors.transparent, elevation: 0,
          scrolledUnderElevation: 0, centerTitle: false,
          titleTextStyle: TextStyle(fontFamily: f, fontSize: 20, fontWeight: FontWeight.w800, color: c.text)),
      cardTheme: CardThemeData(color: c.card, elevation: 0, margin: EdgeInsets.zero, shape: shape, surfaceTintColor: Colors.transparent),
      dividerTheme: DividerThemeData(color: c.line, space: 1, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: c.card, border: ib(c.line), enabledBorder: ib(c.line),
          focusedBorder: ib(c.accent, 1.4), errorBorder: ib(c.negative), focusedErrorBorder: ib(c.negative, 1.4),
          labelStyle: TextStyle(color: c.textMuted), hintStyle: TextStyle(color: c.textFaint),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: c.accent, foregroundColor: c.onAccent,
          minimumSize: const Size.fromHeight(52), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontFamily: f, fontSize: 16, fontWeight: FontWeight.w700))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(foregroundColor: c.text, minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: c.line), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontFamily: f, fontSize: 16, fontWeight: FontWeight.w700))),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: c.text,
          textStyle: const TextStyle(fontFamily: f, fontSize: 14, fontWeight: FontWeight.w700))),
      navigationBarTheme: NavigationBarThemeData(backgroundColor: c.card, surfaceTintColor: Colors.transparent, elevation: 0, indicatorColor: c.accentSoft,
          iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(color: s.contains(WidgetState.selected) ? c.accentText : c.textFaint)),
          labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(fontFamily: f, fontSize: 12, fontWeight: FontWeight.w600,
              color: s.contains(WidgetState.selected) ? c.accentText : c.textFaint))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: c.accent, foregroundColor: c.onAccent, elevation: 0,
          focusElevation: 0, hoverElevation: 0, highlightElevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      chipTheme: ChipThemeData(backgroundColor: c.card, selectedColor: c.accentSoft, side: BorderSide(color: c.line),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: TextStyle(fontFamily: f, color: c.text, fontWeight: FontWeight.w600)),
      segmentedButtonTheme: SegmentedButtonThemeData(style: SegmentedButton.styleFrom(selectedBackgroundColor: c.accent, selectedForegroundColor: c.onAccent,
          backgroundColor: c.card, foregroundColor: c.textMuted, side: BorderSide(color: c.line),
          textStyle: const TextStyle(fontFamily: f, fontWeight: FontWeight.w600))),
      dialogTheme: DialogThemeData(backgroundColor: c.card, surfaceTintColor: Colors.transparent, elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: c.line))),
      popupMenuTheme: PopupMenuThemeData(color: c.card, surfaceTintColor: Colors.transparent, elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: c.line))),
      snackBarTheme: SnackBarThemeData(backgroundColor: c.accent, contentTextStyle: TextStyle(fontFamily: f, color: c.onAccent),
          behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? c.onAccent : c.textFaint),
          trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? c.accent : c.card),
          trackOutlineColor: WidgetStateProperty.all(c.line)),
      listTileTheme: ListTileThemeData(iconColor: c.textMuted, textColor: c.text),
    );
  }
}
