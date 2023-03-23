

import 'package:cinescope/model/film.dart';

class FilmDetailsScraper{
  static Future<Film> getFilmDetails(String url) async {
    return Film(url);
  }
}