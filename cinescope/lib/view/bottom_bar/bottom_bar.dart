import 'dart:async';

import 'package:cinescope/view/pages/inbox_page.dart';
import 'package:cinescope/view/pages/main_page.dart';
import 'package:cinescope/view/pages/profile_page.dart';
import 'package:cinescope/view/pages/search_page.dart';
import 'package:cinescope/view/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  bool _isVisible = true;
  late StreamSubscription<bool> keyboardVisibleSubscription;

  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibleSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _isVisible = !visible;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    keyboardVisibleSubscription.cancel();

  }



  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Container(
            color: const Color(0xFFF0EDEE),
            height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MainPage()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.house,
                      color: Colors.black,
                    ),
                    key: const Key("main"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.black,
                    ),
                    key: const Key("profile"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WatchlistPage()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.black,
                    ),
                    key: const Key("watchlists"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InboxPage()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.inbox,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFD7CCCF),
                        borderRadius: BorderRadius.circular(20)),
                    height: 55,
                    width: 55,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                        size: 23,
                      ),
                      key: const Key("search"),
                    ),
                  )
                ]))
        : Container();
  }
}
