/// Persian/English digit helpers and money formatting.
String toEn(String s) => s.replaceAllMapped(RegExp('[۰-۹]'), (m) => '${'۰۱۲۳۴۵۶۷۸۹'.indexOf(m[0]!)}');

String fa(num n) {
  final s = n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return s.replaceAllMapped(RegExp(r'\d'), (m) => '۰۱۲۳۴۵۶۷۸۹'[int.parse(m[0]!)]);
}

String faDigits(String s) => s.replaceAllMapped(RegExp(r'\d'), (m) => '۰۱۲۳۴۵۶۷۸۹'[int.parse(m[0]!)]);

String toman(num n) => '${fa(n)} تومان';
