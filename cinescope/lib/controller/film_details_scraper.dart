import 'package:cinescope/model/film.dart';
import 'package:cinescope/controller/IMDB_scrapper.dart';

class FilmDetailsScraper {
  static Future<Film> getFilmDetails(String url) async {
    final filmData = await ImdbScraper.getFilmData(url);
    // print tuype of filmData['title']
    print(filmData['title'].runtimeType);
    print(filmData['year'].runtimeType);
    final film = Film(url, filmData['title'], filmData['year']);
    print(film.toString());
    return film;
  }
}
