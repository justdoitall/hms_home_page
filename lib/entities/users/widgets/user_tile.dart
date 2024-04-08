
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.users,
    required this.id,
  });

  final List<Map<String, Object>> users;
  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
            title: Text('User ${users[id]["name"]}', style: theme.textTheme.bodyMedium,),
            subtitle: Text("email@email.em", style: theme.textTheme.labelSmall,),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
    Navigator.of(context).pushNamed('/user', arguments: users[id]['name']);
            },
          );
  }
}


