import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/Repository/auth.dart';

part 'test_bloc_event.dart';
part 'test_bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Auth _auth;

  LoginBloc({@required Auth auth})
      : assert(auth != null),
        _auth = auth, super(LoginBlocInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonClickEvent){
      try{
        yield LoginLoadState();
        await _auth.login(event.email, event.password);
        if(_auth.usr.uid != null){
          yield LoginSuccessState(_auth.usr.uid);
        }
        else{
          yield LoginFailedState("Enter valid username or password");
        }
      } catch(e){
        yield LoginFailedState(e.toString());
      }
    }
    else if(event is GoogleLoginClickEvent){
      try{
        yield LoginLoadState();
        await _auth.googleLogin();
        if(_auth.usr.uid != null)
          yield LoginSuccessState(_auth.usr.uid);
        else{
          yield LoginFailedState("Enter valid gmail account");
        }
      } catch(e){
        yield LoginFailedState(e.toString());
      }
    }
    else if(event is RegisterButtonClickEvent){
      try{
        yield LoginLoadState();
        await _auth.register(event.email, event.password, event.name);
        if(_auth.usr.uid != null)
          yield LoginSuccessState(_auth.usr.uid);
        else{
          yield LoginFailedState("Enter valid email address");
        }
      } catch(e){
        yield LoginFailedState(e.toString());
      }
    }
    else if(event is LogoutButtonClickEvent){
      await _auth.signOut();
      yield LoginBlocInitial();
    }
  }
}
