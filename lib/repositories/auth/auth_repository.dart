import 'package:dio/dio.dart';
import 'package:hms_app/const.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/repositories/data_service.dart';

class AuthRepository implements InterfaceAuthRepository {
  AuthRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<Token?> getAuth(String login, String password) async {
    final DataService service = DataService();

    final response = await dio
        .post("/auth/login", data: {"email": login, "password": password});

    final data = AuthResponse.fromJson(response.data);
    await service.addItem(CONST.authToken, data.token.access);
    await service.addItem(CONST.refreshToken, data.token.refresh);
    return data.token;
  }

  @override
  Future<AuthResponse> getRegistration(RegistrationData data) async {
    final DataService service = DataService();
    final response = await dio.post("/auth/reg", data: {
      "email": data.login,
      "password": data.password,
      "referalCode": data.referealCode
    });

    final responseData = AuthResponse.fromJson(response.data);
    await service.addItem(CONST.authToken, responseData.token.access);
    await service.addItem(CONST.refreshToken, responseData.token.refresh);

    return responseData;
  }

  @override
  Future<AuthResponse> getVerification(String code) async {
    final DataService service = DataService();
    String token = await service.readItem(CONST.authToken);
      print(code);

    final response = await dio.post(
      "/auth/reg",
      data: {"code": code},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    final responseData = AuthResponse.fromJson(response.data);
    await service.addItem(CONST.authToken, responseData.token.access);
    await service.addItem(CONST.refreshToken, responseData.token.refresh);

    return responseData;
  }

  @override
  Future<AuthResponse> setPersonalData(PersonalData data) async {
    final DataService service = DataService();
    String token = await service.readItem(CONST.authToken);
    final response = await dio.post(
      "/auth/reg",
      data: {
        "first_name": data.name,
        "last_name": data.lastName,
        "weight": data.weight,
        "height": data.height,
        "nickname": data.nickName ?? ""
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    final responseData = AuthResponse.fromJson(response.data);
    await service.addItem(CONST.authToken, responseData.token.access);
    await service.addItem(CONST.refreshToken, responseData.token.refresh);

    return responseData;
  }

  @override
  Future<void> repeatCodeSend() async {
    final DataService service = DataService();
    String token = await service.readItem(CONST.authToken);

    await dio.get(
      "/auth/resendCode",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }
}
