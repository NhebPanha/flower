import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final SupabaseClient client;

  UserRemoteDataSource(this.client);

  Future<UserModel> getUser() async {
    final response =
    await client.from('users').select().single();

    return UserModel.fromJson(response);
  }

  Future<void> updateUser(UserModel user) async {
    await client
        .from('users')
        .update(user.toJson())
        .eq('id', user.id);
  }
}