import 'package:cinescope/controller/film_details_scraper.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/model/providers/watchlist_provider.dart';
import 'package:cinescope/view/cards/page_message.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/discussions/discussion_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FilmPage extends GeneralPage {
  final String id;
  late final FilmDetailsScraper _filmDetailsScraper;
  FilmPage(this.id, {super.key, FilmDetailsScraper? filmDetailsScraper})
      : _filmDetailsScraper = filmDetailsScraper ?? FilmDetailsScraper();

  @override
  State<StatefulWidget> createState() => FilmPageState();
}

class FilmPageState extends GeneralPageState<FilmPage> {
  List<Widget> buildCast(Film film) {
    List<Widget> cast = [];

    film.cast!.forEach((actor) {
      cast.add(
        Card(
          child: Container(
            width: 160,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(actor['name']),
                          content: Text(actor['characters'].join(', ')),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        actor['characters'].join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 15),
                      Center(
                          child: ClipRect(
                              child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/default-actor-image.png'),
                        height: 180,
                        image: actor['imgUrl'].isEmpty
                            ? const AssetImage('assets/default-actor-image.png')
                            : Image.network(
                                actor['imgUrl'],
                                height: 180,
                              ).image,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      )))
                    ],
                  ),
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
  List<Widget> getBody(BuildContext context) {
    return [
      FutureBuilder(
        future: widget._filmDetailsScraper.getFilmDetails(widget.id),
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || snapshot.hasError) {
              return const PageMessage('No information available');
            } else {
              final Film film = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
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
                            ),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${film.type}  •  ${film.year}",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (film.duration!.isNotEmpty)
                            Text(
                              'Duration: ${film.duration}',
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.2,
                            ),
                          const SizedBox(height: 10),
                          if (film.rating != -1)
                            Text(
                              'Rating: ${film.rating}',
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.2,
                            ),
                          const SizedBox(height: 20),
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
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                              IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.comment),
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DiscussionListPage(widget.id, film.title))),
                                  iconSize: 30,
                                  color: Colors.black,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) =>
                                                  const Color(0xffD7CCCF)))),
                            ],
                          )
                        ],
                      )),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              'assets/default-movie-image.png'),
                          width: 150,
                          image: film.imgUrl.isEmpty
                              ? const AssetImage(
                                  'assets/default-movie-image.png')
                              : Image.network(
                                  film.imgUrl,
                                  width: 150,
                                ).image,
                        ),
                      ),
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
