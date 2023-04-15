class Film {
  final String url, title, imgUrl;
  final String? duration, description;
  final int year;
  final double? rating;
  final Map<String, Map<String, List<String>>>? cast;

  Film(
    this.url,
    this.title,
    this.year,
    this.imgUrl, {
    this.cast,
    this.duration,
    this.description,
    this.rating,
  });

  @override
  String toString() {
    return 'Film{title: $title, year: $year}';
  }
}
