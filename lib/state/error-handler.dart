import 'package:dio/dio.dart';

// enum Handlers {DEFAULT, VERIFICATION}

String errorHandler(Object e) {
  print(e);

  if (e is DioException && e.response != null) {

    if (e.response!.statusCode == 409) {
      return "Такой пользователь уже существует";
    }
    if (e.response!.statusCode == 401) {
      return "Неверный логин или пароль";
    }
    if (e.response!.statusCode == 403) {
      return "Ошибка обработки данных";
    }
    if (e.response!.statusCode != null && e.response!.statusCode! >= 500) {
      return "Ошибка сервера. Попробуйте позже";
    }
  } else {
    if (e is DioException && e.type == DioExceptionType.connectionTimeout) {
      return "Ошибка соединения. Время запроса превышено";
    } else {
      return "Ошибка: $e";
    }
  }
  return e.toString();
}
