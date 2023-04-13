import 'package:flutter/material.dart';

import 'package:cinescope/view/general_page.dart';

class WatchlistPage extends GeneralPage {
  const WatchlistPage({super.key});

  @override
  State<StatefulWidget> createState() => WatchlistPageState();
}

class WatchlistPageState extends GeneralPageState<WatchlistPage> {
  @override
  List<Widget> getBody(BuildContext context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
          Text(
            "Watchlist:",
            textAlign: TextAlign.left,
            textScaleFactor: 2.2,
          ),
        ],
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
