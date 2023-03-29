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
  List<Widget> buildCast(Film film) {
    List<Widget> cast = [];

    film.cast.forEach((actorImg, characterNames) {
      String actorName = characterNames.keys.first;
      List<String> characters = characterNames[actorName]!;
      cast.add(
        Card(
          child: Container(
            width: 160,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(characters.join(", ")),
                const SizedBox(height: 15),
                Image.network(
                  actorImg,
                ),
              ],
            ),
          ),
        ),
      );
    });

    return cast;
  }

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
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 40,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Film Details",
                      textAlign: TextAlign.left,
                      textScaleFactor: 2.2,
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.all(10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            film.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // fontFamily:
                            ),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
                      )),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          film.imgUrl,
                          width: 150,
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Text(
                    film.description,
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.2,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: buildCast(film),
                  )),
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
