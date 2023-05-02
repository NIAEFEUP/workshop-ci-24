import 'package:cinescope/view/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

abstract class GeneralPage extends StatefulWidget {
  final Widget? floatingActionButton;
  const GeneralPage({super.key, this.floatingActionButton});

  @override
  State<StatefulWidget> createState();
}

abstract class GeneralPageState<T extends GeneralPage> extends State<T> {
  Widget getTitle(BuildContext context);

  List<Widget> getBody(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0XFF07393C),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
              getTitle(context),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView(
                          key: const Key("body-list"),
                          shrinkWrap: true,
                          children: getBody(context))),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: widget.floatingActionButton ?? Container(),
                  )
                ],
              )),
              const BottomBar()
            ])));
  }
}
