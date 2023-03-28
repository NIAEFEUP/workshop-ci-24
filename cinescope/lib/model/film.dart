class Film {
  final String url, title, imgUrl, duration, description;
  int year;
  double rating;

  Film(this.url, this.title, this.year, this.imgUrl, this.duration,
      this.description, this.rating);

  @override
  String toString() {
    return 'Film{title: $title, year: $year}';
  }
}
