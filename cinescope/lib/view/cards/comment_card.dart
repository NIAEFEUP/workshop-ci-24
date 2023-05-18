import 'package:cinescope/model/discussion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cinescope/utils/duration_string_formatter.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = FittedBox(
        fit: BoxFit.scaleDown,
        child: comment.createdBy!.imageData != null
            ? CircleAvatar(
                radius: 20,
                backgroundImage: MemoryImage(
                  comment.createdBy!.imageData!,
                ))
            : const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  "assets/profile-placeholder.png",
                )));

    return Card(
        key: const Key("comment-card"),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  avatar,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal:7),
                  ),
                  Text(
                    comment.createdBy!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(7),
              ),
              Text(
                comment.content,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 15,
                    color: Color(0xFFD7CCCF),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                  Text(
                    DateTime.now()
                        .difference(comment.creationTime)
                        .toFormattedString("{} ago", "{} ago"),
                    style: const TextStyle(color: Color(0xFFD7CCCF)),
                    textScaleFactor: 0.9,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
