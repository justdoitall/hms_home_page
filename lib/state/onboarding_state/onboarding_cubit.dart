import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "onboarding_state.dart";
part "onboarding_cubit.freezed.dart";

class OnboardingCubit extends Cubit<OnboardingState> {
  final InterfaceAuthRepository authRepository;

  OnboardingCubit(this.authRepository) : super(const OnboardingState.initial());

  getRegistration(RegistrationData data) async {
    try {
      emit(const OnboardingState.loading());

      final AuthResponse response = await authRepository.getRegistration(data);

      emit(OnboardingState.success(response: response));
    } catch (e) {
      emit(
        OnboardingState.error(errorHandler(e)),
      );
    }
  }
}
