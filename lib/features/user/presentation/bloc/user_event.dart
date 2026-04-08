abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final dynamic user;
  UpdateUserEvent(this.user);
}