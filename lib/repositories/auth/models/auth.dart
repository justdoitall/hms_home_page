import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

class RegistrationData {
  RegistrationData(
      {required this.login,
      required this.password,
      required this.referealCode});
  String login;
  String password;
  String referealCode;
}

class PersonalData {
  String name;
  String lastName;
  String? nickName;
  String weight;
  String height;

  PersonalData(
      {required this.name,
      required this.lastName,
      this.nickName,
      required this.height,
      required this.weight});
}

@JsonSerializable()
class Token {
  final String access;
  final String refresh;
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  Token({required this.access, required this.refresh});
}

@JsonSerializable()
class AuthResponse {
  final Token token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  AuthResponse({required this.token});
}

// @JsonSerializable()
// class Auth {
//   @JsonKey(name: 'token')
//   final String authToken;

//   @JsonKey(name: 'token_expires_at')
//   final String authTokenExpires;

//   final CurrentUser user;

//   factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

//   Map<String, dynamic> toJson() => _$AuthToJson(this);

//   Auth(
//       {required this.authToken,
//       required this.authTokenExpires,
//       required this.user});
// }

// @JsonSerializable()
// class CurrentUser {
//   @JsonKey(name: 'last_name')
//   final String? lastName;

//   @JsonKey(name: 'first_name')
//   final String? firstName;

//   final String login;

//   final bool active;

//   @JsonKey(name: 'is_doctor')
//   final bool isDoctor;

//   @JsonKey(name: 'verification_confirmed')
//   final bool verificationConfirmed;

//   @JsonKey(name: 'first_entry')
//   final bool firstEntry;

//   @JsonKey(name: 'subscription_status')
//   final bool subscribitionStatus;

//   @JsonKey(name: 'subscription_days')
//   final int? subscriptionDays;

//   final int id;

//   factory CurrentUser.fromJson(Map<String, dynamic> json) =>
//       _$CurrentUserFromJson(json);

//   Map<String, dynamic> toJson() => _$CurrentUserToJson(this);

//   CurrentUser(
//       {required this.id,
//       required this.lastName,
//       required this.firstName,
//       required this.login,
//       required this.active,
//       required this.isDoctor,
//       required this.verificationConfirmed,
//       required this.firstEntry,
//       required this.subscribitionStatus,
//       required this.subscriptionDays});
// }
