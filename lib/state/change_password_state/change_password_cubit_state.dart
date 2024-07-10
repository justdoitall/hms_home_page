part of "change_password_cubit.dart";

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;
  const factory ChangePasswordState.loading() = _Loading;

   factory ChangePasswordState.success({
    required AuthResponse response,}) = _Success;

  const factory ChangePasswordState.error(String error) = _Error;
}