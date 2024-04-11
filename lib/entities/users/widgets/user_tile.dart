
import 'package:flutter/material.dart';
import 'package:hms_app/repositories/users/models/users.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.users,
    required this.id,
  });

  final List<User> users;
  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
            title: Text('User ${users[id].name}', style: theme.textTheme.bodyMedium,),
            subtitle: Text(users[id].email, style: theme.textTheme.labelSmall,),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
    Navigator.of(context).pushNamed('/user', arguments: users[id].id);
            },
          );
  }
}


