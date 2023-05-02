

import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/utils/duration_string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/discussions/discussion_comment_page.dart';

class DiscussionCard extends StatelessWidget{
  final Discussion discussion;
  const DiscussionCard({super.key, required this.discussion});

  @override
  Widget build(BuildContext context) => GestureDetector(
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
      );

}