import 'package:cinescope/controller/film_details_scraper.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';

class FilmPage extends GeneralPage {
  final String url;
  const FilmPage(this.url, {super.key});

  @override
  State<StatefulWidget> createState() => FilmPageState();
}

class FilmPageState extends GeneralPageState<FilmPage> {
  @override
  Widget getBody(BuildContext context) {
    return FutureBuilder(
        future: FilmDetailsScraper.getFilmDetails(widget.url),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Film film = snapshot.data!;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                  const Text(
                    'Film Page:',
                    textAlign: TextAlign.left,
                    textScaleFactor: 2.2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Film URL: ${film.url}',
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
