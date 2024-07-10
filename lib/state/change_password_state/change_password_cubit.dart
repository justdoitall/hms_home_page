import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "change_password_cubit_state.dart";
part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final InterfaceAuthRepository authRepository;

  ChangePasswordCubit(this.authRepository) : super(const ChangePasswordState.initial());

  changePassword(String password) async {
    try {
      emit(const ChangePasswordState.loading());

      final AuthResponse response = await authRepository.changePassword(password);

      emit(ChangePasswordState.success(response: response));
    } catch (e) {
      emit(
        ChangePasswordState.error(errorHandler(e)),
      );
    }
  }
}
