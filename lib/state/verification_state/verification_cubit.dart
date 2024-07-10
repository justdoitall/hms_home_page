import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "verification_state.dart";
part "verification_cubit.freezed.dart";

class VerificationCubit extends Cubit<VerificationState> {
  final InterfaceAuthRepository authRepository;

  VerificationCubit(this.authRepository) : super(const VerificationState.initial());

  getVerification(String code) async {
    try {
      emit(const VerificationState.loading());

      final AuthResponse response = await authRepository.getVerification(code);


      emit(VerificationState.success(response: response));
    } catch (e) {
      emit(
        VerificationState.error(errorHandler(e)),
      );
    }
  }

  getPassVerification(String code) async {
    try {
      emit(const VerificationState.loading());

      final AuthResponse response = await authRepository.getPassVerification(code);


      emit(VerificationState.success(response: response));
    } catch (e) {
      emit(
        VerificationState.error(errorHandler(e)),
      );
    }
  }

  repeadCodeSend() async {
    try {
      await authRepository.repeatCodeSend();
    } catch (e) {
        emit(
        VerificationState.error(errorHandler(e)),
      );
    }
  }
}
