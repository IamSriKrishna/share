abstract class UserEvent {}

class ReadUserEvent extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final String name;
  CreateUserEvent({required this.name});
}

class DeleteUserEvent extends UserEvent {
  final String name;
  DeleteUserEvent({required this.name});
}
