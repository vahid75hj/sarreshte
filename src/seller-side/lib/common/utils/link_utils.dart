import 'number_utils.dart';

/// Order code from a tracking link (track.html?c=CODE), an app link (?order=CODE / #/order/CODE) or a bare code.
String? codeFromText(String t) {
  final s = toEn(t).trim();
  final m = RegExp(r'[?&](?:c|order)=([A-Za-z0-9]+)').firstMatch(s) ??
      RegExp(r'order/([A-Za-z0-9]+)').firstMatch(s) ??
      RegExp(r'^\s*([A-Za-z]{2}\d+)\s*$').firstMatch(s);
  return m?.group(1)?.toUpperCase();
}
