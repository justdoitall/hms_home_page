
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class User extends Equatable{
  const User({
    required this.id,
    required this.name,
    required this.email
  });
  final String id;
  final String name;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
  
  @override
  List<Object> get props => [name, email, id];
}