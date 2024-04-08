import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hms_app/entities/users/widgets/widgets.dart';
import 'package:hms_app/repositories/users/models/users.dart';
import 'package:hms_app/repositories/users/users_repositories.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}



class _UsersPageState extends State<UsersPage> {

  List<User>? _usersList;

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
        // leading:  BackButton(onPressed:_goBack)
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/svg/icon.svg', width: 25, height: 25,),
          ),

      ),
  
      body:(_usersList == null)
      ? const SizedBox() 
      : ListView.separated(
        separatorBuilder: (context, index)=>const Divider(),
        itemCount:_usersList?.length ?? 0,
        itemBuilder: (context, id) { 
          return UserTile(users: _usersList??[], id:id);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        _usersList = await UsersRepository().getUsersList();
        setState(() {
        });
      },
      child: const Icon(Icons.download),
      ) ,
    );
  }
}
