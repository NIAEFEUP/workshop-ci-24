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
  Future<List<Film>> films = Future.value([]);

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      FutureBuilder(
        future: films,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Film> films = snapshot.data as List<Film>;
            return ListView.builder(
              itemCount: films.length,
              itemBuilder: (context, index) {
                return FilmCard(films[index]);
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return SearchBar(
      pageState: this,
    );
  }
}
