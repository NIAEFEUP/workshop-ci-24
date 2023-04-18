import 'package:cinescope/controller/register_callback.dart';
import 'package:cinescope/firebase_options.dart';
import 'package:cinescope/model/providers/watchlist_provider.dart';
import 'package:cinescope/view/pages/main_login_page.dart';
import 'package:cinescope/view/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Widget startingWidget = MainLoginPage();
  if (FirebaseAuth.instance.currentUser != null) {
    startingWidget = const MainPage();
  }

  runApp(MyApp(
    startingWidget: startingWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startingWidget;
  const MyApp({super.key, required this.startingWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //list of providers to add
          ChangeNotifierProvider(create: (context) => WatchlistProvider()),
        ],
        child: MaterialApp(
      title: 'CineScope',
      debugShowCheckedModeBanner: false,
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
      home: startingWidget,
    ));
  }
}
