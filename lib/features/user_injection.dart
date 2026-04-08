import 'package:flower/features/user/data/datasources/user_remote_datasource.dart';
import 'package:flower/features/user/data/repositories/user_repository_impl.dart';
import 'package:flower/features/user/domain/repositories/user_repository.dart';
import 'package:flower/features/user/domain/usecases/get_user.dart';
import 'package:flower/features/user/domain/usecases/update_user.dart';
import 'package:flower/features/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initUser() async {
  // Bloc
  sl.registerFactory(() => UserBloc(sl(), sl()));

  // Usecases
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  // Datasource
  sl.registerLazySingleton(
    () => UserRemoteDataSource(Supabase.instance.client),
  );
}
