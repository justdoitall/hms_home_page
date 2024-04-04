import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const HmsApp());
}

class HmsApp extends StatelessWidget {
  const HmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HMS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme:const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
          labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color:  Colors.grey)
          
        )
      ),
      // home: const UsersPage(),
      routes: {
        '/':(context) => const AuthPage(),
        '/users':(context) =>const UsersPage(),
        '/user':(context) => const CurrentUserPage()
      },
      initialRoute: '/',
    );
  }
}

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

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  @override
  Widget build(BuildContext context) {
     
    return  Scaffold(
      appBar: AppBar(title: const Text("HMS APP: AUTH"),),
      body: AuthForm(),
    );
  }
}







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



 

// Create a Form widget.
class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  AuthFormState createState() {
    return AuthFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AuthFormState extends State<AuthForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final authController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: authController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Processing Data. ${authController.text}'), duration: Duration(seconds: 1),),
                  );
                  Navigator.of(context).pushNamed('/users');
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}