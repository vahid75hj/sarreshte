import 'package:url_launcher/url_launcher.dart';

import 'launcher_interface.dart';

class LauncherDataProviderImpl implements LauncherDataProvider {
  @override
  Future<bool> openInstagram(String handle, {bool dm = true}) async {
    final h = handle.replaceAll('@', '').trim();
    if (h.isEmpty) return false;
    if (!await launchUrl(Uri.parse(dm ? 'https://ig.me/m/$h' : 'https://instagram.com/$h'), webOnlyWindowName: '_blank')) {
      await launchUrl(Uri.parse('https://instagram.com/$h'), webOnlyWindowName: '_blank');
    }
    return true;
  }

  @override
  Future<void> call(String mobile) => launchUrl(Uri.parse('tel:$mobile'));
}
