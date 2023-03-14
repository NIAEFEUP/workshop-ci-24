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
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              "Welcome to CineScope!",
              textAlign: TextAlign.left,
              textScaleFactor: 2,
            ),
            //hardcoded page starts here, 
            Padding(padding: EdgeInsets.all(20)),
            Text("Your last watched movies:", textAlign: TextAlign.left, textScaleFactor: 1.5,)
          ],
        ));
  }
}
