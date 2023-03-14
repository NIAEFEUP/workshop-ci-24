import 'package:flutter/material.dart';

import 'package:cinescope/view/general_page.dart';

class WatchlistPage extends GeneralPage {
  const WatchlistPage({super.key});

  @override
  State<StatefulWidget> createState() => WatchlistPageState();
}

class WatchlistPageState extends GeneralPageState {
  @override
  Widget getBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
            Text(
              "Watchlist:",
              textAlign: TextAlign.left,
              textScaleFactor: 2.2,
            ),
          ],
        ));
  }
}
