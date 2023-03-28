import 'package:cinescope/model/film.dart';
import 'package:cinescope/controller/IMDB_scrapper.dart';

class FilmDetailsScraper {
  static Future<Film> getFilmDetails(String url) async {
    final filmData = await ImdbScraper.getFilmData(url);
    String title = filmData['title'];
    int year = filmData['year'];
    print('imgURL: ${filmData['imgUrl'].runtimeType}');
    print('Duration: ${filmData['duration'].runtimeType}');
    print('description: ${filmData['description'].runtimeType}');
    print('rating: ${filmData['rating'].runtimeType}');
    String imgUrl = filmData['imgUrl'];
    String duration = filmData['duration'];
    String description = filmData['description'];
    double rating = filmData['rating'].toDouble();
    final film = Film(url, title, year, imgUrl, duration, description, rating);
    return film;
  }
}
