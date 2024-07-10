// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonError _$CommonErrorFromJson(Map<String, dynamic> json) => CommonError(
      json['text'] as String,
    );

Map<String, dynamic> _$CommonErrorToJson(CommonError instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
