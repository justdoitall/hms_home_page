part of 'user_cubit.dart';

@freezed
class UserCubitState with _$UserCubitState {
  const factory UserCubitState.initial() = _Initial;
  const factory UserCubitState.loading() = _Loading;

   factory UserCubitState.success({
    required User user,}) = _Success;

  const factory UserCubitState.error(String error) = _Error;
}