import 'package:flutter/material.dart';
import 'package:hms_app/router/router.dart';
import 'package:hms_app/theme/theme.dart';

class HmsApp extends StatelessWidget {
  const HmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HMS App',
      theme: theme,
      // home: const UsersPage(),
      routes: routes,
      initialRoute: '/',
    );
  }
}