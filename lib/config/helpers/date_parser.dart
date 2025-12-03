class SafeParser {
  static DateTime? date(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  static String mapGender(int value) {
    switch (value) {
      case 0:
        return 'No especificado';
      case 1:
        return 'Femenino';
      case 2:
        return 'Masculino';
      case 3:
        return 'No binario';
      default:
        return 'Desconocido';
    }
  }
}
