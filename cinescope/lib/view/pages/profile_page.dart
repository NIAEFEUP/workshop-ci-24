import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends GeneralPage {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends GeneralPageState<ProfilePage> {
  @override
  List<Widget> getBody(BuildContext context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
        ],
      )
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return const Text(
      "Profile Page:",
      textAlign: TextAlign.left,
      textScaleFactor: 2.2,
    );
  }
}
