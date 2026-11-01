import 'number_utils.dart';

const _months = ['فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور', 'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'];

/// Gregorian -> Jalali (year, month, day).
(int, int, int) jalali(DateTime d) {
  final gy = d.year, gm = d.month, gd = d.day;
  const g = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
  final gy2 = gm > 2 ? gy + 1 : gy;
  var days = 355666 + 365 * gy + ((gy2 + 3) ~/ 4) - ((gy2 + 99) ~/ 100) + ((gy2 + 399) ~/ 400) + gd + g[gm - 1];
  var jy = -1595 + 33 * (days ~/ 12053);
  days %= 12053;
  jy += 4 * (days ~/ 1461);
  days %= 1461;
  if (days > 365) {
    jy += (days - 1) ~/ 365;
    days = (days - 1) % 365;
  }
  final jm = days < 186 ? 1 + days ~/ 31 : 7 + (days - 186) ~/ 30;
  final jd = 1 + (days < 186 ? days % 31 : (days - 186) % 30);
  return (jy, jm, jd);
}

String monthLabel(DateTime d) {
  final (y, m, _) = jalali(d);
  return '${_months[m - 1]} ${fa(y).replaceAll(',', '')}';
}

String jDate(DateTime d) {
  final (y, m, dd) = jalali(d);
  return '${fa(dd)} ${_months[m - 1]} ${fa(y).replaceAll(',', '')}';
}

/// «۳ روز پیش» / «۲ ساعت پیش» / «همین الان».
String ago(DateTime d) {
  final n = DateTime.now().difference(d);
  return n.inDays > 0 ? '${fa(n.inDays)} روز پیش' : n.inHours > 0 ? '${fa(n.inHours)} ساعت پیش' : 'همین الان';
}
