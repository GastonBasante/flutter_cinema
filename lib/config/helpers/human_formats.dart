import 'package:intl/intl.dart';

class HumanFormats {
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String formatRuntime(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return "${hours}h ${mins}m";
  }

  static String number(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);

    return formattedNumber;
  }

  static String dateDDMMYYYY(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

  static String dateEEEDD(DateTime date) {
    final formattedDate = DateFormat('EEEE dd').format(date);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  static String dateDDEMMMMYYYY(DateTime date) {
    final formatted = DateFormat('dd MMMM yyyy').format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }
}
