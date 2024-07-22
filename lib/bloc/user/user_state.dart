import 'package:crud/model/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({required this.error});
}

class ReadUserState extends UserState {
  final UserModel userModel;
  ReadUserState({required this.userModel});
}

class CreateUserState extends UserState {
  bool isLoading;
  CreateUserState({required this.isLoading});
}

class DeleteUserState extends UserState {
  bool isLoading;
  DeleteUserState({required this.isLoading});
}
