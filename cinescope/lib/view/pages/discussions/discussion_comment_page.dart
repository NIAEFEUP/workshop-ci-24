import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/model/providers/profile_provider.dart';
import 'package:cinescope/utils/duration_string_formatter.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/discussions/comment_add_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

class DiscussionCommentPage extends GeneralPage {
  final Discussion _currentDiscussion;

  DiscussionCommentPage(this._currentDiscussion, {super.key})
      : super(
            floatingActionButton: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFFD7CCCF),
                  onPressed: () {
                    navService.push(MaterialPageRoute(
                        builder: (context) =>
                            CommentAddPage(_currentDiscussion)));
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.black,
                  ),
                )));

  @override
  State<StatefulWidget> createState() => DiscussionCommentPageState();
}

class DiscussionCommentPageState
    extends GeneralPageState<DiscussionCommentPage> {
  Future<List<Comment>> getProfilesOfComments(
      List<Comment> commentsToLoad, ProfileProvider provider) async {
    for (final comment in commentsToLoad) {
      comment.createdBy =
          await provider.getProfileByUid(uid: comment.createdById);
    }
    return commentsToLoad;
  }

  Widget renderCommentCard(List<Comment> comments) {
    List<Widget> cards = [];
    for (final comment in comments) {
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

      cards.add(Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      avatar,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.createdBy!.name,
                            textScaleFactor: 1.5,
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          Text(
                            DateTime.now()
                                .difference(comment.creationTime)
                                .toFormattedString("{} ago", "{} ago"),
                            textScaleFactor: 1,
                            style: const TextStyle(color: Color(0xFFD7CCCF)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    comment.content,
                    maxLines: null,
                    style: const TextStyle(color: Color(0xFFD7CCCF)),
                  )
                ],
              ))));
    }

    return Column(
      children: cards,
    );
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [Consumer<DiscussionProvider>(builder: (context, value, _) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
      Text(
        widget._currentDiscussion.title,
        maxLines: null,
        textScaleFactor: 2,
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
      Text(
        widget._currentDiscussion.description,
        maxLines: null,
        style: const TextStyle(color: Color(0xFFD7CCCF)),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
      const Divider(),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
      const Text(
        "Comments:",
        textScaleFactor: 2,
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
      //Render out comments
      Consumer<ProfileProvider>(
        builder: (context, value, child) {
          return FutureBuilder(
              future: getProfilesOfComments(
                  widget._currentDiscussion.comments, value),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return renderCommentCard(snapshot.data!);
                }
                if (snapshot.hasError) {
                  return const Text(
                      "Something went wrong while getting the comments...");
                }
                return const Text("Loading comments...");
              }));
        },
      )
    ]))];
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
        "Comments",
        textAlign: TextAlign.left,
        textScaleFactor: 2.2,
      ),
    ]);
  }
}
