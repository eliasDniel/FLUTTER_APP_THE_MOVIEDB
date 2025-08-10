import 'package:intl/intl.dart';

class HumanFormats {
  static String formatNumber(double number, [int decimals = 0]) {
    final numberFormat = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en_US',
    ).format(number);

    return numberFormat;
  }
}
