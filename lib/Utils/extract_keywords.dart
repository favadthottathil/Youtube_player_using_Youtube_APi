String extractKeywords(String title) {
  List<String> words = title.toLowerCase().split(' ');

  // Remove common words and punctuation
  List<String> commonWords = [
    'the',
    'and',
    'a',
    'of',
    'in',
    'to',
    'for',
    'on',
    'with'
  ];
  words.removeWhere((word) => commonWords.contains(word));

  // Remove punctuation
  words = words.map((word) => word.replaceAll(RegExp(r'[^\w\s]'), '')).toList();

  return words.join(' ');
}
