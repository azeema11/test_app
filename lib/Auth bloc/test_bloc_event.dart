part of 'test_bloc_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickEvent extends LoginEvent{
  final String email;
  final String password;

  LoginButtonClickEvent(this.email,this.password);
}

class RegisterButtonClickEvent extends LoginEvent{
  final String email;
  final String password;
  final String name;

  RegisterButtonClickEvent(this.email,this.password,this.name);
}

class GoogleLoginClickEvent extends LoginEvent{}

class LogoutButtonClickEvent extends LoginEvent{}