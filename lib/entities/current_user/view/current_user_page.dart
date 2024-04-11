import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/entities/users/bloc/users_bloc.dart';
import 'package:hms_app/repositories/users/users.dart';
import 'package:hms_app/entities/current_user/bloc/user_bloc.dart';

class CurrentUserPage extends StatefulWidget {
  const CurrentUserPage({super.key});

  @override
  State<CurrentUserPage> createState() => _CurrentUserPageState();
}

class _CurrentUserPageState extends State<CurrentUserPage> {
  int? userId;
  User? _user;

  final _userPageBloc = UserBloc(GetIt.I<InterFaceUsersRepository>());

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
//provide ID as args
//Make a request by ID

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      print('No args');
      return;
    }

    if (args is! int) {
      return;
    }

    userId = args;
    _userPageBloc.add(GetUser(id: userId!));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user?.name ?? "..."),
      ),
      body: BlocBuilder<UserBloc, UserState>(
         bloc: _userPageBloc,
        builder: (context, state) {

          if(state is UserLoaded) {
            return Text(state.user.toString());
          }

          return Placeholder();
        },
      ),
    );
  }
}
