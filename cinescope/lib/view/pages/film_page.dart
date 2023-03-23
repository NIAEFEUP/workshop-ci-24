import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';

class FilmPage extends GeneralPage {
  final String url;
  const FilmPage(this.url, {super.key});

  @override
  State<StatefulWidget> createState() => FilmPageState();
}

class FilmPageState extends GeneralPageState<FilmPage> {
  @override
  Widget getBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
          const Text(
            'Film Page:',
            textAlign: TextAlign.left,
            textScaleFactor: 2.2,
          ),
          const SizedBox(height: 10),
          Text(
            'Film URL: ${widget.url}',
            textAlign: TextAlign.left,
            textScaleFactor: 1.2,
          ),
        ],
      ),
    );
  }
}