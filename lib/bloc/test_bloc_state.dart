part of 'test_bloc_bloc.dart';

@immutable
abstract class LoginState {}

class LoginBlocInitial extends LoginState {}

class LoginLoadState extends LoginState{}

class LoginSuccessState extends LoginState{
  final String user;
  LoginSuccessState(this.user);
}

class LoginFailedState extends LoginState{
  final String error;
  LoginFailedState(this.error);
}