import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "auth_cubit_state.dart";
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final InterfaceAuthRepository usersRepository;

  AuthCubit(this.usersRepository) : super(const AuthCubitState.initial());

  getAuth(String login, String password) async {
    try {
      emit(const AuthCubitState.loading());

      final token = await usersRepository.getAuth(login, password);

      emit(AuthCubitState.success(token: token!));
    } catch (e) {
      emit(AuthCubitState.error(errorHandler(e)));
    }
  }
}
