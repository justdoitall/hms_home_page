import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/app.dart';
import 'package:hms_app/const.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/repositories/users/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final options = BaseOptions(
    baseUrl: CONST.apiUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );
  final dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    // Do something before request is sent.
    // If you want to resolve the request with custom data,
    // you can resolve a `Response` using `handler.resolve(response)`.
    // If you want to reject the request with a error message,
    // you can reject with a `DioException` using `handler.reject(dioError)`.

    return handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    // Do something with response data.
    // If you want to reject the request with a error message,
    // you can reject a `DioException` object using `handler.reject(dioError)`.
    //on success it is getting called here
    return handler.next(response);
    }, onError: (DioException error, ErrorInterceptorHandler handler) {
    // Do something with response error.
    // If you want to resolve the request with some custom data,
    // you can resolve a `Response` object using `handler.resolve(response)`.
    if (error.response != null) {
      if (error.response!.statusCode == 401) {
        // throw Exception("Err 401");
        // return handler.next(DioException(type: DioExceptionType.unknown,message: "Неверно введен логин или пароль",requestOptions: RequestOptions(
        // )));
        return handler.next(error);
      }
    
    }

    return handler.next(error);
  }));
  GetIt.I.registerSingleton<InterfaceAuthRepository>(AuthRepository(dio: dio));
  GetIt.I
      .registerSingleton<InterFaceUsersRepository>(UsersRepository(dio: dio));
  runApp(const HmsApp());
}
