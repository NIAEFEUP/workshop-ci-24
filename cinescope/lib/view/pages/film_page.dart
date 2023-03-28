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
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null || snapshot.hasError) {
            return const Text('Error: Failed to load film data');
          } else {
            final Film film = snapshot.data!;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 40,
                    ),
                    const Text(
                      "Film Details",
                      textAlign: TextAlign.left,
                      textScaleFactor: 2.2,
                    ),
                  ]),
                  Row(
                    children: [
                      Image.network(
                        film.imgUrl,
                        width: 200,
                        height: 300,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            film.title,
                            textAlign: TextAlign.left,
                            textScaleFactor: 2.2,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Release Year: ${film.year}',
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.2,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Duration: ${film.duration}',
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.2,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Rating: ${film.rating}',
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    film.description,
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.2,
                  )
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}


/*
const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                  Text(
                    film.title,
                    textAlign: TextAlign.left,
                    textScaleFactor: 2.2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Release Year: ${film.year}',
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.2,
                  ),
 */