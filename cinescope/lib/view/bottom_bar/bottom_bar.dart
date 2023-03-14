import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  final _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Container(
            color: const Color(0xFFF0EDEE),
            height: 80,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.house,
                      color: Colors.black,
                    ),
                  )),
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.black,
                    ),
                  )),
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.black,
                    ),
                  )),
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.inbox,
                      color: Colors.black,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      color: const Color(0xFFD7CCCF),
                      child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x00000000),
                              fixedSize: const Size.square(60),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          child: const FaIcon(FontAwesomeIcons.magnifyingGlass,
                              color: Colors.black))))
            ]))
        : Container();
  }
}
