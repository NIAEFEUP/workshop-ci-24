import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<StatefulWidget> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitEvent(String value) {
    print(value);
  }

  void _submitEventButton() {
    _submitEvent(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: const Color(0xFFF0EDEE),
          border: Border.all(color: const Color(0xFFF0EDEE)),
          borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          color: Colors.black,
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
        Flexible(
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
            controller: _textEditingController,
            onSubmitted: _submitEvent,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
        IconButton(
          onPressed: _submitEventButton,
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          color: Colors.black,
        )
      ]),
    );
  }
}
