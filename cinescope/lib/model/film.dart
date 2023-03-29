class Film {
  final String url, title, imgUrl, duration, description;
  int year;
  double rating;
  Map<String, Map<String, List<String>>> cast;

  Film(this.url, this.title, this.year, this.imgUrl, this.duration,
      this.description, this.rating, this.cast);

  @override
  String toString() {
    return 'Film{title: $title, year: $year}';
  }
}
