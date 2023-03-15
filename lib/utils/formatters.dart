class StringFormatter {
  static String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return "не указана";

    final dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
