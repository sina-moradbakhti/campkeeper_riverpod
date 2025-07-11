import 'package:intl/intl.dart';

class PriceFormatter {
  static final NumberFormat _euroFormatter = NumberFormat.currency(
    locale: 'de_DE',
    symbol: '€',
    decimalDigits: 0,
  );

  static String formatEuro(double price) {
    return _euroFormatter.format(price);
  }

  static String formatEuroWithoutSymbol(double price,
      {String format = '#,##0'}) {
    final NumberFormat formatter = NumberFormat(format, 'de_DE');
    return formatter.format(price);
  }
}
