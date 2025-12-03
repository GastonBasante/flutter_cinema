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

  static String dateDDMMYYYY(DateTime? date) {
    if (date == null) return 'No hay fecha';
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

  static String dateEEEDD(DateTime? date) {
    if (date == null) return 'No hay fecha';
    final formattedDate = DateFormat('EEEE dd').format(date);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  static String dateDDEMMMMYYYY(DateTime? date) {
    if (date == null) return 'No hay fecha';
    final formatted = DateFormat('dd MMMM yyyy').format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  static String calculateAge(DateTime birthDate) {
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    // If birthday hasn't occurred yet this year, subtract 1
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age.toString();
  }
}
