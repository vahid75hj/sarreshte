abstract class LauncherDataProvider {
  /// Opens the Instagram DM (or profile) of [handle]. Returns false when there is no handle.
  Future<bool> openInstagram(String handle, {bool dm = true});
  Future<void> call(String mobile);
}
