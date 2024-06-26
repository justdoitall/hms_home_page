import 'package:hms_app/repositories/users/users.dart';

abstract class InterFaceUsersRepository {
  Future<List<User>> getUsersList();
  Future<User> getUserById(String id);
  Future<Profile> getProfile(String token);

}