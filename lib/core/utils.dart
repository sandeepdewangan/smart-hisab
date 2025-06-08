import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final day = DateFormat('EEEE').format(date);
  final convertedDate = DateFormat('dd-MMM-yyyy').format(date);
  return '$day, $convertedDate';
}

String capitalizeString(String text) {
  final articles = {'a', 'an', 'the'};
  final words = text.split(' ');
  final capitalizedWords = <String>[];

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    // Remove punctuation for comparison (like '.', ',', etc.)
    String strippedWord = word.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();

    // Check if it's the first word or not an article
    if (i == 0 || !articles.contains(strippedWord)) {
      // Capitalize the word properly, preserving punctuation
      word = word[0].toUpperCase() + word.substring(1);
    }

    capitalizedWords.add(word);
  }

  return capitalizedWords.join(' ');
}
