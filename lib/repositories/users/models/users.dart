
import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User({
    required this.id,
    required this.name,
    required this.email
  });
  final int id;
  final String name;
  final String email;
  
  @override
  // TODO: implement props
  List<Object> get props => [name, email];
}