import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadingUserEvent extends UserEvent {
  const LoadingUserEvent({id = 0});
  @override
  List<Object> get props => [];
  int get id => int.parse(id.toString());
}

class DeletUserEvent extends UserEvent {
  const DeletUserEvent({id = 0});
  @override
  List<Object> get props => [];

  int get id => int.parse(id.toString());
}
