import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "email_reset_cubit_state.dart";
part 'email_reset_cubit.freezed.dart';

class EmailResetCubit extends Cubit<EmailResetState> {
  final InterfaceAuthRepository authRepository;

  EmailResetCubit(this.authRepository) : super(const EmailResetState.initial());

  resetPassword(String email) async {
    try {
      emit(const EmailResetState.loading());

      final Token response = await authRepository.resetPassword(email);

      emit(EmailResetState.success(response: response));
    } catch (e) {
      emit(
        EmailResetState.error(errorHandler(e)),
      );
    }
  }
}
