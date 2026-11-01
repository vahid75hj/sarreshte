import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

part 'theme_provider.g.dart';

/// Light / dark / system. Optional `?theme=dark|light` on web; otherwise the saved choice.
@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  SharedPreferences get _prefs => GetIt.I<SharedPreferences>();

  @override
  ThemeMode build() => ThemeMode.values.firstWhere(
      (m) => m.name == (Uri.base.queryParameters['theme'] ?? _prefs.getString(AppConstants.themeModeKey)), orElse: () => ThemeMode.system);

  void set(ThemeMode mode) {
    state = mode;
    _prefs.setString(AppConstants.themeModeKey, mode.name);
  }
}
