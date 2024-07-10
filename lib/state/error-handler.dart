import 'package:dio/dio.dart';


String errorHandler(Object e) {
  if (e is DioException && e.response != null) {
    try {
      if (e.response!.statusCode! >= 500) {
        return "Ошибка сервера. Попробуйте позже";
      }
      return e.response!.data["error_text"] ?? e.response!.data["error"]["text"];
    } catch (e) {
      return e.toString();
    }
  } else {
    if (e is DioException && e.type == DioExceptionType.connectionTimeout) {
      return "Ошибка соединения. Время запроса превышено";
    } else {
      return "Ошибка: $e";
    }
  }
}
