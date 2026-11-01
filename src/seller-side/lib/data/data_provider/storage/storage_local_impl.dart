import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils/app_constants.dart';
import '../../entities/demo/demo_snapshot_entity.dart';
import '../../network/custom_exception.dart';
import '../seed/demo_seed.dart';
import 'storage_interface.dart';

/// DEMO ONLY: shared_preferences under [AppConstants.storageKey] (`demo5`), same JSON as earlier builds.
class StorageLocalDataProviderImpl implements StorageDataProvider {
  final SharedPreferences _prefs;
  DemoSnapshotEntity? _cache;

  StorageLocalDataProviderImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<void> init() async {
    final s = _prefs.getString(AppConstants.storageKey);
    if (s == null) {
      await write(DemoSeed.build());
      return;
    }
    _cache = DemoSnapshotEntity.fromJson(jsonDecode(s) as Map<String, dynamic>);
  }

  @override
  DemoSnapshotEntity read() => _cache ?? (throw LocalDbException(errorMessage: 'داده‌های دمو بارگذاری نشده است.'));

  @override
  Future<void> write(DemoSnapshotEntity snapshot) async {
    _cache = snapshot;
    await _prefs.setString(AppConstants.storageKey, jsonEncode(snapshot.toJson()));
  }
}
