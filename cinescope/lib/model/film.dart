class Film {
  final String url, title;
  int year;

  Film(this.url, this.title, this.year);

  @override
  String toString() {
    return 'Film{url: $url, title: $title, year: $year}';
  }
}
