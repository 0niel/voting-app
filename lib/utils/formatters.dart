class StringFormatter {
  static String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return "не указана";

    final dateTime =
        DateTime.parse(dateTimeString).add(const Duration(hours: 3));

    return "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  static String cyryllicToLat(String text) {
    final Map<String, String> cyrillicToLatin = {
      "а": "a",
      "б": "b",
      "в": "v",
      "г": "g",
      "д": "d",
      "е": "e",
      "ё": "yo",
      "ж": "zh",
      "з": "z",
      "и": "i",
      "й": "j",
      "к": "k",
      "л": "l",
      "м": "m",
      "н": "n",
      "о": "o",
      "п": "p",
      "р": "r",
      "с": "s",
      "т": "t",
      "у": "u",
      "ф": "f",
      "х": "h",
      "ц": "c",
      "ч": "ch",
      "ш": "sh",
      "щ": "sh'",
      "ъ": "",
      "ы": "y",
      "ь": "",
      "э": "e",
      "ю": "yu",
      "я": "ya",
      " ": " ",
    };

    final List<String> letters = text.toLowerCase().split('');
    final List<String> latinLetters = [];

    for (var letter in letters) {
      if (cyrillicToLatin.containsKey(letter)) {
        latinLetters.add(cyrillicToLatin[letter]!);
      }
    }

    return latinLetters.join();
  }
}
