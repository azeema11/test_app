import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository/auth.dart';

part 'data_bloc_event.dart';
part 'data_bloc_state.dart';

class DataBlocBloc extends Bloc<DataBlocEvent, DataBlocState> {
  final Auth _auth;

  DataBlocBloc({@required Auth auth})
      : assert(auth != null),
        _auth = auth, super(DataBlocInitial());

  @override
  Stream<DataBlocState> mapEventToState(
    DataBlocEvent event,
  ) async* {
    if(event is DataCallEvent){
      try{
        yield DataLoadState();
        await _auth.getUser(event.uid);
        if(_auth.doc != null){
          yield DataReceivedState(name: _auth.user.name, email: _auth.user.email);
        }
        else{
          yield DataFailedState("Data Unavailable");
        }
      }catch(e){
        yield DataFailedState(e);
      }
    }
    if(event is DataClearEvent){
      try{
        yield DataBlocInitial();
      }catch(e){
        yield DataFailedState(e);
      }
    }
  }
}
