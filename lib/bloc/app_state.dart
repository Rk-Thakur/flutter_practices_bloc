import 'package:downloader_flutter/models/data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserState extends Equatable {
  //equatable is a package that helps to compare two objects
  const UserState();
}

// user data loading state
class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

// user data loaded state
class UserLoadedState extends UserState {
  const UserLoadedState(this.users);
  final List<UserModel> users;
  @override
  List<Object> get props => [users];
}

//user data error loading state
class UserErrorState extends UserState {
  const UserErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
