import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends GeneralPage {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends GeneralPageState<ProfilePage> {
  @override
  Widget getBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
            Text(
              "Profile Page:",
              textAlign: TextAlign.left,
              textScaleFactor: 2.2,
            ),
          ],
        ));
  }
}
