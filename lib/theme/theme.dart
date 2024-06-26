import 'package:flutter/material.dart';

final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 52, 152, 219),
      background: const Color.fromARGB(255, 236, 240, 241),
    ),
    useMaterial3: true,
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    scaffoldBackgroundColor: const Color.fromARGB(255, 236, 240, 241),
    inputDecorationTheme: const InputDecorationTheme(),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 44, 62, 80)),
        labelSmall: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
    fontFamily: "Nunito",
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 236, 240, 241)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 52, 152, 219),
            ))),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side: const BorderSide(width: 1, color: Color.fromARGB(255, 52, 152, 219)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 52, 152, 219)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xffffffff),
            ))));

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({required this.hintText});

  @override
  final String hintText;
  // final String counterText = ' ';
  @override
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );
  @override
  final filled = true;
  @override
  final fillColor = Colors.white;
}
