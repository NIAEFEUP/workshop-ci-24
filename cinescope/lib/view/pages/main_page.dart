import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends GeneralPage {
  const MainPage({super.key});
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends GeneralPageState<MainPage> {
  @override
  List<Widget> getBody(BuildContext context) {
    return [
      const Text(
        "Welcome to CineScope!",
        textAlign: TextAlign.left,
        textScaleFactor: 2,
      ),
      //hardcoded page starts here,
      const Padding(
        padding: EdgeInsets.all(20),
      ),
      const Text(
        "Your last watched movies:",
        textAlign: TextAlign.left,
        textScaleFactor: 1.5,
      ),
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return Container();
  }
}
