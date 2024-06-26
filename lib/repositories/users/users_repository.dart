import 'package:dio/dio.dart';
import 'package:hms_app/const.dart';
import 'package:hms_app/repositories/data_service.dart';
import 'package:hms_app/repositories/users/users.dart';

class UsersRepository implements InterFaceUsersRepository {
  UsersRepository({required this.dio});
  final DataService service =   DataService();

  final Dio dio;

  @override
  Future<List<User>> getUsersList() async {

    String token = await service.readItem(CONST.authToken);

    final response = await Dio().get(
      '${CONST.apiUrl}/user/',
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    final data = response.data as Map<String, dynamic>;

    final dataList = data["data"] as List;

    return dataList
        .map((e) => User(
            id: e['id'].toString(), name: e['last_name'] ?? "", email: e['login'] ?? ""))
        .toList();
  }

  @override
  Future<User> getUserById(String id) async {
    final response =
        await Dio().get('https://homqmfp-app.apms.io/api/user/$id');

    final data = response.data as Map<String, dynamic>;

    return User(
        id: id,
        name: data['user']['first_name'] ?? '...',
        email: data['user']['login'] ?? "...");
  }

  @override
  Future<Profile> getProfile(String token) async {
    final response = await Dio().post(
      "https://homqmfp-app.apms.io/api/get_Personal_data/",
      data: {},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    final data = response.data;
    return Profile(
        weight: data['weight'] ?? 0,
        height: data['height'] ?? 0,
        age: data['age'] ?? 0,
        gender: "m",
        bodymassIndex: data['bodymasindex'] ?? 0,
        dailyCalorieInTake: data['dailycalorietntake'] ?? 0,
        glycatedhemoglobin: data['glycatedhemoglobin'] ?? 0,
        firstName: data["firstname"],
        lastName: data["lastname"],
        login: data["login"],
        phonenumber: "phonenumber",
        calorien: data['calorien'] ?? 0,
        priemPichi: []);
  }
}
