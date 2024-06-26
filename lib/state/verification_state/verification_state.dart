part of "verification_cubit.dart";

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState.initial() = _Initial;
  const factory VerificationState.loading() = _Loading;

  factory VerificationState.success({
    required AuthResponse response,
  }) = _Success;

  const factory VerificationState.error(String error) = _Error;
}
