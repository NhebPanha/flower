abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String? name;
  final String? phone;
  final String? address;
  final String? image;

  UpdateUserEvent({
    this.name,
    this.phone,
    this.address,
    this.image,
  });
}