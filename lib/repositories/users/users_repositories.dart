import 'package:dio/dio.dart';
import 'package:hms_app/repositories/users/models/users.dart';
class UsersRepository {
  Future<List<User>> getUsersList() async {
    final response = await Dio().get('https://homqmfp-app.apms.io/api/user/');

    final data = response.data as Map<String, dynamic>;

    final dataList = data["data"] as List;

    return dataList.map((e) => User(name: e['last_name']??"", email: e['login']?? "")).toList();
  }
}