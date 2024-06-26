import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 236, 240, 241),
            image: DecorationImage(
                image: AssetImage("assets/images/texture.png"),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter),
          ),
          child: Scaffold(backgroundColor: Colors.transparent, body: SingleChildScrollView(child: Column(
            children: [
              child,
            ],
          )))),
    );
  }
}
