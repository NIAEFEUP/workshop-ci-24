import 'dart:collection';

import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/utils/duration_string_formatter.dart';
import 'package:cinescope/view/cards/discussion_card.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/discussions/discussion_add_page.dart';
import 'package:cinescope/view/pages/discussions/discussion_comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import '../../../model/discussion.dart';

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
      cards.add(DiscussionCard(discussion: discussion));
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
