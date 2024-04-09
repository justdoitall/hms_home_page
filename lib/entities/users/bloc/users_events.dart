part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable{}



class GetUsersList extends UsersEvent {
 GetUsersList({
    this.completer
  });

  
  final Completer? completer;
  
  @override
  // TODO: implement props
  List<Object?> get props => [completer];

 
}
