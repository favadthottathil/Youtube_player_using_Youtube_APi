String? extractFirstHashtag(String text) {
  List<String> words = text.split(' ');

  for (String word in words) {
    if (word.startsWith('#')) {
      return word.substring(1);
    }
  }

  return null;
}
