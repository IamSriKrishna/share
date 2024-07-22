import 'package:crud/bloc/user/user_event.dart';
import 'package:crud/bloc/user/user_state.dart';
import 'package:crud/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository) : super(UserInitialState()) {
    on<ReadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final userModel = await _repository.readUserData();
        emit(ReadUserState(userModel: userModel));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });

    on<CreateUserEvent>((event, emit) async {
      emit(CreateUserState(isLoading: true));
      try {
        await _repository.createUserData(event.name);
        emit(CreateUserState(isLoading: false));
        add(ReadUserEvent());
      } catch (error) {
        emit(CreateUserState(isLoading: false));
        emit(UserErrorState(error: error.toString()));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(DeleteUserState(isLoading: true));
      try {
        bool success = await _repository.deleteUserByName(event.name);
        if (success) {
          emit(DeleteUserState(isLoading: false));
          add(ReadUserEvent());
        } else {
          emit(DeleteUserState(isLoading: false));
          emit(UserErrorState(error: 'Failed to delete user.'));
        }
      } catch (e) {
        emit(DeleteUserState(isLoading: false));
        emit(UserErrorState(error: e.toString()));
      }
    });
  }
}
