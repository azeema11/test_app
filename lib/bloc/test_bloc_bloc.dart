import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:test_app/Repository/auth.dart';

part 'test_bloc_event.dart';
part 'test_bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginBlocInitial());
  Auth a;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonClickEvent){
      try{
        yield LoginLoadState();
        a.login(email, password);
        if(a.usr.uid != null)
          yield LoginSuccessState(a.usr);
        else{
          yield LoginFailedState("Enter valid username or password");
        }
      } catch(e){
        yield LoginFailedState(e.toString());
      }
    }
  }
}
