extension StringExtensions on String {
  String get firstTwoWords {
    final words = split(' ');
    if (words.length <= 2) return this;
    return '${words[0]} ${words[1]}';
  }
}