import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hms_app/repositories/users/users.dart';

part 'users_events.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this.usersRepository) : super(UsersInitial()) {
    on<GetUsersList>((event, emit) async{
      try {
        if(state is! UsersLoaded) {
          emit(UsersLoading());
        }
        final usersList = await usersRepository.getUsersList();
        emit(UsersLoaded(usersList: usersList));
      } catch (e) {
        emit(UsersLoadingFailure(exeption: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final InterFaceUsersRepository usersRepository;
}