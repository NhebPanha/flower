import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/update_user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  final UpdateUser updateUser;

  UserBloc(this.getUser, this.updateUser) : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await getUser();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      try {
        await updateUser(event.user);
        add(LoadUserEvent());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
