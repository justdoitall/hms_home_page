import 'package:dio/dio.dart';
import 'package:hms_app/repositories/users/users.dart';

class UsersRepository implements InterFaceUsersRepository {
  UsersRepository(
    {
      required this.dio
    }
    );

  final Dio dio;

  @override
  Future<List<User>> getUsersList() async {
    final response = await Dio().get('https://homqmfp-app.apms.io/api/user/');

    final data = response.data as Map<String, dynamic>;

    final dataList = data["data"] as List;

    return dataList.map((e) => User(id: e['id'],name: e['last_name']??"", email: e['login']?? "")).toList();
  }

  @override
  Future<User> getUserById(int id) async {
    final response = await Dio().get('https://homqmfp-app.apms.io/api/user/$id');

    final data = response.data as Map<String, dynamic>;

    return User(id: id, name: data['user']['first_name'] ?? '...', email: data['user']['login'] ?? "...");
  }
}