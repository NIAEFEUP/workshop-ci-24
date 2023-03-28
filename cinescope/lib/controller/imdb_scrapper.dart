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

      final Map<String, dynamic> filmData = {
        'title': data["props"]["pageProps"]["aboveTheFoldData"]["titleText"]
            ["text"],
        'year': data["props"]["pageProps"]["aboveTheFoldData"]["releaseYear"]
            ["year"],
      };
      return filmData;
    } else {
      throw Exception('Failed to load movie data');
    }
  }
}
