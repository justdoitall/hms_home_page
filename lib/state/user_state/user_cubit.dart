
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/users/users.dart';

part 'user_cubit.freezed.dart';

part 'user_cubit_state.dart';


class UserCubit extends Cubit<UserCubitState> {
  final InterFaceUsersRepository usersRepository;


  UserCubit(this.usersRepository): super(const UserCubitState.initial());

  getUserById(String id) async {
    try {
      emit(const UserCubitState.loading());

      final User user = await usersRepository.getUserById(id);

        emit(UserCubitState.success(user: user));
       
    } catch (e) {
      emit(
        UserCubitState.error("Error loading users: ${e.toString()}"),
      );
    }
  }
}

