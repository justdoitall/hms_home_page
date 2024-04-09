import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/app.dart';
import 'package:hms_app/repositories/users/users.dart';

void main() {
  GetIt.I.registerSingleton<InterFaceUsersRepository>(UsersRepository(dio: Dio()));
  runApp(const HmsApp());
}
