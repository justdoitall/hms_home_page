part of "email_reset_cubit.dart";

@freezed
class EmailResetState with _$EmailResetState {
  const factory EmailResetState.initial() = _Initial;
  const factory EmailResetState.loading() = _Loading;

   factory EmailResetState.success({
    required Token response,}) = _Success;

  const factory EmailResetState.error(String error) = _Error;
}