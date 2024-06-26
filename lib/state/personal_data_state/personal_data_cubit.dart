import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "personal_data_state.dart";
part "personal_data_cubit.freezed.dart";

class PersonalDataCubit extends Cubit<PersonalDataState> {
  final InterfaceAuthRepository authRepository;

  PersonalDataCubit(this.authRepository) : super(const PersonalDataState.initial());

  setPersonalData(PersonalData data) async {
    try {
      emit(const PersonalDataState.loading());

      final AuthResponse response = await authRepository.setPersonalData(data);


      emit(PersonalDataState.success(response: response));
    } catch (e) {
      emit(
        PersonalDataState.error(errorHandler(e)),
      );
    }
  }
}
