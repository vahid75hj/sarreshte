import '../../entities/demo/demo_snapshot_entity.dart';

/// Local persistence of the whole demo store (one JSON blob).
abstract class StorageDataProvider {
  /// Loads from disk once (seeding on first run); must be awaited before [read].
  Future<void> init();

  /// Current in-memory snapshot.
  DemoSnapshotEntity read();

  /// Replaces the snapshot and persists it.
  Future<void> write(DemoSnapshotEntity snapshot);
}
