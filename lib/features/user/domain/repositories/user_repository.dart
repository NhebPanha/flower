import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
  Future<void> updateUser(User user);
}
