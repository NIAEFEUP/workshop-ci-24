import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/pages/comment_add_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class DiscussionCommentPage extends GeneralPage {
  final Discussion _currentDiscussion;

  DiscussionCommentPage(this._currentDiscussion, {super.key})
      : super(
            floatingActionButton: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFFD7CCCF),
                  onPressed: () {
                    navService.push(
                        MaterialPageRoute(builder: (context) => CommentAddPage(_currentDiscussion)));
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
  @override
  List<Widget> getBody(BuildContext context) {
    return [
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
      const Text("Comments:", textScaleFactor: 2,),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
      //Render out comments

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
        "Comments",
        textAlign: TextAlign.left,
        textScaleFactor: 2.2,
      ),
    ]);
  }
}
