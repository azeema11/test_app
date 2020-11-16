part of 'data_bloc_bloc.dart';

@immutable
abstract class DataBlocState {}

class DataBlocInitial extends DataBlocState {}

class DataLoadState extends DataBlocState{}

class DataReceivedState extends DataBlocState{
  final String name;
  final String email;
  DataReceivedState({this.name, this.email});
}

class DataFailedState extends DataBlocState{
  final String error;
  DataFailedState(this.error);
}
