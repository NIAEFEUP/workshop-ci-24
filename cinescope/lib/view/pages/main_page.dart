import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/film_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends GeneralPage {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends GeneralPageState<MainPage> {
  @override
  Widget getBody(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Welcome to CineScope!",
              textAlign: TextAlign.left,
              textScaleFactor: 2,
            ),
            //hardcoded page starts here,
            const Padding(padding: EdgeInsets.all(20)),
            const Text(
              "Your last watched movies:",
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
            ),
            TextButton(
              child: const Text("Titanic"),
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FilmPage("https://www.imdb.com/title/tt0120338/")));
              })),
            TextButton(
              child: const Text("La La land"),
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FilmPage("https://www.imdb.com/title/tt3783958/")));
              }))
          ],
        ));
  }
}
