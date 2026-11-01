import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../common/utils/link_utils.dart';
import 'deep_link_interface.dart';

class DeepLinkDataProviderImpl implements DeepLinkDataProvider {
  @override
  String? initialOrderCode() {
    final u = Uri.base;
    return u.queryParameters['order'] ?? RegExp(r'order/([A-Za-z0-9]+)').firstMatch(u.fragment)?.group(1);
  }

  @override
  Stream<String> orderCodes() {
    if (kIsWeb) return const Stream.empty();
    return AppLinks().uriLinkStream.map((u) => codeFromText(u.toString())).where((c) => c != null).cast<String>();
  }
}
