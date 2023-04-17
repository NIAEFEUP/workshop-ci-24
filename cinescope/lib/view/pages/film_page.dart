import 'package:cinescope/controller/film_details_scraper.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilmPage extends GeneralPage {
  String url = "";
  FilmPage(String filmId, {super.key}) {
    url = "https://www.imdb.com/title/$filmId/";
  }

  @override
  State<StatefulWidget> createState() => FilmPageState();
}

class FilmPageState extends GeneralPageState<FilmPage> {
  List<Widget> buildCast(Film film) {
    List<Widget> cast = [];

    film.cast!.forEach((actorImg, characterNames) {
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
                Text(
                  characters.join(", "),
                ),
                const SizedBox(height: 15),
                ClipRect(
                  child: SizedBox(
                    height: 180, // Set the maximum height here
                    child: Center(
                        child: Image.network(
                      actorImg,
                      fit: BoxFit
                          .cover, // Scale and crop the image to fit the container
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

    return cast;
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      FutureBuilder(
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
                    const Padding(padding: EdgeInsets.all(10)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              film.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                // fontFamily:
                              ),
                              textAlign: TextAlign.left,
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              film.type,
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                            const SizedBox(height: 10),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.heart),
                                  onPressed: () {},
                                  iconSize: 30,
                                  color: Colors.black,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) =>
                                                  const Color(0xffD7CCCF))),
                                ),
                                /*
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                                IconButton(
                                    icon:
                                        const FaIcon(FontAwesomeIcons.comment),
                                    onPressed: () {},
                                    iconSize: 30,
                                    color: Colors.black,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    const Color(0xffD7CCCF)))),
                              */
                              ],
                            )
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
                      film.description!,
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.2,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Cast',
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.8,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 280),
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
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
      )
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return Row(children: [
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
    ]);
  }
}
