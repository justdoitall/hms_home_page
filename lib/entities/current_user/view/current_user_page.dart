import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/repositories/users/users.dart';


class CurrentUserPage extends StatefulWidget {
  const CurrentUserPage({super.key});

  @override
  State<CurrentUserPage> createState() => _CurrentUserPageState();
}

class _CurrentUserPageState extends State<CurrentUserPage> {
  int? userId;
  User? _user;

@override
  void initState()  {
    super.initState();
  }
  @override
void didChangeDependencies() {
//provide ID as args
//Make a request by ID


  final args = ModalRoute.of(context)?.settings.arguments;
  if(args == null) {
    print('No args');
    return;
  }

  if(args is! int) {
    return;
  }
  
  userId = args;
     _getUserByID();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(_user?.name ?? "..."),
        ),
        body: Placeholder(),
        floatingActionButton: FloatingActionButton(onPressed: _getUserByID, child: const Icon(Icons.download),),
    );
  }

   Future<void> _getUserByID() async {
    if(userId == null) {
      return;
    }else {
      _user = await GetIt.I<InterFaceUsersRepository>().getUserById(userId!);
      setState(() {
      });
    }
 }
}

 
