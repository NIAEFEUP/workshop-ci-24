import 'package:cinescope/view/pages/main_login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineScope',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xFFF0EDEE),
              secondary: Color(0xFF90DDF0),
              surface: Color(0XFF2C666E),
              background: Color(0XFF07393C),
              error: Colors.redAccent,
              onBackground: Color(0xFFF0EDEE),
              onPrimary: Color(0xFFF0EDEE),
              onSecondary: Color(0xFFF0EDEE),
              onSurface: Color(0xFFF0EDEE),
              onError: Color(0xFF0A090C))),
      home: const MainLoginPage(),
    );
  }
}
