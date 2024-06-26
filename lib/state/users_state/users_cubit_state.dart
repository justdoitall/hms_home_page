part of 'users_cubit.dart';

@freezed
class UsersCubitState with _$UsersCubitState {
  const factory UsersCubitState.initial() = _Initial;
  const factory UsersCubitState.loading() = _Loading;

   factory UsersCubitState.success({
    required List<User> usersList,}) = _Success;

  const factory UsersCubitState.error(String error) = _Error;
}
