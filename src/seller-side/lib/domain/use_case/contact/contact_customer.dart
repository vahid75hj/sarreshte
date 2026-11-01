import '../../../data/data_provider/launcher/launcher_interface.dart';

/// Opens the customer's Instagram DM (or profile). Returns false when no Instagram id is known.
class OpenInstagramUseCase {
  final LauncherDataProvider _launcher;
  OpenInstagramUseCase({required LauncherDataProvider launcher}) : _launcher = launcher;

  Future<bool> call(String handle, {bool dm = true}) => _launcher.openInstagram(handle, dm: dm);
}

class CallCustomerUseCase {
  final LauncherDataProvider _launcher;
  CallCustomerUseCase({required LauncherDataProvider launcher}) : _launcher = launcher;

  Future<void> call(String mobile) => _launcher.call(mobile);
}
