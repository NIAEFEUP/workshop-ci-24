import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'dart:convert';

class ImdbScraper {
  static Future<Map<String, dynamic>> getFilmData(String imdbUrl) async {
    final response = await http.get(Uri.parse(imdbUrl));

    if (response.statusCode == 200) {
      final String htmlString = response.body;
      final Document document = parser.parse(htmlString);

      final Element? element = document.getElementById('__NEXT_DATA__');
      if (element == null) {
        throw Exception('Failed to find __NEXT_DATA__ element');
      }

      final String jsonData = element.text;
      final dynamic data = jsonDecode(jsonData);

      final Map<String, dynamic> base = data["props"]["pageProps"];
      final Map<String, Map<String, List<String>>> cast = {};
      final List<dynamic> castJSon = base['mainColumnData']['cast']['edges'];

      for (int i = 0; i < castJSon.length; i++) {
        final String actorName =
            castJSon[i]['node']['name']['nameText']['text'];
        final List<String> characters = [];
        final List<dynamic> charactersJSon = castJSon[i]['node']['characters'];
        for (int j = 0; j < charactersJSon.length; j++) {
          characters.add(charactersJSon[j]['name']);
        }
        String defaultImgUrl =
            'https://digimedia.web.ua.pt/wp-content/uploads/2017/05/default-user-image.png';
        String actorImgUrl = castJSon[i]['node']['name']['primaryImage']
                ?['url'] ??
            defaultImgUrl;
        Map<String, List<String>> actorValue = {};
        actorValue[actorName] = characters;
        cast[actorImgUrl] = actorValue;
      }

      final Map<String, dynamic> filmData = {
        'title': base["aboveTheFoldData"]["titleText"]["text"],
        'year': base["aboveTheFoldData"]["releaseYear"]["year"],
        'imgUrl': base["aboveTheFoldData"]["primaryImage"]["url"],
        'duration': base["aboveTheFoldData"]["runtime"]["displayableProperty"]
            ["value"]["plainText"],
        'description': base["aboveTheFoldData"]["primaryVideos"]["edges"][0]
            ["node"]["description"]["value"],
        'rating': base["aboveTheFoldData"]["ratingsSummary"]["aggregateRating"],
        'cast': cast,
        'type': base["aboveTheFoldData"]["titleType"]["text"]
      };
      return filmData;
    } else {
      throw Exception('Failed to load movie data');
    }
  }
}
