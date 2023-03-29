import 'package:cinescope/view/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

abstract class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class GeneralPageState<T extends StatefulWidget> extends State<T> {


  Widget getBody(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Container(
            color: const Color(0XFF07393C),
              child:getBody(context))),
      const BottomBar()
    ]));
  }
}
