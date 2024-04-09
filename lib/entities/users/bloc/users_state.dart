part of 'users_bloc.dart';


abstract class UsersState extends Equatable{}

class UsersInitial extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState{
  @override
  List<Object?> get props =>[];
}

class UsersLoaded extends UsersState {
  UsersLoaded({required this.usersList});
  final List<User> usersList;
 
  @override
  List<Object?> get props => [usersList];
}

class UsersLoadingFailure extends UsersState {
  UsersLoadingFailure({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}