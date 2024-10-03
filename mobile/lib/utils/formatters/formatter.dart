import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    date = date.add(const Duration(days: 1));
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(amount);
  }

  static String formatPhoneNumber(String number) {
    if (number.length == 10) {
      return '(${number.substring(0, 3)}) (${number.substring(3, 6)}) (${number.substring(6)})';
    } else if (number.length == 11) {
      return '(${number.substring(0, 4)}) (${number.substring(4, 7)}) (${number.substring(7)})';
    }
    return number;
  }

  static String formatDateToDB(String date) {
    var parts = date.split('/');
    if (parts.length == 3) {
      var day = parts[0];
      var month = parts[1];
      var year = parts[2];

      return '$year-$month-$day';
    }
    return date;
  }
}
