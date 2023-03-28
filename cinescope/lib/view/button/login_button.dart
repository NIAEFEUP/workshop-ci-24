import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key, required this.pressedFunction, required this.childWidget});

  final void Function() pressedFunction;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressedFunction,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                ((states) => const Color(0xFF2C666E))),
        ),
        child: childWidget);
  }
}
