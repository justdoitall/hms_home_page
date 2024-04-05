import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}



class _UsersPageState extends State<UsersPage> {

  @override
  Widget build(BuildContext context) {

final theme = Theme.of(context);

final  users =[
  {
    'id': 0,
    'name': "Roman"
  },
  {
    'id': 1,
    'name': "Denis"
  },
  {
    'id': 2,
    'name': "Sergey"
  },
  {
    'id': 3,
    'name': "Kamilla"
  }
];


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
  
      body:ListView.separated(
        separatorBuilder: (context, index)=>const Divider(),
        itemCount:users.length,
        itemBuilder: (context, id) { 

          return ListTile(
        title: Text('User ${users[id]["name"]}', style: theme.textTheme.bodyMedium,),
        subtitle: Text("email@email.em", style: theme.textTheme.labelSmall,),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: (){
          Navigator.of(context).pushNamed('/user', arguments: users[id]['name']);
        },
      );
      }),
      
    );
  }
}


