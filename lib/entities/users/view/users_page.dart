import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/entities/users/widgets/widgets.dart';
import 'package:hms_app/repositories/users/users.dart';
import 'package:hms_app/state/users_state/users_cubit.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({
    super.key,
  });

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
        create: (context) {
          return UsersCubit(GetIt.I<InterFaceUsersRepository>())
            ..getUsersList();
        },
        child: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            context.read<UsersCubit>().getUsersList();
            return completer.future;
          },
          child: BlocBuilder<UsersCubit, UsersCubitState>(
            builder: (context, state) {
              return state.when(
                initial: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: ((errorMessage) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Something goes wrong'),
                          Text(
                            'Try again later',
                            style: theme.textTheme.labelSmall,
                          ),
                          Text(errorMessage),
                          ElevatedButton(
                              child: const Text("try again"),
                              onPressed: () =>
                                  context.read<UsersCubit>().getUsersList()),
                        ],
                      ),
                    )),
                success: (users) {
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return UserTile(users: users, id: index);
                    },
                  );
                },
              );
            },
          ),
        ));
  }
}
