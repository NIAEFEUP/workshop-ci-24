import 'package:cinescope/model/film.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'dart:convert';

class SearchResultsFetcher {
  static Future<List<Film>> getSearchResults(String text) async {
    final String searchUrl =
        "https://v3.sg.media-imdb.com/suggestion/x/$text.json";
    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      print("**** FOUND INFORMATION ABOUT $text ****");

      List<Film> films = [];

      String jsonData = response.body;
      final dynamic data = jsonDecode(jsonData);

      for (int i = 0; i < data["d"].length; i++) {
        var current = data["d"][i];
        String id = current["id"];
        if (!id.contains("tt")) continue;
        
        String filmUrl = "https://imdb.com/title/$id";
        String title = current["l"];
        int year = current["y"]?.toInt() ?? -1;
        String defaultFilmImgUrl =
            "https://media.comicbook.com/files/img/default-movie.png";
        String imgUrl = current["i"]?["imageUrl"] ?? defaultFilmImgUrl;
        final film = Film(filmUrl, title, year, imgUrl);
        films.add(film);
      }
      return films;
    } else {
      throw Exception('Failed to load movie data');
    }
  }
}
