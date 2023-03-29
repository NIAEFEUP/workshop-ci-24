import 'package:cinescope/view/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../button/login_button.dart';

class RegisterPage extends StatefulWidget {
  final String email;
  const RegisterPage({super.key, required this.email});

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerPass =
      TextEditingController();

  void Function() registerButtonHandler(BuildContext context) {
    return () {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _textEditingControllerEmail.text,
              password: _textEditingControllerPass.text)
          .then((value) => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MainPage())))
          .onError((error, stackTrace) =>
              Logger().e((error as FirebaseAuthException).code));
    };
  }

  @override
  Widget build(BuildContext context) {
    _textEditingControllerEmail.text = widget.email;
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0XFF07393C),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.asset(
                    "assets/logo-no-background.png",
                    color: Colors.white,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  const Text(
                    "Register:",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  TextField(
                    controller: _textEditingControllerEmail,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextField(
                    controller: _textEditingControllerPass,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  LoginButton(
                      pressedFunction: registerButtonHandler(context),
                      childWidget: const Text("Sign-up with email")),
                ]))));
  }
}
