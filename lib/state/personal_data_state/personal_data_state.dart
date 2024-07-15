part of "personal_data_cubit.dart";

sealed class PersonalDataState {}

final class InitialState implements PersonalDataState {
  bool isPolicyAgreed;
  num bodyMassIndex;
  num weight;
  num height;
  InitialState(
    this.weight,
    this.height,
    this.bodyMassIndex,
    this.isPolicyAgreed,
  );
}

final class LoadingState implements PersonalDataState {}

final class SuccessState implements PersonalDataState {}

final class ErrorState implements PersonalDataState {
  final String error;
  ErrorState(this.error);
}



// @freezed
// class PersonalDataState with _$PersonalDataState {
//   const factory PersonalDataState.initial({PerosnalDataMultipileState? state}) = _Initial;
//   const factory PersonalDataState.loading({PerosnalDataMultipileState state}) = _Loading;

//   factory PersonalDataState.success({
//     PerosnalDataMultipileState state,
//   }) = _Success;

//   const factory PersonalDataState.error(String error) = _Error;
// }
