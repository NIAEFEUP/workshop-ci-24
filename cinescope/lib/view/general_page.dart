import 'package:cinescope/view/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

abstract class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class GeneralPageState<T extends StatefulWidget> extends State<T> {
  Widget getTitle(BuildContext context);

  List<Widget> getBody(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0XFF07393C),
            child: Column(children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              getTitle(context),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ListView(children: getBody(context)))),
              const BottomBar()
            ])));
  }
}
