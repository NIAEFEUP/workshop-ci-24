import 'package:cinescope/view/button/login_button.dart';
import 'package:flutter/material.dart';

class MainLoginPage extends StatelessWidget {
  const MainLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0XFF07393C),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Image.asset(
                  "assets/logo-no-background.png",
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                const Text(
                  "Welcome!",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                LoginButton(pressedFunction: (){}, childWidget: const Text("Sign-in with email")),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                const Text("or", textAlign: TextAlign.center,),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                LoginButton(pressedFunction: (){}, childWidget: const Text("Sign-in with Google")),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                LoginButton(pressedFunction: (){}, childWidget: const Text("Sign-in with GitHub")),


              ],
            )));
  }
}
