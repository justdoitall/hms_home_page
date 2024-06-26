import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hms_app/generated/l10n.dart';
import 'package:hms_app/router/router.dart';
import 'package:hms_app/theme/theme.dart';

class HmsApp extends StatefulWidget {
  const HmsApp({super.key});


  @override
  State<HmsApp> createState() => _HmsAppState();
}

class _HmsAppState extends State<HmsApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ru'),
      title: "HMS_app",
      theme: theme,
      routerConfig: router,
    );
  }
}
