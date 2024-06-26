part of "personal_data_cubit.dart";

@freezed
class PersonalDataState with _$PersonalDataState {
  const factory PersonalDataState.initial() = _Initial;
  const factory PersonalDataState.loading() = _Loading;

  factory PersonalDataState.success({
    required AuthResponse response,
  }) = _Success;

  const factory PersonalDataState.error(String error) = _Error;
}
