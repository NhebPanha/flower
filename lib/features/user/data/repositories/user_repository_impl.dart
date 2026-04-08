import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<User> getUser() async {
    return await remote.getUser();
  }

  @override
  Future<void> updateUser(User user) async {
    final model = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      address: user.address,
      image: user.image,
    );

    await remote.updateUser(model);
  }
}