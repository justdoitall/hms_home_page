part of 'user_bloc.dart';

abstract class UserState extends Equatable{}


class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState{
  @override
  List<Object?> get props =>[];
}

class UserLoaded extends UserState {
  UserLoaded({required this.user});
  final User user;
 
  @override
  List<Object?> get props => [user];
}

class UserLoadingFailure extends UserState {
  UserLoadingFailure({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}