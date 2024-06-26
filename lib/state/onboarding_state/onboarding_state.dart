part of "onboarding_cubit.dart";

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _Initial;
  const factory OnboardingState.loading() = _Loading;

  factory OnboardingState.success({
    required AuthResponse response,
  }) = _Success;

  const factory OnboardingState.error(String error) = _Error;
}
