import 'package:cinescope/view/general_page.dart';
import 'package:cinescope/view/search_bar/search_bar.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends GeneralPage{
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();

}

class SearchPageState extends GeneralPageState<SearchPage>{
  @override
  List<Widget> getBody(BuildContext context) {
    return [

    ];
  }
  
  @override
  Widget getTitle(BuildContext context) {
    return const SearchBar(); 
  }
}