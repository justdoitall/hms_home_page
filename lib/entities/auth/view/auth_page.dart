import 'package:flutter/material.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  @override
  Widget build(BuildContext context) {
     
    return  Scaffold(
      appBar: AppBar(title: const Text("HMS APP: AUTH"),),
      body: const AuthForm(),
    );
  }
}
