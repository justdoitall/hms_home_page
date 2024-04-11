part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{}

class GetUser extends UserEvent {
 GetUser({
    this.completer,
    required this.id
  });

  
  final Completer? completer;
  final int id;
  
  @override
  // TODO: implement props
  List<Object?> get props => [completer];

 
}

