import 'package:intl/intl.dart';

String numberAbbreviation(dynamic number) {
  final String stringNumber = number.toString();
  final double doubleNumber = double.tryParse(stringNumber) ?? 0;
  final NumberFormat numberFormat = NumberFormat.compact();
  return numberFormat.format(doubleNumber);
}
