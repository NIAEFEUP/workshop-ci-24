import 'package:cinescope/model/providers/watchlist_provider.dart';
import 'package:cinescope/view/generic_film_card.dart';
import 'package:flutter/material.dart';

import 'package:cinescope/view/general_page.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends GeneralPage {
  const WatchlistPage({super.key});

  @override
  State<StatefulWidget> createState() => WatchlistPageState();
}

class WatchlistPageState extends GeneralPageState<WatchlistPage> {
  @override
  List<Widget> getBody(BuildContext context) {
    return [
      Consumer<WatchlistProvider>(
        builder: (context, value, _) {
          final List<Widget> cards = [];
          if(value.getWatchlist().movies.isEmpty){
            return const Text("No films added to the watchlist yet...");
          }
          for(final film in value.getWatchlist().movies){
            cards.add(GenericFilmCard(film));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cards,
          );
        },
      )
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return const Text(
      "Watchlist:",
      textAlign: TextAlign.left,
      textScaleFactor: 2.2,
    );
  }
}
