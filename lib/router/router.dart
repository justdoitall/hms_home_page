import 'package:hms_app/entities/users/users.dart';
import 'package:hms_app/entities/current_user/current_user.dart';
import 'package:hms_app/entities/auth/auth.dart';

final routes = {
        '/':(context) => const AuthPage(),
        '/users':(context) =>const UsersPage(),
        '/user':(context) => const CurrentUserPage()
      };