import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';

class InboxPage extends GeneralPage {
  const InboxPage({super.key});

  @override
  State<StatefulWidget> createState() => InboxPageState();
}

class InboxPageState extends GeneralPageState<InboxPage> {
  @override
  Widget getBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
            Text(
              "Inbox:",
              textAlign: TextAlign.left,
              textScaleFactor: 2.2,
            ),
          ],
        ));
  }
}
