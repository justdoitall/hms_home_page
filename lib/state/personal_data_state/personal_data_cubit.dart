import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/error-handler.dart';

part "personal_data_state.dart";

class PersonalDataCubit extends Cubit<PersonalDataState> {
  final InterfaceAuthRepository authRepository;

  PersonalDataCubit(this.authRepository) : super(InitialState(0, 0, 0, false));

  setWeight(value) {
    final tempVal = value == null || value == "" ? 0 : num.parse(value);
    emit(InitialState(
      tempVal,
      (state as InitialState).height,
      (state as InitialState).bodyMassIndex,
      (state as InitialState).isPolicyAgreed,
    ));
  }

  setHeight(value) {
    final tempVal = value == null || value == "" ? 0 : num.parse(value);

    emit(InitialState(
      (state as InitialState).weight,
      tempVal,
      (state as InitialState).bodyMassIndex,
      (state as InitialState).isPolicyAgreed,
    ));
  }

  getBodyMassIndex() {
    final num heightToMeter = (state as InitialState).height / 100;
    final num bodyMassIndex =
        ((state as InitialState).weight / ((heightToMeter * heightToMeter)));

    emit(InitialState(
      (state as InitialState).weight,
      (state as InitialState).height,
      bodyMassIndex,
      (state as InitialState).isPolicyAgreed,
    ));
  }

  setPolicyAgreement() {
    emit(InitialState(
      (state as InitialState).weight,
      (state as InitialState).height,
      (state as InitialState).bodyMassIndex,
            (state as InitialState).isPolicyAgreed = !(state as InitialState).isPolicyAgreed  ,

    ));
  }

  setPersonalData(PersonalData data) async {
    try {
      emit(LoadingState());

      await authRepository.setPersonalData(data);

      emit(SuccessState());
    } catch (e) {
      emit(
        ErrorState(errorHandler(e)),
      );
      emit(InitialState(0, 0, 0, false));
    }
  }
}
