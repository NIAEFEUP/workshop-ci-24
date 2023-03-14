


import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/search_bar/search_bar.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends GeneralPage{
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();

}

class SearchPageState extends GeneralPageState{
  @override
  Widget getBody(BuildContext context) {
    return Column(children: const [
      Padding(padding: EdgeInsets.fromLTRB(0, 36, 0, 0)),
      SearchBar()
    ],);
  }
}