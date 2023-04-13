import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/film_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class MainPage extends GeneralPage {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends GeneralPageState<MainPage> {
  @override
  List<Widget> getBody(BuildContext context) {
    Logger().d(FirebaseAuth.instance.currentUser!.email ?? "pog");
    return [
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
          onPressed: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FilmPage(
                        "https://www.imdb.com/title/tt0120338/")));
          }),
          child: const Text("Titanic")),
      TextButton(
          onPressed: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FilmPage(
                        "https://www.imdb.com/title/tt3783958/")));
          }),
          child: const Text("La La land"))
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return Container();
  }
}
