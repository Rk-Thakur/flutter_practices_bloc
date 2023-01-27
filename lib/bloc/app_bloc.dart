import 'package:downloader_flutter/bloc/app_event.dart';
import 'package:downloader_flutter/bloc/app_state.dart';
import 'package:downloader_flutter/services/data_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDataSource _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadingUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        final users = await _userRepository.getUser();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
