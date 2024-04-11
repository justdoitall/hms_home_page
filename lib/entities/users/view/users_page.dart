import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/entities/users/bloc/users_bloc.dart';
import 'package:hms_app/entities/users/widgets/widgets.dart';
import 'package:hms_app/repositories/users/users.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}



class _UsersPageState extends State<UsersPage> {

  final _usersPageBloc = UsersBloc(GetIt.I<InterFaceUsersRepository>());

  @override
  void initState() {
    _usersPageBloc.add(GetUsersList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: Row(
          children: [
            
            Text('HMS App: User List', style: theme.textTheme.titleLarge,),
          ],
        ),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/svg/icon.svg', width: 25, height: 25,),
          ),

      ),
  
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
           _usersPageBloc.add(GetUsersList(completer: completer));
           return completer.future;
        },
        child: BlocBuilder<UsersBloc, UsersState>(
          bloc: _usersPageBloc,
          builder: (context, state) {
        
            if(state is UsersLoaded) {
              return ListView.separated(
                separatorBuilder: (context, index)=>const Divider(),
                itemCount:state.usersList.length,
                itemBuilder: (context, id) { 
                  return UserTile(users: state.usersList, id:id);
              });
            }
        
            if(state is UsersLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something goes wrong'),
                    Text('Try again later', style: theme.textTheme.labelSmall,),
                    TextButton(onPressed: (){
                       _usersPageBloc.add(GetUsersList());
                    }, child: const Text('Try again')),
                    OutlinedButton(onPressed: (){}, child: const Text('Try again')),
                    ElevatedButton(onPressed: (){}, child: const Text('Try again')),
                  ],
                ),
              );
            }
        
            return const Center(child: CircularProgressIndicator());
          },
        ),
      )      
    );
  }
}
