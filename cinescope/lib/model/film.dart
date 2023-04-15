class Film {
  final String id, title, type, imgUrl;
  final String? duration, description;
  final int year;
  final double? rating;
  final Map<String, Map<String, List<String>>>? cast;

  Film(
    this.id,
    this.title,
    this.type,
    this.year,
    this.imgUrl, {
    this.cast,
    this.duration,
    this.description,
    this.rating,
  });

  @override
  String toString() {
    return 'Film{title: $title, type: $type, year: $year, id: $id)}';
  }
}
