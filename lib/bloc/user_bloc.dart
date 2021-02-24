import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      var user = await UserService.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateUserData) {
      var updatedUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profileImage: event.profileImage);
      await UserService.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          var updateUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);
          await UserService.updateUser(updateUser);

          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          var updateUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);
          await UserService.updateUser(updateUser);

          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  UserState get initialState => UserInitial();
}
