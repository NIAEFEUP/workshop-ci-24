import 'package:cinescope/view/general_page.dart';
import 'package:flutter/widgets.dart';

class MainPage extends GeneralPage {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends GeneralPageState {
  @override
  Widget getBody(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 26, 0, 0),
        child: Column(
          children: const [
            Text(
              "Welcome!",
              textAlign: TextAlign.left,
              textScaleFactor: 2.5,
            ),
            //hardcoded page starts here, 
          ],
        ));
  }
}
