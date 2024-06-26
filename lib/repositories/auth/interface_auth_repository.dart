import 'package:hms_app/repositories/auth/auth.dart';

abstract class InterfaceAuthRepository {
  Future<Token?> getAuth(String login, String password);
  Future<AuthResponse> getRegistration(RegistrationData data);
  Future<AuthResponse> getVerification(String code);
  Future<AuthResponse> setPersonalData(PersonalData data);
  Future<void> repeatCodeSend();
}
