import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/search_bar/search_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/view/generic_film_card.dart';

class SearchPage extends GeneralPage{
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();

}

class SearchPageState extends GeneralPageState<SearchPage>{

  List<Film> films = [];

  void updateFilms(List<Film> newFilms) {
    setState(() {
      films = newFilms;
    });
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          return FilmCard(films[index]);
        },
      )
    ];
  }
  
  @override
  Widget getTitle(BuildContext context) {
    return SearchBar(pageState: this,); 
  }
}