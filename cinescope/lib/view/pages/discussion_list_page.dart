import 'dart:collection';

import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/utils/duration_string_formatter.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/discussion_add_page.dart';
import 'package:cinescope/view/pages/discussion_comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import '../../model/discussion.dart';

class DiscussionListPage extends GeneralPage {
  final String filmId;
  DiscussionListPage(this.filmId, {super.key})
      : super(
            floatingActionButton: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFFD7CCCF),
                  onPressed: () {
                    navService.push(MaterialPageRoute(
                        builder: (context) => DiscussionAddPage(filmId)));
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.black,
                  ),
                )));

  @override
  State<StatefulWidget> createState() => DiscussionListPageState();
}

class DiscussionListPageState extends GeneralPageState<DiscussionListPage> {
  Widget buildDiscussionCards(
      BuildContext context, UnmodifiableSetView<Discussion> discussions) {
    List<Widget> cards = [];

    for (final discussion in discussions) {
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiscussionCommentPage(discussion)));
        },
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discussion.title,
                      textScaleFactor: 2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Text(
                      discussion.description,
                      maxLines: 4,
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xFFD7CCCF)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          size: 15,
                          color: Color(0xFFD7CCCF),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3)),
                        Text(
                          DateTime.now()
                              .difference(discussion.creationDate)
                              .toFormattedString("{} ago", "{} ago"),
                          style: const TextStyle(color: Color(0xFFD7CCCF)),
                          textScaleFactor: 0.9,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10)),
                        const FaIcon(
                          FontAwesomeIcons.comment,
                          size: 15,
                          color: Color(0xFFD7CCCF),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3)),
                        Text(
                          "${discussion.comments.length} comments",
                          style: const TextStyle(color: Color(0xFFD7CCCF)),
                          textScaleFactor: 0.9,
                        )
                      ],
                    )
                  ],
                ))),
      ));
    }

    return ListView(shrinkWrap: true, children: cards);
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      Consumer<DiscussionProvider>(
          builder: (context, provider, _) => FutureBuilder(
                future: provider.getDiscussionsByFilmId(widget.filmId),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return buildDiscussionCards(context, snapshot.data!);
                  } else if (!snapshot.hasError) {
                    return const Text("Loading...");
                  } else {
                    Logger().e("", snapshot.error);
                    return const Text(
                        "Something went wrong while loading discussions...");
                  }
                }),
              )),
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
        "Discussions",
        textAlign: TextAlign.left,
        textScaleFactor: 2.2,
      ),
    ]);
    //TODO: add divider
  }
}
