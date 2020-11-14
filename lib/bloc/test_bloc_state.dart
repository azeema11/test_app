part of 'test_bloc_bloc.dart';

@immutable
abstract class LoginState {}

class LoginBlocInitial extends LoginState {}

class LoginLoadState extends LoginState{}

class LoginSuccessState extends LoginState{
  User user;
  LoginSuccessState(this.user);
}

class LoginFailedState extends LoginState{
  String error;
  LoginFailedState(this.error);
}