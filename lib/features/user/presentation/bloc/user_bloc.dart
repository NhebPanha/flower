import 'package:bloc/bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/update_user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  final UpdateUser updateUser;

  UserBloc(this.getUser, this.updateUser) : super(UserInitial()) {
    // ✅ LOAD USER
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await getUser();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // ✅ UPDATE USER (SMART WAY)
    on<UpdateUserEvent>((event, emit) async {
      try {
        // Keep current state (no flicker UI)
        if (state is UserLoaded) {
          final currentUser = (state as UserLoaded).user;

          // Merge new data with old data
          final updatedUser = currentUser.copyWith(
            name: event.name ?? currentUser.name,
            phone: event.phone ?? currentUser.phone,
            address: event.address ?? currentUser.address,
            image: event.image ?? currentUser.image,
          );

          // Optimistic update (UI update immediately)
          emit(UserLoaded(updatedUser));

          // Save to backend
          await updateUser(updatedUser);

          // Reload from server (optional but safe)
          final freshUser = await getUser();
          emit(UserLoaded(freshUser));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
