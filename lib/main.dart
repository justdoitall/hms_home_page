import 'package:flutter/material.dart';
import 'package:hms_app/entities/users/users.dart';
import 'package:hms_app/entities/current_user/current_user.dart';
import 'package:hms_app/entities/auth/auth.dart';


void main() {
  runApp(const HmsApp());
}

class HmsApp extends StatelessWidget {
  const HmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HMS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme:const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
          labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color:  Colors.grey)
          
        )
      ),
      // home: const UsersPage(),
      routes: {
        '/':(context) => const AuthPage(),
        '/users':(context) =>const UsersPage(),
        '/user':(context) => const CurrentUserPage()
      },
      initialRoute: '/',
    );
  }
}