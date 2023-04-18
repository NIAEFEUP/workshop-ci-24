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

  void setFilms(List<Film> results) {
    setState(() {
      films = results;
    });
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [for (Film film in films) GenericFilmCard(film)];
  }

  @override
  Widget getTitle(BuildContext context) {
    return SearchBar(
      pageState: this,
    );
  }
}
