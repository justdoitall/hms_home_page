import 'package:flutter/material.dart';

class CurrentUserPage extends StatefulWidget {
  const CurrentUserPage({super.key});

  @override
  State<CurrentUserPage> createState() => _CurrentUserPageState();
}

class _CurrentUserPageState extends State<CurrentUserPage> {
  String? userName;

  @override
void didChangeDependencies() {
//provide ID as args
//Make a request by ID


  final args = ModalRoute.of(context)?.settings.arguments;
  if(args == null) {
    print('No args');
    return;
  }

  if(args is! String) {
    return;
  }

  print(args);
  
  userName = args as String;

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(userName ?? '..'),),
    );
  }
}


