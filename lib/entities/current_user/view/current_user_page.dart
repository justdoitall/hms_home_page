import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/repositories/users/users.dart';
import 'package:hms_app/state/user_state/user_cubit.dart';
import 'package:hms_app/theme/theme.dart';

class CurrentUserPage extends StatefulWidget {
  const CurrentUserPage({super.key, required this.userId});

  final String userId;

  @override
  State<CurrentUserPage> createState() => _CurrentUserPageState();
}

class _CurrentUserPageState extends State<CurrentUserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) {
          return UserCubit(GetIt.I<InterFaceUsersRepository>())
            ..getUserById(widget.userId);
        },
        child: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            context.read<UserCubit>().getUserById(widget.userId);
            return completer.future;
          },
          child: BlocBuilder<UserCubit, UserCubitState>(
            builder: (context, state) {
              return state.when(initial: () {
                return const Center(child: CircularProgressIndicator());
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }, success: (user) {
                return Text(user.toString());
              }, error: (e) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Something goes wrong'),
                      Text(
                        'Try again later',
                        style: theme.textTheme.labelSmall,
                      ),
                      TextButton(
                          onPressed: () {
                            context.read<UserCubit>().getUserById(widget.userId);
                          },
                          child: const Text('Try again')),
                    ],
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
