part of 'test_bloc_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickEvent extends LoginEvent{
  final String email;
  final String password;

  LoginButtonClickEvent(this.email,this.password);
}

class GoogleLoginClickEvent extends LoginEvent{}

class LogoutButtonClickEvent extends LoginEvent{}