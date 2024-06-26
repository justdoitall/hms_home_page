part of 'auth_cubit.dart';

@freezed
class AuthCubitState with _$AuthCubitState {
  const factory AuthCubitState.initial() = _Initial;
  const factory AuthCubitState.loading() = _Loading;

   factory AuthCubitState.success({
    required Token token,}) = _Success;

  const factory AuthCubitState.error(String error) = _Error;
}
