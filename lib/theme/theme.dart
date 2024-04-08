import 'package:flutter/material.dart';

final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme:const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
          labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color:  Colors.grey)
          
        )
      );