import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hms_app/repositories/users/users.dart';

part 'user_events.dart';
part 'user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.usersRepository) : super(UserInitial()) {
    on<GetUser>((event, emit) async{
      try {
        if(state is! UserLoaded) {
          emit(UserLoading());
        }
        final user = await usersRepository.getUserById(event.id);
        emit(UserLoaded(user: user));
      } catch (e) {
        emit(UserLoadingFailure(exeption: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final InterFaceUsersRepository usersRepository;
}
