
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hms_app/repositories/users/users.dart';

part 'users_cubit.freezed.dart';
part 'users_cubit_state.dart';


class UsersCubit extends Cubit<UsersCubitState> {
  final InterFaceUsersRepository usersRepository;


  UsersCubit(this.usersRepository): super(const UsersCubitState.initial());

  getUsersList() async  {
    try {
      emit(const UsersCubitState.loading());

      final List<User> usersList = await usersRepository.getUsersList();

        emit(UsersCubitState.success(usersList: usersList));
       
    } catch (e) {
      emit(
        UsersCubitState.error("Error loading users: ${e.toString()}"),
      );
    }
  }
}