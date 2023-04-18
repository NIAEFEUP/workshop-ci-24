import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/view/generic_film_card.dart';

class SearchPage extends GeneralPage {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends GeneralPageState<SearchPage> {
  List<Film> films = [];
  int searchTimes = 0;

  void setFilms(List<Film> results) {
    setState(() {
      films = results;
    });
  }

  @override
  List<Widget> getBody(BuildContext context) {
    if (films.isEmpty && searchTimes != 0) {
      return [
        const Text("Couldn't find any movie or tv series...",
            key: Key("errorNotFound"))
      ];
    }
    searchTimes++;
    return [
      for (var i = 0; i < films.length; i++)
        GenericFilmCard(films[i], key: Key("genericFilmCard-$i"))
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return SearchBar(
      pageState: this,
    );
  }
}
